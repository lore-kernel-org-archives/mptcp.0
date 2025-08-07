Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24026290;
	Thu,  7 Aug 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569975; cv=none; b=UWkLRZg4sT0dJ4sCN1qc6D/t3M24uKlPxxRreSpwn4Y1tkRmMeKwYGMmYzkg/PaMHZzeDEbNwCOFMeGIcInxjmzae1uGgb4EptBYDGI5YvYtoTOSqqPe0nDqTda621iGN0IzJx5piO2hlVDDXV0e4LKibMIRa+p2Nsu34+8ya18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569975; c=relaxed/simple;
	bh=N/UKzcapHUjkw8CeNeZGjdfQ7wArMfLRYibiSoak3bU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqhWnUJukQj0TZ03sXVMUtjAm8BHReQ3tXLaRbmxXuXaHI1hRxjpE/SIHRVPKbaWNxCq0twtqYSNROec3ENOjQkNK0o1c8UrKmlWmU85J/olcR/rQ3ZzCYpouRPKkx6GRX2OdgdAhCgTyb6/cUtFrypbW5cbyoLY9qomyLTxT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8G42yA0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8G42yA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754569973; x=1786105973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N/UKzcapHUjkw8CeNeZGjdfQ7wArMfLRYibiSoak3bU=;
  b=i8G42yA08nsbU4RF2sEMhqRxOVphiBnStOvrrXxKbE8RbM/9hMhHqGCg
   eBlnZueaiHLghzkDedFDHE7Et+PcnK15Nq5dkmDyJTtPwpmuTK+ncnu+0
   MwKNXOyWDq4ck83vDxHD+BGnC6nEv96CqkX62m4LyFZ5XBquCgRYKYlaW
   5aBVNUtHIwBQl5mpFHMMzCYszrrOfUtJ75bYEV1GIR+phPRJMTODgv+9o
   IcYO98GVkZs3JyAr+bw615ARQ7pEzCYIQQw0WKIEl5rZys/y+Zm2ItQtk
   gwVJgnf6+VqTQ8MaJfYKvZ9qDJPfnYmBkBVELCyixtl+Wd+PCVh58whK4
   w==;
X-CSE-ConnectionGUID: PX9+BaGYRq6gmH+8z6Ye+Q==
X-CSE-MsgGUID: ksM+ZNqtS1mCjf+2ypGfGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57039044"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="57039044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 05:32:53 -0700
X-CSE-ConnectionGUID: kbNs5IvpQNSM2hnIDNDDIg==
X-CSE-MsgGUID: /nE6UQpERRyGBFxXE+52rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="196045185"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Aug 2025 05:32:51 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujznc-0002mK-24;
	Thu, 07 Aug 2025 12:32:48 +0000
Date: Thu, 7 Aug 2025 20:32:44 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [mptcp:export 5/23] ERROR: modpost: __ex_table+0x2268 references
 non-executable section '.rodata.fw_create_instance.str1.4'
