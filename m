Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAE64A8F;
	Fri, 21 Mar 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570632; cv=none; b=oZZ3wmJ+22gDBm96EeDziEJsXoaB6E/J/QFsb3uMlLYnLfHOSm9FdEq0ytj/4iurW0ptvQscZpLUmVSmpWMwXtK5GfwY8pogt+KOEMfG1R//BBQNeCnzPuq43lfqhjNdSdagH5Fxg21FAcUCA3QqFKEPqwjkHDj9OLX8RkFUfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570632; c=relaxed/simple;
	bh=gSY/v7fIx+uQCvTliv3InCbQJCb4tGZLLFUqBbEqbCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+cF5zYU3rtbgRlbO76/p6+2RzAwzjE1H6p9ly4QdpXbhlKxcgBlDIuZQFTTKM9rPSGjClqkeYXpJn9Ia90v1g5s8wbCjtdtW+G6HBDG4rpoB9WUfiwuYBk9kXYZ2xFiKuEvLuI8Zb/z4iGconWro1nJ6MPoUuyT4vyrkD7K7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfWDeGtL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfWDeGtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742570631; x=1774106631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gSY/v7fIx+uQCvTliv3InCbQJCb4tGZLLFUqBbEqbCE=;
  b=nfWDeGtLNhA8V4lw/CPEb4DC6VqsBA5r7CWvDXhVXnqn5+YVYPGgmBYP
   7jI8iPtL10urZAmktmxI87diR0y9y1pIcGTNDs9+ZMpuglftMW1/X4KCW
   ozGlfoYTXzkcIv8lad6Viu3z3sagzPSFf//Ss1DEqKag5t1fwJCtt8brr
   JIS5A2fDF6UwqonvCKA7Z9v+ecR52TmN6DnYxy3NEbo09M8eEBVHeeONz
   o7B3MLKFQOaDqr24Al948ji5lx3hcRkFsd+GfFtn5IQAzFi8G6zBmbC6M
   hLavV4TUTV5zT8AJBmbMjeNZD6R0jIsO7Krx+11T311410WwSTa0AIZsk
   Q==;
X-CSE-ConnectionGUID: 9wGI39KsSPyeXZdc8eLzgQ==
X-CSE-MsgGUID: 4LETgrL/RlShmfydwNH7LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="31430988"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="31430988"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:23:50 -0700
X-CSE-ConnectionGUID: op9qABE4ScG5FLBUwmgXuQ==
X-CSE-MsgGUID: ZO53u2+JSIGdPNTz1xpZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123605606"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Mar 2025 08:23:49 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tveDd-0001Qr-2G;
	Fri, 21 Mar 2025 15:23:39 +0000
Date: Fri, 21 Mar 2025 23:21:44 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/13] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202503212325.30k85D5v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   bf999aa8665428659ae2cd6f6a5fe0fa577772f0
commit: 14a377a16c65faa3f5dda2a83686c05fa7065d7c [1/13] DO-NOT-MERGE: git markup: net
config: x86_64-buildonly-randconfig-005-20250321 (https://download.01.org/0day-ci/archive/20250321/202503212325.30k85D5v-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503212325.30k85D5v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503212325.30k85D5v-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
