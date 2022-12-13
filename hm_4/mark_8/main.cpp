#include <iostream>
#include <vector>
#include <queue>
#include <string>
#include <fstream>
#include <pthread.h>
#include <unistd.h>
#include <ctime>
#include <semaphore.h>

using namespace std;

struct ProgrammerInfo {  // структура с информцией о программисте, которую мы будем пеердавать в параметры потока
    string name;
    int num;
};

ofstream fout;    // файл для вывода
ifstream fin;     // файл для ввода
int type = 0;     // переменная флаг (равна 0, если не файловый ввод, иначе 1)

vector<string> possibleNames = {"Bob", "Sam", "Steve", "Alex", "Frank", "Tom", "Andrew", "Max", "Jerry", "Antony", "Ilya"};   // массив возможных имен (используется при генерации рандомного ввода)

void myPrint(string s) {   // фукцния вывода, принимает строку, выводит ее в консоль, и в файл, если выбран файловый ввод/вывод
    cout << s;
    if (type) {
         fout << s;
    }
}

int getZeroes(string& s) {       // функция принимает строку и возвращает количество нулей в ней
    int cnt0 = 0;
    for (const auto& ch : s) {
        if (ch == '0') {
            ++cnt0;
        }
    }
    return cnt0;
}

int getOnes(string& s) {        // функция принимает строку и возвращает количество единиц в ней
    int cnt1 = 0;
    for (const auto& ch : s) {
        if (ch == '1') {
            ++cnt1;
        }
    }
    return cnt1;
}

bool checkCode(string& s) {      // функция принимает строку - код и проверяет его на корректность (он корректен, если состоит из 0 и 1 и количетсво 1 не меньше количества 0)
    int cnt0 = getZeroes(s);
    int cnt1 = getOnes(s);
    return cnt0 <= cnt1 && cnt0 + cnt1 == s.size();
}

void changeCode(string& s) {    // функция принимает строку - код, и делает его корректным
    int cnt0 = getZeroes(s);
    int cnt1 = getOnes(s);
    for (auto& ch : s) {
        if (ch != '0' && ch != '1') {
            ch = '1';           // все элементы, которые не равны 0 и 1, меняем на 1
        }
    }
    cnt1 = s.size() - cnt0;
    for (int i = 0; cnt0 > cnt1; i++) {   // полка количество единиц меньше количества нулей, меняем нули на единицы
        if (s[i] == '0') {
            s[i] = '1';            
            --cnt0;                  
            ++cnt1;
        }
    }
}

void generateCode(string& s) {      // функция принимает строку по ссылке и генерирует в нее код случайным образом
    int len = rand() % 100 + 20;    // генерируем длину кода
    for (int i = 0; i < len; ++i) {
    	s += (char)(rand() % 2 + '0');   // записываем очередным элементом 0 или 1
    }
}

int cntRetiredProgs = 0;       // переменная, хранящая количество программистов, которые корректно написали необходимое количество програамм
int numberOfProgramms;         // количество программ, которые должен написать каждый прграммист

queue<pair<string, int>> codeForReview[3];  // 3 очереди, в которые для каждого программиста мы записываем код, который он должен проверить (первый элемент пары - сам код, второй - номер программиста, который написал этот код)
queue<bool> accept[3];   // 3 очереди, в которые для каждого программиста мы записываем результат проверки его кода (true, если код прошел проверку, false - иначе)
vector<string> names(3); // массив, в котором мы храним имена программистов

pthread_mutex_t reviewMutex[3];  // 3 мьютекса, с помощью i-того мьютекса ограничиваем доступ к очереди codeForReview[i]
pthread_mutex_t acceptMutex[3];  // 3 мьюетка, с помощью i-того мьютекса ограничиваем доступ к очереди accept[i]

sem_t outSem;  // семафор для ограничивания досутпа к вводу
sem_t cntSem;  // семафор для ограничивания доступа к переменной cntRetiredProgs

