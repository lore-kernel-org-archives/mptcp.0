Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489F1386
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645686549; x=1677222549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cPMwJJMSzRrE931scVTrdLwLrpY7bXn6tscZGJp1/oA=;
  b=aFKCxbIbED4JLAHomBiPQykFHrnhU98t3y8/BclCYMvi1WS0jKWD9kk1
   yRJVC2ZogHEw/dbqG3p4+Zam4DWTVt6lx6/MKab2gY2ox7Kss530kwnbl
   B1T+OQx+ZDR0n8rvlj1HsNiaDbnF1XhBYO1pejRslG2c434O76oHkgLcB
   XAucRLzR/Xi8WdTIv+cYJ3WwG0PdJXJMP3g0J5xGaX6Avnad31shnISh2
   pMHNcdxGhhpvGjWKhBaWxhmQR95mBp6HUtUcERNYwJ+uDxgnFpvyRrG3B
   Ig0mNDDaFwWwiZxGW7BHxnB8XXhP9hWEPwonICqU/V2sgvLhluHYOKN7l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232788742"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="232788742"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 23:09:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="684180780"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 23:09:08 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nN8FP-0002RL-CG; Thu, 24 Feb 2022 07:09:07 +0000
Date: Thu, 24 Feb 2022 15:09:00 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 3/4] mptcp: handle join requests via pernet listen socket
Message-ID: <202202241550.kL2XhEdK-lkp@intel.com>
References: <20220223110832.29357-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223110832.29357-4-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Florian,

I love your patch! Yet something to improve:

[auto build test ERROR on mptcp/export]
[cannot apply to linus/master v5.17-rc5 next-20220223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Florian-Westphal/mptcp-replace-per-addr-listener-sockets/20220223-190948
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220224/202202241550.kL2XhEdK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f12f5ac9c72117b9182b05e236674f68041deb5a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Westphal/mptcp-replace-per-addr-listener-sockets/20220223-190948
        git checkout f12f5ac9c72117b9182b05e236674f68041deb5a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__mptcp_handle_join" [net/ipv6/ipv6.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
