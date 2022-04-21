Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7297A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS4O9/CnWhvENeJvg4MTsk7WOgSZ2uhtsdkdqOVBD48=;
	b=Ks5zgAu4Wm7Sw2vreOxHdAuZ5VeGvD4JG+kiVA3hY9lcHfrxOOyBGU5hU3QaztGHFCr9xH
	6cnZzFlxktvpZtGvFyEDLgXHjbllqZZLOfKd1Jaybzg+tsqudCk43RJs0ujJy9knN164At
	NDUrZ1frjTJEPyLjoYSkVaRnClRGEvI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-KqKxlvp1OJ6P7ovsCk2wNA-1; Thu, 21 Apr 2022 08:22:32 +0200
X-MC-Unique: KqKxlvp1OJ6P7ovsCk2wNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ded3S6PdQYVSyPgemBLUKXqGN0K8JBpyu5BvnWIptpPVjrurRm6gu21QrT8zUQL7KoRKQvVlx96D4k4oLywAZ+b2ZXngWK+bDt5vtGVxmAomC84Zb7ARmF1qwDj+hoQRTuksRLnOxj7EceXz3ejhDvsNtka2tn0zugXQjNzQjRCmJnL4uTNiiTpb2dhvpw75CxUtH3LYEw7Ov5PG5KihuzJNAkErWYKDwMYmMjBuqFYlzlWxjfiRMZtc0UMICQhjNDYHaHomVxrl9d+jyiWZbXe/2njmpwgqYi8rvFjEL7H9AxT9F9nu1KaW3UCLQl5uruT6vy4bVv1ipPckD+3RkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/rrFu3EaRSAjgb5bm9GV73d6eJZsLR6+Mu9rnbJc/c=;
 b=G4v27sQ/fyLwDty6wYPrWzMUzQ3vpIAd+j8fxkcPd4mBH2sIjwamNyDqZZPSTYBVQTttzMTaNFL+NtrykLUApcH/6/kNOkNjWj+gurod+0u6enUCzHXmf4LRwQOo8874b/ibrHhkZCqGbqTRuT36/uXyRtxxERZXdYHxq7slJLDVXTEJHgaJferjKLH3cQijvVz5VuPFgfT8XGMgCln/p6WVqNJGgTVhxv6HIt6A08x8RYrKCl5vMnlimRbkDz7DTpqtjdNiGhqMtU8yFCCckzqQGGqqo3QLAE0vjDhm2UnJMiIu+MJw2vIAzfkR77s2mlVkAchxAz1z9TkD1ihFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:22:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/9] mptcp: register default scheduler
