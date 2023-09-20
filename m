Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFA19BC2;
	Wed, 20 Sep 2023 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695240673; x=1726776673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7BZD98a1R/UWxHb1L9HAqTrOOagCvkiMqR8MSyUT38=;
  b=inEN5CLG3MCUoabl8oa9BnsZvoyrBN/aTxmg+fDFsQTjlIkJvI7DWw9x
   VHShRJxG/3uZVng6hZV9LbM/a0Q3/vm7b+Afw30we9W+22mDNEb6/7AUp
   pM/3Ws7VuXVOBUZ2ltldF+a2uwsG0IrAvmM/GrHTk+Bgltptjy5pSNbzm
   ut1HSm8YXO+0R209JRLj7ohLs0zr35ohxjr4cGtroAr4BAseM8/8gJtP0
   ZP6tE/rXdpZopGwCdaxUaV3qpGV1TAKo42E/ycOCDSD4muD+ue2DWfEMY
   4IU6XEV1rkpLEgZR1UGOqpsR+sPx/E625jFn637p4YapavYrDzSlmcrkp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365394312"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365394312"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 13:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870511101"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870511101"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 13:11:11 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qj3XQ-00096m-2w;
	Wed, 20 Sep 2023 20:11:08 +0000
Date: Thu, 21 Sep 2023 04:10:57 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v2 04/30] mptcp: use mptcp_wnd_end helper
Message-ID: <202309210337.Gf1gTgm6-lkp@intel.com>
References: <61179b15016da6055cc5a33dfdaacdaa30883cfb.1695095289.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61179b15016da6055cc5a33dfdaacdaa30883cfb.1695095289.git.geliang.tang@suse.com>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-drop-useless-ssk-in-pm_subflow_check_next/20230919-120834
base:   linus/master
patch link:    https://lore.kernel.org/r/61179b15016da6055cc5a33dfdaacdaa30883cfb.1695095289.git.geliang.tang%40suse.com
patch subject: [PATCH mptcp-next v2 04/30] mptcp: use mptcp_wnd_end helper
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20230921/202309210337.Gf1gTgm6-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210337.Gf1gTgm6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210337.Gf1gTgm6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mptcp/options.c:13:
   net/mptcp/options.c: In function 'ack_update_msk':
>> net/mptcp/options.c:1062:21: error: implicit declaration of function 'mptcp_wnd_end'; did you mean 'tcp_wnd_end'? [-Werror=implicit-function-declaration]
    1062 |         if (after64(mptcp_wnd_end(msk), READ_ONCE(msk->snd_nxt)))
         |                     ^~~~~~~~~~~~~
   net/mptcp/protocol.h:141:48: note: in definition of macro 'after64'
     141 | #define after64(seq2, seq1)     before64(seq1, seq2)
         |                                                ^~~~
   cc1: some warnings being treated as errors


vim +1062 net/mptcp/options.c

  1034	
  1035	static void ack_update_msk(struct mptcp_sock *msk,
  1036				   struct sock *ssk,
  1037				   struct mptcp_options_received *mp_opt)
  1038	{
  1039		u64 new_wnd_end, new_snd_una, snd_nxt = READ_ONCE(msk->snd_nxt);
  1040		struct sock *sk = (struct sock *)msk;
  1041		u64 old_snd_una;
  1042	
  1043		mptcp_data_lock(sk);
  1044	
  1045		/* avoid ack expansion on update conflict, to reduce the risk of
  1046		 * wrongly expanding to a future ack sequence number, which is way
  1047		 * more dangerous than missing an ack
  1048		 */
  1049		old_snd_una = msk->snd_una;
  1050		new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
  1051	
  1052		/* ACK for data not even sent yet? Ignore.*/
  1053		if (unlikely(after64(new_snd_una, snd_nxt)))
  1054			new_snd_una = old_snd_una;
  1055	
  1056		new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
  1057	
  1058		if (after64(new_wnd_end, msk->wnd_end))
  1059			msk->wnd_end = new_wnd_end;
  1060	
  1061		/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
> 1062		if (after64(mptcp_wnd_end(msk), READ_ONCE(msk->snd_nxt)))
  1063			__mptcp_check_push(sk, ssk);
  1064	
  1065		if (after64(new_snd_una, old_snd_una)) {
  1066			__mptcp_snd_una_update(msk, new_snd_una);
  1067			__mptcp_data_acked(sk);
  1068		}
  1069		mptcp_data_unlock(sk);
  1070	
  1071		trace_ack_update_msk(mp_opt->data_ack,
  1072				     old_snd_una, new_snd_una,
  1073				     new_wnd_end, msk->wnd_end);
  1074	}
  1075	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
