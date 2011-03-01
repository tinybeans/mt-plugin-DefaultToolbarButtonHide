package MT::Plugin::DefaultToolbarButtonHide;

use strict;
use base qw( MT::Plugin );

my $plugin = MT::Plugin::DefaultToolbarButtonHide->new({
    id          => 'default_toolbar_button_hide',
    key         => __PACKAGE__,
    name        => 'Default Toolbar Button Hide',
    description => '<__trans phrase="Hide the button in the default toolbar.">',
    version     => '1.2',
    author_name => 'Tomohiro Okuwaki',
    author_link => 'http://www.tinybeans.net/blog/',
    plugin_link => 'http://www.tinybeans.net/blog/download/mt-plugin/default-toolbar-button-hide.html',
    l10n_class  => 'DefaultToolbarButtonHide::L10N',
    blog_config_template => 'blog_config.tmpl',
    settings    => new MT::PluginSettings([
    	['opt_default_toolbar_inline', {Default => 0, Scope => 'blog'}],
    	['opt_default_toolbar_hide', {Default => 0, Scope => 'blog'}],
    	['opt_font_size_smaller', {Default => 0, Scope => 'blog'}],
    	['opt_font_size_larger', {Default => 0, Scope => 'blog'}],
    	['opt_bold', {Default => 0, Scope => 'blog'}],
    	['opt_italic', {Default => 0, Scope => 'blog'}],
    	['opt_underline', {Default => 0, Scope => 'blog'}],
    	['opt_strikethrough', {Default => 0, Scope => 'blog'}],
    	['opt_color', {Default => 0, Scope => 'blog'}],
    	['opt_insert_link', {Default => 0, Scope => 'blog'}],
    	['opt_insert_email', {Default => 0, Scope => 'blog'}],
    	['opt_indent', {Default => 0, Scope => 'blog'}],
    	['opt_outdent', {Default => 0, Scope => 'blog'}],
    	['opt_insert_unordered_list', {Default => 0, Scope => 'blog'}],
    	['opt_insert_ordered_list', {Default => 0, Scope => 'blog'}],
    	['opt_enclosure_align_left', {Default => 0, Scope => 'blog'}],
    	['opt_enclosure_align_center', {Default => 0, Scope => 'blog'}],
    	['opt_enclosure_align_right', {Default => 0, Scope => 'blog'}],
    	['opt_justify_left', {Default => 0, Scope => 'blog'}],
    	['opt_justify_center', {Default => 0, Scope => 'blog'}],
    	['opt_justify_right', {Default => 0, Scope => 'blog'}],
    	['opt_spell_check', {Default => 0, Scope => 'blog'}],
    	['opt_insert_image', {Default => 0, Scope => 'blog'}],
    	['opt_insert_file', {Default => 0, Scope => 'blog'}],
    	['opt_toggle_wysiwyg', {Default => 0, Scope => 'blog'}],
    	['opt_toggle_html', {Default => 0, Scope => 'blog'}],
		]),
    registry => {
    	callbacks => {
    		'template_source.edit_entry' => \&hide_buttons,
				'template_output.edit_entry' => \&remove_pkg,
    	},
    }
});
MT->add_plugin($plugin);

sub get_setting {
	my $plugin = shift;
	my ($value, $blog_id) = @_;
	my %plugin_param;
	
	$plugin->load_config(\%plugin_param, 'blog:'.$blog_id);
	$value = $plugin_param{$value};
	unless ($value) {
		$plugin->load_config(\%plugin_param, 'system');
		$value = $plugin_param{$value};
	}
	$value;
}

