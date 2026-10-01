Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B747388397;
	Thu,  1 Oct 2026 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827004; cv=none; b=ME/iEbigb19i64lw2DPshBL3fQVTTXaDjjcLs5qMkCSbIGYF9E8nWSMz7Xo/CRR3o+Opr5JfHEn/q7lUuabi++JRN8NIdeuwQMHgLeld/E2YWMfsZI9LYqXDphTQlWda8czQLKYOrp5Oki2qJ3GXx1g6BIrysRlpN2tX52SoekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827004; c=relaxed/simple;
	bh=FpR9CNaTHsqMag7X8CnTP8bn57TpES+teha2Jc9Au2s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VCZ9IOtnUDj2apog2s08TP1li+/sgoeCfzmXWW49GMpmmmVmEtJ4U2X+jGX3zd4USnuBB2U9jGkctk15XuqUnhjl7ogVLb88QuUyCB2c9IJ8T47HRwdD+a8MIRR71anS6+xKeqbOzU+alA//vQj64xRtreIxoyprI0tGqEtCYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2F8HGR5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2F8HGR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790827003; x=1822363003;
  h=date:from:to:cc:subject:message-id;
  bh=FpR9CNaTHsqMag7X8CnTP8bn57TpES+teha2Jc9Au2s=;
  b=E2F8HGR5z4jFBesOMGwKJr+YERdqfdFLXSZU1K6FAn+95OpALOKMHSE5
   GO9mqEd+wuXxJljOWZEBTF7TIeAb0mE+0573MJc3e5JPuhHdC4stLFg0s
   4zvTE2yy3TIxzThRuJbHNOlHwEynrkdp84qqoQ+/d58MCpEx8OokBp91R
   H5R8YyOqS25xzm3mpYe1u5i2962w5XIaz0LMBmvlPiWEY/4WAw3JC+Lpk
   A0NzIdmKgMFml2rweTaI+HEKE5oYaJhEStSaUdahX3pQ+JqEQzYpy+kIE
   yrm68t4IjXgp22gpfCV/lIwuXG1PtR8KCs+JAiSl2K7ktWVNo6WfvBB6e
   Q==;
X-CSE-ConnectionGUID: JdTG6atGQCK7fSntdc7V0w==
X-CSE-MsgGUID: YXaWiZtYTZCCN/hh18ySTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90527809"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90527809"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:56:42 -0700
X-CSE-ConnectionGUID: /a52rLdPSAeu3AhdQL6lmg==
X-CSE-MsgGUID: VbEppMFXTe+LMaOlrrikTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="280626444"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2026 20:56:40 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xC7uP-00000000RTd-3hk2;
	Thu, 01 Oct 2026 03:56:37 +0000
Date: Thu, 01 Oct 2026 11:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 4/36] .github/FUNDING.yml: warning: ignored by
 one of the .gitignore files
Message-ID: <202610011149.ei434yaS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   49cd94a5b6d8f4f7831051dbb30ed1e2bdd077c0
commit: e8797d07ebb31b7b15411ae72f479f794d09c370 [4/36] DO-NOT-MERGE: mptcp: add CI support
config: nios2-randconfig-1000-20261001 (https://download.01.org/0day-ci/archive/20261001/202610011149.ei434yaS-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261001/202610011149.ei434yaS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610011149.ei434yaS-lkp@intel.com/

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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
