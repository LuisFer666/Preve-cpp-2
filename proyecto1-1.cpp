#include <iostream> // cin, cout, cin.get
#include <fstream> // ifstream
#include <string>
#include <regex>

using namespace std;

string contenido;

void leerContenido(){
    string archivo;
    cout << "File name: ";
    cin >> archivo;
    
    ifstream is(archivo); // Iniciar el buffer
        
    if(is.is_open()){ // Revisar si el archivo se abrio
        char c;
        while(is.get(c)){ // Leer caracteres
            contenido+=c;
        }
        cout << archivo << " abierto\n";
        is.close(); // Cerrar el buffer
    }else{
        cout << "No se pudo abrir el archivo\n";
        is.close(); // Cerrar el buffer
        exit(0);
    }
}

int main(){    
    leerContenido();
    
    string e1 = "[ \\n]*startPrevebot[ \\n]*\\{[ \\n]*"; // startPrevebot {
    string e2 = "(r144|r256|r259)*";
    string e3 = "[ \\n]*endPrevebot;[ \\n]*}"; // endPrevebot;}
    
    regex expresion("[ \\n]*startPrevebot[ \\n]*\\{[ \\n]*(r144|r256|r259)*[ \\n]*endPrevebot;[ \\n]*}");    
    bool cosa = regex_match(contenido, expresion);    
    cout << (cosa)?"Si\n":"No\n";
}



