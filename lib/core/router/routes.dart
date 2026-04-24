enum Routes {
  noInternet('noInternet'),
  loading('loading'),
  authentication('authentication'),

  gallery('gallery'),
  photo('photo');

  const Routes(this.route);
  final String route;
}
