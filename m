Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446C4BB810;
	Thu, 15 Oct 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061310; cv=none; b=UFhD1ZtYQH1De8dY5p0TtC4KOPBhtTc1VcXdbljh1OfafnppxsXB2+45iCxnSLQzc2qSMS4MmIjJeCUDBcVgcnkyuWFbLbW1BHJw4tRn/RFuATMRptYbOd+9+ZiGyo3esXwuynW2YjBiVJ67E8QLfXc1304iOvcqg0fyfQD7920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061310; c=relaxed/simple;
	bh=HEZ2s3FUswkWPi55kTSs8CccEwjxIZkc/eonLWfwo2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5q14i8wcGt7dqHei68MBOJVwnPf0ccwbQhguDNoRkgSiDulnds0R8K/PaK2VuLcLHTRXGT4FdsLWVfsKAetoohDNesHJAuccERYGlNJqGH9lgOVY5rHLdx5exa+CbWLWB0XUcfiZXjWUFuiut7uXGNjwgofKLhGplDCJiOxE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJE6g3Y4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJE6g3Y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792061309; x=1823597309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HEZ2s3FUswkWPi55kTSs8CccEwjxIZkc/eonLWfwo2U=;
  b=hJE6g3Y4ZEYszwxDuvNLwqSy0/x0+rtlUMLqdwzkX3gmQpm1g9nmjBN9
   auXyiqiDlCBWsSBA3fGtmzGsn7p8k1i4gx42fnja4+kOHedDbb9HhFmm1
   Bq1BPyzzhk2LhNjD81fFf6D+wMdm0QoJlKtyi/IcrSVBqyKLp4JHDQCB9
   jnKKq8kfoRNQ0/EGG1Sf1hLJdEdFfC7Z0T88LrkT3SkBiasHUaqyh9NzS
   HSccPKc9pPyeg9BiO+aRJ6XL+aRYwNvYNcF/RLD2QAq++kup/XbwSzU2S
   Jdd3wvAh/rEAMtLsNFR2dFab5bOSIqbXMx5kzEdS15laBTgH9rLQXPTEd
   Q==;
X-CSE-ConnectionGUID: y68AuVWRSlunGz1uoU3y3Q==
X-CSE-MsgGUID: 7UJRo+GXRuKWoA3yGaWZKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="715005"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="715005"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 03:48:28 -0700
X-CSE-ConnectionGUID: fru2sZ4jQVuzEXYHPcytIA==
X-CSE-MsgGUID: nmEvno+dS2ed90NlWwOGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3425920"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 15 Oct 2026 03:48:27 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHJ0Z-00000000GIs-46V9;
	Thu, 15 Oct 2026 10:48:23 +0000
Date: Thu, 15 Oct 2026 18:47:39 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/2] tls: implement tls_disconnect
Message-ID: <202610151855.UjUU8jxN-lkp@intel.com>
References: <6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net shuah-kselftest/next shuah-kselftest/fixes linus/master v7.3-rc7 next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/tls-implement-tls_disconnect/20261014-165935
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next 1/2] tls: implement tls_disconnect
config: i386-randconfig-1010-20261015 (https://download.01.org/0day-ci/archive/20261015/202610151855.UjUU8jxN-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610151855.UjUU8jxN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610151855.UjUU8jxN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/tls/tls_main.c:377:25: error: use of undeclared identifier 'tls_device_sk_destruct'
     377 |         if (sk->sk_destruct == tls_device_sk_destruct)
         |                                ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/tls_device_sk_destruct +377 net/tls/tls_main.c

   360	
   361	static void tls_sk_proto_free(struct sock *sk,
   362				      struct tls_context *ctx,
   363				      bool free_ctx)
   364	{
   365		struct inet_connection_sock *icsk = inet_csk(sk);
   366		long timeo = sock_sndtimeo(sk, 0);
   367	
   368		if (ctx->tx_conf != TLS_BASE || ctx->rx_conf != TLS_BASE)
   369			tls_sk_proto_cleanup(sk, ctx, timeo);
   370	
   371		write_lock_bh(&sk->sk_callback_lock);
   372		WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
   373		if (sk->sk_socket)
   374			WRITE_ONCE(sk->sk_socket->ops, ctx->sk_proto_ops);
   375		if (sk->sk_write_space == tls_write_space)
   376			sk->sk_write_space = ctx->sk_write_space;
 > 377		if (sk->sk_destruct == tls_device_sk_destruct)
   378			sk->sk_destruct = ctx->sk_destruct;
   379		if (free_ctx) {
   380			rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
   381			if (icsk->icsk_ulp_ops) {
   382				/* Balance try_module_get in __tcp_ulp_find_autoload */
   383				module_put(icsk->icsk_ulp_ops->owner);
   384				icsk->icsk_ulp_ops = NULL;
   385			}
   386		}
   387		write_unlock_bh(&sk->sk_callback_lock);
   388		if (ctx->tx_conf == TLS_SW)
   389			tls_sw_free_ctx_tx(ctx);
   390	}
   391	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
