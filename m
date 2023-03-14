Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FF17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoZd/XvGD3OgYujRqH03mpD/028rUxeUtIHkLOEXug0bMjVC1fJHHsvI8D7ugIjjbtAU3wIiswWS2vUlYz4yQcZMVYUsHFUTGZIAmlBiy9NEytTsbsDWBotbmB5ZnhOyfv6kytXfpKW4un/bI3tsYds4xspInAS7jFHeA9d9hFFg4xkENapJwMU9zhHWxqtB2wFH9avcHw/mFRu+IPFv+4gv26vVarItqmMwZyx3iMZkysa9iUJZuG/NWx+N1AcnRUcnli/cSEsv//DlWQSpp4rK6iQK4yNWoTcXNlHrnHFdOs7x4JxWVE2wh2BUScfYYb+WZnPygz481LGSzDA/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGGFYhy8VOOMRsUCebVDEAe/po82kGWkSMgWViE7bMc=;
 b=Q8RdnoRvrpD4ThR2LTugbdGHeieBcPnt34KOUZ+2G8cWOwvsJ2kwAEVBNQ27+sInD8jDS84AXZFoTom+Ehlq8A3dlWUM0qsjG03iefrP1gggzUV8sbvvyVKhv5KSfHp2UzKRRHyc/oL6RGCMhFd2b5sLGaIu2RTkDNG2iID7X2oVVFKTHwdxMLepFTl6yVLXUeuJSZnigz49RaQ5doFT1kD+/pZ/xS5s0S0tqvdibdhc0jU3CMdv8HFBDF1MaR/XkjoHSCXoECAZDKLP9SNakwszBD0lwAL4ZTZAj4pY9EaqbIGnWp2QBRUYvgaF2hCp4TP7Sr55niohu8jnHBzq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGGFYhy8VOOMRsUCebVDEAe/po82kGWkSMgWViE7bMc=;
 b=tsc826DgvtBs0L2teyh1rYx50cWj0bbnvGm25twd2DT99llPO0gwVqiRt7uhqk6+/IM/AMDCpg24oIL+NaI71VKLrKGYZTFV9Vdwhlmd0Bj/1tqf4wj+ffil2yHIoJxj1UTiYzFzhiqWQr8vdY7xT1YBGOuE8VO/qVB6OPaBm9EJ40uG1JvQT/ImwzDbezP3EVY9J5IBxHJgpektaxQb/h6P+VB/UySdy5AlkDpNn2j49XOhMccnvleGIp7EI74/EGnsT5WVonVdoSQ64otsW6BuRUkJB2jdlURxA6/d+XFR5gZhtuYWA0Eo1UBqNLyKZXh19E+okErNiKFhpBvvEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:01:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:01:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/7] mptcp: make userspace_pm_append_new_local_addr static
