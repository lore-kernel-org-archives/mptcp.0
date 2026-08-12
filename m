Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EA330301;
	Wed, 12 Aug 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561079; cv=none; b=pwAAfXDeqAnuo6U/Lp0bP692C6neT7G/km6DHr+09lMJ1YDms3IWypi9lodUuWtDAVpo/DQ/HDLccXbAdgaH3QAG1OSmeFi/FYUPQ7cFrg8oqo5jfrTtuyrN5sJ8f+C6Y25poVKO3nYvs6EhZpk8SZNUC4/ODeWnc0ENBrZYP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561079; c=relaxed/simple;
	bh=1PuX2Ni0G96E6mwRXmHaZj3HW1Z6v6XNwlAv14mSHnU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jKMXq0d817BXEMSOzbOg58FF6aXS36HRu7ugh52kEFDm9U4EA1b2YoRONbhbFmKEvmhfWtR0Pxt5FD8AKQIDTwH4Xh3/qJdnK4qf1CLNJBUJ0pyB3znqH7tV1sxcSM8wCH4rKR8JC7/O+slQI8hqFHlieK4y3yo2OuvtBeiD4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PREYq6xH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PREYq6xH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786561078; x=1818097078;
  h=date:from:to:cc:subject:message-id;
  bh=1PuX2Ni0G96E6mwRXmHaZj3HW1Z6v6XNwlAv14mSHnU=;
  b=PREYq6xHrHdP2uj6v8YoNYTHDrnuhPgI7j7FXPrPEIr9yKNQ7ODVc2Ix
   eq+bnuXls5t4ThR1iDRiWe4wEWuN8aXbZwQVct7O5T9VA8wGZpJ5HkpKW
   oKZd+m7j9vG1VlUWypxb+KLjFHJxRCxCxQ+FWwBEqbgZWAaEKb/rWgm8l
   veQ5pZ3Id8kWoFy/LpeWObdvku/R6otDgBX13XTQs3Nc61tC2Rw6gR4Yc
   2p/yurh36NEka1kEsxp2x/DNZHleabhIPnhMGpqdmf+6Gr7cniohXLeDC
   C3J2YPZVMzCX9v2+4ygMzECO6XHI3qwcQa1uEO2p6F1TDM0h6rVkRMcrX
   Q==;
X-CSE-ConnectionGUID: H9ozD5UxSeyTN0TPiEhaLA==
X-CSE-MsgGUID: liSrC1l3TjW4qWjc2vOqbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98278125"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="98278125"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 11:57:57 -0700
X-CSE-ConnectionGUID: EWFuwmDCSoakxQ6Rw0DOUw==
X-CSE-MsgGUID: zMucTC0STlSKXPWSUfJW1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267583451"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Aug 2026 11:57:55 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuE9A-00000000ROU-3CZy;
	Wed, 12 Aug 2026 18:57:52 +0000
Date: Thu, 13 Aug 2026 02:57:00 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/10] .git_markup: warning: ignored by one
 of the .gitignore files
Message-ID: <202608130227.3MeLtJJN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   657b4fd08508eff8e7854f3815f8dd1a5b95469f
commit: caf6f85037bb1349482662a511afae7882a5f91c [1/10] DO-NOT-MERGE: git markup: net
config: x86_64-buildonly-randconfig-004-20260812 (https://download.01.org/0day-ci/archive/20260813/202608130227.3MeLtJJN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608130227.3MeLtJJN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608130227.3MeLtJJN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
