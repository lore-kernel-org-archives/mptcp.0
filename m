Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50240E8D7;
	Fri, 10 Jul 2026 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680304; cv=none; b=fCrFhUDPYIjodB1bHwqpDFdgAvC0up4mAEV8m2ptqp1bwx+CRpOFZ81ZsqNrRqz2fUIJ1YOeDZ+ymtQHjBXnFwKLqZK94VXuaDQEG1uLLepXeeO9SrxJAcP/aT4C5VU8FSJoGF8fiaz28O6KL4QJY7P2oLCvaONSHSfkHkhf6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680304; c=relaxed/simple;
	bh=M0vBDe/Z7FPk2SqGyiiYUv/LFkMVjg8b2gx3nrSIL8c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rleC8HPXkhMrXffjLawZ2rhEiO8ohBJuaFuDRvxCqgilHsWyqp+7PFDV/KJ3L1GiSgp70R3aPYxvzc3thMmKUS8IpPLT7figsl6U6ZRfIZ1IyC6QRxf7/mSCC3vPzA02HCtSbr0HhM4qG+rGLaFDZmn4WU0eBFfgWNUXsWp+Xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIjuxdfQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIjuxdfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783680300; x=1815216300;
  h=date:from:to:cc:subject:message-id;
  bh=M0vBDe/Z7FPk2SqGyiiYUv/LFkMVjg8b2gx3nrSIL8c=;
  b=EIjuxdfQvwrOojAdCXQhotkYz5xzecmNXUqvj3WGt+v8KYVJ0fVuF/jE
   eMoCUpy4GnS9/ht6DhKeFy2f0bdMU8pOAxC02cZpmwpAEEf5FWrFK8cHX
   wT92TvpQVHUpJ3GVlYRCTbE1UXVOZlO5sZUDcDgXhyuSL+Pd2fQcqdTDv
   B+fXABwUeB4I9NuIA1yFeULh04DIS5YlF28H1DWvOLeOv7U9vCwHK7fby
   a+KWmGG/+rLN9XiAmySPOX2QFbVoFLmuFRFmw1le5GOg+pSUMj7SSPln3
   N87MlToJRu0P3p28PWgoPeT1kwh2dnl8T0+DDr7jNTOeHKtyAhd9yDmge
   g==;
X-CSE-ConnectionGUID: 7Jm9NripTpO2xOtRnYurMw==
X-CSE-MsgGUID: WDbpVMrzRpaiaoZ5CunKYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101926273"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101926273"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:44:59 -0700
X-CSE-ConnectionGUID: mmt4fN/WTWq0w0qrE0hm/Q==
X-CSE-MsgGUID: oDKJ+9wnTzSHityJ9tJ8ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251493384"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jul 2026 03:44:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wi8it-00000000IqR-0KJo;
	Fri, 10 Jul 2026 10:44:54 +0000
Date: Fri, 10 Jul 2026 18:43:47 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/9] .git_markup: warning: ignored by one
 of the .gitignore files
Message-ID: <202607101825.DOTq2aSj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   8a5c23d533d1691aadfed5c6324c68228ba7f24b
commit: 3c2361df3fc86c250e581b7026b3b1277a29edbd [1/9] DO-NOT-MERGE: git markup: net
config: sparc64-randconfig-002-20260708 (https://download.01.org/0day-ci/archive/20260710/202607101825.DOTq2aSj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607101825.DOTq2aSj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607101825.DOTq2aSj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
