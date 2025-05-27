Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6A1DFCE;
	Tue, 27 May 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353642; cv=none; b=GoZEO+9mkdaJmavQaTWcd6boYFUV+s5ZYYIkVUexZecSFy1aNvjArjYFvKoH9hBmcn+MKjMpmdBV5sntZ0unSas+N4FmZ5diAHmo84uS8b9DG20m+xEqghL+GN8V1gPZjwwGrnkk7x1DsgAdiBPWRI0F43IPeiBZoeRXcnsDxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353642; c=relaxed/simple;
	bh=3D8gnlRUJX1FTMB8pcsafYtb1rfWz5/JWe48rMHiNCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYMYMf+93/ypZcqKs/WlOYDyTTj6PBEsZSIsCXp3GSYb4lhETknd2XFnpMM4w6h+Tn+6pNiRdcquUm4qWAw6p1DW8hhvA83I+G5HKItmnvptLAMSACLg2ap89KpxKHYi371t0+vRDDOi+vM5NwU07xs+2J68OGCp+ew3Tt3ZY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei0HwAeg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei0HwAeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748353641; x=1779889641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3D8gnlRUJX1FTMB8pcsafYtb1rfWz5/JWe48rMHiNCo=;
  b=Ei0HwAegrKcQfW3fURBg3aaBicZcaxJRvn+WuR2Lh7jv4wdbRqoljiS7
   KCHl/XX55Cus5wfa3Px0cnjpOpa0xe3gRRzTGDh8dHvogCRxUgUwTszPD
   /KcDdtGoX1Elh6g0wQ93LxeI5BXFnfeyeSDsRwLwpNTLbej1c95pcso75
   Tu206TusABxJsvQEfVEKIjy2dVHJUF1dBAPc6IryFrEnrQpVsWEcKr3KQ
   ZeuwA9LyQsDkScPI1q3zQYHt0JAqe9G/2mAslpso+HOdUa7IKstrweVm6
   5stIPmIHwLizg5TFOt5eJRjPgH42V/jG+qgbBcKnLtHFUO3bhGyYcWI68
   A==;
X-CSE-ConnectionGUID: 97wjxZ75SY6FKXMCjqFHOA==
X-CSE-MsgGUID: ctXuz8MDTz+cp5eYESes5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50267481"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="50267481"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 06:47:20 -0700
X-CSE-ConnectionGUID: f/6XBVbMQ3i8Wp/soM8wwA==
X-CSE-MsgGUID: 61iXXSLgRl+xMzKw32ecjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="166013983"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 May 2025 06:47:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJueD-000TFI-0A;
	Tue, 27 May 2025 13:47:17 +0000
Date: Tue, 27 May 2025 21:46:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/32] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202505272137.3RWXp38i-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   23985141960272bf4e576b4714606bff35ca355e
commit: 06cc59950c83150cea24a92793c6717e7fc32b1c [1/32] DO-NOT-MERGE: git markup: net
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20250527/202505272137.3RWXp38i-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505272137.3RWXp38i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505272137.3RWXp38i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
