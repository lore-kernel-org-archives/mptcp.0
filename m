Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9639DBD4;
	Thu, 17 Sep 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627019; cv=none; b=bMk8ck094TKkh2sFmWuTO6LMg31VrZ1ZZxm95T4vIC+jQjO+FfVufdIPsWNngu59E5WfgHh4Ly+aXiG3x/cPuE7wKI9CuPmHEGe2xEVFAR82ttVLWeHjqXqdmbaXrykdVLy/BP72DpOZS8TNDhrrBghOkoUIxpIc3rbWovzAlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627019; c=relaxed/simple;
	bh=a5LaIFuW2f8s0MPjP/Hzb5tdw4WQVcU4HYCzbY787sM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MNp3i3Q4vi0wCFnHrIxO/hu0LXiBm6I/p2sCiAlVNJ4XsLhTTXcko95V+OGTjQAwXCgXSQyU88NIcFRjMPFZ4Z8zGZxV/6Rpy32Pgm2V7fmCsK2nNLlVQ/RD8stpst7RB6T1iOB92BGGamwznvyYSqaHHJ/vd28gI19ag8DJXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftM3uKxv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftM3uKxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789627017; x=1821163017;
  h=date:from:to:cc:subject:message-id;
  bh=a5LaIFuW2f8s0MPjP/Hzb5tdw4WQVcU4HYCzbY787sM=;
  b=ftM3uKxvHviFnN19yO/aVw+RRhUUsoed1LGtJbH7QANPDc4HkNkZiv9Y
   LB3RPOtzxuvZK3sLAMmZ/IASyInbUDlp/iaH+FN0fy0Ty7BopxCPRU9bN
   ps+5NScJ5KJmIYsZP+TOpCVSLnuxWSi6xbJH/zjKlxnVqbrDjt1TKtbzI
   nlqH4bNVPuopNFVaIRzLJ7yZlDRpnIKpl3VjxRAAGLP2k89Diye3nHkvA
   UazbLBJrWYtFMGCRdyNSp9x6wLMw6Rh2I17X1pEmVQADL6doeqdP19S//
   sSLeZU+Ptk1TeBsgFU1we3oz8jD3YYFVglbQS0QbzJ1cQntPNGVGbko70
   A==;
X-CSE-ConnectionGUID: L4sMpvmhSSG1662pVULSCw==
X-CSE-MsgGUID: cEwxpMdLTTmoFhq+TdoWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90035781"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90035781"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:36:56 -0700
X-CSE-ConnectionGUID: f8zIXeHmT6eWV9yE7NfMKg==
X-CSE-MsgGUID: 9j4AUk7cRzq7X5vSbECaPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270960212"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2026 23:36:55 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x75jo-000000007D1-320O;
	Thu, 17 Sep 2026 06:36:52 +0000
Date: Thu, 17 Sep 2026 14:36:13 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/36] .git_markup: warning: ignored by one of
 the .gitignore files
Message-ID: <202609171408.j46d5LQG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   b95d8ec03dfcd1282c220d2fce0c8fe76ec50297
commit: 58b4911272d0ed62fc33fa1c0151afa8260e7411 [1/36] DO-NOT-MERGE: git markup: net
config: x86_64-randconfig-161-20250617 (https://download.01.org/0day-ci/archive/20260917/202609171408.j46d5LQG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171408.j46d5LQG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171408.j46d5LQG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
