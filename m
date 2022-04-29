Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AA1365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651243908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wu+45/HmTRPh+R+E+xyWGNFQ4skrL2h4+N49FjniBg=;
	b=YuXGarp4ovuC6AHcMeiZzHt/PhzAojbOCz/z4tWrsbt1ba3CepC5TBfVHldJSd5VGzvKTI
	9NdiMJqc43tI9qHuWUoMYG3JSHVp5pWCuDUeTNg/qVQRTqJJBAB+ApnInlMUHiYuF73Nqb
	vlzKwPmJGdEUitV8rWhjShbbIth9Ld0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-RPi4IiFsM7-6fbXYIt7s6w-1; Fri, 29 Apr 2022 16:51:46 +0200
X-MC-Unique: RPi4IiFsM7-6fbXYIt7s6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnIhU5UjrGJs6T9sthYhioRuKOUYkgPgaOtx5Wxrr406qIASAt11exxC0AtTaEzeHDFiKmIiPlN/gEQjhtumKS2Lo3QXB0MZXNvpVE3gHtBD7jQpJUm8t9bXCFkN3tnNp91TUisvl0in03tfwCTHB+rjwPfdynfwEqi7IPuiUYaA/KSlCK1ajjd8PBLdznpFoY4RFu4o5ZocZRuJKowDjmVoIPgU1dZAzX6lG0WADC/GF9TT+zgz3kNgV2O0TK+1AnaSjBiZETkfvAEdzCfu0hDtnsPEhie0y5env05cwgX7raEkm+bhyk6LrE5Qm9WSTf0Y0lmkkvQ49HkCLQzr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWUTkrze5HnW2Xp278t0FXuaaA2GHEYLz3XRVww/Pj4=;
 b=VQaQh4qQMQb8mkkRPy5EYrwA5q23LEXM+799EYn1pdDw4AxSPNz+nf2CEsw3qJBaDx2MivGq2I7lrLQOUZwK5rkGi+Nt6Sdn2BiXOxOho8VcIVYBBDNyJ3KxPAlysRj8lSDnoRIHHfdaAj2qUdjr29q5q03grvqlyl1L1PPNshA0WtXp5FENwXBAERVBgvrmP4faKHHgHFzM3efuOaXmBlqtVy2itdu6P7yJFW8pxcaCO03S1WNkuLmAdiByrD1ccQEkEgQTQDQcSZl2gNFez5u+cMJNtIAWgs985swepgE6mkgKBnRR57vp/fGg432kc6tEImPCixj/g8LkPdCF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 14:51:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.025; Fri, 29 Apr 2022
 14:51:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/3] mptcp: add subflows array in mptcp_sched_data
