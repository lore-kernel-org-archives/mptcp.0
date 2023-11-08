Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C42CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eWJOqLWc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks0udNBjWaaHTGkZ5vgdHHk+0hBEgzR0zKtQQ+KhrBTGcr4hqlrQ20Z9CL8bbkmaxVMwVIKLSEiWACMQiDBtTX8MTCo8MLETGfWCqyY/zg49B2q5t6q+GaSQeCCpoH8QHUyp9W2AMm32K+kpWbohGAL28VFQSXN/xQFUL8A5tPJHTnDzgvmP73UgHK8//GJ9CGHSQCCbZVfZqEQl/duyNlIm7hUU3uBFTFo8Emv9YwDaV4+SUj+Ik1UHp73WRLJLmkNmrY9hWmT/azHtxoiRFO2tOSwRz3VdblmZ6poyLJYju9Ddxo0cr9aCcVryCo0B0KMSVjzC2Wby9qUTq2h1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGfN82lVkeQM0LN3DHLqA01K8e8fWi10BoyEV5rc0Gg=;
 b=GABZZNuUHk18ICQhOiKOxNxxBPkQbbN6Z0lYKLkzI4W3OuXC7FrDlwgzOD+Q9hjdr2h7LsGMC8/otG8UvmkOnRQ7ZjMPaPdUxh07TU7vDe7pjb7+LsnlOZmaqbYPuiASDsH21L5M3fzbWBXHVdfOglFHIxJ8Z8Ch+lTj3tCkEOYLtExDlICdx8VpTAVuzyXjjnUwNGPkCTf70pnMYsh9QOqnU3O1Jmc5Akt2UQWMITVHf8ziZavB3o0j/6we0oJ2MkVvgqVIP9QZlfknHoAF/XWXjfgfuMHr3Vg1MlxC/cNzcXDgnrEs7AMDCPntcfFcr2fZ8tU6xV38eiZl8la59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGfN82lVkeQM0LN3DHLqA01K8e8fWi10BoyEV5rc0Gg=;
 b=eWJOqLWcgSUymgw/++dxIbkYW6//+27+xl4K9Obcu9RMEp19lh4KKb4SYVuZi8r22L8A+pr+rwbLPxQsaW54yzIAyArCMc4+zBW02L2SgWfUN6Ozr5jyQl34vlthUU0hezcsCQQVNOZM9F/qpEU1ACP9zTPP7DizgckwxFcM0M295cXu9cYzTmLkg0xumeO1h7xalUsVe/DyrXQgchcW8gzoXI8geUYL1TC4/afPew7IJYo9v6mgw9qHGO818MNhj7wScPANhyastGDobboy5JgXxPvshdUdEsAyoMUjxQxfkYn7KgwXmdOKRB7XaXMHYMjNgOF7geOV3ZSGDIR/Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 16/22] mptcp: add userspace_pm_get_entry helper
