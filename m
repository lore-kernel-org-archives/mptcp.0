Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2832C08CB;
	Wed, 10 Dec 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359504; cv=none; b=Lw5pICYTnIdaMuiEsFS2WYSufDCHtrascJB5yWcJDzcxpRXRqrJ/BIpI2xlvvzp6VQaloWHrWYrN7JmVEbNhvLcW3AOaMgk5s4E7+TCJgwuzXGuND9NZCLeq4Pj4+KSGxUZ75bPeMvocugqeXYptnE3MNDLg4UaNoHNJ3qBO96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359504; c=relaxed/simple;
	bh=clampMtt7zr2zxd7T8UR0gKHggSzYIcqL3n8aMbu7Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NjPyQo4mc+I82ksNDDSiUb4WPA2yaWLkZ6YafsAZzqbVnzFrap8qls5B8UoDjwDI1Ff1W3tSgG9211EZ2Y5O5MAFLQIyKo8uGnOVjna6Jw/+sAz6yLb/IL9H6/pNfYQXTTN8c6Eczb0+s/xdsBSbdV8cVtUdO34dcgiCS7hAqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz5jDwuO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz5jDwuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765359503; x=1796895503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=clampMtt7zr2zxd7T8UR0gKHggSzYIcqL3n8aMbu7Nw=;
  b=mz5jDwuOTa+z0bLO7XUuaYNYPGe1ppZyM58QS9VTe88o3OD5bMzYDDkY
   toVqJZyCOQCdf0UxK4k8HTD0D11jQ//UWc8NpLYf15rFLoH8XVSfcnCab
   hlpCs5jppUnKxNwRB7tm6I23Du5oHQQO+hIzzxjhcNL9thPMQJHPppeK7
   wdrGmVpp4tVaU+2gToSZy1tw20xbK7K00QxDVsUh6O6qDS9WP4+O5YfpL
   fqCa65r1QBMTmVa8nRH5+fz0N3A74wtK/Uo8t7A5hOG2GgEXpU8lbF7qN
   y3DrlJbHEO9vGnsnyP+AYVuYa/08it0hkvPXkZIajTV7aEcGr+s2FM4rI
   w==;
X-CSE-ConnectionGUID: 1XS7daPdRkSn3m2/N3NTOg==
X-CSE-MsgGUID: JaAQHkbXS6+aUW63aGwKuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="77646935"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="77646935"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 01:38:22 -0800
X-CSE-ConnectionGUID: 6c0TrdimQDSxgamkYin01A==
X-CSE-MsgGUID: VpoCxh8fQCOdIaOXcEaf1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="219809489"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2025 01:38:21 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTGeJ-000000000YO-0AWW;
	Wed, 10 Dec 2025 09:38:19 +0000
Date: Wed, 10 Dec 2025 10:37:56 +0100
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/39] .git_markup: warning: ignored by one of the
 .gitignore files
Message-ID: <202512101024.JUe8VDoj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   3a27f14e2ae5b03a07f13266c7a7ac4bd5095386
commit: 8c1c5d202a3f7669381ca1189e7684e2c612155b [1/39] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251210/202512101024.JUe8VDoj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512101024.JUe8VDoj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512101024.JUe8VDoj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
