Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705863C73F8;
	Fri, 10 Apr 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823820; cv=none; b=c886YNDtakYyifUe//k20f1+/zRbHLIM3GOR4zqLjitDKxGz098dD9Th3vHWEaPpweZG3FzVZejF2bHFanGQACy8KXOuW8av+z49y0C4rOQ9DP5Gn7Q/I+gcpbeTygEPgvNNMUsXA47Ru0WcPbBDzghLcM8ddAfGSbg3F+ddJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823820; c=relaxed/simple;
	bh=iIxRPLPBvFWLpD25+SKalR/P6tHK+MH+eYz2ibDdhUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eZonqQHSCpXtX5qBteFZO5BuK7GiR/XM6spBp6DixpYpawjXz5ddZeBWFxVF3mIrh09/VvnGFNpq0JlYgvXbNZZR4C7tW2lKV2atBqoEFe2dvky6UWyNLKugqXYe0Au6WYcoOhY26J4YpNfQUkI0dlnJFWKvAHmEuCE4Wi8ALyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEvR3YIK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEvR3YIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775823818; x=1807359818;
  h=date:from:to:cc:subject:message-id;
  bh=iIxRPLPBvFWLpD25+SKalR/P6tHK+MH+eYz2ibDdhUk=;
  b=WEvR3YIKDinuQhSvHytTKGiz/RnJ8mPZ3s7eix0XbC9qcbqNNR6+WPDs
   VAEAzXP7vJrc29utkSQ9tZ9buIfDpv2U2VGctzPSkYz44XLO5YBjYiE9u
   F5pJImR/zZGSu8/MEhR7xTLtfkljV8Hlm2ImTNHIaDtJnsvwIy5DXeXQg
   y3Yb1BSL2JCcVPOXMgiQBvT2HcDCMkL0geCOBs22l73js2eMdKWJ8+SKN
   R/v3PBuWwOms2aFEZ3XPhamo2hG6wmNeXTn8039TufH4rR5BGr73IBvM4
   Ovb3lYNtoXQgsFcjqUqa5FLjzQDcrafaEIremHTkceydcnsn10IgYzqer
   Q==;
X-CSE-ConnectionGUID: 1c86j1dyRxKaGWbVhQvacg==
X-CSE-MsgGUID: JuBxitO/RWSWAuIvLCb8wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="94235173"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="94235173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 05:23:38 -0700
X-CSE-ConnectionGUID: m9a/Iwc/RhesWslbwLfItw==
X-CSE-MsgGUID: PBcVDlSmTs63CwRhTy+i2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="224328695"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Apr 2026 05:23:36 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBAta-000000003ir-0W89;
	Fri, 10 Apr 2026 12:23:34 +0000
Date: Fri, 10 Apr 2026 20:22:36 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/10] .b4-config: warning: ignored by one
 of the .gitignore files
Message-ID: <202604102025.D4dPgief-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   323758aa61504449b3abc7d2adeddfcd62b2a56e
commit: 8705d5d473b289fab5a0af20cba9660ca4c6414a [1/10] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260410/202604102025.D4dPgief-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260410/202604102025.D4dPgief-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604102025.D4dPgief-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
