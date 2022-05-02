Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA761322B
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651534146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+4WMBUUct9AGZ+ikzlOYTSkDS+Rf3eepBqe4I17650=;
	b=PzTR4ORlcuNVa8uxKdTsUWhQdEuB1tnSLbNitUdYjnKKDV177TB/a3vvwlGkmFSAH9yjeQ
	UI9L//I6iaFWDCBHd1hW4mSNBf+wv27qT2bL3zbSh/fYiA+ZdY/nbGHWQIuK3e0o3tepx8
	OgeWsfhIuLxSgNqs0Ch3ErSQIhPI3rw=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2171.outbound.protection.outlook.com [104.47.51.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-2QypOQxfNi2C1V2TaxXctg-1; Tue, 03 May 2022 01:29:05 +0200
X-MC-Unique: 2QypOQxfNi2C1V2TaxXctg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccMwyzqz0PyMG2AoUC6/TNmpQTMOpD39OBUr/+rKxTVPRftui7Pnt5Cn1K7CW+F/5frWKkXVuM9cDCI2AMBoG5dCWk8jTpTztQGuYW0ECCtuH1ln0r0bwOR1Kc7+kgZ9STcdjtQPJ6U6MkyNvJ4Ynt98pzc2HEY9Hikcfp8gESJBULQdq2cdzv3twr4J2M2zhDvx6ihWT7x8imQokN8+3xPxgz3o3F8cTk+0RQNN/ax/MFBUU4ID6lW2FjQDRkFLoRIJFBsNXswwhxeNRaVSnxOT31DJZf2f2lixyMOAo0CKko/ZF44RSDT67ETJqlH7E1gXv/Cr65hyBnigtN7knQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE9PEiiU7Kl2nVlPNUSEvTJzepds0nGQ2t1mH13eYEA=;
 b=KrGdUyqJx1vE05Z1o80V9Lgj0RzVJAgzeqHQMTssf6zIVPyXbO0/cTiyrN/I//Na0rfVKPUJCHyNOUwUKdaJfxL8FGpyUBPt6PiFrhfJiSKDDibIa8M7Mmw3kmXhnwozy63eQeMkqcZ9+uQzZIYfMWNikmXxvPbinOKstg21nyd41w2MfHIBbwobBxzlHWkXAETtQrm8ZZCTnMmVvX0sz98ezLvhkRHvmXBKzOzhRmlSe786cgRZN1p/OQyD5m5y1gBD4reqMbxrO2eyl5r/fnGKyl3fZWeAMiu86+djHneMzbpRmpsTqklnjRr3cgjZ/m52bi02QJSqgwSEDENgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:29:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 23:29:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_rr scheduler v10"
Date: Tue,  3 May 2022 07:28:31 +0800
Message-ID: <35def90cc8f78baa8200d67b49a7a438ef6e8bbc.1651534009.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8a90b97be579a420d37c45012bbf1075db5a81eb.1651533987.git.geliang.tang@suse.com>
References: <8a90b97be579a420d37c45012bbf1075db5a81eb.1651533987.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f87586c-fe1d-4e9b-dad8-08da2c938bc2
X-MS-TrafficTypeDiagnostic: PAXPR04MB9256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB925670AFD63E3FE41F5DFA36F8C19@PAXPR04MB9256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tLGxt8AGu4mpZMb9zhWwdsIBAdJ7+5srIsnrOsLWo65M5+a2bqizT7mo8i+t/ZCaL4xdqb5t0l59kJdklaKb6R5M7eWPpfJX2tCt+Nuw6DTWyRdfFUZ74Jk0uu9hDbyDzerjtqDG4zhvkyDO4HPLZopobV1+oY6yzXpWH4TJ5P9BpC70edzvi66E98A/TuOv/63B3wxvHKOOU82qVTZCn7ApfWkTzSzJlECzyNsfVqRJNK+LkjGo999kvWE13BwmBPaUKezsftnKWc3PpahLshLHmAslIXFR20JgJjrPSq0VwQs7RDzz44FbjE3kpIw8dH0+l1ftjU2ocPTXhb+kejFQHTy/MBYZYjLdvLY/ZB3uFNNnLt1tQJsRPvEYpooBQNdw2Vb5DkuyZek62CALhWpkrfeYGkZNgNTJTPyFSaE0QEtXX4zUZba0J+UGoa/kIYN5UNSdWPMQ/Cz0I3rlH0FlR7F1yUte4XCOaeNfAEno4a7pbFYA0jZP7/rZCMjNVLQNUBKv/1hk+bxfhf2F5DLeFAN0GeAy5BhGbXKIMWGrF4wLrcq0CgAaxxmtxU3ZAPOwqBTcj0m0Wy2+lXyLdfyDs+qx3NGqnKcfpIfdbR+In8jvUByudCFskoDrzzHWARJIVV2B6a3kIEb0CgQmvxCqw3J9NzCfgH7MXKZEWK14LAOPBRX6OBhbIqPJyyCSQrmJfbWBNXakiRWlMB2FmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(107886003)(186003)(5660300002)(44832011)(6916009)(83380400001)(6506007)(6666004)(36756003)(2616005)(6512007)(26005)(6486002)(86362001)(2906002)(316002)(508600001)(4326008)(8676002)(66476007)(38100700002)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2YVqtR4zGo1ikcYdIVDEODKmiogdE9YPvgMVaoz/CfoAncJs0tXNoQyw186?=
 =?us-ascii?Q?TQPWJF5WEhxes5+Yjr1mPWOmzsH6lkFGeoJagHlLLwUxzc+X/xf6Da4waeZm?=
 =?us-ascii?Q?W3NHLf3zj2qwjVW0+IeW7AyVtcnyR5QIYAl87ATRJ4gjlY8PHPGfDgY+tAfT?=
 =?us-ascii?Q?n+ziapwzDTQweA3BVhc9bH6sPWiSkG/ko2SYJFijxn60ml0q9zR9pSAINC2g?=
 =?us-ascii?Q?1CgfPQ56BoDmVtybpExfFnke/dPBX9c4odODaUBcZHIOj89KA8G+Dhh3bFv6?=
 =?us-ascii?Q?eescjCwm0Bm6D2ic+IM8gSG1HJyPQ76l8Y8FzGCNlqHxURRbwCTCxRhIE3Qy?=
 =?us-ascii?Q?u1/pdedM8HNrKAHQEuJQ6Xqz1EqzGEg/sss7UbTxN4xKazDhb+yc8dqO5TVa?=
 =?us-ascii?Q?mjeWurUROxnlraU704XdsqK79CYEveeDIFP3yIFeDrYj3jxxsmkHGPgdvx8w?=
 =?us-ascii?Q?KUiJ4q6571I5+RfEZuV+Kk5CGCZpm6NOir3VyClQhLqSwY6kzZFOkEAk8mgG?=
 =?us-ascii?Q?4381GKnEhbQy/AHXJyt8h7sj8i9AkBq2Ev3hLXt8xsL6eSbBIojRuwxxy2R6?=
 =?us-ascii?Q?8MdJ/O+ZDT8w2pLhonVO8lLFP2evmM/5QGYxgySAQ78CmxIxGYjglJzgkcti?=
 =?us-ascii?Q?LtfykcOn2aaVKL5yaRVYi9GfuAP0Ig+p3+Ib74OzpZHqn2yehOQRT9HzkE9f?=
 =?us-ascii?Q?K88hDuxy2xovWi9jU9xhdC2p3qAFq24pB7S4Rb8ekeyyglMx9KwtMtJOxjhx?=
 =?us-ascii?Q?9RuxajsWP0qIHDUDqaIWwpb4qa1jdHwMrlWweFgNjpaFuonm0E/uAMDWQZpE?=
 =?us-ascii?Q?lPTaLAO099QeCoXyod/zQcZ6lF3uKbQkB29HUwXTYG3kaGmoMTyNhLA5VLmn?=
 =?us-ascii?Q?tl1q1L1CZnyONBA3WZCOl4UUHIUFCBNSrirchetg7UvmKcdWJZ2ouZlbCWh0?=
 =?us-ascii?Q?RXNSiu0vtBVk46zS/aDL+5aeBQjAxLI9tQ75Y67Enb3CJOVRuT+STY0+nmB2?=
 =?us-ascii?Q?taN6p4ZP3Osvj/Ot9cTeLLlNtS/pQQ3x5eIlnD5JgjHIMTpXplCGoUNWSa8M?=
 =?us-ascii?Q?ZEq4ORCpIbYLixIoeTl7pzOMQlA3px+0UwWOhiJJ3oX8xtMm6oFkTPDDZ58v?=
 =?us-ascii?Q?ShPv6XoJ6sxiOeQ5z+Sj2XoAv34lhhyuWJW74+ayAm3wBXbWWGZwv91w2co2?=
 =?us-ascii?Q?Jmawx9Mt9bgdtU9FWb22LMCP48YUVhNIz0SNAWavxle9Djv8Nqhfk41RaVhS?=
 =?us-ascii?Q?yIwPAxlvIQItuiJkzVupDab5Kk8rQd8ag1+FlJJf1tRAY/QI3L9fmAg7s3K8?=
 =?us-ascii?Q?+yctuT2Wh6RjMZSZP0fHLM48XZ7qqOg8XVoDklsB/FzkNDBQwg7MYISTTmZH?=
 =?us-ascii?Q?9qDvCz7JtvcQR2zdKwRNXWjGRowCMAyX6RezxtCrdczIeGws4EcbmC34pUkp?=
 =?us-ascii?Q?4N180DEMJ8Sfzt8eo3ErPWwZWcAw9RBTA0HcSbsgL80oFvZEKwdnAk4d7okn?=
 =?us-ascii?Q?cdc+c63ah8EIuOgAhVh/286zi/ZkwAOkSvr9+K9C1mizTXcLyq9KFEh8PCd1?=
 =?us-ascii?Q?zMpWQSFlpA83gIYtgTLJmpdVbsaI/DkdHXFCWmaa1rCln1/ytSij5zQnLQFH?=
 =?us-ascii?Q?/wusD6rmgJ44oaBi0Emb48o7+w4azDJM9t1RSQpNzbbejeS8YllHFcpgsP5c?=
 =?us-ascii?Q?kS6+RrQWYC1rcjEWQ6wnvAvjJbDBODUDgYdI6fUf0E0yAQ/hxA2okt4jfheU?=
 =?us-ascii?Q?lpY1gjg9Bi/AufyGRvPNWZtdXZjT8xM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f87586c-fe1d-4e9b-dad8-08da2c938bc2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 23:29:04.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DerWvinFbTS6yCJksq/sH58ssM8IyRKZ7BkrRIsSKFsvbWEvtJqc8aQVLzh3YRx7uHEmSWjBT8uI7aO5eSxPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

Add const for all msks in mptcp_sched_ops in mptcp_bpf_rr.c

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
index 3619bd622b94..fba3394ac027 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -9,16 +9,16 @@
 char _license[] SEC("license") =3D "GPL";
=20
 SEC("struct_ops/mptcp_sched_rr_init")
-void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
 {
 }
=20
 SEC("struct_ops/mptcp_sched_rr_release")
-void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
=20
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		    bool reinject, struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
--=20
2.34.1

