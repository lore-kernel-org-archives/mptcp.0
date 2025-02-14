Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CF151983;
	Fri, 14 Feb 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524908; cv=none; b=FkpQXWsuV7BsEMo1UV2MbfwvA1+Z5bOj44ymelGrF1Fgc7woJjfjThD3BG8fbvyCtdQrJr3O7C6Dsygc51jvRRwedafJlImrbDVml+tZPcOAslx0a3PmVUZIJIn398KrGs8qcCC7YnuTH9+/zwn8NGC4h9OrYLzoZxY6cYdHLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524908; c=relaxed/simple;
	bh=Ydvn95HYL/9RvBOPXpB5+o3NjxSLJNNjMi7Sn7od54k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sTmdOHvUFp1xjRSzMJaXgRr1y0T/KcJ3wEdfdtqlJXoKrrzk9ujjuj/6lME0O+PdRvnt8vjq0gf4TUgupRmdLVCp1jIU5o3EKcwQIfE+MojB7rERvVNxVz1nuvBnZQRB4XSum1KnETn1NLE6khGW2fdRr4Fzw387Z4zNw1CUhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clFDDsiZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clFDDsiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524907; x=1771060907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ydvn95HYL/9RvBOPXpB5+o3NjxSLJNNjMi7Sn7od54k=;
  b=clFDDsiZvHkRt8ynXBr38J28jj8/vLpoWgp0eOUA3PNCCEXAkIhrnjs8
   FRSU+EOydutIpqZGT2Hl10DqxrSE/imkOKBeWsKuUjXecTggXis30QnIk
   t+VnPCf+Jpscd7+NGDpX4qyyJf6KhGNNR5o1Q8bt/Juy0PcTYOIy4Pcuz
   oO4yfUithF8mS/pRYkL9lggKSidGKWa4euyY/7mRlpmYPypqviVlCDT5d
   pEyLn+PJuu1qXBQlzPLxyxE/YvndVNqZCJM5RZyiRQUkj7sXhSlOPsbFH
   GQHjgRSq0lQ3ab0R6doNWwyQXuRdJJLotrIimLNo5NrhDi6R3NFRcX5f2
   g==;
X-CSE-ConnectionGUID: dFdPSkQ1QfKjRLih6SoGFg==
X-CSE-MsgGUID: 8HBLTUV7S1CBwuKd2Sj0uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65618803"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65618803"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:21:47 -0800
X-CSE-ConnectionGUID: bFNNGqa5ScKinUFSpdmQ8w==
X-CSE-MsgGUID: w6LOgKUZRR258DH2qddEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113390600"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2025 01:21:45 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tirtH-0019Jo-21;
	Fri, 14 Feb 2025 09:21:43 +0000
Date: Fri, 14 Feb 2025 17:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export-net 1/8] .b4-config: warning: ignored by one of the
 .gitignore files
Message-ID: <202502141751.Y5mPYEPW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
head:   944fa760a27223478265c5374a3f781c101d95f0
commit: 6bfa223db3bdf60f221897d6fa68f6df4677fd1b [1/8] DO-NOT-MERGE: git markup: net
config: loongarch-randconfig-001-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141751.Y5mPYEPW-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141751.Y5mPYEPW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141751.Y5mPYEPW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> .b4-config: warning: ignored by one of the .gitignore files
   .git_markup: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
