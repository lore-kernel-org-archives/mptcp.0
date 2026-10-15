Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D8275870;
	Thu, 15 Oct 2026 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024498; cv=none; b=DKS3zbkSdKaFJosT59E/8o2aXn2Pwke5KM/mWU8yoLA+RM2n3x+nclhOZ8cvD7+hFhzGb9GFt6U5ufXJznXP7FaK8WrgpnDzI3MKr5vHK2eT256YgbO5/sfbwnXg+t3xZur4TyIqQuCPDvILq2dVgr3osF+s8X3Fu7vnLBeYghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024498; c=relaxed/simple;
	bh=gwTaAOEasKiDHbzb7R1qUUjQw6xLTsx5YdIQap7eOG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nac5oMRyKVTb+bleuVxkb56PKPIcl3pnQDl0M90E/Ky2MUQsdh8FwY1VaPRY7W9Div0c4uqZOAeQ0+3IKMUMR8w+RemUZekjDl3W1np7RBiiRmAvxFjUukgb/FNUKAIalbE4CPHiPt9qmxcZEsn8C3QmFPLdkx3Rj9nlXRDBbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDCtZT39; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDCtZT39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792024497; x=1823560497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gwTaAOEasKiDHbzb7R1qUUjQw6xLTsx5YdIQap7eOG0=;
  b=GDCtZT39FD1B/ErcVscqqHksPC2GfAKAT89iWL2eeEes4JoERfkhTsEd
   +w1BHHus4TfcI2tdKgB95u4KV3ijA4JcEbzawnhAaiHCHGqF42Z6YP4oB
   uYqYLY1ifWvFK3dp1gZCpGbGhm+e02b41k/Cyao06EtpZK6Ff6+B5gIms
   RSTogE+zuL05C/nCOUDhdtSwpAdCtdmuAENVObk9aCpsD6m0/pN9SAmXj
   paKBCQc8ms9bRIa7e0gxAgJk8v/AUVO59Romyuaa0HSEg5h+WmYUkiy5h
   uJblJySBdFJ9C85iDg5yw4bMDl8csM6iCdkz6FPq6ZlJ9BA6Ijli5vqlH
   Q==;
X-CSE-ConnectionGUID: u2ugbvzURcyX3u+KIq7vqQ==
X-CSE-MsgGUID: kY9Kbk+mQ3a19AWCc0sn3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="796594"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="796594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 17:34:56 -0700
X-CSE-ConnectionGUID: pb2hHKhxTWC9JZFUa+Ws+g==
X-CSE-MsgGUID: fpGoSFUETaaSUQ/RN0Rc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1516288"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Oct 2026 17:34:54 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH9Qq-00000000FR1-1K0N;
	Thu, 15 Oct 2026 00:34:52 +0000
Date: Thu, 15 Oct 2026 08:34:38 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/2] tls: implement tls_disconnect
Message-ID: <202610150856.tk1Ryxlc-lkp@intel.com>
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20261015/202610150856.tk1Ryxlc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150856.tk1Ryxlc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150856.tk1Ryxlc-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/tls/tls_main.c: In function 'tls_sk_proto_free':
>> net/tls/tls_main.c:377:32: error: 'tls_device_sk_destruct' undeclared (first use in this function); did you mean 'tls_device_sendmsg'?
     377 |         if (sk->sk_destruct == tls_device_sk_destruct)
         |                                ^~~~~~~~~~~~~~~~~~~~~~
         |                                tls_device_sendmsg
   net/tls/tls_main.c:377:32: note: each undeclared identifier is reported only once for each function it appears in


vim +377 net/tls/tls_main.c

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
