Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00D612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="n64VTwZM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WME0qvP/7JEP4Os2U4Pkw/RZPJHkVNmjEfwzR7jlnZaQK80kAHqOlXOMTVy7rZbTcxpmV2MRRA515TLMC33fwHQzs/9Vh+FLMibmKSK14dulyiQXz+0bQ6wRNN03JrQzlZ5FGSE4nRKlbSedk7OHluP5U34++FWd1dirSbSnEKpGf507CrMDBqX6fehDts9Uod0ubRuvvcBWn1zpYuJKfq/y20bTwf8fMeK4SEI5kfaMhNKKXXcRz+7E1pF4V8TFPKdQcgixhxbb492y8kU9aTuu5X/ddgONA0xbWBWGktDRZZwsJgh4UIQ6T29x+y4OXv4s5xkym+asAvZ51Cx0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlyJvEqbeWSpQ3OD6OWfSiEP2Cej5OMKDu6QuQbiCjk=;
 b=oEzDDUzdIGPwLrNAUO64lLdVj2+Ng0NDTKEaaQaL87aPA26PSDrOvPpQizrTogXzOVEiGenuWps8oJusOAJjZURMvhTrQaKiR++xBsemj0frS5/7rjWUIohix/G03myxddphKs6bUXSKEsLvPRE5LPpZ+7TnnlxcJ+p868BdYMbeO/Ew/VWmFbt8t/Q2BVzVISH2tDBjdQMyuGCXZ9l9aJpKP4Ne+KSEhlpjciHloZa5g1ja/ilLbYjebqxwuySU3Xe2f+D6nyqpHB7zI7nWQkveYNUKcSvxWOLZ2U5Vmm3KQ54bo3oeaVOnJ8nxVrXYECdDj3eFpJmt55MYXQADbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlyJvEqbeWSpQ3OD6OWfSiEP2Cej5OMKDu6QuQbiCjk=;
 b=n64VTwZMy90Ar7yo5FRbMFHJC0U/KM7W17aqc7sWZSt5tM0/B0+ZMnPUozx2PnKFn5w2z2PO5ZYAPcUT0w9Vk5D8jM9PSYTAO76pbKtQUNL9RLRKpcfp5jpvOKVZzRuOlEr2yWG++Detof+uJIFlz7FZpOdu4+4CSP5mr2HZKt3zthRUlYIHpNI9sdpwFTffPEMCqtLqtJ27cA9P3bt9FR19Bqt6bKOK9DAdNQ0xwhL2/44/h7s/9cELedxcPLFHobxBwOTE3xFPbyW2TjwvMBbVYKuJwP3xYvFZYW6uJwP4PabDHYq8kmIDlw5muX4CdVo7B6jAhsZoR4HEp9D9Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 17/21] mptcp: add userspace_pm_get_entry helper
