Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BB17BB21;
	Sat, 18 Jul 2026 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336163; cv=none; b=Fo6D6axSvzyFjtA5//NVorqbZKMcNi8AWXpYcYyHV/lm2Iwp8uI1G7BoOrnqt/HfeI9wbUO6UlaQtH/HZPgP8LM5Lwhe8uBEWUzZzlVtPSaFYjcwIn3SI2KzK+f3UeRq96R3+eNEqhq/Z8gqdLaenxsz/FxtOUawMWpDpeiHEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336163; c=relaxed/simple;
	bh=vT9MbTKQRlnwmzDr+vnDan2i2rF66/2hk5BADSPu+6w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vz7huCNbjOmkvqUuS1rIA6DU2gHCqdNz2GgGoqFatbKp+0JL91WJAJLT+MMrR8kQMKIoqSEJK7upjRebzkF8FWw29rN1/8ACn/+ugwzfUIhbjZF6nKmewhj8eDlC9OKIKwRDvQ+CwcDM74YnswJ3aGL1rySi5wqo31cUSDM6Xlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge/SXRZH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge/SXRZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784336162; x=1815872162;
  h=date:from:to:cc:subject:message-id;
  bh=vT9MbTKQRlnwmzDr+vnDan2i2rF66/2hk5BADSPu+6w=;
  b=Ge/SXRZH2AOZOzBpnL39Lo75tRyUAka9x8H23EbkcYCafJyzErMMYAzZ
   jzseBjU7Y3cgMqOUqYt8gqna8LhMweF/GDrOrBNf5ckWMkv57b410VO5u
   AP86fgcs0ysE40skFCPTOGnj8DJRemA5TbRw6Md7wUk29FgajqerhS4MX
   JbJ8WblUq2SN9YIMifKGSg3kewTIWWeZ/3Uwt25xE5lfdDfWq5LAl19Ff
   vLP6Q9/gsRJWt4OQCmmbwMVSpgj1TZLlskF9vZqfmQXuNNwHagilxfvE+
   gN8ry0Y3lrbVbPqNQaYAVXdOnmMhIKW1Nm0GgYhxQQdIXVHX+Jx9qC5He
   A==;
X-CSE-ConnectionGUID: icq4nVwISt+Gf+zVZaRqdQ==
X-CSE-MsgGUID: jTg/4xVOSV2wYaLToU+qEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95365149"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95365149"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 17:56:02 -0700
X-CSE-ConnectionGUID: qO/g0eQtTV6i+wOsDgvUeQ==
X-CSE-MsgGUID: ttRUlM3oS5utMF+vUdMxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="260491103"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 Jul 2026 17:56:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wktLN-00000000TKg-0Zpc;
	Sat, 18 Jul 2026 00:55:54 +0000
Date: Sat, 18 Jul 2026 08:54:56 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/40] .b4-config: warning: ignored by one of
 the .gitignore files
Message-ID: <202607180852.tbYCgjZi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   d588274319ae0495cf81d0f8793aff72faab6914
commit: 2426143e89ea7b4900ad9a07ecd7fee2cb3781e6 [1/40] DO-NOT-MERGE: git markup: net
config: i386-randconfig-141-20260604 (https://download.01.org/0day-ci/archive/20260718/202607180852.tbYCgjZi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260718/202607180852.tbYCgjZi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607180852.tbYCgjZi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