sub hide_buttons {
	my ($cb, $app, $tmpl_ref) = @_;
	
	my $blog_id = $app->param('blog_id');
	
	# Get the value of option
	my $option_default_toolbar_inline = $plugin->get_setting('opt_default_toolbar_inline', $blog_id);
	my $opt_default_toolbar_hide = $plugin->get_setting('opt_default_toolbar_hide', $blog_id);
	my $option_font_size_smaller = $plugin->get_setting('opt_font_size_smaller', $blog_id);
	my $option_font_size_larger = $plugin->get_setting('opt_font_size_larger', $blog_id);
	my $option_bold = $plugin->get_setting('opt_bold', $blog_id);
	my $option_italic = $plugin->get_setting('opt_italic', $blog_id);
	my $option_underline = $plugin->get_setting('opt_underline', $blog_id);
	my $option_strikethrough = $plugin->get_setting('opt_strikethrough', $blog_id);
	my $option_color = $plugin->get_setting('opt_color', $blog_id);
	my $option_insert_link = $plugin->get_setting('opt_insert_link', $blog_id);
	my $option_insert_email = $plugin->get_setting('opt_insert_email', $blog_id);
	my $option_indent = $plugin->get_setting('opt_indent', $blog_id);
	my $option_outdent = $plugin->get_setting('opt_outdent', $blog_id);
	my $option_insert_unordered_list = $plugin->get_setting('opt_insert_unordered_list', $blog_id);
	my $option_insert_ordered_list = $plugin->get_setting('opt_insert_ordered_list', $blog_id);
	my $option_enclosure_align_left = $plugin->get_setting('opt_enclosure_align_left', $blog_id);
	my $option_enclosure_align_center = $plugin->get_setting('opt_enclosure_align_center', $blog_id);
	my $option_enclosure_align_right = $plugin->get_setting('opt_enclosure_align_right', $blog_id);
	my $option_justify_left = $plugin->get_setting('opt_justify_left', $blog_id);
	my $option_justify_center = $plugin->get_setting('opt_justify_center', $blog_id);
	my $option_justify_right = $plugin->get_setting('opt_justify_right', $blog_id);
	my $option_spell_check = $plugin->get_setting('opt_spell_check', $blog_id);
	my $option_insert_image = $plugin->get_setting('opt_insert_image', $blog_id);
	my $option_insert_file = $plugin->get_setting('opt_insert_file', $blog_id);
	my $option_toggle_wysiwyg = $plugin->get_setting('opt_toggle_wysiwyg', $blog_id);
	my $option_toggle_html = $plugin->get_setting('opt_toggle_html', $blog_id);

	my $style = '<mt:setvarblock name="html_head" append="1"><style type="text/css">';
	
	if ($option_default_toolbar_inline) {
		$style .= 
			"#editor-content-toolbar.editor-toolbar #ceb-container.ceb-container {margin-top: 0 !important;}\n".
			"#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button {margin-right: 4px !important;}\n".
			"#editor-content-enclosure {clear: both !important;}\n";
	}

	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-font-size-smaller {display: none !important;}\n" if $option_font_size_smaller;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-font-size-larger {display: none !important;}\n" if $option_font_size_larger;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-bold {display: none !important;}\n" if $option_bold;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-italic {display: none !important;}\n" if $option_italic;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-underline {display: none !important;}\n" if $option_underline;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-strikethrough {display: none !important;}\n" if $option_strikethrough;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-color {display: none !important;}\n" if $option_color;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-link {display: none !important;}\n" if $option_insert_link;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-email {display: none !important;}\n" if $option_insert_email;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-indent {display: none !important;}\n" if $option_indent;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-outdent {display: none !important;}\n" if $option_outdent;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-unordered-list {display: none !important;}\n" if $option_insert_unordered_list;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-ordered-list {display: none !important;}\n" if $option_insert_ordered_list;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-enclosure-align-left {display: none !important;}\n" if $option_enclosure_align_left;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-enclosure-align-center {display: none !important;}\n" if $option_enclosure_align_center;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-enclosure-align-right {display: none !important;}\n" if $option_enclosure_align_right;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-justify-left {display: none !important;}\n" if $option_justify_left;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-justify-center {display: none !important;}\n" if $option_justify_center;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-justify-right {display: none !important;}\n" if $option_justify_right;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-spell-check {display: none !important;}\n" if $option_spell_check;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-image {display: none !important;}\n" if $option_insert_image;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-insert-file {display: none !important;}\n" if $option_insert_file;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-toggle-wysiwyg {display: none !important;}\n" if $option_toggle_wysiwyg;
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting a.toolbar.button.command-toggle-html {display: none !important;}\n" if $option_toggle_html;
	
	$style .= "#editor-content-toolbar.editor-toolbar .field-buttons-formatting {display: none !important;}\n" if $opt_default_toolbar_hide;
	$style .= "#editor-content-toolbar.editor-toolbar #ceb-container.ceb-container {display: block !important;}\n" if $opt_default_toolbar_hide;

	$style .= '</style></mt:setvarblock>';

	$$tmpl_ref = $style . $$tmpl_ref;
}

sub remove_pkg {
	my ($cb, $app, $tmpl_str_ref, $param, $tmpl) = @_;
	return unless UNIVERSAL::isa($tmpl, 'MT::Template');
	
	my $blog_id = $app->param('blog_id');
	my $option_default_toolbar_inline = $plugin->get_setting('opt_default_toolbar_inline', $blog_id);

	if ($option_default_toolbar_inline) {
		my $old = '<div class="field-buttons-formatting pkg">';
		my $new = '<div id="default-toolbar-buttons" class="field-buttons-formatting">';

		$$tmpl_str_ref =~ s!$old!$new!;
	}
}

1;