Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BA15486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wPdt2iT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4mXVbuDirCa49mM7SbFf7PKdSU1VGnzYrzyqh2PdFT55AGhlOgq4UcnH5wCAgg7PSuseAd2pMtasnR/kc76+csjUMFAdan971bsSvQ9Do3NRVWtst/XG1b8GuoRht/egr07BKoy/29uIcHC6d7at0pANA9RNMsA51Ol+x3p1bTNW1VdAC4F5v6VgtziBv5fDuPyLdMafTNbaA4y3OHDWNXyxySHJN4zGirrvSilhQcG8w+D3W8qlr45ylIUrIm8CZQ5F8vPOmoJomzFaNkLwUfqhlvB46ncDXLBZbY3w0ievQnacoyRifEhFuvWwq/63iOd+4+xvuExt+xLtp0R2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2zhnK2P4Gf5C/Mv69ObnJ+9F7Ik8KS4QpL1mhNYgbg=;
 b=S+RW0OTkFWk7TPeBOeFhjtmNdXT+PhQxUMc8OWlKaU9wm0q8OUnTSICTuJxlheN1fM1EvzHjVeV8g8csoIXDXmnLhPMkO/IdCDAS6BigrKo2/GJE5sfSefCwh1ZZYRW4R9VOieGF7zZ4PwFcEEfoKKEb7NkfdsM71V32QO+ENesHZq4lo3ijcD/nUndkI4S1j3Lu0IpkbU1T1GRP401DeAqysLcjJBEWgw5q1MdjYZUTYV8Alfligybnwgjs3dO22Y4qRerv7Qq3FbvVWuiLhBey9xG6XYgXsD1DQkOwB3+hERQS1ZuWGNIjn9tcFDxoNw37pPnUCL9n79gELT4sHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2zhnK2P4Gf5C/Mv69ObnJ+9F7Ik8KS4QpL1mhNYgbg=;
 b=wPdt2iT+UISDWZhqJUfnDcoCWhmHcAxfe39oW788ry2JSgKCtVN8kBTrTIldOAoI4HSOj1j+AsDEP/INNPOtZAg44Lk71svebj7gviXjBRO3Uqtoc+pGmz3fRSDc5oVGgmhzTeiwwiz0PnogFduhaEJ3X16F6I+Yn7udgWl16sI8hqqkaaHwJkq1vEpaK91uzaY+k1ZBoM7vL0l5du4Y/2pjmLCeq9NgrOO+zEGdXf1xCoFzR9zjyGeyfZzVpf2uUYsnAgXpyAK/++4b/nQqfTfvCKfOEM9CPU7dm3VEfB1Vep5tqzIitfflq/X03lc5il0yGzX+8YtEjp86zPnGSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/12] mptcp: dump userspace pm addrs
