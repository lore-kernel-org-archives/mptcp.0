Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB8356742;
	Mon,  1 Jun 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341666; cv=none; b=cmmk+XRkHBG8T5tLAjqvduA1n2a0/6WzqGKOsDWyUDc1U/QFI3eq6seI5bDXMaxNM6HPOokH0glKqHYajAMRcQFQUpxEp3AgVH2HmCwObbHNTtf7Yz8ngZS7AzWb+d4PfzJxLgvYJ+aPjbzmjsbytEP1iqbdt1sL9Pq0kIGFOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341666; c=relaxed/simple;
	bh=te1p2XikqfauP/Ps6RR+pSJ+j3eSP3lPbx5QlhDRH2w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KfmJLtMVS5n8bJIJ2LsgMXotLczln5VxtKloP6kU0kURuLFhCDLdM+zuB+NoG5p529Q/OvCgHKQSj2t2XcVGOP7nNgsh2M2ZuBVHHmUMrcTBLXbyZjnTmyLzd0kialrrdVgYGCm14SwqzXzjRH7iZtvvySlcZNL2pH4tImGZraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjN6vLWK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjN6vLWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780341665; x=1811877665;
  h=date:from:to:cc:subject:message-id;
  bh=te1p2XikqfauP/Ps6RR+pSJ+j3eSP3lPbx5QlhDRH2w=;
  b=MjN6vLWKmsbo0IVLNnJFw5CnOFT3z0SoXeiskiV36tTutFkOfLqubbVS
   BzpXrOSIXsRprvA9mQPCxu2Eq53d5UK9TtO5fYBI3NrQMjJLvyZGAYj1m
   rNB2tkeZyiyo40TA6cFLbDkbvQt63vq5NZ0/SNmwP7m9s6GzoNXFeG3Ml
   qzwvvMs25ujoWPPG4IPTo0DZy85IybCdUCgPWrSml9TxZQxvVzRygjJm6
   kdNLFquB1KTqR+vx/8+hlqiaJ1pVHwwyBGFjzeWYUdAEGz0V+0szVhlmK
   yW2cZsRm2QsJithUXg9QeJJXRGKmM0wZm/eWj9nPHo7u5jlfke8SXPj7r
   Q==;
X-CSE-ConnectionGUID: EGUEjvotQfGtGQ5XlrXsKg==
X-CSE-MsgGUID: 7VVjZh17R3m8tdpdlM52fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81083312"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81083312"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 12:21:01 -0700
X-CSE-ConnectionGUID: 1ZY2wPDnQD+YyaExWLlCbw==
X-CSE-MsgGUID: wgCUb5r0QX2Ekk+bApSTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243767020"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Jun 2026 12:21:01 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wU8C1-00000000Azi-3Dsv;
	Mon, 01 Jun 2026 19:20:57 +0000
Date: Tue, 02 Jun 2026 03:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/60] .git_markup: warning: ignored by one of
 the .gitignore files
Message-ID: <202606020245.oFsdN9JN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   e05cbdb611ff815528cdf90e29a96663b9af48c6
commit: 63c7e82ee806b2ba0be31bda10406e6f91efb432 [1/60] DO-NOT-MERGE: git markup: net
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20260602/202606020245.oFsdN9JN-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606020245.oFsdN9JN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606020245.oFsdN9JN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
