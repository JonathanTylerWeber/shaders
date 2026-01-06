
varying vec2 vUvs;

uniform vec2 resolution;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 white = vec3(1.0, 1.0, 1.0);
vec3 black = vec3(0.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);

void main() {
  vec3 color = vec3(0.0);

  vec3 red = vec3(1.0, 0.0, 0.0);
  vec3 blue = vec3(0.0, 0.0, 1.0);

  // smooth gradient black to white
  // color = vec3(vUvs.x);

  // mix
  // color = mix(red, blue, vUvs.x);
  
  // step
  // color = vec3(step(0.25, vUvs.x));

  // smoothstep
  // color = vec3(smoothstep(0.0, 1.0, vUvs.x));
  // color = mix(red, blue, smoothstep(0.0, 1.0, vUvs.x));

  // 

  float value1 = vUvs.x;
  float value2 = smoothstep(0.0, 1.0, vUvs.x);
  // float value3 = step(0.5, vUvs.x);

  // min
  // float value3 = min(vUvs.x, 0.4);
  // max
  // float value3 = max(vUvs.x, 0.6);
  // clamp
  // float value3 = clamp(vUvs.x, 0.25, 0.75);
  // diy clamp
  float value3 = min(max(vUvs.x, 0.25), 0.75);

  float line1 = smoothstep(0.0, 0.005, abs(vUvs.y - 0.333));
  float line2 = smoothstep(0.0, 0.005, abs(vUvs.y - 0.666));

  float linearLine = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.666, 1.0, value1)));
  float smoothLine = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.333, 0.666, value2)));
  float stepLine = smoothstep(0.0, 0.0075, abs(vUvs.y - mix(0.0, 0.333, value3)));

  if (vUvs.y > 0.666) {
    color = mix(red, blue, value1);
  } else if (vUvs.y > 0.333 && vUvs.y < 0.666) {
    color = mix(red, blue, value2);
  } else {
    color = mix(red, blue, value3);
  }

  color = mix(white, color, line1);
  color = mix(white, color, line2);
  color = mix(white, color, linearLine);
  color = mix(white, color, smoothLine);
  color = mix(white, color, stepLine);

  gl_FragColor = vec4(color, 1.0);
}