Date: Fri, 29 Apr 2022 22:51:57 +0800
Message-ID: <c1e8b41ce01678189c1b5d51719df3c75ba881dd.1651243739.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651243739.git.geliang.tang@suse.com>
References: <cover.1651243739.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d8028d-a7f3-4d82-6a8b-08da29efc823
X-MS-TrafficTypeDiagnostic: DBAPR04MB7238:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB72384CA18EF1199D2497DFA7F8FC9@DBAPR04MB7238.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8QS1hVCqrjz+6YXN71cKjDORiaOhFKOfNj1NzYFDQkYeuyh+hvpLRC74mNHrnpam8oAuM7m4bQRShLvtqxCj04Ljvilf+DPIiW6DzbX9ayXV5hf/6n4K/M9eW9swB9OSn/iyqgZvgsR/2ItsQhlBbDSZ0M0tIpCVFcwWeWYKYJe1znbPQUsasf5aeftcZ+UImeHUGavds3RWEjDDzzjy1vO/T1gU908hRwMfPXwjIR9dHv/brngmW0Qx7HgOQl+5NAAmc7fgR2NCRpLecVnMLkkj5afNGmv31YdXVcUZui1BqQNVmjGkRdsr6TpoEmDc91s6f72VCeaVdXls1xfCaZS0RzapwhiPlELggwBqWH4TCF7ZurZDba6wXDyaEmp/kX9sXYlyO5xTphZGdmC+gpKXj0zjopAWycgONYFCzKM61RFrjbLhVS3ZHONsXVJgaqCf6UX+0N+CSRtx+e0GHZZHJCNMWWuPqn2pCmMlzzaSe7RrNqnvRXjMWVSgIScmx/3FSomGeDTiDxGqkOstTdPRPGk0IJSurzsbDci3anIM26YtMCpfv+Ex9aPAUhNnHCuedJ4U9sVVOejIYtms2W60qzlvoFuRs4gJBL4Zht2xCXws8RXO+oc6+H6T27JtjTGQiTEkG6sFwBI0H8Yhe9u5fQ7c6Ky0RZ0APQmvplRLaWs69GWICzlq7GAloNzLjUej6UWzzKlXg4jCeEXyUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66476007)(4326008)(2906002)(508600001)(8676002)(6916009)(38100700002)(66946007)(6486002)(86362001)(26005)(2616005)(6666004)(6512007)(8936002)(44832011)(6506007)(5660300002)(186003)(36756003)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsEZEJ82Zi74QZyO/8Q8fV4sFsQPINHq5Uqnf0m3+z4v5JmVbivZi72oL6YO?=
 =?us-ascii?Q?X009SUfqXg+bOE540zq0SjCrOvtcBjtAtNyURZB6sCm89Pfy2HHH3nBEO4DQ?=
 =?us-ascii?Q?t9Wiy8y8uL4c4XjbLOicTCNX1YOo9GqRg5x1i1i//avakUB/UK3GYPsDTARJ?=
 =?us-ascii?Q?IXkAhiCsM2k98Ws1uuNRxS5f5u1RRf4pglTYPvS08xsEcE1uEsi6TTMk32Gt?=
 =?us-ascii?Q?c4Yd8zOPWoD/sYLZJnxEDjj0gTSWVmpFeo1kCBvmoVAzyC5D3IyW4/GlptZU?=
 =?us-ascii?Q?UYb32NfXpYeBNK9vU7v/cBybNwMNrYxtrYvLWH+VH9mZgzg5mG4CVIZPCDPc?=
 =?us-ascii?Q?MawJarjfNWNBLsEfgeiSVkiFScY+IyX1++rTdCPoOGWcGuEfSWhMDPgz95Gh?=
 =?us-ascii?Q?/tvBjgsvYYCc3C5yB4H76uCjd6fJHMZHgVFDZnt846dq89JqGWjmQO/laomC?=
 =?us-ascii?Q?MYbs/8iff4/Lt8q9I/r60k3naG4VAkn26gZATHZulg4pJhExLHLB/Fj9UZzw?=
 =?us-ascii?Q?/ytIInJ0MCLOmuhN6a9qNqg4QYlIMs8Ne522nxT9xzH40MG78zfcFgaFhXBz?=
 =?us-ascii?Q?quDgpA3SW1XOug9bamREybmSd5GKVSN9Tx7Ahwv3sHwzcPeiZLUrKUpParqC?=
 =?us-ascii?Q?KxPHTilWucbeGB1zjCGu93v4MQ5y7+2+U87ZEi1tpibydTxjYiqEDI5O5KC9?=
 =?us-ascii?Q?iC+XyaVtTBWoWo5VKViFeIy5egbehGrEijAgnWJeD8E94jK6L2GRjBCJT7dg?=
 =?us-ascii?Q?9mnhYjGLGEIbii4v9jv9MXNzQw3cvrqSbKy23i8jcuAu8GUhS+mCRKsLM3pN?=
 =?us-ascii?Q?GJymiD9byigK0qv5FX527C9fAOwNOFxop1Yc2+sQvSk2Xh9fFuk1xFcyWC9G?=
 =?us-ascii?Q?tBJrtH15gCHAYneEDSG/9CXAmxvFVM52cR92L2H4wAWgC4TgpwOXEAK5M2M2?=
 =?us-ascii?Q?dkg9ze3jl7L0VriUEZe4hcGwWu3fRGX+ZkdgqZT7bNePkIRDz5+k64ajZdT1?=
 =?us-ascii?Q?3lkFWDKotF6RXSA/z+8QsrNJhUq+SJWqP/AupTnmJ/88JkW3ukR+qXSYlInA?=
 =?us-ascii?Q?x1Ljnwb69ieQjUdupwqx0ZT4NM9R+RrtI0fyjRnbBq/h02ZCQxnMR0exblTE?=
 =?us-ascii?Q?MwamMKOvhES15FRCrKeCIjQR0fUdiCM6N6NCdLb+Q0o7AufHhMajy8D/KjGk?=
 =?us-ascii?Q?vuSAiJjX5e2IolCcxkOVgoY3bKiTm2+BjTW08G0ThderYfcDRzNDHYgRjLj/?=
 =?us-ascii?Q?mW/4PaMLbU49Nhw/aJz1Z+ezKjmskBsSH6w/wIPvd+TZ38rjS/OkJWxe2DXb?=
 =?us-ascii?Q?WsCn0ZojqhZXjJm2zX3g9zIhyD40SG6pj0aWZ7h0fmVKx6s9+1BBmTusiO30?=
 =?us-ascii?Q?QYRjnaedqyuAOcUS65kbq6baxBx1rWrWGg1Dhg0Tq+qPiu8LlbSsxbTr294L?=
 =?us-ascii?Q?k4YYQ1XAToRQuhvlPTWMCI4x0xVhGMLstmMQKKHMGuuo12rAOXhhtnueYtvg?=
 =?us-ascii?Q?spA1gWldtFN6s/VIdVhrgstYFNAg7rFJWuOqnnRW/AP/LlGgu8cutRq1eBeZ?=
 =?us-ascii?Q?xBqDNNJ2rnEvrb0uInjh1vAqM4HAo+VB/TsaTnM5soA8rDOKHXo5BR44iTkl?=
 =?us-ascii?Q?hH5sJmn+aEI7CdWc5yDLioq64vDRx/3KP/GdNZseY49EtsUl1l7Xt3ZIGAdm?=
 =?us-ascii?Q?LvabjedkV/AAMO3PPCacKO/hwZJe/IFHi06MgzJyeW0vDl0devE+DD3XeZPI?=
 =?us-ascii?Q?p9JqosJcWH/yWG3wqu583R3CczO7BKc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8028d-a7f3-4d82-6a8b-08da29efc823
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:51:46.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IZRq9ji30aR3FzeWpq4/hX4RRxPbFHEh9/iRcjfcpCquJeyje2y45GGVx1kdH12QAJRmZ+hyl9+6LVmLMnWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             |  3 +++
 net/mptcp/protocol.h                            | 16 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bea7608d72d3..1a48e31f3ac7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,13 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	u8		subflows;
+	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0da2a91ad197..95a65582f1e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -993,7 +993,9 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_soc=
k *msk);
=20
 static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
+	int i =3D 0;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -1007,14 +1009,22 @@ static inline struct sock *mptcp_sched_get_send(str=
uct mptcp_sock *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
+	mptcp_for_each_subflow(msk, subflow)
+		data.array[i++] =3D subflow;
+	data.subflows =3D i;
 	msk->sched->get_subflow(msk, false, &data);
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		data.array[i++] =3D NULL;
+	data.subflows =3D 0;
=20
 	return data.sock;
 }
=20
 static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
+	int i =3D 0;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -1025,7 +1035,13 @@ static inline struct sock *mptcp_sched_get_retrans(s=
truct mptcp_sock *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
+	mptcp_for_each_subflow(msk, subflow)
+		data.array[i++] =3D subflow;
+	data.subflows =3D i;
 	msk->sched->get_subflow(msk, true, &data);
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		data.array[i++] =3D NULL;
+	data.subflows =3D 0;
=20
 	return data.sock;
 }
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index ee07caf978b3..1fe3d0a97429 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -7,10 +7,13 @@
 #include "bpf_tcp_helpers.h"
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	__u8		subflows;
+	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

