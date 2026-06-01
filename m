Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BF381AF1;
	Mon,  1 Jun 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296933; cv=none; b=gW4ldX3meFV6LYx/Ci6dHb90Pxotjr6Bfz/eAWBMyETSPZqC2W0tg6zyP1AowikhwEr6pJ1+4HyFzgE1ZPrzoCZyfiGbc5SMyAaWEUC7AKiQEkJGHkSji/EVtTLZWjoCW5HHOSHezPoyMzYFFjh2Z1psf0j67D9lnombdHuhUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296933; c=relaxed/simple;
	bh=HsB7aVsNJtEEySl12PFqdonyJ4+nPqV+JWfWwrh+88Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YQeuqjzv1+leVanY1TImt+Gf6pYcCmhwV1sH1UeLmbj8birjTLWxlgF+e+bHHrmVAti5SFo8Viln/+670TR6jEFcD666PAomhMSxInD5MfToBZu1QbNE0y9uYh7eYq8JYwXLnzgDD64kxcWPzMNdxYY+hxgIYE6c2UodyNS62UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzVsqmcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzVsqmcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D98C1F00893;
	Mon,  1 Jun 2026 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780296931;
	bh=l9K/2mOCmg6QiK/gAw/yJVFS/xHL0XjxT2uwWaRPFv4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=mzVsqmcqaJ1wAteszWUiz/dT0yAvRRVLA1VfBtimr7jTV/l2ORcWDByAyAY4XBCD4
	 QyVB5UR0PNcn6dtRuiHc1ypmU5vBKK3QW1CSu0s58diHjVAEw2bH4L1Lv2SdmQ0Bbg
	 TK84zR7xzFLZhvs8NOnPlcOY0mfcnB4HsxA/xRYRp62bVZ6jl2ZBnZu799ax2dIOS1
	 v9pRHSK/M/HfWdCBkdztsCLBnU0Zj5vuaVS2ajrNcrgk6PRP5XGgcU+MtO6YRjCx0r
	 35Y4UC59F/awPs7zp+7eCef8sCUxCQajhNd4RPP4hSmpgBMs/sUbULdfQEadVgY143
	 IjQM2ypN5S20A==
Message-ID: <d5891e2b-2f88-480f-a61e-2fe192d413ad@kernel.org>
Date: Mon, 1 Jun 2026 16:55:26 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp:export-net 15/22] include/linux/compiler_types.h:699:45:
 error: call to '__compiletime_assert_784' declared with attribute error:
 BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: oe-kbuild-all@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <202605312026.Srgsz7Tp-lkp@intel.com>
 <25fb125b-6b4d-4f46-b8be-0a34099d1696@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <25fb125b-6b4d-4f46-b8be-0a34099d1696@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 01/06/2026 12:22, Matthieu Baerts wrote:
> Hi LKP team,
> 
> On 31/05/2026 23:04, kernel test robot wrote:
>> tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
>> head:   27a7d32aeb103a5c763966a494b141136c31cea0
>> commit: 206cf8c6e2bfce69eba0d463b3f6127d14f75abc [15/22] mptcp: fix uninit-value in mptcp_established_options
>> config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
> 
> Thank you for the report.
> 
> (...)
> 
>>    net/mptcp/options.c:576:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      576 |         BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
>>          |         ^~~~~~~~~~~~
> 
> Mmh, I wonder what size this struct group has on ARM 32bit. I tried to
> reproduce the issue with the config file and the instructions, but I
> didn't manage to. So I don't know what size was detected there.
> 
>   $ COMPILER_INSTALL_PATH=${HOME}/0day COMPILER=gcc-15.2.0 \
>     ~/lkp/kbuild/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/mptcp/
>   Compiler will be installed in ${HOME}/0day
>   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>   make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=${HOME}/0day/gcc-15.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- --jobs=32 KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef -falign-functions=64 W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/mptcp/
>   (...)
>     CC      net/mptcp/options.o
>   (...)
> 
> Any idea why I cannot reproduce the issue?

