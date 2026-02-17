Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F45322533;
	Tue, 17 Feb 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323156; cv=none; b=NfLy3l8UwlIDgR25+0ndDCimIUpt47gKbfeAvGsAerKQiKyPyokiWx8Ng27hcz3onClwP9x6HHQroanSL/UL2LpglQoC+aDWrtDeC81tSXacGaabbeU3zCEzkBrAhG3YXefQCmKJDLopX42GyjXfSyDIcFHN9l5bAXK+1HjZ20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323156; c=relaxed/simple;
	bh=UaY0dutnuSd/tichuJ59IpJhn67GCyHvXBzpoxLqzuU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RPeLSd6sZt/EXgByWMbcFSJ6G2OFhAlnlBfvBE12dMhr0S5/765odCc2Swzbo1i1bk+9srlwtcii8x/idlutKne0SR3+chspMJok1lfjytV3gNDQStEDuWZbkNRBWfmneVnjJYegNBQu1UrgZKk541VqmE6mtW11tyTYjH7d2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bz+88OKr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bz+88OKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323155; x=1802859155;
  h=date:from:to:cc:subject:message-id;
  bh=UaY0dutnuSd/tichuJ59IpJhn67GCyHvXBzpoxLqzuU=;
  b=Bz+88OKrD45i+iCTu1VheSUynK+TxgErxsPDpZCqva4tqBo3aZ1wuIhj
   pYmZA7pdUN2NyxPrjU0s0BdbexSE91F2CTPQQLZg0BCowcDJ6wZMvw2NY
   e6JTWexo0zfYQ3Syw8vg0JI4n/X8fUDJlyCxkTPHWiqjyJ/CPoXWalvwG
   qCHZfmmXSfe68bTP3LbdY/9OM/3Br+6L00k/hN856C+4LGHJBhjlfedcO
   8zeoubTqiyLZ5zpsCr43JCLEKO3I2BPNIT48iApBJ0PTugbDed4i5dXtd
   7HMa7w3cYa051RFm27/+pn9qAS1GeUf5hCWBm0TA1gz9PDNBCmBx+V3yg
   w==;
X-CSE-ConnectionGUID: T47aNfSvR92/d4EhqUH2gA==
X-CSE-MsgGUID: eRO0yydfRYefYayXkDK+Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72098397"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72098397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:12:35 -0800
X-CSE-ConnectionGUID: /YnRAk0rRhmsaDY5DLJWLw==
X-CSE-MsgGUID: SMwsIRGCSQWZYgx8CUDWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236849872"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:12:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsI4E-000000010pk-286w;
	Tue, 17 Feb 2026 10:12:30 +0000
Date: Tue, 17 Feb 2026 18:11:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
 matthieu.baerts@tessares.net
Subject: [mptcp:export-net 8/12] .github/FUNDING.yml: warning:
 ignored by one of the .gitignore files
Message-ID: <202602171838.8CLqYA0a-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   d8b476dcafa197a8e66cf6e87f2441848269af0a
commit: 1b132854451b47463fd48114792c3da70d0f2262 [8/12] DO-NOT-MERGE: mptcp: add CI support
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260217/202602171838.8CLqYA0a-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602171838.8CLqYA0a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602171838.8CLqYA0a-lkp@intel.com/

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
   .github/workflows/stable.yml: warning: ignored by one of the .gitignore files
   .github/workflows/tests.yml: warning: ignored by one of the .gitignore files
   .github/workflows/update-tg-tree.yml: warning: ignored by one of the .gitignore files
   Documentation/.renames.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
