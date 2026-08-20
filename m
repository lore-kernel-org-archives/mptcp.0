Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE101AF0BB;
	Thu, 20 Aug 2026 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215525; cv=none; b=EVQOM/c9hTjxJIZe2O8SL8A2HSab9WmXyXDcxUJGpxndl+KapAjeFYpaMkY/SLfnJ9Vt4VF6PuRpdCbN9q2hPgJF5nEKC9O8b1WITwPWqcvM4GrYBopWzOWLNotdovY0WaETUJISF5vME/VGkGhCVW0wm/g40vzMN4pbjsAsq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215525; c=relaxed/simple;
	bh=Wp6MhId/Ti7e81JmPYijG9mb6dRjS0icNUgqibA4fBU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GFUunwAndGkmhmuys1P0Kmrloi3+9gjB8HdcQcL//ZsBnWkjThG5UQCnJkqVP8TgE4cdL+7WykQyHR1Y092zV1ijz7CDQshsY8V67qaxeKXn7rjV2pwBsOhqXmdjL6AbTrpZ2p244MgzkhumY2DYV0hZhjOt7IiJ5XvcytbGI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hISVGe5C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hISVGe5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787215525; x=1818751525;
  h=date:from:to:cc:subject:message-id;
  bh=Wp6MhId/Ti7e81JmPYijG9mb6dRjS0icNUgqibA4fBU=;
  b=hISVGe5CE6wokYqciy8x3GAhW3jB6HHb7McIg0NfbxLj1QWJlINfJn8V
   1c/VkKVRP+WdOX8JcrOit56O3u0MqHvtD3Zs3aP5ngiUSLe03UbJDimEA
   w4SArTaGBmjUtpk6XkY3pPifedG8c2jrMvnTJhGH1DZURATzRsNBObdUU
   YKTaZ7N02ljYUavBf9DmL3HM1yb6ZyifdaGfAOmPZ55IoOH0jmMSzQSeK
   txAYr9n4ydLDW4lKYmLa8fXOkp54iO3JHGGz1T2HusGfV+JnaaOc1rQtz
   v48FE3gd7vrxAd6dcfgZoZkAUThibDW+COh+n0xS9/WNCmCGvQtEeCQjZ
   Q==;
X-CSE-ConnectionGUID: zJXCllV9ThOUwC1eYGq9ow==
X-CSE-MsgGUID: W9FU2E/FTDeQ/dIyuXBU7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91617449"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="91617449"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:45:24 -0700
X-CSE-ConnectionGUID: kz6EYbUrTR6Ee9CJrUNrgQ==
X-CSE-MsgGUID: d7fIkmWGR8qLAIM2P4HmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="290742912"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Aug 2026 01:45:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwyOl-00000000iQn-1rsn;
	Thu, 20 Aug 2026 08:45:19 +0000
Date: Thu, 20 Aug 2026 16:45:00 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 2/11] .b4-config: warning: ignored by one
 of the .gitignore files
Message-ID: <202608201656.CcN7GkHj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   397bbb2919258dde0b58a688771928fa3d0f69d8
commit: 55d5d98b7729cf2603949e4cf5098aa570aae9f2 [2/11] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260820/202608201656.CcN7GkHj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201656.CcN7GkHj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201656.CcN7GkHj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
