Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AF1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/bFTaNw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/aX2uukHzvm7ABxAK6E93SJj7jnZkaAfQyWiU/WgUVgWaHp5o1RqQbTnb4Ea4cNgJxCJ7wdLE8MIooiT9Jfw9Bbe7aaukx98mQiwQa8g9zVb0bc92657Y/uxbuU1MEAFrwAJzQsHvTBGoOIlPLNQCZGjph+yVARR2kMdg+T82c47blInaDE15/3julx4irbQX9tulfkAWMK6w886bOi1+w9dTvrYVgK/63Gk70j4hX12lv9EUqVVcxYrrMR4o5HYJiYBy16Mdq+VTXAoWh0PNd/OZOiK0usiwbhT2ylGDUWttzzGbsdnAfStHtqnoB63HyGb4q7JgObLe2MrwSCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwNDfN17K0LFAMDx3qp7Q1h4GjSywajxnLKO7TC/I1k=;
 b=XAyVhXNe89hJCMMtOuegWM0aCZ8T8qfKCqOpcecGRnW3tU4YQPyi59u5XcORvILMaQVpCg2VCPq3OFFrBFRVK3tvsjcDd18KMjxQfqPZHrmuoEj0Dw6DYTeQqx+SyaOqvEy81NFB64/JBQ+lxeobhL1lmnJkirDsHJkkambcgIy7N433yRAm2GOVG+wnlZ9qRs/PwCgS9I0AjyhLqBuynf6YTnT2BTMql2KRo/fEcSAAAHT84xYkJToZoLgBkIWJ1Ke4dJaDCCJPrkhBdJAaVXLaHWz52Y7G0TlMas4PIlTl9tU1wq3OkpGEaLi16MzLF+iGUoZ/thihoj7z709M5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwNDfN17K0LFAMDx3qp7Q1h4GjSywajxnLKO7TC/I1k=;
 b=Y/bFTaNwc6M7UarLy15iAQlngrq2j4c2jNmE0msI8iLXroF4lu8wbgDfJ8iSidGP5ZL6NYU2RW/UJI44Itzh/xsdf6k5rs1xD9CDADHmX3uAAybo+qg7+Dc7155Zg11rTusyxqU8pq8ByO/kC5BCy/sRS4aDH6bupYqF2QkhkPJhieX6Dv/nMf9qYcOywaMURQkotMyZbU005w3ErsXkjwv+5hSslKkPyoN7VriFpbOZjzEpm42f17Bu5xauIokUNRAhG+m3C1IhzzCOvAzotWYAcNG22T+sy7+EZmKDe2tfODr8AzW2Y/c4WtVvK5UDZ6NGmoaHKBuWbOwDo/V2TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:03:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 15/21] mptcp: add userspace_pm_get_entry helper