Message-ID: <202508072050.j6BxiFvy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   ab53a8c82fcd96fd476a3a2c7b61ef05fe9f5a22
commit: a6a4be257dd86f8d813b05135477592579ecf04f [5/23] mptcp: pm: add get_local_id() interface
config: riscv-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508072050.j6BxiFvy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508072050.j6BxiFvy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508072050.j6BxiFvy-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: __ex_table+0x204c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2050 (section: __ex_table) -> .LASF2360 (section: .debug_str)
ERROR: modpost: __ex_table+0x2050 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2058 (section: __ex_table) -> .LASF2362 (section: .debug_str)
ERROR: modpost: __ex_table+0x2058 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x205c (section: __ex_table) -> .LASF2356 (section: .debug_str)
ERROR: modpost: __ex_table+0x205c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2064 (section: __ex_table) -> .LASF2365 (section: .debug_str)
ERROR: modpost: __ex_table+0x2064 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2068 (section: __ex_table) -> .LASF2367 (section: .debug_str)
ERROR: modpost: __ex_table+0x2068 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2070 (section: __ex_table) -> .LASF2369 (section: .debug_str)
ERROR: modpost: __ex_table+0x2070 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2074 (section: __ex_table) -> .LASF2371 (section: .debug_str)
ERROR: modpost: __ex_table+0x2074 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x207c (section: __ex_table) -> .LASF2373 (section: .debug_str)
ERROR: modpost: __ex_table+0x207c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2080 (section: __ex_table) -> .LASF2375 (section: .debug_str)
ERROR: modpost: __ex_table+0x2080 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2088 (section: __ex_table) -> .LASF4128 (section: .debug_str)
ERROR: modpost: __ex_table+0x2088 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x208c (section: __ex_table) -> .LASF4130 (section: .debug_str)
ERROR: modpost: __ex_table+0x208c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2094 (section: __ex_table) -> .LASF4132 (section: .debug_str)
ERROR: modpost: __ex_table+0x2094 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2098 (section: __ex_table) -> .LASF4134 (section: .debug_str)
ERROR: modpost: __ex_table+0x2098 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20a0 (section: __ex_table) -> .LASF1881 (section: .debug_str)
ERROR: modpost: __ex_table+0x20a0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20a4 (section: __ex_table) -> .LASF1883 (section: .debug_str)
ERROR: modpost: __ex_table+0x20a4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20ac (section: __ex_table) -> .LASF1885 (section: .debug_str)
ERROR: modpost: __ex_table+0x20ac references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20b0 (section: __ex_table) -> .LASF1887 (section: .debug_str)
ERROR: modpost: __ex_table+0x20b0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20b8 (section: __ex_table) -> .LASF1889 (section: .debug_str)
ERROR: modpost: __ex_table+0x20b8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20bc (section: __ex_table) -> .LASF1891 (section: .debug_str)
ERROR: modpost: __ex_table+0x20bc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20c4 (section: __ex_table) -> .LASF1893 (section: .debug_str)
ERROR: modpost: __ex_table+0x20c4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20c8 (section: __ex_table) -> .LASF1895 (section: .debug_str)
ERROR: modpost: __ex_table+0x20c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20d0 (section: __ex_table) -> .LASF112 (section: .debug_str)
ERROR: modpost: __ex_table+0x20d0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20d4 (section: __ex_table) -> .LASF114 (section: .debug_str)
ERROR: modpost: __ex_table+0x20d4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20dc (section: __ex_table) -> .LASF116 (section: .debug_str)
ERROR: modpost: __ex_table+0x20dc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20e0 (section: __ex_table) -> .LASF118 (section: .debug_str)
ERROR: modpost: __ex_table+0x20e0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20e8 (section: __ex_table) -> .LASF3001 (section: .debug_str)
ERROR: modpost: __ex_table+0x20e8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20ec (section: __ex_table) -> .LASF3003 (section: .debug_str)
ERROR: modpost: __ex_table+0x20ec references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20f4 (section: __ex_table) -> .LASF3005 (section: .debug_str)
ERROR: modpost: __ex_table+0x20f4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x20f8 (section: __ex_table) -> .LASF3007 (section: .debug_str)
ERROR: modpost: __ex_table+0x20f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2100 (section: __ex_table) -> .LASF3009 (section: .debug_str)
ERROR: modpost: __ex_table+0x2100 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2104 (section: __ex_table) -> .LASF3007 (section: .debug_str)
ERROR: modpost: __ex_table+0x2104 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x210c (section: __ex_table) -> .LASF3012 (section: .debug_str)
ERROR: modpost: __ex_table+0x210c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2110 (section: __ex_table) -> .LASF3007 (section: .debug_str)
ERROR: modpost: __ex_table+0x2110 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2124 (section: __ex_table) -> .LASF1306 (section: .debug_str)
ERROR: modpost: __ex_table+0x2124 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2128 (section: __ex_table) -> .LASF1308 (section: .debug_str)
ERROR: modpost: __ex_table+0x2128 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2130 (section: __ex_table) -> .LASF1310 (section: .debug_str)
ERROR: modpost: __ex_table+0x2130 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2134 (section: __ex_table) -> .LASF1312 (section: .debug_str)
ERROR: modpost: __ex_table+0x2134 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x213c (section: __ex_table) -> .LASF1314 (section: .debug_str)
ERROR: modpost: __ex_table+0x213c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2140 (section: __ex_table) -> .LASF1312 (section: .debug_str)
ERROR: modpost: __ex_table+0x2140 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2190 (section: __ex_table) -> .LASF2146 (section: .debug_str)
ERROR: modpost: __ex_table+0x2190 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2194 (section: __ex_table) -> .LASF2148 (section: .debug_str)
ERROR: modpost: __ex_table+0x2194 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x219c (section: __ex_table) -> .LASF2150 (section: .debug_str)
ERROR: modpost: __ex_table+0x219c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21a0 (section: __ex_table) -> .LASF2152 (section: .debug_str)
ERROR: modpost: __ex_table+0x21a0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21a8 (section: __ex_table) -> .LASF2154 (section: .debug_str)
ERROR: modpost: __ex_table+0x21a8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21ac (section: __ex_table) -> .LASF2152 (section: .debug_str)
ERROR: modpost: __ex_table+0x21ac references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21b4 (section: __ex_table) -> .LASF2157 (section: .debug_str)
ERROR: modpost: __ex_table+0x21b4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21b8 (section: __ex_table) -> .LASF2152 (section: .debug_str)
ERROR: modpost: __ex_table+0x21b8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21c0 (section: __ex_table) -> .LASF4568 (section: .debug_str)
ERROR: modpost: __ex_table+0x21c0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x21c4 (section: __ex_table) -> .LASF4570 (section: .debug_str)
ERROR: modpost: __ex_table+0x21c4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2268 (section: __ex_table) -> .LC3 (section: .rodata.fw_create_instance.str1.4)
>> ERROR: modpost: __ex_table+0x2268 references non-executable section '.rodata.fw_create_instance.str1.4'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2274 (section: __ex_table) -> fw_dev_attr_groups (section: .data.rel.local.fw_dev_attr_groups)
>> ERROR: modpost: __ex_table+0x2274 references non-executable section '.data.rel.local.fw_dev_attr_groups'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2280 (section: __ex_table) -> .LC4 (section: .rodata.str1.4)
ERROR: modpost: __ex_table+0x2280 references non-executable section '.rodata.str1.4'
WARNING: modpost: vmlinux: section mismatch in reference: 0x228c (section: __ex_table) -> .LC6 (section: .rodata.str1.4)
ERROR: modpost: __ex_table+0x228c references non-executable section '.rodata.str1.4'
WARNING: modpost: vmlinux: section mismatch in reference: 0x2298 (section: __ex_table) -> .Ldebug_abbrev0 (section: .debug_abbrev)
>> ERROR: modpost: __ex_table+0x2298 references non-executable section '.debug_abbrev'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22a4 (section: __ex_table) -> .LASF4653 (section: .debug_str)
ERROR: modpost: __ex_table+0x22a4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22b0 (section: __ex_table) -> .LASF0 (section: .debug_str)
ERROR: modpost: __ex_table+0x22b0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22bc (section: __ex_table) -> .LASF3 (section: .debug_str)
ERROR: modpost: __ex_table+0x22bc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22c8 (section: __ex_table) -> .LASF6 (section: .debug_str)
ERROR: modpost: __ex_table+0x22c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22d4 (section: __ex_table) -> .LASF9 (section: .debug_str)
ERROR: modpost: __ex_table+0x22d4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22e0 (section: __ex_table) -> .LASF12 (section: .debug_str)
ERROR: modpost: __ex_table+0x22e0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22e4 (section: __ex_table) -> .LASF14 (section: .debug_str)
ERROR: modpost: __ex_table+0x22e4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22ec (section: __ex_table) -> .LASF16 (section: .debug_str)
ERROR: modpost: __ex_table+0x22ec references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22f0 (section: __ex_table) -> .LASF14 (section: .debug_str)
ERROR: modpost: __ex_table+0x22f0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22f8 (section: __ex_table) -> .LASF19 (section: .debug_str)
ERROR: modpost: __ex_table+0x22f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x22fc (section: __ex_table) -> .LASF14 (section: .debug_str)
ERROR: modpost: __ex_table+0x22fc references non-executable section '.debug_str'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
