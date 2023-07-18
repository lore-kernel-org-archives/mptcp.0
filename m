Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4517CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuvcOtLKkHVkTx6xOhMYh2WKLCjzQuFQnO3yWQbqeHTO7HuN4o4qQFbtZQwiYI06JnKDxBI4oWiLr6J/rZV0+L7FpIwoim1fa5a4gsPhD5sdo1GvhDkHZlKOUVf7ZdZPiUyxNVTq1dF59RTZUZmf23LUbc1DqCi828nD6We5jqbCv3gqy4AfYmdPrgrVxHae6RczCxFRrn7pqX0VeaYN1QgYebwl6XuPtJw+AkbO60T0vo4rGa7H1iA1Cz8zooTX9UbqvJK9U6H64DXKjFQhHRhtkm+lP5tei7HjsYP4HcQf2UKH4S0jXTQIyu4B0w0FeVlniHGRZJahgfGent7FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuRvueZ8sKpYCu7a7padwGFLfSXFOwn3fywTLimydMc=;
 b=TCUagZmg4h41VAU3rEjcOWQfNBB4M+AEyLHaIjpoDW2TK3lrDR3ECITvRLoJorVC63UDpPugrJ0fW/RE17qj4TDgq55pbxGFMFoYpdgxkCrIPKYshkbZpSjfTVpn5jIq6jFIloA5G+FRN8EWrKySJ+wd8A3PskeQFSMHP6piFQGYv3eyTdueCRmqOUHCqL75cfC96Yzs4cOKExSMQuBGCjjEtqFXCQXGoZKqBuN2AegZWihdXvm2o3qyVuxOFatj87Z26k2oBe6z5oYClwImt04IsDyikHKyI4+HcWmLP1gCOYvctmZkJ151U7juJVBIzagYq7x4+reklYn9eeg+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuRvueZ8sKpYCu7a7padwGFLfSXFOwn3fywTLimydMc=;
 b=mKmZ1FWX9xIPr4bqriJeMvPId8yAqGP/SkTPnPn4wOS1Cta158St1HI8x+NfLJ8uuXcsEUDa4RsuBhQ2elpLrRCA8AXlsaLgsh3i4d4pKsNTpHG6v/IPwO7FwF0zncFG5G/55DuCcKH3M5jM6xCCIIqBRX1kJF+3S+AJhqjxPertxNzXOgu1WH61SYbQ1hu+JfoIenSHSuSm54ryqBt4VQK6l07zeg5miMwLZKmbBbuuoUx7szFmTM5K+NYx2W2zO9hmKJMc0ihg0NB+Ahe/x6QX6kMZ7/VpnI56E/zIuWIzkBr+K9ZfNg+ykunSRRtqfVNPm/qdZMWv/1mmjWf/7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/13] bpf: Export more bpf_burst related functions
