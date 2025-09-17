Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DF7464;
	Wed, 17 Sep 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105932; cv=none; b=QWaOAxJ3PzVs2RAJEXoT/LbZseIoqwFuSIvXueiyAQReFtLXhAmRSyfJWYKvkdbrQar0korAayET/L6Gzeh7P7H9LL2HBJp0/KeNfO5ll+VIFsDzjuNVKh0AZP3m8gHyoBP3w2Lcf7/acvuO9dP9TjJBFAPHJ9npP/0i4yddV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105932; c=relaxed/simple;
	bh=lALeFnr032icB/R5hjDAWNydbiTVK4KtWslLrAqdJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtgxUA6TX4LOUh26goujgWVcLrZiAlLmDnN/64e7cITwYE63vxOUoOU1eq0XamFlPv0mKHenutey6SXlwveEWh0iGtLoHj6mQ2/Bq2Jwb7cSKhX4cSmHtBsI8ooZYbnk1ex8z8giDK/UsgdgHK6oeXxcdNB4p/OT8TnErUpRanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO5rWFsR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO5rWFsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758105930; x=1789641930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lALeFnr032icB/R5hjDAWNydbiTVK4KtWslLrAqdJQw=;
  b=LO5rWFsR1s14p7AXhk1eeMW7/bEl/NvQQPe7ikQ2N7r1YlRW1fsAyz0q
   MUH4bl2LsFVYxvEhU149Bvmbda7IIKF7/SLe9ZN/NDPNAlygPcl6VUzUy
   qlS5v4Yb3KXhr0rl4hV4mY0prwUoweQB/8xK/Edya+sXQ8YpKSVJuc7Ul
   q2cgZ0Pu7rfrGd4IMJLv/XK64LXoIJ7IyyagASNcgMTBEmkGxXJxMu2sq
   d/B8VtQANSvbXoBZwc4ikRpUm709RRf5cc46+1CFPBeLhGsKlkHZKvpz7
   h/l0QxbXHoJZd9v58Je72IGiQ/ODNsQ0fs44ewW9J2PphUUoX/AqoMtJt
   A==;
X-CSE-ConnectionGUID: YXnRfZmOQEmsEFUMKYHjmw==
X-CSE-MsgGUID: tnqblaqpQvyOeEKT1c7EKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="85847509"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="85847509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 03:45:29 -0700
X-CSE-ConnectionGUID: lY47/jHkRl2pH9M1BbFwkg==
X-CSE-MsgGUID: kavOjdEJSQOu35mwtXi7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174500270"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Sep 2025 03:45:28 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uypfB-0001OJ-1i;
	Wed, 17 Sep 2025 10:45:25 +0000
Date: Wed, 17 Sep 2025 18:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [MPTCP next 03/12] mptcp: rcvbuf auto-tuning improvement
Message-ID: <202509171856.1KhVdgmP-lkp@intel.com>
References: <d3f96328a76e6fffcb871e8542c526ea99135ea5.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f96328a76e6fffcb871e8542c526ea99135ea5.1758039775.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mptcp/export-net]
[also build test WARNING on linus/master v6.17-rc6 next-20250916]
[cannot apply to next-20250916 mptcp/export]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-leverage-skb-deferral-free/20250917-003012
base:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
patch link:    https://lore.kernel.org/r/d3f96328a76e6fffcb871e8542c526ea99135ea5.1758039775.git.pabeni%40redhat.com
patch subject: [MPTCP next 03/12] mptcp: rcvbuf auto-tuning improvement
config: arc-nsimosci_hs_smp_defconfig (https://download.01.org/0day-ci/archive/20250917/202509171856.1KhVdgmP-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250917/202509171856.1KhVdgmP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509171856.1KhVdgmP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mptcp/protocol.c: In function 'mptcp_rcvbuf_grow':
>> net/mptcp/protocol.c:199:21: warning: variable 'window_clamp' set but not used [-Wunused-but-set-variable]
     199 |                 u32 window_clamp;
         |                     ^~~~~~~~~~~~


vim +/window_clamp +199 net/mptcp/protocol.c

   180	
   181	static bool mptcp_rcvbuf_grow(struct sock *sk)
   182	{
   183		struct mptcp_sock *msk = mptcp_sk(sk);
   184		int rcvwin, rcvbuf;
   185	
   186		if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) ||
   187		    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
   188			return false;
   189	
   190		rcvwin = ((u64)msk->rcvq_space.space << 1);
   191	
   192		if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
   193			rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
   194	
   195		rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
   196			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
   197	
   198		if (rcvbuf > sk->sk_rcvbuf) {
 > 199			u32 window_clamp;
   200	
   201			window_clamp = mptcp_win_from_space(sk, rcvbuf);
   202			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
   203			return true;
   204		}
   205		return false;
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
