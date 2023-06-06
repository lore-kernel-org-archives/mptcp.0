Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C6190
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4wx2sd+VR1X5gkWVh2HiHmC4JPLT7c3AFx2owHWGCo5st2c3qoCKGyZXWWZZuVIV30F6FnUzJ3q4olksK5puB8O9NZXDCKrChzYVMTLLrn/kmsngBwb0tC7jRiWffuxfXxPdmslSMQAtoc1W/Tz6umN0Q8mhzaAAoXF8xhljMQrwWvZV+uX4KCKL3K0YnP7e98KAJrJYdLOUTKnE+b2zZpSKdIHgxVQIHtypnH0gVRsg2V5LA/aPQ6+B+Ofu//xsplA2tLGKkBCZKPUPRhvKox5GiMzzTqj4tRO3vBm/gDd+uGWKNucsZBe/W9d+Nuq31XmTpBKWXOqK77m5CjaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwa1GJEC/FcOH52kEYSkQ77nUrYIAb6lJ46RkUkfRBE=;
 b=m3D3+Kt57XSMoo4vHKQF07il4ZjPBsh9zwe4gkR/ZylDNCsX8goAfOyBFfpB1xkmtQyMUtkezC8shngZFZCaPd7xMb9ZqNrQwqeXwKimbFbEYpUJFnbZn67PqNAZQi3vfXQ81qedQ50LZm6PQhZYFNC3G0iJftnhunkTRJP/fTy9IUwvXaoAKsMvtRCEaK75aZRr7hzYgdknTuuqBwSaoP/KGgCAVxfvJrqDz10VUqy2w5ayKyjfm1vTFDCAUfiR2aw2J0jBWrUpdA2UpErUtdWpjOei2VuqeZMoG6ikhQ9q16M24QpgLe8HY2PLS5hRx51+R5F1u6y9b05kC+vbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwa1GJEC/FcOH52kEYSkQ77nUrYIAb6lJ46RkUkfRBE=;
 b=nDx3QKuht3ppv5k081n46FAk1IbYQ2jHGvrkniYegqY7Ju5qvXMuZqIt95p/+1dlMk2hu4mwtnepDEZ7AJPWbAge6+C7c8k2GPhGsMSsYgIfLAVBUOfuFugLvynrvy0ky0gcCBUCAzkWPqttjFl+Wd5ZCTDVi1t1pMskg3OcZIXaT6ts79d9wgDeYQE0LJAtR3H056xkRjqecoaKuesR/kY3IpuQJwgpkJnK6I2ugwqN6OJmWT5SWL/r378uoi150R5nj3k1O2ZFcP/Xr9exWTfM+usov+Mw/mIKgix3lYCtm8NwdOlNsfkZO6ww3ZsQ3VvYYP5+L6zzthYSVgciJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 13/18] bpf: Export more bpf_burst related functions