Date: Sat,  4 Nov 2023 22:16:20 +0800
Message-Id: <f9d203555a420b236ba811792a1329301d845919.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cc02e4-57a1-4afb-8696-08dbdd40bd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tu5tTVaI534MA+MsEIe7GKZZIwN1O5f9TDwoxxDojogN1innGVc7sQdCgh+3ZUKfKrhh+UZaXd+6vRo445lK2loOjg09srKH6qKrnfgwQXDGuq5KXFXWXdv6a3yaDA6UKdeswl3rvuEIDNdFKw+vTAsUlKzBlvoT/o3wvi1Qdup887eBaecQhW/9sNpa+g4FXUE4vLQRAGb5nZmAPsWhGYuoCJaTkZfdALhXoZAU+natVhPoUpqymddolI+Vo6hQeED/54cOdQNYmGVd4VSEtjKYpVW5f0VSwtVJFL8VhRSJOZfqi0mjxJ8jyTSWRdOH9iXcbrMKxRxFVAfJManwPjBXOK1mtXLamFEiQoCFaoMRL4HcjnJXlC7khLd8zSJPXKnWqHxwclOn9Kx47xuY9vPSt69wIoxbQrzkuxJnqpRk4MFZS+PSyxuWNTPShMfypASe9n3QMhOdR/R1Xaji8nglZBzzjcSiGPlRCWFFvpt3fqwAu5Wge1aiyuJQP93M2qEcMg1OQICwr3gh+QfthnKwJSUt6irzPEtsprLL00OFq1109volKcTVjcAun+pOZIAy9YNW52jKUg+IxMIDGpjc3wysBzXdsaHecyWbQwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGPliBsWRunuFSMe0JL2HhZ+2KXZogvNOS5wr+2MrK7XEakLd72m+FlbeOuV?=
 =?us-ascii?Q?1TTLGgoeezTPECzf/gn96DYAIlikfFBx7wKdRy/n4ShIDX1H1hQM0a77eVtS?=
 =?us-ascii?Q?Qr96jBJjbT/jLlbgQyMYG8VH/Dx6guqETEI3KN8xh8taVOEEZGEyZ2PwQ4Pn?=
 =?us-ascii?Q?TmkGUAX+f4gyLodMTYO9e3gro+mSnRJg6ZjAnFzH5bJM+OTEkN/h6+OMDzVC?=
 =?us-ascii?Q?QUAf7aAdQmm2vWSFKrN6zdqq+qCb8aYFoJJKyS9PGt7g3aXn/ozxgs9/3H/m?=
 =?us-ascii?Q?sMl8c7Hv8yLBhWH6bVaPj0qM5HTLmQCQQN+WheDi2PY0EJF1YniNePgq+78N?=
 =?us-ascii?Q?iKIVLTX8nuFRKKpb6qP8RsCA8BVN8+EynwrCP/69D2pPR1ODHyCQ0qMGd4Tk?=
 =?us-ascii?Q?NANgQ9WruaZHbSFoxamPB+l53JE3GGgkonSXQRtGH1iCMpKfpYJKIM+DHIOz?=
 =?us-ascii?Q?E5K5fA3ePHcXB09QMYE/CM3vJhQf+nDowjvFri2V1bj2WXOFgB8/4Z0hZarZ?=
 =?us-ascii?Q?aYm1+Ygzb60k8ClZuMdlDuM0gfGt8p3njnzrcoRCz5hSCGqspnAO5P7O232W?=
 =?us-ascii?Q?oOvXrzg1Wul3itZfOVZiLNgpqAEWn0Jbd44h0RJoTiV4zaTWVLDaNjvn4dji?=
 =?us-ascii?Q?K+U2qfpF12N5Wiidn1o0JM+D65jiWf3AFNwbq6INxBUX8h4TGEoSpU7RVShB?=
 =?us-ascii?Q?K0RIvCU3KqvgLd1PSbVV8R9nZN03rd7F2pbmWnfFkiXmLyOHbl97+kgzly4h?=
 =?us-ascii?Q?5XJiOv0G7cJiEJti20kwzj2/OD/acTKUzP6XAynO/Kdwjs0Rbn8V7TbVhRSh?=
 =?us-ascii?Q?WcLHadS/xijz0xuVBtIfV5QPhK/VwKoBI1L2rGLido/EyqNRGLIw12pKgk23?=
 =?us-ascii?Q?/JWg89Pr39Jm2cs4lFES/qj3Dv29d7jh6rnQbwK82U9T8E3ATei/J5S/XM4C?=
 =?us-ascii?Q?jp097ubZmcvw6lkyZ1fbUeiWeGyLiT5LHw/GBsSJjIZuTqVorNz9UKqbQekw?=
 =?us-ascii?Q?Td2x/5HgtYRWYMFOJTYNO6DxT8eGLiHGutR6RlBlu2at8cQi2ykpzzTvAfxI?=
 =?us-ascii?Q?Co0hiApd/yrhy5yteKFTkeMY09BULV/bgFtRzBPtv2RgDxMI5Uucm6KmT8IN?=
 =?us-ascii?Q?THI13yh34UJNfvWSrh6YedlTAW5mJfeNqGhbCMzsgZ4bO7cT62qoVbLkC4qs?=
 =?us-ascii?Q?cnNQ2eqWs2cY0E8Nm5rIGu9t1sRyDcJuyO3guFQuIa3AkqhNIru2MJMxxyPt?=
 =?us-ascii?Q?ukz5LryICdZ1LM4XWl+RddUOTdYwqXStLpz44qo/4HTlO21olP5ZdUGsuvk0?=
 =?us-ascii?Q?c3l0UhbFdyOUqN+/VZivc8kwgykDu4hb+QXfujUw3T9Tx5+E1kj6YFKjsCLL?=
 =?us-ascii?Q?9ip8Gt1B6FizaPyUoVo/4AVnAn5nFa14pOVixE0l6JZ7ZLP8hIQZ6Vehlrf0?=
 =?us-ascii?Q?STU70JWD0Vrs7I2s+GNIO9LPdN8Gwu/5ka7P1V77Ah4LiZj8QGk078VbDHCY?=
 =?us-ascii?Q?uqlLg6psQM34Ggx1S3lyeOXD4sRuVwtpEP2EiMsNeku1jn8ZXgynfjkXfHpd?=
 =?us-ascii?Q?OFTbvjRCmSZ3j8bNzvQBQlnahBAr/BhDzgvu4ANSNSCBA98+0mzXUA2uM4xl?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cc02e4-57a1-4afb-8696-08dbdd40bd77
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:13.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjJv4GXlDfVWCVdHjEw9MN44Nn4pHbuwNqXeNjaJjhWs7btr38XCjvhboC2L3lIN5AmZB8VdDPCjMJMrw596DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 344362ec17fa..c2c51fed4e43 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1708,8 +1708,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f96dcb2b5db2..9c03fc46d9a9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -575,3 +575,28 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
 		cond_resched();
 	}
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0014b6b542a4..8bfa9bb0552d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

