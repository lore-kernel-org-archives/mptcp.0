Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F287F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/310m/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1wYmuazgqPzbrv5WVdyqNU4hu0UjR2tZRh/yceg2QtNwrow6HpoXNLYkGTG1EO2jjeGsHMScygwfVf7Ee0Td1CQ2K084kf7eTRIoQ0c7cGXJ90yCXmVm29cvzUCw7+VwNKl6YiqgWGUgpQ7OAHQgAsrUSUWGNGBVc0WawUM5sH+qAAhKGQw9wJYkZGshOGTuVh7Gm9F2Z1VH617GxSCwFuINZR08yy3t6GdCcFE1INOiqGwWAHNXAlugzSMjdpZeAWyRnpL22sotmLfX5UDCoqVGc8LMAvghCkNaMGquLf6u7pnQwToiii/QFEAQp6yTDq7QD5SCtZjoETH0HBoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7Ssu9iljPYRRzcfOEy1kp+ToUQ9ycQCaVYMOFiPySA=;
 b=MCbtCOoowxQkojPpl47MnfbnqqgSfB9cgG4Z0xO0mIvRflZVqvvbbjMZyC/QgQw2lpIRVGnrsg0R6EG2ubKQPtiJOMUhJwu78Inrr8y863uQavskLLoBRrirw06swJ2yLnbpLHqLo3mtcQvLrAQSUtcdQB9+0Le8fzU3+3owaxFheThFYUnXLuUja0hTMI4Cs0Rv4IXfN8yo1SIAUJTcldF8BFdbDJn9dLP2pJQVVAHW6NSAku+YMAuhh6b7Advbv0Mn3YOPI2HS32IMV+3JclZYNShKp/gZxsTD9/NHD7res6qBGIQFwHiydPUskMmUuDRu8cUMCtcN7Sus5p5/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7Ssu9iljPYRRzcfOEy1kp+ToUQ9ycQCaVYMOFiPySA=;
 b=D/310m/o4B3GI+r91UvQ3Y7Sj2lwd/Bm+wEEqy72QerE+agpsZ4eq56p9AqNEANrovlKjuuKnVN2fm7SovIuTwKt1dVEbu2N1mO/p43CTrNM1F2Qy3JJec+0VWljCNm4bUtzxmXPZYUlc1v5UdQ9yzyROLvk3upWbMLbUGhDUd7ib3ofpWFzX22X7CpQyd38ONmUvSxJM++xJzMxbuGjTvrd2ei3v218KEbXMM0kw2f1+i5TKEhUDDs95g6mvMf/ALAzZLDqXfZEMrbzSZjAKX5D8S43Tk/48+5pn3cnaBrTCVz/1dphryH0fUGKUggH6l38y/9xDiq6hChZ7wb29A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/9] mptcp: add userspace_pm_get_entry helper
