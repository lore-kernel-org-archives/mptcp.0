Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0C1FB8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AImr4VYCsQRB34+tWxYEUUhbQOECWUW3VaRvF+t/RXJRIV9IQfAa0bIw1fP2ZyfFbCUTBS49yOXlSRLgFDOihnSqwNn86rHdahpQ2wiRxOZlqEORGI9xMiVpa8EyIar4hRT2eTKZAdalPt7ILSSLivWvCK6HNhj+16aSwhQtcbh/QAIMk3rpgzCg7pAZTfheAFeiYQtb7hK1pZnzWqYSL7q5FOPygdVg1ocM+2KREfhAk4OdyOqaYMctDethHlXdUumA5PIxtJnXBg8X5Wnd+wLsM5s5nMBsLoQuXN1c0IXerufOzncMS/Ul+XihWOh/NBfDyhaB70844mzKmUwyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUuPcMYp3H9yqBsS1EVBRVe2IXVbrjOhl0x+Qn/ky1c=;
 b=BuAsi1DUgae3He7tIMvo+dB5HAoIl/gsR2odPTpx7TwkYKkrVvzfvcU73X4qVkhmm/8xPE30s1GkE4/84iPe2vg+AUNKZv8KKR3C8iMD28w+HXkrz+t7i0tLUDdPqu+4iG9huSdFpEVF0nwerPt1FbAT4zmPedaU77hlk43pkhNe70Q1WzoUdcHZN5Yw/wFB5g3trbm4IFiOIE+K35LM34SS3TEMnwboZL2PpvmKaHRWu0Xg6Wt3yBKk3xHW5uTxGbIR4zkEHDICkAoKTy8chgXurw5ChHomo7oUwpWojYwCJZq0jef0Vmc2cCFXLfFu4bOz4NdsvoaKKQlYu5mp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUuPcMYp3H9yqBsS1EVBRVe2IXVbrjOhl0x+Qn/ky1c=;
 b=Hq160pT9sU1CKMPbzabmSLNUlhSoj5EbYowvHpF3HA69+sPR1P+afaCRhGEnDkxYomRSp3FVkLM+TmiG03qFyks5iR2XtRJ1+khMuXrZ+n6gehlJUo3y+Btl/rsWmLqGW3Zud8/XB8+NYBI4yxBvb4WrzL0pgHvnyz/uigvjQrnUvS8/PfxYr6/WwL34b+0CRCtj7W1x8EcKTmV9StCXeNsZvN08C9YunXSEtlKSFtNuUgLRKw7GBpAOZYeGKyNXo+fnkFrNCfeXekioMLVglsGYEIz2QC2tme2XeYI64VHoIKi043UosIiSrH514jf9OzOQsn/yB95k6ujMPIytsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:07:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:07:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] mptcp: unify pm get_flags_and_ifindex_by_id
