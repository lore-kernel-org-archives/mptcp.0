Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CB43A7FB;
	Thu, 13 Aug 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614950; cv=none; b=d0982IwtBDOQvWFvkSC1ROtwOoqzUWlTk1rMT4RweOWDlo4LtYCTBJk0Nj3RUi73YG92PuTmuaDMb3yc5XFtIfUhwworbHCtEeGMlm0e+4ZFXfAI7WZn7yY5O5DOICkqDaywgVAeqSnte1WzOsUMelb6hjcvYCGqTF7cghB/s5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614950; c=relaxed/simple;
	bh=YZ34yIP3b2QwWGAANpKK2TZvGIxYrgDrGJ2RjlXUu80=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QlHj3DyhsTFMXoZInO62yBN34F17UJ8TLDKGqgH3tqJbXvEsIjNqhiJG8yWgYOEXBgaN9QmJpe+oMyYuR5oMKXPz7ZdQtHaS/L50ntFfAYEDhh2rYoRCpSjDEfUgRr8rcL9MFgsgWpMja20XGDRQ28FZPflodgXt6PGBu/buoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz6EoEh5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz6EoEh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786614949; x=1818150949;
  h=date:from:to:cc:subject:message-id;
  bh=YZ34yIP3b2QwWGAANpKK2TZvGIxYrgDrGJ2RjlXUu80=;
  b=Iz6EoEh5J7mvdT265uMGOV9RV5rkYJgrtbD4YOtKKdkOcAaPA4cXBY90
   Kw6TKiAJD2W+ectf2wKLXwCT5vFBqRkgvSOxEnkX7Yn77HHdCM/GFRWbY
   CZwzwyxHVMsGxprfSEJSVW+IzSKvgT5Lx5R7VhjjtaFyPg/sQOTEqQuIU
   BiNHCUTFXjRZ0+I5xQHmAc3O67jn7BVoQmCIEdlAbZkYkyK8V3wQVyfON
   l+AIZCMkG9Y91v2Onqn97b4OqyLFfChdXmcDiwqzTz5GTSNJGG74ilMKA
   h15ZMyvctj6Jgz8kel6vJRv0qrbN+wjrClqk3Yx29+rb5tMB4bx0xY1k8
   g==;
X-CSE-ConnectionGUID: bM7JyGaCQyGbzgylCk1dTQ==
X-CSE-MsgGUID: 6YXXJUUlSpGiih3BjxZGSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89705273"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="89705273"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:55:48 -0700
X-CSE-ConnectionGUID: 0y80L0i4Sy6xi+V0F3rYJA==
X-CSE-MsgGUID: 16KtDuQZTBmmwvRgwaXpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="269088480"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2026 02:55:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuSA3-00000000Ta4-44Pt;
	Thu, 13 Aug 2026 09:55:43 +0000
Date: Thu, 13 Aug 2026 17:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export-net 7/11] .github/ISSUE_TEMPLATE/01-bug.yml:
 warning: ignored by one of the .gitignore files
Message-ID: <202608131723.hcN1yDEa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   cfc6097737df827f6d7523b3295b7952bc42d9a6
commit: a05434644d42a543c6d58d9174503c0add8e9cc5 [7/11] DO-NOT-MERGE: mptcp: add CI support
config: i386-randconfig-141-20251020 (https://download.01.org/0day-ci/archive/20260813/202608131723.hcN1yDEa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608131723.hcN1yDEa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608131723.hcN1yDEa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files
   .github/FUNDING.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/01-bug.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/02-feature.yml: warning: ignored by one of the .gitignore files
>> .github/ISSUE_TEMPLATE/03-question.yml: warning: ignored by one of the .gitignore files
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
