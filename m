Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B8378823;
	Tue, 23 Jun 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210249; cv=none; b=lxnRxcnFaTzw+EjrChEw1hyFVCijoAwYBsGrA/zcAmTnDoYvOzBjsUKB8vVwe2M9VVs7rOutVeDBqSZWiwtJbz61M/lUyROMRybHsuqiVQT017pRK8fyR74sweY1i89YbHyPywo9Dknob8hEenUoJfbOC62ZndmS7ca/q6i11J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210249; c=relaxed/simple;
	bh=wwZXkqFSnEiaLN8CIYwpCsyYEguUbHw0Izyw5ktNuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDbbyKrq1aNE5Jxy4AWSRnjSAMLSgwaesuzM06VPTMX5oELKRAK9786BhUUxfzh/RTY4hSpO1sNfETVt9dO15/cW19hVPO7qLAKcT+ZlsBFoDFInkguZcEuSWdxplhLemh/uAODg+HLLF2zPeHq8PEsTf4181xs4maNtBSbfIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsNZns8U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsNZns8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782210248; x=1813746248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wwZXkqFSnEiaLN8CIYwpCsyYEguUbHw0Izyw5ktNuOk=;
  b=fsNZns8U+fws271aH6IiWXqnsbkdi+Csbm07gAXuJs0gn3TCj9FBjXZ/
   mzF2EbAT80f48lA1SbWxLQEL+Ynh1FyS3cHoSOPHaQmCJUh+LzcQPorwM
   JzWIqLPZ7hpphPUhElupKBY3m3WhUILyq+rN3cfPhr0xbn6axDHlqR8/7
   Y/bn8UonvPKLdB0B0184xOC0gJbKj2Q3SgG+v+pRLGvIH72ogXtWPsrT6
   Er9Mn5llZkoCcQcMtlIPp9M7MwBVvLAmM04JASd0mZcbW/BkMWDSxA4mQ
   J8Y+Ytn3j21NTm8XcpjUrS6ItFANwwrnvtl6lr2X5rk2DbKkKiLd/OnSA
   A==;
X-CSE-ConnectionGUID: QKACltclQ+S/NuEH1im5hA==
X-CSE-MsgGUID: 7Pg7Ywx/R8eJL4o9io6H9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93313789"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93313789"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:24:02 -0700
X-CSE-ConnectionGUID: eISYuP0mSg+qEduzU4O5iA==
X-CSE-MsgGUID: bS9h01+VQ5ihWzvyU+nyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="248332976"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 23 Jun 2026 03:24:00 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbyIP-000000006BP-36Rs;
	Tue, 23 Jun 2026 10:23:57 +0000
Date: Tue, 23 Jun 2026 12:23:15 +0200
From: kernel test robot <lkp@intel.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, matttbe@kernel.org,
	martineau@kernel.org, pabeni@redhat.com, cuitao@kylinos.cn,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	shardul.b@mpiricsoftware.com, janak@mpiric.us,
	kalpanjani009@gmail.com, shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v4 2/2] selftests: mptcp: add regression test for
 stale ADD_ADDR on id 0 removal
Message-ID: <202606231240.AR0wvSEl-lkp@intel.com>
References: <20260622092838.1267134-3-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622092838.1267134-3-kalpan.jani@mpiricsoftware.com>

Hi Kalpan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalpan-Jani/mptcp-pm-drop-pending-ADD_ADDR-when-removing-id-0-endpoint/20260623-033836
base:   net/main
patch link:    https://lore.kernel.org/r/20260622092838.1267134-3-kalpan.jani%40mpiricsoftware.com
patch subject: [PATCH net v4 2/2] selftests: mptcp: add regression test for stale ADD_ADDR on id 0 removal
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260623/202606231240.AR0wvSEl-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260623/202606231240.AR0wvSEl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606231240.AR0wvSEl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mptcp/pm_kernel.c:1154:15: error: call to undeclared function 'mptcp_remove_anno_list_by_saddr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1154 |                 announced = mptcp_remove_anno_list_by_saddr(msk, &anno_addr);
         |                             ^
   1 error generated.


vim +/mptcp_remove_anno_list_by_saddr +1154 net/mptcp/pm_kernel.c

  1127	
  1128	static int mptcp_nl_remove_id_zero_address(struct net *net,
  1129						   struct mptcp_addr_info *addr)
  1130	{
  1131		struct mptcp_rm_list list = { .nr = 0 };
  1132		long s_slot = 0, s_num = 0;
  1133		struct mptcp_sock *msk;
  1134	
  1135		list.ids[list.nr++] = 0;
  1136	
  1137		while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
  1138			struct sock *sk = (struct sock *)msk;
  1139			struct mptcp_addr_info msk_local;
  1140			struct mptcp_addr_info anno_addr;
  1141			bool announced;
  1142	
  1143			if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
  1144				goto next;
  1145	
  1146			mptcp_local_address((struct sock_common *)msk, &msk_local);
  1147			if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
  1148				goto next;
  1149	
  1150			lock_sock(sk);
  1151			/* Drop a possibly pending ADD_ADDR for this address. */
  1152			anno_addr = msk_local;
  1153			anno_addr.port = 0;
> 1154			announced = mptcp_remove_anno_list_by_saddr(msk, &anno_addr);
  1155			spin_lock_bh(&msk->pm.lock);
  1156			if (announced)
  1157				msk->pm.add_addr_signaled--;
  1158			mptcp_pm_remove_addr(msk, &list);
  1159			mptcp_pm_rm_subflow(msk, &list);
  1160			__mark_subflow_endp_available(msk, 0);
  1161			spin_unlock_bh(&msk->pm.lock);
  1162			release_sock(sk);
  1163	
  1164	next:
  1165			sock_put(sk);
  1166			cond_resched();
  1167		}
  1168	
  1169		return 0;
  1170	}
  1171	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
