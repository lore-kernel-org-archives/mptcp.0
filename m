Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69858ADF
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QtTzjT2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM/O9t4KpqQj7HXEaykq90WBO9sGrYf41I8FMXX9lRGPgh5nD7rRbgxsJjKKqdACyWz8ROlPM6ha0GzBsF0c31im+/uWvxF7XW/9vvBdS+cn0YBihliIvpdVFsf75mdOymQXO/MVNNdZ72129c8zz4Gz34NZA2u6kzHOaiBoZqkH2UcuFs5WfZDxo0nsKjJXPeVzmrg7+6AI0Ns5x/FW8+v9vElOwwbDZSmOjJJHWZBTg1GafYrQcFgzY+Q6uHUiJqd7DS0+RDpFL2TZiZoiVPOHSyxzCT5yoQuAeIhnWl5iWK0pzKkD5ig8kUuqRQWTO/7DgtbCnBNq/7nbJDFjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6MGksTFx+t4yzf6kvysgft7dLwKH1cppACIWDAADlc=;
 b=epNBsud6pzn176U6o/JA6EesF28Vbi+h+98wBMKRxPjk67WFGDm/jPnbKFkP9HquMXxvckSQzGt7uQHHZg3+Ea3LnGZZzHPq9awb9iC4qRK9C5Ii7gPIr2KxxOnf6fPMIoKX2BZtaQi5+uim92toDHosencKrROMDwCnTWXE8wnJqvJvEC04bF8Fy1Lz7S/kX1AhDJdmM+mZZxxOGMO5OoU0kuBcgXqhRA/j33/vUSTKJvhmfJ3yqH0jesMiRmc4wVfvts4e7Gp8W5Wrgsj841YyLAdkWNM/HyY0+ohg6qiYBeYFWVWVjWPfZ34zauovk1u3xDYSrzOl1deAVx+qbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6MGksTFx+t4yzf6kvysgft7dLwKH1cppACIWDAADlc=;
 b=QtTzjT2QapedVsVSb/gapvHKE0uQLGmz0A6Jes5Y99NGqCRxl2MzvGwNoIFaimCo6gnf4NFaoRidVM5Yk7R/Tj5WcOSzugpM8yjXcWSahYYdxpwZyh0WQAbO1gsinf33BsioHQrH2q0EEW7voDK/w2L9HiY4aYtH24NljpSBS6epjEMGuDEcPNKxFQ7XHhtFZusQIcK3SJne9PFI2JZ6sa9mrUgtH/WZJNwt17EsvnVMmLKZmmCEVVKM51oDFrXXsxFoyqhR0vxCzzO8Y0wJdOIzuvBO+Glnpey0JU3xWqL7aB5lXZb3fJYnJfzuZOo3Nlg5dRSVw4RE7uDuxjVaMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:25:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 27/32] mptcp: drop addr_match and id_match
