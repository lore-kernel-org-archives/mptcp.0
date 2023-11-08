Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B871FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="21vm9GWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfhgzLb0Tt+EAWsxjdPG/lo2Zao57NfM6MafuhB6TuB3LMqU5B2LqFfSGzEMwDyOZXFFDK3LiUJvL5XtINxg60+JtQqgXWRWW0Fzo+WcExptCttaet0VOUyPKw38Ef4XGz2/LrQSymrH58lmQa3JXcnxuX0JvPOvaZrfROLEuiIiYPCfiMOBwtgpHoa1U3UhOfnIsdLGJTHFSLl2E0ibW3POaIqoxktSsPh8Z+FE2ChfckeRaig/PdGF+6Fk5MxFfxt8OZx0uz4Fhgz7xOGY532BV/N62ILdmjuAweNHHFjU9c2FNBcGeHNYCFX88S8WsrT808bCTx1LqF2KI87Vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=bI7Xdp9UJGSv8TZtbq9psrAno+7bowiSH4kP2AMUN7V5+fDYnw3lo51DA3mRFxC6XwZtLM24vj3yGD3Fzn/gEehs9Hj6FBEZtertdC6YeVyid/mRargsDBda3xF8HNwHc0Y2rauhMddjHKCj04hWT1VFFkckHz68KFdIy0zaePVLBGW4IcRJ172v5Dw01JFCL6SnSxefAfrhX57/E6rLbHC6D7Wu7OQRa97zJooehb48Pc/6ANjrdeL3BFLHCI2KhiXg8KVQ0hbbzIaScmUHGJVopEf7MpyNYqfWGSdw4jF84eOipxM1oQFMLwBjrusyR2z1hdYl9PNzQlcIM/aFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=21vm9GWSwm/ULtr/JW2gx3j9uUeU2JOqCFGekMfJVMCz+kNtmxN9tT0wteges7oMJKgEnN9W0ueK9V4sA9CMMDEcFiGH2v+u7Bdm7K7qHNT1wtQb0Dy2aKZe4J8zNWbiTJJMKiCTgXmF3rlPcY8uZTbj0s2eIbzlh43p6kwPDqKbMhWH7PR2w7xCkGMPmZ0bFG8xfgxdV1D/H5HkJU3Xv0VyWuFRPDxrrBLj06LhiQWLqaU/65xBDMHXgbQb/nBhmi0yle35/LnL7IX58HKvQpvMOmkA0kVjUpKSchhCZ/6sKN8NTvAAQkfuVgVCnmM9fmhM1/aeALiITGqhgWbDAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 06/22] mptcp: dump userspace pm addrs
Date: Wed,  8 Nov 2023 14:49:36 +0800
Message-Id: <e54cd7147f342c31ca75a59e6ae2c95ce077e9a2.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2ddf55-b70c-41a1-e070-08dbe02700c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3tOD7DyzwM1JCB98wTUc1Id2WWv5514aOnodAClQ5T7FWNsGxnAJKgXtO1UuM6XrpOoNsTQYJjMAXjk6unem+esKv2TyyiWf3NV1VCLoA2HZWfrdfXJhGbSlELTwjJh5aupi7+pMUX8p6aT0ReBFKigJrBp2Y7heNQC49xjOwj2YRYT1cqFrOXyjPixFSRoBysVEQFFfRUHvA4r7Z+3FVGzxNDP/Iat3REt0sPLifFOeOCPCmjuLT+9Qkfd15rBmIOsys+hZILRh6Mi9rZbGm9wVv3WfmpO1hlg4SYKQr5RaTNOl4XBe/yLfoeAUYFvXqji+S+OdmAnycuDqvr94TccXJLp9Xo/l4CbUu8BfIMK2bI9zy8/PYnemvTGRr+IaEiLNMvbdSm698aCKSFIVXxP0wBC3re1zjNnV8xydsTKcKslTGass8AnPcDAHqVcvaqlFQfUghFnIz1GM0eejKlQZdErtGNIQTKYTgo4HPaj+ptb0EAwLsFbAUdm+l7WA7JqDhuJjq9DWnKILKFvjj/qVTUmpEWq3Lhm3cxw8l4Yt5kXCVVivugA3uhXmLSCR4AEDfxkdc/poWdFMuEefN9FXy4F0cRv8tvJkcRB1rkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hnf54zDab5cm6JAa2QcJe/oSAoPsIPq0EfHTRgiKDd1//kYJwDLD08SwzMoK?=
 =?us-ascii?Q?+jNHkVoDxMSPW0AsYHdKSHRLtjAPU4Q7OF381PMad+jFRKpOtG2jpsOOX/tg?=
 =?us-ascii?Q?ABgCsrI+l+kHIkQR7LpOhHJ+ylfz+VQf29ygCmFb3mETrHQ7T4v/Aop0fzd4?=
 =?us-ascii?Q?EM92d/huM/jCa1Fcl74oZM2TwcRzfz22aSHjyi56PQ2+LBmChUawHQ2sOFTy?=
 =?us-ascii?Q?IzBaLvciyTnO7x8b2eUn188Cbyof6716IXVhDpbsBgUxH9R7UB1BFA+z6FIf?=
 =?us-ascii?Q?9WbzPdwB9Jp2o/Ks7w/VapySDOeh9AiByXQcLCC0OxjGp/ikZfoTHdkismPx?=
 =?us-ascii?Q?TD4PtDd7L5o6tgF8jPZjNgkhjizOSZNWLWDptBOPAq5cqEDrDkeIuJvwd29C?=
 =?us-ascii?Q?1je7GTQqKMYnASz/1yxudja6UVSg0w1P7qTvtds45qV3eU/1C9J6J+BfRDx7?=
 =?us-ascii?Q?Hhl2H8p98+7bd8wq2r1PJ1Qx8ZF/2FK38qCekm5p40pO+iVdGvU/UdhdV57n?=
 =?us-ascii?Q?qjaciFfbFP5dD1kTYQMekRThZovZvkxDf0cyfry0yt3cY+epCiuLaFRCw3N5?=
 =?us-ascii?Q?MEnSOvCN7WO00UxFK0za27troehIBxCZu2r1uFKhRNf4FttRtMjHDWE0njL9?=
 =?us-ascii?Q?eFfa7vUv8c3pRQry/AH5oNgp0yJamHLMWapg8aLElILPV/kO1erpIhdyhwmW?=
 =?us-ascii?Q?SIgzBe61uepz2n2fdSk9DioO0nUJdBue1iu0coNjdJUPzzklH1YpPKKbaelM?=
 =?us-ascii?Q?SGa8Z9cf1s2t+kOnNdL0rO1EAKMGb+Ghz8CZgPoiIvMJP9fhQtcoc1mhF/I4?=
 =?us-ascii?Q?CsTCbwGYxCJgiR7OaP7gNFbcwBmbXvWwx6Lu3FWJYqS07vZuopvNO3/w9/Wg?=
 =?us-ascii?Q?Rpj0eW702k0YLKEyN90OilvOWwT8GrpA0HIazdxJnYViSxLszXiE4400B8C/?=
 =?us-ascii?Q?NtpBwX++pi4zuP1nPYCC9Ml//lOhhNsuidGlYT+wQu9lepWA8h7JB0rjodh6?=
 =?us-ascii?Q?AK8eznc6cbUKHDt+5GwIB+lz8n34H+WUtaDEBNGHs4bh0S/flU3xekxZ530G?=
 =?us-ascii?Q?iOyLJnjRHdteMcNrUjZIIwAhCDKlUCzGS/CeZv3g228/Ea2NpibnnKny/Wea?=
 =?us-ascii?Q?uYRrcPGC1JlFOVD7E6DcTp6JottXukJ4Y01z5b2WxzFhb/lzJ881H5IWzMH4?=
 =?us-ascii?Q?3lKskQ5mcDFEsMgPvYpUR6j+mKLWjyKV4qfwAoSHJS75OP56aYmiqeuP2qRI?=
 =?us-ascii?Q?f5RwuUWDQeMC6w4aupF/dHb7t34gRpzVvGGIja/UP7SUIQ8QJaWWkemNS+3/?=
 =?us-ascii?Q?DpLwAfHNQoJ5dxon0+weeS+M2W4UOf8VlyeUy4sg4qirtqRyU1rv46kqlMXT?=
 =?us-ascii?Q?1fa/KnG36EpsK0KR6yYZ0koDrAmS7srtw6tVAW5vKGIOWvX6KrPgYX+gVv1v?=
 =?us-ascii?Q?h/+7NX7+ZtnsJh16COdz+BUoFSmcwvaQUrhKsTEDDPPXzY9dGySwp6xG8AI+?=
 =?us-ascii?Q?6GS6X+oFWTDmWccY3HlNjAh5D4s9M4XMno49z8PVkOj35gHgiF6EtbowoTst?=
 =?us-ascii?Q?BWj3LZhpVlpEEsE7M+CxJqOK+kZWUKbsaIihjhHNPUGP1vuz7rOUYKSXRTQY?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2ddf55-b70c-41a1-e070-08dbe02700c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:32.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+JHAdMk3znQqmpioq3DMHlGYMiCCziuNkPjZTd79Bn3zCp4gF4zsc0GuQ1wX688M8E48C5eQqGHv5SWcQC9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

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
index 4cb52df57ba5..08b4211fbcbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1673,8 +1673,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
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
index 6999296cd5db..5e45e36ce1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
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
index 88f5b422f941..c30e59278080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1021,6 +1021,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

