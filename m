Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AC6ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5geiY34lRqZV5jjzwPPwvxa5DbtASVNUM/scrZMk7pmawWNJgfAi7MyASnxTjMyPcseJQ8LzTwlH0k7NA2Z9qN2osuRaIQfLAMzy7T3+dGi4KfKwXnkl3a50alpVHCeVsQ1Ni7N7ToiHvDtzWMPjfpUkGgdGuLLG+CFh1S70YCtfI443CU1kV7WlMx4h9KPEgR4kdR35pKia8k4a+b+n0qX4m0eJd2LawNtJW/Da8ZG2jaiI488Ffm1sEDb++vEKLLD2bEuJQsQfPp+PqxYozdizv3WTSXTN2x/PteI6+u7IDMCyza6AdF4bGt1r/8/lPDN5CakssCmUQK95S116A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=nmp7NLDDBjWrDOJg8amH8uGv3VdrOgpeUmixUzFdlHhD9nO+nRrFvtL7m1NCUDhUXx8OtzcHBRV1nDcENoSWvudrlRKQrYIxT+83ZiQCIziNhn8s9RQoaqitiOFLHyOcY5swOt0+kvx+xryyIQ0scihNXTZbmcjh+KHrQpaKk2zt/wWBWaJ0SGTx4UJO3eGiV9k1estd4gI04YHUJVWhmrdqRoSpkKxQIpcN1qDoTsHdLPqohYNJGzNFQxvdN9XHevf83Qbt92vMZJG3nJlWWOwqZUreOvAw+w46i5GN26HhJ1QCFuKZzZfIG2OwclAS5Scq6+v1RqwbLN2yKHeHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=bD32uKM1AqtBfBaWjxK8wEo7Zby7CMEDnBpyU0pSAKf1gN0gETwXtLUQwRwdbU4qa6E2YkpdPnpryMzuTB6J3IUmRpc/P/DI24Pg0twC278XxtHXUO59hZbNDcP6h+7qRJbweJN/dGJww//p48NtLXRcctZXVFVG8zFTOc3AG8k62E3w2Gq1aaQx1hgPaNVYVFngwZhAskWy0ZNeQrPih2qIEI6FRbXlAyx7QgCozykONaiIIm+th0CeREz1B8YiMhCdiqoR0a3iacuAaP/CRKgYbwVioQvCNZKIXwLpQrjekK0noN48QFnkr4V7qoXsJwv5mmIOsSKI528lWN91lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 09/15] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue,  8 Nov 2022 17:08:31 +0800
Message-Id: <bc0bb04ee334a2a38c7e5603405c16d6af4fff5f.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d51c8f-9365-436f-2df9-08dac168f5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ygl7jy8P/2GKsW1K1kGkNiZd4mla22bAIPBfp86Ag8psGDYl020wmH2L6h7qZE6uX8b/THlmUPJ7kGKDf3uBoTkrvb+1qSBJJwtBcZ/kEtYVxm/dDeCGiARRT49lVHPrUl+h935XAyKWHPv4zH/POk1aH+lRAj/FPBQerZKA/dq6T8d91UUEFJ8w+IXsIiWJPnIsuXkIJn6PVtqRdI2G1Eejsmqe7C7ZyCEa90tkA4AzGcJbNFZ0Vg6a2LMPE1I1YzhABo6+lNPUj6FYntUxUAE2F9bZh64FoK58WA1U330yZJylBxuaowpewhxhrznhdAYJz5kwq1dV2KpU9w4LYPvVbrE+IK7g5/X7DMdba9eMmZhrSSd/8RTXSUKkxz4xg+V3b68cFt0oeS31CA79gQ+EbOHRg3pYZ6p3ZABbPRYT2WgEehecqb8VIou8JR4PKxMmPIrvsSuJyIPXUGqXR5tuA97YTOJ4OZPlxc/PbzrVNNLSA2sI1wIHRaazoak6U+mHb4Q4hqFk467D3vwZ0IyaMdOFdcZ/gMHQMIU35TtyGBTx+Ny7KerE+/0RmeRtls1/C/4LcirTr665fe9Qcnl0dWMe1AY5Us8by5YnniP+Dbf3hT/3ipiA5kqYBhQFbTN3uUz4SQKP+oo7R2ZQF1leykTd1AhHUMkDOwXGqTxKYALbrZ7HvtYD0jgfAIomcYrUyFe+l3XTrEVbPQWieq5X1ylYxYigJ306L3DNm8WB7RscVuuDUQ5+smceQge2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(6916009)(316002)(8936002)(8676002)(2616005)(4326008)(186003)(41300700001)(36756003)(66946007)(66476007)(66556008)(86362001)(2906002)(5660300002)(83380400001)(38100700002)(44832011)(6486002)(6666004)(6506007)(6512007)(107886003)(478600001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSHEU+lyXZ92LkiSCyuHGR0Ti1+yuWWk/kKlH+dVOw2GaDerQBx15ArcyCay?=
 =?us-ascii?Q?Kl2bZYbh9hUocXg0Vu47QSrd5hR4IXh3parIDvgxCFhvFIc0dEgmGXKrsL5I?=
 =?us-ascii?Q?dNT2LabgXZk+v7wUV1qgJfcfiijEtZUramROJCf9WiWr/PTubjrQi++AoMHG?=
 =?us-ascii?Q?kMs3blzG9An6LpyQfyISoX5U32K1oIiXsOyCo79/FMjof6sX9NhE6Gq0B+3c?=
 =?us-ascii?Q?lH2+nyAqMVwsTlJERtqs9ubzTmgUzewSQ+VG0x1clyYq9usiVoPtMuDVCab3?=
 =?us-ascii?Q?Yg0Squ9hXPUkuH6i9eQd37GDOa2hTid5XzqpIr5yoyCOUX25Ly6OMCIqI+Ro?=
 =?us-ascii?Q?eLVORDq1wyqjOBi26vcAU7eSfNR+tmJoxObzqiizTmmckeJH5ZT7Q8WCtwAr?=
 =?us-ascii?Q?gOqycVVQU1CC8ii8b5OT7jQCnjDsuBSCpnRpKPeH2Hjx6YhHEM8KybvC3Xh8?=
 =?us-ascii?Q?Ue0957mEVTZB2hnK1WWLy8tIN1WRrWFaQqXbGW4AVzW1V2NACCKcIY1vPr4E?=
 =?us-ascii?Q?iZLbMCDOg+iGczRzQIpUy9alaDDub38nSLe+FtpM+XACw7kH/0bhWB3y4n6M?=
 =?us-ascii?Q?f93KP7WwOqLv5Z//GzLf1WVI9aH2+txLaV39nSHv6QbR0CY/LNxONncAujVs?=
 =?us-ascii?Q?QZYgYOzK3L8IRzPVbekmikKD61tDdUixPM8Of8jgNnQwpQJNFjuN5RnwZq60?=
 =?us-ascii?Q?KxSm4+xif3j3UXhhTUitx2lsonNJRCGbBJfeHPM42s6Ftq2wRTb/TyWtqREZ?=
 =?us-ascii?Q?96nZ2hGhL/VFmUdStaNxzza13od0/0ZqwCe2vd4PPe4rAClMROWO7U4DEDdX?=
 =?us-ascii?Q?hPzPL9X3p+E9sojc6z5A+m/JlwpiOw86uzEbIn5/UeE1JTA6Z5S5KrU59R2k?=
 =?us-ascii?Q?F9g+ggm9vH0HzgHmTS/uzvdAWMHsi1gZE0HQjmq5gOxX3zkKo2Ga5v8rHNLe?=
 =?us-ascii?Q?asO5NKppAms3PsUbvGxRLeAug/WqFxc5mDQC5tcdPwQiilE3KQfS/0am8R+v?=
 =?us-ascii?Q?JGC9xyL1dliMvFDHHFb5WM+nShBf0874RTP2QlJh4A3DmLiE2eSqYhfO1eFs?=
 =?us-ascii?Q?dEquBBtA5WBlgf8u3sF42yPdqHExmZ1XjP9Lw7UlExPTIU5TxYGHwWFND407?=
 =?us-ascii?Q?n6ovz7Y9igKU1sB/i1nkOXJcr/IYyoLmvC1w85AIjQjG8JfBWAiYjZ7N8erH?=
 =?us-ascii?Q?aVnPkxmg1QKpVCNoC9aOOCm5JHR+VE06oJcjFhlK9pbXGQkg5It9hX6BSzhU?=
 =?us-ascii?Q?5YK66V4VcRH2N/p8cmVqFFdA+7vEi3TxC3u/GZ1NBAgn0pStFAG2PjuOZTuW?=
 =?us-ascii?Q?l2Y6oIzdkW2MQGiPyy7dbT1yWul8m09FXOOord3QwL7q1GYm7K9C35IQugcZ?=
 =?us-ascii?Q?H8/vxzHcd0VdD2p4SIutPGcfRASHKkYatxoKKcULZQ+5eysotU4pJRjvYFJL?=
 =?us-ascii?Q?RFgrfDZ0il1B6so62Z/n+FnTN+neF1GdOegTC2ZQrpnEnPEjAEhC1l94S+7/?=
 =?us-ascii?Q?cvRx03bZPDUtywAYXI6RWWD+1eGA4iTCrHu/B9y0F0Fq1kr4BhDhO7DtSiz1?=
 =?us-ascii?Q?u6jhbt3tCZZZXAxLDMegumeXtugBXoXmTBjd/Kf7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d51c8f-9365-436f-2df9-08dac168f5ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:37.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjbfgcmREeLTsQ/5Eyjyu9FrHztNpCqbHdQF5SElWuB+A9jVmWPmuZ5HYp7QV/E43zktsTT0ByWRSMN2mquIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..e101428e5906 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

