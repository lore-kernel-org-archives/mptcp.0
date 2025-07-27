Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C72A93D;
	Sun, 27 Jul 2025 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753580002; cv=none; b=LLoTTYRLttpxv5+RnMAnrWBASKb+6zfuKkphMLFkpPlBje8B9swnQIdWcX9oNPP0fiRwuNQIRDIwNpV+8ruExO4rlL29UvPl/prtRkCNAAlOG1ZHK668SGoam8JNdMh02hYZPvjnV/y4REfWiadgJ2Dm+trkS5p6laXfK9ypReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753580002; c=relaxed/simple;
	bh=LnavfsiKvc0K6J6LYnCbT6CfE32vRSPzSy7rfXDoZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bB+CZfltJqHnMTqGqJMKVITFATRTnZOR6jF/RRJDNwDEkVOVnFcPlqcRPnUGsXE3tCcKoUfJVecfO+3CVxfXHxb7YjX8Z6W12S5xiW7JufrDazQXGFhAm4oWvoqLdd6Lmmlu7p2ES4kDnnMyV20zRIV9/2D3DBbjrqDILz3MvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgpOGkx0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgpOGkx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753580000; x=1785116000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LnavfsiKvc0K6J6LYnCbT6CfE32vRSPzSy7rfXDoZAM=;
  b=UgpOGkx0mSxqEiq+CdOck7HQhp2aihH82WvJPIO1RNyYvPWYM0wYGQaT
   ag91x5R7qXRj25urOASpNwqcgbRawI7BA/IYP6oYccR+QS/GZMeBNWlYf
   9ebDdWSRYy1XEQNXSS0ytESrdMDOplpVsuim9HBoBLNZ9dLp9/IXiiKDw
   jCjO59hyfCL1qMHYnRR2dfXT6jbabcQB0KkaAGbarqeAKCU6hpthLIQOL
   sox+EEzz5yBBwjUqXGOZ2Sm06832D45bxnNs55ucPfu+SggyyIhHrILvX
   1i3qrD0ryxAviZenkBLnXmZQvWx5Ux8T0p7o+BirCmjfSWYDxrAuvpgWG
   A==;
X-CSE-ConnectionGUID: r3UL2vSQTuStSqfKUOsU1g==
X-CSE-MsgGUID: VUK5NynnQ4eoR58r3vLkUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="81315570"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81315570"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 18:33:20 -0700
X-CSE-ConnectionGUID: 3AoAqiSDReyW6tu+U3E/Dw==
X-CSE-MsgGUID: vmZhkIyYQbODgbNg2cLVxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192768209"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa002.jf.intel.com with ESMTP; 26 Jul 2025 18:33:20 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufqGK-0000Lz-1n;
	Sun, 27 Jul 2025 01:33:16 +0000
Date: Sun, 27 Jul 2025 03:32:21 +0200
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/31] .git_markup: warning: ignored by one of the
 .gitignore files
Message-ID: <202507270300.BplIN5np-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   55891ea8c6ab978cded765923b2576362c4ade6d
commit: 4867d82b9760191c4f7aa852b5242ea2d7b740b2 [1/31] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20250727/202507270300.BplIN5np-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270300.BplIN5np-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270300.BplIN5np-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   .pylintrc: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
