Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75C15443F;
	Fri, 13 Sep 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207299; cv=none; b=CnpAE+GkPRh7DGd8qXqOsSEtlge2gPlnGtceuR0YTDcRZq0RGjmDbwoL77FU+uflDCLtFrpnVv1XPE/Jnoql40uJ3O6mKRg9m1ZQewFzngei8vw4TL28K+wgMcOJ9Dh8kew52LvVXGEPlcArG7vroaHUJmqxJUK59YeWAsynd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207299; c=relaxed/simple;
	bh=m+v9Op6a3ySmakr4dqhtYEQPprjiNvVD5LxHH4dqhqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eUfQVttnx5e7GHuyo2AuOrlYSTxHsU+QVVQF4W8vUKCD9Zwq7t+UEWKQQTNL9SClSt/oyBd/Ky0dAPSpBMS/Y5Br6zV+qvs25oqqk7RO7HnM4mzkAcrETXgtPVYtbY1hRd8uu6waYiBka15XSV+tnNij+AFoGo/Paxhzpr4uSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0OhB2Hj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0OhB2Hj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726207298; x=1757743298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m+v9Op6a3ySmakr4dqhtYEQPprjiNvVD5LxHH4dqhqg=;
  b=Z0OhB2Hjd6K8XZgPCTeItwDkPeRzUaCPFHdHhD4vDeFvjvWyYWcZ0F/B
   UirnkwRpYuTxTanH66lvQ8E5wCXNQ8dgQC7Dhh50M1ssouOFeJh9JUacK
   0KcHyHghAOiVCNAfrlCaXjvqYJxRw7wDO+LwVrEphzC2lrhgKd9Y9Y9Fz
   2G0PjInO3hCjzU8/Pr6Yr+UrEj2x+i1OrKLQRpEQjx852x5EZsFw+rCX+
   o3VfDxJW2KoEV80cf6nLSQAIO6LrkEFIN5T5x4MfpV/c7g46akcB5H++W
   jOnFcWheBWOanfrKWxBUO1a+xK4hAdp8NQ5uSlWtQzWOw9N2TGRWsBFA1
   Q==;
X-CSE-ConnectionGUID: KBfCEaLuSYGcXs8Rm1W32g==
X-CSE-MsgGUID: jh82GmOZTlKNGBOzHyU6kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24965478"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24965478"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 23:01:37 -0700
X-CSE-ConnectionGUID: e1PjM5AxSSawR8G+WZYcjA==
X-CSE-MsgGUID: M4up2wWSTS6c1a3e9CYd0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="91202927"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2024 23:01:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sozN7-00064E-2M;
	Fri, 13 Sep 2024 06:01:33 +0000
Date: Fri, 13 Sep 2024 14:00:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 6/29] net/hsr/hsr_slave.c:74:34: error: 'struct
 hsr_priv' has no member named 'seqnr_lock'
Message-ID: <202409131325.XoYow2d1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   c1b7e5cd24c0db2a6a351cfba33474545022d1f5
commit: f9cd7819a1b49a8eaa14f5ca178290bdb4258133 [6/29] TopGit-driven merge of branches:
config: openrisc-randconfig-r071-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131325.XoYow2d1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131325.XoYow2d1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131325.XoYow2d1-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/hsr/hsr_slave.c: In function 'hsr_handle_frame':
>> net/hsr/hsr_slave.c:74:34: error: 'struct hsr_priv' has no member named 'seqnr_lock'
      74 |                 spin_lock_bh(&hsr->seqnr_lock);
         |                                  ^~
   net/hsr/hsr_slave.c:76:36: error: 'struct hsr_priv' has no member named 'seqnr_lock'
      76 |                 spin_unlock_bh(&hsr->seqnr_lock);
         |                                    ^~


vim +74 net/hsr/hsr_slave.c

