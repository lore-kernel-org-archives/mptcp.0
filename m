Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80F27146F;
	Wed,  6 Aug 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489936; cv=none; b=DqskN5Pt7hbD/RhanqYGQ53gNIEl5XuD7f6+XddfQu5tfRMcODGyIQApK/miPJC+QzJYtDG3KtWrXxqIu3QuHy3i8P5feGD0el4oPEs9vPzCT4+y3gu7llY1d9krPXryaBrffcM+YPO6giUNQ5jAYYPagtLy+AnT9eQFdqbSiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489936; c=relaxed/simple;
	bh=QPXABmbSVuIxRrOQTZY8ueM25o0q1pgnarf5kPgDFIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GX2MUaL5Bla0EqoS2cmrA/i5daC1RnUiZy0W9do2eB014GEtHXUajhBfCtX/ad+w+F823z5fo2QeZxs3ZqXiUH1wECj8/TlcecRK3i/EEmCGNp18XooGKwWWutEfP1/Zc6ANlTHZ2zsUqZWgCs4qohQ5N+tFfEp1fzRjjXPRKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/m02M1V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/m02M1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754489935; x=1786025935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QPXABmbSVuIxRrOQTZY8ueM25o0q1pgnarf5kPgDFIA=;
  b=a/m02M1VZgU9f6TnKVfdqTPqpDImbothBizkgdCUr2evZ/UKxemuSGSB
   iryfpGBP9xVabrH91XC31VHn+Bz/wFXEUnJvvyhahBYuthAvISuMw4j4V
   LuOYGl+7Rc3zo7A/nqrVNzfUplWveUdhHKmuqPNoEE67TagkBan2Ue7ae
   Y7obFBEZHYiw2P6xmegHkpTKVwi+b40PgKzB0gV6er92YH8MdYCesdFw7
   5NBB8yf3VOw3tROTbzXfCoy4A5jytkQczpl06bDhQ+hVu+JFH1c2iD3zv
   15JJQ/Em58LBto5Oq8me+moQIjCtOIOpXilqSK4rlZV8CmcxbHVMJurHb
   Q==;
X-CSE-ConnectionGUID: pgsko5XyQRmzFvP65ENVog==
X-CSE-MsgGUID: Gug7yN+rQ2y2c6tt709SYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="79357008"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79357008"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 07:18:55 -0700
X-CSE-ConnectionGUID: HorJFblNSVKTsqvmZJGmXw==
X-CSE-MsgGUID: It1C0NwcRg+jwXKesNWnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164701022"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2025 07:18:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujeyh-0001lG-0p;
	Wed, 06 Aug 2025 14:18:51 +0000
Date: Wed, 6 Aug 2025 22:17:51 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/27] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202508062249.eOdDdXyi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   789563ca042b02a36bd765746ebc659fc5cb8695
commit: 7cab8cc8afcde03c8d6675673b59258fce17b5b3 [1/27] DO-NOT-MERGE: git markup: net
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250806/202508062249.eOdDdXyi-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062249.eOdDdXyi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062249.eOdDdXyi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   .pylintrc: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
