Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D21494C3;
	Sat,  2 Aug 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102303; cv=none; b=s4+CdQyxNgMwJ3KfnTq1MmLee2TBltCPomG0Sb0P+IPHxND/DwOAWOzaW/m2+f9EhTo1dKWFVye2GUAhdv5BQn51pu5h15/fsgxmVJivy259tRCwoGuPBS1Er2jK2/Faj033ZgpRGQ7s/Nk8tDtaAZ7MVyBPqWQw7BFKOmdaQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102303; c=relaxed/simple;
	bh=ZbUnigqjMiWRvXf1Vsb31pn+EsM+BvIdQrsRp7gvb2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkWZiJgAJY23minOdFlEn6FPL0qoulhIJzurAM6xMWzjOstx0dsav4agxk1PCzxka5c4keZpBDw00+V/d/o3XplJQscxijWc60VI+gBIxJH/+6lJot1i2PKr78NtWLvDq+V01YuV3kiuUKE9ZnBYmYlb7rQlleNIx0ptfcl/F1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRZf+TX8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRZf+TX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754102302; x=1785638302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZbUnigqjMiWRvXf1Vsb31pn+EsM+BvIdQrsRp7gvb2E=;
  b=GRZf+TX81PvU/LTPks+ceZkUSNz0BBncCcw65VlIrO/VpQVQ5fx75K+a
   I8uW3mYjot7gIyMT8rKHadL1TqtjaVrzM1fxwHgi5PCEPsKqM5f/ol7vN
   6C4OAdSRF3guWkYW1xynOwNeF9zgCOeCxuatXkbTkZtyY4CEglmRBmSLC
   Ovr2IhzDcGzk2kXhmeqAJOnfBzuY+xfD+9PYTGtARU2pUourSW+ju7W8Q
   /UwwhpWsz5hdxEV7FQLYNVngEEVZfIRwNRoHj7HHc3Tf7IyBO1EqDiUV5
   Bngoy8gKM+ULCom0XotCrpN0o/LrKfv51dBvPm/9zyLD6SIQboZ8/Naow
   g==;
X-CSE-ConnectionGUID: 2o/WhnmETUuTsiDPBROtZw==
X-CSE-MsgGUID: v9qipLTEQnmH3AZFnjhbrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56589965"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56589965"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 19:38:18 -0700
X-CSE-ConnectionGUID: bfvueePKSMG9qWQB01eY6A==
X-CSE-MsgGUID: Jrn93eOMQGupIadafhWg8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="162991220"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Aug 2025 19:38:17 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ui28U-00056o-27;
	Sat, 02 Aug 2025 02:38:14 +0000
Date: Sat, 2 Aug 2025 10:37:16 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: implement IPV6_TCLASS socket option
 support
Message-ID: <202508021003.tEAjvv2S-lkp@intel.com>
References: <7979be7e1b82de6ba2eeb8dbda37e1e443636862.1754042175.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7979be7e1b82de6ba2eeb8dbda37e1e443636862.1754042175.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on mptcp/export]
[also build test ERROR on mptcp/export-net linus/master v6.16 next-20250801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/mptcp-implement-IPV6_TCLASS-socket-option-support/20250801-175837
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
patch link:    https://lore.kernel.org/r/7979be7e1b82de6ba2eeb8dbda37e1e443636862.1754042175.git.tanggeliang%40kylinos.cn
patch subject: [PATCH mptcp-next] mptcp: implement IPV6_TCLASS socket option support
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20250802/202508021003.tEAjvv2S-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508021003.tEAjvv2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508021003.tEAjvv2S-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: net/mptcp/sockopt.o: in function `mptcp_setsockopt_v6':
>> sockopt.c:(.text+0x854): undefined reference to `ipv6_setsockopt'
>> sockopt.c:(.text+0x854): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `ipv6_setsockopt'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
