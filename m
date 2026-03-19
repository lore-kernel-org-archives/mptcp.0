Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59366224FA;
	Thu, 19 Mar 2026 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897571; cv=none; b=GncusuMSY2Dq5XxSp/gpJ1Cl//YDyK7kIo+iMfZ63B2hc1HyiWFBkCWh1odVamwB2Yw5/40aaDVUTSyGayyVf71yVCvEitZezOJAA4v/3+fuvgSvogmPgKgiBUrwrwhQFPAde38lnBz4EmoMhv1W3EcL8CKUXf1NV6shaHBNWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897571; c=relaxed/simple;
	bh=fqrk+J1bchXiXZ3Tk6s0FwYVQVZ3bUlDft1jeci4hAI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QizoBxVVjNOALwZu0j68IxISRDgdNXEG2IvF9S3awR9mTlywWxnu7IcXmz/wfKi1GjSGZP2UNpa4gg/5n5Q9UAruGH0Z2oV4RKr1iaRoQH/GRCF7j261hXVRLl92Vjk326paNCwRsON2659QpaTYhxS225n5vKjSe/H2HOkt1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9GN2tpa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9GN2tpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773897570; x=1805433570;
  h=date:from:to:cc:subject:message-id;
  bh=fqrk+J1bchXiXZ3Tk6s0FwYVQVZ3bUlDft1jeci4hAI=;
  b=Q9GN2tpaya1xhV4dWqvuzptJWEg8nKxizAwIxuBBqxUYhgGPbousFCke
   jb3E4CLr/Ffg8HBMTMOJybnp5ljn8U1/OV1+nWJkpEYtSxoHMTVF+pGHu
   u8oW6zUQq2xpkQoQCLwfOtOqHxHF8kcQK551TQO6ntxQVyTKliwZRHtTq
   KyLJzjsZVXk01nqVYAms+hKQht4O8q3oGTmGNB+L3yfhHvbF3MO4ds5ID
   xvl8qA+jEMXHgVO0pWCDKsVynqQ9915UaI7Y+sByHIs+nXepUAkpBPigF
   yIFPgrY/Hxr9uxc1chNCBF0xYpyPBsP1ZhhaTpOptPy6QV1ZYB8eQ84cX
   w==;
X-CSE-ConnectionGUID: f1GYkzbETzSQFDL1WU+lYg==
X-CSE-MsgGUID: WkxcrdRMREaZ4gUZhHj7dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74996186"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74996186"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 22:19:29 -0700
X-CSE-ConnectionGUID: Wm5kgMtXQJqeEr5zZfq3zg==
X-CSE-MsgGUID: JtDEZPnCSI2Yzq4IsjcvVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227551713"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2026 22:19:27 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w35n2-000000000M9-45HT;
	Thu, 19 Mar 2026 05:19:24 +0000
Date: Thu, 19 Mar 2026 13:18:25 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 8/35] .github/FUNDING.yml: warning: ignored by
 one of the .gitignore files
Message-ID: <202603191329.KS8U2YCt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   629fe2e3f4b604d4cd1a5af45882b00881d474f3
commit: 12e0f43d481c66ba35b332f9841451a1a658517a [8/35] DO-NOT-MERGE: mptcp: add CI support
config: loongarch-randconfig-r132-20260318 (https://download.01.org/0day-ci/archive/20260319/202603191329.KS8U2YCt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603191329.KS8U2YCt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603191329.KS8U2YCt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
>> .github/FUNDING.yml: warning: ignored by one of the .gitignore files
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
