Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D927F19F;
	Thu, 25 Jun 2026 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367099; cv=none; b=CRup30gk/8namP+rPnQ6kPS1BsnWK6i/olTGBDz6HunYkRahQPXFUH1A4JrjvKHScqM1+jorTacJwnjlAwqwdxS+fswrhUADV+eioX1QWogojQzbq7lur7lQ1jSRz4M9CfHiKwxXWq4WHgp/HzrJ1ZrSANJspG2PItTUdIrVMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367099; c=relaxed/simple;
	bh=6QyKUi00zDDxkSK2tE0ZFd1L1YZwCujLYana0DFnVPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nmT0KYGxkHEXulcv680AZsKkkczSTSmX7qCmBTAlMlIFN+ZHbEgTCgEalUHlsbARqyNZwtQvx/S0+1dQlZndiex1DokZQT6DIcfZ1+FRIkR11wK/NBo0V8rc6Q4nMZ9xEqn1rWpQ27Pc/S1jH9IP+1RkaxIuHrN6+lN6ifucllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbvpmEXp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbvpmEXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367098; x=1813903098;
  h=date:from:to:cc:subject:message-id;
  bh=6QyKUi00zDDxkSK2tE0ZFd1L1YZwCujLYana0DFnVPk=;
  b=gbvpmEXpZM6K7RNbK+Tab7kfCdgFHe+ut4CM7Hc9ndPsY6qFoIHA6y3n
   UpxhHnvo2ox5/U4qaNEYsr4fwEcUA6MwAron1zy/nbVHOtfNYpoX+W1Kq
   6eZmojgUWxeFs5SAhp7JPoQfnAgGtrIpej0G8AE1I4r134rJrLSzjs6TO
   B+JWfvKzyQGpbFeT+X6iSGS3S/3NhB87sF/Fsf3VT/E69sIdo4C0Xba12
   bXzgFWVgPGgercizUnU1Cujswbq4OYnEhbV/gsEk9PQqcRS1IIP4938Kr
   aD37UXh5UvOxcidm6lGLb3D6QyhmaCx2Szo1sG3p32cv44vlZmsVXTIkf
   A==;
X-CSE-ConnectionGUID: vPniIyBlTuy4ZuEmnNx+Rg==
X-CSE-MsgGUID: yOvrujJvQQGd5pgoJzsGaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="105930625"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="105930625"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:58:18 -0700
X-CSE-ConnectionGUID: 3tNElzYnQ2ONmR1Xu/uLzQ==
X-CSE-MsgGUID: lLFGfpuXQ3KEWsAHtI1hkw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2026 22:58:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcd6L-000000003wn-0Kr5;
	Thu, 25 Jun 2026 05:58:13 +0000
Date: Thu, 25 Jun 2026 13:57:59 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export-net 5/9] .github/FUNDING.yml: warning: ignored
 by one of the .gitignore files
Message-ID: <202606251307.cBec3S8W-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   ef2d32af8a0f0b9cdd6f648b2050d024a6b91bc1
commit: 6b8b386dd8e88c65dbf0209b3344d8d906ba6f3b [5/9] DO-NOT-MERGE: mptcp: add CI support
config: i386-randconfig-051-20260625 (https://download.01.org/0day-ci/archive/20260625/202606251307.cBec3S8W-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606251307.cBec3S8W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606251307.cBec3S8W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
>> .github/FUNDING.yml: warning: ignored by one of the .gitignore files
   .github/ISSUE_TEMPLATE/01-bug.yml: warning: ignored by one of the .gitignore files
   .github/ISSUE_TEMPLATE/02-feature.yml: warning: ignored by one of the .gitignore files
   .github/ISSUE_TEMPLATE/03-question.yml: warning: ignored by one of the .gitignore files
   .github/workflows/build-validation.yml: warning: ignored by one of the .gitignore files
   .github/workflows/checkpatch.yml: warning: ignored by one of the .gitignore files
   .github/workflows/notif.yml: warning: ignored by one of the .gitignore files
   .github/workflows/stable.yml: warning: ignored by one of the .gitignore files
   .github/workflows/tests.yml: warning: ignored by one of the .gitignore files
   .github/workflows/update-tg-tree.yml: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files
   tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
