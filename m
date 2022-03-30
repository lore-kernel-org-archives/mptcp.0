Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884297C;
	Wed, 30 Mar 2022 03:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648611523; x=1680147523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kPljEm2HsbfLocY4jiOlmukZRzbE+eJVGnBWF9sUu/c=;
  b=A18qDfTA5qLWezXLY82Oz6MESaRK+aTQ2YmT/qy8zjTWykmDP5KExYLz
   aMioGPvuYH1V766NjWMUWGjPkdP8ivq13CxhEOUOUx7Z/BleoxeW1h+JB
   V8HEuToRmACSJh2W0lyRs0IiQRMN9mfxwtfAH84kZ+4Vb5bCLjauxOKqM
   pJpBlFVcmUWPaokrLeQ5XzLetM0F4kzWmC+hkjfVff5vBX10vvnu1JyD+
   5pye8oNzesOmsKj8P2j40OvqR2AsD8H1E/XYTsdZatUO3VOX/COOg+ZGa
   d2YVUUNRyZweJERc8facU+4yM8UDt4XBKzkQ6CZ7ix4RR6sSxuB5qhGHP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259622958"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="259622958"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 20:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719809760"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2022 20:38:39 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nZPAN-0000xK-25; Wed, 30 Mar 2022 03:38:39 +0000
Date: Wed, 30 Mar 2022 11:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>
Subject: [mptcp:export 32/40] ld.lld: error: undefined symbol:
 bpf_mptcp_sock_from_subflow
Message-ID: <202203301115.cmYiPeju-lkp@intel.com>
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
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220330/202203301115.cmYiPeju-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/multipath-tcp/mptcp_net-next/commit/3f57ab06c5b43fdc2438983f79f2da7556ed3639
        git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
        git fetch --no-tags mptcp export
        git checkout 3f57ab06c5b43fdc2438983f79f2da7556ed3639
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_mptcp_sock_from_subflow
   >>> referenced by filter.c
   >>>               core/filter.o:(bpf_skc_to_mptcp_sock) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