Date: Tue,  7 Nov 2023 14:01:59 +0800
Message-Id: <828a19f642f28edba0a20922bb7211d9748d69d5.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:404:15::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5260b4a4-5cba-4e2b-d9b1-08dbdf574c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vKd0nc8CLUMVUshqx2OuJc+87i+EmvcMfV0muW4OBtUE3tDwNEXm+lduSbeN5D62hsMlK/i+/uvPELlrLB/iaXA++CUsAUaMIBfgC1+lL9TBDoWUzQLmtOCVo7KZb9Gj7rrMfW7gT545OpZ9OwbvZsf60QSFvSVf3gX+P1hb0WN2Aki7Q/qJKhGc8GWS8uHdw7UwzNGvK3uZisZziRi1YNJeKty6J36U6+eKTGgTLTfMiegK1OAcVL9Ifs8kKLSZT9BwopC0HIFrubpcIBJ7ZzgoGpJEHwFr1lOiH+XKy1Ef+nnvYmDpdu/LyaGutxg98bwSO5FkmhEkmCxGbs6TnNNwW1SnC1/870SETDPlFxVYav8U1PagjmlWk4wIYGzFTw6nvfSdUvaEXChdTao+MYkpud5U5GMqoApDDuTsGmd9k9qtLc7NMrdUtz7g/orQv+2TayQXZvi/3JlV9GS1z4fej3ZuRXkPXsMvPmtC3qFUHHdDa2W2JaaXgaDzBhkgaew43mr0ORMy8wACmqgp7JLF5ZMvaGv6xLpmDvX3JbuxvDETdK/1wMLEM62adkH0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjht7aOzHXd7Di/0u3SgIx+eEmJJ7znyrQ1FkBlKuQ6wb7vCxK+BS4WWfzV0?=
 =?us-ascii?Q?gU7/wqf92OOzxXTssM85LTiovpizkfjNGRJCMX5zLOrbrA86RfTCMVzVLVN0?=
 =?us-ascii?Q?K4OBJsTyZwCpvarX/ipiBDps/vMY6AIYmgVWn0sW0uHhg14HPZE4mRWtysfC?=
 =?us-ascii?Q?vJEFdj3N3CI3nfsgLbkKsm0W7W1TCMaa9qtLN7RafIaL4IFiV9J2ur6Idi/1?=
 =?us-ascii?Q?aZxOStaUO/aRMVQUETRnwOpWER6ZvqSdPIBjc/wyhS5M83N8aQEInZDVFvW6?=
 =?us-ascii?Q?P4Xad0XNe7IiCW24uj/QG81UdmVsafxe6a7EDBP6IW54vbw2saPjZ7zkCH3u?=
 =?us-ascii?Q?WOidO+vWYi8nn5U1Jstw8QNKjBAG+epUyFT5ILYcpa7+ntZsG4Iu4GWjKSsn?=
 =?us-ascii?Q?cvZCTYN+6N4jlRvj2RnSnBEOS79GVroQ2rHHOU4zm0GzWFNW2TIFZNCYfORw?=
 =?us-ascii?Q?CfrPoVE6UFmFZE2p2I0kFjua906UzGlh5tCUQ09Ni4CEBvzTiFYZsJySCI7O?=
 =?us-ascii?Q?PE4Cgqcim6BOVxIYqNfdXv0R80XSBhQCTSEZgLKY/2jDJcYe9s3zkzzQHl21?=
 =?us-ascii?Q?WUxpPTGwVMYUVNz1UCoU4tKqnGnWlj70Qfxy1Fzk8znwQr2jGZF/G+4Mvqzn?=
 =?us-ascii?Q?yUSaYOPEI+/Fh0Qn6Y+BRRjBWkvWoD8D2SMJQ3JdYOWJ3qBLUrA3JgEo3wka?=
 =?us-ascii?Q?iPMw7Vd0U5HcwyDFSeCl06UVzq8PRzj4IWqYAKqO4bFpb3JE2xwo8SXKKwmo?=
 =?us-ascii?Q?6KG+aSDbQYkVitHBAceZ7GiBQ4KZCugATPo67003h6LDmF1R+3LpQVX+RuKq?=
 =?us-ascii?Q?D5UArx9bg6dGyUXnk4iq/ujcxrCIETaD6M0lvfztPdfaPg0LaMdIM4RaBMNM?=
 =?us-ascii?Q?xHZMNZ9tQ3CRhJmtdljcy3AbZNxaxWOwkTekN+n/+fmn9U1xYDsHjGeeL7mM?=
 =?us-ascii?Q?wNmL43YSq0SDxdTtMPaVNovG8Qltqjcbv13XH9DFXHn87XtyLTwqzXHY0Zj/?=
 =?us-ascii?Q?C89SdKvPFISKKlPWcSPT9Ccbx/drVMjPeK/BfhIa73UEpajPQsxZioyynf3O?=
 =?us-ascii?Q?lcpT0bHJbfADZUuy6NV8lPfpPY3tgRETVi7Yt4pS0E6dWvcj821zl1mnW93N?=
 =?us-ascii?Q?YkIRjYDTAvDjq/P14NEDqGoTo2GsV3hfmB8ANiulNhjjl6VgznEYbbrB5BRZ?=
 =?us-ascii?Q?iXQ+Y+8Cg58SZW/JssIOL6m5wks1O5Q23neLCwMn+6QKPfvzPpGQb57MOe24?=
 =?us-ascii?Q?rCtlaqt8bCb6rT873gAbfk/huIbnMNpQ+JOm3YqgxjuABx5FL16WsmlU/iTO?=
 =?us-ascii?Q?amrL2TqgitRjYQzgdjE4dWUnunkWJhUJ060+j9KlBtjahtukL3BXGdCsyqkS?=
 =?us-ascii?Q?03l4t2CKUBpLwbG0bsoEQjo73CiNZOfzBav34YOgCy6ZQ2MNhOWpdXqjh/Cr?=
 =?us-ascii?Q?nR9EhVCMQ8f53hEJ0RM84rcBRqExYO/jmVuWnjVuEI8al2XKJbRQwknIa9fc?=
 =?us-ascii?Q?JAiFWzhnuFKt+HHpbHz0Yy9gvosTytk4SNhvU1lpIFOI0Ja5jn44wN4CEEo/?=
 =?us-ascii?Q?I7Bvl599HpmOgEL+zADREQ+iZ+u9l9vWXx1rqffJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5260b4a4-5cba-4e2b-d9b1-08dbdf574c40
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:43.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LImTlC+zH9utlg5/Z3tUVsxDVMOdayB69qCiZ7LUCUMrvZ51LYAnlWvG60icGF+8X01tyU+qUJT4jOyc5/2C9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 08620b3ca8e6..465f2c208ac1 100644
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