void makeCodeReview(int num, string name) {                       // данная функция делает код ревью
    if (!codeForReview[num].empty()) {                            // проверяем, есть ли в нашей очереди программисты, ожидающий код ревью
    	pthread_mutex_lock(&reviewMutex[num]);                    // блокируем мьютекс для очереди с кодом на проверку для текущего программиста
    	string codeReview = codeForReview[num].front().first;     // достаем код из очереди, который нужно обозреть
    	int reviewNum = codeForReview[num].front().second;        // достаем номер программиста, код которого необходимо обозреть
    	codeForReview[num].pop();
    	pthread_mutex_unlock(&reviewMutex[num]);                  // разблокируем мьюеткс для очереди с кодом на проверку для текущего программиста
    	        
    	bool res;
    	res = checkCode(codeReview);                              // получаем результат для данного кода
    	
    	usleep(3000000);                                          // засыпаем на 3 секунды
    	sem_wait(&outSem);                                        // блокируем семафор вывода
    	myPrint("Programmer " + name + " made code review for " + names[reviewNum] + " with result: " + (res ? "Accept\n" : "Reject\n")); // выводим данные текущего ревью
        sem_post(&outSem);                                        // разблокируем семафор вывода
    	
    	pthread_mutex_lock(&acceptMutex[reviewNum]);              // блокируем мьютекс для очереди с результатами для программиста, которого мы проверили
    	accept[reviewNum].push(res);                              // добавляем результат в очередь
    	pthread_mutex_unlock(&acceptMutex[reviewNum]);            // разблокируем мьютекс для очереди с результатами для программиста, которого мы проверили
    }
}


void* writeCode(void* args) {    // функция, которую мы вызываем в отдельных потоках - имитация работы программистов 
    string name = ((struct ProgrammerInfo*)args)->name;
    int num = ((struct ProgrammerInfo*)args)->num;
    for (int i = 0; i < numberOfProgramms; ++i) {            // перебираем номер очередной программы, которую пишет программист
    	string code = "";
    	generateCode(code);                                  // генерируем код
    	usleep(8000000);
    	
    	sem_wait(&outSem);                                   // блокируем семафор для вывода
    	myPrint("Programmer " + name + " wrote " + to_string(i + 1) + " code\n");  // выводим данныео написанном коде
    	sem_post(&outSem);                                   // разблокируем семафор для вывода
    	
    	int reviewer = num;
    	while (reviewer == num) {
    	    reviewer = rand() % 3;                           // генерируем номер программиста, который будет делать код ревью
    	}

    	pthread_mutex_lock(&reviewMutex[reviewer]);          // блокируем мьюеткс для очереди с кодом на проверку для ревьюера данной программы
    	codeForReview[reviewer].push({code, num});           // кладем наш написанный код в очередь к ревьюеру
    	pthread_mutex_unlock(&reviewMutex[reviewer]);        // разблокируем мьюеткс для очереди с кодом на проверку для ревьюера данной программы
    	
    	while (true) {                                       // запускаем цикл, который будет в очереднйо момент времени либо исправлять код (если возможно), либо делать код ревью (если возможно)
    	    if (!accept[num].empty()) {                      // если нам проверили наш код, зайдем в данный if
    	        pthread_mutex_lock(&acceptMutex[num]);       // блокируем мьютекс для очереди с нашими результатами
    	        bool res = accept[num].front();              // достаем результат из очереди
    	        accept[num].pop();
    	        pthread_mutex_unlock(&acceptMutex[num]);     // разблокируем мьютекс для очереди с нашими результатами
    	        if (res) {                                   // если код написан успешно
    	            if (i + 1 == numberOfProgramms) {        // если данная программа - последняя для текущего програаммиста
    	               sem_wait(&cntSem);                    // блокируем семафор для переменной cntRetiredProgs
    	               cntRetiredProgs++;                    // увеличими количество программистов, завершим написание всех программ
    	               sem_post(&cntSem);                    // разблокируем семафор для переменной cntRetiredProgs
    	               while (cntRetiredProgs != 3) {        // пока все программисты не закончат написание всех программ
    	                   makeCodeReview(num, name);        // вызовем функцию для код ревью
    	               }
    	            }
    	            break;                                   // выйдем из цикла
    	        }
    	        changeCode(code);                            // откорректируем наш код
    	        
    	        usleep(5000000);
    	        sem_wait(&outSem);                           // блокируем семафор для вывода
    	        myPrint("Programmer " + name + " corrected his code\n"); // выводим данный об откорректированном коде
    	        sem_post(&outSem);                           // разблокируем семафор для вывода
    	        
    	        pthread_mutex_lock(&reviewMutex[reviewer]);  // блокируем мьюеткс для очереди с кодом на проверку для ревьюера данной программы
    	        codeForReview[reviewer].push({code, num});   // кладем наш написанный код в очередь к ревьюеру
    	        pthread_mutex_unlock(&reviewMutex[reviewer]); // разблокируем мьюеткс для очереди с кодом на проверку для ревьюера данной программы
    	        
    	        continue;
    	    }
    	    makeCodeReview(num, name);   // вызовем функцию для код ревью
    	}
    }
}


