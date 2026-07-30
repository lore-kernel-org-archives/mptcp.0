Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3098410D32;
	Thu, 30 Jul 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410972; cv=none; b=Gug5jFLyQUDVeZTT+UfXtMYoI1HXt1uhFIaItle+KbAy0UTUQk5XDhgUSsXstZepRFZne+80ctKcY1pgCAMN1zErbtfoGxnndJeQiS6D0DMGjPcGmDNXKAMrnYuXjSEpcY/zN6tE0JJspStK9/zEFM3fvXDtcACnfWXyoQaU5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410972; c=relaxed/simple;
	bh=eEdOnM8vidS3lKv3ibpETHjoPIJ1G1vTUD7R27smfq4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gm2jIYq0V+V+Z76yOleac/4b2vdTbGapJ/JwnqyZtmcrAcDc7WS12k+92obl62ppHJxGMch4w+SE887VH8jbYR02mxead+DFmIc8wM+jtCDswuNfs4BvcGCMrCmJRXCmsEJQ2wrOLn41XMlpqLuwYpPYhVHaxXgbvz9jk6bs/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJKZzWWZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJKZzWWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785410970; x=1816946970;
  h=date:from:to:cc:subject:message-id;
  bh=eEdOnM8vidS3lKv3ibpETHjoPIJ1G1vTUD7R27smfq4=;
  b=cJKZzWWZugLZbmBofqC+0SHBlej0z7IcBQ2v8pRPT+3LtIRraLu4izFO
   2q5I8AfNlfmUUPNIeZQQUfsye0ivmzV8CvmF3ZLRmUvJ5XqDMnUs4+vE4
   sTcqk7Y/ZNCR+BzYzZuyN5Lh6zFHGUct3V8N1aGKxMKHBI/Wm/sbSzXXD
   rxTqySC9FsrHx7iT2aM9P7vzs1dvv8wsppxMHRwJW3tHuBXUZ7mlJpQai
   kxMywfghUiS+mGNNTScjD9iuKfjx7zdC2B+owLb0ywiOQGmhG42ou1wPI
   ZBdjQTnNBXR86sbeHFmfVG0wFy+Mz5jODp3boRP98ZWuvXOBkkkGXnrN0
   Q==;
X-CSE-ConnectionGUID: 0UNgsFhMRf2KV2UsBLuryA==
X-CSE-MsgGUID: +k5KInq4QeOtW9ks/KkT6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96613609"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="96613609"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:29:23 -0700
X-CSE-ConnectionGUID: wXu57kTCRyu7e8Sb2DZY8w==
X-CSE-MsgGUID: MihNI2OYRUGYjGAXqVHD5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="253948601"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2026 04:29:22 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpOwx-00000000gU2-1Zdh;
	Thu, 30 Jul 2026 11:29:19 +0000
Date: Thu, 30 Jul 2026 19:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 9/43] .github/FUNDING.yml: warning: ignored by
 one of the .gitignore files
Message-ID: <202607301902.ifqwk8Xn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   6201be839b36e8dd22a23b9b367388ed900a257f
commit: e394d1525981d0d3459639c2e4dd84e04882ba56 [9/43] DO-NOT-MERGE: mptcp: add CI support
config: sh-randconfig-001-20260730 (https://download.01.org/0day-ci/archive/20260730/202607301902.ifqwk8Xn-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260730/202607301902.ifqwk8Xn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607301902.ifqwk8Xn-lkp@intel.com/

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
