Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171544C77
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659116655; x=1690652655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7dPo19ld25ZOcZzj3TKZlahUdmwMf5jHKSGTi9vWY8=;
  b=GXIsDtWpaRixxEJvaJInQDUpfdWZydKcp9qI2hg5jYKwSMrmxeX2OoxX
   CxSBhR44hfSzzVw0DXG69zXddOJde1iaRw6S1N3GaGA2MQxTnv73oFPw7
   Ps3hLFiH4G9e71mHfA84vbNrGXDlnOpNuraYIsxGL3PCft4D38cnn8vRP
   UwxzkFcNI0u68LLUEyPmqveTyHx4rmbsSBylVvk51WuL0HO1RBM9/hk1m
   KtgK5/miWTNCdavYfLfXDEeeE3g3dc+gJU6VlNJ2h41zq2pv8eBiqKFR1
   o0rCytK0jenGJqNtaHUuZgaREIPQHO8ITuiznACT3ixQDz6nYtzAVjQoW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288827992"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="288827992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 10:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629455856"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 10:44:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oHU20-000Bvx-2Y;
	Fri, 29 Jul 2022 17:44:12 +0000
Date: Sat, 30 Jul 2022 01:43:14 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: kbuild-all@lists.01.org
Subject: Re: [PATCH mptcp-next 3/4] mptcp: move msk input path under full msk
 socket lock
Message-ID: <202207300141.nTSygY8v-lkp@intel.com>
References: <3fdd375269bc0bad45ccadfca268dcb3ac3389c1.1659107989.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdd375269bc0bad45ccadfca268dcb3ac3389c1.1659107989.git.pabeni@redhat.com>

Hi Paolo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mptcp/export]
[cannot apply to linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220730/202207300141.nTSygY8v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/120ee56b1ad70bbb3d1b35c107110b0f83b2e4e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paolo-Abeni/mptcp-just-another-receive-path-refactor/20220729-233501
        git checkout 120ee56b1ad70bbb3d1b35c107110b0f83b2e4e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash net/ipv4/ net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/protocol.c:798:6: warning: no previous prototype for '__mptcp_data_ready' [-Wmissing-prototypes]
     798 | void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
         |      ^~~~~~~~~~~~~~~~~~


vim +/__mptcp_data_ready +798 net/mptcp/protocol.c

   797	
 > 798	void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
   799	{
   800		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
   801	
   802		/* The peer can send data while we are shutting down this
   803		 * subflow at msk destruction time, but we must avoid enqueuing
   804		 * more data to the msk receive queue
   805		 */
   806		if (unlikely(subflow->disposable))
   807			return;
   808	
   809		/* Wake-up the reader only for in-sequence data */
   810		if (move_skbs_to_msk(mptcp_sk(sk), ssk))
   811			sk->sk_data_ready(sk);
   812	}
   813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
