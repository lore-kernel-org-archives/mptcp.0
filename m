Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598074;
	b=OoEmcTbMf4LSmANBVp+JqAzCKTQrK3l1UocEwvzQk4Ccc36DbybI4/KM06Txo+VGx5w0
	 N/8L9K6wmB6op2+DzLnM+JQkjNrMR986/mcwQnv9zdSiRiak9Oq9AeYk6fXHmG3PGzolN
	 iDghoJNBUN5dC2NlcvTiG7pgZzeBoO8n/EVKUwzGYrl1kjHAjMQOwCsBUW7nTG52GZqXI
	 8kDoghgyy9PeST/RoFVMGEuAZnxYdC9clqhsPVAXgi/LXTQEKqnPNskBQFrqdIrHfNCkl
	 OouuKb7HX9h5uEcWS+08LwhaGs8Jzoqx3rlWDg0hJ2U2L9TAIjvhgR7fAF6Cxr9MBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598074;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=lJmZ5WwGx3iTDReIcuVpB8iK8HmwCxvHVqZlo81WFn0=;
	b=2QnZ0WyIKHTLKQA83IgNwuBhTkofqXnX8gdqLscY5vaMyZiwlZkZtmOONyWyz/ikmMmL
	 NT+wzLeJx975sc9oStF6UAXNZsDzUrBKE8Gliu9t/HAdSzBpoKYDaPrTUSTSbDVrc/swe
	 up1qBjKxjK89q4MDuydTINFU3l4peay4y/Vmg4Fq5BtwLRQo9bTeW8vdhENxsWGuN8Y/L
	 WN4GWx1dkH7Zo755pz9mINL6hH5Ls+2dcLZIIH5HCuoU16mde7LIGj4epYX/p0pWr1Xf0
	 HyEr/Do2pbCoDaURFiT2jbcNFKMlu+HPyKx5kU0TUhxDId7M0lNCzCCPduDoHMlVVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KRCKWP2y;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED81606A33D;
	Wed, 25 Nov 2026 09:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED81606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KRCKWP2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795598068; x=1827134068;
  h=date:from:to:cc:subject:message-id;
  bh=tDcs7amqTljem4iggVez3OGMG3D2Bt7FnNdwoEY8GWw=;
  b=KRCKWP2ydjWRBqgxb810EhDVsdRExFFiMcRGyFI5I6LRkK7/JUyR99hH
   KlYqpoyaYgzYe9SxoB1a7IAbb56UIgmp1BEvcNAljS2bEeqKkSuib2eQh
   UiTlsMMrUYjFy6wU9KJ2KSVog2C4ZMtbrhnE8jJHrZ6jVe9qRUmaqs7A+
   8XL/PBidRaihqu+Y3yZ//H1efbrXUraDsxZr1MWFFEhKmvbSlt8lu6kqR
   AVJMgR/XwtwVFC74A3jAZnYna5PZ4qq2b/CeVeqU6zO2baGQOVAFK6FVz
   9rvu5sj84A8XAr+daDFdmRebSnJGeI895mOsn7PcBdxs9RXMmpCOLj+B7
   Q==;
X-CSE-ConnectionGUID: 0eMP+KoESOqIBWKjwtCSww==
X-CSE-MsgGUID: S6n6AkgKTU+doEL9oD4JTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4369244"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4369244"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:14:27 -0800
X-CSE-ConnectionGUID: fROSgHZmRkekyW/t/+ubBA==
X-CSE-MsgGUID: DcxunBAMQiGwQyGDdWztgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12030200"
Received: from igk-lkp-server01.igk.intel.com (HELO 99c479ab0aeb) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 25 Nov 2026 01:14:25 -0800
Received: from kbuild by 99c479ab0aeb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW955-0000000006B-2F0B;
	Wed, 25 Nov 2026 09:14:23 +0000
Date: Wed, 25 Nov 2026 10:14:16 +0100
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 22/56] .github/ISSUE_TEMPLATE/01-bug.yml:
 warning: ignored by one of the .gitignore files
Message-ID: <20261125101222.Olptea6x-lkp@intel.com>
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
commit: 382699ec4bcf25e1380ddfc82a45028112f08cbd [22/56] DO-NOT-MERGE: mptcp: add CI support
config: powerpc-randconfig-2002-20261125 (https://download.01.org/0day-ci/archive/20261125/20261125101222.Olptea6x-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125101222.Olptea6x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125101222.Olptea6x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   .github/FUNDING.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/01-bug.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/02-feature.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/03-question.yml: warning: ignored by one of the .gitignore files
>> .github/dependabot.yml: warning: ignored by one of the .gitignore files
   .github/workflows/build-validation.yml: warning: ignored by one of the .gitignore files
   .github/workflows/checkpatch.yml: warning: ignored by one of the .gitignore files
   .github/workflows/notif.yml: warning: ignored by one of the .gitignore files
   .github/workflows/stable.yml: warning: ignored by one of the .gitignore files
   .github/workflows/tests.yml: warning: ignored by one of the .gitignore files
   .github/workflows/update-tg-tree.yml: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
