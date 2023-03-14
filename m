Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C202565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJIcGO61dcDVpTSXJxs/l6b3lkZDFQsEkZUh3w6uT2KnhOxcCqisASYp3N6gsQbMPvWAhCOe4kQgumwATy+jwbusTe5L0KvjA0/kon5Sh/eBLTvwUGTo3pu5GGUpHCX1ZdEHGAbFrbtlFevgetk8HxRNt0W7DyCRxtte4GA4hBqvLMuV+HwRT/SMxMC1sSrpWTaCT85cCae2M1MjBjjvoNt3Ut28tYziJWPquQVo41SNP9hNHbQwOXjG/2VK9EUetCOgfOWssaCc7xElp1Pe8Vi3g6wQmAmK3VBkmYX0rDHb0FCd2+LTYG/HrQ/Jjb54RHr1OrIvYxMww2fCweel8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kO9CUzCdHTgwfZg10CyMNbz9v8I6qsypVebY9uJKQE=;
 b=SrvEV4ganTSY++WxU97MrI8dyG1u7AafozaOCCPj7fzwXiugR8ndu368dEe2E7j8NKrCKDJZLqsHtj4tJ7TD4F91l1uyA/NyYZp6si4rXks6eU4zLlO+uzFvOdIApstz70DgP0IzKHXHCw+wKPntubgN1jIBVqlHNoutJUfFP8qTDqSXv01QiJJQCnihpp5kOG8pako4DCY8vyCLXrckxu1XMvFOPH8F8WXc6IBEnheAWel9b3NFeFoSqRIRnelxdmpV5tAxoJgUFDp+P1xJiqV3YnsDGf1/cD3aI2JVTGEcdYMmYFsl4kdEAFRCvk1Q5qi8NsJTSaRyEZzXB1QxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kO9CUzCdHTgwfZg10CyMNbz9v8I6qsypVebY9uJKQE=;
 b=tvdv8hCc5F5HL9JCEM91SbnrZqDfMkjD9/YDIUGOAwX/MHrdAdicAZKcBjj6MdorHN/+/X0sd0tBsMvOCsga1oStLHNaLNBiaTKrekF772QNrUz4bidkqeGguuZ2LbB0EqAVAKmSh3SpOCO/lROCXpTE5ivGFKtOgjX2CnBmUl05+v9c0Bmp3okTkA/o/VCDyuWmZXzsFO6rpzVCaoP+KZ0qxPxzSffiiqTjUhird1rJHK6Y3BmrCCyP+WaGwZCKjvH5+uFPXqo9zSAh92/vyKVzaiGLDHGfuA4vdpgSc8lrrb8HznquuNPflJs3pxqK9W9W0Guk6afW0ksg4sviLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:31:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:31:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/7] mptcp: increase userspace pm add_addr_signaled
