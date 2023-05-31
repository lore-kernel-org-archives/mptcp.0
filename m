Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894241FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VevnoLRNCN4Uyx0wexC9s89/zJRyqdbdbvCY1LIOAd9fjIYE6jShdkxvkPPGw70OCFs2Asuuox3m4ZaXLNab2q7mvRpXZ8FYyBlKuSXzLub6sIAOFhDnkAQu0+YbZHSDOaiQf6QAYtmvuybzMYEnnRvhgFbOGIm3iUWfNSshk3RjzJEQmlidr8dZdS6fcvc2KO5sdN+vdI9FxE+iWOMpWVcREuZRhAo9CaPm9fRPF8r5akj5gwpO44I/Lx1omf3by8xIs6yRT1csv0RPfztT9Yj3elyj55WkSMeaZK4aVKihdMZ1kCddgoq17eS8mzeMcmDz/kaCant4f6VciJIgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjstMBIpJb25g+U7v7VrmkLyDv6N1zC3CIpculI5m9s=;
 b=kk0d6KYwTTVxZyGRLko3pOeCOnjiWLz4Qs4Y1wIgeogGnguMay5CbDY6F3lsc63sskAewVFUo7QuIJdMcPhQn9KWnO4ONFaSvMBSQgtEq3vgSLKr8OxSariQe+Cl18/cwZgpdXlTfAvg++Q5KIv+JZcTw/IShVn+zwKXaHNAnzVPlCUITP6uS6d4UM8DLOTEjz1GQUKPC8I27RCm8E4rJZrfUkAvVquFqOvxkgtm6Islp7IiHYHDqMEap9duCZApi0ZTfoGG4voBfpCAv4OHuI8wcggy8utx1OVD1VIbhAaU7B8h/nx43M3tDFlhePCylcQu55OoTIYk4VDGsFXocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjstMBIpJb25g+U7v7VrmkLyDv6N1zC3CIpculI5m9s=;
 b=Th6H6vx+qrBn+sWwMtR50Dh5X30gAUeQBc60hwLdXlFtROqlpYZJ3UlkgmnNFrect3FuetOSopIOQGadIp399UTvj6sBvY+vx4RkH1fH/xfxDcOgEtCwzmM36jKVO+B6WH+gG47Xi5r9JAx/s3MdAx+Fj84mIiYFks0bd46XrjKgzDrH19GG2qrJBEi9+8SDljefMQ5veE9TQN2wVCwsHEDLREK1oIypzHxiGFdX2s7CmoZiBFdNTu9wV0rgCxmMIX7WZa+gFSm7DBIbwRbA19ZTLMKPRZi3WUjRa4DHGaHCEpz37lpKxCUjZjiFuXnXpzb9r1YU3zKJowNV/J1qHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 2/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Wed, 31 May 2023 16:58:51 +0800
