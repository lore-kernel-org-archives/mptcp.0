Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640381FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="0iyWukvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/EGcwFPQnh9trhmPDmfxACCBHaiFpPn3zSTrHQ4PsS2W7vjNvwXRgEmrBko8gF7c+bOgrQlTe64/NOErHFA/90CgziDE2GC7emUWJYXv7dND5grdMaFmn8zQfWpN9viC+Ly8Sg5MR/SFdbbvK01oHqiHGnMMDsLXFPKFqKsaHwTYxS56PdiWyNDnE0UF1DWUucnChJOi2XcQxPb9DZAFk4iCIvsLEhdhw+RIbPX7rnM1HpwZezQUpi7W+TwqX20EC5WNY3xN9ETwKYLTtGPbJl0FKcyUZUp8TmLpQrZbYZuT4lBRVaPGXb4i9uTxE6c7lEa9DreiJ9fUwGAbEcKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=QDhXSDnRiMVmZ7T7Tn6nY0BZ5mDzqVqPMCkEX1fz6U2YZhNnRmblgD+MGiEPmjX/4uhvjz8OFChUZuORQ5ivne0abyJBP6Y8YVDAdf5oSphZtuHkTDmVUSnfQVBYCt316bWKzofMnWuYFfM7KfcPnJdZW2UNN5VLa2BBHOdO2deGwG/Mzw0fBZihUdc8lkqocds6VDpVfLfKUbRCeveKNjCJI2Jaoo4l6E5iEJrPSWXK0BtCrDuSLrhdJW/5lFF3czoY3NobF4SbPtrUXxcL0cLBjyZQRZ0l6yxfQekhRKwOhJQmMcf3yFXq78/aF2aGadNyDTr2h236UAkeK/JEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=0iyWukvwgd9cfeiH7LUmTW/fns+Kp6ohHA2GW1PSx4kSVogkAtrhuCismqNvTyE3RWLz4bU5KMNRPvAGpS9qrctkEMRZ8xctH/I3pbx6HAuMSMeTTv178RTHdVpJeVBmrdqJr1Yk51Gt6QpCXxN1xPa/XgAhvzYTkmZdnYTRGl495QuZxNWeJZ952QKnGabNJskWy2Akli2AtwkJrHwLh2n9rMneFBT0x0YKwOVl7JhPxZbV/OmA19ap4uRkP546eyXplMuJp75c0n6FS/IuYUbS50EzZGg8mfijf0Us02zkSxPrftjWz4nsnmnTMaMS3O1tW6co3LhR6TVaAluP0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 03/21] mptcp: use pernet id_bitmap in userspace pm
Date: Tue,  7 Nov 2023 14:01:47 +0800
Message-Id: <b483658ccd4cf28a38407a156973ae306681710b.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0151.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7886e2-e459-4fbd-b866-08dbdf571e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UCQ/Wg+SBwmr6FnxDsVVGDb0LFCxBZbgvFvJeAmBJInOqGjjksKaPnnHevp1Cuz5DTwNSagNVWGs47m8OS0UkYk5CwIHf+ItRKczHtJbAovdD9HyWAFdTUuiq1QQAA1ggr4ueQHX212hckdbDp9UMG5So2KxjXI92MGDiTLBDD/9RZmmcQixnZ3fwty3pOS21KY1qryoQdFNZc4SUK97KzRhKRcqQST8GDG2y83+Rpk3EhmNMUo7tNecwYJc4vIUN2razUpBDwf4bCxzsKvGG86/NRx+rOPZ/JE21aORnrSKuOhBAXPLdgXv9GelOjKqAKcKbWZd+aUmQNWZ09TC0t295pCkH9i6A4r+W0pq+usNn/b2/96vpPwFt5ITJqrn+myvLvtxhzgOyERUbpC82udWY0+a6KVnY3LNfEQ2fO+Z1Ffqju8+IJTGkAs/ZO++2ggVqurHhygzr3S/h1ATd0/A1vF2awljr1ZNyELaG6lTY6HJyCi9iKZu4mHm9Xz/rP7WWpH9TXTVB59Od26FnhPiBD9N4saq49yfQffQFuLORTyBIHnWN03RIP3KcVLd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zT1Os6UQNEkhFcztnaPvEN4QHDk+i/1irzswYdavxUxNhFgy17kWXRjTj5h8?=
 =?us-ascii?Q?GqDSoQrZxFw0K9QWKKNZUSiDI7a06pyOuaxYndoAeap8xtOE3osYNLy7jPDG?=
 =?us-ascii?Q?j8DVbqeQof/bTra7czgsddqtcbyEs8aGtIghA39/I/GVVJdsnZHUOn+m4/uT?=
 =?us-ascii?Q?/v1MsRBa81XGbwfVHB4PzSNrWDXmvdmXrWrwqlvfeWSujJGm2UPfTz8dx32U?=
 =?us-ascii?Q?Gs+pafbTzGzgItccD2fORqZ/g2VSx7ZDrCNVdmRXGRupM+I+LLP6y+WmfdWy?=
 =?us-ascii?Q?XhfWHSszD0h0eULV1TKPueEd56Vock78FLHXigLiNv1OUoGIiKh4kqSvG+yy?=
 =?us-ascii?Q?hQKWx25tIg/ZyOY7Cr3GGrLQqRUJZ5DNCNmZoLbDo+nqKEkIuaKVNCP87ZoR?=
 =?us-ascii?Q?00Tky8Lhj6jiVdwknTbcMe/t6Glvfz0eXUoreUYNlrGP2PvenbqTgRVbtqT5?=
 =?us-ascii?Q?cfA1pUxa0upsW3oDejwe20KsiLHY/epUn6paIqnzEBLsfiq0BM7axi0bfFFS?=
 =?us-ascii?Q?xZYwgbugEyibBCw70DheGs1jRHYAB7fGdlm+fioG5jaFk083T0Kc5hw9rFCa?=
 =?us-ascii?Q?UeuCmt64sXmFM8Ca5eItro8H4o/fkSD1TqOx/bTOAI70SEyUhu9I1x4WotYJ?=
 =?us-ascii?Q?A3VUtNsEJWhAdItJTlDoyB6ehAWkkmewrBHolfKs4+CWVqApyz9R37JJ9yT5?=
 =?us-ascii?Q?tXp51DnGygfGOv4NWBtM+i5QCvPOTg/fJXrlivbIA7+e036yneJkzrDDOnO8?=
 =?us-ascii?Q?h4HZt+hMDta1/zryFkwiS2/lSlLKi31bb1Zvgq8yxpk8YcgWf8B7N8/Krinu?=
 =?us-ascii?Q?jXX4j1Ei9hWcN868gTuazEbW70izSpdRjEiOjccp2PN6MZPBnjWaZfKmZ0At?=
 =?us-ascii?Q?Mm2CwqS1xTRCsflKr90abYrPbOOlwmKe5G+mk9dNRXTBlYg6/nNRziWjKtaZ?=
 =?us-ascii?Q?p5BGJaq2jcxqetLRne8AkBxlhkWr0BVHxyPvYKICag88+jLY6383SP4QYCJ6?=
 =?us-ascii?Q?z6gMBAQEpZRmMkvxNKYofbCD1yMBv+cRDgCDHsGFXzFOT2HbKJfE5chSEe+/?=
 =?us-ascii?Q?fPofB6zx6upanU8sYRRIzQ/HB4KWpbTrezqFofUEKbleI0xMq351VPTMVMbb?=
 =?us-ascii?Q?hJxbXtxlGBCZy6qGhbP8KKpJ5c/ZiFaUchZqB+wsTFhPegy0O2OSxTkWshuA?=
 =?us-ascii?Q?8DVhACPqZO5CR0lscP4vu47yMCBqi6u/JgI8Ih5bu1OKStCD1fu90tanZ2Xd?=
 =?us-ascii?Q?m1CJwrwe3ELRGvHQi3BsI8IH7kZ6QrwCdaD8yeYsH+0S+63i6kM3I/qJNvYv?=
 =?us-ascii?Q?Tr/WzmbNYx3QrbsTekTyxxUMqfcdFIiNwRoJYlZYk7YA32vwRKngLjGhvzd5?=
 =?us-ascii?Q?UjD1KYuHbXoemZQKl3ukGUtdpNY57d/9YQea4KWXB22pf+rortgT2olMKT1r?=
 =?us-ascii?Q?4taykiKuMMW3I4JFXuoDRGRnYqKCJHtyhpgSYIILAtvZXvaLVv4quoys/59S?=
 =?us-ascii?Q?Rnq8s1A9R5IQpQgJz1wGRQ00TmxqYtWabzHnh66aBPDXO1eqs+dMiMuuv9b4?=
 =?us-ascii?Q?7++OQSmtseYR33QtgPRSMyCx/9lSjZxmyjhrID3J?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7886e2-e459-4fbd-b866-08dbdf571e1d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:26.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZOKgf525Z/4VQf1xKr448YGYBAA/h8xerO6IH4ZkI8O6+tiNcPK/wE6TQFzJovskE2nQtXDBVz8Mf4GkDmXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

