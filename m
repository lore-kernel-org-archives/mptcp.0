Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00101622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxLL+d8st4OZAGskR2UG2SQOhZWEHSrTlUD2Iofdpjs=;
	b=a6AKryFylo28CDtHtCfMIkPk+M8OELQ1LT379CijezXDvbAKE0eNxWU+PONDUp22AHP9Bs
	7iulMmGt1rKD0S54Ui/HUz0ONl164On+9vwzie0mqJms3Np8LmQX5k6dJ4DZJdTxkfVOoB
	T7l3ZCKR7KGajn3DLk7nM3j/ocIikF0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-8kK-dnw3N2qOoHYoXyqWsA-1; Thu, 02 Jun 2022 06:54:46 +0200
X-MC-Unique: 8kK-dnw3N2qOoHYoXyqWsA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ozQZBOnTIqk/FBcETq4yLHDr9vONhm7NwmauFSHGpQaYhrgJsiDmFIHFGnvEyi5G+nKTaBYi3C2IJHy7Lzqjtxubm8wLKXA6VRzIvC6rAOTY/PlcMHOV2kaM91AVHuG7i2WjHC8Igko1q8u+ynTyF1EN0eegMCRZTdHNFucKhrUUmKeyurdPsyHjnphOHU0kackV7DpT84RmdwXL1LtSlB4DUFIoz4g1lIyGam5yQ6FBzHnxlM5KQanv1N5idq99Yn9Au2gb4h3saDR1MBFHyT2iUFUKX6C63KZmRD2JusW4z7Vhc/6I9GgadBR7wrLMnw5Rfq6kDMf0uLdCsu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jdEZp13QRt7lVWaqsQzcz7qfZwiVk7E3QwAcvCxAF4=;
 b=bJIhB+E6vgR2jQ54J2L4y1YF4kDdmjCqPVbKS92tu+cwt2OtHx2ULDkoNAlGGpftsPnJf4aFPq/yjNyuICpFJRmmOM8RGgEVkoAlcJzCdJEBUc5GEHDTwxrYPNgPaGb57juPocl35q6uiYVn1zOOHSTWKMRj+uZR7ZT0ZqI72EJ+qV+zFGaaMYiYh35QnCTkB16pR4g6/bzeNAo3hYl+fKdnZbkZAjlu1fXToiMhpi2T2gVeaDG2iHRqcUGS7LsnTOJmO0znvVyUhHsUGwy0tnHtrRep7DCeaOZ5T1evchyaZyQNpYE6e+IXkCK87y16Gp+jF/v1tuaqFhYKBVSG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 07/13] selftests/bpf: Add mptcp sched structs