Message-Id: <afea116c44f2dd23abb19dc91ad9d5d7ac49f714.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: e308de38-9612-4d74-0dd6-08db61b551e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lV4SexQClHHt803iK5FgRDzOamlfRSKRJssextl51IUWJaWiZi0NoegygKrOh1QhjRyyqYcsJckK5r6jNVOnaQtzAThuJUwkPo1EhNVaMBm4j83x/p2ZLDJO69JKHXMlWwa2+gcdPoYS7USY5ZmbI9BhJQ5DKGPYsk8gAQKSuM/R0oLjs4XIKTqWwwYluWhQAXBFrzUCHPAY6joLK7hrbIW2q3D4VkcVuByakehQpiQvfzzOZC4Ce7spVuk9SLZTXP5YhwUe/4hLUNC+biZ01fN3JevE4ClzzwE7FVPAsrrYcnWcealcZqAU6OKPDg7XEZBGQLpt3WlmNJkFA4GC5ZJt4v5dWSJ4K2WJrUYkV0tyC+O6fJwn5S6m+CCoxxN+yQ7zMDoAyALHf4Rx1GF+KWxeuEs89y0LnohMqLPMr6V06Y+Eqmtku1+lTviBVB9ifaIIzYVFEqhXHPrw6blPGeR7xUErajd+epHpIAeBNLpn1M6/JTMLt4T+4wjq1+y6g6MjfFsGq3yNQHCGOPPqTv9EWkGMMnyn+3kYuqYNlbuO1uZ8TRitZNRxk+x7nEtb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SESdGBcF8PQjHShR59lEGHCoDLwXcqaH+KypZZPkSl8UqhAznDOF7Ve+YBR?=
 =?us-ascii?Q?ZUB7rNjeBZX9T54vx7Z7iWTOwFwAvQFgp7GDRmY4qtVMZNXDrwBaLaxPvD6m?=
 =?us-ascii?Q?GD3svQIPISTOSMWztPl3Bxu9qixntP2bX4LGHkWmze0Dz9jEWmYNtL0LYfbt?=
 =?us-ascii?Q?iEMOXNgKLKkdx9rjMs3XUk/tFB5Y+g/6r+wOV8qMPBwr1kDx2FDZ9HW0zT78?=
 =?us-ascii?Q?x3qzP13lOZpp7WPiTS0o7CVLR0as1Bzzoy1Gh0OZ7N9bdZcCpFeX0iC3c+92?=
 =?us-ascii?Q?QtAUc88PYn7aQsUamAKGB/moSVnOjz3b4qffmufxajEplYk63qkwLpK5aLHo?=
 =?us-ascii?Q?EEftxfPB/yn6Q5VeJ2udd60zAcZLOZYbjm/odyhBuftST9GywVy2JixoQVeN?=
 =?us-ascii?Q?iLPTkIVXWIzYAAY9PPcONrkf8CnTD9djH+T/EvkWEYbH8RhTP34VbIXRU6Jh?=
 =?us-ascii?Q?JFEj1OgZDgg/sS3F0NvJbq/fhTiduUXXGOrjP6PBC/R+IcElDDevHH9dqpmH?=
 =?us-ascii?Q?RJNKaBzjLwwrIO4r87l7Uvcuo0HqNzLEHWyC96MR/AWt5qw57Suym8MEY0Ih?=
 =?us-ascii?Q?E1z0vKmwRFrw8VYXfDSTQmHXdI91lR3Eyl558Fl0xbcrhIXn8kUxNZfDZQyu?=
 =?us-ascii?Q?o8UV1VWb9I911J+y6Exb8MplF2tr9xUQjU9nJe0VTBujkhFf/ucDSOiZlYt0?=
 =?us-ascii?Q?NUTkiL6OhRmJGgrvoLL9yQ6ZAFrLOC6khMxl94WgEPK0+F6GjOfwyu50eaLd?=
 =?us-ascii?Q?OcpDvCeQQTH4IsthVhYqk9J4on6PVE/o+n7Ywn522caYlZs/2A+AhQ3WOPwG?=
 =?us-ascii?Q?R1YLjob4L4p0pFJgXEOAcOV3N5F9ibv3c8FLIIPewRPtA+qO/plmMQGvUrfU?=
 =?us-ascii?Q?h3HkXlAvo3U0ao+7H6xGGRBDMa3e0/G0x68WP6HpttyWaJEKn/grUhT565kZ?=
 =?us-ascii?Q?10w2gc0yBw9EY1HBhlITYAXDFuyO9wuualk8XpZ8kuCW+DOUbzZPzrRUA4vF?=
 =?us-ascii?Q?dXPxkLoTg8pxYJmxKk2wSSIjRy46772LFLCdYsD5hoS44WRFViPu2/2MMPax?=
 =?us-ascii?Q?5xxQqIXvx3+q93xi9PPBcVNotURBUXPqEI/sl2HlZfMmnhEQsUKI2fjL4q8I?=
 =?us-ascii?Q?a4sFlanTu7y6V0xVzxemrouvoZawnM6vEpDa+jDSdFI1Yv/2xMO7Ah3JZw/c?=
 =?us-ascii?Q?Zumw7FzaIaR/y3VLycKNJ+jB0MsT0FLC2UCabG/YcaOhal6pArLbvQ9dz5ux?=
 =?us-ascii?Q?REy1VGJ620RW9IiYz3a2cRqn7SrCcFMru75ZwTZNnIvob7Wy4xhqTc3wyTn8?=
 =?us-ascii?Q?9oMTkh72dcly/eg9MN2x9sGMRvoDsvGyEVfeCiMuhIljtUO1hVkyfaGqE+ZZ?=
 =?us-ascii?Q?By9uiWcTap1P/Av3ZQFanK8JcuCx+E3WFXjgIIZlxQ1IV+bF92dHBAP3ICfm?=
 =?us-ascii?Q?q0EFAPWeEemUmnEVBowNxf+Efi0vZQNFyVhjTl7w/+58IBmTUZXHu8LWhlxO?=
 =?us-ascii?Q?MU6nLw7tfMZt1ij5f7K6HbT5dTe6u4GdiJbRNZeDw52yC9DHzarOp/FC1nzi?=
 =?us-ascii?Q?0C2VhcnOdPVKWH0//dQ+Up9GzeetNIrOmzVTtsaq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e308de38-9612-4d74-0dd6-08db61b551e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:19.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHCN/0jBDwmtJaayMDtmbUBi6AJIaJtG2cR1DR7wQMS2aC2bsHtBWRH+5zE4Z51mWd9LCqnLmXLFVG+kAhVJoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec892fb8d85f..082018e4b0bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b06aa58dfcf2..3152c197811d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -196,7 +196,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4b5c5004f34..83b4cb16120e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -832,7 +832,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