Date: Thu, 21 Apr 2022 14:22:20 +0800
Message-ID: <7a74001f492426cb8373d77f8c5b76fe8efbba22.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a84e7f-d7f5-47dc-2790-08da235f50af
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB810050DAD8F7008678CEE327F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1aEI8NrF2pMw8tE+tzMYjrmL173iKjl67GnKW+vVpNw+rO1/DuxPb9EDLHNJp2/Kmxg814h1ETRemqwOn6uU/jhFNfm13qTfdUScPRrsP/tYEdb5RJMXHrfidn/x5Cj4qYgICmue4yN7dsSmqFMtGHDuGtQgdJrox7hsXufPGj3PCk7tGDoXcTOjIbESWIb82IZsYaiqAy1toVZ0U+Sb1itVrexz/NjIFjX7ix1NR/V2HYag1hp7Qya3nsT0YaH4W7FVC2N7OG+vtqZ3zAsBch2jxFnnX5tlmx91vUVnuLDrqhKzwukSIp70nkFt2q/gKfURWDoPlh7SkhWxhLuQHm6rKwpN1A5GIIvv0SaIaWL1+sFfXGtS5pxmh1Ti2bd9Xrye9Lpm6TBRZmBG2yV3F/YvO+T5sxmxm1GUkHt4esY6jxmgspf/LC0dp+xlZ+b3JqPdKqV1BjUHzzquoGD4cxEc5T9R3aQC+sOEOnMpVee46RDKV+j8eiEh9m5s7cFW1+QbSBsM6OxMPbPdsya2WK19FkGdXijtL1dr3PoSetwrbfbRgt8/PJdbXLjdu1O3Q3UWbk6oC6beRsvkhTGtPVFh2jzIqA2XCF+XAmQ7xgjhwnVbQ9raEoY/Jdjz84qYI5jo/+vjgqylM0ATkHP+LWoEYWJka7yQJtCGHl5XcmbAUsB28m8RLNJf0QyHf4Zq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncgmWsthBLqgnS9OvKXHzMxifgiqpImyh3ncIDF9B5jpDwRnguv7age0PtXT?=
 =?us-ascii?Q?uhyv7kWBGAGl6yMpVgcTp3pHSM2O8xwEmWMBMJHiS0YNUJYQ/Gke8XTJS9pT?=
 =?us-ascii?Q?tgJR6KA0OuaU2Jky33vS/JeffuMd1z0TM0i9OUXdS8JOgVAhdbUKjYK5oZHF?=
 =?us-ascii?Q?MFs9t03HOLerFl9nuxLrWCwVfU3hyAheXGEPbURxQFSFSWNM/+nmk4dSHD30?=
 =?us-ascii?Q?vCV4iUuclNMRfO/Kpz8izcbCwIFfhqFwKp9aPzj8W7FrD43vPc1UCHbbX/lh?=
 =?us-ascii?Q?9MYSZ6thsrOAtmEZl3rtWc2z+XR5SXRaGDwDQHCx80DPEqq6mvmAEuzVKh3J?=
 =?us-ascii?Q?Zbl3X5JEsQZgjuDzOs3wduSHf3fEZc+09VDxdQVeFev9TiDKSs9Z4ceYqLFF?=
 =?us-ascii?Q?qUzmTB0TJeZK2uNWXJlmlh882Q1naF7ZW7zGm6xQ3LA+P2fDxvBrN6h2tRtB?=
 =?us-ascii?Q?9KqvTnaALvAWv+ZbSteTD+yepxYdbrdOZgiYPbsZD6+ih12AFFQ2qYgInpTG?=
 =?us-ascii?Q?K5aOCBJejyYnLGZ0/8YTK4GNuGGAFfKucWO7ElP7DKh3JLZWPjor7ipt27om?=
 =?us-ascii?Q?0Sq1TPvBMJCM8CqWAJr4Ji5VhHAl/alkFEj8ZmsDprQUNnEYq1oO7FTHDa25?=
 =?us-ascii?Q?ygxRw2k52PZhDsiAUSg/vOns2EUUsvfTfq8slcvuD/QE1AA1IN1Uco1BjAsg?=
 =?us-ascii?Q?d4b1leaWZBZu3VTFOlxYHiJZCcr83OdorbXsj2CVRgzGUspD/lULDfdvoeOh?=
 =?us-ascii?Q?KOcdPR89QgZIBgZJvZdNtZvkK6PpLOzPXMqie1SuY5m286W/LDl6pIIyC1Of?=
 =?us-ascii?Q?adGu7vgV71oQsKTfLGEtjGRKJ7kJSWzOG+fyQEEPLO3mnoiBGPB/0kYivSAp?=
 =?us-ascii?Q?ErcIMBQwjvGZmYUl+j3QdUjVDAxDj6uMzbyGP1/i8hvft9AE34iVJ38pt3Sr?=
 =?us-ascii?Q?h7UuXynFm+OEOO/ZO0MlZr+rsCdwOkhyWNOut+VUC7sHeQhOs30h3P7vWhYj?=
 =?us-ascii?Q?Ocf8S8PmY117OqF5nWgDBYfbRUOocCmQHIlP/8Y8gpDz1I+45CjeRD8WH1n4?=
 =?us-ascii?Q?zh6jvS2jA6/HLP3hX9kh58i5ae8H6T404EH6usgL+qmzTljyaH8mn06Xubht?=
 =?us-ascii?Q?Qh14OppmAPBmkt3GRAml48+VJN2xcOP9vhk7RivmWwyMGxPfywzyux3S6UQQ?=
 =?us-ascii?Q?wemVhvKx8fG3ZI5WHkV2IX0FBpT7av9zTo65BurycVEH79qefNr6vbohG3Zm?=
 =?us-ascii?Q?66qDDFbMqaS9rMNj4QvV9Qa6RMp6hLGuEPyU2/p1icLaLGKUR7iRZoTa0ODI?=
 =?us-ascii?Q?XCJcYqwe3y0k/mDS0iX+lrcP+63IkdfoQzeJ/ai+aPFV3IgTQzufaReHrya9?=
 =?us-ascii?Q?xBxkKTgl6q8ODe7h+kBQxHBCTp2zZ6z8YVzuZoVjnFk66ar75Qk0ACR9bCQ8?=
 =?us-ascii?Q?4RZUhCqAuQr1Ow3OylHohKqzYxnQ1qGrwBJo99irMSc//VBXXmGPMxaUofUL?=
 =?us-ascii?Q?5pFjJfEX46W7qZU6I3XGck7X/ywXYW77/aAur4ZnWqmz4WpqgxWS4wdI+95B?=
 =?us-ascii?Q?Z7h9FOdfFLZwOvBHcCQiyMwd4jj+hTsFi22UDw78vb2hP73G05BZKJJbaPXM?=
 =?us-ascii?Q?A/xXnHTZ3wbmUpYO5VFq86SmK4Qa+BMTkAmS7CrPnjG1Oyb4XUW/A0kd3XbX?=
 =?us-ascii?Q?3Mi2cbx9hXNWG3lhPaCoseAu7godnVRiq446VKFN+efOzzuPqTIbdwLNqMqF?=
 =?us-ascii?Q?1hytiZ4IZ9u2oUn7GnJDNatElbn+xqk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a84e7f-d7f5-47dc-2790-08da235f50af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:31.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p91wIpWs9nbEXFhwVsTeYVbqrwukd+2gzpjeMjTNemhZWcmSkELmKFfri6RUmSY7Gj+r0RLam0ZDbBE4MCbkrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d59bfdd6bbd..4a9a55c4e2b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2251,6 +2251,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinje=
ct)
+{
+	if (reinject)
+		return mptcp_subflow_get_retrans(msk);
+
+	return mptcp_subflow_get_send(msk);
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3805,6 +3813,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f8739bbf9c..b71d430ec868 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinje=
ct);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..bd0beff8cac8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_get_subflow_default,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