451d8123f89791 Murali Karicheri          2020-07-22  23  
f266a683a4804d Arvid Brodin              2014-07-04  24  static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
51f3c605318b05 Arvid Brodin              2014-07-04  25  {
f266a683a4804d Arvid Brodin              2014-07-04  26  	struct sk_buff *skb = *pskb;
f266a683a4804d Arvid Brodin              2014-07-04  27  	struct hsr_port *port;
451d8123f89791 Murali Karicheri          2020-07-22  28  	struct hsr_priv *hsr;
f5dda315b63775 Murali Karicheri          2020-05-06  29  	__be16 protocol;
51f3c605318b05 Arvid Brodin              2014-07-04  30  
451d8123f89791 Murali Karicheri          2020-07-22  31  	/* Packets from dev_loopback_xmit() do not have L2 header, bail out */
451d8123f89791 Murali Karicheri          2020-07-22  32  	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
451d8123f89791 Murali Karicheri          2020-07-22  33  		return RX_HANDLER_PASS;
451d8123f89791 Murali Karicheri          2020-07-22  34  
f266a683a4804d Arvid Brodin              2014-07-04  35  	if (!skb_mac_header_was_set(skb)) {
f266a683a4804d Arvid Brodin              2014-07-04  36  		WARN_ONCE(1, "%s: skb invalid", __func__);
f266a683a4804d Arvid Brodin              2014-07-04  37  		return RX_HANDLER_PASS;
51f3c605318b05 Arvid Brodin              2014-07-04  38  	}
51f3c605318b05 Arvid Brodin              2014-07-04  39  
f266a683a4804d Arvid Brodin              2014-07-04  40  	port = hsr_port_get_rcu(skb->dev);
2b5b8251bc9fe2 Eric Dumazet              2020-02-03  41  	if (!port)
2b5b8251bc9fe2 Eric Dumazet              2020-02-03  42  		goto finish_pass;
451d8123f89791 Murali Karicheri          2020-07-22  43  	hsr = port->hsr;
51f3c605318b05 Arvid Brodin              2014-07-04  44  
f266a683a4804d Arvid Brodin              2014-07-04  45  	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
f266a683a4804d Arvid Brodin              2014-07-04  46  		/* Directly kill frames sent by ourselves */
f266a683a4804d Arvid Brodin              2014-07-04  47  		kfree_skb(skb);
f266a683a4804d Arvid Brodin              2014-07-04  48  		goto finish_consume;
51f3c605318b05 Arvid Brodin              2014-07-04  49  	}
51f3c605318b05 Arvid Brodin              2014-07-04  50  
dcf0cd1cc58b8e George McCollister        2021-02-09  51  	/* For HSR, only tagged frames are expected (unless the device offloads
dcf0cd1cc58b8e George McCollister        2021-02-09  52  	 * HSR tag removal), but for PRP there could be non tagged frames as
dcf0cd1cc58b8e George McCollister        2021-02-09  53  	 * well from Single attached nodes (SANs).
451d8123f89791 Murali Karicheri          2020-07-22  54  	 */
ee1c2797728490 Peter Heise               2016-04-13  55  	protocol = eth_hdr(skb)->h_proto;
dcf0cd1cc58b8e George McCollister        2021-02-09  56  
dcf0cd1cc58b8e George McCollister        2021-02-09  57  	if (!(port->dev->features & NETIF_F_HW_HSR_TAG_RM) &&
5055cccfc2d1cc Lukasz Majewski           2024-04-23  58  	    port->type != HSR_PT_INTERLINK &&
dcf0cd1cc58b8e George McCollister        2021-02-09  59  	    hsr->proto_ops->invalid_dan_ingress_frame &&
451d8123f89791 Murali Karicheri          2020-07-22  60  	    hsr->proto_ops->invalid_dan_ingress_frame(protocol))
f266a683a4804d Arvid Brodin              2014-07-04  61  		goto finish_pass;
51f3c605318b05 Arvid Brodin              2014-07-04  62  
f266a683a4804d Arvid Brodin              2014-07-04  63  	skb_push(skb, ETH_HLEN);
48b491a5cc7433 George McCollister        2021-05-24  64  	skb_reset_mac_header(skb);
48b491a5cc7433 George McCollister        2021-05-24  65  	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
48b491a5cc7433 George McCollister        2021-05-24  66  	    protocol == htons(ETH_P_HSR))
48b491a5cc7433 George McCollister        2021-05-24  67  		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
48b491a5cc7433 George McCollister        2021-05-24  68  	skb_reset_mac_len(skb);
451d8123f89791 Murali Karicheri          2020-07-22  69  
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  70  	/* Only the frames received over the interlink port will assign a
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  71  	 * sequence number and require synchronisation vs other sender.
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  72  	 */
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  73  	if (port->type == HSR_PT_INTERLINK) {
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06 @74  		spin_lock_bh(&hsr->seqnr_lock);
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  75  		hsr_forward_skb(skb, port);
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  76  		spin_unlock_bh(&hsr->seqnr_lock);
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  77  	} else {
f266a683a4804d Arvid Brodin              2014-07-04  78  		hsr_forward_skb(skb, port);
430d67bdcb04ee Sebastian Andrzej Siewior 2024-09-06  79  	}
81ba6afd6e6443 Arvid Brodin              2014-07-04  80  
f266a683a4804d Arvid Brodin              2014-07-04  81  finish_consume:
f266a683a4804d Arvid Brodin              2014-07-04  82  	return RX_HANDLER_CONSUMED;
81ba6afd6e6443 Arvid Brodin              2014-07-04  83  
f266a683a4804d Arvid Brodin              2014-07-04  84  finish_pass:
f266a683a4804d Arvid Brodin              2014-07-04  85  	return RX_HANDLER_PASS;
81ba6afd6e6443 Arvid Brodin              2014-07-04  86  }
81ba6afd6e6443 Arvid Brodin              2014-07-04  87  

:::::: The code at line 74 was first introduced by commit
:::::: 430d67bdcb04ee8502c2b10dcbaced4253649189 net: hsr: Use the seqnr lock for frames received via interlink port.

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
