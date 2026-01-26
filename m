Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC91A9F96;
	Mon, 26 Jan 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393353; cv=none; b=cPyZZsGPxocusd0jBPoLSEgsGsbrsrKEcHj1jNt0WMgFiiDZKThKkXIy7ALPb5QvUwAc6wjf6jKfx/O/SryENsZKdzyzAnhz4d0PBTIn7f0Bldh5fI3SKkkabP+eAnirJwtp2vOw5wk8Uu1s1D+D1hG6Hp9IYSoliVS2xL9y1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393353; c=relaxed/simple;
	bh=sSbJvrx5bkMXjHoh9sqSiyJmRyFVZw6mCTis7HnvZh0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H9HxFe9B01b1ydD4ufOnItOP97tfrj8nsdQvpYAZF1aGkFIEzJD5ygViauof43ZbHt3wB/mIWP93zF9S4aOnu1DLaDUPnsqxHIeGh7kbXG/9EBa/xjmSkwgickuHzieyLYVobHvioVJANVMl+5y+zAp33u04HKfj2RyjlDOVwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Quz4R8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Quz4R8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769393352; x=1800929352;
  h=date:from:to:cc:subject:message-id;
  bh=sSbJvrx5bkMXjHoh9sqSiyJmRyFVZw6mCTis7HnvZh0=;
  b=V0Quz4R8N85FuT9PwelvLTTDK+5j4HKKsaFGunbjI12sRL+UXfZZZ3Gf
   tbH4yh7EiMOFFZ3KLj3mm+YbLVll+OqLVqwiN+miK+rdCbjbNYa9JCz5Z
   4Hx1d22tD8TALymHISXPQXi1y3GJVo1fp6NKSFVklfyuElAjCh0t+UMPj
   QPNvAqo/hERjRitJUE9MtldDlEhpOJuEE50DqZiAVh5dg9XRLhISu2uoS
   7uHD4+qE2RDvURNCPVOcxgN9iswV4suauul4ajFAjj30rhp6YyafxOkXz
   RXIyVlZm0gZ/adXlfMaLfZ9O84PV1j+03VPOgMhvJlC67NseeEp20C5gv
   A==;
X-CSE-ConnectionGUID: 0lsu6BydSc6daAUrzs5Yvg==
X-CSE-MsgGUID: 8oM0k5COTzayxfp8DKUcWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74438123"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74438123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 18:09:11 -0800
X-CSE-ConnectionGUID: MhzZdf7LSs+9rcOG/r0qdA==
X-CSE-MsgGUID: H1xVcsSFQ3m6famoQ2xBHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207989436"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Jan 2026 18:09:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkC2O-00000000WoQ-0FWz;
	Mon, 26 Jan 2026 02:09:08 +0000
Date: Mon, 26 Jan 2026 10:08:55 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 2/9] .b4-config: warning: ignored by one
 of the .gitignore files
Message-ID: <202601261005.GjTiE57c-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   49c680ea6316ba79a5bebbd4ef202bbeed300a8d
commit: 899eca1cb578d3b24afc42b92b12e39b80f33559 [2/9] DO-NOT-MERGE: git markup: net
config: x86_64-randconfig-121-20250915 (https://download.01.org/0day-ci/archive/20260126/202601261005.GjTiE57c-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601261005.GjTiE57c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601261005.GjTiE57c-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
