Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4746FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+c7Nry1BFVT0rkL5SjEmfYuYqdDOwTx0dLk+mAI9YQI/RXaKV8hAJn++e5FuMiWjWxRF2Zl5YWR9g+H1Y5shr0Zjgk6FAoJGjQxTi7ckpVKDlD02K3qioUks2scGqMoUzLZTsTyWFVuwRBPgITv/5MJG7HQs5nXnOXqO8thovC8GWCOqPLOd3VFhH/RCoahB8cmAom2dvRNPJivV7nfhbj0TrGdPBF3CzK5LvTSmkInBj/vQkZf/NNK1WbKp9JGIY4JR8suqqUOBlsoKmx9BCIGt7NtU61ERt2vpA+Y6bn8dxKyL1ehi3Sy69onrbflzwGMTHlI5QFjDUP44iTxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zUgElSwNCjjAISmZYaVHigKUA6yZyxLeCLBOp4DTCI=;
 b=f0in0sKjaEcUf5iesJm+0b2pptVStUfecOYEXISMa6O0OXLFVhVyGGEajq1sLRWbBjgYdG4J6N0alZDIWznwliFhsFyqNLdF6w8yd5kMqDUX+jgZd/daXM7I7HfY9bO++6rg/uF8lxxCrwaiaJxPdpRn8FnPF9zrT5Ah7uvJARsH5gnvOIRt0q8fxyoieqiyniYutlBACjU+LsXS0vq1QnP+d54N+rEhrKd+wEQk1RmEsKlrVJkxrxSBtzYE4XDSv1jst8AknFrgj45A8qlHzc8Wrt/h61QLOPqVgzlP/OZdMMFUMjEhMvbN6w0EHFGT1etj7iRbTiEkF2XTGgq/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zUgElSwNCjjAISmZYaVHigKUA6yZyxLeCLBOp4DTCI=;
 b=yv2xFmLMzidIIIhJqtS9PCiQ2f2qr1TABROcDqyRo16EYsdZuyEGb9kxCaOnQqKhU1ykZoA+hJunFp613wDL3Q7wzWF1Pnf9brQEJllnVVEm66AjWO7i6YJsp6RvnPRhTo46fRne0VaF56wF5eKbrBnlXA3OcitL5pO7ucispW21MpcQjp23MriSLpvIAo6CJxoJdISG7cUPMf4tpNX5EV8OpXiX01gmoizd7b8ynAMs8lz9W8dxxOIQysYcLnKMwc1KMH33a67sX8UBsLGXNuTCPai066HYPzK15gruWZTVWYNIHCcCVkuskgWtVNpxxgIzTQDWluGb4YndCMYY9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:56:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:56:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/6] Squash to "bpf: Export more bpf_burst related functions"
