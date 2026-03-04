Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE43368BA;
	Wed,  4 Mar 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632433; cv=none; b=QomG8FfQ1FgctBCDGFZvR3IgMkIFJJ1uClXm8UVJ3Xse/SrW23OH9Bw52RJk/Yndg4tRW7rVQcAZP3tisdBC+Ye88Et4jf1UZGcc+HhBKLin4YQ3cjrxtE0k1oGSl9NtCDP3yQXCierUGEP6WgnbpGw1JJgNOV7t+EtDR76rX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632433; c=relaxed/simple;
	bh=wpmw0iunRONJ/129zzzQab45/4v+rx09BId/P71FZbM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I3G2i3KwFf1iq/y9sYoEtkZRUTx/zQblpRpAdX43EL5T7eQ53SEHV5kOK4Gl+0LAZbbJnJ8nX5KcM9h11Y2DIJ/2B14A8Zr/3i4Tuok5fdK0hNYJwafQGy0hEKb/7Rf5aFn1DWiVaVF6VuqI2q4XR5xlX9HOgb5I6oIoaWPw51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO74okul; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO74okul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772632433; x=1804168433;
  h=date:from:to:cc:subject:message-id;
  bh=wpmw0iunRONJ/129zzzQab45/4v+rx09BId/P71FZbM=;
  b=fO74okul4pdSDPn/5r0aL47lIdarAsLEi78ds/F0w3seaLfWeEQR/psX
   Eytt28Ux8nxbg0ozMYzcTZ/2o3MD46rZk7qMTFPKcaSHjBmUK8OWD8yFB
   Lx2GGU2KqOZiTI9KdnJQHqmVLKBr2a63ayEtmvgtKeq26tDSslIQN5lMq
   fwRC6AKXNKSiGlEFWNbRzl/C/wYhQTKcx5llMB8RHiBWaTpB6bzVWeSsQ
   /MHOiqlddNJam3hb4NHW6ewbXgGhXQmc5PVtz64bPkOCaxcqlz52TrlXW
   QE27iKwK5JM8Sz9g0eRKLGWXkVFSW90hzIabOx4R4SsklEpEArtyyMNYy
   Q==;
X-CSE-ConnectionGUID: Mayc6JlUSEe3qdfwEXfHrQ==
X-CSE-MsgGUID: XWvGYOAYQ6uF6FqHgJtpYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84780524"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84780524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:53:52 -0800
X-CSE-ConnectionGUID: zLTLcmmFRU2d8a5Ja+sjhA==
X-CSE-MsgGUID: PC+dPXDwT8eiKJFTjIrR/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="256229270"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2026 05:53:50 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxmfc-000000003nH-0Zgu;
	Wed, 04 Mar 2026 13:53:48 +0000
Date: Wed, 04 Mar 2026 21:52:55 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/13] .b4-config: warning: ignored by one
 of the .gitignore files
Message-ID: <202603042130.7fEtS3qT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   3131c791dc439da56db5757d4fcb9a41b056780f
commit: b03554f51454944c778c34b3d752337d805887fa [1/13] DO-NOT-MERGE: git markup: net
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20260304/202603042130.7fEtS3qT-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603042130.7fEtS3qT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603042130.7fEtS3qT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
