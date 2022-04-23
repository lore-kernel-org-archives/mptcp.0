Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEA7A
	for <mptcp@lists.linux.dev>; Sat, 23 Apr 2022 04:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650689867; x=1682225867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mN2fVntLNkuIjLe8kXl4zmVwIz47xfaavaR9Ir3fv8I=;
  b=Yd2gl2tzJwR+8z2JUWudCiYfdIXS+wLb6UaWMIpRYxUaiKnO5uQzDsi3
   do+0X0rhhi571+WQ1VlL3ZylClb+1bYt75CIkxl28f2wGWCWygcwg0pOq
   hRQKGSNC1A1Mlb0LQWPBc7lR7LM5vA3/5VyTR018/Y/0Vt6eoSxVRvpRX
   s8LEr5J8YpQIbTU1f78R62ot8WcpVUTM899eVVlnisLJ82vcTzJzaG4/k
   hPF87fep5LPfunOgMDyUDgNSeotGceO2ZkDSXCpEmwmySDARQwqwPt3PE
   IeIWw5CNxbFH3EefBuveN2aseMW7mv0izIBLBPsPb9CJOElJAqMEcZEPW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351298570"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="351298570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="728823776"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 21:57:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1ni7q4-000B1z-VH;
	Sat, 23 Apr 2022 04:57:44 +0000
Date: Sat, 23 Apr 2022 12:56:58 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kbuild-all@lists.01.org, mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [mptcp:export 12/68] net/mptcp/options.c:1254:3-4: Unneeded semicolon
Message-ID: <202204231205.qD8O1MNA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   242bc8552034f5b320b9f66f00a528a317b4dc4a
commit: 57b108d2e6211ae04a366f93dfebcc8a3f7d5ccf [12/68] mptcp: never shrink offered window
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220423/202204231205.qD8O1MNA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> net/mptcp/options.c:1254:3-4: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
