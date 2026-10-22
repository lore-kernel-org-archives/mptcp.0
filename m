Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692410;
	b=LDasET2KJkRLqKAHzN18SjTwitPCI7ReXZFfChoVZ23VcYHi1ghZD5QegkvElHkM+hKV
	 OAwiks4pheCRcqqyptCNSyZ71xMYD/8hoZuc2hV8rFiF3JV+dWVxIRulVAOWEvWvxkC+K
	 aw94t1BMuQ5bbRbYOgvOXI/dQ7tsKh2+kQhsG5ltk7bo6C0xxiooXO+DDifOkVxE8K8QG
	 KYlsK4vNQpSQbz++450W1bK1nqXcB3B5W3mam3ypP6jiKMZLnF00qDqGjLk4qXii+jf3e
	 ZakEQlxG50THVd1s6GNA50d+XQpct3wYCr1Zi8NEvDQzrJFgCMHJXKe1yZnmSdETOPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692410;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ZNgXUFfxb+pfuB4pUvGiJLITHyM0ta/+E9PxL810iRc=;
	b=w9QOL9iiNjRUNmTzjSdh5klN3dumz+4bmSjkDJHkvcHS+0b+tian9AciDc17Nx3rUCQm
	 r6mDuagoJXw1AxZQSLnQe7bVg/8So7KMzI688rrz/3ZgrqxGQ+N5sDnm4ttRJycpkkhj4
	 4H7PMYtStRYTpI75kjyzG4p7XC5JWxRaO0/2FUUH/oZkyMEITn1tw7tZdnTyvs0EH23z6
	 i8Vz4JK9/84mM2CYcnGQ188Oq7wVA20fyZGnCs44GpNr0I5iDm+cNLM+Kb/+o+Gu08lu/
	 HWTw6J/b98tRG0hhop7H+6ZveTu1W5tjrErAdfcyzlBlairYTiG04WkFCiJ7CjkwN0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mlpI0prF;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E02606A319;
	Thu, 22 Oct 2026 18:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E02606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mlpI0prF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792692410; x=1824228410;
  h=date:from:to:cc:subject:message-id;
  bh=Uhy7Rc3ZGYdEWwonAjCOaZhHqD8mpDGvxXYLiBZbXig=;
  b=mlpI0prFCwaacGfKmg3lL09QFKBOS3iigdmqThKgf/EUyprVtsOWO1rJ
   7O6LQ39HJI+2dMdIEDO0nrp6Ui0QCpBTwaNNfg2EU0tcPsQwSwbUkvy2P
   c0uHOxNDL66/AwPzAaP6mqMURpe+ATCeZflCjWlYQuSOtNteuPRyH/wpu
   1elxrndU5F9uuQDQUx5+CIxeKHRYmhcFZnrGBqOq6Bg+C8jaoYTBjsioM
   XOkQYn5S8v6LB1r+ypYwo0KHdBwyF4z+LOqmAZ5YA1P3wzow3RvAyAo9v
   XFlx4cYA8qDs8yE5DAdddNriIvCZG4ZwaRqSTFTfa7BeAXrIob0KUNfWo
   A==;
X-CSE-ConnectionGUID: ny+wgxObRA6Hxm2JwCa7nA==
X-CSE-MsgGUID: 2pbKNOSKSSGz6+agf66H/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1352277"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1352277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:06:41 -0700
X-CSE-ConnectionGUID: cgdQ8OI3QDuEW1cainYpCA==
X-CSE-MsgGUID: +bT5YJrmSw+Dlcu4K9Y1qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3339269"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Oct 2026 11:06:39 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xJxBV-00000000RSK-02vo;
	Thu, 22 Oct 2026 18:06:37 +0000
Date: Fri, 23 Oct 2026 02:06:02 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 1/35] .b4-config: warning: ignored by one of
 the .gitignore files
Message-ID: <202610230103.NS6LPLIU-lkp@intel.com>
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
head:   f2f79e9af965c1c49decfe56312fa547095fbbee
commit: 0d55d8f752543be2b6f4afbc6b3d58dbc7be09dd [1/35] DO-NOT-MERGE: git markup: net
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261023/202610230103.NS6LPLIU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261023/202610230103.NS6LPLIU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610230103.NS6LPLIU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