Date: Tue, 14 Mar 2023 11:01:45 +0800
Message-Id: <38533f0c6bfec11683e619593b6564b98da23221.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: f7331fbe-5b00-4b6b-0945-08db243861d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vwACTMH/C1e8PVdkjVfNu3GBvD9CukBMdGRkM5PL3lKZFqzMMRm8Uf4Ue+12rjby7kzGqT5MUMezKrWqr5LtHEEk2xd/a/z0nn5dNi3ZmivxeWtjD/s0IsP+wAAy/W7LC/PSfgRAR7py+5sgpVskelRD3bhaG4H8eKznuwBSScRNe6KPlatQ3gM49handgKsM20kzUG949bB6G63InXzQ+n3jIEZTvB3kRm9nwNaNu0hnPbnLFf5QnaHbwQVkzrET5e00tI8dT9T0MNNZgPFosHaMT2J+zLYpNMx98nz1J7M/+Y7QhFPggvP++oXVxXQAMmdHrGBGaL4EK7RNYdnpZcatF4ELv0eTuzRnnPk0DAM1fOrB3KqbXOMo1iUw4q6G5oRyApiaHf3Ui5MeOPWRHCz1eS7ezgWZBnPHr0pwh6O9/x+Xtqxp9YwOzy6p2H4DseYTPoXS7Fzyg0Q3GVg+k/ACda2FfhVoKb4Fs2bnps/lTNA5n3t52z7PYaIyPULjlgqAg4P6e3SxMjqfSl8aW1OO6WcaemSKAShgXp8VKjIYls8EYxNF+XACf28i6xaMbYtL3L6D+4oMf3OC7S2QvDpeU0yR0MEm64ySyyuUaqEQVE1AmfSrNRPxpfirI3EgMLkJjjbM5PcWuoz4rTA8nFO71fnRoQMxjTK2k8AS02V9otIbO65nPPm1wRdIgap
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWF1IDqFSn0+p+caWfOOsID00tch3ym7Q99INDUUPvsgV2TaL4lqFT3LRxUz?=
 =?us-ascii?Q?PVeMI/6dqmJt1NwrpeQbQ+j7BGrHnBecv/FXNjeRyryGowCR2oIyZORsCPJM?=
 =?us-ascii?Q?aefk7m1kGnwFXppMAJFQ5yiKOnLebGDq1zwUbS59wGVR8gakpPP2HAx8YFGx?=
 =?us-ascii?Q?zvS3XgjO33XdSm51Y609vuD+nNyRowTexIc9DA2tADm8ucuvZ2w+yId8kcmf?=
 =?us-ascii?Q?OnkIToK+437buLbl+nlv0nNXlqQpOIs0Z3cLESaG2Xnh3O30qGzUqtNVcG3Q?=
 =?us-ascii?Q?YPVU/f1/7xI4nBTuIOaMU1Z+wjpVSe3RxZEbvsqIwCQ98UA5fi9epKoKEjjB?=
 =?us-ascii?Q?D899UK6kxcOvQTed/ni3JaP0emkSiOFnVwuvd5OY1vySBEb8L1Y2Quzk9Mx2?=
 =?us-ascii?Q?79H7w1XcKBXZMSzhAUylRkkdzM4P1cv3YCu7HTefjXoFVqRyypq0QlvyVFOk?=
 =?us-ascii?Q?zf7+wgc2V2vEmh9iZ4g2HchLeNV4qdhkCdo/iVGntZMf+M9VlQeeH4xht5+q?=
 =?us-ascii?Q?ZUUml0MGynlG7NGK+u0Ms5/jerzfLj9y9JJxE5yPc3PeuipYjbsJQtUuFZXy?=
 =?us-ascii?Q?kMreci9jHFSyvMjkeuSKINIetLHOR6CafGQtD949N4M8YtaYZFwduw9HzK90?=
 =?us-ascii?Q?CyxAMiLTGFAlNwQgSBzQa7tNZLrUuI38H8i4Ep87sAWWgfo6tnXQgz84Rx91?=
 =?us-ascii?Q?IjcDS+Js7iqBBc+G3n1f+3J/Kl7qR1RGY+aK9QHgl6MHydlE25c31GpO+ckq?=
 =?us-ascii?Q?S1v5C8DcTzwqMMJW5dUxJ7LWPfNmt68AZWwmNiSPONlv+VnXR88o1xcsYGdS?=
 =?us-ascii?Q?I7SXQb08lKoxSEw8wGMroNVfxh5uZASvMK9/ailS/FNoTzdL2oXLTdUMC6Pw?=
 =?us-ascii?Q?wZRkZAa+Dxgco3l1mhGbn/1BYaeffTdvx4Ndx08ty31ogb7Kbn2o/isrMgQm?=
 =?us-ascii?Q?Mpt5hdkYg8+4jrNSe0/uQB0uMm0+q9aggqEGrCc1LdBW40JxiTa6VBMOL4na?=
 =?us-ascii?Q?HA4gThNN8xAUtSXJmuw5pKLYz95BvTzYbHLd8mvCc0bKsFE4CDI3gwGks+P8?=
 =?us-ascii?Q?8YQE9J8euYtg3gzTMKqm0A+KD1F6zSNNq/f7Camx5AiCfYsKVU34/e8hVg+s?=
 =?us-ascii?Q?Jq8hFYSIZ1ObDvvyVHRzGk/qsaNWK0++Um4yVT4BV6xRxctveDnfF2WAC6cN?=
 =?us-ascii?Q?2yGREQGES+jyZbUgBoaltYUUYGNZyu7kZ0tAGmIpXOgYGOM+KL7nJqxXvmkk?=
 =?us-ascii?Q?pqEA3v3BySRG4PgJgYXwavpjBav55ubDzP+iUry9G0ZjnyK7merkaUCPILS0?=
 =?us-ascii?Q?WbKIyhCD487Ly0KvYqgmqmEXnEh2P86HDi4e2FquyJC6FeyY6MjnLFeLmmOr?=
 =?us-ascii?Q?9n175AMCw2lMuJQSOP7CnTMkjCd3oaJCf8F2s/SCn9pNDLd8+XOdYhH5a8uN?=
 =?us-ascii?Q?P9Y2ra7ZCPC/8PbxaaQI46SVhqH8jsZ4+Dl42EBfGAxMtW5o5JebMDR5M+tK?=
 =?us-ascii?Q?5pukfB1XL+wfEJrlqQmum4ZIr1uuVyVp1AgjqVYLeJtzUDm225X8Dc5La8BT?=
 =?us-ascii?Q?3wTYob3blCB7UCytS5W+qcIp3/hZ7FPbQSt1wYdfsVsBRwxY+0FjSAAjXwqs?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7331fbe-5b00-4b6b-0945-08db243861d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:01:18.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/mByewWSUPItIdV+9LG1yaSNO7gAthEiFhkcNT2RsXt/Sg6BVFDibSaUhSaSDY16siM6t8zxb1hMLGCcYChBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

mptcp_userspace_pm_append_new_local_addr is only used in pm_userspace.c,
so make it static.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a2fce8486d60..d2749225f391 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,8 +25,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry)
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 46962a2581b4..421e587a4d62 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -849,8 +849,6 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-- 
2.35.3

