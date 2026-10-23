Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773917;
	b=FjNRLyUJr1PaHSXuFVqooHdzz3LDlRSco9yhbq1JUYBmpe9aiJ4rMHl+DjMVsg4o48bZ
	 M0dVECaqG2dC0dZI6f+2/6YR0Ym5L57LKBZwCL8YldTgdky5mu4QGwff6QsN9OzXSY1Lp
	 fhlRaDEwNYd8Jg103okAuMHcqCMEm5v0TUzL81hcHfMCqPs3K3VFQx6Anie7qeAG2VTID
	 XNznU9/7cSgqA0MVmu/jPiOdCmVTAZchF7N8s9+uQUztsPN67puz3hPFCFPtYpB9YAxhv
	 fiWw8gchKdv7QB3jYgMP1j7YwfGEFssffVrE56BTn0EVVvqz3brEaUu+mLaaMs5wgPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773917;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=0A8KiySiC3s9BMJDdSFp2ZCfJ95dC2sd+/dk1VSZs/g=;
	b=3WKAsiv4vYO4PI4iht+6xlrIJNEZB2JfqcwgRxTMlBOcaMudTVjXynajeZ64dAN8zDE4
	 OPRor+4jhNkGV5nyoil+nAXY+E+97GMZCIjhHhRTxlhGzdjJ9qFdg9ekaZQTdyDEQY6j+
	 kwYoBi1miSDqu/BRX8WjCbMl3bziFeakjkI2zqMWLyymU96auSrdUFQeAeWvnSZuPzBkX
	 AUxz14qQYWJXVNkEn5l5Kss3W3yglnZsgm1kQZIMUUPEnD6toqJGI4uajMP8KYeDOLhB4
	 hXoLrIGjoeOY2en4HVs0F4rnXqFj2gDk43C4jirQrfHgDelZVVsBPCy5n/Awv5FWOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J3BbZH01;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF63606A320;
	Fri, 23 Oct 2026 16:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF63606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J3BbZH01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792773916; x=1824309916;
  h=date:from:to:cc:subject:message-id;
  bh=oQOhcaweA44vxpaCh8PyUsT0Rz4/s09cqcqwoO4iYgo=;
  b=J3BbZH01TlnTla3pCWD7uI4CP+Jpe7ul/BHHnqUcY/Un6s6fepcdWO5J
   83QOk46HSsFRKUgnCOyrei7fyiLwve20QBArgu8TmFsn5olRDwbj9vues
   852L72k3PdsrE5UVP7CiMa9yRU0gJFQRqcXoEesx9oSIva6yvlRfQpiZJ
   ieKsPUFu9DeGqZmzhnpgRPTN3+75nZMF8DE8o7phpKf7FMtY8GYbi2HOC
   7FThuL56AqFXAZO8ABqUKZJqQAiBwEKbwUIr47KXMfSnrMNPOKBrYcQAA
   aQ5VSrdY0RpKit8vHF7vnfSloA5i4+Aq03ECX7ReK83gYNRsuqvOjzkfv
   w==;
X-CSE-ConnectionGUID: xLz9lMpcQi+GRmekhN60JA==
X-CSE-MsgGUID: Z2U/GIfZRHGgcM9C3hJt1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1550541"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1550541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 09:45:16 -0700
X-CSE-ConnectionGUID: Thx3A8fnQ42SnvAP52RiRw==
X-CSE-MsgGUID: 9K4bwP3zSJyRTCNIUAXOLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3797589"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Oct 2026 09:45:14 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKIOG-00000000Syi-1nZd;
	Fri, 23 Oct 2026 16:45:12 +0000
Date: Sat, 24 Oct 2026 00:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/35] .git_markup: warning: ignored by one of
 the .gitignore files
Message-ID: <202610240012.9uIgIRG5-lkp@intel.com>
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
head:   6ce5f1be3eecbc06913957ca12f7b346c948814f
commit: 0d55d8f752543be2b6f4afbc6b3d58dbc7be09dd [1/35] DO-NOT-MERGE: git markup: net
config: parisc64-alldefconfig (https://download.01.org/0day-ci/archive/20261024/202610240012.9uIgIRG5-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610240012.9uIgIRG5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610240012.9uIgIRG5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
>> .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
