Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3A21ADA4;
	Sun, 25 Jan 2026 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769316308; cv=none; b=KVQBNj+3HNNnEc/Jmk0i5FeF+AXQOkbXMHF0JrK6R6Jr+MahXlujsIWxHt3bOYHg7FPxTQePjv5Vsl2psC8ZLETySVDJy4zMDvc1cPTS/KVBzu7HyWa0+eRz/5IgT7AGx7ceUlza6SWBI+eUlBLEcTGxCDecVSdjd8mb91rnceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769316308; c=relaxed/simple;
	bh=zC2psyqE6VJZyi/oC+FFh4v5Yg3e8Xt3gZ9vIs0LThU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tP+NnlT3dR6zR0KRL2RJPKEA5j74QAbRmFay8rfUWK9bzTs/QfsJzjeZ5tEu5YBNxjZo9x6bBnh//p/+95pU08esWhCp4qatwXtTAM4OQgF5UjAzAIdfHeALBeBYgsVfUcoD2cDrMXsKOEOW3IXfNEY/jvEDk6YTe+erNFkBTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZw7cr6I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZw7cr6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769316306; x=1800852306;
  h=date:from:to:cc:subject:message-id;
  bh=zC2psyqE6VJZyi/oC+FFh4v5Yg3e8Xt3gZ9vIs0LThU=;
  b=dZw7cr6IQJZivUrdcb7IMm7yWkREhNtO50PMUKdEFVKtq8cS5kHMYl4y
   hPzL1x1qFr5CnoCqrS39QiIPzeohGml0GuQGYfk2ALjwK+b2eajPAxBqv
   QZTBFVP6I6Dehzd6xd465glVKWVuQEnO0Ndx+9+asDktydtvofm5K6MLO
   bs/0Tw5F7TNOXmlQSQt6Lr63aCqe+M9gXoH1egpJr9q8bBkQ6l87IR0cM
   /HM1oWZ/BUq4C2ZtOVABkhTF5/ChIXyBIY/k2SHxsRefeUFWbywYoeRB4
   wEUrH+q413u8DUFY9Z8BeMS3+Vwaz4+3xOUWKJ7FlrR9crKISjv1g/JRv
   w==;
X-CSE-ConnectionGUID: CgG2Z8M9TIOxh/KdaQKZRQ==
X-CSE-MsgGUID: k1STNkQPS6S+V0U2E6bhew==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81631966"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="81631966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 20:45:05 -0800
X-CSE-ConnectionGUID: G9M+9aJ8RQq2oXuPezOLgA==
X-CSE-MsgGUID: YSVYO++VRb+GX6+wYNCS1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="207436587"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 24 Jan 2026 20:45:03 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjrzh-0000000018v-1r1Y;
	Sun, 25 Jan 2026 04:45:01 +0000
Date: Sun, 25 Jan 2026 05:44:28 +0100
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev
Subject: [mptcp:export-net 2/10] .git_markup: warning: ignored by one
 of the .gitignore files
Message-ID: <202601250555.wUthhYTM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   49c680ea6316ba79a5bebbd4ef202bbeed300a8d
commit: f0d6f2b1b5c0522d97f10d23a4bf790546283604 [2/10] DO-NOT-MERGE: git markup: net
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260125/202601250555.wUthhYTM-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260125/202601250555.wUthhYTM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601250555.wUthhYTM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
