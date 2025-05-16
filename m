Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82905231833;
	Fri, 16 May 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393628; cv=none; b=TePv/ctWXCDwgFt+jhftSW+ZAo2Ex9QIAGxaw4proBXU/f8wiK8knFwGmcnf+f5gDgHgwehe80DI986pL8GHFhiTrOug7GR5GOz6rhc8gqYO84Gibj86VYeOPH4K3rohxDr+ytZNZ9/PiszKkTLWdF1lEfjspHDMRZNEqyzgUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393628; c=relaxed/simple;
	bh=gcDYN/eppVKNeQtKKwGlnI/ctWBsZiX2w9PLxqw3L8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RdypA9nSib34FCw6EhWAfDW4GnsgUs2XMSHCBhiffr3rQL+PLH0qwp9Of/ptisQOS05W/ac7iCCorVy/JWVQ2gtwrUEyG3ExOm0QmQGCk4zJARxLvN/SpP9y4XgBnupxy2zMoqDW3KcSJ50kpCfe+9UUtKvr2TjCIe/G8uNJNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AInIxfCV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AInIxfCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747393627; x=1778929627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gcDYN/eppVKNeQtKKwGlnI/ctWBsZiX2w9PLxqw3L8I=;
  b=AInIxfCVqhe9HHAF9t2apNV7OWrQnlM0Ym9oNCa1OtY2hyczQGsbm06J
   4Z8ylJPDdlU0PMXGbf7dD3YFCHZgEuKj3krdHkqyJMxnXM0gf/BdO3EqU
   2QUvd0+H/+Ua6S9P7++BfVg2HloUXHDh4mPydPixOFVMcTwcVvH3mWA9F
   nbXTDmGidToATriaZkL/G5q9yIclAy/JqtelzneeTjmzjHrkRypYCAkJC
   l2e/hIEO6phj0JOHVcuc/PhB5+IfmRCL6v19CYoIKqdR8CeqNFsU3w8zf
   2EO/n6KEubIWJ8mIGkv5fej2jkTTkqTcBIc54zHvLSG3IbUEN849Ik+UF
   g==;
X-CSE-ConnectionGUID: ssY6R3pTR8G5eeVs5afYUw==
X-CSE-MsgGUID: WpYbXx3XQ7moZKc8sW6cMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53176467"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53176467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 04:07:06 -0700
X-CSE-ConnectionGUID: /ZZh4fntRt655zNQaTpGbw==
X-CSE-MsgGUID: ZGsfTj6iTtyOtekilJeOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139052227"
Received: from igk-lkp-server01.igk.intel.com (HELO a1decbf9c5f9) ([10.211.3.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 May 2025 04:07:04 -0700
Received: from kbuild by a1decbf9c5f9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFsu6-0000N1-25;
	Fri, 16 May 2025 11:07:02 +0000
Date: Fri, 16 May 2025 19:06:40 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mptcp@lists.linux.dev, matthieu.baerts@tessares.net
Subject: [mptcp:export 6/34] .github/FUNDING.yml: warning: ignored by one of
 the .gitignore files
Message-ID: <202505161919.wHuOi1vX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   d0aadd90486f91d2f2ec316a9ec3a10a78f981c2
commit: 443fdc47e4c9c44f7962f51f7f336af36ee879a1 [6/34] DO-NOT-MERGE: mptcp: add CI support
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250516/202505161919.wHuOi1vX-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250516/202505161919.wHuOi1vX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505161919.wHuOi1vX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
>> .github/FUNDING.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/01-bug.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/02-feature.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/03-question.yml: warning: ignored by one of the .gitignore files
   .github/workflows/build-validation.yml: warning: ignored by one of the .gitignore files
   .github/workflows/checkpatch.yml: warning: ignored by one of the .gitignore files
   .github/workflows/notif.yml: warning: ignored by one of the .gitignore files
   .github/workflows/tests.yml: warning: ignored by one of the .gitignore files
   .github/workflows/update-tg-tree.yml: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
