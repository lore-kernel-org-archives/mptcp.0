Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AB11C8B
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="y/akxmhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiHdtP8qKMQC8Bmsup6jc9bC4uKNazLBWBGJJ1F6iuv86ji5t5+7y2FI57XII9X72BEcyVAHFbrsEkXueFYtK1g3UQuuMcfnARFWHo8SErifx0eStE0F5RpVB82KBX3Kghnm5UjXY4QI+nJ6alcFaAalFw2FCu4gaSQk5QBacVjaCLnLVF2ZA128pxjHjBwlCLP/zqrjtrW6UC3WyiHZqhXZX8Yijia7y3FuTTJ62roxGCHwpLJrrpvRAVyAVlA3aNh0DZzeD/1wQMomwaNHcyOEt9CamppfNwzs2Rur8zGfhI0MpGJRqUBd4mqZnApokTzO1uy62h2Mqdk2YnwVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=cg7ife72+Z1/EhOa/xS7GmerF0lQ/cz2J+uXLsbDNIuskqTwGmWjdHMqk4BLpQV9qqfMEzzwtfaAEimvLrS6GSXi9xWhpDYpIKMHsc+cOPqNXZ5GKyyU9jDMU149iPfDlULoq7OiBWZyXXWQeeM0lktqGKPANI0FlzNNggyFVOYMFCU4kS2V6adThNpljfJr+/P9Hrf1igqnTu8bWXmonggW+RBp5kq8lkTBkq74iFAb9iB3gx/Tu8kjBX0HTwoBkphV6O1Zx5M7SfWqthlBI1dVBR4SG6UVhYW1KGHuDyZ0jFGQixLsihcPrB0Y4sZGYG0VjlOjaxu4zsUNRskcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=y/akxmhmcRpnW7dULNKKKJzjnXFvcT/N4TWqh03SjsNN0qQCgIjduTs9YXT7kBOP2ct0KrxTGtwIRuwsjsVuZSyaqfkQPm96JecTFZUCDjaEtIR9yWLL5sC0IV3UhdklIM0lUOm62UyutH7JvMIw77WIq+vD2U9Plmx0dixcyuT1J8keUCIv1sdrqOS89auvYiSreqTkIauiP3f2OeFPNyEyi+v4Mqj3zibgUchPIci3+2ShspEnDg0dJcP2EKA+kIuQgh+3/EaYmM6G665omfSPBPl+Plb3ffbNHp/YujsBddzm6kkPJxDfUVBDPaZFnW7yxVvDQGQRUb3jqc1Amw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 04/27] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Sat, 18 Nov 2023 22:28:19 +0800
Message-Id: <9b4015ca0b36a946e3e65fee7cd63ffa1bcbcb46.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cd2ac9-65ce-43f8-2cbb-08dbe842bd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slDmcdfqh4nOLbI7KErIdlufecnqsU+DSQrwAbGuDZJGhH6exT6xyWVhvEOXLn/dC2064ptDa/MIN8uzSWunJtTtwKHklyCByu00uZCyGdiYB1cOgheirTP8PaEXB3snIzuwF89cKdQz68BrcKOXS/G08T3gmQ5uFeQGQKHEUX0sOhJeLRxi6qYcnyUAEuA6qabYtN7iGott9cLs9mtJaOb1Fgeg7mXdfT7UfglrgX68LlHm9ki+H2kHEgs6XGucDb9xxk2OZFy5xYFP9WqCn06di72IiYm18r8w0hawkRh0fZ1WCZDyQcGGKBFb+lAyDrXT0TwvpbhORPrJhcsSJiHFBwEGTkr4PA6QYjM6uWwCH6s4A+WPVrABr8BI+YEt+zWZNpsYOsGjHMYiEfzGag4qU5Dp4gDEc91VYIzKMZlhPjUd1zXEhI2wxEqbsKMcWO90918wi2NX8AVpvrNU4lgpQ195MxkgOOquH459jclWiujy7A3e7+8T2wHXSYwtgjNcfCil+djYQprwZTD9h2yaZuJOSDx1HW/fzLAdiS8kaVzCBGGrtu9Re3qKmJytr3DRWqyM/95LogPS4QuWZOFCg5rQyghlPxeHqPUHyRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfRe+U68e+UHRbEvllhC2YbdrAFYeZqDvDG/WuVUuh7xREwNm0joKF8LelqI?=
 =?us-ascii?Q?7pbEuIUK0wlqNPAYOHtwn3n0aunFXB2smhZ5fwhIOEIW4gl/Dnaa8RhibNBt?=
 =?us-ascii?Q?xSJqLiEY2BxfoJjCnaeAQwc/LssvwHmYbra8o5NguVZg7FOgylfFNwJAnmC7?=
 =?us-ascii?Q?DkFQXUDzI3HGbJx/pIprr1L5Qa3V8spIxxyc8qqs9aAXJ56wZAXI97iEqePX?=
 =?us-ascii?Q?HBK1GL+rVO29sy75oI4yYcSvPCXesF2hfJ0QuMAoyQy7T/0zjbZwB9Ev0uN6?=
 =?us-ascii?Q?vD3orjJBODuPtTjysbUUvvaRb5gcB4MUlkvmIVbsfjZfsI/UUxZxnvNKVojR?=
 =?us-ascii?Q?tjSPy4S9B1kkWweJq9Ig5cdJK7iTW5LboM0f9Lp0iHKqD1ooL9Tw/aaoi//X?=
 =?us-ascii?Q?+L0manp+vKDlWLDEW8AUjWFZCtvGxl4AlXaiTKt8TmCKqhM/RY1ploNTyNH7?=
 =?us-ascii?Q?OPlOXkicTDzWwMVe5HarDFCaV8CeC1KCbVHAdXy8R7HCp+QrtDVka5Y64Osb?=
 =?us-ascii?Q?yVY/fb79nMwrCseQWhYil1mQQdd7VQ89pTnbroL6gv/Jys2zczk4KB9Nya9X?=
 =?us-ascii?Q?oGvu31ezGhgzhbDTxvAIbHHH2YjCacy2UuGnoj2YM+17KfH5Ox8YZxecxX2w?=
 =?us-ascii?Q?DYYNZUr7jvbn0oig0/Qj3LUCZa+u6yv2FKEJ0xnHk3D9329QitSkf3xBhs1X?=
 =?us-ascii?Q?q9Z0FwmmIani3NNUqeWp6JUitSY7vOFaNlsvq0TQNn+rVYghDdeERp88WFgF?=
 =?us-ascii?Q?AU80tZBDCq9+OorYwfea3zFMsnhax+S+wGhmRU98xCFq2NLaDxY2xpu7VY/1?=
 =?us-ascii?Q?qX+LqZQc/9t+nuz57BlX5o1GgFlmJsUAYeMv+d+zDxTKlvMRyPKvveeQwwJm?=
 =?us-ascii?Q?V1fcMAnpRT77cljE1spTL1cy0cWS7hr0BGqOCZM+YECsJydW5KrHqva0pcag?=
 =?us-ascii?Q?OZFOGI7h8jxqosqTL0PXMo1x7H+gcrbQug8LCCweJvwAlZ1AKvvNyJ7/2okC?=
 =?us-ascii?Q?O0zoUyyDK2fsMowOkG2GoeBg1T9EP+3gmyS1eDpwgJSfSMrGIm89EfnGwD2A?=
 =?us-ascii?Q?DOo93DRsmcbX7O9qHJLtqEzNaY8DTH0Zr6+ZI14Tyrj2W6aKH9Za9rZIr931?=
 =?us-ascii?Q?LAYFZaV5IBBWr7+NI3wKyxKaSc91B9iX7SgqIRvH2mEwynAhFZU3kXFO61D0?=
 =?us-ascii?Q?+Yf3Anrol+JZ0hOgkWtEEmdUAip1wYkWmpxWH6n1na8MWP2f7TkWxpJuX8fb?=
 =?us-ascii?Q?sqJ+oedGMmAXFv7JzXmWAMRCxQ69vdxhUaaY1AKjHWFJ0+xgBwogTDs0NEHN?=
 =?us-ascii?Q?xT07JLuQSBCW2qHjIDeuYBjmEmNh8Mocnb7DWLEwjRLRVOU+cGERSZsTC3ML?=
 =?us-ascii?Q?sOhkMSy68FJrAI0JNwmNDT/pyUuQXlJemqllTkpI6/Eawd3ZzurpvAwtYFSF?=
 =?us-ascii?Q?sgBTNfzm9bjajNr0TnAQ80src07pYAGPvEc+Yx/o2Z7j6QR2BrREopPpnajN?=
 =?us-ascii?Q?3nd0GTCjghngn0F86eHsAVC+dac9a0nF2EzlaLJX852bbsh4rZtEjlInszRk?=
 =?us-ascii?Q?xPod2MWE2FuHsP7/qzc9R6ZbGsfRXRzTjwcLcjtE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cd2ac9-65ce-43f8-2cbb-08dbe842bd14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:14.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0wtbaCdIMmWqS7pHLz1umGlFhLcTnf1HIGN/5tDbTTxLf76w9pR38yn57EQP7stny7LCHC3z99r9gQny7VKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
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
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

