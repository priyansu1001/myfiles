#!/bin/bash

function usage {
  echo "--- inttf NVIDIA patcher ---"
  echo "script usage: $(basename $0) [-h] [-v 340.108, 390.147, 418.113, 435.21]" >&2
}

function get_opts {
  local OPTIND
  while getopts "hv:" opt; do
    case $opt in
      v) 
        nvidia_version=$OPTARG
        ;;
      h)
        usage
        exit 0
        ;;
      *) 
        usage
        exit 1
        ;;
      \?)
        usage
        exit 1
        ;;
    esac
  done
  if [ $OPTIND -eq 1 ]; then 
    usage
    exit 1;
  fi
}

function check_version {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  usage
  exit 1;
}

function check_file {
  if [ ! -f ./$1 ]; then
    echo Downloading... $2
    wget -O $1 $2
  else
    echo $1 found.
  fi
  if [ "$(b2sum < ./$1)" = "$3  -" ]; then
    echo $1 [OK]
  else
    echo $1 [Fail]
    echo Deleting... $1
    rm ./$1
    echo Downloading... $2
    wget -O $1 $2
    if [ "$(b2sum < ./$1)" = "$3  -" ]; then
      echo $1 [OK]
    else
      echo $1 [Fail]
      exit 1
    fi
  fi
}

get_opts "$@"

nvidia_versions=( '340.108' '390.147' '418.113' '435.21' )

check_version $nvidia_version "${nvidia_versions[@]}"

nvidia_short_ver=${nvidia_version%%.*}
nvidia_directory="NVIDIA-Linux-x86_64-${nvidia_version}"
nvidia_file="NVIDIA-Linux-x86_64-${nvidia_version}.run"
nvidia_url="https://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/${nvidia_file}"
nvidia_340xx_b2sum="890d00ff2d1d1a602d7ce65e62d5c3fdb5d9096b61dbfa41e3348260e0c0cc068f92b32ee28a48404376e7a311e12ad1535c68d89e76a956ecabc4e452030f15"
nvidia_390xx_b2sum="a8085c9abc1c31251788a8f5abdc2090c9085b3028e364184244bbf24d822dc3266877c88b30f403507fa2dd511c68ec67e1f188d6b0f1f4d7d792881d5253fc"
nvidia_418xx_b2sum="b335f6c59641ee426aff2b05a495555ec81455a96c629727d041674f29bd4b5e694217ea9969ccf5339038c5a923f5baf5888491554a0ca20d6fc81faaaf8a27"
nvidia_435xx_b2sum="e9afd6335182a28f5136dbef55195a2f2d8f768376ebc148190a0a82470a34d008ce04170ffc1aab36585605910c1300567a90443b5f58cb46ec3bff6ab9409c"
#nvidia_510xx_b2sum="9165e4763a34c3cf474c18dae7d2c548bb6d4edc21507afe67d046959e9f3fb758cf507dcdffcfbc0bf70cf2b677a193429127b3fe589af329fe6a671ac51e6f"
nvar=nvidia_${nvidia_short_ver}xx_b2sum
nvidia_b2sum=${!nvar}

patch_url="https://nvidia.if-not-true-then-false.com/patcher/NVIDIA-${nvidia_short_ver}xx/"

