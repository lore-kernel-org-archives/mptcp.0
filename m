Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DB2BE65B;
	Tue,  2 Jun 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363275; cv=none; b=Y3tLUxplnuNw+PdX0VfiEF6fr2NTl4khcOdxWN7e8/Mm/QotNthvk8YEZp2iEs9594GUmtTxDQyl76Z7aPS8R3QynX/XR9D6v5S5tm9QxYCmiMqNfovYvRggwfN/gWNnMn37bJbrhJ5GvAxd4RvR8Zl2Qxhr0VV5745jMqWo4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363275; c=relaxed/simple;
	bh=gF6aTJL5+y8d5dM91/YlWgZF8Xca3C3R+i3O4IC1xIo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cQsc56V0u6pEXQcDqfqj3z4GEH9CROtWWxlSkTWQdYapT7z2q/ztupNr9TmFNxdhIavVpxL2bczq9OAnPtA6DfwnKPMijPmch4+fQ4gpBoYixyffsaZs3Wdhks6ivUYYSKQJoQEqzvTa89F77Y4qTnIoKOmNZSl2s+rfyAfrXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoYISo70; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoYISo70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780363274; x=1811899274;
  h=date:from:to:cc:subject:message-id;
  bh=gF6aTJL5+y8d5dM91/YlWgZF8Xca3C3R+i3O4IC1xIo=;
  b=LoYISo70HjlnRtDQWRVwiVvj+Fn0yKxRpeHNC08VnURoCihOp5drGGOR
   AYiIidUormDSfmaJIiHn51TyV6PmUsNmdoMto55lD/iw7TyjcBIV48qAd
   8x8vMqVgo64DkU0B24s8POCtalFVzd73b+fC29ekiRoyBlaqf3ZkW0BJP
   Ft/vhEWOyJMXRh1aLvOHoZE60RZnZCHXzrT6JYMLodFQmfguIEZj+oaJD
   QPQQ23CVjlCmUsZL6ZG/KW007uOG9DLjvhSHvPhlbBJihkEpn82oxh6mZ
   euVPOGppULQTF2U4QoniCiz44LbNzMu71pidQ77lLPVDX8nlTiDLqv1UU
   g==;
X-CSE-ConnectionGUID: W6/V61inTwGSy/tZrkI4jA==
X-CSE-MsgGUID: 1He5lyWORq+acaMDWDGe2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81244076"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81244076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 18:21:13 -0700
X-CSE-ConnectionGUID: hwazt7TxQ4y+Qv/qul+CkA==
X-CSE-MsgGUID: yIWHbSdBRcG7a8zYbM7zJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248663905"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Jun 2026 18:21:12 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUDob-00000000BJi-1gF1;
	Tue, 02 Jun 2026 01:21:09 +0000
Date: Tue, 02 Jun 2026 09:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 15/60] .github/ISSUE_TEMPLATE/01-bug.yml:
 warning: ignored by one of the .gitignore files
Message-ID: <202606020937.xZNUCUMs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   e05cbdb611ff815528cdf90e29a96663b9af48c6
commit: 5969300829e7560c720d15ea6f18f0e36eef8fd9 [15/60] DO-NOT-MERGE: mptcp: add CI support
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20260602/202606020937.xZNUCUMs-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606020937.xZNUCUMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606020937.xZNUCUMs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   .github/FUNDING.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/01-bug.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/02-feature.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/03-question.yml: warning: ignored by one of the .gitignore files
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