Date: Tue,  6 Jun 2023 14:45:12 +0800
Message-Id: <40c0aaba36afd5180f19cbd6d54a58fbab48313a.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0b946a-6d71-4354-5528-08db6659c8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uXZZeIH06wEvCdCfbA59EEwWNE8kivAuJbC88AChv/JV+qi4Sc/CMqVn8GUK1CTHYceYH2U6GvaWBqbFaMY5npsyQfuCgLP+X0oDB59tahWNfM/VwHJPktfwqkJj4OLMdOG6NJw4ZWq0dUe3frVCNf6xrcnxwXdueg5SMKHuFY6ywk+mq73x8QWkrFW7Be8pvCEZWKThy2DC5Skwc8daaJy39cIKkQGLRbES65e9fPhMbByfta49FebR8zl5FnXY4vW5FnotVyijNbPyx73guwHdfYAoPLyXYRRFzlR3HiG2KexuKnjrKRPiaM+MB1qai5KNpWwsgiyJWrpi0Od1BN8L5lrPzy728OcEvJZnUeWR7uuCUga4m5Q2vqEdfTTBRANV0lgrtIBn1dhMtINvj2SRIkOGXHjbRu2lNbUFxrjf5qZMA3fn2KMlHrQWzI6ktiMjdhxAiuw+XLoWc1L2QwHFyB082BJ2zBcmldLFdqo43iSDyUiD7bEzjtT5ho+DMJMJLJGf0XOKiKMHSqhTBjgUxWVwYFDKmgNrTjHBRUGHpgGuZxLQA35LI1DE8enl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WqGTeSBcqaQ2A2ZKh1jvVdtLpJFr9SEQPeBXGrvEIZZbOXrAISOGJrib367z?=
 =?us-ascii?Q?gsnSgseRk4TJayxxyKPqkq9ERXJIeYLQCkrOHNhARah4l/UO3vR6dhj4LqUW?=
 =?us-ascii?Q?xjB97jCvB1OefU0FAPRwba9JBlp30XXdI5Z7MyYEp/xX5sXzLZlmD7FdLybr?=
 =?us-ascii?Q?0WXxqSo0tBtJCTDhztfAeSD3KEtRh7/fSzNvAwKZ3BD7AvdOtyj+as6aoHXv?=
 =?us-ascii?Q?tB2KH1rtk6XVY2x2tEnIcx886M2xh6hgF8Inzfq5iobcuLoDdTbccNXb36xh?=
 =?us-ascii?Q?a6P/+sY8QzRgVs1MERmgIRWSh2idezideUq7xZwQiP6cBfQpXYiH97zDZPi+?=
 =?us-ascii?Q?OH1TDXweBc97T/sw/tBW1up+gpq7grapgaQqb/yrNiDShA0so1KXhD77antL?=
 =?us-ascii?Q?QPve09AE4vKbza1Zu1tlX1TfE6dNJX8m0KzrEMLQX5jNoYRpZfJWc/xI1mD0?=
 =?us-ascii?Q?vsOSEdG4TZjOFeDvcTCGp/fCXgrJCP3M1W9Pp/RNwmDFHNjrtNWvVlqBOhoq?=
 =?us-ascii?Q?5fywqAvCYh+swQjc6XkCO7cxes/cpz70yA1V1Dbtbo0CVaO9B5kNsHk4xMPv?=
 =?us-ascii?Q?tWS99xeymhF671FCvfuSKXRadVJc18nREy5M5bBdEktfR9h5BnvQHf02X1ZQ?=
 =?us-ascii?Q?+9HPjXM+fRqYgNzfPyb6pKzdwDPfOG/DxwDPeffCNJYVpoV/gpR62sNEPLZA?=
 =?us-ascii?Q?ahY9eocxyM2rjlHlXCy5IratoUEFEmaVp09d3WuatVNJnlc7t4V+fP/OmRMf?=
 =?us-ascii?Q?QFNejMfzcVtH+wFIw19vy0WMDp+N/mfZWf00TqQOZ08fSCXjxWPsPkh4wh6y?=
 =?us-ascii?Q?HddULlhrtt4QwuF9eqjGi4g+oQfgPvOoZmm6AgG33O8hFTAW7SKeure0AnP/?=
 =?us-ascii?Q?3l8ulf8/Ob/rwkECbg3tpzSpyu19uu4dkTW0UlgDbR/sg8THKtKYvYzXSNux?=
 =?us-ascii?Q?jE/WeB5BW3qqBJzatCm4xz4BJqGINa+rHYcVM9mCTgpTrTLycBBMIwMq3h95?=
 =?us-ascii?Q?ALM3/nxwHIRCvZuncTo8JsXRFTmVJwEAe/Ev0sNt+Q01i3dNo4wMMgkNqfT2?=
 =?us-ascii?Q?iDrE+7Ul8NAkzr2EetuuMb15qQLPzuRqPYQdvdjYQKWFgGIc7lEULd8gCJs3?=
 =?us-ascii?Q?ThO+l17TRJ7F4DGu+n6iPPnQo8EHFQ6F31oPFeVDJeNZIJxw2YErJ8O4Md6O?=
 =?us-ascii?Q?qF+HBAZTogNZTz5JpY/fkADBM26PS31ZaZX7CYg9pkn3KxVj9aCQZWubSxUg?=
 =?us-ascii?Q?uw4bX8xkA0wav2MfnfdH+uanRPAfnB5CR60Y7FE83uWsoOS9oTW6ZoP/2Uhz?=
 =?us-ascii?Q?FhbWuIRQOttoMpmwqfKg3W5319PpeBDgSUFDVNSjguDEz9NcUO+9y9a4y7mC?=
 =?us-ascii?Q?JlePwRBzNCn8KRs6TXUKly3ZCMvAo1lWLoJZ2Ok+hwAsFlBE1F4L3xrRpzUn?=
 =?us-ascii?Q?kOCJOkYFwK0SDbggD2bC5uZGe8Q0tJmR9vdVW56hpFEJyAcIxlnj5GejtNYB?=
 =?us-ascii?Q?YVWxmM7SRFTgcArYVUyzfroStKOjpjBic9Lq0Kdk6F8lYBa/vVSstEU4GI8G?=
 =?us-ascii?Q?uE3fY1CVLKoHtEdaBDjZoebhkgXj6d+s8Oai0j2K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0b946a-6d71-4354-5528-08db6659c8c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:41.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPqXjAmFE/vV6KNIBEfKjV4Vq8pWZE5Wlox9RzLPmjA7sifOJVXv8h7CmRYVEAM4oEOTIimfgeVbWCqZxm5bXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 7 +++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 719d673ad346..ddcd803227d0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -187,6 +187,13 @@ bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_timeout_from_subflow)
+BTF_ID_FLAGS(func, mptcp_set_timer)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55c2be2b14f2..e416e4a7b82d 100644
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
@@ -490,7 +490,7 @@ void mptcp_set_timer(struct sock *sk, long tout)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-- 
2.35.3

