Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6909134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLg4T2lqEFjNI+fzgOgM+UstKP75ND9bJ9twk7p7+FSNDS8fGcxfyUUd8DZd2tuKiEDTkViKJXn9QxtVsscU7rpWe/OlWP1lOCJaP5UWQEW9qOq/v4T/QYNWdURKya3vipsp1UwOpIgTccHICX8uRbn2AFZvSfGwSVGvlg5Xufv2o6EMLw3fIH6cDbMxPf7VWl2u5YfXarY5yncKn3nHSM8ZApE3yZko2xc3QzYONXqUx0HvJOBvxB1M/RSUdrSW9pDue6kp+R1+Uz36vAFOup/MIMbc40npstEFgwHcLL2A0X0m1GhXf0m6DjzB1dfevNhyteCNiGRrPJ5rxZP18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95l5ai7aCoUhDNeLPq2s1rczFLZuY67fhzRgqNXHdMg=;
 b=LClHVmhoSQH9ndUACoBU9K6VQUishp119J3kkYtQU2J3SrZql+00jVSn6Q7WvMJqqgkv2JpIuAnYymRZ4T22aiQkMp9aH1epUYW0QYBikdCwf+LfORjATG7lpscfLFDr2Hrnt0VxHhpbT19xaQXCTz886NpgKnZeLi4YtBDp4wP69pMzKnx9XSCDiEkhzV2N0KnaJ9Qu/lAlHVsssmMmJD+kacq7krdgAUGWfhs/56OEPavxJO57FS2Fau0t4cmJrsYkrsqaNlqm6+54IPOvrMF3+DAsMw2QaOcxO+U0pEOwRyRGO+v2P/ishudmwWeJvPsn5iBbMG6H4F4aoOOBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95l5ai7aCoUhDNeLPq2s1rczFLZuY67fhzRgqNXHdMg=;
 b=bIU/smQziIcFS1aEjvCnBUnuqIpcOoluSaIDuAZAuBn9xs5Esay9kpTf+dw8JP7sKpLhBab1tmUpNJ+GJZLE5loalW/HgG0rR0ZSrbdeeYy+6ACy8QqGhmxkWDmrfpsIagx86xm8ZGCMh8eeg4vBDr8SJqQdgKcbbv9IoHlZ3Wi1OOb3/DqIDSO5wTc8o7fr0k78WLw7wYsI/ZW45/A6jOLw7Q7YgmduXflDiwm72jNi+llP3paTbDwNK7Ns7H/q/s8gN2vyw2JKYQ8RXTbfWuXv8F+aHSiVSPJi66n24IItr/cnwNC2uO4V0daTJcvMA5H5WdHO+YEVPGFY9senvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 11/15] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue, 30 May 2023 21:17:31 +0800