Earlier, I started a full build with LKP with all patches from the
export-net tree, and it didn't find any issues:

> elapsed time: 730m
> 
> configs tested: 285
> configs skipped: 6
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> tested configs:
> alpha                             allnoconfig    gcc-15.2.0
> alpha                            allyesconfig    gcc-15.2.0
> alpha                               defconfig    gcc-15.2.0
> arc                              allmodconfig    clang-16
> arc                              allmodconfig    gcc-15.2.0
> arc                               allnoconfig    gcc-15.2.0
> arc                              allyesconfig    clang-23
> arc                              allyesconfig    gcc-15.2.0
> arc                      axs103_smp_defconfig    gcc-15.2.0
> arc                                 defconfig    gcc-15.2.0
> arc                   randconfig-001-20260601    clang-23
> arc                   randconfig-001-20260601    gcc-8.5.0
> arc                   randconfig-002-20260601    clang-23
> arc                   randconfig-002-20260601    gcc-14.3.0
> arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
> arm                               allnoconfig    clang-23
> arm                               allnoconfig    gcc-15.2.0
> arm                              allyesconfig    clang-16
> arm                              allyesconfig    gcc-15.2.0
> arm                                 defconfig    clang-23
> arm                                 defconfig    gcc-15.2.0
> arm                   randconfig-001-20260601    clang-23
> arm                   randconfig-001-20260601    gcc-15.2.0
> arm                   randconfig-002-20260601    clang-23
> arm                   randconfig-002-20260601    gcc-11.5.0
> arm                   randconfig-003-20260601    clang-23
> arm                   randconfig-004-20260601    clang-23
> arm                   randconfig-004-20260601    gcc-8.5.0
> arm64                            allmodconfig    clang-19
> arm64                            allmodconfig    clang-23
> arm64                             allnoconfig    gcc-15.2.0
> arm64                               defconfig    gcc-15.2.0
> arm64                          randconfig-001    clang-23
> arm64                 randconfig-001-20260601    clang-23
> arm64                 randconfig-001-20260601    gcc-14.3.0
> arm64                 randconfig-001-20260601    gcc-8.5.0
> arm64                          randconfig-002    clang-23
> arm64                 randconfig-002-20260601    clang-23
> arm64                 randconfig-002-20260601    gcc-8.5.0
> arm64                          randconfig-003    clang-23
> arm64                 randconfig-003-20260601    clang-23
> arm64                 randconfig-003-20260601    gcc-15.2.0
> arm64                 randconfig-003-20260601    gcc-8.5.0
> arm64                          randconfig-004    clang-23
> arm64                 randconfig-004-20260601    clang-23
> arm64                 randconfig-004-20260601    gcc-14.3.0
> arm64                 randconfig-004-20260601    gcc-8.5.0
> csky                             allmodconfig    gcc-15.2.0
> csky                              allnoconfig    gcc-15.2.0
> csky                                defconfig    gcc-15.2.0
> csky                           randconfig-001    clang-23
> csky                  randconfig-001-20260601    clang-23
> csky                  randconfig-001-20260601    gcc-14.3.0
> csky                  randconfig-001-20260601    gcc-8.5.0
> csky                           randconfig-002    clang-23
> csky                  randconfig-002-20260601    clang-23
> csky                  randconfig-002-20260601    gcc-16.1.0
> csky                  randconfig-002-20260601    gcc-8.5.0
> hexagon                          allmodconfig    clang-17
> hexagon                           allnoconfig    clang-23
> hexagon                           allnoconfig    gcc-15.2.0
> hexagon                             defconfig    clang-23
> hexagon                             defconfig    gcc-15.2.0
> hexagon               randconfig-001-20260601    clang-18
> hexagon               randconfig-001-20260601    gcc-8.5.0
> hexagon               randconfig-002-20260601    clang-23
> hexagon               randconfig-002-20260601    gcc-8.5.0
> i386                             allmodconfig    clang-20
> i386                             allmodconfig    gcc-14
> i386                              allnoconfig    gcc-14
> i386                              allnoconfig    gcc-15.2.0
> i386                             allyesconfig    clang-20
> i386                             allyesconfig    gcc-14
> i386                 buildonly-randconfig-001    gcc-12
> i386        buildonly-randconfig-001-20260601    gcc-12
> i386        buildonly-randconfig-001-20260601    gcc-14
> i386                 buildonly-randconfig-002    gcc-12
> i386        buildonly-randconfig-002-20260601    clang-20
> i386        buildonly-randconfig-002-20260601    gcc-12
> i386                 buildonly-randconfig-003    gcc-12
> i386        buildonly-randconfig-003-20260601    gcc-12
> i386        buildonly-randconfig-003-20260601    gcc-14
> i386                 buildonly-randconfig-004    gcc-12
> i386        buildonly-randconfig-004-20260601    clang-20
> i386        buildonly-randconfig-004-20260601    gcc-12
> i386                 buildonly-randconfig-005    gcc-12
> i386        buildonly-randconfig-005-20260601    gcc-12
> i386        buildonly-randconfig-005-20260601    gcc-14
> i386                 buildonly-randconfig-006    gcc-12
> i386        buildonly-randconfig-006-20260601    gcc-12
> i386                                defconfig    clang-20
> i386                                defconfig    gcc-15.2.0
> i386                  randconfig-001-20260601    gcc-14
> i386                  randconfig-002-20260601    gcc-14
> i386                  randconfig-003-20260601    gcc-14
> i386                  randconfig-004-20260601    gcc-14
> i386                  randconfig-005-20260601    gcc-14
> i386                  randconfig-006-20260601    gcc-14
> i386                  randconfig-007-20260601    gcc-14
> i386                  randconfig-012-20260601    clang-20
> loongarch                        allmodconfig    clang-19
> loongarch                        allmodconfig    clang-23
> loongarch                         allnoconfig    clang-23
> loongarch                         allnoconfig    gcc-15.2.0
> loongarch                           defconfig    clang-19
> loongarch             randconfig-001-20260601    clang-23
> loongarch             randconfig-001-20260601    gcc-8.5.0
> loongarch             randconfig-002-20260601    clang-18
> loongarch             randconfig-002-20260601    gcc-8.5.0
> m68k                             allmodconfig    gcc-15.2.0
> m68k                              allnoconfig    gcc-15.2.0
> m68k                             allyesconfig    clang-16
> m68k                             allyesconfig    gcc-15.2.0
> m68k                                defconfig    clang-19
> microblaze                        allnoconfig    gcc-15.2.0
> microblaze                       allyesconfig    gcc-15.2.0
> microblaze                          defconfig    clang-19
> mips                             allmodconfig    gcc-15.2.0
> mips                              allnoconfig    gcc-15.2.0
> mips                             allyesconfig    gcc-15.2.0
> mips                      malta_kvm_defconfig    gcc-15.2.0
> nios2                            allmodconfig    clang-23
> nios2                            allmodconfig    gcc-11.5.0
> nios2                             allnoconfig    clang-23
> nios2                             allnoconfig    gcc-11.5.0
> nios2                               defconfig    clang-19
> nios2                 randconfig-001-20260601    gcc-8.5.0
> nios2                 randconfig-002-20260601    gcc-8.5.0
> openrisc                         allmodconfig    clang-23
> openrisc                         allmodconfig    gcc-15.2.0
> openrisc                          allnoconfig    clang-23
> openrisc                          allnoconfig    gcc-15.2.0
> openrisc                            defconfig    gcc-15.2.0
> parisc                           allmodconfig    gcc-15.2.0
> parisc                            allnoconfig    clang-23
> parisc                            allnoconfig    gcc-15.2.0
> parisc                           allyesconfig    clang-19
> parisc                           allyesconfig    gcc-15.2.0
> parisc                              defconfig    gcc-15.2.0
> parisc                         randconfig-001    gcc-10.5.0
> parisc                         randconfig-001    gcc-13.4.0
> parisc                randconfig-001-20260601    gcc-10.5.0
> parisc                         randconfig-002    gcc-10.5.0
> parisc                         randconfig-002    gcc-8.5.0
> parisc                randconfig-002-20260601    gcc-10.5.0
> parisc                randconfig-002-20260601    gcc-8.5.0
> parisc64                         alldefconfig    gcc-15.2.0
> parisc64                            defconfig    clang-19
> powerpc                          allmodconfig    gcc-15.2.0
> powerpc                           allnoconfig    clang-23
> powerpc                           allnoconfig    gcc-15.2.0
> powerpc                        randconfig-001    gcc-10.5.0
> powerpc                        randconfig-001    gcc-13.4.0
> powerpc               randconfig-001-20260601    gcc-10.5.0
> powerpc               randconfig-001-20260601    gcc-14.3.0
> powerpc                        randconfig-002    gcc-10.5.0
> powerpc               randconfig-002-20260601    clang-23
> powerpc               randconfig-002-20260601    gcc-10.5.0
> powerpc64                      randconfig-001    clang-17
> powerpc64                      randconfig-001    gcc-10.5.0
> powerpc64             randconfig-001-20260601    gcc-10.5.0
> powerpc64             randconfig-001-20260601    gcc-12.5.0
> powerpc64                      randconfig-002    clang-23
> powerpc64                      randconfig-002    gcc-10.5.0
> powerpc64             randconfig-002-20260601    gcc-10.5.0
> powerpc64             randconfig-002-20260601    gcc-13.4.0
> riscv                            allmodconfig    clang-23
> riscv                             allnoconfig    clang-23
> riscv                             allnoconfig    gcc-15.2.0
> riscv                            allyesconfig    clang-16
> riscv                               defconfig    clang-23
> riscv                               defconfig    gcc-15.2.0
> riscv                          randconfig-001    clang-23
> riscv                 randconfig-001-20260601    clang-23
> riscv                 randconfig-001-20260601    gcc-10.5.0
> riscv                          randconfig-002    clang-23
> riscv                 randconfig-002-20260601    clang-23
> riscv                 randconfig-002-20260601    gcc-10.5.0
> s390                             allmodconfig    clang-18
> s390                             allmodconfig    clang-19
> s390                              allnoconfig    clang-23
> s390                             allyesconfig    gcc-15.2.0
> s390                                defconfig    clang-23
> s390                                defconfig    gcc-15.2.0
> s390                           randconfig-001    clang-23
> s390                  randconfig-001-20260601    clang-23
> s390                           randconfig-002    clang-23
> s390                  randconfig-002-20260601    clang-23
> sh                               allmodconfig    gcc-15.2.0
> sh                                allnoconfig    clang-23
> sh                                allnoconfig    gcc-15.2.0
> sh                               allyesconfig    clang-19
> sh                               allyesconfig    gcc-15.2.0
> sh                                  defconfig    gcc-14
> sh                                  defconfig    gcc-15.2.0
> sh                        dreamcast_defconfig    gcc-15.2.0
> sh                             randconfig-001    clang-23
> sh                    randconfig-001-20260601    clang-23
> sh                    randconfig-001-20260601    gcc-16.1.0
> sh                             randconfig-002    clang-23
> sh                    randconfig-002-20260601    clang-23
> sh                    randconfig-002-20260601    gcc-16.1.0
> sh                             shx3_defconfig    gcc-15.2.0
> sparc                             allnoconfig    clang-23
> sparc                             allnoconfig    gcc-15.2.0
> sparc                               defconfig    gcc-15.2.0
> sparc                 randconfig-001-20260601    gcc-15.2.0
> sparc                 randconfig-001-20260601    gcc-8.5.0
> sparc                 randconfig-002-20260601    gcc-15.2.0
> sparc                 randconfig-002-20260601    gcc-8.5.0
> sparc64                          allmodconfig    clang-23
> sparc64                             defconfig    clang-20
> sparc64                             defconfig    gcc-14
> sparc64               randconfig-001-20260601    clang-20
> sparc64               randconfig-001-20260601    gcc-15.2.0
> sparc64               randconfig-002-20260601    clang-23
> sparc64               randconfig-002-20260601    gcc-15.2.0
> um                               allmodconfig    clang-19
> um                                allnoconfig    clang-23
> um                               allyesconfig    gcc-14
> um                               allyesconfig    gcc-15.2.0
> um                                  defconfig    clang-23
> um                                  defconfig    gcc-14
> um                             i386_defconfig    gcc-14
> um                    randconfig-001-20260601    gcc-14
> um                    randconfig-001-20260601    gcc-15.2.0
> um                    randconfig-002-20260601    gcc-14
> um                    randconfig-002-20260601    gcc-15.2.0
> um                           x86_64_defconfig    clang-23
> um                           x86_64_defconfig    gcc-14
> x86_64                           allmodconfig    clang-20
> x86_64                            allnoconfig    clang-20
> x86_64                            allnoconfig    clang-23
> x86_64                           allyesconfig    clang-20
> x86_64      buildonly-randconfig-001-20260601    clang-20
> x86_64      buildonly-randconfig-002-20260601    clang-20
> x86_64      buildonly-randconfig-003-20260601    clang-20
> x86_64      buildonly-randconfig-004-20260601    clang-20
> x86_64      buildonly-randconfig-004-20260601    gcc-12
> x86_64      buildonly-randconfig-005-20260601    clang-20
> x86_64      buildonly-randconfig-006-20260601    clang-20
> x86_64      buildonly-randconfig-006-20260601    gcc-14
> x86_64                              defconfig    gcc-14
> x86_64                                  kexec    clang-20
> x86_64                randconfig-001-20260601    clang-20
> x86_64                randconfig-001-20260601    gcc-14
> x86_64                randconfig-002-20260601    clang-20
> x86_64                randconfig-002-20260601    gcc-14
> x86_64                randconfig-003-20260601    clang-20
> x86_64                randconfig-004-20260601    clang-20
> x86_64                randconfig-005-20260601    clang-20
> x86_64                randconfig-006-20260601    clang-20
> x86_64                randconfig-011-20260601    clang-20
> x86_64                randconfig-012-20260601    clang-20
> x86_64                randconfig-012-20260601    gcc-14
> x86_64                randconfig-013-20260601    clang-20
> x86_64                randconfig-014-20260601    clang-20
> x86_64                randconfig-014-20260601    gcc-14
> x86_64                randconfig-015-20260601    clang-20
> x86_64                randconfig-015-20260601    gcc-14
> x86_64                randconfig-016-20260601    clang-20
> x86_64                randconfig-016-20260601    gcc-14
> x86_64                randconfig-071-20260601    clang-20
> x86_64                randconfig-071-20260601    gcc-14
> x86_64                randconfig-072-20260601    gcc-14
> x86_64                randconfig-073-20260601    clang-20
> x86_64                randconfig-073-20260601    gcc-14
> x86_64                randconfig-074-20260601    gcc-14
> x86_64                randconfig-075-20260601    gcc-14
> x86_64                randconfig-076-20260601    gcc-12
> x86_64                randconfig-076-20260601    gcc-14
> x86_64                               rhel-9.4    clang-20
> x86_64                           rhel-9.4-bpf    gcc-14
> x86_64                          rhel-9.4-func    clang-20
> x86_64                    rhel-9.4-kselftests    clang-20
> x86_64                         rhel-9.4-kunit    gcc-14
> x86_64                           rhel-9.4-ltp    gcc-14
> x86_64                          rhel-9.4-rust    clang-20
> xtensa                            allnoconfig    clang-23
> xtensa                            allnoconfig    gcc-15.2.0
> xtensa                           allyesconfig    clang-23
> xtensa                           allyesconfig    gcc-15.2.0
> xtensa                randconfig-001-20260601    gcc-15.2.0
> xtensa                randconfig-001-20260601    gcc-8.5.0
> xtensa                randconfig-002-20260601    gcc-15.2.0

Should I ignore this report then?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

