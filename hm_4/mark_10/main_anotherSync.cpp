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

sem_t reviewSem[3];  
sem_t acceptSem[3]; 

pthread_mutex_t outMutex; 
pthread_mutex_t cntMutex; 

void makeCodeReview(int num, string name) {                   
    if (!codeForReview[num].empty()) {                     
    	sem_wait(&reviewSem[num]);                    
    	string codeReview = codeForReview[num].front().first;     
    	int reviewNum = codeForReview[num].front().second;        
    	codeForReview[num].pop();
    	sem_post(&reviewSem[num]);                  
    	        
    	bool res;
    	res = checkCode(codeReview);                              // получаем результат для данного кода
    	
    	usleep(3000000);                                          // засыпаем на 3 секунды
    	pthread_mutex_lock(&outMutex);                                        // блокируем мьютекс вывода
    	myPrint("Programmer " + name + " made code review for " + names[reviewNum] + " with result: " + (res ? "Accept\n" : "Reject\n")); // выводим данные текущего ревью
        pthread_mutex_unlock(&outMutex);                                        // разблокируем мьютекс вывода
    	
    	sem_wait(&acceptSem[reviewNum]);              // блокируем семафор для очереди с результатами для программиста, которого мы проверили
    	accept[reviewNum].push(res);                              // добавляем результат в очередь
        sem_post(&acceptSem[reviewNum]);            // разблокируем семафор для очереди с результатами для программиста, которого мы проверили
    }
}


void* writeCode(void* args) {    // функция, которую мы вызываем в отдельных потоках - имитация работы программистов 
    string name = ((struct ProgrammerInfo*)args)->name;
    int num = ((struct ProgrammerInfo*)args)->num;
    for (int i = 0; i < numberOfProgramms; ++i) {            // перебираем номер очередной программы, которую пишет программист
    	string code = "";
    	generateCode(code);                                  // генерируем код
    	usleep(8000000);
    	
    	pthread_mutex_lock(&outMutex);                                   // блокируем мьютекс для вывода
    	myPrint("Programmer " + name + " wrote " + to_string(i + 1) + " code\n");  // выводим данныео написанном коде
    	pthread_mutex_unlock(&outMutex);                                   // разблокируем мьютекс для вывода
    	
    	int reviewer = num;
    	while (reviewer == num) {
    	    reviewer = rand() % 3;                           // генерируем номер программиста, который будет делать код ревью
    	}

    	sem_wait(&reviewSem[reviewer]);          // блокируем семафор для очереди с кодом на проверку для ревьюера данной программы
    	codeForReview[reviewer].push({code, num});           // кладем наш написанный код в очередь к ревьюеру
    	sem_post(&reviewSem[reviewer]);        // разблокируем семафор для очереди с кодом на проверку для ревьюера данной программы
    	
    	while (true) {                                       // запускаем цикл, который будет в очереднйо момент времени либо исправлять код (если возможно), либо делать код ревью (если возможно)
    	    if (!accept[num].empty()) {                      // если нам проверили наш код, зайдем в данный if
    	        sem_wait(&acceptSem[num]);       // блокируем семафор для очереди с нашими результатами
    	        bool res = accept[num].front();              // достаем результат из очереди
    	        accept[num].pop();
    	        sem_post(&acceptSem[num]);     // разблокируем семафор для очереди с нашими результатами
    	        if (res) {                                   // если код написан успешно
    	            if (i + 1 == numberOfProgramms) {        // если данная программа - последняя для текущего програаммиста
    	               pthread_mutex_lock(&cntMutex);                     // блокируем мьютекс для переменной cntRetiredProgs
    	               cntRetiredProgs++;                    // увеличими количество программистов, завершим написание всех программ
    	               pthread_mutex_unlock(&cntMutex);                     // разблокируем меьютекс для переменной cntRetiredProgs
    	               while (cntRetiredProgs != 3) {        // пока все программисты не закончат написание всех программ
    	                   makeCodeReview(num, name);        // вызовем функцию для код ревью
    	               }
    	            }
    	            break;                                   // выйдем из цикла
    	        }
    	        changeCode(code);                            // откорректируем наш код
    	        
    	        usleep(5000000);
    	        pthread_mutex_lock(&outMutex);                           // блокируем мьютекс для вывода
    	        myPrint("Programmer " + name + " corrected his code\n"); // выводим данный об откорректированном коде
    	        pthread_mutex_unlock(&outMutex);                          // разблокируем мьютекс для вывода
    	        
    	        sem_wait(&reviewSem[reviewer]);  // блокируем семафор для очереди с кодом на проверку для ревьюера данной программы
    	        codeForReview[reviewer].push({code, num});   // кладем наш написанный код в очередь к ревьюеру
    	        sem_post(&reviewSem[reviewer]); // разблокируем семафор для очереди с кодом на проверку для ревьюера данной программы
    	        
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
        sem_init(&reviewSem[i], 0, 1);     
        sem_init(&acceptSem[i], 0, 1);
    }
     
    for (int i = 0; i < numberOfProgrammers; ++i) {      // для каждого потока создадим структуру с именем программиста и его номером, которую мы передадим в аргумент функции
    	args[i] = (struct ProgrammerInfo*)malloc(sizeof(struct ProgrammerInfo));
    	args[i]->name = names[i];
    	args[i]->num = i;
    }
    pthread_mutex_init(&outMutex, NULL);       // инициализируем семафор вывода
    pthread_mutex_init(&cntMutex, NULL);       // инициализиурем семафор переменной cntRetireProgs
    
    for (int i = 0; i < numberOfProgrammers; ++i) {  // создаем поток для каждого программиста
        pthread_create(&programmers[i], NULL, writeCode, (void*)args[i]);  
    }
    
    for (int i = 0; i < numberOfProgrammers; ++i) {   // дожидаемся завершения работы каждого потока
        pthread_join(programmers[i], NULL);   
    }
    
    pthread_mutex_destroy(&outMutex);        
    pthread_mutex_destroy(&cntMutex);          
    
    for (int i = 0; i < numberOfProgrammers; ++i) {
        free(args[i]);            // освобождаем память, выделенную под аргументы функции каждого потока
    }
    
    for (int i = 0; i < numberOfProgrammers; ++i) {
        sem_destroy(&reviewSem[i]);
        sem_destroy(&acceptSem[i]);
    }
    
    if (type) {       // если был выбран файловый ввод/вывод, закроем файлы
        fout.close();
        fin.close();
    }
}
