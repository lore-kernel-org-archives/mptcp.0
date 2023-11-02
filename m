Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3311CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L8eUkms1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ5uTbeivZIJr8+RGghuKULRQd79XHJ2ts6PMOhT2g/jV4a8PL6MlrMW0dhW3U3zCM6qwebUP+uPa5soGMTOraS6GgbRLNkkFjJgbBDakwoBb58/DZS3JjXKB4Hlym8Kip4zCt0I6mkfyVEzJ/M9qc6myJqdhXzvaXWkbvgSRjMgovnR+FNofgM+wLyeUBMzDBQ4hhnSFcUTny5g/v5BbNlToL66dHGqLyO8Jc7vdswY6USwCkhjD/2ykpoYXD3PqRgRRbRb5WtvEAp8Woq8ZA3OJRHy/1Ra6IJ8bt79IIzn2f8GR+pJkW9fzLwQokXcNtKqg7ftQtqzVaJ2HPV3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKXnnJzrR08/qMp8QKkbY67C96F8zeiYUOah2aR3Un8=;
 b=nGqSnOkXCheLjHqvh5tgxVM8z4V42GV63RKS4JN7+XfDcWECRbtVyO0fN9+7LXQvNDMHC8Xb07NXZx0JjJlOQvRw5tyGiQLcFcOyz0+bdEYRULjDhe8TZcAJ6KV+yugcqbkbIXTkGzS+tvUUzZRlx5rLw8Kijj0DNzwqXphpA8+H/qqFfQzop62SGBSCiG54QsXb9Vt2Iw7DqQrjJp8vI3mPChXjIhQ06GdJNFeaS2y+CsK08GR6evHFfUSGoHeTPcgCL436FLu/LRmQd4JbYvvcF0+nmIm3PchNnlGEPlXQvGagg4MxkSjVPX8XmESQF6NgHO8yvZvO6siOvdBEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKXnnJzrR08/qMp8QKkbY67C96F8zeiYUOah2aR3Un8=;
 b=L8eUkms16jcTwkC4KfeZrJ5/uZfyNtdvws+q5JQoTPiBwEbDl6zt+pH/CTxtYA+70yuVy1CaguqCcjJV0KoJeJ1ONBthWsIxkwjl8Hi/o6OGumNaqO0V9Dq16XSkMgG0HVDxhU4jfxrYk1KY2H8bs0gkV8aYzFEIVv5VJF+R3inUxIlbhWQ5KtQjHjsDiYfKcAcu4+f5N3z7zyAh5E90Wv/DLlbaYcywj96EUniTRrGGNyMluhnsvq5N4YpW2rHm5Ufi1D+PFtTEM+1rUviFCEGUoS5TaUoyKf2qY4zRv5p7SB2kHw4KkbEdLNzSzf4BC9FPEZWubY1Qdt2l8Ar69Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/10] mptcp: lookup_addr_by_id helper in userspace pm
