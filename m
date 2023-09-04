Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE77E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1TRGpTskHY8KLSQHBclzILT4iVDxwG5f4T+6hIfy4/uX3GI4VyZtzSyn7ZHAcV5bOiPwIivnGfT78GMPTZOSrG01j8wOcWeiKxeDWTanjsBXf1Qba/LlD8fGkI6oGhIBhj6UM2TENOgtKLXDg6NY0h8qBipw0OJdUe3Q0jM7U1xGqFroR6h0JygvxEJj+U/DYqeZ0mmgvydlw9Ei6u4a7INi1CdyE0VYd+gZb/6fVlClgRfrCXWbv6YPlG+R/ZLzG9lYo1v3MsZ+7q+U0gL2zBb9PuvBCfhTZaT+dq9YY2IDP7bxioDFWWBX6UKO/qAgh/CnmFbOhOtX42y8PpXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk7Zm8GvHizeVmRaRIFyP/6ttyFVRxssFvdrVHvaPBU=;
 b=fnrfnxzypkqJDlErbenulTJIyIyYCTBDD5OQ4AtJoI30nRovE08vuZcGXdqPkrXvUarI7SUAuRmpar+cZSf3upIluHsc75lcXJsBC+xl0El6J3CtXS4Omyd0EpeC+aufVuoIoF7X8yWrTbhXwVzfoOm9kY+XnK0HVyaGqeUBuGLKj5Po/rhPJi1kTRnqjMuHseS0U9CzUusu/V3zbQdylBi9LaP1cqrb1ECs1KElKw1WLeUEmrFC1lV+541lHayqDvLjNqhh58CUAJBTxzdokwRAGGtYZG+aVdUoXmyg8/pbL0hba0E4WzLPMv/qHP/QbMlRgOvcKhwpBF+w/brdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk7Zm8GvHizeVmRaRIFyP/6ttyFVRxssFvdrVHvaPBU=;
 b=3LowjSZfvSBxEN5wQ4UiUHP8byzKUt51pHjrBbpRXnu/Nz1rLQuFvPJWBHtJOyrGgWnsLDifEON6ZbltMP29NEuDYqnDAwejXNhyMFWeTwfyH+93QNSu4Li+1IL68Ue5i37FalPlDRqOpwyOkhNV6UH5VkTIcJ4M2cNIkj6wRVqI7wZdGN5xvmAMIEvqTis6e5SEsaI2j7ynEVhg3QSIrKP4gEPTOxBYyp/inCVdHWAuqq6aMBenGi6ankPbazgzsqHHpiyOs/Nt9siSX4O824kv5TSDhOCwf2gOWzz+E6cxkRhvhjlxdbFFndIKwEBsueMjU8QeneJz1z/DZ/h9vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:35 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon,  4 Sep 2023 17:39:22 +0800
