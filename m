Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599B1D61A3;
	Tue, 14 Apr 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149703; cv=none; b=CA0LehnN6RbJpt5NLgkES2Hj1nza9tuunPboL0wj5H0DaJrGEeb3n1WDB/trg/MiQgsl0PI4UtxKQDZoDHktm/xwq6zm9bCmnarsEHwrBIdyy52/N1CWGSlu91XG2E+9RXUy4O3AcnM7euPKunnh0J2gdLk0A7t6FKyR0HB26Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149703; c=relaxed/simple;
	bh=48uY8Yr6mrulRwh4NSVYgz8aOPw2kADAr0C+CpGSsMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k4tSiDofSDl493MGunHBK6zNEJUUrvL6uyCXrfcHbyi0jb6c0tz6Cqgn6ae9y/E3Cskc9VIDj4EidP/BJBuVB7uHeUt9F2BcNz661Rh75p51+sn9nZToiI7Rnu2wCDbr4AN1wVuuFJ4i5grPo93bT9HEEGKBYaNPjy/FEOqXNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8qnW20k; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8qnW20k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776149701; x=1807685701;
  h=date:from:to:cc:subject:message-id;
  bh=48uY8Yr6mrulRwh4NSVYgz8aOPw2kADAr0C+CpGSsMY=;
  b=C8qnW20kgYBJiTJRDC4EiZ0t30tOwCp7jqRhmezDIfbrHHGq7tThMqRS
   72AJ+iDA3qq4yXhzz6dXhrHvAnC2DQF/p6GO1ZkHVdMUZRcKPYEL6dRUr
   FD/AdYS+orjMuW+Tf0p2wOPXijjLrYTxAPMWM6Oq0JdxI48ObLee391cs
   Xkn3hK4VwKP2YuMDblf6tbCzeeALvE/q1McE+QDXsvFiNNQDJqNj40DKU
   3a5UMT7NDlcLVFtMX9XEIlNS/oWhjesUFd95C/j8DSPNf71qLLm1xvYuY
   cWBMMPQarHvhgYhx7dP6PuzP6OopZu6STjuoZ7qMwLhcxDqUcz6Jdf0jl
   w==;
X-CSE-ConnectionGUID: hlZertI2SFqIqvyswQt4iQ==
X-CSE-MsgGUID: LvvO9yjbT+CcC3yHoM44JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77003763"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77003763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 23:55:00 -0700
X-CSE-ConnectionGUID: Ptb2NbFZSGmxZ+4zK2p6rg==
X-CSE-MsgGUID: Y8lSVD23R0W5PPTtxyc9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229129098"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 13 Apr 2026 23:54:58 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCXfk-000000000Lx-1THA;
	Tue, 14 Apr 2026 06:54:56 +0000
Date: Tue, 14 Apr 2026 08:54:40 +0200
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 6/27] include/net/sch_generic.h:1203:39:
 warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum
 skb_drop_reason'