Date: Thu, 25 May 2023 16:07:09 +0800
Message-Id: <aebf16ae330cdcf47e05be90b2891f7d9763ce98.1685001897.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685001897.git.geliang.tang@suse.com>
References: <cover.1685001897.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: a76bb8ee-9935-4d99-9817-08db5cf71b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVDq59OCy96vtS40G/QW9dzUF6HS+U1nKR/R7y5OdzyLsLQJGDWaUw4DDPhCV7+/x2Kw5raw7pp9tqV0Go5zDE3teak0JEKkM50hXMLl+ivlfNHjTIF4Hu9t2tVPEZK28Z4OdqWCtTUrJEwz4tqsWKzhNAX1XjuNlFRuI6rQiCxCIUh8nAImAUfTQ9sOmnbXP22/oUqnhDr1PGp3XE+iAdQEJHasncIBmSjMGG12PVlVFIc1x3bptYtv0w7d5utMpsqE5OUNMKjsofLsDebXXuhQ+oVl0lCOGkXKl6+tJk+r4ccyj1BhY+lJULtf0dGmWBEyHoBoat5AqlCKzx8cocPpwwonOe49OoYB+K8oWHfU9MxfIADvbQs5f6XDl6ZJTWglaNz47mXsgbuJuel4Z5row+i8wBOqA6vDJIElp2Pqyko1/Ar5kirpUBb+XNbH3m9zBeruBBad1tXidrxpjLRad9Gs+VOdnaayrpAs0VEVS5/eqa4rpgnP4PzZrMsadim+SN4/szLf0ZbvKKrf9gqrhyb/eT9QdYm5EeKGYsia0o+dMwqio07RQZ6K6s0j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(36756003)(38100700002)(41300700001)(66476007)(66556008)(66946007)(107886003)(316002)(6916009)(83380400001)(6666004)(4326008)(6512007)(478600001)(186003)(8936002)(86362001)(6486002)(2906002)(8676002)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lb8e25rKxxnckcj6RA4fb74nyD3EDjfb7WYXMMHQSZt2MfG+ZiOO9eRS+P8t?=
 =?us-ascii?Q?wpUQNk+uJzYTV3ygDkpnGxOlOdoD8moGchSNyS9FG7KcLYLikR+MFu7am2pl?=
 =?us-ascii?Q?Xr4tJbTlzQHxcQJnHHMWz7RgXp3IJjVsVRIyn9+3BHxkjDFHrn/IraiHUprP?=
 =?us-ascii?Q?m8Bk3EIptPDEy+vdiQCurT71ZAGD4R1uxxH9oNt8F4thSiFdpI0bBmJ8PSty?=
 =?us-ascii?Q?2toBvb7R3OHPp3H9JCiHXcDs0tKzp0vZ4H+BZjQiAlKUMce7/j47CCTsrt63?=
 =?us-ascii?Q?ZH0KHIgnT2jP99RJj3jBZ7VMH/vXheohQfqlczq7L1tL4FwQxQxl9E0csihR?=
 =?us-ascii?Q?3KRip9vynHtYiQ7Sn+jsh2cY73Ex6n5xB7yD1PCkRb8L/ZjD9KmgWz88nq4h?=
 =?us-ascii?Q?JFUYTBP161TgSlzSRrA+z1iHkme6Srv8oR1xZZ1Ct+Kj4tTpfAcR2vxERYJ/?=
 =?us-ascii?Q?a25Uc3VwaKny6JoEUFeZN7KOPevxG8CqXsJDj6E6JikkXlYtP3AdonqsUTMS?=
 =?us-ascii?Q?xcJNm6o6UwY/aY7j6pnLo0azqM8bFy9uvJdUxGJ5KabTCDmGPTF+Qojbb3ON?=
 =?us-ascii?Q?NE/AZPH/p3XoOZ3kN9mdJsAHR88XGC02JK5vBaVZcTf05Z4RFh//ZQV4mDv5?=
 =?us-ascii?Q?a/2Ukm2Cysk49Shtr0uY22x9miTBpLNwTC8WYBY23sbZyICJXIa1QHSvgL/B?=
 =?us-ascii?Q?7GgAgOM6PcFACn0nGFBu8YujG/2L4y7lfPcvzPoh6A4Z2va2N6gg5JVeWYqP?=
 =?us-ascii?Q?vAzr8JrHxZrugNebAJ59bMZ7xET0yrDI/gy1/4pCnt2Fk0g6x1+LJ16I+28e?=
 =?us-ascii?Q?bTFo0jxlutmOnrCgDv0ZTStyk3rs30gCnPwtBqRsMPAy8e0Y5+LJulXsXv7+?=
 =?us-ascii?Q?nAafPFgL86oirfc8g+bCQBvw2L6qG6cWmoPZoattdwbDtm74wsC55fMPQ1Op?=
 =?us-ascii?Q?1PY/PZ2hy/kJsQzqLCp2OyJyDbr2ey8+T7hg1YVPV5SWw700AWj4OM3KJGU2?=
 =?us-ascii?Q?7hmCfZLxpsVgdLUPCFEnpLsUFZGEMmvG26wreIX7j9+rpgM4qtPeJ1k1zbXL?=
 =?us-ascii?Q?iq8YtZmLfVF6Q3pIM5tgerh5TPTBYfpI/9pKshWZkcBh5E16GmwDKWMNFVXx?=
 =?us-ascii?Q?TqgpMvBEx/6H0CXtIPE0nw1AkRpEvbdUZRUg4o6K4GZv0YwMzY4nUiEGN4hb?=
 =?us-ascii?Q?RfSE4BZiLVESEXxSfJ568RwbyT0Brb1YI/7PWZKRxTjp0m9ByBJ5Tw27RtAD?=
 =?us-ascii?Q?qV9LcVBs4z4wfdVy61LGw5m43wHX/Ecr9VD4HNwarUIegq/tpX6EXWFplHAk?=
 =?us-ascii?Q?JRRNxw3+TuiRr8+af9LXTzDiKrR9G7I7o033AuHOgnSwN0AKTzwIvCZsMy6n?=
 =?us-ascii?Q?1Hq3slHbLBx8110CjknJrOEpET6ZYkdZBX7lNkO6bG8fgE+7uMCAxCBnPt1A?=
 =?us-ascii?Q?yCJkErBl4tkReYKF2e7divCZX94IO5ygrd/PFhXJU6gTL+pNagvs+oY4d5UZ?=
 =?us-ascii?Q?KtcZ21KavCRbxUClSnnv/sPizEF6qZtDHpFDFDylp4qgz370C5muaAKd2TMu?=
 =?us-ascii?Q?NwoVnCsxwsDd9EinGahZFHLkyv4bdjRXH/Fm+4E7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76bb8ee-9935-4d99-9817-08db5cf71b97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:07:39.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMyqnAuDwbP5cTJhNmmmJk2+lWh6BWRnFs4uhQTa3rjx5j2kYo4CGvye+2sNUqKAn8V3t253kIHufWxg5VnD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

This patch unifies the three PM get_flags_and_ifindex_by_id() interfaces:

mptcp_pm_nl_get_flags_and_ifindex_by_id() in mptcp/pm_netlink.c for the
in-kernel PM and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in
mptcp/pm_userspace.c for the userspace PM.

They'll be switched in the common PM infterface
mptcp_pm_get_flags_and_ifindex_by_id() in mptcp/pm.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  8 ++++++++
 net/mptcp/pm_netlink.c | 10 ++--------
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e37df2f45c70..8499196b8789 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -424,6 +424,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					 u8 *flags, int *ifindex)
+{
+	if (id && mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index deb097f16abc..ab4f0483d9d8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1359,8 +1359,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					 u8 *flags, int *ifindex)
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -1370,12 +1370,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	*ifindex = 0;
 
 	if (id) {
-		if (mptcp_pm_is_userspace(msk))
-			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
-									      id,
-									      flags,
-									      ifindex);
-
 		rcu_read_lock();
 		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 58989303470f..c91c9387f42d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -838,6 +838,8 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex);
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-- 
2.35.3

