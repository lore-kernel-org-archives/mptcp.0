Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897891;
	b=ebT/WxD6s1FDcDb2SNGAfUSFB2Y8rMTgU3jzldt4uorSNF87kpVqVLq7qkzPM1Zlfbai
	 nwrY3nrQjTCnIoKw1/+yQwW5X75GJf7nwZm8whdhIfa2oNXeMUGpE9qHaDIRHCfIqnyh2
	 Cm/sND1T1Bc6P3grWSqNmW/d6+jn3BKuwXOR8OIGX8ixxI8EIxinvv2M/Ad33L/pScm4L
	 AwyS60kQOYl0Lrg6dC0KEx4BRI9N5AUJZcx2HEvS5TBzDilD+zAe324ERuSZ+HzTLMY09
	 5t65axGOY5xKSvRVAaZ3JxMZli18yv6pf5OL26TSqqma8NX6K5FoUNNq8kFZxtH77KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hOnWhf2UYUafyeK5eqb3reqBBAwOK+jIEmpgbPZ8v1k=;
	b=xYFPS3sJZW4BKFunfGEBzFjqZTTUgOBQTrdpk3lc9eO1REp8wAsASB2ykwWxCe+0rAoL
	 jLABjB/yG+qgV83vhSQTajXOYP2Xe5hZTy7yNSpxGXJu2Ga5N7oa1CfTv3/fC+biMtq2k
	 Y1NneUFV9ZpuUNliI1JgChAekLo7xFghd0+nkYmDDoL453e9QZ/P90BbqsUFtg2zcjjq/
	 39siFFkGAD+7PjgxEkXxFlF3VICNRwrhJcIoZn+GJHp+QBSxTP65U2PcM3se2FqVZkeN9
	 IXUb3/Mh4G0ihh6yNncs5J1lUHwjEFRbr/vfPrE+ouvFO7QuYDh5RuFuECDutKR341w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvcYvyi2;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD8606A31C;
	Tue, 17 Nov 2026 06:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BD8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvcYvyi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794897890; x=1826433890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESQjpD8S2LW070yACMHY9t3rIJIM32CEwZ+XZ+1Vu5E=;
  b=gvcYvyi2Z1tJPBKlvSs3Eu9JbUzgSZQbkeY01iIV7guv1lDKYVbim4oT
   fCApOSUphr4v7YAW82Hgmi1byDcMVZ5MDFn7BVhTvr0uCTQieiB8oDBGH
   lheCqJ7kpF6ofSLhmNxAtnN4TL7IHZQKV6cMA2Rnkypc+OXAhwNY1dFsq
   MhVH4NwXUJTS3rNf1hQ7T7UO6VOS87PEdyoWSgK3baNQonvqGE9EpAobY
   hht3QGhxXQTLY1QAPryvO6rbAxCvJLrX89HLQQDhHAaP+ADpiYZq5JOnN
   LGMLGDu1myK8MnH4nbsMdk9D9d3A2CYiUQVu9b8MFaJaHO1iPJeSx/xHQ
   w==;
X-CSE-ConnectionGUID: fegcvc3WRzOaf5YUHhfjQA==
X-CSE-MsgGUID: jpXHJMP1Q+OA0+3OYH72qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3564576"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3564576"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 22:44:49 -0800
X-CSE-ConnectionGUID: K2ZTOQLqQ36QOI5pE7FNuA==
X-CSE-MsgGUID: 3W5u5vGJQKGsicfVVW/6ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10152989"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Nov 2026 22:44:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTCvr-00000001AAp-04dz;
	Tue, 17 Nov 2026 06:44:43 +0000
Date: Tue, 17 Nov 2026 14:44:22 +0800
From: kernel test robot <lkp@intel.com>
To: Hang Nan <2122295973@qq.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	willemb@google.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v5 2/3] net: mptcp: reject token 0 in
 mptcp_token_get_sock()
Message-ID: <202611171407.G0WgWRA6-lkp@intel.com>
References: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>

Hi Hang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hang-Nan/net-mptcp-reject-token-0-in-mptcp_token_get_sock/20261116-225828
base:   net/main
patch link:    https://lore.kernel.org/r/tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05%40qq.com
patch subject: [PATCH net v5 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20261117/202611171407.G0WgWRA6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611171407.G0WgWRA6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611171407.G0WgWRA6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: net/mptcp/mptcp_token_test.ko: symbol 'mptcp_token_exists' undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
