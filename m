Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF28161;
	Wed, 23 Aug 2023 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692749156; x=1724285156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C5Y3glfFMvFJ/RIek1TuAGhwigrdddIl+LtJBWlRitA=;
  b=PLw73XeR/kUushjGIcSFKAR5HcRRa5shn9wpbwqKZbRFcjku+xHIJefj
   902HstZX3c/dqDCgLGAJvfQXMXVIvpfBpwi2YvpC3uzux6r4eF6wz4Y6w
   JKbqxUD5EWZHVFnY+V98JLg+ow4bM2SxM25my/Z+ODHG8Wq2Z6eKQA259
   QFy7btcak+f2HzRHE7H+lF771mCTxMnNAhyDLXdR7L7tC4ET5qpVihkmi
   XVgld/SrXn5dUFxVGdaZHZm8vjx5soChs53MDI1+/bAovE64Iw+xqfoVR
   VhrxBJPkgLx6tMd6iWPBbTd1xr7sdTS3PgUCEOin2n3au6Kdovgc/GLnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372910967"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="372910967"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 17:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983070485"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="983070485"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2023 17:05:51 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYbNe-0000de-23;
	Wed, 23 Aug 2023 00:05:50 +0000
Date: Wed, 23 Aug 2023 08:05:05 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH mptcp-net 2/2] mptcp: process pending subflow error on
 close
Message-ID: <202308230746.DvdUqzMi-lkp@intel.com>
References: <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230821]
[also build test WARNING on v6.5-rc7]
[cannot apply to linus/master v6.5-rc7 v6.5-rc6 v6.5-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-move-__mptcp_error_report-in-protocol-c/20230822-154511
base:   next-20230821
patch link:    https://lore.kernel.org/r/065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni%40redhat.com
patch subject: [PATCH mptcp-net 2/2] mptcp: process pending subflow error on close
config: sparc64-randconfig-r033-20230823 (https://download.01.org/0day-ci/archive/20230823/202308230746.DvdUqzMi-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230746.DvdUqzMi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230746.DvdUqzMi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mptcp/protocol.c:767:6: warning: no previous prototype for '__mptcp_subflow_error_report' [-Wmissing-prototypes]
     767 | bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__mptcp_subflow_error_report +767 net/mptcp/protocol.c

   766	
 > 767	bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
   768	{
   769		int err = sock_error(ssk);
   770		int ssk_state;
   771	
   772		if (!err)
   773			return false;
   774	
   775		/* only propagate errors on fallen-back sockets or
   776		 * on MPC connect
   777		 */
   778		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
   779			return false;
   780	
   781		/* We need to propagate only transition to CLOSE state.
   782		 * Orphaned socket will see such state change via
   783		 * subflow_sched_work_if_closed() and that path will properly
   784		 * destroy the msk as needed.
   785		 */
   786		ssk_state = inet_sk_state_load(ssk);
   787		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
   788			inet_sk_state_store(sk, ssk_state);
   789		WRITE_ONCE(sk->sk_err, -err);
   790	
   791		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
   792		smp_wmb();
   793		sk_error_report(sk);
   794		return true;
   795	}
   796	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