case "${nvidia_short_ver}" in
  340)
    patch_file_names=( 
      'kernel-5.7.patch' 
      'kernel-5.8.patch' 
      'kernel-5.9.patch' 
      'kernel-5.10.patch' 
      'kernel-5.11.patch' 
      'kernel-5.14.patch'
      'kernel-5.15.patch'
      'kernel-5.16.patch'
      'kernel-5.17.patch' )
    patch_file_b2sums=( 
      '7150233df867a55f57aa5e798b9c7618329d98459fecc35c4acfad2e9772236cb229703c4fa072381c509279d0588173d65f46297231f4d3bfc65a1ef52e65b1' 
      'b436095b89d6e294995651a3680ff18b5af5e91582c3f1ec9b7b63be9282497f54f9bf9be3997a5af30eec9b8548f25ec5235d969ac00a667a9cddece63d8896' 
      '947cb1f149b2db9c3c4f973f285d389790f73fc8c8a6865fc5b78d6a782f49513aa565de5c82a81c07515f1164e0e222d26c8212a14cf016e387bcc523e3fcb1' 
      '665bf0e1fa22119592e7c75ff40f265e919955f228a3e3e3ebd76e9dffa5226bece5eb032922eb2c009572b31b28e80cd89656f5d0a4ad592277edd98967e68f'
      '344cd3a9888a9a61941906c198d3a480ce230119c96c72c72a74b711d23face2a7b1e53b9b4639465809b84762cdc53f38210e740318866705241bc4216e4f35'
      '31a4047ab84d13e32fd7fdbf9f69c696d3fab6666c541d2acf0a189c1d17c876970985167fd389a4adc0f786021172bdec1aa6d690736e3cf9fcd8ceabe5fd32' 
      'a26426488f6e105f546e091ce4d2e9587cc41a0fb05b0dffeb1c523d8d06782bda3004352655c9c019224091f7bc7903939e53ede73f64553f14be8e8a47793a'
      'caedc5651bfd14c02fb677f9c5e87adef298d871c6281b78ce184108310e4243ded82210873014be7fedee0dd6251305fa9bbce0c872b76438e0895ef76109d9'
      '0266e1baaac9ffbb94d9e916a693b1663d8686b15e970bfc30f7c51f051a0af9267aa5f6a12b68586c69d2e9796a1124488b3997ba4b26db1a5ac10a892f0df2' )
    output_file_name=( 'patched-kernel-5.17' 'patched for kernel 5.17+' )
    ;;
  390)
    patch_file_names=(
      'kernel-5.17.patch' )
    patch_file_b2sums=( 
      '308c4e770500dc63031a5736bf9578982c022b91c4ef081545821322c1712a8fc3ceab70d507b329378eee053671e8a89c59d9787821f25e92aadf4161f761a6'  )
    output_file_name=( 'patched-kernel-5.17' 'patched for kernel 5.17+' )
    ;;
  418)
    patch_file_names=( 
      'kernel-5.5.patch' 
      'kernel-5.6.patch' 
      'kernel-5.7.patch' 
      'kernel-5.8.patch' 
      'kernel-5.9.patch' 
      'kernel-5.10.patch'
      'kernel-5.11.patch' 
      'license.patch' )
    patch_file_b2sums=( 
      'fae57c950f4906fa95801c2676cb9c4fd831c9e1c5333223fb68f3fb7dbb994742873ae307723eb0d7547a4a4c655d3bacb7e4d7e8e0f11051300fdb1098489a' 
      'b45a707f09feb32fd17df9e2582ef1ae77a4a21e6fcc51abc81d59c7e5e831c1c5fbcd3f06829fc084bed4a4ee3fdcbfc88ac2ba8a28d3c48d66ea539e490feb' 
      'e290a02036cb4a41b8c561aa9ad67971392550de9c4fd4f8106848752068fd544f48ae07736e40313bc71a9f8beee9f9a9b317e8931a686ccb9cf4af9ecc4430' 
      '4241170d7ab8eda68b51893090c7ba2dffab1bc6316affa84aa2786a5f428874b9008febda8f20a761e08c1c79d962547e577fc59f2db97b42434fc76588aad6' 
      '4bcd4094bab3349fbf4d784f5aaa6137930089d6e228f2adb86e960f2fd4ebe84c750f1c39e47f0d5372434b6f429a3a5921a7a590a4b4000a4b8d88d7583b06' 
      'db272697c06972ea3b4f3edd9802bc0fc9e9fca931a4559caf1944042fe88336a08ed7d9d06e49270853b9fd53a029a7fd3c3dcebb5c2087857078d7966c1b75' 
      'f1fa9292dffa046c3d46ce5e56d8db4f5897dc0f383825f8b7de35b46dceca5f7b41936ab23a65cf355bcd6e37f1dab8f565498f649b914b1a454d75dc8d1532'
      '0472598d8ce4c60a93ef9843ab01b1ab99a647882e55ee2d666b6e10b2a43fabcee6a0d26f4674e224430c4af0ef9af5a4f277ad4e0ef2d13f5c30afe85100b3' )
    output_file_name=( 'patched-kernel-5.16' 'patched for kernel 5.16+' )
    ;;
  435)
    patch_file_names=( 
      'kernel-5.4.patch' 
      'kernel-5.5.patch' 
      'kernel-5.6.patch' 
      'kernel-5.7.patch' 
      'kernel-5.8.patch' 
      'kernel-5.9.patch' 
      'kernel-5.10.patch' 
      'kernel-5.11.patch'
      'license.patch' )
    patch_file_b2sums=( 
      '586982cdbbb7751dc75f9b1c33ca033703170d0329c9c19e02bc32df732b6d7f102c5f703f8e4ec3a7152cb5a6ce87e0ed0fd3df95b040655b409ad59e0c210d' 
      '26bdf3240caf5a8382703e9193e43993c518dcba325679f2e314d9ab69f7f11400d1fe0e4f99618bd1eaacb737143f37eedce363acfb78a5631c2bfc9a2e9150' 
      'e7b6ea3fae0bd92bdc0a934466313a48075b8e11b27cbdec328ec3bcb415d2c89aaf61cb0dc5506aaceb537162e8f833e55607a4db12ab3a6475f3b8ac736bff' 
      'e4ad99e110bbd8539b9ebf5ec5269db5db1ae2bc23b0fd6c1a2cb396b782a48a849c98de4a535327dc8cb2e73e50aad79e3fc2cb4d2b806cecc7c23aa06aa466' 
      'e77dfd9aa5629a66e8cfacb3afde1ef74b26f6471287b43b6e0fc58bb4686cab919a49ba2e9a6f931b4f443e49bf82ee759067a7c7477a965aa9295b223d8217' 
      '7c5e6c9b37965c1e35fa35b99c8497afa50fd5e72f3494b02654e85b96e9982193e7a27d3b681c6b9de59f54bb5708950d3dc2640aa2a22ab4cc40e3163d42c9' 
      'da7cbd06fe7dbcd704be4f97fbdd39ea10d149fbded4773420e94318571800d62c619c801a270abcda92ae48662adb01c8d48a5e0cc85fa4532a2ce056d4e698'
      '1448dca042897bde8e14c7572c61344cd5df1b1a46f0fe832fa726cf8cff513537cdfac251d1042a7566d2c362e42af9d8c7118cad2e689d19ce381e8827d745'
      'badf91ac5b0d0ef5d5eda85b79447b475216b4692b19380f495670c961baa0b6f0d6687d2393c29edc22115f40e94705e488471265d30124b0a0775105638756' )
    output_file_name=( 'patched-kernel-5.16' 'patched for kernel 5.16+' )
    ;;
  #510)
  #  patch_file_names=(
  #    'simpledrm.patch' )
  #  patch_file_b2sums=(
  #    '9d58b844cf680baa9b626e9165b067dc233301e1895a698575398a8015ae60b4681f30b1edc2409650a104ff1f01ffd4415c35dc7dcd8c0ba5cdd55e4ecd98f3' )
  #  output_file_name=( 'patched-fedora-36' 'patched for Fedora 36' )
  #  ;;
esac

check_file $nvidia_file $nvidia_url $nvidia_b2sum

mkdir -p NVIDIA-${nvidia_short_ver}xx

for i in "${!patch_file_names[@]}"; do
  #echo ${patch_file_names[$i]} $patch_url ${patch_file_b2sums[$i]}
  check_file "NVIDIA-${nvidia_short_ver}xx/${patch_file_names[$i]}" "$patch_url${patch_file_names[$i]}" ${patch_file_b2sums[$i]}
done

chmod +x ./$nvidia_file

if [ -d ./$nvidia_directory ]; then
  rm -rf ./$nvidia_directory
fi

./$nvidia_file --extract-only

cd ./$nvidia_directory

for f in "${patch_file_names[@]}"; do
  patch -Np1 -i ../NVIDIA-${nvidia_short_ver}xx/$f
done

cd ..

./$nvidia_directory/makeself.sh --target-os Linux --target-arch x86_64 $nvidia_directory $nvidia_directory-${output_file_name[0]}.run "NVIDIA driver $nvidia_version ${output_file_name[1]}" ./nvidia-installer

exit 0





