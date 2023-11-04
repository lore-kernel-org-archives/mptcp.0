Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9032399
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TO9qVkKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzfQ0uUG0GbPZ67v0SqgmVrhioscHolyOzByXPxOx1L3yoq83ZyP0hhWz2DRhg2c1Sro7a9dbhbnQacZfywgp/cUOsybHwXl5YB+1TWzuWP3CoPS5SdXsxFAb/H1wZI2WaC05nQvGndahmADS2GeeC7eZ9nTv9W2gwb4yPrv3sIg4tNkR/oFyY9N60udT1t2yC4urKtcrYHbk03yGLQjH86mTqFcPl5sPPtBkpxpkez9suex800XQ67WQVr3n6X95V2a+T2xdfz/UzDEoUwRQmRR+zbvF+zG78C3fSF9u6oN/Vu58a//g8vS26lxdxWoakRK9VJTdw3ylBFfasTEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhBUlhOPbDC0FcqsKABvR34O4UN3fiyxd936xBJj2zE=;
 b=ZkFs4kfufHCtAKJhFg4jZvCtHv2MJtTTejgR7jwx+6WheMDTyWmiXiD1WXEZ9+ysBWkRkyUwT5siGCtFIqd5EN/PcUrXSS6ZjE1Is5i/IWKTghmzUlxdLfH8vyZFY4MNrfesA/v09H37KTaHOHCdx8zAEn+UdEfdOm+9kchvP7ShdEgf+mlXWFPLuzLnYbPdOjxBapP5I52buH81YLtizsKar9iQujdG4XQ+ByPNgGts65Qr8uBUnKv4XnUDSyVWMDfLOSkclpn2IsH7BsrC3yFbxm2HjUbMUygw9uBgrbzg7CfS74YBe0S6Zxzvx7mi+EztCJIBx+3QJPsEq6TbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhBUlhOPbDC0FcqsKABvR34O4UN3fiyxd936xBJj2zE=;
 b=TO9qVkKHMtibv3ApaZqEqmtd69c1meM8mris6bG0dLm1Ovs2QWuzcZ4fvPe7wqN4tZYPhW0JxSqdjjwIDMFddO5r/O+d0tSWh500XSyWeq3QTRtVuV/c6bsNYBiKqDSNpCNt27DsEVllAzLTqaNtusRJS+73gZG+LlWXnxPZGKI0zFHaE2fn8KBnEKcxIZ7lwCm4BOeQFgTXmQzAEAABeuTNEgHdwMftNI2mCF3kALq+L7C1+yzENdMotfP9Iq/cuwScxWCPmtko28Z8y5HeXohksXCKphx5+xwLRoN22vt3Vwc/HdtNmZ7H1T6kK+CvDnXswVE119EjWGsZyiPgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/12] mptcp: dump userspace pm addrs