int main(int argc, char* argv[]) {
    int numberOfProgrammers = 3;  // переменная хранящая количество программистов
    
    if (argc == 1) {              // генерация случайных входных данных
        numberOfProgramms = (rand() + clock()) % 10 + 1;
        cout << "Number of programms - " << numberOfProgramms << "\n";
        for (int i = 0; i < numberOfProgrammers; ++i) {
            names[i] = possibleNames[(rand() + clock()) % possibleNames.size()];
            cout << "First programmer - " << names[i] << "\n";
        }
        cout << "\n";
    } else if (argc == 2) {      // ввод из консоли
        cin >> numberOfProgramms;
        for (int i = 0; i < numberOfProgrammers; i++) {
            cin >> names[i];
        }
    } else if (argc == 3) {     // ввод из файла
    	fin.open(argv[1]);
    	fout.open(argv[2]);
        fin >> numberOfProgramms;
        for (int i = 0; i < numberOfProgrammers; i++) {
            fin >> names[i];
        }
        type = 1;
    } else if (argc == 5) {     // ввод из командной строки
        numberOfProgramms = atoi(argv[1]);
        for (int i = 0; i < numberOfProgrammers; ++i) {
            names[i] = argv[i + 2];
        }
    } else {
        cout << "Incorrect input\n";
        return 0;
    }
    if (numberOfProgramms <= 0 || numberOfProgramms > 100) {
         cout << "Incorrect number of programms\n";
         return 0;
    }

    pthread_t programmers[numberOfProgrammers];          // массив потоков
    struct ProgrammerInfo* args[numberOfProgrammers];    // массив с аргументами функции потока
    for (int i = 0; i < numberOfProgrammers; ++i) {      // инициализируем мьютексы
        pthread_mutex_init(&reviewMutex[i], NULL);     
        pthread_mutex_init(&acceptMutex[i], NULL);
    }
     
    for (int i = 0; i < numberOfProgrammers; ++i) {      // для каждого потока создадим структуру с именем программиста и его номером, которую мы передадим в аргумент функции
    	args[i] = (struct ProgrammerInfo*)malloc(sizeof(struct ProgrammerInfo));
    	args[i]->name = names[i];
    	args[i]->num = i;
    }
    sem_init(&outSem, 0, 1);       // инициализируем семафор вывода
    sem_init(&cntSem, 0, 1);       // инициализиурем семафор переменной cntRetireProgs
    
    for (int i = 0; i < numberOfProgrammers; ++i) {  // создаем поток для каждого программиста
        pthread_create(&programmers[i], NULL, writeCode, (void*)args[i]);  
    }
    
    for (int i = 0; i < numberOfProgrammers; ++i) {   // дожидаемся завершения работы каждого потока
        pthread_join(programmers[i], NULL);   
    }
    
    sem_destroy(&outSem);         // уничтожаем семафор вывода
    sem_destroy(&cntSem);         // уничтожаем семафор переменной cntRetiredProgs
    
    for (int i = 0; i < numberOfProgrammers; ++i) {
        free(args[i]);            // освобождаем память, выделенную под аргументы функции каждого потока
    }
    
    for (int i = 0; i < numberOfProgrammers; ++i) {  // цничтожаем мьютексы
        pthread_mutex_destroy(&reviewMutex[i]);
        pthread_mutex_destroy(&acceptMutex[i]);
    }
    
    if (type) {       // если был выбран файловый ввод/вывод, закроем файлы
        fout.close();
        fin.close();
    }
}
