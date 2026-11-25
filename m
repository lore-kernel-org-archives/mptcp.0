Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597487;
	b=yyolYqTCga9Qa+h2l0jAuwxPiLouAuccnv+qCyyLIhYlSWaDqfT2jkPcaP4qe0ZHBIZJ
	 rD6eZg/L8AjWCJOccH+1s3Leq2VRnSIMynBQDHcjgBDDjCcV7IA+7PIZJFU2ZPP7TfvkJ
	 l3KxAlsLSdUloCQYXVRikTHVZHG8xddavTSPoebWDFncblnUt0bWUHYid8l9kV/px3ise
	 MHGXt0mqSfu24vTmdtOF1HnE3VwnA0lkAk4yJGC3nObdhJifN9bgS50Lw/0N0JdkIPqf/
	 QkPuVAAxiLTQrcNCImbz1qtcHiYcBKBzD4CLG4u4QfMn8Bwo1cEOps/rIdO4kGr5M9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597487;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=FiQu5duTdZDOO1sS8f353s7nlfCaf+YomMSk/GsfJbw=;
	b=NdYBrOMB8OO5Nq5ilQhi5xoURjR2Dy/typ+zqC2B6PYLNStb70G7HWbqHGi0lMXzcG6e
	 ZcTV/YhQxGpKwXXBl+XCDWv2UWsRHw1MavyDpdM3p1xdO5BfSXKM8fvRfztU+4X0kB4m0
	 jFQBLFKUVQcyIBF2p7MU14XdRfANYS4nl7Kih/CjkdihAbSBmdUeHkQz0xlGHTx7R4geH
	 dUtepRtH9mSSbkzGJpNY1pXAc2lVXj84gWNvnqR9s8sn/H7d3CPWGJBnJVClem0zpbo1D
	 4V+Y5WbhLvTTrUuEcOBLzgWT85YX5GGzw3Y3tYefc3m3jNGLJnBHWOgXD2IsUDfLRSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HxYBBuLq;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FF606A321;
	Wed, 25 Nov 2026 09:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HxYBBuLq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795597486; x=1827133486;
  h=date:from:to:cc:subject:message-id;
  bh=CiqWfNlS/QOhimcggpMWZCjah4/Jps6I/U/qVj1biso=;
  b=HxYBBuLqX2kEZxovRr4062U/5Ds5Qzi3qz1g1c3lt/PS/U0QR+JsKCki
   Kwi8HZ8CEIdfK+/vg5wrE/3Mbeq4i4EIZtut5pWuGxNhLD1bKVySVm/M4
   lzzTEMCGNaaYfmZUwd4fIUh47C8bmm3VbOrk66+PhLLFKC/7vJK/x0P6K
   fOXqYFRHT2Oiq3ElAF0n6PlUAZkuq31klUggpmE1Bh3bEa+ESRbw0rVef
   glqSf+ieM/cwQZtJqAKum/BbhpY+yHjJVYgVIt2+xtvm9/7/wHrWVZzAP
   d+S2y31/X6XvoqfbboF9p6uGD5DgnhtrNv54PoEaYJQuIgCDREEgAd8mt
   Q==;
X-CSE-ConnectionGUID: Fvq4Uz2mSDqgRJTQCwRN3g==
X-CSE-MsgGUID: HLpEhjs8S7yJ2WHbqmTILA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4367907"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4367907"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:04:45 -0800
X-CSE-ConnectionGUID: 69SrQfgLRnaNw2YQEGoXbQ==
X-CSE-MsgGUID: jZcIerbnQUiMhr0dDaXGDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="13596923"
Received: from igk-lkp-server01.igk.intel.com (HELO 99c479ab0aeb) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 25 Nov 2026 01:04:35 -0800
Received: from kbuild by 99c479ab0aeb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW8vO-00000000067-0Sy6;
	Wed, 25 Nov 2026 09:04:22 +0000
Date: Wed, 25 Nov 2026 10:03:48 +0100
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/56] .b4-config: warning: ignored by one of
 the .gitignore files
Message-ID: <20261125095730.33sXw3jm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   1cec70813ada37937c1048b76c60cb6b44fdf0ab
commit: 5f69d4b14f44927147300eb49548589e60d3029a [1/56] DO-NOT-MERGE: git markup: net
config: arc-randconfig-2200-20261125 (https://download.01.org/0day-ci/archive/20261125/20261125095730.33sXw3jm-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.4.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125095730.33sXw3jm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125095730.33sXw3jm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
