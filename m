Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607E634;
	Tue, 23 Jul 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714002; cv=none; b=AEegzMZ3vV3hS+EaeOwuZ9Rl1618az1BE3KbHRImeqIbjoewQKmxSMGeL8SGz5ZMzWyqsO1CGrd6WF2aP65hdCHkWeyHQcyfmmGXJfLD2svdWgiXEYrr7XVzSjffy1Fvao7lSLpU5YwttyvHit68m3d82hdORIGC2wF/h9P26LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714002; c=relaxed/simple;
	bh=4EZGZDSgQv/w9UIyFMTgMZntzm/z8aluti6yvXV5g6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQAdDXJjkyVZ73LaXdkRo+5taHv8zVCfMy5TqlxB1QhfUBmUvWP+MoX3B2bZ7oo+rctAW2GV825VzRRGUO+qIjhLr/arkZDLTQwhvQqNgpD5o7Cou1mrji185XuNx3mKFZicFnsrdEwdLdT4fZfNBvJEMNsorBCbmL9mowksLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb0904Bt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb0904Bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721714001; x=1753250001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4EZGZDSgQv/w9UIyFMTgMZntzm/z8aluti6yvXV5g6w=;
  b=lb0904Bt3ERl/8WGTAsEkiVcDHkisLEg4p/fQ97ntUJyabAletqtsNPv
   mGbQM++i3bHtKGNr4vaIPB5bcD/9MB4uAK+SMSS3pguwCgt7XGGm/Kx8v
   uH/My8GUc2nc273Zz5BO3sKxEJCm+WS/TJ3GqBiyncGD7N63UimROtMns
   NF4buPOqgSyB32pxrzf6LjwqhZ5aO6cfGYmXwb4PM0ubHTOfZ1xODgyPs
   K3q2Icu7YWxQhENjRUbLfzf0OtVlIdPvK/QXJryQWl0B2YRYP456LPCri
   1rY9AruH/iUkhb11/eYG2v4bHC6G0/UW2+Zpj7okawsszOpPwHJBKBkAD
   w==;
X-CSE-ConnectionGUID: sk/zfhwjSAq14wPGmp3wHA==
X-CSE-MsgGUID: KzNlL7gfTmmNB9agqshjUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="18934525"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="18934525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 22:53:20 -0700
X-CSE-ConnectionGUID: eWYOkQk5QJ29bkhkYYxqTQ==
X-CSE-MsgGUID: uv1JDZZcR0qwwBGQwTuIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52726929"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Jul 2024 22:53:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW8SZ-000lge-2X;
	Tue, 23 Jul 2024 05:53:15 +0000
Date: Tue, 23 Jul 2024 13:52:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-net v4 23/23] mptcp: pm: reduce entries iterations
 on connect
Message-ID: <202407231303.CsUy96BP-lkp@intel.com>
References: <20240722-mptcp-pm-avail-v4-23-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-mptcp-pm-avail-v4-23-15bfd73de384@kernel.org>

Hi Matthieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 140ff27ee47286bb0a270f3aa275fc319724da8d]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthieu-Baerts-NGI0/mptcp-fully-established-after-ADD_ADDR-echo-on-MPJ/20240723-035843
base:   140ff27ee47286bb0a270f3aa275fc319724da8d
patch link:    https://lore.kernel.org/r/20240722-mptcp-pm-avail-v4-23-15bfd73de384%40kernel.org
patch subject: [PATCH mptcp-net v4 23/23] mptcp: pm: reduce entries iterations on connect
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240723/202407231303.CsUy96BP-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231303.CsUy96BP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407231303.CsUy96BP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mptcp/subflow.c:10:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/mptcp/subflow.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from net/mptcp/subflow.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from net/mptcp/subflow.c:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/mptcp/subflow.c:1580:34: error: no member named 'addr6' in 'struct mptcp_addr_info'; did you mean 'addr'?
    1580 |                 if (ipv6_addr_any(&local->addr.addr6))
         |                                                ^~~~~
         |                                                addr
   include/net/mptcp.h:55:18: note: 'addr' declared here
      55 |                 struct in_addr  addr;
         |                                 ^
   17 warnings and 1 error generated.