Date: Thu,  2 Jun 2022 12:53:44 +0800
Message-ID: <ce3910d24fdcfecc38a21c5e6692c21469a755ac.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7884f4dc-544d-44a0-6dfd-08da44540356
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB33842C79255F0895048B494CF8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iZWhF3C4SGpNM83NTCCT/hGATe0TkRaWFDHEU9YDMvWUwBGw1CktH+gLkkMC3qjuhnF6kEjKsbE7/+spk6+yvj6tsXEoT2PSBWeLHQt66DuVcctviaLADSmJvWSPEmiNPqr8MeqyOwdbWsOjtz2u0WFqvqLwvALOxGj8XlJm6E1SlBiIfd+VOrGWMK89nJ59RTjD1m5koHd1f2lIi3LPauj+SehtwJ885O63E1ez6MQWRxHqGVxzhKBchuWLZ0V9/E8o+atANFgK7Wca7NS3duEpwPfsB954d6kf9aOQ7LGCSXtnwojfCydQItepam8Gg0DGcShThjCbMOo8CrE0IznlFgPuOBOTRjdK6I7YlWV4U/fuddYqDsqj7EMNNOOJ4xd2NVF1kQ5Ks6tUtRkAOK/F0v0PHOwCSj2x+5+2GbOucQ7QeBTRbvGx1WiK1KPsxDiYaTG2PIIcSOzNfK0Asr8SOFWQRBDNIfEyCBz9NyPiWYBL7S8lQDee89/aYvvJGusw8bibmYjxhWZqO1VUqOE1B/uYkaWtOBwW+PFmNXq6qo3Bran5QwHcJwpsGvbbqaRPkk4pzTdK7GfKcXqKN9gOUiCA6KWYHalbSYxGMaK/WT2U+f/5Z8xv+SBn2HJiISKExsRUWdSclEE0jb4LReZKli8uyUKE111mQopYWiNJz9x9/47IbO1NXWqdWwbs/3TfdXdoZSavAPaSVDVpsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lF+gDoaVatqscU+x2TTuaA2YZL4Hxp5+GFuahJfo112ncEx+KrypppTj15LA?=
 =?us-ascii?Q?lWfgQlp81ACMlFuruKPjQVqwuswy+u1DQ9IZq50/V58/bAb97aaXzt8p/1++?=
 =?us-ascii?Q?8uk6fULDElPtPOnA5PeDrXnV7t1M94y/EKtg2LqDZ9MpR33In24Y8P4fcvu2?=
 =?us-ascii?Q?lnO346yJWTQuUySsCrNurRKW3qjP27EwZDc3YUCF/YZg36zmJoau6qMzCkQy?=
 =?us-ascii?Q?temwR+YBRMCaXslyHmhRDLFty0kRvk/hMLN81wAhs+uYRSLDHgx3b2/WQ58G?=
 =?us-ascii?Q?f10hRiJc2iikxd2H9LwCOh2rMoTGtE6H94++JPttJinhmCW/wZWCY0w69nb4?=
 =?us-ascii?Q?/trtnMx39H1ZUuAoF1KnzNySwVzW6sNVn+emRBeg3naTJH0DvcIyeWkuEaqs?=
 =?us-ascii?Q?GY8AxNnMuheEEMpGPPci1zrN7LiGJf0vpfltKTCKlklMXi0c5/XoqYCuK3a1?=
 =?us-ascii?Q?EtUjdtFJnMtbsxSD8ODbIoKVAU/rC0WRBB5oKcKtskvZZgJ/mW9Y0ynKQO+Z?=
 =?us-ascii?Q?MjdygVfoey7qB78aysVM6Hu9NDeW4isPUjtI4fNwTHD71raEGMvT89so7uWz?=
 =?us-ascii?Q?tDAcKyonpUwHSVYJMcrNInR/WmPjBAXmQdjrdExT+fNgwvssZTOtfHOJC9Vc?=
 =?us-ascii?Q?pTZlGyHz/Zoqwhh1/pmK4fXNFks2FO53T6OXMSgFf8nzM5I1b/oTwSMoyp82?=
 =?us-ascii?Q?2hgf8LFeVWai3G0fsjyR8WjOFE+jASOBbrirQxBFtgIiCF89Z+pfvSXgTpUZ?=
 =?us-ascii?Q?lmSrpZ+sGSvwIJ4ChKblMzFlus5x98zw8LjHt3lsufEqifgeU4ZdxGiiBgFT?=
 =?us-ascii?Q?7nSoj+0FrzXmzCE81gBpUUHZRI9jhJYCH3JXskVHVvQHPPCxPlDuUG3iKZnJ?=
 =?us-ascii?Q?xolW+MPTrcIwSf736ahznXqy9+I9uwl89KSeGWpCmkwX8E4zAjVr6empTSwn?=
 =?us-ascii?Q?zDSw/uctotQ0Y9eKXyF6V1E6rCmFeAdiOrLulGv0w21belB35h/VeoEeDOpn?=
 =?us-ascii?Q?4F/++tiIddLLAzsuqnBjWehGmguSZqBvgz+iF3h0IhjpzJ4VWHK4KUAQFau5?=
 =?us-ascii?Q?h7KpT2j0T+42XEoXuHcm5cgx1G6g+c0So2QUCg9Dm8isGWtIqymH3FZr4Ckk?=
 =?us-ascii?Q?DlbTdrnbenSzXkfZv/XyxZ+yb8jpBiYS9nKaiD5z8Hrehzg5IJ4Xg93pJHJ5?=
 =?us-ascii?Q?ChW1zMltEsMVJB6O422IlCTOQHiA173GCxhGbb+Xf7pjkxqaKjcB0/scODOd?=
 =?us-ascii?Q?//lN+jRzA4fHLAAJdTr36XGQPzXiv33uuPUbM1Gjmf1ojl2lyuDd9Wdg1aEx?=
 =?us-ascii?Q?MksNz+j0sZuOB0GVl0MxBtqZ1irpJFNjRJqmXvbAGPZxhVAnusg1EJIMVTB8?=
 =?us-ascii?Q?CgDWcqXkutVcMCNp8G7P3pJtwYRQgEI9RjxU/idK+nisIyeligprMUq+8ADF?=
 =?us-ascii?Q?g+4tEnqAySajDbz3OIfUPpmc4HKuXDr0krfpKyUqomlQZF/MC3Fc2J6GGBNK?=
 =?us-ascii?Q?NeLrhyQ80XW1VHy2eyEqJK1C74WMLKdw/8vwy2Pr29m50eC9RVLUBIzk7LYD?=
 =?us-ascii?Q?0j/8R9vmzbNYnm3tQnLmW3ElAiUH1iMfOmGULa+QK0Ir3dIXiGX/bToRKnZ1?=
 =?us-ascii?Q?PijYAoPk5UKS4GIpbTYE6J1miFTjBgpPdJYgBKDfI0OeIjAVJCTGrsYJFzU2?=
 =?us-ascii?Q?XlDN5xcmZqYdNd7QAWcH72+JqMwE13a4dufqGaoNI/Ypp9A13pPGiuF9vHha?=
 =?us-ascii?Q?CxanARbn9JefT8f3S3A8875x5kr97Rc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7884f4dc-544d-44a0-6dfd-08da44540356
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:45.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcRnwnt3W47DNQLiQUwCYCwizKTYKH/4Zjg035RpVk3C0KIYaNY0u7UV0e9AXUpX9hUUhRAGwDqD4bq1uAyjsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch adds three MPTCP scheduler structures: struct mptcp_sched_ops,
struct mptcp_sched_data and struct mptcp_subflow_context; and exports
mptcp_subflow_set_scheduled() helper for bpf selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 82a7c9de95f9..c8792e6f125a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -230,6 +230,30 @@ static __always_inline bool tcp_cc_eq(const char *a, c=
onst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
+#define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	__u32	backup : 1;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
+struct mptcp_sched_data {
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+} __attribute__((preserve_access_index));
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(const struct mptcp_sock *msk);
+	void (*release)(const struct mptcp_sock *msk);
+
+	void (*get_subflow)(const struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data);
+	void *owner;
+};
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
@@ -238,4 +262,7 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subf=
low,
+					bool scheduled) __ksym;
+
 #endif
--=20
2.34.1

