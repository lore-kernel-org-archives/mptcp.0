Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E58628
	for <mptcp@lists.linux.dev>; Tue, 24 May 2022 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653365406; x=1684901406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pXRfrMGrgXkaLJYGaP9y6YvV5LL2rxBwSzcgDu1qxDA=;
  b=ga4x6Ofxfyi08Qg5rXm8RS2Thbdi1J2k7V2mWqBMlTjn6SeALqrJLDj8
   LduzUeqBTu1aYrPgE5iWrs6MGAODseXr6wECCudgR351sZUeGSdQkKwqk
   wRsb1sKUPnEenSAxkUQp0m8TELkBeZyOcKmztK6GBOUSzR7rFi0rjwNSr
   WxbxuJE2shXrENeJw6S6awucZlh01k133ZvkkYa7736m4Hf4WdLQ7N5dq
   5G1PKKxBiZFBStrAfTzVeTIg2TXumfYnaWBKYSds1kXmVVBybcn8HRv83
   GwTAwh2mPORKNL+lNR2XkME2o2aekdgp9TE2Gj7CSYxUfv6MhArdtp/Zm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="359819783"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="359819783"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 21:10:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="577720664"
Received: from samuelal-mobl.amr.corp.intel.com ([10.212.199.128])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 21:10:05 -0700
Date: Mon, 23 May 2022 21:10:05 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review (fwd)
Message-ID: <c776ed1-693e-ec7-7ae6-e0a36c68be1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-430609414-1653365405=:9457"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-430609414-1653365405=:9457
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Looks like Linaro's test farm checks for -stable regressions but does not 
have MPTCP selftest coverage.

I think I'll contact Naresh to see if we can add MPTCP to their list!


- Mat


---------- Forwarded message ----------
Date: Mon, 23 May 2022 19:03:36
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
     torvalds@linux-foundation.org, akpm@linux-foundation.org,
     linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
     lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
     f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review

On Mon, 23 May 2022 at 22:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.17.10 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.17.10-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: 389f9b0047fd0c936414cad5400875652b2711ef
* git describe: v5.17.9-159-g389f9b0047fd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.17.y/build/v5.17.9-159-g389f9b0047fd

## Test Regressions (compared to v5.17.8-115-g3f3287e39741)
No test regressions found.

## Metric Regressions (compared to v5.17.8-115-g3f3287e39741)
No metric regressions found.

## Test Fixes (compared to v5.17.8-115-g3f3287e39741)
No test fixes found.

## Metric Fixes (compared to v5.17.8-115-g3f3287e39741)
No metric fixes found.

## Test result summary
total: 102240, pass: 86820, fail: 722, skip: 13738, xfail: 960

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 296 total, 293 passed, 3 failed
* arm64: 47 total, 47 passed, 0 failed
* i386: 44 total, 40 passed, 4 failed
* mips: 41 total, 38 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 59 total, 56 passed, 3 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 26 total, 23 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 47 total, 46 passed, 1 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* perf
* perf/Zstd-perf.data-compression
* prep-inline
* rcutorture
* ssuite
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
--0-430609414-1653365405=:9457--
