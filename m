Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9ED33DEF4;
	Thu, 13 Nov 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034793; cv=none; b=UIuV6CssTH3PCj8UGhDH0kj/oP5A0MKcE3VXd2FlWCnrEaCni8gQ+RSbJhGIQTGuD/Y8/AKXIM7cvkEkAsGmjoiR3wGi9xsUkv9GMz9jPzKFVocj4LIwWUgmly/l13MMR4Kk0Wi+6nDbwCsuAWXzrKrlp3Urb1mWhhEBr4emt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034793; c=relaxed/simple;
	bh=EnTd1yIYJhrbayx54jkHHGQTQtsGLte7b2vGK/trwJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIKpZ4/mCd6tGXte+MaAi2gYMOh4CjqgeEuQ0NWMzzenhcYTyoJrAr4Z2hjZSe8kwf+jUHrnciKOv7kUx6f9SgYticKS5gNBz9CbMTPkjzHbI29S/4Sa2owuAidp8QbVf6Z20eghQqukwetaEpDQWBJGOPaX1JEsJJ04ZrckVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky5xh5kQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky5xh5kQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763034792; x=1794570792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EnTd1yIYJhrbayx54jkHHGQTQtsGLte7b2vGK/trwJU=;
  b=ky5xh5kQ/uTQ3CZyzDAeW4zUMCXNDHw5dHLx8RyFLnIj9Y/2EITJJ3Eo
   0BwbnzrcgT/FaKGu6oHjQS35mPJGwOVTWfVFAeqgXCZXYJcRyTlhBoFF4
   qRojzH7+eYP9dRJktGxy9nD2+3w0ctfNq2c2wGuEXuyedhCh3XyBoV1+q
   /NaCMzvzS9wG+ZBdUW2QFx7Nvs0mtrqgwB2Qe+M5jF83/OFpq9bdKlE5Y
   2ya+YFIgQyhvyDnEM985UNwSLUeCX7rFLbVzpO5CZMgyQCSTMQCCbpplA
   A1YNFHHji/UrYhjBoa5b4a928yuDBb7/1OI+wGBCN++BM+ZCEigj5uFww
   Q==;
X-CSE-ConnectionGUID: jpT99LqXSeOvZRbGNkv4FQ==
X-CSE-MsgGUID: umYhJtpIQMu1WRfRQkkIcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76572005"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="76572005"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 03:53:09 -0800
X-CSE-ConnectionGUID: KI0P8riSR7CNAJXtWjnlvg==
X-CSE-MsgGUID: 56hdobk0T9ittekeU8Xi8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="226783197"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Nov 2025 03:53:07 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJVsu-0005HX-2s;
	Thu, 13 Nov 2025 11:53:04 +0000
Date: Thu, 13 Nov 2025 19:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-net 3/3] Squash-to: "mptcp: leverage the backlog
 for RX packet processing"
Message-ID: <202511131922.61JkdJO9-lkp@intel.com>
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
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20251113/202511131922.61JkdJO9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131922.61JkdJO9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131922.61JkdJO9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/protocol.c:693:12: error: no member named 'sk_memcg' in 'struct sock'
     693 |         if (!ssk->sk_memcg)
         |              ~~~  ^
   1 error generated.


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
