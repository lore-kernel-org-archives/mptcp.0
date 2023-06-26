Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8227FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCQbK3+luokJjmeqLos69TwQTp2th6J/ppJR69MdzjDnI9h9I6eVtARyZ/UVzxRMVqOAxYlLnh8oEJLo60SGWIYF3cu2wUiRVnjuQ88cvLgCFcRvVbXLPwFiSiKZ7R1rKTCCPNTNu8HWdA/BhuyOVLsxTs3GfXU9BBEdwKerKMtE1hO86GiYnaQbtqmecooKd1gDX8/PwIsoGrENVlddOKBe50EgtdeSO7Zbx8tdFjOGJHYnVCiiKg+6ZtcZJEDMuT9/1LokKdtd+TJqahiykgNNVJNjez7Pag1h3MhDY6xnFscydy00IpsKC3xq+sRE4p37bcSvKnNKkrVuw5rYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEHFthuFF/0+e52J2Oo8+MtLAwJVA8OVor5RdmIyC5U=;
 b=VxM8hNOolMyNMcHyTYY3hEf+vUxAif4ZPge4cIdn5ubv0Ow1UwF647oPSNGnHX5MfadCvvNoMwDJvWSA5U8FosD4yc8qFduWChwqG85B1hPfE1OmiYufWrJhwylmHkaDD6PlYLereIW/P6TNByEJM5ezPdXsKVbsM8HGRiOq02upCsSPX7Ynh8a+5hAMgidN+Ghmsw6LX+9e60jvjYkxe74o33Af9EV+mCXgIOWo0Ylmhy98r1uLSsTg6PltbunyqU0fC7b+gVvMeaUP70JCwqNUR5Suaq8joksF0cDe9DE46KBa1+gbBu2z686VRr01+YNZKmo6qm5dSGNTpz1f+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEHFthuFF/0+e52J2Oo8+MtLAwJVA8OVor5RdmIyC5U=;
 b=HJ3TxrbhrdhbpRAwRaXZtiZDIdbhzoMM1lR0IOHnnkW8NfBNYDxs/g3RpqcVnytJI/jZwty4Ml7QcXS1XbekQDoWdZqHur9xSmiYU+y5VV/vZA6Q5L068+OC84/zKvcL8u+rifjjhgo8pVCrju7WfvXE5xu/LRs+rpCLFoX9eiLrcN71lLm0HzB9vW2xsmjPNACNI5VFk4IgIe9u8rzHizAwN/0kJmw7C9UCPQKB1tUcotHO5Xrr5cc5zDE5vf5N6JBy+tgOGq6+hZvvRQNeRHx9pnF0woG+NqPowUZWvCiwuCekHAVGi0yE2woP8qqk24S+lgDkObmzrYL+ujXNPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 02/13] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Mon, 26 Jun 2023 10:23:03 +0800