Date: Tue, 18 Jul 2023 11:36:48 +0800
Message-Id: <cb16ad49ee7b95ef6c744af0cba5b0aba5718107.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c77deed-195b-4f4b-a380-08db87407342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HVp9y5SJw1ynYdpNyvL4M/peGBeL/3MR3nQbTetG1V0VLpEzLL21aJOMxYQ770b+VHeNySP8niRpkuQsm60U0nZQBCgslXQ43DkC6p1ykA+5oKjW9Nb1GLH8f180jX7Z2Pv2g6IUeUiyP9Keeyt3DEHwDrlwTb3YocmRM04mqY/nONNeAgbMosHDJnF4MjK1pSRzbcyIVU04LtKyi1IKUvym9gwlcPR4AjGNny0CyjmzRZWOvQ+ieoFrZfuPZ3eia69U3GQoBvLkLVuMuz2kMhCzZAqo1ukpAgF/6KBJn5xA9RhRgJul2sAyGWPhyXs5TyZy+j4Gn8VxlLPbfylytSD/yDHswke0l6YaNAVINaQQFGzJGrBL+b1u7y9moIQKorvr1eDY1CTgFWwcWipZh88HYqqMpTKjDQvStLwv+SMsZe89O3MNbJDrjLr6Vaw6i4HOTAIpqCce4XaNlf7yfRdcAxtGkCHf9aWo5vVlJapcmLkl/PxXBTWybGePdpZ+QbcIMK7pXAAdmLDs1yP92ipAdwRQwWnaaL7ihSMG2s0B3DMQygGNq3wpS3NGRsaDsLdDVr0tU79zmXYy7FnVQDFx5BPqCW6n+5GAPuwh7SU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivm5wJHnDHbP+/Yf9SgS2GrTgyGQn+Q2YgwC/+0jE8bZOx/XAXd9TxTNOXlU?=
 =?us-ascii?Q?MVY/y9l9qMh7WRckuYbzVNhMLd1GT9YxOBNDD4TJA7XJzZKjWCs7JyzBA06F?=
 =?us-ascii?Q?k/+lva1WhlQPhuHkuRjit7RH6R2wrZnCWrWfo6LNiymXobbCw0+IGc5IGMS0?=
 =?us-ascii?Q?8rFKw7gKkk/nh6bS2cpfB/lwHdgV5lfnVSw7qd+bOKV6F/jUtG7sCUwJQNeJ?=
 =?us-ascii?Q?a5FC/ylmBmxqf7La3Sil4/ZhsNbnYI6bLwwghAmHsQdCCdAp6/gOoUEIp49K?=
 =?us-ascii?Q?A5nwT/3+59HuFy9CEzkeLNY/MxZuSB2RHgJsEfI+z/I4Bi8jKZw1INqRu5Bq?=
 =?us-ascii?Q?3jnlTjhIoVesKK0LrAUI/ZpPk84Yyxo75OCZKt1RK5Ha9fii5oupyh0NGKiv?=
 =?us-ascii?Q?BGjttE6VWgWi4n3JJXtoqyTTjFhxFZOTjrXFU2c3LCxf8A0Tb1AxFwadYc6j?=
 =?us-ascii?Q?0+2srf2EOwppJ61l35Y3Trhu5RZKe09aDlsq6j5aNSJKI6qzGSc4rOWGNKFC?=
 =?us-ascii?Q?fh5Ket6NdON2F9vdQsJZrZrzND56iLa4IhsadNYaz0XVqQpAi3k33ARvrbu6?=
 =?us-ascii?Q?4PdkmuMGx2wVrVOM3LBkzxRaLQEoACQZZTTW7XDhvsKblzWtbMnLjah5xTnc?=
 =?us-ascii?Q?apM/XJbAVFZFmU3yiCIq1IrqgZhsEbmDvPln0ete3FwjXf56B8aqz07tuALI?=
 =?us-ascii?Q?eiEz3SeZHPWH4AvX78SACMNEdsC1EXQLg3YcUAmd84jNEyzDUkKa7KbcqEBR?=
 =?us-ascii?Q?BLYVRonDHJJ6amPjY7l6xkpzrgD3rphhFqkC76JZ0nQ32qKieIH9iXAMqHit?=
 =?us-ascii?Q?1zy3B2RA+K6RjS9CctlrS7Uuw+AHhagqZkuQupm8xTMWAlE+bFvxBolZax/O?=
 =?us-ascii?Q?fSiL6cS6ElT/+fiM/H5uoaWUcwwRCp2ziuVoQ+Kh+A7iCoUnr4qMXtyPTOtS?=
 =?us-ascii?Q?nO/qksL+Cpq6zx9phoZt0KVUR+VyyBEcJIyKexyoHXon9QEAd6T6anYpVvKG?=
 =?us-ascii?Q?8CQx/z0J/9QjK8EI8+x0RtCqlmjt140qGTiTDd/hUmGrWEbdNLYzaMYLavJD?=
 =?us-ascii?Q?GPadAGpRqU9gz0pW+Dpeb9Sz1hB8YJmpu6Kw9FYtbeyo6Xe5o0TM0fcU6Pzz?=
 =?us-ascii?Q?uU94nfDiWB5sjie7NnYW5Z3aK1kUwBR9+ShyIUBZ3uiO4/9mk7hf4V1Sqdbd?=
 =?us-ascii?Q?yHWzOhXZjR2GIEHCjCxHXaaQQkAWuMHn7up2czod6XTCkSqs6e6VPNh1Kjes?=
 =?us-ascii?Q?b3ORNZHYskTlPuvsjkt7ZkEDhbsEKHHxCkL71rykNZYN0mhg1ye5DgNUFPZL?=
 =?us-ascii?Q?l5hNj2IaFoabrzI/nlp/fWBC+7mTxrvy28xD6CfgazXGabxSfPHf+a6eswfj?=
 =?us-ascii?Q?httqx2OKL83vN1yCGFumNnFUQp5LeOMMtLYmilJBfcOAX2TegQDVnlBGbX0l?=
 =?us-ascii?Q?3118j0sN8LF9e69NDgjoaJYTfTSuWEqn1l89AsbeQsNgzebpPF9UAN+RRTdc?=
 =?us-ascii?Q?qlZA+115p6JnTSODuZ11WazaQO7OnhIDSsvC0I3c1RwrWDOHTaSjz4DZhAcv?=
 =?us-ascii?Q?dNnZq9YOc+sqavXc4RY4CLNm3k0zJnZWt9p/iedw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c77deed-195b-4f4b-a380-08db87407342
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:28.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXMe+SYGe6CMO812DMZ5lpYqig/rMxAy19qo2KAlRSyWM7YLZTeQfzsJzzcZikXDZPr6pa1dki7nuws3jk6ilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 16 ++++++++++++++++
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e6f94d5e22fb..12b747813dee 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -144,11 +144,27 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_mptcp_subflow_memory_free(const struct sock *sk)
+{
+	return sk_stream_memory_free(sk);
+}
+
+bool bpf_mptcp_subflow_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_set_stale)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_memory_free)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9f00a0288a0a..b4218108f17f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -494,7 +494,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 78b3beeb7d7a..cabda60f5f76 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -635,6 +635,10 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
+bool bpf_mptcp_subflow_memory_free(const struct sock *sk);
+bool bpf_mptcp_subflow_queues_empty(const struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

