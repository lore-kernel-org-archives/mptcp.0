Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20081.outbound.protection.outlook.com [40.107.2.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43D6ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZb3u8T/myLEAXrYCKJvDil4n6EU3+XxwV3VZnhQcAay5UHEAuXUG6R4jRpl4mHJa9Me8uF/jkChyMawLat8BB4smkDml8YpUvfMiwijK7R1U7aa8XJ40whKtFsuKMMH0vaNTMsvylKiBwqZeZrIMQAjsZXDeLIb8m3Da33rDTH6cSbuKxkNxGRomjtnTiZDHZ7UAQw7/97XIdLNG78pb0mOnFqqOqR0q0dwxmOGMWlPCvRqsMkL9FzG1njYhtNUH1PpKOOmv2soZDvXy8NQvUlI0qwhLHtepPGQ2sfjllhZK3QuCRkNzlcE0ZijiRBtx+BB8fkVTUPu7tyOQ4mnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=Uc1I0KtjtQQIbVe8vW6RIooEAwc3qIArFHXAyOd0tD2MWIvExx8ZQAoxImftILpWvp9x0FBg2bUaopUiiLPzYdNHJ6L9xdh4pY2ASQBt2vVRfm91uyMb11O5oJQ9sEgotkchnGjAUQZjAn8YVP4b92Bf6pAdNuTVQct1L1qAX9IZ7ceYhcNuKFb0nwP0PTefjqbsTSZHcA/SPoPfCPL4kw2EbTMX+gLX4+wTARb4QMF+p8TznHia+w0pkyBHXWxmiFtfkEtkPKUCVZww2PPEX7NK0JXceEaeyrMHvE7ILbl/WPh+Ni5F+zjuCD0OndjfzhMcujGY8TrDMwg683eMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=3vy49W5Qi8NjshxofTU+5qHDsldPHOJ/exdAhWexRwaOQFRfqb1mlOe78j6XXI6U4uofPyljX3K4pe1u00OzTNh711U8wPv4d225Cvw2c6/gEHJnHrtN68jMS6a3Fi7Z59JMxETvjU3d9PBaR7J3DcnweBFeidsUer/NxGT9PWtYaEQUAte0m3rwUkyjI1d8GPy8NAstC29Lu15emEPvv0A0CUxwTuqAlso/rqa+nRbDJk6aK1xtCA5I/kX++RRjLV+6FM5oSpgoZ3HePGZOyIJkt6Zr2/yu6/kmgREO0P7eBIDeMLHtu2GGzAjG+4ilJ0Ldot9uqczeQ3cIkQRWsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 07/15] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Tue,  8 Nov 2022 17:08:29 +0800
Message-Id: <00f0c0ab23efb522a31b252574288715759e1a30.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 393b80c4-0360-4f92-9ee2-08dac168ecf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vTFuYVLXkWB1fkMf3PHQdYf1CjLLjLasDgN4s/lMjnkB4+yYGNrfJ0nNF9WI15jpOMJ7xa9potF/GeLJTgDT2hwGZi6j9F0rOwl4VQI2RklzUz2l2oWrMnz8HSPlVCjc0SFWVGiPEmOl9jVNl5OAbthgwC45i8Lm+ohMJ1S7GyOmLincfAZaKdHTWUTp75fdLNyYtvpIPvmSyxdA5o5Ra3EKmP2OHIdaw0h8GfoHaDPfhfQxKjK9iLw5dX2LfiQVuRVMDzkHXunP2lLWaXM6174v9VwmF/VWwbXSPBF5gZr3H0wIQoBrI7A2P5rLlpTnLIfbC7RwQ56iZC39tLq6ESxMIiTa/dmUWpXD4bAS69sXt3o6v4Dv3mD//WkwPpvFCQcTH3HdudNAEcywHA90H9dMAwPJYbrXWPqE7ZmczMlg05mXNZwmwVoLlznLK9UFR4AYq4g84D1auHBWRLfZAqEK8W50kr9XRwJt3AAD161XbWOHd8mXuz1qg57TXbeDs+/+lddc2Hw8v2vJFnHOqFGVKb42Qbyi+kvNBE4QR4z1GYMq4Z2Pnt0ldW3HM6n5lNaF0Pk1BSMG0LU/W8beLgP1ervZIzcSzC8jKdDNE/MLiMELjx82H6Nh7UTJC4Dw7kuL3GEmCaQ6hy51a7cRvrfL1n3Qv69INAwnHIzRB8k3c9OYW+uVty8KGOQOiGNM3A2vJ1dldBcPcf/d2Xz9KAkChA3MuFshluj0n5ho6+a3up21pJ68W7j0VqhJb7EQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(6506007)(316002)(6512007)(36756003)(83380400001)(8936002)(2616005)(186003)(5660300002)(2906002)(26005)(41300700001)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(107886003)(478600001)(6916009)(86362001)(38100700002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9dJBbcuLaXG998rV5AXUbht+F/dPC0jBaSC0hHaOB0ifXX0XUj/SKxtybcA?=
 =?us-ascii?Q?ixJuuGx9b1CxNQbYYegC1qf40rKtlrYZ2tvggA/b5TUWZqS4jPcv6u4EbpjH?=
 =?us-ascii?Q?qIhDDaA+URXyJMszLBqswzLs26B8zv0laMHc3f3YEW1h+4xJOt+nzkKyfocR?=
 =?us-ascii?Q?+k9dohIQyVbnO7PgXAtDckcDgFJYJZZQwiik+8SL3Dni/Ap+JU1AGWdhDzdO?=
 =?us-ascii?Q?hBTXClwp1foIf7u/sQytafR9lop2IqtW8ebDyBMck5RtDZIuytcxRn2DGrFD?=
 =?us-ascii?Q?WXLQ9KMyZ7IueJ3+2qcn4JWCsmrbHjwFykYEutbfGrCBgckf1lGU4u7y68Ge?=
 =?us-ascii?Q?kcL0p8p7LJYpp/0SqbHCf+wpdMy3nIKRNFiTdKNxkGWqHSy/z2nn/8nJ5aoJ?=
 =?us-ascii?Q?4k5hBKlw/ruI0GpVYKFEJUdgzBsMHTM5up3uTBbCo1zL1IZO072VrAmGKjPt?=
 =?us-ascii?Q?bcAoP1KL8eeIjY4oiaLjPBXTRZfLWtu0edt+j6GYzBgUzGvqGyNRfY56mJ+q?=
 =?us-ascii?Q?Z4e1qYzuPw8OgPYGEHf4wGEB/vQChUi421RoBhEqnRiMBQwTpHVZYdi3l7lg?=
 =?us-ascii?Q?xuIiUWSGCcEpzSpmFHAqUOMWWxSeXzrTjcTFfNChZJc4NNhi7alU+XxxSTF9?=
 =?us-ascii?Q?tdM6KZdc9wixi3ZLzLrF43XFqdVlHqvBG6y9l7WXuXM7zYrfmyICYQumx7kQ?=
 =?us-ascii?Q?GIZu18trG8gCR9upJFhZ+wT4uwxM1reoobK8y9wo2Y5q98CNCNgjPLjsL2C8?=
 =?us-ascii?Q?1PAlJKnMlw++9upRLBCGpGh3w5odV3Zu6RhpaPgcYVqUP0VLAuH7GLKME86A?=
 =?us-ascii?Q?LRST8jsL8Mn4P6sXJswkn02DXPTRMjgr5x7JFO0wpXopo8hhyraMhNNnC3j8?=
 =?us-ascii?Q?gJVGAWK8Rx9OXgwm3pVUDPpxt+479RTESbadWGnu4R/RVcpcan6G+0ZKJf6L?=
 =?us-ascii?Q?9M2u1IvkcDdUBtLOQqFC9/n/0KMlbmXPEqucCNJfOqAYj16rvpaEgDd5qJEP?=
 =?us-ascii?Q?5ybdHmGUwd+eIT803TR75fIgeiLCUbGt2jPn/S07fFiZdQ9uRxVN41RWxdBz?=
 =?us-ascii?Q?SGhElsOIadbxhgnaVuBhq5tQ/xl9mqITKfglB+Zx53ig/pdDYJfuU86L9wRp?=
 =?us-ascii?Q?ibpfp6kqdRAhb6+dKM/uTz+bSPUzHR7Vi4AQ5IHHSddYHxsrk8hBlnLhXk0J?=
 =?us-ascii?Q?A3WbsIcNeDByl5uqqlpdYvjW5hyls02hR86aYqnokJXELngYCWsyy9vuJTYg?=
 =?us-ascii?Q?gYxBEsDlC/Wq0L3PPzq61tsHgHjaBiBk63jpfVbX8YR04xK7E+sKQoOU5jof?=
 =?us-ascii?Q?wIXtTATLR+kKOcgJoIiObOUn8kYBA/pjA5MFCBT7a+5hQNPRTJGMm1H9K3EJ?=
 =?us-ascii?Q?k7/a6fFLVFQy7ZBuAzRLaaqVxRWmvvMp/YyTRqWR61IuPEnwmr1lPHeHdUBL?=
 =?us-ascii?Q?BpXdG/BmDkUVx+AR90wC8qP6G7Bahu4QF8JONWW3yoPczZ1Musf9N+W7tkSp?=
 =?us-ascii?Q?QXZvuoPBLzBYfN+v92U2VGUzZ2C67QdV2FTHIPXAZyMH15POEwoCeV6ZXU+Z?=
 =?us-ascii?Q?p8PW4AoWwz9jnybalSoQ2/J5kKceiooVtCA+GgUG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393b80c4-0360-4f92-9ee2-08dac168ecf2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:22.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sev8ywDM7qK/9HfNNs91aGtjA5TH2Sce46BnpFSTCALbAhTt+50vQleut/nplWsFWm+woDb8PYYsSqE6XU/hSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

