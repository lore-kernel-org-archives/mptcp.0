Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6B28C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBhrWEAI4Ux2A7kwfA1oY/Z0ACMi0BPHBwnRmnpBNzbxp/3TV73iwnS8CuKZCzVVn5ZkyyF81upEqXZxBV6qIVcIvcOgp1Gnj3HNXfAPnripEXvbr+J3nYsgz75kCqfEulkndt4NBIdg3vlaRwoBl6tEAOa2uyM+i+05x5FyWjwwWqqJesum5oFar8CqTGnnjcd+0OyRrnkddU/plI8hOWv/iVvpvJOKgKX0k37+s9VG4oXtWms/XZjZHxivkFfHCfTcdAWrDi4G+TJPbCwu96miChnUZTbjBcqD6NIvrIaclVw/xRicf6W8gvvnLjlcHgutr/WTRK4E15SMDS93Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=DFqCjNFz77OkO17rrRNRoDLIaQjF3ca0Ph8M8zq4rXqa09PZY2He+80PpRSWn9jZ8mqSmeMZxty/5zBDHtcja4Fch6thAU5UYFgFjohD+Fql9OkRMuNqk6DpepuzxTPTW5pWTxTmFfqQn8Q6Sv9FOICOhNG6uzzAC6d+nECFXmhPViNVqkv/sV74Vs6ZbzELf5ibOy/tu1WwFZd8p0Mhp9w7KYQHSi3SU/XvNo6bOiQAd9b/93BfBTM5VmG5TluH5iuZytC2AOZhghMCLFFrpBwDAdwfZqH/PwsSa7htxSHD9mjIQJm3S27AXdTRqq1ZxN7k7rFLJYOjofqA5PXL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=b3fiBTpJKXMTZd8SvhQH6qKsgRof8NvsMT+yWBdXfODKO9S7O84dZcNzxhv75cwNMzvdrovQn2yhpNPE5PkCrZ5DEW/bBkBwUWlxpltBgujMbtMh4jdzKIRIBvqCFO24VvJJbh5j3RHi1t38LTZAiL2cW90sGO02lYhOJ+dYJ707jYAnXQ7tjghlPiu3iuRL5b+Q+gxj7dUFHWQ6NtrZGqBJFfS+7kJDVQ5L2vFWw9Ghd9FKOv6Omg8wGjp06MTgQjxMbyUNfZFugAJLHU5tUQw/HwzQcZv57kjRBEtUBfBGMM7bbVrffcell/LHGaj+kOouRSGvWDdWn8hlGnl9Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 09/18] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue,  6 Jun 2023 16:59:23 +0800
Message-Id: <9dd59d8a2ce7c6b0d521159d461e61b2a09bcc62.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: ec06b022-e208-41f6-d901-08db666ca2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iSF9gq+TFjP3qVqBSz7kCu0Xqm75Iv3YlztnCZbAkPj5EZIvMMswyibMN9gdv3QXyNgfXohxJzveHMPfOD81gashHbuTxCfgpXXakVTwLVUAieOfVogcB5FbotIVRCU7k1ENVf+iSANq/xPEAxp+2ENtq1oinYFNek2xnYkIcQAffNEqRaXp34cxVs+DSnJBgeuioJyzPrzWx11YvxdTTKeXuxd/1yfXW6R+N1Dor4AQVEewxPMdxsu59bC6L4bo5hrFE6o+HHvMcRbsYHH9vYLeQSs8n6ADXK6YHZ2d1/H/5csjXkSmrMPpt3DN1mwUS4ryaIOvN7d292UFPCIyA7xKNxBvXStizbomHTRZcSsDRoAl3AmNG4Bn+OkcGg2bsEBZaMZyw+F0OQrpjsqKcYE0846FCXM/2upVJl1CMr1Zs0xog1dyCuFMJgLgnsnrESR4dmAv1+6xJfvmFZ9KhCil0Jx7brJzDPy0XS1T+rdp4FqYotZkpihVPG8C/PvOYGP/Pz/xWhSTxxuo2wNZJwf3Qmj8VDJRYm3qyG4XyuvFbYGL4FL9eFjeGos9cytr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QKOfSMm2GbwcKzSWn21uhOHgjEiDH700ZpRXbQW22sn+DCCMN1AEEYxCJ3l?=
 =?us-ascii?Q?rrbYofb1kCXajc98oKWXKjwDGdEqnIdg3h/bJzxDJ3tmaHoQfeyXSHhiTgK3?=
 =?us-ascii?Q?NTbtCGUcu3F6NAUhkGTR7QwCE7k0+S5NE9vCFsdsSN5paLJdhlNIBZNjSOs6?=
 =?us-ascii?Q?stdVZGfVjRlBtw0PthpHtGxeZqkkO4m72P+ox9urtzsbiIxHg+tklJqkn9oy?=
 =?us-ascii?Q?m3MLG1LFKhgVnsMvaXXzwVrWLE+Hm6zWVR8dQyB0dCAq7CW1UcAqaNCTASxe?=
 =?us-ascii?Q?8Jtuoeop78s2zkV9XgxCmFeRaRq3PZT5XlRE4+L8rtazyPKbCri8OC8sydWn?=
 =?us-ascii?Q?kCXZLNWhB9wJ7CjICmNUaLiUKQbyGC6ZRoTptRnJ3S2QOtcQUvuDQApGjqHB?=
 =?us-ascii?Q?6J33RoeJ1p9eNCMV6nSdeBQ5nhACq82GvuQXeMjQiPpCbhWvNm0ne9sfECc/?=
 =?us-ascii?Q?U+5d2H+s9BP7d0pQGqfH8CnfHnikyUqwcnYqHxXD/ohhVYVGX6OvoRMHKlwj?=
 =?us-ascii?Q?iT76gsR7L+tRnBCPhpxAETqo6C+HpG2lHKFnBWDL4SZ08zSPt/fHJzZSNyi3?=
 =?us-ascii?Q?UnoomtfjS7T/ngx+ux1zfcQQegJ6muqIbPVRz2cv7XRuzc/e5YDpngTdpuaW?=
 =?us-ascii?Q?oi6r1CG9RUntITBHh45Ds5A/8YYq5BmBZduCdfID+1XRFZebQh20Itz3cOne?=
 =?us-ascii?Q?WLA9jOt9sU4BI8N4xIc/R2wGmxi73KWKXQ8Wpu9YImlRSzn3ycYqF8FEtIqL?=
 =?us-ascii?Q?vBG/DQbfWXcDifoH2SuGr7p3bwCaJlkZEHa9QX1UYqcHbVfGcGPrKlH/zz0P?=
 =?us-ascii?Q?QP2n9H5lu8hN3zNnmfNZvVHTNb/xQJaXiXuq9sDDykjILWzPRcsZK9zLopKe?=
 =?us-ascii?Q?Z8BAr1QakKou9gqZ7LKgiaiD/Jnk9FD14mZIlpSaXytdtAjGFvuNe9RHuqtN?=
 =?us-ascii?Q?443afK0GBt5UBuLN5G2h5/JiWQ/KRLRQ9haNQd2QrLNlzBTELPQ6q/vCueJn?=
 =?us-ascii?Q?ZxCzbH4oZ1Ly5X0V1CMxYs3b6MjACdizlE+AEO63PoLxXsHd6l7la9Kr+pej?=
 =?us-ascii?Q?sgmf671mhwPs82q1oOoqkS59JIdap0o1lCeu69PheQvj6niTsSVsnOQMMOmN?=
 =?us-ascii?Q?6GrJ/if1w+/ra23S/Mu/vcdJlAhPEMReKLcaOMxzLvtRAp1OHNg8HEU6zQaz?=
 =?us-ascii?Q?q47TjPS/nbKKcRZVMSy3PXsAghmbLj7WipXXT3V91FwFIXXHxGnF2Lm9Z4n7?=
 =?us-ascii?Q?qpBFUw3TNPOHer0Sx6eYYIONuARYfSt59OOyoqiZpCLcHMn+KuFVjLW7HZuj?=
 =?us-ascii?Q?RMQ0eQWSiLnu1uFny/ZbeXcpLhPACURvhtPnpoj8hNee5f5UCCu9umCP6eJs?=
 =?us-ascii?Q?I4+OIvF6/dDR8kR95Ra7vk+CJrQJn2guYtuZgSS1qPzvs2ase1+LoQQNSZvi?=
 =?us-ascii?Q?DonDkpbhtVqhLNZcfa3myv3Jy2TExfflInpbbNzb8+ZM/DKcmK8AN1FxFYey?=
 =?us-ascii?Q?t9UHFsJYorwfLpVlnrKvS0+jGuuOY7EJIjWz5AfXFossbd6vrSlvNzvEfZzr?=
 =?us-ascii?Q?qFveKo81uAghU+uohiE77yrhn+JMPDUXublgE9eV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec06b022-e208-41f6-d901-08db666ca2bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:37.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7m644nBEyso0mpOLS5oosc5bvowRVOc2fVmOmDWEqLbKalGrrERczdTuvxFUTOttib5BzbAI6zAqbgdfIl/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index fcb023a749ad..dddb51a47740 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,6 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
@@ -259,7 +260,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..4b4141056fe2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -28,10 +28,10 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!data->last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == data->last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
-- 
2.35.3