vim +1580 net/mptcp/subflow.c

  1546	
  1547	int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
  1548				    const struct mptcp_addr_info *remote)
  1549	{
  1550		struct mptcp_sock *msk = mptcp_sk(sk);
  1551		struct mptcp_subflow_context *subflow;
  1552		int local_id = local->addr.id;
  1553		struct sockaddr_storage addr;
  1554		int remote_id = remote->id;
  1555		int err = -ENOTCONN;
  1556		struct socket *sf;
  1557		struct sock *ssk;
  1558		u32 remote_token;
  1559		int addrlen;
  1560	
  1561		if (!mptcp_is_fully_established(sk))
  1562			goto err_out;
  1563	
  1564		err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
  1565		if (err)
  1566			goto err_out;
  1567	
  1568		ssk = sf->sk;
  1569		subflow = mptcp_subflow_ctx(ssk);
  1570		do {
  1571			get_random_bytes(&subflow->local_nonce, sizeof(u32));
  1572		} while (!subflow->local_nonce);
  1573	
  1574		/* if 'IPADDRANY', the ID will be set later, after the routing */
  1575		if (local->addr.family == AF_INET) {
  1576			if (!local->addr.addr.s_addr)
  1577				local_id = -1;
  1578	#if IS_ENABLED(CONFIG_IPV6)
  1579		} else if (sk->sk_family == AF_INET6) {
> 1580			if (ipv6_addr_any(&local->addr.addr6))
  1581				local_id = -1;
  1582	#endif
  1583		}
  1584	
  1585		if (local_id >= 0)
  1586			subflow_set_local_id(subflow, local_id);
  1587	
  1588		subflow->remote_key_valid = 1;
  1589		subflow->remote_key = READ_ONCE(msk->remote_key);
  1590		subflow->local_key = READ_ONCE(msk->local_key);
  1591		subflow->token = msk->token;
  1592		mptcp_info2sockaddr(&local->addr, &addr, ssk->sk_family);
  1593	
  1594		addrlen = sizeof(struct sockaddr_in);
  1595	#if IS_ENABLED(CONFIG_MPTCP_IPV6)
  1596		if (addr.ss_family == AF_INET6)
  1597			addrlen = sizeof(struct sockaddr_in6);
  1598	#endif
  1599		ssk->sk_bound_dev_if = local->ifindex;
  1600		err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
  1601		if (err)
  1602			goto failed;
  1603	
  1604		mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
  1605		pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
  1606			 remote_token, local_id, remote_id);
  1607		subflow->remote_token = remote_token;
  1608		WRITE_ONCE(subflow->remote_id, remote_id);
  1609		subflow->request_join = 1;
  1610		subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
  1611		subflow->subflow_id = msk->subflow_id++;
  1612		mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
  1613	
  1614		sock_hold(ssk);
  1615		list_add_tail(&subflow->node, &msk->conn_list);
  1616		err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
  1617		if (err && err != -EINPROGRESS)
  1618			goto failed_unlink;
  1619	
  1620		/* discard the subflow socket */
  1621		mptcp_sock_graft(ssk, sk->sk_socket);
  1622		iput(SOCK_INODE(sf));
  1623		WRITE_ONCE(msk->allow_infinite_fallback, false);
  1624		mptcp_stop_tout_timer(sk);
  1625		return 0;
  1626	
  1627	failed_unlink:
  1628		list_del(&subflow->node);
  1629		sock_put(mptcp_subflow_tcp_sock(subflow));
  1630	
  1631	failed:
  1632		subflow->disposable = 1;
  1633		sock_release(sf);
  1634	
  1635	err_out:
  1636		/* we account subflows before the creation, and this failures will not
  1637		 * be caught by sk_state_change()
  1638		 */
  1639		mptcp_pm_close_subflow(msk);
  1640		return err;
  1641	}
  1642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
