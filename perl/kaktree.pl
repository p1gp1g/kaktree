use strict;
use warnings;

my $root = $ENV{"kaktree_root"};
my $open_node = $ENV{"kak_opt_kaktree_dir_icon_open"};
my $closed_node = $ENV{"kak_opt_kaktree_dir_icon_close"};
my $file_node = $ENV{"kak_opt_kaktree_file_icon"};
my $indent = $ENV{"kak_opt_kaktree_indentation"};
my $current_indent = $ENV{"kak_opt_kaktree__current_indent"};
my $hidden = $ENV{"kak_opt_kaktree_show_hidden"};
my $indent_str;

for my $i (1 .. $indent) {
    $indent_str .= " ";
}

chomp(my @input = <>);

if ($hidden == "true") {
    # remove `./' and `../' from tree
    @input = grep {$_ ne "../"} @input;
    @input = grep {$_ ne "./"} @input;
}

my $input_size = scalar @input;

print "$current_indent$open_node $root\n";

if ($input_size > 0) {
    build_tree(@input);
} else {
    print "$current_indent$indent_str<empty>\n"
}

sub build_tree {
    my @items = sort @_;
    my @files;

    foreach my $item (@items) {
        if ($item =~ /(.*)\/$/) {
            print "$current_indent$indent_str$closed_node $1\n";
        } else {
            push(@files, $item);
        }
    }

    foreach my $file (@files) {
        print "$current_indent$indent_str$file_node $file\n"
    }
}
