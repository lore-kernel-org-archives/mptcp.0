Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007E7C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648609061; x=1680145061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QHibYO+unoB/dnfBLxzYqyjI2OqT+FF/+o8xZG3LMh4=;
  b=PMx3tyT34Ji3I7psKkPH0aewHbDz/qmEp6GVbKiOFydhqo3XqDKm7m1T
   toiaYJc3G7jAEk4DTRnNQ8dJ86mBsKQpk+MFX0iDp7skGTJs77go9KdiA
   Izx8y9H7YCTTYFNZdGB2Ye3eI6v4DXGXXF5rjfvha9lzHhE7/njqmuRhZ
   vg5TbUZA6EAv6XrobM+EDTbY+jNeiSLpUV8OFzuughwVkMc7eZWNSp0mA
   JKA8IhpiVYBg+aRrOOZhiZ3bKf+GanwuDXrFO7yPYH3bc4OwgmtJ4vrvt
   BnFdQceMt6jEJ0aRXmvQ6FOvll45WKl6XfWHJHQ4ikHnynp72sPblt87S
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259146397"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="259146397"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 19:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="546668346"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 19:57:39 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nZOWg-0000vk-4P; Wed, 30 Mar 2022 02:57:38 +0000
Date: Wed, 30 Mar 2022 10:57:09 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: kbuild-all@lists.01.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>
Subject: [mptcp:export 32/40] net/core/filter.c:11275: undefined reference to
 `bpf_mptcp_sock_from_subflow'
Message-ID: <202203301004.nATOEv88-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   cd59bc96e464d4bee9ab55ad2de0c16a6efc6c5d
commit: 3f57ab06c5b43fdc2438983f79f2da7556ed3639 [32/40] bpf: add bpf_skc_to_mptcp_sock_proto
config: x86_64-randconfig-a005-20220328 (https://download.01.org/0day-ci/archive/20220330/202203301004.nATOEv88-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/multipath-tcp/mptcp_net-next/commit/3f57ab06c5b43fdc2438983f79f2da7556ed3639
        git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
        git fetch --no-tags mptcp export
        git checkout 3f57ab06c5b43fdc2438983f79f2da7556ed3639
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x59: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   ld: net/core/filter.o: in function `____bpf_skc_to_mptcp_sock':
>> net/core/filter.c:11275: undefined reference to `bpf_mptcp_sock_from_subflow'


vim +11275 net/core/filter.c

 11272	
 11273	BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
 11274	{
 11275		return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
 11276	}
 11277	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
