Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF622FE0E;
	Mon, 16 Feb 2026 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771284463; cv=none; b=WiYzKi6qbJ09qu5Pn+nkyc+x/oYNX3Sw8FEuFd3RM4pR+QEZKK50PFe7v3qJIM61VwUUup+wnuwrKUsAcZMsaIatsiGZs+SsCxlYSAgOw0+9f2UHtupNn7p4hMH5EYqFI9zPyFyi7DdG2g3odga5d0sUEY6ZdU/Yb9BTUduWzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771284463; c=relaxed/simple;
	bh=3eDHWBAgzyRpVy0JHZiN7AznMUh9cfiBNLfrzAZOgSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gI1/oGiY9aLf6eKn55RAjM/dsqZaq2x4b/QgZf1DUMDFlYuJNtLOFaV9jdy//r6/2GKL7bFnljcFNIfG4x/D1qkGAAatLyEPCrlzvIzUfgGwZIantXDPl8eVdx1a9FCa5xdzwS8+9mXHjxc5aKhYCVY8ys44BESoxATSun3JwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmrmcIxJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmrmcIxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771284462; x=1802820462;
  h=date:from:to:cc:subject:message-id;
  bh=3eDHWBAgzyRpVy0JHZiN7AznMUh9cfiBNLfrzAZOgSE=;
  b=WmrmcIxJ0BfthdyDbXSSYEpa8JPbBBdhPVpzR3VOLhdBb2+uNoxjlJE1
   mWywoF4MeK5S/Yq04Dx2uoRP3Wm0JvhrdVbgbZFsrxLwatbmZvznuwo+z
   /8AOV2uP59cgRJLxHXo+Pn8Up5XtC+GMPVhui69b5OSHd1w3TFm5tj9OK
   KrMOZ3kDjLmQvk7w0sW6XkK5Hos2xJTLmOZs3F+lum8BJ+AM8O9+LxysT
   ICv3prhePgy2krmYOnZonczuz54eMNnGOm7Urh5pdlZDdqD28EVhyofAz
   fnLIGU6FZi0n9cYtlkHEJC20SvYYNZdWtvwjAytorKHpWeVA1FqJ/GpeM
   w==;
X-CSE-ConnectionGUID: sgzmWYH+QkO+M6j/kkpQZw==
X-CSE-MsgGUID: NIdpNNbpTeegCOsayeg78A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="76201692"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="76201692"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 15:27:41 -0800
X-CSE-ConnectionGUID: 1sNRUuHQTVqIf3+d9KcZnw==
X-CSE-MsgGUID: KaBz59NqR4ym11rskUJmMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="212240603"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Feb 2026 15:27:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vs809-000000010Me-3b7A;
	Mon, 16 Feb 2026 23:27:37 +0000
Date: Tue, 17 Feb 2026 07:27:26 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/12] .git_markup: warning: ignored by one
 of the .gitignore files
Message-ID: <202602170758.Dxr6HX9l-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   d8b476dcafa197a8e66cf6e87f2441848269af0a
commit: d09ac91885d528e93a8ae458b877d0d5faa897b3 [1/12] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260217/202602170758.Dxr6HX9l-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602170758.Dxr6HX9l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602170758.Dxr6HX9l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
