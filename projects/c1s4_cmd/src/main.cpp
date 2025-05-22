#include <iostream>


int main(int argc, char* argv[]) {
  //default initialization no initializer
  int width;
  //copy assigment
  width = 100;
  std::cout << "width = " << width << '\n';

  width = 500;
  std::cout << "width = " << width << '\n';

  //copy initialization height variable
  //height — instance. Width — instance?
  int constexpr height = 200;
  std::cout << "height = " << height << '\n';

  //direct-initialization
  int constexpr depth(1000);
  std::cout << "depth = " << depth << '\n';

  //direct-list-initialization
  int constexpr time{50};
  std::cout << "time = " << time << '\n';

  //value-initialization
  int constexpr distance{};
  std::cout << "distance = " << distance << '\n';

  //atribute for compiler
  [[maybe_unused]] int constexpr edge {21};

  return EXIT_SUCCESS;
}