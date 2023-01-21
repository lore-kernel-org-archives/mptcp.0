Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499A2561;
	Sat, 21 Jan 2023 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674307525; x=1705843525;
  h=date:from:cc:subject:message-id:mime-version;
  bh=Eijtwteh1c9Fq9HRrVpAc7YZLSYEtobx3TbvKp4hcV0=;
  b=MrGpeyOfeFuqCwqdQJDVFELp4Bdc2FmDzHjWSES6ZJspmN22/N26S8/P
   u8u/9GMIrQJkntrh4PrVI9zn1fMuvvxv7d3X3RU0oJqwshvLFv6yWMFp+
   1u1U/vPQPOVqGiE12I+xayBu2LX43K3qCMTU6yEY4i6u6xJm0m45kT6Ku
   yjSLuePmgIsKah6NhqCgAJ7vderR9lT/7Niv95AO0ST95jYnuxpj9wROr
   /ALJ/rZIpFnYgrO+4Bxg71oS72hvySsjEjbyFqJeMzgOUt8j7ZAjh0dk+
   P9pSl16pYNxJELYTtOTfEhWLXxwasdwHw1TaWK/Uy09fVdDPMhBFmWlm7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323473520"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="323473520"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 05:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="769026458"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="769026458"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2023 05:25:23 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pJDs2-00046w-2J;
	Sat, 21 Jan 2023 13:25:22 +0000
Date: Sat, 21 Jan 2023 21:24:59 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 7/43] drivers/net/ipa/ipa_interrupt.c:165:6: error:
 redefinition of 'ipa_interrupt_irq_disable'
Message-ID: <202301212139.IudaFveI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   1e98edbf9926b572f1766b48806f35b0427dff32
commit: 9695c8bd48f808e18eaab940550cf32a41820a89 [7/43] TopGit-driven merge of branches:
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230121/202301212139.IudaFveI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/multipath-tcp/mptcp_net-next/commit/9695c8bd48f808e18eaab940550cf32a41820a89
        git remote add mptcp https://github.com/multipath-tcp/mptcp_net-next.git
        git fetch --no-tags mptcp export
        git checkout 9695c8bd48f808e18eaab940550cf32a41820a89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ipa/ipa_interrupt.c:165:6: error: redefinition of 'ipa_interrupt_irq_disable'
     165 | void ipa_interrupt_irq_disable(struct ipa *ipa)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ipa/ipa_interrupt.c:132:6: note: previous definition of 'ipa_interrupt_irq_disable' with type 'void(struct ipa *)'
     132 | void ipa_interrupt_irq_disable(struct ipa *ipa)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ipa/ipa_interrupt.c:170:6: error: redefinition of 'ipa_interrupt_irq_enable'
     170 | void ipa_interrupt_irq_enable(struct ipa *ipa)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ipa/ipa_interrupt.c:137:6: note: previous definition of 'ipa_interrupt_irq_enable' with type 'void(struct ipa *)'
     137 | void ipa_interrupt_irq_enable(struct ipa *ipa)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/ipa_interrupt_irq_disable +165 drivers/net/ipa/ipa_interrupt.c

8e461e1f092b22 Alex Elder     2023-01-04  164  
9ec9b2a30853ba Caleb Connolly 2023-01-15 @165  void ipa_interrupt_irq_disable(struct ipa *ipa)
9ec9b2a30853ba Caleb Connolly 2023-01-15  166  {
9ec9b2a30853ba Caleb Connolly 2023-01-15  167  	disable_irq(ipa->interrupt->irq);
9ec9b2a30853ba Caleb Connolly 2023-01-15  168  }
9ec9b2a30853ba Caleb Connolly 2023-01-15  169  
9ec9b2a30853ba Caleb Connolly 2023-01-15 @170  void ipa_interrupt_irq_enable(struct ipa *ipa)
9ec9b2a30853ba Caleb Connolly 2023-01-15  171  {
9ec9b2a30853ba Caleb Connolly 2023-01-15  172  	enable_irq(ipa->interrupt->irq);
9ec9b2a30853ba Caleb Connolly 2023-01-15  173  }
9ec9b2a30853ba Caleb Connolly 2023-01-15  174  

:::::: The code at line 165 was first introduced by commit
:::::: 9ec9b2a30853ba843b70ea16f196e5fe3327be5f net: ipa: disable ipa interrupt during suspend

:::::: TO: Caleb Connolly <caleb.connolly@linaro.org>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
