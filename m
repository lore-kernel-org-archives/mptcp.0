Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF2426EAB;
	Mon, 11 May 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518304; cv=none; b=UQl369QD9Qjr59tjm6E32ZkOf+sAl15tSGfF6cdxRlen6Cq6xDuNLE1EHs0as8qOW/RWycGNdIezi7Ks+LcSPDukhydh8TMxdQ/qcN/P4HeravnkbExTq6sTV5f2RzZg6WvkFC5wIMOty++PitYgyVWQUbthfzEispjng6FIn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518304; c=relaxed/simple;
	bh=zoSWnkqdd8MFJy0pV9VkPobwqV6Frbu3b0beuGHDFiY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A9uuOEWCwynjbocuuojqezXwLRww4tiuOpBbDu19xIALkGK8/W879LwrLEKeGRe69BjI2qZy8a9jHNEPl15KzdQGxxfjMh4xY3usJJp7dLDPaAm87yv0GplJX9SzD6ny8bAnDna0QhirgC9iIHHh2Q3iwyoq+pqp0bEOgp9EP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjL80qn2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjL80qn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778518303; x=1810054303;
  h=date:from:to:cc:subject:message-id;
  bh=zoSWnkqdd8MFJy0pV9VkPobwqV6Frbu3b0beuGHDFiY=;
  b=FjL80qn2E/VuTRIbRtSXE//NCe/fcx1g42be2i//AvtVXwrqkFjCvogx
   CRkSACSq/PrN833EoboQ/saGx6ohsgcGfXlQLC6YXr97dnPNzu8rnde3m
   MH8cCx5F1Em0Dznk8LyKh+VGITMz/0w7fxQdSXhCKrhSnmRY8B7A9vmB8
   xaJiVtyZIsJMXvC+sFyW4PwKWIiwE7LSlF4DA+Dyf4dekSTLh9N0MPJvh
   2ltNeS1wKrUZCoiDfZwL7dHQJXKnchuIZGYxLlFZ9I6LMdJHV2YgYYM3e
   ZjQWVsW7+whSW/djSfhN7LcVUiJ8+jr1tiAhI2mScrqQMIvL5p7kh45md
   g==;
X-CSE-ConnectionGUID: OW3PciV7QpO2s85wDmXS8A==
X-CSE-MsgGUID: 5ep/OFaURgGlN/CvfR0bhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90878767"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90878767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:51:42 -0700
X-CSE-ConnectionGUID: Mnd7uEURRWe8wXg67VC/mQ==
X-CSE-MsgGUID: XOe+Rg3aT+CyFcMtoeaihA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="231114404"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 May 2026 09:51:40 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMTr0-000000000sR-1deg;
	Mon, 11 May 2026 16:51:38 +0000
Date: Tue, 12 May 2026 00:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev
Subject: [mptcp:export 1/39] .b4-config: warning: ignored by one of
 the .gitignore files
Message-ID: <202605120017.W42dqjAR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   52f68f13d42a1c3752de7a776b6f873988f48401
commit: bffcdf4fc40a5044eb209e41eb662738fde65fa7 [1/39] DO-NOT-MERGE: git markup: net
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260512/202605120017.W42dqjAR-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605120017.W42dqjAR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605120017.W42dqjAR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
