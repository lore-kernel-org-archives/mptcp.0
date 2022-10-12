Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140050.outbound.protection.outlook.com [40.107.14.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B217CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcCwN6r/e+8v79tM8W6fnojA/r09tMcqjt6JuDptgwb+yNgrBYU4qPCORJag5yq9yQaUuf8x/1zTZ+leex1mcFQaw3flII2xdYGCWlLshblaysG/wD/PqSHn4l6w1RpEYRRvUUIHyojOECj2104DQLXGD91c5s+XgR+WJmeWm9egXfamwmz/sNK8uk6NTvsiknbbTxAC+eAYzjUN6au103kYvfGvJIEUJOrLTmVI1r/zt6rZD8dTuY/9NBlNRRqArih5JX8npRPIoeU5zR8AD20nS8Jsyl4xnV4eCPEAtqFBfjyCQJQD4G/6b8rYGXfEmS0Xc6XuaTTYKOQvued7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fC+BdENxiyc7CebiQ4TrS61NNftPQY3q6HUYqzm3AE=;
 b=Gh9gDY9Q2GVTS37wQ7g1npsXrdcheR7f13LHVTiW2SLf7dbKlVGDjawZiGTnKT9n0hnrErmwqUBIxOpfVKhPylSopFwxlMKk655FjMq9Qe4e+RDyeur2H25sAEMZt/daMptBnEkzlN2uJNiPSf18bcOpgtNQyWpkeX9F4OR+Oe1qvTlmjJCZbaxTAK1EIka30hFOSkiNoHEX5DULfFsqTnQm2/Y6D/B+YOddtkIidQrbZdx4UDpt/FwwoQchKCsaEncCzpom0o6zIyrBi5YnfDNHPKVJrnyQerwkVUt4se6yKkmB8lZGS4yBDPkYYqApkzSdlv3ejDAmYwsb7GWEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fC+BdENxiyc7CebiQ4TrS61NNftPQY3q6HUYqzm3AE=;
 b=0XLeK4eecL1Snj/w7R7jYtywBUYyUkF5T5RrGzIFr0MACD0ybuuARj4+YE5Ndy+TvBzFhjE6vFvfDkCsMi8KGEK6PFj7YbZ8H45zdbX0DsK20+p7DHOdBnKjcW3apzmQIJ4DEGPyDqkJt8INgx3ahOOYlBn2sQf0VCfDqaxbqdokILwJgoMLSdKCxrWE7Q7o2D0SQeog58VdpHj2IH63HMBYyLYtYtFGPy5W7vyWlSpA4auOOgRt7Xx9MBTINguC06+HDTl1JsGUU4gXFVI27trU3KYaTjiZxk7ZpNqVGhI740U/SAG9JAng64jXs7knxySy4OAF1MmX/b9JVfsNZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:52:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:52:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 16/16] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed, 12 Oct 2022 12:50:37 +0800
