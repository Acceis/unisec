// Load plugins
import gulp from 'gulp';
const { series, parallel, src, dest, task } = gulp;

task('copy',
  parallel(
    docsify_js, docsify_plugins, docsify_themeable_css, docsify_themeable_js,
    docsify_tabs_js, docsify_image_caption_js, docsify_sidebar_collapse_js,
    prismjs_js
  )
);
task('copy').description = 'Copy dependencies';
task('default', series('copy'));
task('default').description = 'Default';

function docsify_js() {
  return src('node_modules/docsify/lib/docsify.min.js')
    .pipe(dest('../docs/vendor'));
};

function docsify_plugins() {
  return src(['node_modules/docsify/lib/plugins/emoji.min.js',
    'node_modules/docsify/lib/plugins/search.min.js'])
    .pipe(dest('../docs/vendor/plugins'));
};

function docsify_themeable_css() {
  return src(['node_modules/docsify-themeable/dist/css/theme-simple.css',
    'node_modules/docsify-themeable/dist/css/theme-simple-dark.css'])
    .pipe(dest('../docs/vendor/themes'));
};

function docsify_themeable_js() {
  return src('node_modules/docsify-themeable/dist/js/docsify-themeable.min.js')
    .pipe(dest('../docs/vendor/plugins'));
};

function docsify_tabs_js() {
  return src('node_modules/docsify-tabs/dist/docsify-tabs.min.js')
    .pipe(dest('../docs/vendor/plugins'));
};

function docsify_image_caption_js() {
  return src('node_modules/@h-hg/docsify-image-caption/dist/docsify-image-caption.min.js')
    .pipe(dest('../docs/vendor/plugins'));
};

function docsify_sidebar_collapse_js() {
  return src('node_modules/docsify-sidebar-collapse/dist/docsify-sidebar-collapse.min.js')
    .pipe(dest('../docs/vendor/plugins'));
};

function prismjs_js() {
  return src(['node_modules/prismjs/components/prism-ruby.min.js'])
    .pipe(dest('../docs/vendor/prismjs/components'));
};