Date: Wed,  1 Nov 2023 12:38:19 +0800
Message-Id: <5d4a7d79d4a7dcd6ebb486549bb1d08585b95aaf.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: d8007769-a5b9-4a84-7c62-08dbda946ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8h20oBlGOXGVpdUHaMH3JH+LBww1TSdOBJRjFEH4ypSFnbdp7tfZuFtwQms0POzWhr/vx8ldUAW+bdbtJl005QAFRZN6o4c7dQ8LiJ0lBZPxwykiEqWi+tzKGDlfG3FzDzvJe98w5h8TJrnYGBvgK4AyNTHAEcYCZO3jr2FcEI1tBu2FKFCJNzgdoGa5qzavUJhMwJ8/+efBpYcLY3mCcNythS7E/TRvUaVK0KZxe4uZn8/YELRLiZV2Yqi8PXcFBa0UhJqjNosVS8NfeuCQB5WOj659zz9a//iyhVKt3P37attU4UqMMbMelZNCH4Ddh4pNE/LoikrO6hn2nPKXUOoD3j+WwOjcFO4w2SPfE9yLp7JYmrL8kW/Lk2hFVn61t0ZxutBE/GjIjIUtcKTvbihFXvy9oaeX/bHFnFea2cGziiYhFr4tRFAozXW0MTl8SLptl+VMf0Sp4Gk6y40SX15FIzLptmXQoQpVFEaolCQp7Z4FikQZBy9cbQy5+LLXtKl23v82pxc8p7fhPfnhsjzSp9JofVF2MUtwlgdbx9v2H0Xj+4iHFzfUpl+stmKwkxl6w8ZHSmWVc+dbd5As1hfbA/bWJHIlKjnHA2IDXnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e7oG7LUP5sg1pmHcIDjN/Afb2lP7u3guSbrIs5fZq94FCJ8/1QyzdknTAWJs?=
 =?us-ascii?Q?x8sBUdncdj/oK3dgPEiTld51ZydUqg5ljMRVG9trnhgG+zmV6CmG7LjVBPXq?=
 =?us-ascii?Q?V4VoKO1Lki3DkNslPBYV0ZRAV1/6BZ02QSQ2qInW4Ai4bIiP6EqPJBVWvTNh?=
 =?us-ascii?Q?ixhY8JXSKYdSbCA8/ZLkLrI2t8R/orvTFYjmbVGw3MHlNL+whGmLc0pmoUxn?=
 =?us-ascii?Q?MARvk5BW7tVNQELNLlVRYSwMHQVOnOMM8rwiUh18batBwg6HzthJOH5X2AHh?=
 =?us-ascii?Q?U60KJAb8ydm7K0gOXWrjhTHvy0KZUChRFjC0ZM5u5bcPj74F4GEnbP6RZHEj?=
 =?us-ascii?Q?D4+zioOO0mTQYA0O4bsg3KHWJApOywcIDaUGR6Okh2v9cloWB/xkZWGUWGdH?=
 =?us-ascii?Q?VJJJYskoUcj5xjmTiC1A2N2COgPfYSv/qI0eerpdz44bXdxqHq/X6y6quDoN?=
 =?us-ascii?Q?89BkxhxtSCQHxaZ8rFSvoU0+AE32KnWiMAqtuoStLL1ZuFnOzoDatxG3umhv?=
 =?us-ascii?Q?5SHPb06LNASUkC0YKekgXuSGs3iQuivSJJfaoLVkgpP4t5yYqc1fm5lLccrh?=
 =?us-ascii?Q?WEVGjo8rF45OSf5BXAoF3pZjK31y/l1PSTWclcVxPQasjRtRMyfRZFwRPVjK?=
 =?us-ascii?Q?A4IZ16/IdD7xqG40kxfODHeyyFjoeAQU/mPxqMFedwKNlk8O7gMyuKTNsov0?=
 =?us-ascii?Q?5Y2kOC4E+uk+Hnoyh+gmg26qeAwqg51Sf6PBS57KKv7V6VYNI0aZMzUTeANX?=
 =?us-ascii?Q?TZ9PjssDwTsJIV5kl2s6Lm00474sUbpbXACbh+d2sbLczCEyb3GtN288HwnS?=
 =?us-ascii?Q?SVGYh0WodG14zrTkLWcLlHa/RrWfd+1C+X3YX6dIeJUOf8OKxx28T2FyEfS6?=
 =?us-ascii?Q?DunbP52UlVy0VcaeQk3vhkBBxwLtJxj6hJoz+MpdwbHmp5Is/dximMaLqwq9?=
 =?us-ascii?Q?U6/zK+o4UA4IIUl1uDSCli+wzPxhtTV9+l+ImUJl/uof28xLVEZ9egqaH3tR?=
 =?us-ascii?Q?zussvm4OgNRUv+mD+olJHWI99smv84wQryHaB7z5ol4z0CIvcR4hxLlL4cgc?=
 =?us-ascii?Q?H6Y7uxq1u9l1/7hWw0EJaipLYYIL228yOK+6xKXG8axgP2kACVWnjzVl7hra?=
 =?us-ascii?Q?6HrD6jfsmQEC+oHSmr7ErAoP38qWrfJpxTOKulQmyO6yGI8F1+G3FaB1fLCI?=
 =?us-ascii?Q?G059d+wZFIGR7zyvxdHh/kUoiI3nUHnL9m7EDKiWCV1YHxMxRB5DL3VEk2Yd?=
 =?us-ascii?Q?ndduWGDTcDjOz4q8ZKphn4tzjtxceRXq3J9aQThBWk72jWBYIReehsvgs3tw?=
 =?us-ascii?Q?I/VQi6A+soIR4kl5baFo9xyyXIHxk2mkJLUDqcgY6808jlVbmDtAtfA5dhTS?=
 =?us-ascii?Q?NQYX/ZZQRzVTB2zx1SQlCq40Lrp52UPYmPANNV4E2CERPNy67PK4mvMlGDaK?=
 =?us-ascii?Q?vYMH6VNjnfO0e+iY8VfVcaIdzSJv39MsttDeVqv6Gbd7PNMFU/oJp+1hJhN+?=
 =?us-ascii?Q?tgH1H+AoMuNguqBENv/dSLGR9tRawUeF1wKUqPtVbv7A0rZfUOJYFNrchSgA?=
 =?us-ascii?Q?9oyrAHdwcw0qClQo42JS/FxMLrtvEwrQ6HLCcZEy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8007769-a5b9-4a84-7c62-08dbda946ce8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:42.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDkVzZsXysPxzPZxqHZPAwdU1yohI+TKjSd8OPS/ZSrBSEYIERcVmwS8DSzh7cXWvdEPW5ALeN5Q9vL+S/nudQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7227198fe689..934afea24692 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -80,6 +80,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+
+	return NULL;
+}
+
 /* If the subflow is closed from the other peer (not via a
  * subflow destroy command then), we want to keep the entry
  * not to assign the same ID to another address and to be
@@ -88,18 +101,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.35.3