Date: Wed,  8 Nov 2023 14:49:46 +0800
Message-Id: <3d569801aa9429cfb14ffcb59c0c9c0105adee0a.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8239fb-2aa9-4df7-35e6-08dbe02722cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QmYWH/Z2ZjZSxGFHVGVaagM5pYgKqkf9dY0KmzsK06eso3KCzqOe/w/o2WBhnxD1zVyANFYD/P2dukOuSUzdjfTBpkmRA3cT9Nw3oVO4Jr620oeaVD7tYM4C0zQ01wK6+AkVbFNYaiSrGtNEyMM86H872TgOKBxE4/jUr4ypFdLtqZ/L5dsJNK/Y1oizYNimnLsOXIUyzpYPjQHh11exNcUnDnr5Jdmc9BJnN9PyKLZS1XZwJLI+I8vlNXWH/nKDD5wsMCOpNqxf+2lF+giLkqFrJF1zzhowfNK0yXeRFYeK3p0EHwyoat1tnTavk/zVDHKZpQX2VB4ZJx5AH/XUfwh4sLpfoQzVcHPeePGmoeHdeE+Uij2wDcMqSEYRb3mIwKUZt9zHrKJdC865rwuvk6zS126M0P42YWzjujsCvFu7vAxCBlhV5Oa0MtWKffc0jsoSxy1lCyI1DS25X7Sg4qc0JUddw24RdlN+l78rD1dMPJHR3jMcSkmOPhMx6nGFXn8M0IVPqiO/TWedKMUV15GGw0GJnxq9Hcf/PgFyh0ItMEHmfowYxgCGGUJN8hEnYJzAKG3jajijODlM5MiC2N795gGgwnBsK41RHy3AozE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6666004)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TmbVHWozuvIVquGc9RBO3kxcak08RyxpKTN2skNqmMfBczEIhwkS8YCLna5E?=
 =?us-ascii?Q?tHhH9LQk6sX2UpIDVsu94PMq9VQZXu9b/rDfagDJgh0qYUkzaH74xDkumw+f?=
 =?us-ascii?Q?vQEQrEq3BRHcK9U9gGgCpaFUwPV1JGI/ukzdPAM2QC5GBCDoVZJ/02rcVCV7?=
 =?us-ascii?Q?VTUYtuIqfON9tLa8xZltkyRt1Ssy+J5OyhfeAp66Tu2lpgM6EVxRXjb1/Ll+?=
 =?us-ascii?Q?ZrpjsKicLJX5J1NU3BgcFFC5D4mr0ESN33OCNFzvegf2Nd9Ze8KhkpJ/aS3p?=
 =?us-ascii?Q?EgKR6KyDUaqCZKEetUvTgxBSvY+q1MrItFtl3z57C4Xzlt6op4HW0gnCzFrz?=
 =?us-ascii?Q?PiYCYwXDJcMfyQABGcVqCPpDK7ZytYr2K6efWlxbRROCuwDRv+k3iuKyBMe9?=
 =?us-ascii?Q?AlseH1Fpb9cQVHEkip5TGe1ezQg5cC8iz2kP36auG/vCHrzLEj+iyka62aVg?=
 =?us-ascii?Q?R4sLE3cGrn24pP5hLnsd7NCZdsxxXGLau54FcPDVk/aA3BSx5u2EJPXmWeY+?=
 =?us-ascii?Q?EAWzhhERUnZIMsuUcIx3IUBa1BD05u1YDsBnAl6pNzcS/hur8V9QHvvsAJDK?=
 =?us-ascii?Q?KrKzsvnJ2KBRznEML2Q+LggvtBhOQomIFfdwnv8O+nvie4mAJMCfq7EpfRxF?=
 =?us-ascii?Q?pCNaQ7VwZWv8Keebrr0uEK8d9rMaEUKfg8j6cbEpYPKeDDCVhI+AYD/Vx+2N?=
 =?us-ascii?Q?GNeen04/muUSZYq1fDhoW/0e6gStDDQXu5C1OVzHMyvbUDBauqPgwZQqS8m/?=
 =?us-ascii?Q?SzVe6qdeB6e4zlDFbWOCpWbCIhoQk7VG1jy2dlVRrP6wWx1+rKCmgzqLKkbm?=
 =?us-ascii?Q?Zdy2dTVsCmhpmMbo8funDkdRWFeQs8YlCstohIg9nmmm0X32qHjJ1ydE20fd?=
 =?us-ascii?Q?2HsQlw3p46Qta4k+iFXweyxhqh/SobK8fWFLxXwnSgYJ0FChHGEPk11CT7Pz?=
 =?us-ascii?Q?UgTdEUVElay4lmCu6iXfyqmLctjjYqgYsdoAwm+oX8Gm0zcM7fXz8wajAEML?=
 =?us-ascii?Q?W49a4xROlk7lZ3/yagnXs9eZi5BV4zB45A0zr0go9S1O5uZW68w3gZexghc7?=
 =?us-ascii?Q?56DW7ZHL+E8vsyRE3PSfHt5CGGuyK/Fsakl0QSiFtPCqiEPSTNLjEnkh9sgs?=
 =?us-ascii?Q?UDGU2tZwmWmmhcy+6gs8D1RrbDyFrORJ1YsWbHHuXOpB6oB2hCI0bcYheR+c?=
 =?us-ascii?Q?xRt8pTmHvIZHsqxQweCHMPLsBI9G77Jw62fvPaT8OCoE+viSD4VkIVadxmES?=
 =?us-ascii?Q?FeqzdquVwiVp3Jpx+DeRFKmqUg+WKOYY5FC2VKG1RTZ6vlzpw8h9q66EiJpA?=
 =?us-ascii?Q?gaTpo/piarUXgRMs0kafiVLBVb9eBEC6FAPrucFHbEC2teElaOfW9/dZcBVy?=
 =?us-ascii?Q?x2dcZOXgrXm8iNTsjFv/BDqC4suLlwcmaPKA0/wNXWYXxrcIYzzRiGl6TyUr?=
 =?us-ascii?Q?vM593/g588b1pF9gN6PCgv50vRKWR4SDRCxG9Dq2bmAFM3BtzwUUm1MxLll9?=
 =?us-ascii?Q?84KfuPrVc04na2Tdh1eks8UpqRFpbkYLZf5AvB3xQKM5SUdrfrhb0XOH7rYF?=
 =?us-ascii?Q?xAZG6/HPg93seTfbdlr8QcpioVMxF1wi+ILMvvN3pndDUmVr0CfW+mEx08cX?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8239fb-2aa9-4df7-35e6-08dbe02722cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:29.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo8ed32PWRNdXmfo8v8QdJu8N51CKTGST5CtJuUB2fCz4Ej/N2cqewfx+ug7tOcfOD62/yqxAKTgzHMC0kDk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

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