Message-Id: <21fea5e561c8247b698143aea4f218be75d52165.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9251e226-75fc-4759-46aa-08db61107c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LMNxeyezZSpaswo1N295ifeWg9SIvEeqcJcOJsaXNUjSel3HpuaNotnqenjfGF7GpaZghWpDfmAUeqDYEqvIPjZicBQrz4k5hfEmlohPF/TAeRQnKaBrzGUH6UEFcwRLPGFQghE6uEhgoBX6hdqXfzn5F4f4Tuej4Ha2AaP4Jl0qvyj8Qlhwk8sXkD5MuiyKyGsiKGIbOSDgdIL1oCpXYA0ng5UhQxekksnfL6HbSnmPlkJhFK5u0PI7ko+sWGz4ruH1aJRo5QweBz5B+b/ld2hqnpiqh/lta9mzWTsmxy3fUVcZh1wV605Hp8qnFlDi4kLZkyLy8ZowIdopDtc51mb6mLnBxkP1OHd0xR9xKVj7R62ZCmXTo1U/fye7YZ8zdTTrg1ciWmI4L+5mAMGb7FiSbNTLr9RCC2KbA9qA6KakoTCsWedYGeky9/BmmX9BnnaFywugcHrTbmb+vLxekqGk7p89QW5kTuEyrZRcE5yDxbM2q/Hewdi/1YN3aOBE1FIDn6Uk8OM1ForQKdAX1uyX4QFp1oito8zsZSCKhDSUcXadq4Ewq5Yha/h56kqS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhyOj3CdDcHbbjHtW4if0csgmHwLIWVG2lW0IWgXXl9hJo/jS9uxY1KbDUnl?=
 =?us-ascii?Q?AGKCbjWRFK88YsJxK0PvuuAZ5ZTXRrndjisa7C/JP1/M+hl2kKo4cICDk9hn?=
 =?us-ascii?Q?E55FwRJGaDM74uorM913Erq3P1lc13h6Y1dpJZ3NmNJhrHKYV63prFebJ6kt?=
 =?us-ascii?Q?ovNR/OinFWu+hFbsbgBYQe9bFTNrHEM/TmQQ1hBtnegKFumNzwLJN8eCK6aS?=
 =?us-ascii?Q?qvKUqx2dCtttts6l8Z/07E7OHO1Hs9gkVZB0k8TJLrp0yv4cR0ISj0j8o92A?=
 =?us-ascii?Q?51wCbq4INmpP9P8rian+rLg7zES82Kg+ruHpztfAhThYXC+2KzhGIi4DyQ+0?=
 =?us-ascii?Q?YYPBEhCSaYS7beDyReMhDNa1SMB+p+IJVAfv8Y5KYCFif85nuJOebhY9l6CN?=
 =?us-ascii?Q?jAT+Cryx0vkzL9FFleN0asFudiV+DnfdluH6f391wROvbXq9KiUX/PMurJx1?=
 =?us-ascii?Q?Gj9kSD35ttxFyonvuC2wCnedNn7jkEULJR5H2rVH1YCx/s6w2/VnNTbVcBj/?=
 =?us-ascii?Q?cGOXfSjoXzRlnAsG+arMDU+8CcnOb62yDNoWFVKsZFjhfN9JD3OGruhyZ4ug?=
 =?us-ascii?Q?DiZUZylQx2X1cmh9T2qNxddaLr5jp1MZ9IRTOpEXT8PHqm2fhHfvNWeNfWxR?=
 =?us-ascii?Q?c8V/WqohrqEEjn6/OuPUC0vRapEQqn+81X1luY4VxRpXxvKquuN3nPpX6hQ5?=
 =?us-ascii?Q?JiGt8dW3IR+AWy1KqW4RpMS1kw3weEBWDrMDnmA2wpmuok1sJLisTetwNLE0?=
 =?us-ascii?Q?6RR/MBFGjUqQ+0GIokgKx7UpdVnwEyDqdn7otKLV/bEV9hiE0XrTsRLWwnyT?=
 =?us-ascii?Q?J2j7eQYnIQKYDuyiJQUN43NDtjroZGpMrw3sRH5ZkvoKvNYQ07reTNh1XQuS?=
 =?us-ascii?Q?xY/mXhBJKXdSH8QRfrcUF3Qt/Ek2FalAQ3HO4mEfSVIVYfBOgTuqfx2gJKgW?=
 =?us-ascii?Q?GkDZTWbji9j2F/j0zsMhqI214Zp86/BOUZvnggOZsGwNLa8ZQdEg2Po1MKqH?=
 =?us-ascii?Q?QTLLC7ECpwGJ57N7liMDxVetmPogP9bNdh0r08mFQrWXMM9owkZw37EdIuqb?=
 =?us-ascii?Q?fWKrGNX8/iqGdJqJ43Pjk/ZGDL8uCylV8uSmnSInaabHqPFsPrGcll9yn5Km?=
 =?us-ascii?Q?TuuZPy6+oYQnJtNPAjyzuPBES67QNGaDQ+m4Wr2lsrtAGfFFU8hhFV+e9GlH?=
 =?us-ascii?Q?Wzx33B9Jgx60BPliqwcTHzjOlYB7rdevRQH0+/682ofegjutMWoQBPf/PcUj?=
 =?us-ascii?Q?ziX2UkIa4sEzXWFPb+aWR7EAOQaKJBvGE/9ufkpnnUhQ4ou0jrZt+yhlUbcJ?=
 =?us-ascii?Q?Ib4/T2li4S2vHMO4c5bbbH6VmIKn8XoaO9HJYoKqYXgALUGsmlZdvGmMCk+m?=
 =?us-ascii?Q?4ZSD+vbCHGXEfjAo+Hqb+8Nb9MPMcYZ1m3/nheyB5LhrL9L8D4S9R/crPHue?=
 =?us-ascii?Q?47Wngs5gr2utwNOMkGvgJ5xzXtYI2OGXHi79NyX9Cm/CvtDh/INyqNCMdt1E?=
 =?us-ascii?Q?vOWWwavVauV7QoTdnk02rEY2yO42Ot46IZu9oh6X0F0Kn/IIo+emmaQ9oXIG?=
 =?us-ascii?Q?Qx6AQXppgxWghLmteGGPMKYY4pg3P49Etx8In7dO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251e226-75fc-4759-46aa-08db61107c07
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:23.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhRZntGJNVUzYAW+hKrGexvw2XDmHCnO8KRdYzJBO9KaT4roWu23MPFtBHY0XexDWWS/+mSO2DWRQ3QObFOF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 9 +++++++++
 net/mptcp/protocol.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f2ce9acc2628..c5acce1409f5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -175,6 +175,15 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_timeout_from_subflow)
+BTF_ID_FLAGS(func, mptcp_set_timer)
+BTF_ID_FLAGS(func, mptcp_stream_memory_free)
+BTF_ID_FLAGS(func, mptcp_get_linger_time)
+BTF_ID_FLAGS(func, mptcp_get_burst)
+BTF_ID_FLAGS(func, mptcp_get_pacing_rate)
+BTF_ID_FLAGS(func, mptcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8dbc9b9c3eb3..83ed8ab58be2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -488,7 +488,7 @@ void mptcp_set_timer(struct sock *sk, long tout)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-- 
2.35.3

