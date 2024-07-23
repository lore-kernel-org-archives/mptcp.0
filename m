Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F31DA22;
	Tue, 23 Jul 2024 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703436; cv=none; b=RTZsnqzC+ZUwe3iZN3eRVlSi2eOQwZnlpHTzJoC/e8CEHEgQXAuepkVPgoXXQ3rqc8NBq3Fw5SzDbQr0efAULqK6IZ/nW/la9sv7ait6XQxdh2H1P+FBruJMnwYtOEJirxOTBRgZvhu5g6S6JNESNiIaxZKEHNvlRh+x4p/dM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703436; c=relaxed/simple;
	bh=KyvsydBaMqUsShDBZS37JrBBIA/ZU2ydrTEjgDTPiuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBe4BhuznrDQeawfQYzBlVNlVYP5MgmFXDyApHPlahOBxWcIWZFoeYre3nf3HFLmP0cAjKrmb0faMecKkGCpBeE+FM0kiMvDJZqrkEdao48btG4NMdWeEoNOkPRTo9T+oavRF0lL3doRWlz6JKSeuSctCkhqkK28VCNfiHUbKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTKGjwd3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTKGjwd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721703435; x=1753239435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyvsydBaMqUsShDBZS37JrBBIA/ZU2ydrTEjgDTPiuc=;
  b=HTKGjwd3zKiSWqoYLJlZ+CT4Ww2kGNVxWOeGMp5arvvzF6PRlLOgkweD
   08zxI1DxtRtVzMLXM1TSsasApmWaYB6nETTBeB2zhGmn9CT0xE9uNgeGY
   JnShB+xCnRJAYgo9ZT3zatNnISLtspknEfKH0ucUR4uLHrnvtL1UP4gzM
   mbou3GdxWFLWi6Rpur2lg3We3PSyx+Oy4nwGI2qne9pJ/b3D/DqwEiVTu
   oFvPV6H6aBuCA1fU8HLkYJQmMryLHlBu+76LxzUSa6Yv60rWSCUhHG73j
   fQJFZ4/2MdXdiPuKF+fkvWy5fK0VAZ52EPFjZT5hMqQk6Ha+/9LXLN5fr
   A==;
X-CSE-ConnectionGUID: yabezqaMSt+cJeNDvtkMMg==
X-CSE-MsgGUID: 1a/FxxkXTk2IN2BcFnpcgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19180320"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="19180320"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 19:57:12 -0700
X-CSE-ConnectionGUID: ASqvKW3tS1SEjnDoebRVwg==
X-CSE-MsgGUID: rcU60Z7+SYWMcCsXYUC2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="52826781"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Jul 2024 19:57:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW5i8-000laC-0K;
	Tue, 23 Jul 2024 02:57:08 +0000
Date: Tue, 23 Jul 2024 10:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-net v4 23/23] mptcp: pm: reduce entries iterations
 on connect
Message-ID: <202407231046.JRpmrtkT-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240723/202407231046.JRpmrtkT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231046.JRpmrtkT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407231046.JRpmrtkT-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mptcp/subflow.c: In function '__mptcp_subflow_connect':
>> net/mptcp/subflow.c:1580:48: error: 'const struct mptcp_addr_info' has no member named 'addr6'; did you mean 'addr'?
    1580 |                 if (ipv6_addr_any(&local->addr.addr6))
         |                                                ^~~~~
         |                                                addr


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
