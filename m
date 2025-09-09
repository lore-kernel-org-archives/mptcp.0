Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33522CBD9;
	Tue,  9 Sep 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426656; cv=none; b=RtvlGG07oZQAYRtz77jDYK3ypIblQwqVxQWd5Lk20rJ+0NLYCUYz4H85tkMbUg8SVuyDVMtuDdRTgyNza5rPFmESxBxr2BIf1Rj5cZl67z2eHN0bei+UslH9bw0bg2HeHQD9wo4F7WrOkSlDp3fgyYHgH34RefJCRPBiNXTDrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426656; c=relaxed/simple;
	bh=bHE6tkhyuFOU4Er3uXFFGJEiL3T/RozdMiR0OMaLsJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FTgljDeotQcT/HhgNJQvrQhScij14RR3SrieBgLSgVn4YUFNawKaQ/dNIfhJitPuwuFdF3XoB4dJW7v4QwAEiCBdgc18G0Uic9XvzHA2WZsY36OeZGWgnBm3FjYG7Cdlv48ErRHbonTinKsXz5tZ5mcalhJPRbtkckabCwRWo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUZQjaEt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUZQjaEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757426655; x=1788962655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bHE6tkhyuFOU4Er3uXFFGJEiL3T/RozdMiR0OMaLsJ8=;
  b=jUZQjaEtBi/ZevpKTUQ+b3BOmw/kuavHtBBXyiHuKPTMVehCro0slDnQ
   0iiQ6GvxxQikksIpcCco3PJgSwXBt14c2rYgnRjy2CsyDP5WeMA0iais3
   9kb7t5H055Y5aMvUSMlrNnighrYRBuydWw+pKTQyWkPfvr9/6Uxgv5NfW
   BxKZg/EtBJWAen5ykXhZrfqB4XOT2sEJphEwW3GxI1WvJtTaBTEnIJG+/
   eZsY1ZwrK5vcGcQPd1hm8Kpk6q7LEFUjC5zomDEHNHXF7Xtm/XoIb5+vM
   v4yXhxcs7a4zKXhi+SbngUzEC/irnuWTiAlzlKKX809JiSkblU/TwrlY2
   Q==;
X-CSE-ConnectionGUID: KhY89LSWT1CTGkvA6GBOGg==
X-CSE-MsgGUID: ErN6IDXwTn+TwNoJSuQTzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59661675"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59661675"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 07:04:09 -0700
X-CSE-ConnectionGUID: qH78s8DGQrinxnjbmXX5jQ==
X-CSE-MsgGUID: feZHev2wSuizhO+3NpUhog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="203865569"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2025 07:04:08 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvyx3-0004vp-1g;
	Tue, 09 Sep 2025 14:04:05 +0000
Date: Tue, 9 Sep 2025 22:03:38 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 2/9] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202509092140.B2VtiCnC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   001322eb512dfb2de4444190c10e82cf2f328d87
commit: b0f2b972f6eeb989a7118b49bd45f0d52f962218 [2/9] DO-NOT-MERGE: git markup: net
config: i386-randconfig-r113-20250909 (https://download.01.org/0day-ci/archive/20250909/202509092140.B2VtiCnC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509092140.B2VtiCnC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509092140.B2VtiCnC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
