Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46189125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7VoTTkt7x7YLf808xAaGlD/73YYiydP0yggrpbfGvR1bD5kxunPX584aoyoeKJUCKciHJ39qk0sOggkSEO2q0LgJ50t6z0CqRq2A8YIr3a37fYPCSwsaW/W3+YSZrAxcpnwpiJgscBR5tWOYa8tGi2BKGWHojKs8RYYMnuH5Cc5eWHNnhMkHvKp39lXO2H580lvmtkF48bdxHs10U9IJji/cAJ+lpyODE6WTEIKlgusYtrtfEY/DG7MJtEBi6lLuqymsa8Rh4EojZAWlwTZ47xe2wqcFTzmdSBVRtytdKWYoVn3mHJmaAlYpDjpu4WITexyn6Vz2bE5F9cQzayXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=109AygQyyfkJjS9ejfLtNvX5LQ7m1EIZKkbr6Gj3eEY=;
 b=MAfrrrWF5lP5Rj3XX+ENtKi98FkgbfzTtcaZV/PDfmrpWIa3yaxAVpuWqBb+cUR3WNh5ZLyeq0xha6i6eqCjcnT3kGYii8Vu4vmLTNeh1fL2jLwQ6+EGskekQZ6CAzMuxqR6vt3UHqwdj7Xt6pk476oF3fZnZhEnASnC1Y0cc67rX2e0WqtP6wQvBFEeCadJjIy+xVNihRLhqKwcpfFJlwYhwUeKYGcQVEhtC7yizuAuieudXTJowb1C04LO+Th+P4M0EmB/K8DkPPbFqTv9xXqQhzvYV+00ARfy1ShZ3WUAKhxIRgnmicWIR7woKcAVhQ0rwrFsIZQeULq4MTgU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=109AygQyyfkJjS9ejfLtNvX5LQ7m1EIZKkbr6Gj3eEY=;
 b=gzJ0f/jHBT/qgkQD50XseYQgbROlXoR/j4J7Df1jtaz3gfcGCeQozZDBgz+z98xLNtblxoUg5H5DxQUlYMAez+cbu9BvPBwRTpjup2F7UnV34pF4Izz1ZIFX14CRCs3+92AT5jAVU/3Ggkb3lKjzh3lQq/f6HeZ1W8lnSiGIMW6hmCIawgCWs2qZhRIoJQxdl91dYnpJJHoLbMKbx2gknWIf5bVYZ+UHrldR93FCU/GApe++WP5YDbNSCakPoYvH5Wp6Hq7K60nxcrVlxH9deL93fiNhACMKF4+2rm3qHtdF+LMoSFYnwQzmPQ93NP9w0dYatZ2maXVgkYteDdE6QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 18/29] mptcp: add userspace pm addr entry refcount