Date: Wed,  2 Aug 2023 19:55:30 +0800
Message-Id: <2a4f5f97d2c186d04651a17bbd230d8893679153.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 6430e6b4-d186-4691-3236-08db934f76f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BS235ouSEYcnNLHErW1mpsG9LoODv9p/LF+rlCl90ZSu2bh+8G2SjY2W/FWJ9mxBDdEC4Bmi9zGGrUjO1+InhfC6gCSrTs/TQCPoQh8QjztfjV81GBo1Q1SrIScH9W6zr/N52islazENKEcZYRwlKzUoeSio7GPPy+RauJmnUBg8u/kYbkx5s0ySz7a+X/nm3WJiii0BmSo5gCip2xIwb6Ld1nec89cZCp3Gm6zAs/FD/4e6gv1aMwjRqYmTg3Njh4TSaj0B2EdvFfq9GG1/o8gAgTvClw6fGQ+64KDGZTfjna/vSquhRbXd4NgJvTz18YRrjeLHT9t7fqvLJGG4asImWiXILPd/kwKp1MBehOv/hvXS/1x+48o2MAmQx78gH5K1i2oAwPG178Meu6S4Mtx16+173Z5H2u+2PJcuikYw0Ebb3wQcihCp5rJeqVKyg/Fs2ABxSXhGy/7QcjPYArHQyNBwLkxSHER9l4mEm9mQihb/TO4pkJEWhbRcHnRBaaMoCTVGbbEUw57+Zppr4/PZ0LRHO58C5T+oDNDR3e6dWzyzF4QztWm/d/HUDcqAXIleShLwv3mPplDA41lYBVZnfVsQ23+WRS80uTlziyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHEqg2lvKz5lIgLOWvrh15odBdjq0Cx62d3wcCqowzcjYEyBwcpFc8/OqMfN?=
 =?us-ascii?Q?MwyI8XnhU/4TtU6LTtma8mwLWUrpAXrD4KYeTcW93E/iiarIqs6TNsKX8zIn?=
 =?us-ascii?Q?l3YAiRErE+mBQP5gBD0PdSaiWD42sEnaVWtUA131oJKMACgc7idemW0WEXBo?=
 =?us-ascii?Q?6IIhgEt6t1kB3BMY1gXkjEuV3AT0VeAoPb9gCVSSmgHrekeYpc68GxzZk5dA?=
 =?us-ascii?Q?Z3Jm/ckUBxUMewpZeph6CNAKhRSaWTVyQhXpdq4j1j3x262s0Cqa4ImT3N9q?=
 =?us-ascii?Q?XD/UjKRuBG9LEsLw12UVTPOqnZZ5086yo1ZwrL9Hq6BCeCgSY+b6oWrOIsAF?=
 =?us-ascii?Q?Iu7NZpg6ZbVFha1kb/RYlWH7FXbq2TP34Fo8wUbf2b+VrsFBp6d1qtsKKjSq?=
 =?us-ascii?Q?uvZxUxjUe0IwIaL0EZNEUiBJK+PU/4o6UDFtBydGFiXXd2FK4gRRsY23FIay?=
 =?us-ascii?Q?PwaZr9kKH8NsNYu5xjL7aJWNhWysnJnaW3aCk4zfV5xSHqO6ECGMPz2lmGhK?=
 =?us-ascii?Q?FZb0Ek1n3EwlyePJbzLuXhL7SNyITCTqpj8Hl3imAEf9U5gVeV5CAPHnaWxF?=
 =?us-ascii?Q?A2mMXvX6zqnPwNozyTSRPnnSu7oJT8xQgEmrj3XCN31ZnRBNMPwixDWU8W/U?=
 =?us-ascii?Q?IRjta/3b/76F7lw5NAnqsvFA6sinfuRFuS6XNLbcYK5Fc7llxQa1jF0CvFc3?=
 =?us-ascii?Q?GS1Vmfew7t9sNSq0ieHLhYUrnJsKZB5/oYYrD4zb5opoGKGtTriYPE3RqLW/?=
 =?us-ascii?Q?XpsKtLe5kwQmA6X3vUImtjHTrcDKIdkvvZdzISpQinjUPgisa28RajFWLzvc?=
 =?us-ascii?Q?WFKV7Byu03m07lcmYPw8fJqdMUBXP3536yAblUVOK6TQpx01TcQ6NMNB44mV?=
 =?us-ascii?Q?HTMJ/8AB136Ielqf9lZa8wZanTtqf/WNn/7K9LVgsOla1O/l7zlEV8cdtfeY?=
 =?us-ascii?Q?7kz1uaYyKQrOMR5sGvkxu9YTGGzHLNQDu8at1rK5mapi0x/ze6HF1UDsE785?=
 =?us-ascii?Q?JV7bZ8Ew3mRml5YLGepKpFcoXLcniDrMTLJ3FM/pLQGFpMviFXX1AAUo8FiE?=
 =?us-ascii?Q?5PxXTZR6sJ5hojUEM0Blo4RnW0QIZPeqay4zrJ5MUB/rU3U7jc7drC2L20gm?=
 =?us-ascii?Q?SC7M7hqM4vHGZF/CbQIIGSXA6+8E61kZ/BDn+gQwSlPDfmMIydRS7pbp8QYL?=
 =?us-ascii?Q?FUdLVz6ks27LMiF5oGSb/ZcxZNXpXT4IUqCb9pGngXTpJs9hYXAI8ndczf6O?=
 =?us-ascii?Q?Oo4+kucwllyPZyg1dLFYtIU5m54HpLjs+tHVPGNbmUqLyvYzyYTqEXj4fjik?=
 =?us-ascii?Q?pXtXZJwIKBoZFBaTLiAGc5Kw6ZyicAFphRiM3M1EoKp8cek423u4X4o9W2SY?=
 =?us-ascii?Q?fvHbcsJ057pwQjE6VAr17SIch4Zak3E+sbEcVvtKDesZQ+iP1vFVKR42CzR8?=
 =?us-ascii?Q?BWQRiy/9oJH0njutycuBZ7ZK0YZcAtq0Zw1m8ZJT3nPAZJqGNiGWe//Q85Gq?=
 =?us-ascii?Q?u1QA5/2ieHZV3Z0rUlD+t+xX2PAO6rGmiy3/bdxyoTdUURTXq3F6IR3pNRbc?=
 =?us-ascii?Q?GIlYkIARLXgGAb/AEherOnZRHQBjIB1gF6iWtuNd0Q+HRyD8arkeFupmMZXs?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6430e6b4-d186-4691-3236-08db934f76f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:56:11.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBa32IKgzj8JdOV3q8V0Wn4if8fHI4wGw/KN3stWN4VnIIMKb/AEateqrWr/u5sivyA4A3xlq2/IwYcku/ShEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Add "ignore -Wmissing-prototypes".

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 6 ++++++
 net/mptcp/protocol.h | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c33b5c7b1649..51634efe4741 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -144,6 +144,10 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
 bool bpf_mptcp_subflow_memory_free(const struct sock *sk)
 {
 	return sk_stream_memory_free(sk);
@@ -154,6 +158,8 @@ bool bpf_mptcp_subflow_queues_empty(const struct sock *sk)
 	return tcp_rtx_and_write_queues_empty(sk);
 }
 
+__diag_pop();
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba6a63e6d39c..4572f01b978d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -642,8 +642,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_memory_free(const struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(const struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

