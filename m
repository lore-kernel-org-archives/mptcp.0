Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF623286405;
	Tue, 16 Jun 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615906; cv=none; b=JgUmJqQOaN5LWPFXikJ/ez1hXgkwyKLWYoU8fwjja3bEnu5RZydwfu/Px5aTMR2/nonFSLBhQcoNee7xEqRJt7l6zP1VmSfWgQj3JoIUNdVFv94xnn1tbLHlkgDQzux9JY4WNKF2BtKRBRqU3fRcl0nf3ZrO7Lj1h4k8dhZWZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615906; c=relaxed/simple;
	bh=aYT749C1vcGzeZrJIgaMPF8X2TruvSOZYXbVC/9svjM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VG7suZv7W4KjuAXzgLA8UwpA/gOC9gch/2/7BkbVlClqWyZAQ7ZzWtRv7SotXzC57bSiN7Bt5sfIG7Sw+rsr1Ray24p667P6nbPSr3HKUjB/4GqWgj3qsfr64iJOo8hX+rJryOH/wtNFaqPk3gpdjBLtfzOFv2dsP0Nehyitngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJwDB7Gm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJwDB7Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781615905; x=1813151905;
  h=date:from:to:cc:subject:message-id;
  bh=aYT749C1vcGzeZrJIgaMPF8X2TruvSOZYXbVC/9svjM=;
  b=XJwDB7GmmZU4aXMW5ZsPaOAYNinY4h8FRghizUekZ9/bXSJmIDPWTJId
   l25fCq1EXc3YE3z7HGlt/RYNodRB7X92LYnCroxOMxCXY1jBmWlEjhXUc
   tDZ8ang0dPHUGRJ6tGPdLIkJJWogPTOcWWKviWPT91DOzpR+uyhsGK+pz
   d/mRNkf5yCSw2R9mwR+z2D0wC58wCkfVHikkvLe9PwgaYGv6c6ckahoNP
   w0ADMEJvGc3vqbb/175jr8MZ/X9RjBygOeWuPCazBTFQ7IyCVu3D12ca2
   rYtQengWXBs5koTy7+xPzV177CTH9QvRLPkNx3KhFXiyTFRIGwf8KIbRQ
   A==;
X-CSE-ConnectionGUID: U09g3krCRju+Sx+4FSMlfg==
X-CSE-MsgGUID: LFK+mBe2TlG9kRI06jMjsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82485032"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82485032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 06:18:24 -0700
X-CSE-ConnectionGUID: UOvvaDaFQmuHL/Kg1yVqQQ==
X-CSE-MsgGUID: nv0d2GS5R3a/y7UMJZGTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="277971679"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Jun 2026 06:18:23 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZTgJ-00000000TCW-45nA;
	Tue, 16 Jun 2026 13:18:19 +0000
Date: Tue, 16 Jun 2026 21:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev
Subject: [mptcp:export 6/37]
 drivers/net/ethernet/microsoft/mana/mana_en.c:2406:4: warning: misleading
 indentation; statement is not part of the previous 'if'
Message-ID: <202606162155.rSSbzs8P-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   f539e897493cd0b5c3745ec4b33a2690afc7c7de
commit: 508cdf985e09fe14eb5e1da1d2e2a124b2cbae23 [6/37] TopGit-driven merge of branches:
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260616/202606162155.rSSbzs8P-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e19d1f51a2c80b63cd8ca95bcc757b7077112808)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606162155.rSSbzs8P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606162155.rSSbzs8P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/microsoft/mana/mana_en.c:2405:51: error: member reference type 'struct mana_tx_qp *' is a pointer; did you mean to use '->'?
    2405 |                         mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
         |                                                           ~~~~~~~~~~~~~^
         |                                                                        ->
>> drivers/net/ethernet/microsoft/mana/mana_en.c:2406:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
    2406 |                         mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
         |                         ^
   drivers/net/ethernet/microsoft/mana/mana_en.c:2404:3: note: previous statement is here
    2404 |                 if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
         |                 ^
   1 warning and 1 error generated.


vim +/if +2406 drivers/net/ethernet/microsoft/mana/mana_en.c

ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2381  
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2382  static void mana_destroy_txq(struct mana_port_context *apc)
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2383  {
e1b5683ff62e7b Haiyang Zhang          2021-08-24  2384  	struct napi_struct *napi;
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2385  	int i;
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2386  
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2387  	if (!apc->tx_qp)
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2388  		return;
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2389  
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2390  	for (i = 0; i < apc->num_queues; i++) {
d07efe5a6e641a Aditya Garg            2026-05-02  2391  		if (!apc->tx_qp[i])
d07efe5a6e641a Aditya Garg            2026-05-02  2392  			continue;
d07efe5a6e641a Aditya Garg            2026-05-02  2393  
d07efe5a6e641a Aditya Garg            2026-05-02  2394  		debugfs_remove_recursive(apc->tx_qp[i]->mana_tx_debugfs);
d07efe5a6e641a Aditya Garg            2026-05-02  2395  		apc->tx_qp[i]->mana_tx_debugfs = NULL;
6607c17c6c5e02 Shradha Gupta          2024-10-08  2396  
d07efe5a6e641a Aditya Garg            2026-05-02  2397  		napi = &apc->tx_qp[i]->tx_cq.napi;
d07efe5a6e641a Aditya Garg            2026-05-02  2398  		if (apc->tx_qp[i]->txq.napi_initialized) {
e1b5683ff62e7b Haiyang Zhang          2021-08-24  2399  			napi_synchronize(napi);
d5c8f0e4e0cb0a Erni Sri Satya Vennela 2025-06-17  2400  			napi_disable_locked(napi);
d5c8f0e4e0cb0a Erni Sri Satya Vennela 2025-06-17  2401  			netif_napi_del_locked(napi);
d07efe5a6e641a Aditya Garg            2026-05-02  2402  			apc->tx_qp[i]->txq.napi_initialized = false;
b6ecc662037694 Souradeep Chakrabarti  2024-09-02  2403  		}
508cdf985e09fe Matthieu Baerts (NGI0  2026-06-15  2404) 		if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
ca9c54d2d6a5ab Dexuan Cui             2021-04-16 @2405  			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
d07efe5a6e641a Aditya Garg            2026-05-02 @2406  			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2407  
d07efe5a6e641a Aditya Garg            2026-05-02  2408  		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2409  
d07efe5a6e641a Aditya Garg            2026-05-02  2410  		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
d07efe5a6e641a Aditya Garg            2026-05-02  2411  
d07efe5a6e641a Aditya Garg            2026-05-02  2412  		kvfree(apc->tx_qp[i]);
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2413  	}
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2414  
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2415  	kfree(apc->tx_qp);
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2416  	apc->tx_qp = NULL;
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2417  }
ca9c54d2d6a5ab Dexuan Cui             2021-04-16  2418  

:::::: The code at line 2406 was first introduced by commit
:::::: d07efe5a6e641af59f2dbbef4a748fab6d967747 net: mana: Use per-queue allocation for tx_qp to reduce allocation size

:::::: TO: Aditya Garg <gargaditya@linux.microsoft.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