Date: Tue, 14 Mar 2023 15:31:41 +0800
Message-Id: <498e1cd7f935d4c0867fa61170895539606989cf.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a722d04-e5c8-4c0a-cf03-08db245e1403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xIYzJHOrlxEhWH2x5wHjnyCmKIOsAiRN5t2O/PANPy6NHxsrlCMgREL0bs104W/lDMkK8J6RYzGLuKKpO494dKyNSFxJl40jbisicH6S+tMLUmwKVJhMqLfZ+iOYw/JOM7wLmCZ07QYYgMtRK5PI7beEVVfJLpkxzZPNFCTzqdFgz2zBPeI6tat3LLgaEgAfHvYjV0R8IX/ara2v1WrSuHTYvjDbeAGYt+vAjOxRJtXqbltQjMgsWRUtAM7k7J8COUp8bNpgsipaK/Jhw4lOW99UjMB5Ghi4E5ia4RIxEN7Ft5NcT6yXxvvR/GIxIWgjXp0clMeej5kuxH+rWshx/NI/QYfvu73ICgGvVopIzTSc4F66lkb2Z5Nv3eIHPVxcpS0wR5+eSqmQWtKYZq1+hfdqPzn5ldgX0HwQnVSW76v6EHRZr4wUKMSQj3f0S0j/pqfjbDawo4TUnsP2AaDFEXOEkj9xy6pWhvp651+XlYz1BTmoikoULPaDiDcEusg8Ra0JTS76+U2thkEx4K/nDNTO1BicmN/eHacBJ4H3SEBKOhmjvkYOjutJfmMYzoRafD+gb6KV505B5rZI5D42pcDq0mOAM/U0ynculjNXL0JesoLSGE86RVVY+8hXrbidZBs/wWqDDUsfETB9AVncuPR9qejlXWmBIpGKNRX8CoHdgeGky86uN7hfEnbm2GmO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(6666004)(107886003)(4744005)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1CTPm+wdS1eZwLNYHTNQYTNVkMcbpmEWP1Pl3/CtryPzhpGFjGpn0y2qEsH?=
 =?us-ascii?Q?JhUB1tI4LP1hiW7g9yYGScFsDuOJLbJsZvneByuGbnouDS7XY3D0I0+xz1bR?=
 =?us-ascii?Q?+teseOwm1QyiiH5OFBy9M1jKm59m/wPwneUhbGKEAQ2MLRiz7E+3IniklIXV?=
 =?us-ascii?Q?8YhK4/TB1SkTHqPAyg/XkWyHY2rDaRoD2y7RlOc6aq/qjbX6ZVNykICY7fjA?=
 =?us-ascii?Q?PrTu+7ZrIu4rmnmcotlaF9GZx+xb0wGv6Y1fmEarsEfYgxobGjQlXfvNkXiC?=
 =?us-ascii?Q?wtE+gMSJPaiwxCJuU9h3KmKPN1xDbVaVxDWejRDo234DmA1joPsQwvp1+E8N?=
 =?us-ascii?Q?MBvU+KngcUreQFbkKSiCCxLb4czBBE7WbCOsluA2ZSNMYgvMHfJ2uQD5I3Xg?=
 =?us-ascii?Q?K+pYsUwOJXGe/U9qPupTpWhOHUdXNSM8CD0d1qyntUBCoh57e+uXtiNiXnXV?=
 =?us-ascii?Q?GqAnbPZzzU1nQSn9qkpI5PKjB2RqcCvINxfZj3/GjdX5rMMDZiHpn3GnWQIx?=
 =?us-ascii?Q?uHEU/yrkvcRPkWAnvb5c/Wq3FnWgAhwOyRTjqvN4E6MJDKOpl1tCl9NJT0PV?=
 =?us-ascii?Q?0FwKvnZg/U9ikqGq16TzZpXL7ycIGYEbfhvJVxw6ONlBnbYmBMNME09RHquJ?=
 =?us-ascii?Q?MnAgchFdaWwFtun8DDxfvcr75ascyQeefIdcZukR6hoTo3VHfH5+FyASW+ne?=
 =?us-ascii?Q?2pkPlC71Zt2Tj0eGL5P51WsonwJGm13UBPpClBYcwgOZjTaJt4OpysYmMuph?=
 =?us-ascii?Q?zPgQz9kEp27kBXvqgjM/XtuBQ4UH456pJI58MdvmdWZt/bKKIPV2oqBaYZnU?=
 =?us-ascii?Q?CYeTk87desBpMcMKzZY0/fT5xSczNL8strT1+xvYfHaRg9G2RYTcSKHoV2aN?=
 =?us-ascii?Q?qa49HW70nSo8/t3Aw9hqeXBBADDoRX708rfFzwCwm2Qh8Fx8c1eeHzLndmB2?=
 =?us-ascii?Q?ra96J32EYJ72tPjAb0g4zs2SxJdxQVgzQtVzLE7BgEUGYC8IcjBUzeXwB0Yw?=
 =?us-ascii?Q?YeOQW6JzYEW3whAEj1HIoMBAxqODB0AIS7f60aUFj+BwU8kXsI1DGXn7zOMq?=
 =?us-ascii?Q?VamQNmlIhbPYCBuOlRNUfYFQ7msd9IP57xw2aMpxK431rPe5c1R9Y5l3DoJV?=
 =?us-ascii?Q?Wpx1L38kcKX36BEwparcpLtzJveupGsjpjDvJs3V7PAsMitg3R6b16Bygyxw?=
 =?us-ascii?Q?6HfTKZ96ZpBkHdN60ggI71X6PsM56YrBHDBw86GTHzJ+x7eJa4R7VIkA0GQL?=
 =?us-ascii?Q?/5y86TBQeKNBXI8HvdzxwHikmoljWP53AgrCTcVdTSVsWERSL095SaWrY8qd?=
 =?us-ascii?Q?UZraJFVUqNNpBag5Q2B5Hu0wqIvI7X5+kw02OtfDFWgtR6yirhmZAOS74GGd?=
 =?us-ascii?Q?9OpJ0/f2yHzNOxtRQJgUSQCeWkQAn+oNFITlhuTSKeUu++HyfWLbN+oU92pD?=
 =?us-ascii?Q?uD+RCI8MzACdW4GIzipmLdpT06ykK9Zy/cLQmnjwraPJmuVtnlag+ydFqZg5?=
 =?us-ascii?Q?ufRvgePgFsAAbWfBa+op5GxCuGGlJ1MB9kfjSKPPR4EMh2Tk9odrOFFC5xW4?=
 =?us-ascii?Q?SSL0rHlIuEv/2jHFdkrK85GRZQ5MMtXh9IZUGVF9FmSYJ1zTzOJnhwT5/Xsj?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a722d04-e5c8-4c0a-cf03-08db245e1403
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:31:08.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YePiLUCMbStS/kn2AqdXKKTqLUm0FWoXveUGJJ0qgvuecYwBhemnON6P7eJ0QA3qBesgTHvzOW6zBPKjejvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8b077564e394..09b4b359d960 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,6 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
-- 
2.35.3

