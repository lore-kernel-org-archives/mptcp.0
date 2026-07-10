Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BB264619;
	Fri, 10 Jul 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693854; cv=none; b=qQkCNSoBdRkq/DatvTi/X4CemGzqnANu0HQRMnmb1qbOjw52iluVwuzMtr/iUZTRrajY2o479ave4FOAGaHSUzbvNY/3s7Zi7S0QfRR1knwhLLmyWpWV9l5gzlhzhuGOIgAYFm+ywkkcIQq6zjOH8pkxjqvGbKy/jGq/hj7FpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693854; c=relaxed/simple;
	bh=BBd2jpoQfJoYh66l59f8fnRCUabNYQcVFWqh1k7vXac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZFq7Bb23Zu8UvDtY1W8w3yNJY8gXMzcJtzcGvtoCV1nGlGSUZhT3vrP32lICZtftjCZudf20eNi9m4PZ7u11ivnzjb+MM7q8tDvzS6mcx27wtNA6WO1fRV8T2dEubrTSrcpF13ZVugWk6grxquB2ymzPyyvrSvQW2huHEYGimHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8TUY1ZG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8TUY1ZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783693852; x=1815229852;
  h=date:from:to:cc:subject:message-id;
  bh=BBd2jpoQfJoYh66l59f8fnRCUabNYQcVFWqh1k7vXac=;
  b=D8TUY1ZGttYoPMiIPhVCiQARidiyl+RhqBTyDgz7f4aFdgXlT9kMv9U2
   SaXxNZygXwzC59WTevvXCZZFGU9wkCYF0NUlqkODcAO3wMGnZJc48T0YN
   QEeRLV93sWw+M2bH9vsfWcwG8J0HOmWfrv6s1h0gNzSltGvYDgjj0SJ5h
   HF73fUF04mhASP6Rm4Q6/84zApUAT5G7lLQ1c1gvFMOaluJidXLI5kgV+
   ycAiHKmBUe5UShoyKfDjJpoK5OyuKdoiru9gvrZRxuPRTQSXgLmXiJ3um
   ZisrhKz4tOxiEyZznyyX3iq9XQ1YrJB/kITKJDXwS93scweuzX9aqRvjn
   w==;
X-CSE-ConnectionGUID: MS4fV4OQR3+sX98JQfoh+A==
X-CSE-MsgGUID: djcFzoU/Q1WMwQyKDAV0Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71916051"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71916051"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:30:52 -0700
X-CSE-ConnectionGUID: ssS7/uLWSg6K3xVUKNh5mQ==
X-CSE-MsgGUID: iDIbgkR+THOvhzAfBJBCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255555596"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 10 Jul 2026 07:30:50 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiCFb-00000000J0p-0WCy;
	Fri, 10 Jul 2026 14:30:47 +0000
Date: Fri, 10 Jul 2026 22:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 mptcp@lists.linux.dev, matthieu.baerts@tessares.net
Subject: [mptcp:export-net 5/9] .github/ISSUE_TEMPLATE/01-bug.yml:
 warning: ignored by one of the .gitignore files
Message-ID: <202607102243.qOGZxnoE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   8a5c23d533d1691aadfed5c6324c68228ba7f24b
commit: 9e002ca3e688e4248d6337c1b9945d8b9237b3f8 [5/9] DO-NOT-MERGE: mptcp: add CI support
config: sparc64-randconfig-002-20260708 (https://download.01.org/0day-ci/archive/20260710/202607102243.qOGZxnoE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607102243.qOGZxnoE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607102243.qOGZxnoE-lkp@intel.com/

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
