Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294822CA6
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cjrS/POR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF+LbYr+cIDyhABHgYYhWlSUMPhHz2mORiktbx2i5JOab9V6k93lh32INxnodfxmhEOWMRaMoefARFnd1WeAdNMCdXxqN0f3e9g7BXdI3ZvlUi6IG7QKH9Mx8xvjwyJJMajC16+vFMclEDJaYFZSCLFaD38so08QXHnOJ26dgEFqsJ7iBCu0x3d0/uGKC7DAnbyDKgASdvGMegw2uPQBYMUHH2q9vVlyDKrYnQp56YQEoyVFZCNZ8PBcViW+5tRB8MJEYSen6ETl8JRKJxk91GSRMpcDBa6h08Nsvdgj3nhXm19z3OSEpP4v3sbBUsK5+j05pxG8vTh3g89APJN07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=EFlc5Ee/VWvxvvv0FH0vxMzGqNC/Uji7x+teJQyjpXT1LZiwYav4XGbniERx0GvBC0zvgU37Scmr11N9NOEUEzHaJoIDFEEJkXTjsUwTiH7skrlbicCURXoYlmyoHUFesJ7xtr5ZYhmAL8CdOdEXQqYwvirP0xqhy3tD6yV8iTR6h1H9gM5FpT4qagri6/WEcKY+566w0JQJnq0QRnCuBlmtlUkQYliy90Dc9OvCaLqGIfmfKIZN+wqqeL5/uG0JAFSdeyAsefWWZ2LusEHJgPlEVo8z7H5OT4iOicfEKBIjSIJj5YiPEiqI8+XPXHcxxmT74sJ4PK9OzfcxOuNDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=cjrS/PORwyq5bs3GbGeGlthjjlGqEVPIjnbWm392dHJa+XsGLMjZjDT/nJH2f9SMhpRI4JTFvCgdNGxi8p+DeKDmnWr6jAD8nkYAjOaGhSL7A7+fkM80i8y4pNy0SrezOQgCdgiHtCFqXr2/iYRYLf9V1pvBLKyY0BeskVwO41aKaBhqjPMFHXBBztbovfakLn4HceAMzShRwkMCuvlGc4Hpvtjtvq4cyyATnmi6utyOzkevoE47GYWhEsS7uSxZvtSfw1hw1eepVico9YfCLkK3N4kZaUvAzdDi/n/dIwD2hYJGNlMSFEBIoOl/HOd05g4VQLXVVWKLfAnqTwRmMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 01/22] mptcp: export pm_nl_get_pernet_from_msk
Date: Wed,  8 Nov 2023 14:49:31 +0800
Message-Id: <9b6e98e069ac9aa4a2124602121c0e9743f96f28.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a316db0-33aa-4258-9403-08dbe026ef50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CrXZ8l5ftdU/16lMGLgkkN7/MM7OZqHhh9PJuSBt5JPjsF4eE6DpT0SdIh+Ob3ciU/S6zYqAvyiR7Pf2AJfyKzoS28MWo734jju+eckDBnayJF3ojshTBeNp2VMPqPop4nuhbhlpY7cbt7bmYIpT/SO53g3VAuweuQfO49+zo4iZCA9rFfMlb8CAuVQx/qtYfT9qn5nl5KQIJJ1dkMO4aHtCQB11jgcDWo+guvxNqm8G9yQOX/orlOsWWETonH0qD/s1ZXos+KUTwT2qcgPhhhpWv4YO6PXhJ/5vkc+T95yQudKQZKbyqNu8KJ2wFURAohOVME0BgTEad69MzxH5UzDg3uFLQRoGVOTBdtt+bPRCGUuPF2oDMBKBMnGpnMzeVqZ2j3TX1bPu0TaKWiWWz4GmB6/3SOfxtLF7PZI3hsi8ZWCdomgULOEkKpJayH4rQxtwqdhh8aB5sdK0QGoZw9D+2+/8a8ZDGXDpdUR2zea/MrqdC6+yRqlsCBcr2ZNZwVkzYV5cpMrkwb/CKsvl0K/iBj06uLfiOnZoAEaq9JE5tGs/ssvtGgXoTu0mq4IDSQKj3clk1JOgF+hmfnSAqQZvlW8UHgAwTrYwaNVJMXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2ioUE22arnHZ6JWl0h6qmvInBrle40pU25cqPEll9QdDX9p2PpRMg795EA3?=
 =?us-ascii?Q?yoPdgG3e0j75FcWaY1D1UdMhhGXaUovEKqz0wriu+r7STZwtkr45ZuQqfjrS?=
 =?us-ascii?Q?FORprkB9Wk8EXxFeJGSzqSY5hOEldjYHDl6YHPhrP+55ie73O5fFS2L/mM2A?=
 =?us-ascii?Q?zM+N3iRaZ7pa0IDirscDz1hqZe5J5kG7RCHYspc4BGAsQQ5Mm+OiMWYA8UlB?=
 =?us-ascii?Q?E7gy22xMp7fl4M7KONIfJEbRceICqLATzCWz6Wm0+EZYtfYxtkXIVo9uTULx?=
 =?us-ascii?Q?+vtoSMB/KJ+CdbU1jkjJF35pilFMWvsJQwFJC41AWpq9CPnuDCasTmysWsqV?=
 =?us-ascii?Q?gw8EosS25zp4Fe2ho1r/uCKYTFfgRzg1QHWRbbfr0Q0GKfj8YJ8wl0Z8Esyp?=
 =?us-ascii?Q?BaYmGvyT/gwDj7YSyabxQ4oXhnO8x3Twd6rBkWn0KQ74T3uAO9XFeA1rJCkE?=
 =?us-ascii?Q?Afq/Lx9Gk9rrgKw+aouX6OqlQnRaMzYgQuywb+2VH7Q5ukPt0mCJ3Pm6+xnh?=
 =?us-ascii?Q?UedpE7GExSJYRvOQ2VinQ8pLGVV3i6uuUO36+lbD7QD84P8fkiC/Huj4OhnQ?=
 =?us-ascii?Q?dq2tBI9PapdgvGiGNTgi2QElrwtDmVJe+v8oSw6AJHuAmXRnoDTW9bHkogMl?=
 =?us-ascii?Q?EOcLNWgXYaZ3fO30BQzL6+xm+BCpohGxlnMgYlk6PNZMo6INO6nz3cgsPMDH?=
 =?us-ascii?Q?9yFSeqFIOzddPZMCr84Q+fSXgSTrje+1o/9+qMIy+ejBDeoBTKSzz5iwre8B?=
 =?us-ascii?Q?pJnXNpnK5pitaItwll5IWbYJR4MI1RLL3Z97wVbdc2xdBrqVd9w+028NB4oS?=
 =?us-ascii?Q?/NFnNZN+0d41aY75seH2P23K1ODnOW8K6mdzp61hu7QZ3Y29YVfD9Lu6ml0I?=
 =?us-ascii?Q?vhkglPTXAFt2lASqOZkmtGFCc5PbjLE9dySylDyKYKrpXdm74FovKFWdMoUQ?=
 =?us-ascii?Q?GRXgurElr5l1iTjBwoKA/j13LJBZ2JDHqFIVynaHmyNVoYUR7tjIR6WQqTFN?=
 =?us-ascii?Q?R1UPFXlbMlIQwvErLrz1v9GthvQ14o8v/OjA/V7yx+zEbTJLgBhwmjPhUH6J?=
 =?us-ascii?Q?6eIkot3Ebr/jhFf4i6uKiuZ79kT1hSx4SFQLXuvl8BkQaXIkyDVYSwq11BML?=
 =?us-ascii?Q?/INU5wGi+dsvmP+2UBie8fr76WEDQLWCF5iFYfUycxc3B01pQOFlZA/GWEOF?=
 =?us-ascii?Q?AFdvh8ebuywISDKnp24CWJKXLJC3OQBAwAYR0NxcAijD+ePro0x8ndX+9WT2?=
 =?us-ascii?Q?V5vw6Qq1uGzKn3ONh4hObQLAhEgoK46CJADiVAzwKDuQZAD0HXjYqcdGeMWg?=
 =?us-ascii?Q?LkT/SluCA8aEnAGqfBMuUmlyEqc0+vOmTL3kW0rciGrrMCw7HT0sg5oVd8Pb?=
 =?us-ascii?Q?lJYrmLp/qbxlkx6pFMY3hSMRV8SjFin/knZCacuR9kqa/+amd3ODwSaxE3pz?=
 =?us-ascii?Q?bOTnFcczu5cxFU4i7W+mVcNym0srO+PyIPa2lGUIE213NIih8DLs+91CzBc5?=
 =?us-ascii?Q?vcSbxSStNYFmf3JT09StESla4VphMpS8NYXbKk5xEQ3l7n2GZXULyqQT5tH7?=
 =?us-ascii?Q?JxCgqbnbDA1U2shA4HekR5lXr3ua2wUsbRSf6VsQwMLq85umqZMH3VdYTAtY?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a316db0-33aa-4258-9403-08dbe026ef50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:03.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvylNVg87snzQ0fE6DLyALqMPolKTV+IRJ2K7Ya3BIOIy33YzciK3qlPUG9bM77vAarFSh3cUAeDOIYlQRjyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk().

Then pm_nl_pernet can be accessed everywhere, not only pm_netlink.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 net/mptcp/protocol.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..1dcf104d7a01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,20 +31,6 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -53,11 +39,12 @@ static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 	return net_generic(net, pm_nl_pernet_id);
 }
 
-static struct pm_nl_pernet *
+struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 {
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
+EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..c38a2126071b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,6 +1026,23 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

