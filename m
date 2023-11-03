Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984A2376D;
	Fri,  3 Nov 2023 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlW8MvQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699053133; x=1730589133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lU6IU+X/GtyMmN9xF8zfEW3ETMBzyLIui0hBPtRwIRg=;
  b=IlW8MvQYRRw0MXfN03O+1BIY2SmaZ9kVNV7ctIev0lpZO8aMIE53xRu0
   gRqVMzByGZjos7a4tyLJRes6blwSN7ZhC6byialxVf2LSygIKWf/t2y/y
   2qwa5QX857KAWSlTtdz4PGC9wgyMAs301Ezc5fU31HBEZHWcg/OlAUs+A
   APjFPaSWHG+7XFdA7pdEiZLF77F9dtxrpBjpxCn20L7MvPLb0N7CoDY91
   29XpG8evzmeTePFbQcrB+7iiTb1qFRO2/AGe0iBWA6b8qFWFOHzIx23iG
   lGcGNeeSxt0FdXi4nw62pBt322Tw9TD5uKtp27KXSSUM/N5XVDJa/L87l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="368375167"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="368375167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 16:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="9886199"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2023 16:12:11 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qz3Kj-00032g-1O;
	Fri, 03 Nov 2023 23:12:09 +0000
Date: Sat, 4 Nov 2023 07:11:23 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/71] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202311040718.bpsI0NBb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   bbb2b19ae34074f76a2b0bb92e7a839f458a626e
commit: e3a6be01600e0975a210cced079c34f092d35362 [1/71] DO-NOT-MERGE: git markup: net
config: i386-randconfig-141-20231101 (https://download.01.org/0day-ci/archive/20231104/202311040718.bpsI0NBb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040718.bpsI0NBb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040718.bpsI0NBb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
