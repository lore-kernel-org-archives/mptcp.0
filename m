Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3A31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKxr46i59fTPpgKkjZ6ljClM0f3qBl4wwC2bt5f2nBVq8B3bOD/V919T+lByQ+jbRZSpvuNeV7TGgXRmaxYv8ot3mi9zewD1jCabKpFiY+1iJrsJpiAaDsAvghTWTCWlDkS7iuoYgdeSC6sk1Yk4icSHVR2bWyYcZJch+uIAsi/ev5O9GT2GB74ZeVzf66aC4ls2jNhzggpybUUflP/D4gg6Qki4rti+SZBlAF90Ho9OLAO+PV93106N0j3bxBzVbJdG0H1lD+A2yJmvUnRT22Nin9LJpXy3WzEDxxB2XZc33HNBcPD+hoqpgMwYC7W7yHH8ace6FGA28sLYh5e7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWt1G8qJtcNlvR1ojF2/stIP4boXpCPl+SplV82Ys2U=;
 b=dzPIbumP02tZax6WVMChZ3+BeoRD4ho5EyIL+FiET9C/qdKwPJqmbLTuHOg46geluAz6gLJy+xmdpXCB8oE/D7B65r/n7F92Yy9v8QcOVGnFrCzXLlLh8UUkw+3IoVzLdSFNLg0Qk/gtnqKqnBdwhdZCu8m7oaTi9RPCfKbyvxtLbfxZMMsa9GjZnIVAgKuQSyD0rzjafF4Y5PxiNxQvq26V/kafTJZ+RJvUVGz6uxcfnRN0WhF5yzV9IgRarEx8MQ13qiWd2rc3UIxUVVKeCno9czXDSBYxMtgMtmEMogqvsZva3VTmS07I6bNY7sZuklGyvrlxlCb105QGMuAHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWt1G8qJtcNlvR1ojF2/stIP4boXpCPl+SplV82Ys2U=;
 b=n0J7jsnfTkqiV4ROqkFEVPUU8I5CoqirSNQOeSQqxL7nhC5rA38+dEOIxsscuIprDL86uc3F1VTBR80M8YCbTBiDqPuEvD+H1Atm/vYuJ2W4IXrJQ9miZ7v/cOeI9/OSgV2uqfruLmQ4Gb8ws685IqCsFVDVKa0Evs6TSR6w7IIamoqCo0/cdFAybWvEbXxbYUtN/OExZ7/M9joY38QQcHzfwsrIK8AOY7MsA+Jwn0FRjpA6YXNg8Ralmc2SrdTJjsY89D3ubncH+FTmkIcZeqtfGGvjeVizl++cQQl4A2tusVtqUdpRIc7+Mi2NCKzY3tVoM4/EKPxYjswzsTqPjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 20/30] mptcp: add netlink pm addr entry refcount
