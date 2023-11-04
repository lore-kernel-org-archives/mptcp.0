Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF127472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="sdPOG0D7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlAVVb66UNzVbj027qxcWpZD14jmRY0FWpO6v37lw9nsOmfgZquel1jM3ljcQ0Vj0zKoeEPQ+sTuPv6imFSHXRYaQkyX4LGn5Eytg3GYHFDyKlxaDF/CihaclIrNGMIMExoSishFw+1A/d22O/Psg4yO2b8QjeNT9084aixSQ8aNB0d1nkNC0mdiVl18zjkGEx8AyPzarjHRbMSqCo45KBWj1EvaTua/+3+puGwNgI+9/7OpP+XhXFGoNg4o4iOT5azr4VkF8IUz3MQnEnjssQNZIa2/fsBdpHYrNupAVTEkC8GGDoV//IN45kdijW2K9EGNPa6pfTJrY79JQ4eIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCf8Bms77J2C252cRZ+ws6cgUlsNHRdmQqK22yszJ48=;
 b=XAglF7qH0AoNeF+LiAA8hPmoRloLHNhrdaPu8e0idHR1iOCA4UVFg59oaDj3CJHKMGvqgNL5bfHYvel5IR2A5NbE8e3ed+aWn2YJR3tLpcjiO7z8Uk/1n94nN1dL6QvXcNgMrowR2FvsPCcfbe5LzDb562TiJpIw+ZT8EA6lqobKczRySFeZDhbiEntbLjl7azyhHZM7OG8CuyoNOSvgODnEqvOomUOQbC5qpu3mNRIc7Xe/LKporzEHcF3YiUQKoEsxmRt6u/PUoaiSEAoSm1d17lnjvO7lmBLEaL13Dxed2DsbATTtwEyVM5zbfLQ3dorUO2UxTbWfQCzmfbA/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCf8Bms77J2C252cRZ+ws6cgUlsNHRdmQqK22yszJ48=;
 b=sdPOG0D7N3qI7nGB3fXmU2K+dJsWlm37yPfoQ+SJldXkoaso9Yp9ngYu7KnMjUHfpU7ZhWnPm03Qb6y5j/QjC4NvUQg/6neYMNbN68xv79cpPV+YZFzuHPCu+46jeYjTfr1mTNn99rG9d5EmKmL5rWvKCT5HBGA7hYjk1+nmr1JPNbrJHPMaDuQCwejuU1DsiLiGL4dkMT0i9hhPO016kEgEZaysLkDVxrGvLpJskRA92fORsvbrmKM59XPhB1GkGWHJV0vPnUlkdhk/fMQpY03uq2CU3mTwMgJYYYSyx4nWo3vggvVyFItzFp4O7YC26tB/b6ecBVj0F9te8MXltA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 03/12] mptcp: add userspace pm addr entry refcount
