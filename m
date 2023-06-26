Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625927FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf8rAIQffNdm/twtV4HT3e8Yy5MRg63HcXQgDKqjnGT28jzCzyLIbdrRUaludGIPr12nWiD6mFwx1Gjcle/R7SVYdM4gqvgv9r5OgPBZN+ZNQqBouuXPMY1/IpBLruk8xyCT4PNSXRZ4276NzYUd4+OjxT43ZX9T/G6V5yc5SBLbBYPEWvYBvfh2VW8WtxDuo7gpRlx4jQetvNCw8xTWeDMtJbnlfT7taADGc0plnrZwhxUdG4gW6lVHQ1AkzZH3o17jCDy3H4YzTCCZzN1fgC1fe2aNFYqzgjUtjzaRXqco8rhgOuTgEYoPrZBtRremvPLEjdCNVb1Z2wCb3q6fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXUEK29Ag1K2VSEDf5t1XDYKLbgsGTzzQ5ZSkdfnVOE=;
 b=Nm7DOMPcepnEtxsPNlqIBeU7K1VyE/bqYv3odZIx1X8gAFRiTahYgFtHZd1fxwx0K1uvIBgU+nGw5vS16ttbKclMgN6x2nqVJ+uqbwAKaN8bh+lqdsug8OxfKM+QOHXPFeCDi5ZvPqimjDYcyIV+J1EsomZNz74ALT+ff0EOibDEaFK7HZ5NWRxhiQDzqwbbIGOVxPzeAsV/70CF/q4fT6TS1ap7lWo2zCVW2tZef22swsomhEUjixh1Eqp1aqvGO2pPLdEZ0ZFvOjn50eH6yndpzbP0qfZx+dZwO8lm53YFbVFuwsuMYYA2Li0w3woDWi9t6xdab20OCVUNyO3Njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXUEK29Ag1K2VSEDf5t1XDYKLbgsGTzzQ5ZSkdfnVOE=;
 b=gyze7GAS5KQ0FDhrFd2PECcEkwIsSjWBZqS/JHrxJuBo782DZSyrT2DoG3nIj3f4LHZ0zhHHBLNtQr9SQMrYmCuXXDTcyHLnn4BSnNHN3qLzx5t7WVUXlQoax0yu2Tugvae2RZSgN5Apyy3pNw4Wsm+WtwxcTnIPHIEi6hTohVJQc6PNVu2Js161mrksXlqQu/XVCyWtp/F3+7ie+inQgUj82vlDzaspqFp2+OU0MolhamifMIu8Ypav1PMjnm6Ck1WIksP3X5joDW42OB5DT6aDhB8HjyliBv4FdI7+wj4FLUPPWMLBwrFExTrwLKZxYj3LN/S4WFE66+IehsC1Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 10/13] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Mon, 26 Jun 2023 10:23:11 +0800