Date: Tue, 19 Sep 2023 12:02:21 +0800
Message-Id: <9f63b3165770e871595d1bf3f9d78d72a6e2e3ee.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 63007960-1927-457b-3c1b-08dbb8c5901f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JLfvyX06NgravRQQN/iftg06n41AwXNQmbOj7zbKFWczsFvXbSRFDHv422ilUomoJIwFuoivXFSrOn45zc6TGQEf2Arw/w0o5vwNrFkMeHC4skeOwBQ7Ow7TJkLQinTPQow2w4SBFHjZZsj5ddHIKXvqhLyJ9B2EqokjMpKywUJEe7OULnIerzq30qKn+UhDUXCwulIvAIbBdqKKa5ljgkLJ3wRwu0M05gEQyPXfxz1Wd9tJYu3DCHGUIIOexlxI8YVmLdtVCgFc1GW+kfYorDCc65A/dDlbRfvFtqKKVKDp8ruqavKAxuXg1LB9eZMXfE7a1E4z9A3/8eQkhjc0cnJgwmCfc60LRFcEx+iMvC2C4DPRh8j3K2OJJGjabO6xQRxuNoYFsWlNCyvUjm8CQv2CNQOkNuwClwr5IpZaJhrmSTDkdVhFgMZov/60296qQ5eUD5ijIoMKgXMCyAHWKaZhc4+pFTEiTV/POKd0Kq2v/n5M8pwEElFLKA7J52D2vDUegY91CZjH9h7j/aj2UJTO1RNmWA3OeOLf/wsRVbne7il5IdCSJ+8uOyaijmz4yoMokzkkTWbOecHs72E6qQftC7cn1LGVEfAKp9Qtm6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hY7mdHuSQmvFliksYS24Gxebgn7D3GquHB8Poh+09sApRWeNxY8Q3oGsq3h/?=
 =?us-ascii?Q?dvMrds65KHZPWL4ZmYLPYgTxaHsNt1aFmA1BQ9VMEYveaDsWXbMw/YbNz2q3?=
 =?us-ascii?Q?fGsYrrzoTMRQvIcfCHarvYChzFv8GTY6cMyhbIKFYVSY7zsNqcklIThJd0UO?=
 =?us-ascii?Q?OhQbC7YWNi2NNYKWdMj5knVIbocYCK9GqkciaiTOlWPnul3mwbX6Dhi7xCsC?=
 =?us-ascii?Q?Xq5FIUsABi8D1Zcc0TqK9MfE5z1Y/PAqMpNP/JGx7d7J9xPvGOnAuFgEpDgt?=
 =?us-ascii?Q?OTkjUCuPWBG6mMJMFxyt3byLHA8rkR+rDg8E+F331eu27feQHwZGHBVfYxfA?=
 =?us-ascii?Q?zvp4wXB1wGUbSrP3TE6DIZIwc21VPK71J7CiSFcjl/vP2iHMwKcEUPg499Zr?=
 =?us-ascii?Q?NFH3c0obzUUeVPOKLIfRMb0tbh1IkvBiRUwalgm4Z7U7YubUzC8oTcTOsa0A?=
 =?us-ascii?Q?WwbTtlh1jYWgFzF60g1VArg6GVjviiFYtR9yE6KJGKRckgCqG5UkKsgCXkFh?=
 =?us-ascii?Q?qnYp/qYt85n0Leu/kZMIB+M1vRiuI+/E39u/c+7UhRgmuxbTJhPjZbyoJbEv?=
 =?us-ascii?Q?OQq5UgA2cCB0hUPIx42BImKwlzge4u76W3flTQgazcAdZqY08AgoYGXeHJRY?=
 =?us-ascii?Q?tKX5PX6B0wwZPr5c5rHhG5mlRnDE85DHJO+RlQD9cGQcB98dSLjU0mmrkdlm?=
 =?us-ascii?Q?FL+yAKbOXNbUvW9EMK8+pa2mvwXylGlSdKqXkcqiwYYlCYVOCdjdn9AWCd3l?=
 =?us-ascii?Q?GLcoOYP4BzSttHUvV9A4o5R6saiLYjwcIwpQy/75TNejTRUwofnof6J2m4n5?=
 =?us-ascii?Q?//SQTQM9783uftMlNjukrEK+GRdFaJQLTwLHZtMe70/n4XiEnu34Ra9Jd/3t?=
 =?us-ascii?Q?9yXsQHehfHE5TiPkbCz1ClVpGO8c/fSt5G8hBfB+h8r40wPKshS8JtTC8qCx?=
 =?us-ascii?Q?qE+mX2wciXu8q6xtlXM8rB+V0GStma/upoV+9OSdKjYU2kclOaEZbQCYrC3/?=
 =?us-ascii?Q?owtttTA0PXhfIjSOql0jpBmqyNktntW8UXYOIKRg7UJuJ0D0zBgF6tVQg/7z?=
 =?us-ascii?Q?8QkJhU7V7pXeyKg/dLHhNacC8WHs4raycx/z2C44CcRB6bedOGNcKW60ZVVK?=
 =?us-ascii?Q?hQJYllkbk1qkzXGWOrB9NDSmN396/AFUWM0/F7QPO4m+LoQxe0ic0mp9nf0x?=
 =?us-ascii?Q?+GPJ7A52OsC9+hSHmXJ4biRDDJz1UoDBsCVxrXWkl1CpBizyr5MQ7Uo2hIGB?=
 =?us-ascii?Q?AqSE/KE1itw+Jo1UFOFY7h1Ao1loDdjrTPELmBhYdXnou1Nq6cQ7QifwrbZK?=
 =?us-ascii?Q?R9q9EUEy1vrF/6nIfthns+dpJZ+78cTQLwUaab5iU/GuURCQhP1islkICtPr?=
 =?us-ascii?Q?uZGde8ZwsKNSlPotXGAUUnBySBx4OKedDtk4xUzRZwACXtSbjAnmUqCgon5Z?=
 =?us-ascii?Q?WV5M+1ZDGLMlhnZABRMt9VmtxccOjDiBBTuGlnmPP0n+LXiG0ljHp3YoSlh2?=
 =?us-ascii?Q?/rx6iFnzS3LGE2MpNQ41BNDRAhnOSLUhnEbs68/6eU1ElP9JlFLg4NR1i4Tv?=
 =?us-ascii?Q?LTTUpbYsbS6TtSE+pPbJoJOKr9IHtTWRHnB7BvHK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63007960-1927-457b-3c1b-08dbb8c5901f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:47.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA/bbBcB+GIWzrg6+V19r5ud6bI70woUhRIWEz4J9uhag6xtAylF5XtjfiAumaQ72us5b+X9zCmymeX18ZNZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1. And add a new filed 'subflows' in struct
mptcp_pm_addr_entry, inited to 0, to store how many subflows have
been established on this address entry.

Increase both values in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec(), and decrease the counter 'refcont' in
__mptcp_pm_release_addr_entry() according its 'subflows' value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
 net/mptcp/protocol.h   |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..09e632f72366 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -603,8 +603,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt)) {
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+				local->subflows++;
+			}
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -644,9 +648,11 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
+			entry->subflows++;
 		}
 	}
 	rcu_read_unlock();
@@ -895,6 +901,16 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
+	int i;
+
+	for (i = 0; i < entry->subflows; i++) {
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			pr_debug("netlink refcount error: refcnt=%d, subflows=%d",
+				 refcount_read(&entry->refcnt), entry->subflows);
+			return;
+		}
+	}
+
 	if (entry->lsk)
 		sock_release(entry->lsk);
 	kfree(entry);
@@ -1087,6 +1103,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	entry->subflows = 0;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1337,6 +1355,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7adad41b5c1d..1c31d16a640b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -242,6 +242,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	u8			subflows;
 	refcount_t		refcnt;
 };
 
-- 
2.35.3

