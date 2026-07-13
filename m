Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10722431E5F;
	Mon, 13 Jul 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949132; cv=none; b=NkGNgz5hEfkWE18/hX7oFFb+gtwPaJRnhuHvVHE+iuBOg3JfUIkMS/nZNtbVkLHiWBYJbNN0yOHiFG9wUIaoR8S84cKr63QqdONDvCRR6Up52QBdyVvw6EBq+Oy2YiDjpMeDFc32tHkj6OWlnd8sghCihzQQYh8DuUbjO7RTYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949132; c=relaxed/simple;
	bh=YTZIugLN4IiaJdfBc70pfN2xjrX1JYrbfy7t5+whm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO5jmZ9bvPoxpkIb5KSmrO3+eOvxJhjSeZyh4E8RZWih2W0UiUrbyaBWv74vjwztFnTB6uMTKYMwEjUF8u0QXTLd2lL1uGzG2lIa2y8l98keS1FlDDjw/pvcFG3rD4rnyz0ARrPkmek6FPah6Rg76c22+3+sAL0Uj5dFsU+v9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH6JRsxZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH6JRsxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783949131; x=1815485131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YTZIugLN4IiaJdfBc70pfN2xjrX1JYrbfy7t5+whm/A=;
  b=YH6JRsxZJh4B8ljTgect/WRyfuGiYCX5hR3+H7z9vSPTPlAIf5DvOc0b
   h2Zk3Fs7gix5zSSDhgP8j7CrmfEa+XUhSN5PpbdtqKhe0MBXc7bwjgJFs
   K2/g3Wtu5Or/A3Fw2AdQ77cYcDMUOScY5EFC8iyNh/YItuhm9S/gDNeIR
   74a7RcX57/bOz2jyoo2hD1tH+nwCi0Fj0prRg/w7lrJCKIoOGueGTtCeo
   qEmcCKE3lfIKlMPrnvuSL67tE3QNYSmSRGil8NDmVDK1S3odgJUnbqonr
   07B6yYbQ3WCzaxsIkGc7ZPDAc8XKvHkINgtcsh4AfjxK4iiw+VNy/R9rt
   A==;
X-CSE-ConnectionGUID: WzMsb1ZgTkGN52HxI0Ilvw==
X-CSE-MsgGUID: gQ4f+eRzSraNKGkq1tXBVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83535564"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83535564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:25:20 -0700
X-CSE-ConnectionGUID: +lCnMDODQaOe+e/33U3UUw==
X-CSE-MsgGUID: 21JMF5jpTASzccV2oFwccQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259136810"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2026 06:25:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjGep-00000000Lid-3xXF;
	Mon, 13 Jul 2026 13:25:15 +0000
Date: Mon, 13 Jul 2026 21:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: David 'equinox' Lamparter <equinox@diac24.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: Re: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <202607132109.n8GCw6cD-lkp@intel.com>
References: <20260713080634.296011-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713080634.296011-1-equinox@diac24.net>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-equinox-Lamparter/mptcp-sockopt-implement-IPV6_TCLASS/20260713-162825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260713080634.296011-1-equinox%40diac24.net
patch subject: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
config: sparc-randconfig-001 (https://download.01.org/0day-ci/archive/20260713/202607132109.n8GCw6cD-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260713/202607132109.n8GCw6cD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607132109.n8GCw6cD-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: net/mptcp/sockopt.o: in function `mptcp_setsockopt_v6':
>> sockopt.c:(.text+0x908): undefined reference to `ipv6_setsockopt'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