Date: Sat,  4 Nov 2023 16:35:51 +0800
Message-Id: <9a466f843246d7e644105777b2d164759d04c4ca.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b00d64-5c82-4848-25b3-08dbdd1142a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uGhBSZT+ZXpOiAi7MSiNWxO0AAy2YYAemeeC9meqUPM4oqR6DYrkETlCPPW1J91LFpGLiVGu8cYYbH7qK2EivYdmIg+G2LdcfcOVcOJ/vzVMoc4EP++sMpjnFSr8C8JAgz75nU1xN0XVQv0tc6UAmZQ6jUFSk5ggxOaVQq8PJHRKk7F7LvC5NcDRdMhjnWocANZPq3wJN2qjAk1U+pMWiI7Vl31ic4x5Cw4iaQtXYlnqpUrUSBX9MSPdfedDZ0xygXtINeu1Ew7oW2jR4w7wR/TWMuVOphLK87aRQwU0hoaRdja4jT98hjhH6MYTDcoyBgGNlePvVobvfXd3lhp3vXg8gRDNkVNzY9tQG+mRDp4k4X/nloTGc4bVDuewAthhCdQbrRS9cMST1zuckJShmGl8XaoIm7tCITdmwjW3JMfWTCB2SLMk/Df8Fa68pDIjxjLqP1ghenjQNzVDY97S66ueTrlPBj3ZJgMlxwM1VGxrF0xdf6UlV18GMswuURLh43AL38SwFrpssrmqFCO+Qjn9SgCBQSaArHuugCP6krcwMLokAF9QQaUJhrZCHMIVwq/tJVO+cuL8PgzyvFckEFZKWojj4XLdWDCkidFOolo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(966005)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ue4tlycfvoO4XPSYD6EvWGSndfGXIT6YNAolPx1rEZpUhkdJ+YoUVUibukZA?=
 =?us-ascii?Q?WchHIwcsj9di9tQDMiZNWijOyWm5xW3NA+j6yAvq7r0fVqVgJ/DGzWCxRmy1?=
 =?us-ascii?Q?VDJdRSivg3YS3bYhss8RP3w+ALQruCPZut8lxJlRXvXaOgzXr+0J0fcZKvOg?=
 =?us-ascii?Q?L8HDPOt/2BZzStY+Y4AfiV8yy97F68/nHpBLTfrvblNIhKXQtgUlAqKbQx06?=
 =?us-ascii?Q?mhWWj52nExEkiPNLbzznbE2QjPoKC8vuDtV5ja3M7Nva41dgWvNcyzKu5/4Z?=
 =?us-ascii?Q?eQqp4FFmAFe+lwyp048gpXEGLAZhbR0UgXhuQvuHfkYaaE5jKCtvbK37Z6Oi?=
 =?us-ascii?Q?WAXLVTLckShfnWJKlpOk2sqPRaNcCA6XGGYpUn8N/BKxCxs2uRj63/1SJO1y?=
 =?us-ascii?Q?uJph6tASUhfr2Ue5k1xQb9DC0z1JC29TgeZyoTw1VvWO7okBmnQG39zNKobZ?=
 =?us-ascii?Q?pXraH1zkcktf9OEQCH+v1oSjtud/C9LR9a+rjf7a/d9fx3Mtz8vD3JoY70/L?=
 =?us-ascii?Q?XGy2aahaFCbzLmSl5GPfGBv7bwAW+aAFk7ImcfLaS74umXhpOLTYvnWCAEiZ?=
 =?us-ascii?Q?zkfqGwRIiAPQHRDsstSI01NLiWMjc1EFQIqxvFzFwW5aZHM0tr4+SBe+HAR9?=
 =?us-ascii?Q?F4n9fY0LiHE8iCDdgbFBqzfM0r2/7O/HluVINldob+BCafYAGRuZJIRkqVZC?=
 =?us-ascii?Q?8KiZV7RyIH4JsPoyCuWoad7xzZn7BaGZQSvKHNpcBotpNEzYUybTOV4VtZUR?=
 =?us-ascii?Q?rudYw/iOtWmUqP060x0yBGw34Gu9v63HU3nVir1NwpUukwshbjtec7MTFICo?=
 =?us-ascii?Q?X/+XS2+4g5jv5pKwTwdIyjlA9RJF2FF7Xp9Y2Rgk+OWZiEz8EaY3pN6jc10c?=
 =?us-ascii?Q?bzhlQPN3TWN9O4zbroos+eHlEjY+ZDptEEwAQ4P0us5Z3Wfq+iVvIVYPE/nU?=
 =?us-ascii?Q?xN1PzGC5n0YgxEWWhp8Arbt6ziF0y3yCCikKcikC5gdWsEZAHTZDoMEa14c1?=
 =?us-ascii?Q?F0qnO6fGNrE+27QmmVMa63fs0HM+yCMp6sMFl0utQuUTkt+GXVNyJLtQoRaI?=
 =?us-ascii?Q?9pIUvgAZt+rbsy1IsfuKFCL3uFJNWU/I/3JCmgEQeAfQGw81L7uVrdi2Iygq?=
 =?us-ascii?Q?ZRwlqxi5kkotKy0zz+tKJpKMiwcmZmMw7whjqfMvX5dVcrWohRCHGTUKdti1?=
 =?us-ascii?Q?lU2Bj12D+7GxL+/+BSMAzO8ZAJEKYUn9ew6U+f65kBQoUdIZQ78JPgnkVWcK?=
 =?us-ascii?Q?DtmdRMtn42UOnXcsgFQNVSKxXSWHxVtAPVKAdlnLW+7e7geSLV8OHSruMDjn?=
 =?us-ascii?Q?nufhWf6xQZHL4s6CbsbCKpASh3SdcMBjcid6iYi/o74oUtl4Gush5jbcLfIn?=
 =?us-ascii?Q?O4rv7kssNbZ9OUMjoAHhCHMBGDRWBQIZIsb0hVpTVAxgGLV0AMjMHD2NoF/r?=
 =?us-ascii?Q?r/e5gzPJUt8vDA080+xgRb2Lxq14hYQzX3pAReR6Z6FrIXH+1wzfZvxj1UNX?=
 =?us-ascii?Q?u+rRwjipyv1ROWXb0aorKPhuuoqL7ocPiKloaBgdvdM6SPpQnLaywyGQOCVL?=
 =?us-ascii?Q?OkxXN397DPmPotMgSpuHcWlAkQwL1Kv0UFQ8ybOsJTLb2v454JiQ6rxZBfbw?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b00d64-5c82-4848-25b3-08dbdd1142a4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:20.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU7x37Mbaw4OoTQwjuohzFAbJTcf9wTUi1oL3dqoVgaxSJI0DhvVT3gu5S2NVLKFTVSGP/MqUmLOvwaGu+xwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 919428b9edae..3e8304fc1271 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -99,6 +99,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		spin_unlock_bh(&pernet->lock);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -121,12 +122,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -220,6 +220,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -325,8 +330,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -411,10 +418,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5f2c52c82cf7..a7db86901e77 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

