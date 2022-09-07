Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042652F4E
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543449; x=1694079449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fm94KITMVPvJBzxCnyPknZfdfxk9KSXkT2Wso/5vHA4=;
  b=IYluOBY79Dr3EZu9vwALsYWCN/PBv+s9V0TjcbbcDgiIBDWSk2sTNzHB
   AFsrGCXycfPE9AT0xbO9wQjPag30TzhtClamRQZx2sYE23xsQ+PFsrAGU
   pdTjfAJwco8MoJ2JlzKVi4Iv/pfQfyJN966Rnwm1oMTDnmIRDF7PPoDkU
   V/N3iq6ANrymhFAlSCUdRzKYx9qXcN22wBNWWmRJMp1QwILQZfUqxsDCl
   T1+9jW79g1u8UuPRt2hS8wS/b30Q/p2r+um+XtEBsHYGv+dVHxTZQ2IYT
   Hoqh8ACdtPc6mo+aJFpeQIA01bmAs78WSjZOG75eL5poJaErnOwj1lX74
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360773135"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="360773135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="859577988"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2022 02:37:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oVrUb-0006P6-20;
	Wed, 07 Sep 2022 09:37:09 +0000
Date: Wed, 7 Sep 2022 17:36:16 +0800
From: kernel test robot <lkp@intel.com>
To: menglong8.dong@gmail.com, pabeni@redhat.com
Cc: kbuild-all@lists.01.org, mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, fw@strlen.de,
	peter.krystad@linux.intel.com, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: Re: [PATCH net v2] net: mptcp: fix unreleased socket in accept queue
Message-ID: <202209071742.Cv2hLTkj-lkp@intel.com>
References: <20220907083304.605526-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907083304.605526-1-imagedong@tencent.com>

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/intel-lab-lkp/linux/commits/menglong8-dong-gmail-com/net-mptcp-fix-unreleased-socket-in-accept-queue/20220907-163559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git e1091e226a2bab4ded1fe26efba2aee1aab06450
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220907/202209071742.Cv2hLTkj-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d238db12dcac26bfb2197e0aae24fadf6bbfdcb6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review menglong8-dong-gmail-com/net-mptcp-fix-unreleased-socket-in-accept-queue/20220907-163559
        git checkout d238db12dcac26bfb2197e0aae24fadf6bbfdcb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/mptcp/protocol.c:2799:6: warning: no previous prototype for 'mptcp_close_nolock' [-Wmissing-prototypes]
    2799 | void mptcp_close_nolock(struct sock *sk, long timeout)
         |      ^~~~~~~~~~~~~~~~~~


vim +/mptcp_close_nolock +2799 net/mptcp/protocol.c

  2798	
> 2799	void mptcp_close_nolock(struct sock *sk, long timeout)
  2800	{
  2801		struct mptcp_subflow_context *subflow;
  2802		struct mptcp_sock *msk = mptcp_sk(sk);
  2803		bool do_cancel_work = false;
  2804	
  2805		sk->sk_shutdown = SHUTDOWN_MASK;
  2806	
  2807		if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
  2808			inet_sk_state_store(sk, TCP_CLOSE);
  2809			goto cleanup;
  2810		}
  2811	
  2812		if (mptcp_close_state(sk))
  2813			__mptcp_wr_shutdown(sk);
  2814	
  2815		sk_stream_wait_close(sk, timeout);
  2816	
  2817	cleanup:
  2818		/* orphan all the subflows */
  2819		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
  2820		mptcp_for_each_subflow(msk, subflow) {
  2821			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
  2822			bool slow = lock_sock_fast_nested(ssk);
  2823	
  2824			/* since the close timeout takes precedence on the fail one,
  2825			 * cancel the latter
  2826			 */
  2827			if (ssk == msk->first)
  2828				subflow->fail_tout = 0;
  2829	
  2830			sock_orphan(ssk);
  2831			unlock_sock_fast(ssk, slow);
  2832		}
  2833		sock_orphan(sk);
  2834	
  2835		pr_debug("msk=%p state=%d", sk, sk->sk_state);
  2836		if (mptcp_sk(sk)->token)
  2837			mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
  2838	
  2839		if (sk->sk_state == TCP_CLOSE) {
  2840			__mptcp_destroy_sock(sk);
  2841			do_cancel_work = true;
  2842		} else {
  2843			mptcp_reset_timeout(msk, 0);
  2844		}
  2845	
  2846		if (do_cancel_work)
  2847			mptcp_cancel_work(sk);
  2848	}
  2849	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
