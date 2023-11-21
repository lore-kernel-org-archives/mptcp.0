Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62F171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbNhT7KM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRla7iRj4r1vT5gZa3PueEP95KQOLim6UkqG6W5dod7WbBBl0j78cGD1p7IjE4cjj185Wpc6NgAQqJpdWrig9PeTiZbJT1YRXGm5URRCbrM+VYxhmCyvwFXBnkcbkEJL4faYD7Ql3qDh+VGFrW49KDRLY3VbhyekqSy39QExs5GjUSXgo9E0LL4d/K6+NptW2LuZZK7VmEPDnV3OEr2YPdzjmQR1PMUOlSLNgdOXgV1TVM3P6BpBGJRBEMeU1nj/v1SZf0B+IkpkWCqUSsHiL4BKGKjKxccfCoFF+pBoxXsY5usYXx/aLeKR3E5mlJiLfW041l7mhixKZrO077hIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=aBz00IiA+Om2WrsxYVcTtR8q+jseC72xKeIB534/P4+l/g+ORAKTI/HGe+y9H/6qFEDA4mRTgylBcmP77G18NMwsjNBbzv6vPjv9/1/iGa0GoafizbhwC33IV7sUhTI2/SIL5lbQHxmKCfFKxqRUn/kdycLwyVm+c4ANO+m2cKg3kBll0XfitML5BijMzCwtd3R26ebeHQa+ypO7mGp+ygB8OSxmnJ9QlscIxMjOcI6VLSyDRbR2OrKOTexDJJjenXj3svSoZvz+9+2DInjFmtmF2mbM1dZnJ8I5y7OkF4XDjYCfwdvm2dgzOVBK5pjbcKf5dRWMe2P0a72FVmmYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=PbNhT7KMeLac82NMbQabrSqTEaj9AAYdMcL4hSwrK66Z3oVViTw/rnEcUrFEV+aYAJ4qXzOnzj1d+fOJ3Er8wvZn41SyxVyKX418RDrwmhL+9cdjx8JIWKT7mWHhgWdLfBuFb5cVuOdAQvqcyLr4SHwEVO73B6Od/BE9QJwGy4Y5LHKYBqFCeXCdX08QtyJciMwg2mAlJ4qRtK5jBcdoH2lwHBcqBkVbtYkM37agk45mQb1RnfMADHxogkQvWj8MbVm+2ZPd1sb8CaFCM1rMgyE83yT7FsjVE2EwfxpbWYFJAVuMPwoJROX5YE2kR4VmQQg3HzqfYmX3QKOfHGMauQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:53:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:53:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 01/28] mptcp: export pm_nl_get_pernet_from_msk
Date: Tue, 21 Nov 2023 17:52:24 +0800
Message-Id: <14219f05cd554eb7ec74a2361d8813cf12f443f4.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: c748b90c-ee2c-4e52-a365-08dbea77b929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmtdWB1B+ZVyiQoiYcoh4ZMiqze5Vc3rqKrrP3NNKgJeEledQ+izhhfyH2EXWMDpxZxxXO/iYWOvDV5gf35EWOjVQtFcVePqxQp0B+rDWoizwICT8Vr8LGrh72uEhC8blPpSJettbUeOUEzl00DbDyUKlKY70Eybf3X9mSeEl2bzNYWXms5I3GP6VahlYNFRbzy3Fpy2v8bsLjP3UePKhEpnfGN5siPRzDlMlj+vHDFRUipxiiPW6wgbdAj2jR5A2xc6N7+FR8bNXfVF6OKlQOxEeVpZo6+qaYQSSeyibJeIDK/6fosgZSrnpeNnfykpco0vJrtRlOze69TL80bt55yS3HNDPem92jI6xfHtMI1STh9f3xXX1rbVCUMFhH2FwpzTBP/4WjOufpd1jkZwfrSyG0DirH+Z7o+z2C0PBje9bA6SnqCEvYzYA+8HPswQHW20qq8mMRPwzCe6iI9tPdTc1hJG/FKzhf4ba3sswwDWqc0deqhP23HfrCYnIGW2ZHpBtZ2jrhq4epdHs3UlzPZNWb3jRfpPTcJVcUfggwGsW58VMFZ5rD3rAnGTPrA1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(478600001)(6506007)(26005)(6486002)(6512007)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(107886003)(8936002)(38100700002)(4326008)(8676002)(2906002)(44832011)(5660300002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17jYTNW2N5x1SovZvHgsc2rUpcxOuGmBvzeEcapHob4v2v8xxkIaPeCoGqAa?=
 =?us-ascii?Q?B+errhW2ui9Yk3rm+GbuFRcwBNjTITAt5D493nx58bN7/1MnQk1NnvJz8xNu?=
 =?us-ascii?Q?vFMbshJqKiegvNAs4v1EAf0VnEykH0RMuoFSRW5apE9EDxoe8e9o1LBYlvmE?=
 =?us-ascii?Q?7o0bzvjwd6BX0NHMvoWXVZyK4LIz2ZUeyNZ8vGJ8G/PHvmcI5q5HqwCNV7hr?=
 =?us-ascii?Q?QQURvYErFHbx2guJ9A/qF+pp47P/v/tiLUEb/J9z94gX3vxmZS3UwUSoRZKB?=
 =?us-ascii?Q?BxGxggEZvT5Lrib4LohqxL0oJDs0hb0CoW+L9dmSbzLz9OMDtZeoELguJ0HJ?=
 =?us-ascii?Q?hITTFXIYtIiacBIG9trd8TYHWdfGAQjQX8b8iq0TVnyH+V/f87VUwZoXP5vF?=
 =?us-ascii?Q?m7kjAehV0ev5FQWwo7kLJRekD4RqRWhQ7uFLoHaYISqRhU2Z8j20pZ2vWCAH?=
 =?us-ascii?Q?M+UweWJH6MXvrs6DRvNBAzOl2PsU2aI/q/PphQ5Fc1UdX7v3wqMkUeauA4+C?=
 =?us-ascii?Q?qM2oJma24QPR1S+Wq07wTzEVtsYsbzeKeqpEfIey0WW1ebaBHlJXwoQPY3j5?=
 =?us-ascii?Q?fr9fq9qdXZ/Ar4k8ynQQt56AG1kjeBNY2etWFCvJSXjz5U7s20b1JEMvZ3vw?=
 =?us-ascii?Q?7yFsfgc8cN7NDlx/XXu8OFcPu6ykVAPws+vWsuY98m01+k14n192TAxO7Fz4?=
 =?us-ascii?Q?Eei+FS1LtVPcVCiXy7r0GfPvaE6go22aMDetVsAhZKhGpvJwtLV1G+VtJl3n?=
 =?us-ascii?Q?U3EScgDfr422s9bQzxKGuFeXQQgAkaQLoC2rLd7HAGs7egFrJQmcMGxnNfdO?=
 =?us-ascii?Q?LFpQhuvqnLmH4xYauO7IfrBE/zjoPp2eiH5lcPDBJ6b9uD8t6Mrqc1BibC9Z?=
 =?us-ascii?Q?MP7cAsyRQbYFQoqhZ1F7VYVuG88R3gHsG4oAx7MG4KoWj0GbUNZ7EIYfsQe5?=
 =?us-ascii?Q?ZhEfsT70uFOxF1ZcmqUu3ziWUux1HgPTo2NuFWblo88O6dxyMektaBvoaglx?=
 =?us-ascii?Q?MUJW+5nCMNzx6yKvY01WciqUfPiBqExzzFF5283GSpn96RWOy/usXBh+9QFF?=
 =?us-ascii?Q?ri2NyjW/sArrt77poq+EJ9QOL/fdvnFnxF4CUfX2Nstfh1oyhSjDcGZhgYfb?=
 =?us-ascii?Q?TaQmz97T9ce4SAbS8t0MNCAVubJBPNM+C8Yx8zonuIWaF1EozpdltkfTRxVd?=
 =?us-ascii?Q?5y2wvdNC2gj35OtXzE9VxvxoH3QIWVaBXld9B886U65REMD3SK9kV4jOoXpU?=
 =?us-ascii?Q?iGl9eRJoi07ulWYP4oz2RtqAK2Ixo/wQ+CpJbgEMdNrY4e+YUxkNoiirnR+i?=
 =?us-ascii?Q?KF2cpoUK8lQ6J7CWe32HHeSJzw9dM4MArYZKdPrsJt/fzkHvfQw20OniaOBS?=
 =?us-ascii?Q?vavAE5v7ow5SWbHoGkiMIaqcOvH87hatmeiSv5BB27YI4gNZnD8XmkKUX8bU?=
 =?us-ascii?Q?kkPe2SHAcpvqXrFv33gxamuXyH4x8AwphEbiRSoynqn2MiQbF4wRvnDrQvQ+?=
 =?us-ascii?Q?ep8OzBWIIJCDaubaXBwPLUVVBXIIXRLR2NsSFVEv8p4+Z6jb/jteBbl/hWv8?=
 =?us-ascii?Q?YL7kJwns23lTd7ULN/jstaRdAte6/FvyL2XBBQhQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c748b90c-ee2c-4e52-a365-08dbea77b929
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:53:33.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCNyxWNKiioJ2G0x92wRFnJsDbtVWcQHOJ93qKJ6NoP0+3yGGdBMbt4fnq5FZJONg+3hHJVnnZKUV7xGTcGoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk() helper.

Then every fields of struct pm_nl_pernet can be accessed everywhere,
not only being limited in pm_netlink.c.

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