Date: Tue, 14 Nov 2023 14:35:14 +0800
Message-Id: <f9f5a17651f97b65ec3ccbdec5dc4df877a5ab35.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c30f950-8acc-488f-8a45-08dbe4dc2bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uu6hULSoefcqxRvp2tPlKU9WSwbnYASLnrhvON0KySzFy3f6jSYtM57Cpmi9m/g4HfIzGGQjIIfyg7i8poARRA8sF6/7tdnO/DdxTh5KRGecFLR71QgebDk2y/uaPbgGkQOpGIOjBT5FpF8qWgs5FvKvAqf8oOVEez838QJkEHe5odPYcN8tepv+G2RFz65ijymojMudLceYpGXcZlPsBji0QyGb4Z0357vj10wgZbpLBjWDRbyy4EvKD5LkbS46LszjKeoera8fACxmwn0CJidV3dOy5HI6i9+oBkqYDAy8/eyEuQsPaNFI9uvV3Wn80hk+0QfMiOx6RTdv8o3PIpUwiI9DMeBfd2gF7AbcfEUmcgBvaqQbrd6DdoBeNcdv7Ts6fRlrskBfD76SBbjU38SvubjSR9W35GW3qh40s9uaYDkSSNgWgBmLHPsctQylTPKvtGG8XKC9rxoKQOjUHm/Xdpl+n9U2hAHREWCEHHRYxH5WpPkxqQLCHH11Uf0pEjHPrcgfHsptEA/nsS6K3SHtppnzXnETTrs4hM2f2uYW6awE9OeGQEXDvSK+eHTK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0bUtishNectttIIwmoKDs12goFSrenwPPzR9Cn3jJ6RTCI54jnS6GhDJ2ts?=
 =?us-ascii?Q?jGbIRkK/WD3wI/OOIb4PqPtnLfdLzrcc7qSCOhtQQxwLdJ2qIaaI6SFyp0PH?=
 =?us-ascii?Q?d8hayWtHHaRics18iqAxvR62z1GNAFhwqa7itM3P5f+VI1GWm5H2LGXndQGW?=
 =?us-ascii?Q?1/dFLHk5os8krb/6lmvozZpm9+E4snLdGrni0eahjaiH/0ICMf1ejzR0o2Bg?=
 =?us-ascii?Q?goAbFSv/VM4+OJ1FqM/0RECjOM3oQvJQTJn4u96b0zVc1hghfFrOtOBHK3zw?=
 =?us-ascii?Q?B+9YsFDgkRbgwD4s+J7jdGNvh7ADV6Sml6KJIVVqKMX/4qclplOXd3uPcUWH?=
 =?us-ascii?Q?0HIrmP+dG/YXvKWOMYdXMktkW48NCwBSa5ZszHYfoM8vE6KAq32igR0Yxabw?=
 =?us-ascii?Q?YIPzxNaDVDKSE0ep1p0sAI/L5zR6pSVCI94pfvcwN6k1otvBDFKdYp3cHcVJ?=
 =?us-ascii?Q?f4OzD6WsCVf0ep8sRvMedRsnL6bC+defhVPOKwAe/VahBR6TwVCyhog6bjqG?=
 =?us-ascii?Q?pzK3auTbYMMUb5XaFSrPQzmMppzNQhlSWxqIiKqFW5hoz90KJVaApz48ohtT?=
 =?us-ascii?Q?4064lt7Bmlrc94BVwCBzvEv+vJSaGWxnZEXc0SjJ7DtriETq4u8B+QQ7n/xV?=
 =?us-ascii?Q?mSLlx1FgIEFb6VD9iTPQWRgSHqXMRG3WngBt5mnxBJw44dsf+dQgkgtilRCn?=
 =?us-ascii?Q?Gymvsb8Vjz2znZD710vvYgZUJQw2be7uaNZrFVTIM3/cYx4hiNGSAi9Y5baG?=
 =?us-ascii?Q?MGot6d59jVhmfU8VtwJ99C0LIyz/f8n619p2ZYzfreHQYrTZtNc7EZr8ak2b?=
 =?us-ascii?Q?7fYWN2NVnNFE8+rxduEl4kRkru0tiPysIymagn50iRh2fKMq1qVelnhB0BfV?=
 =?us-ascii?Q?RhF6duewfKSfrGo32cVou5zVw4oboV2+UlKE5LeZLwHWsd6J9bxr54uL76b2?=
 =?us-ascii?Q?3d1nGD78/M3cmV5zV6mwXNtqh72DIroR2EAZAhYoe+DU0QrcAC/cf58P5G2P?=
 =?us-ascii?Q?QRRGjGp/I7iur3oEKo1PRRe2BLhTA4u0DbM1D9YupwLPfOuKqyG17H6JqUGa?=
 =?us-ascii?Q?Iw9tX5zAEYlpTlj+cVx3JwmeBwesisMyoMIaGG+Hx82shqZLKLOPLQcUPX+K?=
 =?us-ascii?Q?Z55HPkYCNkWRHzPlNIGnPKXynOX97SRy25eMK7Y70+BMPfsQDcdu68CGyS2C?=
 =?us-ascii?Q?PIjPBa17KKA2J+qPaz0197Zg8fSdNHAq5agj5bUoIstYvQU10+C78gwDmRdp?=
 =?us-ascii?Q?2oMtC9k3EwTwnfAozVYc+Qujf3G57Aqep5tVqp8RNX37CaLcSWz9R5oFWH6t?=
 =?us-ascii?Q?En1Mg+q/keGanTO1OkcfvUN0QwdL+FLsj0nXnlmLxAEGzSmRHV71LuINwoDN?=
 =?us-ascii?Q?8cUSnnhM6I6AkJAXujVXFH/t5tdTMeR6ooG9V3LnksiLhXY7Xxo4PPWYCA+b?=
 =?us-ascii?Q?iR2XLsx2af6/1Do8S/CSnJyG9W8S4V/BW21CMhG56s00Hm5c60FWe30j9iwc?=
 =?us-ascii?Q?Y/FOt0UmkQKMIgL+TmXsNelud4VefXWIWswxfV+cbzsaoCGQPJkw1QG87fyB?=
 =?us-ascii?Q?IGw3ijVeGU2GLo6gzuyDj0TsPoUNdndTJHhPdiaxcE3PrbXsxrumtudH5X7J?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c30f950-8acc-488f-8a45-08dbe4dc2bb5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:28.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JM6Q9vV9X6IjByXsroPPLAXIfiNidPFAyq/mNPFtwhj7actFsovz8l4nDVeQY6unlqW44rC8IWIHXWYc/w0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 58e9ba51ad36..71c47fca375c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -39,6 +39,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port, bool use_id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port, use_id))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -100,18 +114,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
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