Date: Tue, 28 Nov 2023 22:22:20 +0800
Message-Id: <273333bbb1fdc6a3e1ed3556036594c31338a953.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 80017a5d-a503-4277-5284-08dbf01dd059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XbLZJjsJp6u60itfvUb9lVWIbMrl3tRsWapBBPX7HS9ZO+EoE9roXjKxV15Ao+s8Na8I9nJx8k2UKbeNpGSq8fsYqS5SIzqK0LxJ5a/xJcgD75tEkPeXmS8E8p6wF//AhqypQ1ptBPd/SZrLesy1XbtZ9VbKFau7W9ksKX9DDsjFQ/koNB/CKlOZebgpJC4hqCvQ4ZMImWCqYqkRnERn3f88x8Flgnx9c57tY/jr1UVAJuoSl3j0Q6c4Xni8gzj+ojQFb+4JiP1hZTWz7MXGOtJoJPXqdkVG3ORxn5msRmZDv7iKdq3/5wgRYhOro5M96IFj8K5LZU2WFkRPK8vPfu0YMt3iVtwxG0s9DULKpdE90qO6H4d2j+zkU852B4jMk6VuqPZ96mG/vxFdzgUMCVwVYfslKVNM+KGXtVyALJ8eoKMflESQoQtyo5a0/On8BhGjkxcU6xGB4PFiBdR5pvX90lqN9nSiQdc4a2q0FP30ftSwSYAIYe3WusSoVxjkJKOzj+JHPRZ9ORWvZM+VQZVQ5asALRjRfhN/YSSGl5MOhPm1yjyO1ANdGVg57MhP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qHK6pFvKuO6mcN6Yujq9dVoLcch8sDra64vKO4OuJ7ffOGZEu2xRcD4ZRrBo?=
 =?us-ascii?Q?xI0+xkbtBGvYxhJrbcbpINN1LSFA51Iu9iiBDfq3CDDFDxCdSeiCuM6MQiz1?=
 =?us-ascii?Q?DsNefwHl4qKlnhse6n+u5ZYjhTlOfMMr+cnjbcFqlzJUg97mBi+cEqFbkq//?=
 =?us-ascii?Q?cxvsRyrroDcA073M7rwkuHrwlCZza4PakgMJC+1SGj2fppaxuo18asyWUuZs?=
 =?us-ascii?Q?9QKyPQwoKY+rLc6sx+0mMBE5gMfcEkxmRS/ql2plLY5+5L6j0hSK8auO0a5R?=
 =?us-ascii?Q?IZanIASoo+1HL5TGGspSB1uRhtQ20mQdROOnac296FNe/5oNO5fyoAVm2MN3?=
 =?us-ascii?Q?s9AL0HmXgYbv9YM/WjyGL/J9gjH3kxvA+JOERcdL/apCLeKdphTQHctO9Eap?=
 =?us-ascii?Q?LiJ4WyiVjnBjYnaY7RyfdGJN7FX9PaZnudajP0UamRu0pbthipqqSCiv/6WJ?=
 =?us-ascii?Q?aj/MetFfFczXpcxrTPZdX1XNnlaNhKQuYCs5vfuAuS5V/OL71eSKw1QJo0j4?=
 =?us-ascii?Q?wEYl1f9Wx+Y30wL2NVs9jQitqVbxEiJ+Rgl4OnsNGyjk+4VfcZRSG5e1aDbg?=
 =?us-ascii?Q?vLQkFjqYssXCnQfIEzpRo1sTMnqrC5vf0GzSGOpOdc9Z6TtNFv2CUF4DGlfX?=
 =?us-ascii?Q?YbTkR6c0lmxKWKnJpmOsqYdbh6qbRfcC6ogwSe01yTS6jQjQhbAB1v0PPd1+?=
 =?us-ascii?Q?FR2tGjxiltWpdWiRzoZ1aFhbQvN5sry0OS5pFTurkdIF3YGZPdYsH+ClAy5y?=
 =?us-ascii?Q?yddZ8G65gGagnvWW1K1IYh5ZoorD6owYdgTAlXmQPjxoPjMQ9KUJdE9n0BhE?=
 =?us-ascii?Q?QWfiQb4BnPrNIQaI+3lhX9plnVPLkf6BAzTUg6jA90Pn61LLBbsu+d59ogyf?=
 =?us-ascii?Q?GWqzV4KVoos9VkfvJEt+EzS2S59liEllQZwPC84j2b8atiAq+7ix7aWZ62kP?=
 =?us-ascii?Q?gRRQGQWxeVuOPMzLgx9K4GJiffiV4ia75OCu3MCGHJ0Lr6Y5WKim7IkN+X5P?=
 =?us-ascii?Q?thKztCzToG8t/r78bpHbVfjKZTc1UtuAAaEe5QVQQ0eZhlrKFq5HU8AZspUs?=
 =?us-ascii?Q?rK5EQcszX2t0u/47VsBZ4PQ2NHkhQsA3Wqlu4Gi4kuGTLodaAh++jzABHZZE?=
 =?us-ascii?Q?VcD9pw4LdUiRziMXPgzY6LC/UIcnE+fA5Jr0lzWklGCLeAGTsI+C+CO8fCQy?=
 =?us-ascii?Q?G4+D8Z6CnIugyacv78vUNrwFOdoXiZM7T7MwFVez+mCWUjMqe2zjsCNrtJ9X?=
 =?us-ascii?Q?l1izAcGQbUjKPVrvMuO7JkOuOK29K5WrQD81g8y5vAkfRGtd9RUmIoPVWFyr?=
 =?us-ascii?Q?W5TkDcXoDsz4M4AnVLczYRYD7KAC1pTOyYK2+pEFuGDtcJ1RBPPFgSWUdwF3?=
 =?us-ascii?Q?AajdpP22RaBMWy1oEZty5dsa0AGGAi7I65MQWburFN8GLSU2O15kbc7oGV/y?=
 =?us-ascii?Q?8cA5WXX4fzqrznf6LgefWmXJ61avHRCANIyqh5se3tsWwaE/bzDFuxbBjRW8?=
 =?us-ascii?Q?+nKZ79kEvwP8hxDFXeu58tclmoDvqUfsZeXv2XgWS7tX5GI3KxtSgmQSm0GY?=
 =?us-ascii?Q?4qUKHy4+zHWNBwlCdRDPkQLdtEYoB92n59kxcyxz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80017a5d-a503-4277-5284-08dbf01dd059
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:04.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHq/vzU61TB9BVjDyKq5mpcsIGjinT6T7yNZRfFw7svK7IM/52dYLz2rM9b9HX1fc/wY9XwRbgDyNf48DJjutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8c7553d7ee65..a608166af121 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -61,26 +61,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0 && !set_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -99,10 +86,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0 && !set_id)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