Message-Id: <0379bf05934dc748d9c27734a43e8d7d0a9312b1.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b349360-f0c5-421f-db48-08db75ec5388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	be7lMnlcVyFa93riRV6zua4pI8LSG8NKU1tH4RfcXjrZ4nQSB7vtnBhZxUrE/Dl46Q0Z9w9wzDl1WdpL7TCW3XAlXg5QzZgkLeHEgHO5vP3Fz1t5UDNGKcKoZ+o9wAHa53CdtKXya5ELU8KrDOJgTRQ4aRe0XYSi/RO0cQrCeuIr/Tcz63IZ6uNefpYeF5m6Oinyw2HMsk6McZos0V7+rbSI3oyunjHjb6Hqw+MPdRwNB3R2C+Ct7E1ajUfvjue3IiRDz6TAIYujvkh8i5J1hhgsvIJ/RqHczOgnsrnFCqbD/pUidwfAch3UuDhsFjwjYQd+gkU5ACZlgqOUReOAk8qruiv2LU0ie9QzUGGTbP16PtruimgRAdhs7bNa4uJJiizmcIbQOJsrzYgt9ty0XhqczF9RR1wBHp66gMs6GItxdnEqgFoeNQj3uvpPDm0UEldlfHjC/FlOqsD8kzAqG75v5aS0qElYX8OWx9odakqHxJYLAvdd8l+2I4CW6iMaqKg6qzHgXhZS161GTE6yxpgOxfRimC8K5IGeZRtI2SS/v7w47VYi3gqVnWBM4rtz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjWtxuVVgUzFeK/q+ODhRd/UH82WBJWWN1v9dGzwO4H313XJ2yxvjc02aeFY?=
 =?us-ascii?Q?vdndWBvnzyIf206zOezWMRIG9tPhvqG2277H8AF5L9MSbJisllG96j0aWa47?=
 =?us-ascii?Q?35qaT0oYQbrM6qoKhoDku/TBX/dntr9r/+kAMjwsOrrROvPmqqHovtYw5YRM?=
 =?us-ascii?Q?4ctXrOssYqiyOj1Cfys+TH2HF6Tm7GnF7anGyPHhIFWocyOJ7UTPHKwCBr69?=
 =?us-ascii?Q?zUj7mzQIOehibilS3MOVSrHTirSRV9WnseSOOt7Z+8tnIJbkH8/jPanrFGRo?=
 =?us-ascii?Q?awYWJr1FKhEbnsr4x2qx5a1RHe5k2x7/EIOZJel6PzDTeiiCqmnmUYVspsI6?=
 =?us-ascii?Q?TycJ37E2F0dR9wDBhKtRQS8SikGW94jzSCUYeGcYko5Q/Xu/Z9fCmTxzHTKL?=
 =?us-ascii?Q?wADkxGltriMzB4GL+hM/zCw4wzyE5bMuPgeX/eMV15e3LmC015wSlDLs2bnR?=
 =?us-ascii?Q?Buidt2cVqlkR71eajWstn2OOym8t5dw08q//jNSeizspj18lxzuyTWrw15RZ?=
 =?us-ascii?Q?TU0iwizuIw/ocm9es82m2iR9InGZYrbDGyB6ipTSVON36jOiV1bCEo46B3cl?=
 =?us-ascii?Q?NinTR/8deFA9oooOYv0R+K5CJU/fIaGdcn/iv6FNfFQ9aIb0msrdHMCfcV1B?=
 =?us-ascii?Q?rzjD2OQ5TUBduS5ckxCR61VailR7sBVDW9ANwTr6f+sxbGgCbNq96mrQ6qvQ?=
 =?us-ascii?Q?vK3gfwdqFX0x5FPWQ4K1M6X/dYJM8WISngzDVgbzYrvTT4gcPvrEKZNbxwUE?=
 =?us-ascii?Q?2H3zq6M2c23GdYyB967os9WI6bjHVwQj/rKgynFOWs4xnK6SGq12LNeuIw08?=
 =?us-ascii?Q?3IkByO9tyjzyoZQrLU+ucoG8V0Ynd0NVbzngod5wrFJ/L50psYzUSe9hvHgm?=
 =?us-ascii?Q?/l5/HEuxxbPY80NH6MfQnF9MspeNdX9B1yqAgTu7u/BKDJyJ4XGiSNJGKMfy?=
 =?us-ascii?Q?HFbZwg8+zhumtREHe07mijovUieCLMx0ZrnyoGu5Yy0Gma6ZAcOgmsBIftp0?=
 =?us-ascii?Q?6zBH9XVbfGxZ7UzISfeCRb5cFX6VwnoIbPr6zzl7od3/YPNqdeGLi7ASUow2?=
 =?us-ascii?Q?3MJUkf2YMkTPaHPIT6XqLcbfDUyPr5CrEU0LE2MlY5XrusmvsEyKmTQKUvte?=
 =?us-ascii?Q?AEjaL39t1EdDwKHQz8JbOPcPQV7LE8dCyBk4/ZyRpDZD1Q4/qRfQKLoOQEQo?=
 =?us-ascii?Q?F5i/CIKX0SjCGwO2XmP2wT8YK9y6t/TRZJhZTH3tlA8pfNYtktC5BbSin0jg?=
 =?us-ascii?Q?0X2Kcb9RjGQ/1q0RUuTjNtzu+5IPyAKO/X0Ws5zH2H5TQt9BSZ6S5/PZzV9Q?=
 =?us-ascii?Q?mD8BUGTB95A6INk+p37FrsNPrxWajvrwdDtd0e70sbWlxdBMjCns9rO7ySew?=
 =?us-ascii?Q?2ETM1XpN/CUELXcoK85iKuxATT081Q5LeuwDxZ6hbOkrmjq6i0LyBkUf2XCH?=
 =?us-ascii?Q?pfgxtFKyZtJqPwgbRyKVNpj5CgVtL563v0LtP9qCL/nMJ4U9A0JhOJa7ql+x?=
 =?us-ascii?Q?w6HUsnyLFgQTMLdi1JfBlYiJ8yNzw3DQ8VLiHlLmEa3JJXNl9SsV0szNaJqR?=
 =?us-ascii?Q?DCVO78nWrZAM/LqGbjZqqLcM5ZEZODLY9fYFlN8D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b349360-f0c5-421f-db48-08db75ec5388
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:27.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGVfc5F+Q1tt8sZVUDyLuUN0qRyiFxQLv1nxT6rTen+fqbHBjrfTmwZOEBnYIREUtZsJp2a4BXJrICBrq/dB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

- Add subflows in mptcp_sched_data.

- Drop const before msk in data_init() and get_subflow(), since
msk->bpf_storage needs to be writable.

- Add const before data in get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..ba0e1ee68a05 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,21 +101,22 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	u8	subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	void (*data_init)(const struct mptcp_sock *msk,
+	void (*data_init)(struct mptcp_sock *msk,
 			  struct mptcp_sched_data *data);
-	int (*get_subflow)(const struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_subflow)(struct mptcp_sock *msk,
+			   const struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
 
-	void (*init)(const struct mptcp_sock *msk);
-	void (*release)(const struct mptcp_sock *msk);
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
 #ifdef CONFIG_MPTCP
-- 
2.35.3