Date: Mon, 25 Sep 2023 16:41:57 +0800
Message-Id: <f1389728746b0a44344a343dec208f31d7ed1986.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS1PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:803:3d::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 739a9cb7-5c6b-484a-bffd-08dbbda383e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iy/d7EicaViTpHHd3GJVP0jt2kZkirkyx06J81kyKxqPYZE66Skbaao5A+DmHYKMqFTwK5xAMtYqtUdvR4Nyb+KvySBmM+LWNraG9+6CkSpfp8Oq7g5SHWfp6a3bJ524cR1Y40GcpHsRs/Js69Dz4oZb7NngxebCM4xSEAPW2v6tcqzkuVxo4PYn4uhakuiKqa3I4N6BHi6fUBFASHhWJGoFiklvE6T5eka4R0FYjgP2UkItFWdLkR8EISbmaAa0cv4djASYvf6bFgtRG+IvlwN9/+K/UjlfCO5sclx7mHrqkjrpukWMLBcwXp0nGFESeC7LbemKfM68SzT4VVNK1Okzp6qeveVbmTEMAdd7vdQzDS2D6ynmvPZ/G0iItLTBeoAGue2fDM2CYjXi8VMEMWCbwEfnOAYBIMkbwcMHM4MWgVO6dYy81KepgSwIO2hQKb6Cinkos1ahhbRckdZ89yirkj2t6n+pYf8ZwFrkkpJGudUP3WV2amjpPJB0V5S9DsH8Z1kzgRtumCTI58vTOtewLPvhzE4lBrP9ioo/iELHIXB6dBzA94ry2e1TQGWq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZphbK2lG+ev8x8s7wV7sbyDxkWcMa/SjUWgFtRODzU53gV/j4JRgXNy31n0?=
 =?us-ascii?Q?KSx4WwUu57CaRzIaVa6mT7zarfypjy206NB1xSJYwFERa5xKeoKv8zMzozt4?=
 =?us-ascii?Q?bTZS+Q+vl2wEtnFrDwRgWvxr0xud9r0mkM2B/k0Y0lMepnyylEvwP4q619fq?=
 =?us-ascii?Q?+b1zUwoUop3zeNso1+F2hixHZl5KO4+IvKUhzxLs9CIVLT6hKpozTEDnBYvD?=
 =?us-ascii?Q?YSqDpa3mmlcpFORGZSIHTq+nos0w8ERbUR+/uWDevJSzG4df353yY5NWjozx?=
 =?us-ascii?Q?7AIcqqx+t/lXLO4AzNYK4e9ab0/v17hFrz6PuwEq8uYgtXMEIUtaLxv5PJFC?=
 =?us-ascii?Q?bRrgs+kxVMg3R2eMEdEdLZkUpDWDhJu3ptWnNH9iy48T/A3FFr3vuJCs5rXi?=
 =?us-ascii?Q?ZEJUCjqVs/rRmCG/ouinzXwTcj+oQ0kQu4wcMcWHddWWDm5AqM8sdKMGg/uk?=
 =?us-ascii?Q?SWVSECMvQ86URHTk1jP42vTb5tkpG6hpaDRVwdNc0OBtUaeHxq4Vvv9qOWj3?=
 =?us-ascii?Q?zFYK/s1RAY6VF2FuSZsQHfXMzTF67yZLkqpYOBZoWv9XGJsiiQtklyEHjdiM?=
 =?us-ascii?Q?vjm/BmaE4YLvRTx2DVYpZrCNGAM6NI5kCtmBpxprSOVaylSQ5rmLz2HptZEc?=
 =?us-ascii?Q?PnSFLMo4XDwa9K2kXRSNGAeWyx67SMaM42KEHfo/EAX0BioHhYzmZ0UzPtwh?=
 =?us-ascii?Q?NEhvjj+z4E5wpaN/5c1bcNHg6PsxLNIN+ZNt9QMje8tO285o/8p1Fl1zPcca?=
 =?us-ascii?Q?CA0KjMec7kYWullrYpFiW2Z0EDFdWXjymP+UaHUhoSv++u2zjVNrUxgCSvKi?=
 =?us-ascii?Q?P//q0cfnwS9/+MO5QIck1xttSW2J8nlwHm700TME9H2EX/MVjQGjAKUksGCl?=
 =?us-ascii?Q?/33SrkG4VwOIwqfCUmfslLjXaXAo9Ol3Tc6GX6PrO3+TUdkW5q/rcqjNI5tp?=
 =?us-ascii?Q?P7cqhN0XWKId0DwRjRrQLwNtSgXVC0/N93P6WaJuM/Pje3m6MOJj6wmGfdtT?=
 =?us-ascii?Q?AcH5D6CQrOieyhiLuyVL6Aj+rgAM6wsQLHPHk43SVslc+NxSHjMrPWMM1KkQ?=
 =?us-ascii?Q?10aEashEfM94RD2hgsGMvgYp1IQSMoyapZh11sB5jZLEjGM0hoBlHLyXMzLT?=
 =?us-ascii?Q?gm4aytoT4ogqbiTDGHrd1cThfnruyq2OUkBxwVNtR/k6uUTMo/nHsKkqe4+G?=
 =?us-ascii?Q?KdhIOQLZAI9FVa2FQuuHbPREcOiQ4se2OF+2JY0+eLa708X6xi2fsVv92Fcu?=
 =?us-ascii?Q?tY/J6QDVi1PeYgkSlN4ciGQF4W2Bsba0Cn6tUeABAXY8XLih7O4mD/LvX6mf?=
 =?us-ascii?Q?zZQWS/NxuE/RGd387Iw4g06TxqVmzxcTPAkDdMREDQNxRBouQW8JShYCiTAU?=
 =?us-ascii?Q?ApVFGLCA8te7Gfo+et3QywMUCIV6KLi2ItZKqgiwHZXQrAIVqvmSp3qLujGg?=
 =?us-ascii?Q?sedqKhZTF5XXH6dKh7mWYOTFIyG1jHGzY83r9aoezgsw7pMYc1qkXOK+A7C3?=
 =?us-ascii?Q?N4yihgg7+897Vzm8FdOU6PPB1rtHHbwmYMM6ntDfGTNhbV/7M2vxdXU0JIA8?=
 =?us-ascii?Q?zZX7WjSQ12rM7ECSwCTGf8WAyUWNjZJaSiAFtK07?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739a9cb7-5c6b-484a-bffd-08dbbda383e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:39.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWL/Af+u9cH6gDsMjmFHN4TNqwgFiZz5D7wTUG3F1pkqP+KAjb09BEOCfWyg8P0FwWy7LeT5sdVbpU6CVPpOAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds userspace PM address entry refcount. Add a new filed
'refcont' in struct mptcp_pm_addr_entry, inited to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 21 +++++++++++++++------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 30f4dd074a70..8efca1602e11 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -70,6 +70,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -107,9 +108,12 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	if (!entry)
 		return -EINVAL;
 
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
+	if (!refcount_dec_not_one(&entry->refcnt)) {
+		pr_debug("userspace refcount error: refcnt=%d",
+			 refcount_read(&entry->refcnt));
+		return -EINVAL;
+	}
+
 	list_del_rcu(&entry->list);
 	kfree(entry);
 	msk->pm.local_addr_used--;
@@ -387,10 +391,15 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
-		msk->pm.subflows++;
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry && refcount_inc_not_zero(&entry->refcnt))
+			msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6508179e94a6..a71b64565e04 100644
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

