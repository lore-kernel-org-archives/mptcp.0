Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96A39B481;
	Fri, 12 Jun 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290400; cv=none; b=Y2LBxkVFGdY+/He0gOUrePM5NTeQrae04hWU01ChtRbnd+XdBJl7EQxIw3+sEQqwHX0UhzbXJF40zxBJP0YEESI92SS+BWis5ei1WL0/asfYXTGrnGGyHnMYNL4ANAl6kUZ8Jj/gJ4/EIEIbpLvUqrmgVUz6O376rnHzkxvcVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290400; c=relaxed/simple;
	bh=1qHBgcEp2AfXud2IgtO//8m4ITPJUGeGH27EOeCwIJc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZgNVPIibbVbwpTQBgUmrZ9i1YEUGW9CpFzDDkYGwMe8T/J7P0jfcnJh5iKL1JJC9OZ3KM38kTrNzhyrU1DuNB6JaGXFWusfFOMynQ+oY9oGpk2mdiwGNoQQFQXi1tAr707s7vvKBmgLMVbZDxy7nWLFKcshW6Tt7d/iky9UUgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzYrImBy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzYrImBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781290398; x=1812826398;
  h=date:from:to:cc:subject:message-id;
  bh=1qHBgcEp2AfXud2IgtO//8m4ITPJUGeGH27EOeCwIJc=;
  b=XzYrImByALg2CEAskFlyTVNI4cj9rLMQ8Pi58WYrTB0mfg1GN3TJJqSv
   w0E3+FkON3m+PvGNYvqMFah1WINdg5WszCJjVkbAdQpux3YvSOXqK/Lq/
   mdvd9K1fMw6vzGwV/pcJ2B+OKxRFtAgnkKDFxPTa0mNkRp39+4iB2+j70
   7L1+oiubS6PyGVXZEMBooh9cbMMgli7wUs8Ki8F/6iSLPWilWmsUSRsq2
   hbVNhARfQxMY5HgYbkC61+FIOjdR2lbjSU5sVXlt7EeW/wkGTf18xPYH6
   GJukean1GQ4BY38rLDcHehmKBQBPmsUG3IocTrd+knoY47aml2CShmlYW
   A==;
X-CSE-ConnectionGUID: eWdClDErRPOqqYXZJC+Hcw==
X-CSE-MsgGUID: M2OJENWqQe+EJYfRimeEYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="92692071"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="92692071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:53:17 -0700
X-CSE-ConnectionGUID: hI4bhqExTMihLVy58lswTw==
X-CSE-MsgGUID: o8N+LWaBTJGMGqY23Zn+IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="284993051"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Jun 2026 11:53:14 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wY70B-00000000PDl-1ZpM;
	Fri, 12 Jun 2026 18:53:11 +0000
Date: Sat, 13 Jun 2026 02:53:00 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/8] .b4-config: warning: ignored by one
 of the .gitignore files
Message-ID: <202606130208.C1fSJoF1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   848e2cfaada38b718951741563f6b24496e5f587
commit: 247dd0138908e56ae4f7b3b7bb8b3d5c0101c2b9 [1/8] DO-NOT-MERGE: git markup: net
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20260613/202606130208.C1fSJoF1-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260613/202606130208.C1fSJoF1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606130208.C1fSJoF1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