Date: Sat,  4 Nov 2023 08:26:18 +0800
Message-Id: <b332deb9836a37522288141dddb5498ce4cefbe1.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a01d4c8-6258-47c3-632d-08dbdcccd1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LkFrf9S8SFOxVNpKnXGuqqEhf3pbiwsPC6dU1uRtT629CQj1UWKBvIw9kGFFE65H8F7sBfRoq67nDIKhp75YXAegSufGAxBuPSzRFpf527Lxrsrw0cqFLpJcTE5Jyw9Ia6eQGEgMqskZ5uSo4ZJ5LAMm1dCwksGuLf/1LuTM0vRP8wQ/8D1FGPOEa/3bLbof0IaYf5QKTJXDvFV2ASpIu3jsScRjsOqFLpQNmKJjT2Rq5CFMILfXIaQ00zzU3N5HhXSRDjFmOP3JrmF2bWL9sNyE6ctq4FeAOCxPIg3fckkNrTCKXHBqDOsxlCkrtMy5JsZ810PJiIYnWAUh6/EAJxh7E7e0YIGs8H/geBMsvdNGGzPJcaKQpeP5d2yAgQ4IuH3u+/k4LvroQirNnyQUWA1fXu0qH5mV6kQa0hxX4w90lMmTGPE7WnoQOQWouOBS+fjWKbhp+jAWGLOypgS+G0ffS8lYCxfbx11ufaCpLT5aT/mmsKZIJLQVL0iA+oHzp4BkF1iJvcgYB7BiHZrsTCuGHqxxr4Oz7+t+E3N7S7GrwtxXX8KPu6O4kfG/RL22ftcfRRa+JpqzR4MDtQgcHdWcJP2b3s7AAMbvWhU88Wk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2JVEZwWVVkxY1ycqbMOlFaMNCZ/GmbBjzlat+tSavQiIZpnqAw01OXVWvGW?=
 =?us-ascii?Q?ldMpiBGbnHRiAzrSNplPAL31G7krsuW93HsBRxdeSW55OUDQU6eyWfo1coKh?=
 =?us-ascii?Q?UE0g/AEJKxMJZvfpBFXqHUBAhrad7Ci4PzQmP1cU2EX7k/7UxttiWYJj8YKk?=
 =?us-ascii?Q?TEcrKxUmX2FMnvkk24Tljt4ozIeZSlUrAtEnKmFGe4JspM5kTCD0jw+H1fyi?=
 =?us-ascii?Q?UBSvR96WWHdD2yx1jOrZWpaLRfVtuL5cIE3H1VpX/sZjYyBcm6dJc1765+BG?=
 =?us-ascii?Q?VoBrIhx0OmC1086ANMvqJfqSBAEm0rvcJaPkFaCzghZUchUctvbVow7IkyYa?=
 =?us-ascii?Q?qjTBJaliVyYemmE1IU34u+8Loamr4XC1tQvRavBZJMkiXBVmnRjJPDmlpoFB?=
 =?us-ascii?Q?7YWDtZGnNvqycol2k12d5S30gB++2HD+1kiioaTplrvthdmjM4TpTSRW5TOM?=
 =?us-ascii?Q?le0S2V5l2Burj377Y4MxZxWbJKtusM9KvLYWwZpGohLwm0XaEjs+7FOFPfpZ?=
 =?us-ascii?Q?2fbDZmUipFJwLCdBVPpzXZ7mH7MvLTf7C2ZURGZVWBTsc80bdeuQ4bY891it?=
 =?us-ascii?Q?umvBSa9nGEMNGhIfQdk3bWlZRKuitFhQvgxeSgodD5oOf6fZ6rD6pSFuMd5O?=
 =?us-ascii?Q?noRiIcVjp5Ddyz6P4GPjIqY79vtbN+J/epzEt2g4Vr6cYatEpA2UZh4FLjEI?=
 =?us-ascii?Q?vFjAX6NoHqWZqhPqLOdkyKoFT00BMc/NZYgTa0eyiUFZsbmhWOf0PykCT+/1?=
 =?us-ascii?Q?VmFdFWZM0bDXrF1sNb4TsuYgArsTP0Zn5oKGs0a8/NHZKq3iVA9DLozBhjV4?=
 =?us-ascii?Q?ChqD50WUlt7bBAJV6k4+3D7IQDn0dXKxTVQOf+wTYzbbOlOaxRt1y92EQ/xd?=
 =?us-ascii?Q?zBP8zv0cIW6vBnFpqJ0ojrHlF5vo4kwb9L4x4dnlFhiU1J5fxkjIuOBOBQkQ?=
 =?us-ascii?Q?eCUxnniOdwG9e1bYTXqjphyezzl7Kax7e9NWkMkimVJWNquz1kNsxYL8qxpy?=
 =?us-ascii?Q?ll1c5ghqT52DiY4SEY6j+Rb63ZbSbB3lRF3RYU0weOtQGR5n4PQGDWWMdulP?=
 =?us-ascii?Q?Hbj2q4Xp64D3Gt1Dyo8NpvjvMKnAR4MbmfYv3sjOp9MvJrO9X1eIg9cUrCGe?=
 =?us-ascii?Q?LJ+Dhm4d+gBUJyAMDpPiHXSTOamJ2qawG6MQI+tKoRntmKtO79I63HHzPo8+?=
 =?us-ascii?Q?LvwQJYo74T+K5sHtCmh7l2/njmHfz5TWUwCLks1K9sRklA+igZL2QJN1w7dq?=
 =?us-ascii?Q?SZWBGw55z1p79Fy7xpG2CcaYplgVialUIC2fv0Nom3mmuthg/mUg3xkbBcd9?=
 =?us-ascii?Q?aWJkaAkoBja9ll+gvDQRG5xwrPISCmd1CFnRjw61Ya9TxJd3a3mYXwH5Rcbl?=
 =?us-ascii?Q?EaAYAXmdbdfr1AMLbOzbZn0BqFL6IeNaOhnLea6Ydl6zEbb/K8X5tabcqUtN?=
 =?us-ascii?Q?zYYgOx2pkIIREvuseVJqjStUJHYWqRjsqN8hoZHOLoPUujBYK9yXznNHkrDJ?=
 =?us-ascii?Q?cPoOXw7MRzqQcbuMXQJK+vSWLpwJj7iFEWhqJxBuMY9q2r9aCbK4k/5+Qwns?=
 =?us-ascii?Q?xO4cO2TsJp8FDGv9tEBhGdQQWeT2lc6kEJFO0Qm1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a01d4c8-6258-47c3-632d-08dbdcccd1ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:25.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBx82+Ts5mdzxzpWhUKuLnmSDmiFLCaa4Lujb90lbHMCKewzDwITqANwTqg2VcEq4Xh4q8dh0NzOz/6hYP4IyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  7 +++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 72c7b929c229..a974e4e8ae81 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1745,8 +1745,11 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1302680388c2..644162928f16 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -584,3 +584,28 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
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
index 9b00eb38b2c8..c8b4969ea43e 100644
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

