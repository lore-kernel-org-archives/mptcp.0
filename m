Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718126299;
	Thu, 13 Nov 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033471; cv=none; b=iTdiU2lX9O+uBHHQaSLn2JdKIawM6HLzn7Mw/6OymEQwfj0X5/aGktRIbjN0UkwTYA8OFa34okaADkD1HulLjI3JWSBHLsRsSYpghI3VGZTQ3c+DtxuKCGizuPDhetn+Cu0NclbYFWwWVijNZNHuThK76umNmv7wgR5vnIV7X2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033471; c=relaxed/simple;
	bh=leQexSe0QOsw8gKDWYROxDGXZhNe5hvXDiWHOWjWxbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiU8RIlymzSyNncaL/nKnwqy70qB9/HcmNxXy/PyT+4ktbKd8RJBGMRtaiwj5/LaMJg8PwoAWB+ual0wuNBz6TjcbLbR0Ju6ZiWIY0L8FJ6IaasXFycPbVt9TMhs2HSgc2s2r1O7uRhxKtzKAnGW9NCfKzWwqjsQo3Fub18iZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XixOy/S0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XixOy/S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763033467; x=1794569467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=leQexSe0QOsw8gKDWYROxDGXZhNe5hvXDiWHOWjWxbU=;
  b=XixOy/S0KM52OeHZsljtOI2YycgrruHil4mjaRsFmQ8KTNliyHQWLSCu
   y2sz6oYfZ2Jus8/4EXldYJkhpVyQN6xc9cpaOsMQVdvfJY+G6AxoIlUvU
   N+IwZfKgFGrotii9AD/RibJeztuNPdiSD4UlfcJlZ+2PmzQdb10hk8mgF
   xCqqnxfojY5z5GkmsF0H2E4TKELmK5a5UH1ZLqjd+WgnZVwy3NAkMlego
   Xr/Oo9Sfkv5a8METoQ9H1aDBifMgl/QaG/+CBUp4wWnl9qGCnQVp2JAPS
   XqXptBp4NDOS764il93gu6v0EEpRF2NlHmxRFXK6wVaLwKWVV9mpvbOyl
   g==;
X-CSE-ConnectionGUID: KwX7+JU/RJ2Idhw0JXhx5Q==
X-CSE-MsgGUID: FgfX+x9RQumBB2lUhlGHww==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68960602"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="68960602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 03:31:06 -0800
X-CSE-ConnectionGUID: 6Rj5s/SBSaeCL0167eGeig==
X-CSE-MsgGUID: 3IowPMGiTGiQGduJiL6Haw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="220132437"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2025 03:31:05 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJVXa-0005FT-22;
	Thu, 13 Nov 2025 11:31:02 +0000
Date: Thu, 13 Nov 2025 19:30:05 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-net 3/3] Squash-to: "mptcp: leverage the backlog
 for RX packet processing"
Message-ID: <202511131931.1yh3eKYe-lkp@intel.com>
References: <ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[cannot apply to mptcp/export-net linus/master v6.18-rc5 next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/mptcp-fix-grafting-corner-case/20251113-081224
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni%40redhat.com
patch subject: [PATCH v3 mptcp-net 3/3] Squash-to: "mptcp: leverage the backlog for RX packet processing"
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20251113/202511131931.1yh3eKYe-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131931.1yh3eKYe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131931.1yh3eKYe-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/protocol.c: In function '__mptcp_add_backlog':
>> net/mptcp/protocol.c:693:17: error: 'struct sock' has no member named 'sk_memcg'
     693 |         if (!ssk->sk_memcg)
         |                 ^~


vim +693 net/mptcp/protocol.c

   654	
   655	static void __mptcp_add_backlog(struct sock *sk,
   656					struct mptcp_subflow_context *subflow,
   657					struct sk_buff *skb)
   658	{
   659		struct mptcp_sock *msk = mptcp_sk(sk);
   660		struct sk_buff *tail = NULL;
   661		struct sock *ssk = skb->sk;
   662		bool fragstolen;
   663		int delta;
   664	
   665		if (unlikely(sk->sk_state == TCP_CLOSE)) {
   666			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
   667			return;
   668		}
   669	
   670		/* Try to coalesce with the last skb in our backlog */
   671		if (!list_empty(&msk->backlog_list))
   672			tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
   673	
   674		if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
   675		    ssk == tail->sk &&
   676		    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
   677			skb->truesize -= delta;
   678			kfree_skb_partial(skb, fragstolen);
   679			__mptcp_subflow_lend_fwdmem(subflow, delta);
   680			goto account;
   681		}
   682	
   683		list_add_tail(&skb->list, &msk->backlog_list);
   684		mptcp_subflow_lend_fwdmem(subflow, skb);
   685		delta = skb->truesize;
   686	
   687	account:
   688		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
   689	
   690		/* Possibly not accept()ed yet, keep track of memory not CG
   691		 * accounted, mptcp_grapt_subflows will handle it.
   692		 */
 > 693		if (!ssk->sk_memcg)
   694			msk->backlog_unaccounted += delta;
   695	}
   696	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
