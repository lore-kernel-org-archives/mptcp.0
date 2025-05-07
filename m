Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D871E49F;
	Wed,  7 May 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621112; cv=none; b=aj5w1W04jCzz80FpAqHQfoO+i8NfAFSiNihT7MO6ExCnxUrDCOX7n6cjl7lMk9segEc+kcykmCFkQORR8uAkVh3b7Pq1T5AvClFUhzyRllh4JszERfegfcJ+2mswN92LQmnt9bEEfg+ZI6twCacF/moPHkaCbYi5vTqI65hniMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621112; c=relaxed/simple;
	bh=NLFE9SxnKNFG5kSGb0TPjmIn1UVE2kGaqTs9/g3cdl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=As4BHm5j8Y8kywcFyM9LImLLdUsW+RfsWYKTXI6bQ8exNt2iXd8EMRX/aRwpVG7B2xsl1B5kOM5ElPqs7l8wkd614XGu8tgtLg4G8rPcII205OzCQXAgQnzELac5+CC/+yS0PDJAbFn6MmEwQxMCAN336uA9sljFrWjPTChNeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrnlrBV5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrnlrBV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746621111; x=1778157111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NLFE9SxnKNFG5kSGb0TPjmIn1UVE2kGaqTs9/g3cdl0=;
  b=BrnlrBV5bi9RJkcTZKSZsIYnbMGVPjF8zT5SNZVomogTETmIxeVPVRt9
   CNjqJSYOyWZgaKDS3k+2WFAFWuweDc4okmLCmBjYZkSrj//eEXLloodTc
   z/4jBZgYLoZ4gCVgNww/kblEt2e9C5k/xmSjubdbzdu4xGP1eBG0W2GLd
   4bRyGlx2oPcLZwCG5juvzxavkRmx/wJCCKjvA/qNPtppEssk2OARmuusB
   LYO7CVZ+n/HDwr9eznGaToL8aqDSlbbOYwmEtDG0JpfEz6oQru72/kF1s
   n7DkXGwbpvWLSRluGtxXcrGLs8YFZQ9TlbCDGSrhAeCg10W3VUbOQRvmC
   Q==;
X-CSE-ConnectionGUID: l8TnQ+lbSgqk1Ljkyw1uug==
X-CSE-MsgGUID: 0xMxLEf2RW69JmxAe+x3hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59336701"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="59336701"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 05:31:51 -0700
X-CSE-ConnectionGUID: k48YR6sYRsWpOqm0c6C8tw==
X-CSE-MsgGUID: 9eVR+E8VSbqK/QHnQT7Ntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136341180"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2025 05:31:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCdwB-0007mf-26;
	Wed, 07 May 2025 12:31:47 +0000
Date: Wed, 7 May 2025 20:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/33] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202505072040.0lD59gJw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   dc5a194295bd73e042f36afd454ae4febd90c04e
commit: eac743734bd56bf262f6615541d01cdf190945ac [1/33] DO-NOT-MERGE: git markup: net
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20250507/202505072040.0lD59gJw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505072040.0lD59gJw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505072040.0lD59gJw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