Date: Thu,  2 Nov 2023 17:50:45 +0800
Message-Id: <3a4c60b4973911fe50820118248a93be444d609f.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0190.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5974e4-4227-41db-588e-08dbdb893b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xff3I1GxG8wsfeKHL60uoRSq44fBWwAfqmxaXi2NOUq3hgmdXpB5K7amAewj/JfAXO2uL8AkpI9YXd0a7NUpzraG9QBx0aj5R9MD3m/LP6bbf9oti8dw+QH4xiMJTJQEc8zNILr76PiO/SuzxGDW7Pc4a73Nvqa5zg6fdf00GOOcOT7s0mSuQHl7OWbHEf0KU/NY4w2yfb7x7XhLtCcwFnnjUmDv9O8pc7V/brXyRcnzAn/F9XbJ8uFmyu8G4PUnsS4S/mC/FkIR7a75+Z/A742lPG4HrG8YGLHup8jgMXAE7BZKdkLDeO8mWxp0kb07qrbrRtJ07300a0/ZraP9yeGPVUFin+A57oT44WWgfUxV6fDawRwTfUXMPrLOPSy4H8g9A1asY/PHV0CqPeK4TIaiqX5s9XReysdHPQ/NSrIBfMlYaZlkejomMmoqhtEN8DwiYXnd1k9ocmOTFPRFMxZBV5kO3mVMmB0xLES4Dk48PA9ftbwSPjtH8QGsjzekLS/+n1SlK2XF6RpG6+R2jPcxx0HhRP5GDI6SJVa5hFtENyJ6hZZ27H5eM/DJ08OoK7ES1efZDn5fac6rbtQx0xpsK9TeIRqZ7Uel1Po2Xc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4EyF/Gw/bDSj2CL0Gkvt2JpOv5Q0nAonhxe+WmZoihQd2kGFlMYM9IJrW7jQ?=
 =?us-ascii?Q?ZU7RJYL+ZE3MpER/rmnDOmLOVGlK3ceeTVqo3vORJgMcQFPfAktS3WpGwIdM?=
 =?us-ascii?Q?Hlrei7qb4BXnqLrJLvs5Cc1JGDMkIkhDedg9qaRsMrzyEFQKF6hEz2WBtB5S?=
 =?us-ascii?Q?i6IxwxO9LRDqhnyk4OjJm59Od8D8oCg3wtK9BvESO9Up85K4DZes9hKR3wxx?=
 =?us-ascii?Q?swZwJNe0RQQoLYW+wrbrfX0l/rilSUVylRvfCuBpK/0ZjRHy52CSfZvRi/qM?=
 =?us-ascii?Q?Gg59WTgtfxl964KyoOPMmnt2U4DQF+39j+DJ86sUekcwCpXM1O4kdu97Au1I?=
 =?us-ascii?Q?1q2VxkizSnRQO4Z0w9lpew+g9W/j7e58HIVIJywU7e47qdnXQMKSZ2cePvcS?=
 =?us-ascii?Q?FPCz12J1WXNvIXWP5eSHq7ANYDJrJgTOhbPl+2JJIoN9Z4bFREA8DFCzcM34?=
 =?us-ascii?Q?X3OmTTc8H5gZf80/vG/lt/4bVYm5Ns8nzvkUluECbPFOKw/++j5nGtf5feNP?=
 =?us-ascii?Q?lDzC7OqhMvyI1nLs3tEyvZepQ0B0k4TBJvdrp11T2vLkKLoRdPvFpQjvjAcf?=
 =?us-ascii?Q?XsL/pTxj/hyIo4KqgFHJs/v5Xi9RiHmHe/IyYEOem6C8QBxKwTpSGA9POdLO?=
 =?us-ascii?Q?buVQYUuRi+73g382psFNhjsDNosAJuoXB3n3vLmLJT290m/vL+JFF2i0PhCz?=
 =?us-ascii?Q?eYf+nbIFhjd98DJlGIDVr0ddIORyfaPjpZ+KjY/wSytbfJ9hAUMOAUwzrCS5?=
 =?us-ascii?Q?JHfd0qo/1oumQFCPbSrNTpQH69UN6Aw6w+/9snv6lYuVCOeafMLrfNJouQCG?=
 =?us-ascii?Q?c5GhvDB2OXbz8+RbA07UIN7sJqBBwgTRCg3jwME9EtxRljJgbG2+l9qlUpt8?=
 =?us-ascii?Q?lijt1dfWeVaCVnrXEDxJcwZKBwD1zBkY15/qUmShJmBDaoTbrEhv7Llj0TrA?=
 =?us-ascii?Q?NrP5ZlNsIN1FQQwpct0PQKRlk7cl+Q96VnMhOski30Sdh1zKC3TCeE0FvmEd?=
 =?us-ascii?Q?bO63sUi0lv4AVX48wJWktucfkm9zzNboTQF/msi+hoFHTU8CXQz3546bo17m?=
 =?us-ascii?Q?H1AFAqbuQ0uyG/Z96lVQmrjSeZ2TqxulWoIDyigii2Oim8AkbhEDYYLZCiTk?=
 =?us-ascii?Q?AHrMfGEHtB53M/pJ0LI/rvnVhHfEotYzEu2Z+y63I7naXEAH54i6w382QIut?=
 =?us-ascii?Q?PL065iZW7rx+QqhCZvoBnhOcsQpJ24d4ktWw6YCb1noI9mYwWbjXfWoy9iPe?=
 =?us-ascii?Q?KwfHmjOFyPxqWszQhNnpa/5LB/LLAn02fzEfJLX9HVA015sZrQGbWwNY9f9y?=
 =?us-ascii?Q?pHKFSBSTqKfNqFiL2/skWefpBXJxNUopMlxrdNQ+/VJjPLrbIr07IN2Rmb/F?=
 =?us-ascii?Q?WHv9+tXgTOY+ATKx0h0aFcpDUHObpTeTaM6t2j6mLymUJwbwZUF4/RI2tHLH?=
 =?us-ascii?Q?/gdr+nlB6c9RUntBEywoqF7HeeLUIM9L2yS0Wol9KmapP1hg2/qOGsvdCqcj?=
 =?us-ascii?Q?EY5nyI8b1wD9X6lZIMB70OL9hcEwc0Yjg9AVnkHMFPwK7Na00a2tGfjFz7aX?=
 =?us-ascii?Q?D84hBq+Cu00Rp+dyFJbQAaNxnkVHUapMC4rn6BEc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5974e4-4227-41db-588e-08dbdb893b52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:05.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+CZC94eV1QOZ6TrKDgXg+xZ5VNaqfdgTYkday4OIezEp5BahoTQQYGzodvotMiopMQmrARHijWK32n3QJ7D6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 69733a1a5663..b5687578e6ac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
 								struct mptcp_addr_info *addr,
 								bool use_port)
@@ -122,15 +134,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -262,7 +269,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -299,13 +306,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

