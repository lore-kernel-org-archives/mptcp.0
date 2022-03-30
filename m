Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD67C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 04:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648614582; x=1680150582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a4/oNYzKUPhlSMJUzfF8m9VRdH601fOYRAoAPYrJjWQ=;
  b=Cm6uZvgx0JOnwDonlZnkO9CPZACyijkdsZTQUIiN7YXWtjNFJ6ViLb+o
   mpmggzK/bbUfImboAOxajXF65+9I6smF5RA8pmw07lAHopZx2t6ACFYik
   EsBqF6p1REEsGne0Bm3hE86u0RKoDxRp43GXGKY+UIBO3N2kN5wnJ095V
   lDctIYhx2+j/+ADow3Fg4iJU4QJB6gs8fQ+NWEoPcspyR2yOihbCPOnqk
   ASXCk8HRrisIXOVRQo/RG0Ios0R86t3KiVV8ven3rj/Jx69fBjjS/Im8b
   /wu0s8aYE/hPJBSdRFuZH/TK5wpeb2nUuPgVmd16JyNEu98XRfTdJg55s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246941722"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="246941722"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="546691168"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 21:29:40 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nZPxj-0000zG-Qi; Wed, 30 Mar 2022 04:29:39 +0000
Date: Wed, 30 Mar 2022 12:29:04 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: kbuild-all@lists.01.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Nicolas Rybowski <nicolas.rybowski@tessares.net>
Subject: [mptcp:export 32/40] filter.c:undefined reference to
 `bpf_mptcp_sock_from_subflow'
Message-ID: <202203301231.cDntwFCo-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220330/202203301231.cDntwFCo-lkp@intel.com/config)
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

   ld: net/core/filter.o: in function `bpf_skc_to_mptcp_sock':
>> filter.c:(.text+0x66a4): undefined reference to `bpf_mptcp_sock_from_subflow'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