Message-Id: <c074f97c443dad9825b2c6cfc8e9659a0fca23d7.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ff07040d-f755-4c36-e0e6-08db75ec7299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvraCbwvqiiiETobfpJY04pdgcSP5kHtrQBfXZ5HA7E10zoF2+JhE7iZSnebkJzZBXdSZbUSDTRzcJIBJE9FhGG2FcGQ5LZjopDl6Yncz5tP2E6xl6IE2edKUIziT/YXyTNOXYCRhqjKOfBn6P5R3x/8lK+GApMktgdADh4fYNOoTXHq4JUjlOdMs2hNdfSEG4+3S2oUrWQ9/FQr2HW2G3r2Iae/XWEzXI7XmSg1RspXv/yPpOlDKXVnQYpkaU8Dcbo/FkEcRLhhEBZ5LzP6tnA4lvMp5728mYUgKgNDPmwqrM7uctoRSTBk+KePFWu0vCX1xguenX+BZQvAwpQuZgSwRcDZEiyHGFtT1JZzzhG9oyqAv6daSjZixcnZRQCzFbk8uDIFuxNZWcnTHjYnBoOmy7PevvzCS/b+uDR8kMrfnxYptofevGmNsOhriTgGQPcWBP9JfZ8dQLhkAN8txki7tOdZtS7vBJKG8rcPE8BRvpwYvZYJWh6PU0NVXwiT7XykDBzBgBUbslhbXcM35+mNBhI/NBs1SQaKCshawet88h3LBTT7VjxIrMtJkpLZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWVVOiTOqT3f8C++V2AVB9V1JORdFOsXkPKk/nZTDdGz9XzV4pnQCCdrp8Pc?=
 =?us-ascii?Q?otF03GQpT2fnDA9dYd+Nondyu1FzXGXwPFHFLnWkdeCU3HZSQggzC74jVLfV?=
 =?us-ascii?Q?O4Mo0FawK8R03t80qEXF9dunQeg5AqRx55UFate+vOk9U6GExt4DnZQ+dSDd?=
 =?us-ascii?Q?opDFeiKdUJoPE7AGhcxf10z/efTKzP26YvdbUYLenkK4ctVDk2fsV3XKtaB3?=
 =?us-ascii?Q?q9KhqayNNc5k+Oj0O3/Rg9NJGUM03LqH3Voh5JNYnUMzk8KiDL8EPkTQFILY?=
 =?us-ascii?Q?SiPWCQnAr0Rm3Trxh2xDjn/69PguthE0MMgqX9jMwffNuCsdMQHWl9ABJvCG?=
 =?us-ascii?Q?tZsdDUW44N+siUr1kR2pnA8cfrFOO5oZWZsDjrHo7MeiH9en+sTwBaTPD1wo?=
 =?us-ascii?Q?toEkAsGiO6Ws1E42pRpQ4u5icxUDP+xPRjy6LeB142BaLXJ2bq+dhA/UHWGd?=
 =?us-ascii?Q?pbI5lTFwJSCbiHjeQa5Gok8NYOCjg0CyR64v5qKYYRY9hC7YVqzYsSn8waRA?=
 =?us-ascii?Q?KMpH86cbb57LHhbU+EGy+mQGuh+e5TjHE0pqvxS1fcsHPGkAs3Y/vNORdJwD?=
 =?us-ascii?Q?8EFPKXlx5G0k2Fb5ZR83v6PAcnQ3Hq4JlDZoZE3Lw9gPWHORf3o4w4gbEi5G?=
 =?us-ascii?Q?6UJNvCIUpk6XZ9NTGVgxiuzy7FMJ6jdHKFJohZzz3Lm3jfhT20gkfZSzKyFl?=
 =?us-ascii?Q?+aqxCdoEklUXCl8GZiJ5bXx08/ayGObdrawGAbNXJDQYJZhDFCzQKYyyev26?=
 =?us-ascii?Q?pDKo1ilFyKCYJpc5bODENhD85LO1Huj4coDDkbxOk+AY314iflMWaEPSuqdZ?=
 =?us-ascii?Q?3lwsYTvYCpjvGMh3C5tBvKfr94fXuL7U66+2HOByJiNJyH8XWelXuizhvnlT?=
 =?us-ascii?Q?ABmDyoBNzPmaXtudrwr+TUhdqDNUYam9flqQbQdhj+6Bb1Ojk3NU+/u+u1CZ?=
 =?us-ascii?Q?LX/blCbNeYTXHvFFi2uOEaFoYSxSI439ZA2GtkC0sNs3eG220iVIuG1OStRx?=
 =?us-ascii?Q?MJCZPMfT5ErrCzy+ikkGP/S6ixMy7bmlhwkWQHLjkhn9BkqYJPJC56B0KELD?=
 =?us-ascii?Q?8J2JTVT2khRK7htNqi90KdXjhxUn8X3TXnqmrOL5S+JijQpGOtbJ02DLDVyc?=
 =?us-ascii?Q?Vy9urq/ammj6hO5QT3wtyQjaeYEnIf5AZvgUHiHReoHn3DOo08xF4nA7Sroz?=
 =?us-ascii?Q?Rxq8ikUIElArfBxTt5r2AtZ8TzW8vyF/MEypXaEurRFyY/cjCMxTHOFRF86A?=
 =?us-ascii?Q?T12Arr7uRCaV46wUZudeIbxuYAR4fVeSC9ph7cwxiS0ljg1lT6DsGb9zyQGC?=
 =?us-ascii?Q?HagndknWSETYhYHJRGll1s1OSST+km3Cn4BoFOUfRBuEZf74yFwjYS4ovzln?=
 =?us-ascii?Q?qc9JowzkOWtjuj8u/mImpe2VpIqBNlWxCVwPSSUzwohBWj397Om4Urs81y9b?=
 =?us-ascii?Q?PLms8E8Dcb7r+iiLbEtIuUkeSpyn28TMdGzgrbcFqy+st7yGLumLLNb4xnX5?=
 =?us-ascii?Q?3QHSmrzamHI4FD6lCx+mVjS/1OsKj2DoUmACpt6Yqgs0sHyMEBEDVb6Dww4e?=
 =?us-ascii?Q?exWl0CpwW+L4Je81g/w36hB6JyJM+JltC3jlwkhl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff07040d-f755-4c36-e0e6-08db75ec7299
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:19.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJZ3tF384KFrYDCvKS/tQ/v8lUBNrGBd/w9mUMIznkSH7A6bmIhMHLxtKfiLJc1EFBIYXHUkdeNJB10F0YlwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index e4caa2dd8c6f..75591256067a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,16 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, 0), true);
 	return 0;
 }
 
-- 
2.35.3