Message-Id: <28d79bc2db7e326c0f102a2394a89ca20e7f5c53.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:404:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: cd70abd2-6f8f-427e-e8e9-08daac0d97a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qCrHI+S7876K6gsqYNdyBGfqwV9n+KhBxDaNPYWIsrgPODq3ENBaDBCS9ykmq6e8Df1fl6PCHFWLPyiNoxRctbATu4wZ8cTisj9bxi5jUrv7f3cg5LpqugpbDz4G5ZEoTEPZHiVtDdo/06kRFm0gqbr55HlAyudER0zYmflGlMLtSjy2eP9IhNFRzcrbA68/CiOH4O74QxZOwwkkw0PJqDADsmXXoI6xlGFqQlcwnJIWi+o+eiEvj6ZAflDVa8eFBGNg6a49+kUEo8HqaYssEDLq9wfvDA3jnUsM10LgC/xktVGEz0M3I40atSfa1Fbg3b0fq1edALcOL67ahaHyLnKwHNKpu9FMnEpLUW36RePxMm7pNZ4BJ78i6qA0g8s4/YRLWKEIhkANpdIQG2KpFNkHHBpRObQV84QnxnsRi6S0gYqrKiCgTXRseg0d0PaHMgHiiY6mMeqK6b2D6hRCtRjfdVbMQ8+fRaweNOO2U/2zUoCn0FYu7A+dNej1cCikhwrKaGtsrKuRNcn0/mR98kwdZ2LTQY102VsrDYks1Y71tX9bUJz2HZZwdUZQ/stIVSyrr+MWk0AIYg0DUvTqz7lwnNv9hd7ZUtxBDIBT7/QhB0ICeIURNx8dx8xCrr0FgCWmPWsvBTMxUQVx9KQ+kkVf9oH/hT7yUCDlrvKWtfThQfco5kOptqDmuTyGCJqBpES5JDdN5p4m5OeCp0UPkX1EWuh/rsGzmDRt5eRj/e4e/D8Y0I+hJOlXnJl/mWmY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(8936002)(2906002)(66476007)(66556008)(66946007)(44832011)(41300700001)(5660300002)(8676002)(4326008)(36756003)(38100700002)(6512007)(6916009)(26005)(6666004)(107886003)(186003)(6506007)(478600001)(6486002)(316002)(2616005)(83380400001)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6kIwtf7Ms81ZjthSGAh4fbH6R1XYgjmqD1+6fp7qVAGFxeFtarg0mXepR+x?=
 =?us-ascii?Q?jz5/E5hc7zkFTQ5PogOmO9Cf06LwZebKss92DpI/jQpygoDdgca7clfDSGC5?=
 =?us-ascii?Q?0qifSOHHDR46peZd4bZI8IrSKWc8DKmrRoLqjWM1IaK7JEVGYxNV00Qg8WyF?=
 =?us-ascii?Q?4GEvAGZFZ15m8XxFJXGJIZGakJ6V2fJ0Lvy8gXDvP3Qx0EZ1Np8M2PoBi//o?=
 =?us-ascii?Q?akawXJOohHcNKANPPcfFWxcl5DQbQGwi/os7qhPDgCkFl7Lrp1T4GgpkYtUV?=
 =?us-ascii?Q?FtPP+f9i3ijkQLxZD8ygaWC/3knn1AcA/frjCkx7VJ/HnZTlnj5g7QexZJFY?=
 =?us-ascii?Q?1/3M9jY/hk6ZUDWfoyr4vvPDEWRpkL/VTVBGB3TlQxg8VzNhyiVZ6HnnNF7w?=
 =?us-ascii?Q?74gdGgP2QdtwrdyCSKBIEHJ/T7teAag76IGu60YTcsGHq28OU68Bb+FK2X3w?=
 =?us-ascii?Q?feAj3LmIDvNILnddKrpWNmLnoP9BrgHhN3ChFN7rpaTSjPOFqeqCohrRrHH5?=
 =?us-ascii?Q?6BH5M4hwFx+2inlWJ4B774aSQMgD/uCd7sQ3lF3VIbnbhZsxPDSJ6axQOMVq?=
 =?us-ascii?Q?cBpUlKPVww0EQmVVg6wuCpM62AMadpSlH1+UDcScmcG2V4jgMgAdWZeNvDeY?=
 =?us-ascii?Q?kfhIzvCSUQnFqQdO+50NAS5eyBf3za+3xakcNUP0zlWd9zDVWv87PZGhLp23?=
 =?us-ascii?Q?6xITx3oYa55+ADg1/q3Ueo1E5gurK80ReC8LSwqG6Y0/s8HOlB4Mc5n7Wcj7?=
 =?us-ascii?Q?yfrBKB/eoPPLB8yypWuoGMyluGq9mqfZSH5B37qAKmrVK6Up82kiq7Sw44+F?=
 =?us-ascii?Q?8uUG6HkhP3ZuBJhVmQ/82rBtQ8pRr6pXzBZhJlvKMOiyInM64gC0qYhhDLom?=
 =?us-ascii?Q?BQ3VbkJtKSfVaFRA9dPoAMbCD2uQDNhmqgZoWwownumUpC2zOq3aPrTReo+E?=
 =?us-ascii?Q?PnJ0mBT3sGbUWDnyom8ZXmIdxZd3Qz1N2Gsq9af+Cs7XGG8HTIe3mVlMZyhn?=
 =?us-ascii?Q?x1tG7KM3+JBk5myrdfM8uIzWTSP8gbwvRpFFvngo6YOemqC0JznHf66CoERV?=
 =?us-ascii?Q?JWq+dNDvSH5lI9S3gAvMw00ty+5m+tSRXXJzY2FxKD2RFmzFvrMmclGwOYUi?=
 =?us-ascii?Q?Fm3Uexp7TWPKzK5WJA/dotbl03jM1CjquXvzm9B8NBxmsE0s94o/8KMSM8mE?=
 =?us-ascii?Q?Z6pFq8zm0c9S7sltylRvfICh77fKA/Q4SJcEOsAbChdfh8rpqI195KFhfKhK?=
 =?us-ascii?Q?vLBYMS8PWwDneKpnUyw5DXn22oBXdbPZeJeY7XHAKCg/b+O7ryeazqOaygXS?=
 =?us-ascii?Q?G9n2v3/V2o81zF3HNulJgu1IqcFnbtVQRny9Bk26BCmt4zNF2G75G1HqgV4/?=
 =?us-ascii?Q?pQIKZhrzt+APs90q//f5UNNfhAdR7HPxFETWUJgch1MrvYKgPXVF7H/uzTWb?=
 =?us-ascii?Q?LGWHtLZ2OsGuUBzsb9KRKGhUimmaV4YVSvmQr1ihXFN4IKnkED+kRSQYYvd7?=
 =?us-ascii?Q?CEpqeAETjl6v0dU+sf4W/XfQvC5aNluYeJ2ZNaDwvucIP4z+padIDf/bhzTf?=
 =?us-ascii?Q?QDME9yyVocAPBgYkmW5vV4+dsCsbs5DF3vbV5BBCAh7wOMCUpjF6V4GCPVzc?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd70abd2-6f8f-427e-e8e9-08daac0d97a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:52:40.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIOa6tsGSnWZTKOIzPV1mCE75do1gD7q/lVnW3TrobZY0N2gIWjVRTBrY+Y0s6G3l+KoMkLB580GCEhnFrRe2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index b7156f6aae8b..2d27523b5a7c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -17,8 +17,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -37,12 +43,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
 	last_snd = data->contexts[nr]->tcp_sock;
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

