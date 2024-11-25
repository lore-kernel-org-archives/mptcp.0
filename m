Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAC1BBBD4;
	Mon, 25 Nov 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564812; cv=none; b=V59NjaALIhShZ9a8Iyw/a3UQuRf+e/Y2MpF2M7TW/hID2K1QgayzYU+ViXTRtXzq/wIJseCixFqQRtyiHdQ3GW9xmKL2oYuyvhzbmL4YcQBah+Cx1nrVqnqqRPyaRNNHaGLnAPmPI/HChvbDGX+zppVOwCOyHYoU0k0R0rxLDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564812; c=relaxed/simple;
	bh=N5w51BT33syzCvPKds+4HYxzFvxvMfunxNBVpslPy24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gRzTibT+08R/vzQztnnNBTYsAvsZAz6hdxilBY3prXDFpJQN3ovieQdPNHncf+bqpGYstYVsapyKomZJ8RRaOvD1TkQpwwWt+n81mctfskpTfQmkRbngk05TSDaIVYaKQxFd/MAlStkhId83hCUXh6LHCWhKy9vFkhErIzAV68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi7C3Gcm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi7C3Gcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732564810; x=1764100810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N5w51BT33syzCvPKds+4HYxzFvxvMfunxNBVpslPy24=;
  b=Bi7C3GcmYol8Qh455CfIq/cvLiRw0jLdEurEZDoyKJVTCfbtEzrvdm+V
   6a8qVNRxaxWjvp9VueVlkCnCNqzlHmBO8LD8CYZfiVPEWTaPsFUR5G5Dw
   /asD9UL8p7R6/D9gUNnvx0VSliNheVVlROD+RdnGe3Hy5Qm5K1JW9a5/y
   YSnTwcnca6zeY4Nfbm9UsZbD/kL89C+mIqFeWf8njgQJI4T6MXNcL1tSv
   X+lkvDwRpu73SnoxFWx4EagIC8xtGzUk/4cNvBBhVraw7nIuMj9e+pOSf
   V5xjUEUrPRIYJA3zbea2bXke3gS7ExI2mNV2VmEPGRg2ZjLZnnnMfkmIG
   w==;
X-CSE-ConnectionGUID: TeRX8KHKTu6XAE8UGS6ZfQ==
X-CSE-MsgGUID: AcSbx80mRGmOHwToMaV1VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="58103552"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="58103552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:00:08 -0800
X-CSE-ConnectionGUID: BMJikntxQI67YIwYTq+miQ==
X-CSE-MsgGUID: 8aJgUreOSjCxro97AMQ3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="122233362"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Nov 2024 12:00:07 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFfFb-0006km-2W;
	Mon, 25 Nov 2024 20:00:03 +0000
Date: Tue, 26 Nov 2024 03:59:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mptcp@lists.linux.dev, matthieu.baerts@tessares.net
Subject: [mptcp:export-net 4/8] .github/ISSUE_TEMPLATE/01-bug.yml: warning:
 ignored by one of the .gitignore files
Message-ID: <202411260324.B29iWmwj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   a901f3057f733a28f0816c46617979e828f2a717
commit: 665011912bfbc690f923de3dc1ef3f17b9bf2d06 [4/8] DO-NOT-MERGE: mptcp: add CI support
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241126/202411260324.B29iWmwj-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411260324.B29iWmwj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260324.B29iWmwj-lkp@intel.com/

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
   .github/workflows/tests.yml: warning: ignored by one of the .gitignore files
   .github/workflows/update-tg-tree.yml: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
