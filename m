Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791250;
	b=MVE4+r6alLTrBukiqP2jGPztZ+iq/qszK21IgR4wrP2YWGlSe3dAasiEdXiCnOw1tIO5
	 FrziZYg5+VvN6wane8tOj5PDXErpsU3tgiSIk99W84A5UqWkkHDamCx2tp03wf/55BWib
	 mIda6nrY2vdaKSwDd7609zD17+HyTA8EKB54NAD138/UCd2bC44dynqBua7RLScRmJgbR
	 Lu6/0e8uu3pWK8VSrJmgqIKjA4l+fUnIRUdDg2x4KAMR7sgk0W3o2vGfaHkQoHir52GRS
	 cXyXHdjvsVhgjKR+x73ReO6X6kN3V6iOOxilMft6hypTvttBxZTEt4gn+tITghUFiYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=pQRfsss0LwRjOjWqVtxpyWJg4zzkx7izecI++Y98tnE=;
	b=PTpy6c8jq+wY+XkpHt9vWBR9fawyVtoGL8ZeeXg4mhzOMRUjcS+90f4RFU7hijQYgTpX
	 cS5fzSF9/Qm2LI5//0HSqcWG0vEVaUc29FqczE7jex2SfWUw5zrb3cI4ItApHYOosOnAB
	 9IznCa2drLv6Je7CEIgMbR/DQBUMtky26zCE2dbyKjQJQZItnJQNUZKKtzF2UOZmT7KXZ
	 buq20t7qHsO1OcLDMja3Lwc0P5zuxu5K0q6hwdXkO4Z1lrGdFq+ea6rWe0vY5SR50NVq7
	 a+iqaNDAEHwVUgWzXfs7RJ/HgvgACwtdlu4FOb4oLCJuLvHoxEz9jFHH31mU4g2bW0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WeFA17Jk;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E82606A31A;
	Fri, 23 Oct 2026 21:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WeFA17Jk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792791250; x=1824327250;
  h=date:from:to:cc:subject:message-id;
  bh=ntAGzn41ApYUG8qzQ6sTu+EgE1mDoiTKDfQBnujLso0=;
  b=WeFA17JkG77+zgEpSNEbkaYaGec/gLpUeOPb68wB27/+4J0M96xboG7B
   DQYcpTtNKqCVP8zf4+KuxYaIou6t+ElHtmwihpc3KMpNRv0bCPols1CKa
   9F5ASTvXCeV+ZTPgGwmSBbgbcFwm+QIcyV1c4HEajh+EtcT52b27LB5rW
   Dq/s3dniYMfd6VPsdF4wcEWywYjs3jwKdwE4rCxuMFr9x9CMlCk6b0Co7
   4+iAH7pJNd1w4JTSV1clTKnwPdNYgFBNMGeGuRyh7Sm4HmBiMK78gUIwL
   gsVqxlWiaO3NqzZMNJaJrC9Bm8KgMf54Bm0l6TvC3ecWP2cJxzbUfSUZq
   Q==;
X-CSE-ConnectionGUID: bMYwlvIpSCekpJnnzk8/wA==
X-CSE-MsgGUID: mk9N3L3eTo2wEOCSdY+rzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1561663"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1561663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 14:34:08 -0700
X-CSE-ConnectionGUID: xMVrXFVKRCGlPeLDnb6l+g==
X-CSE-MsgGUID: xxxd7kHxTBWa4r6V87C5RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3671196"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Oct 2026 14:34:01 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKMtj-00000000THI-1BXy;
	Fri, 23 Oct 2026 21:33:59 +0000
Date: Sat, 24 Oct 2026 05:33:17 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export 6/35] .github/ISSUE_TEMPLATE/01-bug.yml:
 warning: ignored by one of the .gitignore files
Message-ID: <202610240521.9hBINO5K-lkp@intel.com>
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
commit: cabae5f9340debcc509a8940d2886ad7e23ff069 [6/35] DO-NOT-MERGE: mptcp: add CI support
config: parisc64-alldefconfig (https://download.01.org/0day-ci/archive/20261024/202610240521.9hBINO5K-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610240521.9hBINO5K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610240521.9hBINO5K-lkp@intel.com/

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
