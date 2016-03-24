/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

systems({
  build: {
    image: { dockerfile: "." },
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    mounts: {
      '/azk/#{manifest.dir}': sync(".", { shell: true }),
    },
  },
});
