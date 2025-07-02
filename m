Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2952609D6;
	Wed,  2 Jul 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464101; cv=none; b=TW1ZE32gG5Xu3AskKSOe2NVHiAUDKrmR8XQdanpMHwjwwmilu7lkGEQ5Wd44Xjxs6eCHqFBpBjCX5PLb1DeIG9Cm2GNuQMdfj8BdLxOJg2jTZDVwxb5qb2uSsn8wS9ybZX9wN7yWvnwI9+rNsN/LzaZeYb3+ea3pxV/oaqN7dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464101; c=relaxed/simple;
	bh=4FiEFClCVWwdrxpYTIdJTRbnrTTXkTcwQg+8Kvw3ZH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bmbQHP2HILlSoEvexruEkCQrblOIofQvR+z7F5Qk3Ynk8SA8u5lemYsldrxd0bZw3pcNXMmioLNfW/RExmZVzO2eGr+eR6uyPh58ms0vGEiiY0sU9Q2aPWRZaym1uG0oJrnvjuXftGpRBn//KhePzC1kBL5Cj4eEg9krgSTQ84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPnO8l2h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPnO8l2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751464100; x=1783000100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4FiEFClCVWwdrxpYTIdJTRbnrTTXkTcwQg+8Kvw3ZH8=;
  b=GPnO8l2hxdLLGgthGiDpPbInapm2WuEf4mlRUQEYuFNShQ3+Iulzqw9m
   wE2omd/Q63NdF9qQCGBJ9hFhXFUSx9zEGAuD0irsbKB8IPAWumzoUdg2j
   1BEmkbG73wNRKlVjxpPrkSkr+ZjKZIP40B7txnxLbdgVmWK/xrsM00z3F
   yJ0t6o4A2D9mce1KMxkb/Qv+KscHrDnh+jb7udj4vMsZ9kgqNaLxQofKb
   Ivp6PF/Acs3E+eGtEGg64Mui9SNjH3F66hkehGLoMSqs5h7ds2I4l4Qrv
   2NP5Dxe2wNYSDYVeYdbWi5GNMFpY7VISEhVKWoXRfZf4PqrCPIb6GQo+w
   g==;
X-CSE-ConnectionGUID: ki+qwOUsSbmAxKdtkdQ+lA==
X-CSE-MsgGUID: wadGtT4uQxeylwiYf7e57w==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53688460"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53688460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 06:48:19 -0700
X-CSE-ConnectionGUID: JEuLPmRXQDOJkOwYzJby6Q==
X-CSE-MsgGUID: TNHqVjXZRqK11ocqqVJvYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="185026937"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jul 2025 06:48:19 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWxou-0000gx-1p;
	Wed, 02 Jul 2025 13:48:16 +0000
Date: Wed, 2 Jul 2025 21:47:22 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/31] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202507022146.qT4xCdIc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   486689addfb4fbb1615aff8927062d7d667bed87
commit: 67b3a0e269dec23ce46b6dc921946eee8a4e267a [1/31] DO-NOT-MERGE: git markup: net
config: alpha-randconfig-r064-20250702 (https://download.01.org/0day-ci/archive/20250702/202507022146.qT4xCdIc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507022146.qT4xCdIc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507022146.qT4xCdIc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   .pylintrc: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