Message-Id: <250c7f3417f35ac473f0d87072ba9792787da782.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 106726fb-ba46-497f-6e0a-08dbad2ad96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YRtyXlYn/X49cCT/EWPMLJHClI842iNvZr8YMUYoE8PRGSRwYnVRwIkU2jPdkDSP+6umP7ffGUrl1KR1ld5t86wwt4NsO2GLhqF6P/aslVXMCbeyK2CEk+7v8OMFW3IItptXkDqQ4wBdDlq/JF3sprTqzSQlaDYhrC5nk15lFfs0EABsI3PxWW7avQ+3ncz/8qAa0WwaFP5R5RUH0oN8kHhhUocnKnnsZ0FGk9WPbDFJmVWmdohP7kjmplbVDgPBPhnorMciDmsxj5/T6/Fga+3SJw+KlfZprkrwgexm1v+L0xFt7U6M2Cod7zHOTJW6R1Z+WBa8l7H1C6MkTazkjmGYYCj9uS7s1MQ9kkZ2qTiGMrOjGcJ9bU98efdqrJ68ops4V9b1kD1HFCFLLFDTmO4KLnGBb+K/BQESB+BSDUJyNV0VKjvjlzXiKmdnnRiy261rG+sD6HAV/RJtJTjCnHmWSmS1MYnBRucUfUf72HLjjMQ5TO+Ttbo5zdPH0ifcES3O/ZsoqU+mDAuzmEG/uewm4Z3Igl3jXa95jeDTCqEeXCh0d+gjMubUNIrvtMq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cz/Dpwv0ykuE9/E48tJexRmqNmUuEOHHCBK4i5gz3Owluh2kvgcGYEI/Ndv7?=
 =?us-ascii?Q?mzjmj8e6phhw/u22Er+mBkNkHl5qfnX4fl0+W53J0HZjfc3+Jfpoyr4lQqd5?=
 =?us-ascii?Q?Q2vS9+BMxjYeOOKL4ZYpYvOoMltfnekChe4cIAOnZ9IMoxFP1QN1ZROfQVO4?=
 =?us-ascii?Q?qZ8PBpP3kOfpm4lhAlWlOpsuHCSCvNA2PWBJ6MoZHsMRFASrazCD7X5HJxZN?=
 =?us-ascii?Q?DopDFP+cQ+CNSI954hTp+cgtxEYr7vPq+71n2VN5zATEDR5IL/ei6aL3COSa?=
 =?us-ascii?Q?HGmZ7Mh5FBHMJ63Qs3wiur6HXmFdyG/Bi93aOZBsa6xsiXGK1TU71s9Pb7Hn?=
 =?us-ascii?Q?YJOaMLy46Eln2du91eLpkgQ3NLGLpsRwr+lpQ1WHbFYz3N3yJOhDo4bzDmvW?=
 =?us-ascii?Q?jzQ4z24qkECEhXpnKIPqbv6Cyr3nVTreDCgZnh0tQCbwdB6rhHHlI7Q0P/xH?=
 =?us-ascii?Q?xHagdaJAoFSiQpSyR7+2UFaaupnC/lHaGOv2qwhiPwSI4w37hUzcYk7Z+ZtU?=
 =?us-ascii?Q?2Lfc3kx0obopqf6OtAYdPV8QHuCeTZtrrDcPqnlcF/yNcim/h/pSJQg+1UG0?=
 =?us-ascii?Q?Zm7L+VfzpWt8jAbQzvkFYciEArgFKLzGNDzU9Km5DPbQUjeeDaZZ9D6GAZZO?=
 =?us-ascii?Q?w6u7Ifhm7Csln+dcU/1k9EodKtNZZfh7d16rF4tBPVy/zBe4ShrAaRUosNrw?=
 =?us-ascii?Q?05IMw7uiB10NrVXkymjXRxxNswFK+gb1LMawJsUZoWcI5t9UO4BwBlNkm1EZ?=
 =?us-ascii?Q?mmzD3fDxZlzP/JXfr0+GBT3vm/3sqEW4GTKgowbbvRd6ziqk0tWk7mmUlwAk?=
 =?us-ascii?Q?mMq9Hq4GU/IFsHQWbeD2HNaDRPj0NmITSV4f+S9RjnNYF2ccYdq1polhPNTT?=
 =?us-ascii?Q?nG0GLuBZelydeni+FFiGXh5eDHpdsVBe2hbSxFPPEhMikaa0xICgBhkjN5xC?=
 =?us-ascii?Q?RmEcJMiUsVRLBlcFQmuRB0hboTsWDAfsa9xXzs9L/YLndivDLw7C+efeXWsc?=
 =?us-ascii?Q?lEixVTK2jOghyIFJlXV6jtX6Fj0Qww+yEJaQeBWoBZxTSNXHsa0LHUQcgU4E?=
 =?us-ascii?Q?uGSO4/+B20QFmJBofjMMC1AlSE7i3k/fZjUaLXqEm6OmfBUyv5ZayzqGRaIN?=
 =?us-ascii?Q?DqgNHi4DojgZVgRydWbcZ9w18hrcNO5q5OqNXZZXYob6WGLgjtFsBQ8DwBmP?=
 =?us-ascii?Q?poSso7WKLjVxXRMqWrkJsZaJ11VN4HqE9B7l7t2yfK1Jcz0uTdO/ItDnb2kN?=
 =?us-ascii?Q?793JzKOq7FPU9gnC7IlHEvT2ec58A+Z8GLKifwkG+P0yh0tpcsxshxtbPigI?=
 =?us-ascii?Q?v1V4BxB44FqD9tI+UxyEavanbjFhUh097wFyNH2bLNJ8xOr9RXNUwbxEy1ou?=
 =?us-ascii?Q?V1mqzmRo2Yna+QHpKarJjeR1nil/SUN22w2zdxjU6jzjB9PCbztJUh/mLsvx?=
 =?us-ascii?Q?DRPNYT2kiNO3APCUBwNdkdX9Q3sHmSrN02mxTx29uRftSxxRgUgYgmy1EeEC?=
 =?us-ascii?Q?frYRVcXvwaTvwk56uZwRHDybY3K2I/5IXSglO+xaxoJftZPV6PSvtw+E3Hmd?=
 =?us-ascii?Q?RB/UGtDWx7lyf4A5XA/1onUZ2uFeAUDHFuMjlGRPTrS8Ccrlxuiq8lSQLYgm?=
 =?us-ascii?Q?UZxTnQt/1Ga1fqZILaxh0bheKg4O0VQvDpHENw9n3VBl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106726fb-ba46-497f-6e0a-08dbad2ad96a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:35.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QHu1y74rBx66ABTy2/sxq+yEK/oPhnF5PcPBuH32mJ/rBOzH7x6R8kH4OU4o2CBcD3CLw/3gnqW0XHJnJfLzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Add write acess to msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 18ddbd36faf3..b92c9014ac2c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,8 @@
 
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
+static u32 mptcp_sock_id, mptcp_subflow_id;
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -47,12 +47,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_sock_type && t != mptcp_subflow_type) {
+		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
 		return -EACCES;
 	}
 
 	switch (off) {
+	case offsetof(struct mptcp_sock, snd_burst):
+		end = offsetofend(struct mptcp_sock, snd_burst);
+		break;
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
@@ -60,12 +63,14 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to %s at off %d\n",
+			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context",
 			off, size, end);
 		return -EACCES;
 	}
@@ -125,12 +130,19 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 {
 	s32 type_id;
 
+	type_id = btf_find_by_name_kind(btf, "mptcp_sock",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sock_id = type_id;
+	mptcp_sock_type = btf_type_by_id(btf, mptcp_sock_id);
+
 	type_id = btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_subflow_id = type_id;
+	mptcp_subflow_type = btf_type_by_id(btf, mptcp_subflow_id);
 
 	return 0;
 }
-- 
2.35.3