Message-ID: <202604140826.OEgqGMGh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   75aa4557daa0edb98d48ab835de0a6badda5c1f1
commit: 23dd38834c40d151dce2449203dee4421efec2ed [6/27] TopGit-driven merge of branches:
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260414/202604140826.OEgqGMGh-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260414/202604140826.OEgqGMGh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604140826.OEgqGMGh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/filter.h:27,
                    from kernel/extable.c:14:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from drivers/net/ethernet/broadcom/bnx2.c:43:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/broadcom/bnx2.c: In function 'bnx2_setup_int_mode':
   drivers/net/ethernet/broadcom/bnx2.c:6288:56: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
    6288 |                 snprintf(bp->irq_tbl[i].name, len, "%s-%d", dev->name, i);
         |                                                        ^~
   In function 'bnx2_enable_msix',
       inlined from 'bnx2_setup_int_mode' at drivers/net/ethernet/broadcom/bnx2.c:6314:3:
   drivers/net/ethernet/broadcom/bnx2.c:6288:52: note: directive argument in the range [0, 2147483646]
    6288 |                 snprintf(bp->irq_tbl[i].name, len, "%s-%d", dev->name, i);
         |                                                    ^~~~~~~
   drivers/net/ethernet/broadcom/bnx2.c:6288:17: note: 'snprintf' output between 3 and 27 bytes into a destination of size 18
    6288 |                 snprintf(bp->irq_tbl[i].name, len, "%s-%d", dev->name, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from include/net/tls.h:47,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:69:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'setup_sge_queues':
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1074:48: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 8 and 23 [-Wformat-truncation=]
    1074 |                                          "%s-Rx%d", dev->name, j);
         |                                                ^~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1074:42: note: directive argument in the range [-2147483641, 254]
    1074 |                                          "%s-Rx%d", dev->name, j);
         |                                          ^~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1072:33: note: 'snprintf' output between 5 and 30 bytes into a destination of size 26
    1072 |                                 snprintf(adap->msix_info[msix].desc,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1073 |                                          sizeof(adap->msix_info[msix].desc),
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1074 |                                          "%s-Rx%d", dev->name, j);
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'cxgb4_port_mirror_alloc_queues':
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1356:47: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 16 [-Wformat-truncation=]
    1356 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                               ^~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1356:34: note: directive argument in the range [0, 65534]
    1356 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1354:25: note: 'snprintf' output between 12 and 31 bytes into a destination of size 26
    1354 |                         snprintf(mirror_rxq->msix->desc,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1355 |                                  sizeof(mirror_rxq->msix->desc),
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1356 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from include/net/tls.h:47,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h:43,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:59,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:9:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c: In function 'get_drvinfo':
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:209:52: warning: '%u' directive output may be truncated writing between 1 and 3 bytes into a region of size between 0 and 14 [-Wformat-truncation=]
     209 |                          "%u.%u.%u.%u, TP %u.%u.%u.%u",
         |                                                    ^~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:209:26: note: directive argument in the range [0, 255]
     209 |                          "%u.%u.%u.%u, TP %u.%u.%u.%u",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:208:17: note: 'snprintf' output between 20 and 36 bytes into a destination of size 32
     208 |                 snprintf(info->fw_version, sizeof(info->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     209 |                          "%u.%u.%u.%u, TP %u.%u.%u.%u",
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     210 |                          FW_HDR_FW_VER_MAJOR_G(adapter->params.fw_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     211 |                          FW_HDR_FW_VER_MINOR_G(adapter->params.fw_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     212 |                          FW_HDR_FW_VER_MICRO_G(adapter->params.fw_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     213 |                          FW_HDR_FW_VER_BUILD_G(adapter->params.fw_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     214 |                          FW_HDR_FW_VER_MAJOR_G(adapter->params.tp_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     215 |                          FW_HDR_FW_VER_MINOR_G(adapter->params.tp_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     216 |                          FW_HDR_FW_VER_MICRO_G(adapter->params.tp_vers),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     217 |                          FW_HDR_FW_VER_BUILD_G(adapter->params.tp_vers));
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from include/net/tls.h:47,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h:43,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:59,
                    from drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:48:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c: In function 'alloc_uld_rxqs':
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:141:38: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size between 10 and 25 [-Wformat-truncation=]
     141 |                                  "%s-%s%d",
         |                                      ^~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:141:34: note: directive argument in the range [0, 131069]
     141 |                                  "%s-%s%d",
         |                                  ^~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:139:25: note: 'snprintf' output between 3 and 38 bytes into a destination of size 26
     139 |                         snprintf(adap->msix_info[msi_idx].desc,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     140 |                                  sizeof(adap->msix_info[msi_idx].desc),
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     141 |                                  "%s-%s%d",
         |                                  ~~~~~~~~~~
     142 |                                  adap->port[0]->name, rxq_info->name, i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from net/netfilter/ipvs/ip_vs_core.c:33:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_in_icmp':
   net/netfilter/ipvs/ip_vs_core.c:1769:15: warning: variable 'outer_proto' set but not used [-Wunused-but-set-variable]
    1769 |         char *outer_proto = "IPIP";
         |               ^~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/xdp.h:10,
                    from include/net/busy_poll.h:19,
                    from drivers/net/ethernet/cisco/enic/enic_main.c:47:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/cisco/enic/enic_main.c: In function 'enic_request_intr':
   drivers/net/ethernet/cisco/enic/enic_main.c:1576:40: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
    1576 |                                 "%s-rx-%u", netdev->name, i);
         |                                        ^~
   drivers/net/ethernet/cisco/enic/enic_main.c:1576:33: note: directive argument in the range [0, 4294967294]
    1576 |                                 "%s-rx-%u", netdev->name, i);
         |                                 ^~~~~~~~~~
   drivers/net/ethernet/cisco/enic/enic_main.c:1574:25: note: 'snprintf' output between 6 and 30 bytes into a destination of size 24
    1574 |                         snprintf(enic->msix[intr].devname,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1575 |                                 sizeof(enic->msix[intr].devname),
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1576 |                                 "%s-rx-%u", netdev->name, i);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/cisco/enic/enic_main.c:1587:40: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
    1587 |                                 "%s-tx-%u", netdev->name, i);
         |                                        ^~
   drivers/net/ethernet/cisco/enic/enic_main.c:1587:33: note: directive argument in the range [0, 4294967294]
    1587 |                                 "%s-tx-%u", netdev->name, i);
         |                                 ^~~~~~~~~~
   drivers/net/ethernet/cisco/enic/enic_main.c:1585:25: note: 'snprintf' output between 6 and 30 bytes into a destination of size 24
    1585 |                         snprintf(enic->msix[intr].devname,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1586 |                                 sizeof(enic->msix[intr].devname),
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1587 |                                 "%s-tx-%u", netdev->name, i);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from drivers/net/ethernet/emulex/benet/be.h:20,
                    from drivers/net/ethernet/emulex/benet/be_ethtool.c:14:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/emulex/benet/be_ethtool.c: In function 'be_get_drvinfo':
   drivers/net/ethernet/emulex/benet/be_ethtool.c:229:29: warning: ' [' directive output may be truncated writing 2 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     229 |                          "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
         |                             ^~
   drivers/net/ethernet/emulex/benet/be_ethtool.c:228:17: note: 'snprintf' output between 4 and 66 bytes into a destination of size 32
     228 |                 snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     229 |                          "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from drivers/net/ethernet/myricom/myri10ge/myri10ge.c:71:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_request_irq':
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:2197:44: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 10 and 25 [-Wformat-truncation=]
    2197 |                                  "%s:slice-%d", netdev->name, i);
         |                                            ^~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:2197:34: note: directive argument in the range [-2147483643, 2147483646]
    2197 |                                  "%s:slice-%d", netdev->name, i);
         |                                  ^~~~~~~~~~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:2196:25: note: 'snprintf' output between 9 and 34 bytes into a destination of size 32
    2196 |                         snprintf(ss->irq_desc, sizeof(ss->irq_desc),
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2197 |                                  "%s:slice-%d", netdev->name, i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:36,
                    from drivers/net/ethernet/qlogic/qede/qede_main.c:28:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/qlogic/qede/qede_main.c: In function 'qede_init_fp':
   drivers/net/ethernet/qlogic/qede/qede_main.c:1881:61: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
    1881 |                 snprintf(fp->name, sizeof(fp->name), "%s-fp-%d",
         |                                                             ^~
   drivers/net/ethernet/qlogic/qede/qede_main.c:1881:54: note: directive argument in the range [-2147483641, 65534]
    1881 |                 snprintf(fp->name, sizeof(fp->name), "%s-fp-%d",
         |                                                      ^~~~~~~~~~
   drivers/net/ethernet/qlogic/qede/qede_main.c:1881:17: note: 'snprintf' output between 6 and 31 bytes into a destination of size 24
    1881 |                 snprintf(fp->name, sizeof(fp->name), "%s-fp-%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1882 |                          edev->ndev->name, queue_id);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:27,
                    from include/net/xdp.h:10,
                    from drivers/net/ethernet/qlogic/qede/qede.h:16,
                    from drivers/net/ethernet/qlogic/qede/qede_ethtool.c:17:
   include/net/sch_generic.h: In function 'qdisc_dequeue_drop':
>> include/net/sch_generic.h:1203:39: warning: implicit conversion from 'enum qdisc_drop_reason' to 'enum skb_drop_reason' [-Wenum-conversion]
    1203 |                 kfree_skb_reason(skb, reason);
         |                                       ^~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c: In function 'qede_get_drvinfo':
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:621:34: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 25 [-Wformat-truncation=]
     621 |                          "[storm %s]", storm);
         |                                  ^~    ~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:620:17: note: 'snprintf' output between 9 and 40 bytes into a destination of size 32
     620 |                 snprintf(info->version, sizeof(info->version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     621 |                          "[storm %s]", storm);
         |                          ~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:638:31: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 28 [-Wformat-truncation=]
     638 |                          "mfw %s", mfw);
         |                               ^~   ~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:637:17: note: 'snprintf' output between 5 and 36 bytes into a destination of size 32
     637 |                 snprintf(info->fw_version, sizeof(info->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     638 |                          "mfw %s", mfw);
         |                          ~~~~~~~~~~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:635:31: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 28 [-Wformat-truncation=]
     635 |                          "mbi %s [mfw %s]", mbi, mfw);
         |                               ^~            ~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:634:17: note: 'snprintf' output between 12 and 74 bytes into a destination of size 32
     634 |                 snprintf(info->fw_version, sizeof(info->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     635 |                          "mbi %s [mfw %s]", mbi, mfw);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
..


vim +1203 include/net/sch_generic.h

0170d7f47c8bb0 Eric Dumazet               2025-11-21  1186  
191ff13e42a7b7 Eric Dumazet               2025-11-21  1187  static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
ff2998f29f390d Jesper Dangaard Brouer     2026-02-26  1188  				      enum qdisc_drop_reason reason)
191ff13e42a7b7 Eric Dumazet               2025-11-21  1189  {
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1190  	struct Qdisc *root;
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1191  
191ff13e42a7b7 Eric Dumazet               2025-11-21  1192  	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
191ff13e42a7b7 Eric Dumazet               2025-11-21  1193  	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
191ff13e42a7b7 Eric Dumazet               2025-11-21  1194  
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1195  	rcu_read_lock();
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1196  	root = qdisc_root_sleeping(q);
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1197  
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1198  	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
ff2998f29f390d Jesper Dangaard Brouer     2026-02-26  1199  		tcf_set_qdisc_drop_reason(skb, reason);
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1200  		skb->next = root->to_free;
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1201  		root->to_free = skb;
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1202  	} else {
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08 @1203  		kfree_skb_reason(skb, reason);
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1204  	}
a6bd339dbb3514 Fernando Fernandez Mancera 2026-04-08  1205  	rcu_read_unlock();
191ff13e42a7b7 Eric Dumazet               2025-11-21  1206  }
191ff13e42a7b7 Eric Dumazet               2025-11-21  1207  

:::::: The code at line 1203 was first introduced by commit
:::::: a6bd339dbb3514bce690fdcf252e788dfab4ee76 net_sched: fix skb memory leak in deferred qdisc drops

:::::: TO: Fernando Fernandez Mancera <fmancera@suse.de>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
