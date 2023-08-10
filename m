Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDA1E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZI44bX4BlMuW840KuQ1/RKQiHGAP7QJkb7HAvO4rRjyiKX7J8MEgB169dYFyW7hFk/+ZqE/SX49OQSyWip2mi+E0whzD5uxuT+RwPDnXfV9cxuZmU+21VIzZ+qPbiOM+VDGMJDmVxUkonf0yFcftHeLsrKRCgK1cflkT8SPGC7lw+/YRC9sFcq5jAYJkDQkT04bQj5huz22bWdY+WFsX3WX8tpCjIlhH4SOcSObsedrD4yMJ9TBAeuHTAwvJhhBiAE0berbU3/JVmkvu1EQOhooAgUoTlaMKoyIhmksz4SuP4jIBA6qFOaKTzDjEW6pJ/8dEqJglZU+HXP1+x0uJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUO9U+KVpNlWB/1DhEhRfiBLMpFe4L39RAWaKrtg5oA=;
 b=GoYt3EfaAKBG9f2WHFK/GXq7GyVbzpnCdt5TIvUbVz6xeR1Ap1Wl54pKZzismnu1M8h9mmzbVGtw5jHRuTLR4FhtkW/4T4j9uSNfv/HCzyh0yPqTca1sofidiWPi1lpBU77Gw7tOqGhzEoxs/a69pIwZ4NBb3Oj4Lkt3Wv2E6hZ/j9fdRCFFl68jESymxP/BqEnDEtOR8Gc16K+Pbm1/xAF57DZXOXGSa/Y8X2JEv7zda7w26aX43MhDXfShSEq2uOa2sA+8yctLNoDayPlD6K67dSWCoDh5EO8qO7DRFIo2hkT3rrTsxGQiH52UVIsP1BSU8Pm6tgOVwGZ2+wqYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUO9U+KVpNlWB/1DhEhRfiBLMpFe4L39RAWaKrtg5oA=;
 b=A63Hzj2N679EUe2IEefLCisq67ux4ocrGrZXh1Od0TkGKRsOtRn6DIEw+Bg18sKzHfy2GReOyCMh8APvRNrtzlrH3tDoVpTgtlSbqfYLTshXgm1UhKS2TOJpOYS7EG69SwLlpQAsixh5IVXru+/7tqwfK8mDyjVN3LTEh371SkQxS+Kl5Dw3NMlNf5f5ELWUHWnbWWEeIfkAq666lYBKJoxCciyhGZv10WSVWineKzXbkGpK9RbISn5qR7POJjISDrUtw3yza/9PK1DRns+vLpIaDn4qO/irqB8hPLcJuwPtAeHxR5FYVPTOCusD1Q3FxCBmKEfksAVcLXKkZ2SQDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:11:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:11:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 09/11] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Thu, 10 Aug 2023 22:10:01 +0800
Message-Id: <fc153eab7539e7ef3900c6759c43ec60baef3f80.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0313.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: edcd341b-c381-4a14-815f-08db99aba59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z/DLkPsmWJsGb6+oxm5zfbmRnQ9I+MmtEKGc+YHI0tuvDlzZRViFlvPrjUXMH92D5A2F6DuelvPKj3Vw+wDZNuAO23pVgHq0O8/Elb09UxX+AY/UUNZXc0IL9LYJqlaNngFg192ZcuJPvm+OoMNuaXSQAvrQoLYjbEDjRUAL4Pw0/xk65au2/w9Bovsc+QO7uAAXmOwhsPb6FOyNHg1fIvsweZKbGq/SkY6Ozb9h8r52he63yxiwIKJDDJiwiWg2Y9dZ565fbk4Vq62tbRaL99TEYfJPiOJiyCGEr3aFeHRYsG0FbV5jt1pJ2aW+ciOaHkk9NIJxPI2Rr8Y4Ek1qmh5V/lxCJKh6HVgzrhALvy3t5zg6FD4w/tKbWiVhewzHhDVsMPSmMktWWbK52ZzMFIyuhHM5vtLf3wg94r7yRt/2M55Ech2FzyFlTF8Zd1IDdHCMAX5OmjhVkTYc5EezpG/nkF9Z3HGF7xxZkOdWvPt9HknU3TPcnSudSFWjF8zsOgCYW3AZWGzcFvoqDUCSbGwBBRdY8/7BoBouu3uH2N1LLltuI9JQMRHRvwtPRj3qOeJDtmz8CM5GkowpcYyZHTlUEuxxpuOxEyqwjqe5RuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLFWq/hvWL3iAZvWy7uMskXs08CIoU3+OAbLne46DxNnteef2S9Zg1fhjBNt?=
 =?us-ascii?Q?+CgFZVoSFHPrVLW/FkG6nB3V8gYAxwn/Cd44zXo+/OlpqwR+sOldDghoauaj?=
 =?us-ascii?Q?mQKIrgUQwqzwBfAZBPxIBMP3YbqvohRWnNjbBtrPAeHu9XOVOyCjE9497AQ3?=
 =?us-ascii?Q?1flH96vPaX4T/fMQc+pFG9yuFSbhHqftHfV7rEhVYvkMZm4EoahVJI6IO3sr?=
 =?us-ascii?Q?CKm9mt9b9Bl8ZamSmr2rvtWo7CGS3VGqhjR+LlS74Jl2f6a4csH0QskpjY58?=
 =?us-ascii?Q?5/5uDvNVekipmFae7u82ej3fNGjymp8gdHNw/rJVjeC9lZJ4haa+nZhOz9rq?=
 =?us-ascii?Q?l1nfnADzv3L5vnJBmlCVrW+xY/7ntRY4iGJBbYi3c02ucqf1+pbe6pORfaFe?=
 =?us-ascii?Q?we1zc+IqGGKKiq753eXf0EfxOOMI+bTKkjlFZlxc1jZvUEso+dDSV0fMRiUe?=
 =?us-ascii?Q?OyjUEOXeU+lAKxmS2unLsWmbefEGHwrKnepXHybrHf0LtC3ph3TSNHxBe/Tl?=
 =?us-ascii?Q?P5xA8Csh/bVPJ+K6gkzikDW7Y+MVtYYGHEuSmF2SzuI21K8rV/SN89vPC6XB?=
 =?us-ascii?Q?1zH/H2BaimVnglpOnrhNvi7trTQB1qx4eXYeOaTVYHrFh+y18l+0Xx9Ba+pR?=
 =?us-ascii?Q?NACXvb/sVpabJkAPyt8pd30nRbxO5/LivOkQRuEZDQ43CaK5P3DiU0KB1XbN?=
 =?us-ascii?Q?TrrBTatyR/kZdDe+3A7IhbhUkpDEAp7ua4X3MKQn8baTIqh8u16/4gpG7hDn?=
 =?us-ascii?Q?J/bHAQ0b8PHrfIeVPkPG8mN7XuSVF/hp6bZBr0MOnS/M98WQeqaCCKr/8nVV?=
 =?us-ascii?Q?U3o42XchwhYQaK9bQto4XeB+H9+dHWsnR398DPVwiwMQLezk0Htmn/0gGTZs?=
 =?us-ascii?Q?qJo9v5t/i8io7i2Gjpqt2Y4oJzgJVG6fgVc/rEBV+XEK7dcBq7xlq4dUeDd7?=
 =?us-ascii?Q?ADbCk8IeD1R3/9oL+iS29NX+LAuZ3MrWuZktJUZQZzKKtSh60cO31zClCB7Y?=
 =?us-ascii?Q?6RALvwhRSOh/sxKp6JA7r2o5Z34n31FCU/EjG2SkMkZTEKaEPV/oKLJDPlXx?=
 =?us-ascii?Q?cCyNrWoqmmBPdoZVOdS3yZNEioHxDDgWvQoSnY7yg1tnqzUDDvtcQ3kkS8JR?=
 =?us-ascii?Q?n8uX/O358WQX63snevZFg/s5fjBCffBg89EuyyF4Wwd2iEulpfSla8YMfV9L?=
 =?us-ascii?Q?uYqDokTQuu9K9DuFxRpmOnXj3Yg9Ph4mlkkkX7hAkk4IN9Kp1TsRfd0UkxVE?=
 =?us-ascii?Q?qO++kHItgZj+DdUyQ8DNXozhjcsiPFoQkdNOScFafxRIMOG39Gp0Yp5DLLpC?=
 =?us-ascii?Q?PAxLHzSJ6xXpirqdzg72JyOCUNggsNYHKYggciZaWaYdmNttHTE1MmxVciQj?=
 =?us-ascii?Q?MUZrvtlm1V2K6yLoDQ+E9syFKusyRntjOSYm2M2lIqIeBSFBvg+3SA8/hc8C?=
 =?us-ascii?Q?yOo7pq4PN82movgYI9xpfaCDh/FVWZwoYXCc63+88dHs1tX/YDCx+8Km+rox?=
 =?us-ascii?Q?qoT0tQoCaf1t7425OPSZjDLB4sMhv9VmNygMQm6YDKyMqmKyMN3X1JTpkNX4?=
 =?us-ascii?Q?+XgxpMTww2yC28QZkA24G9qEy+ARImoILvrq6/zoyNpuZQwybb+7i+5OSo8i?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcd341b-c381-4a14-815f-08db99aba59c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:11:10.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrH7w1v6Uxy3DDcp1xoEwJ/r0VtR+1hh7YpiGrbG6p6mJQ8jMjDZjLcUOJRHNVYxapXpHmgwxH+wmmRlcEC3Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

Add .get_params and .set_params.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 43 ++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 8cf2ab32c159..a7bf37005c5d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -69,6 +69,8 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
 SEC("struct_ops/mptcp_sched_burst_init")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
+	bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
+			   BPF_LOCAL_STORAGE_GET_F_CREATE);
 }
 
 SEC("struct_ops/mptcp_sched_burst_release")
@@ -83,13 +85,25 @@ void BPF_STRUCT_OPS(bpf_burst_data_init, struct mptcp_sock *msk,
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
+static int set_snd_burst(struct mptcp_sock *msk, int burst)
+{
+	struct mptcp_burst_storage *ptr;
+
+	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	ptr->snd_burst = burst;
+	return 0;
+}
+
 static int bpf_burst_get_send(struct mptcp_sock *msk,
 			      const struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_burst_storage *ptr;
 	__u32 pace, burst, wmem;
 	__u64 linger_time;
 	struct sock *ssk;
@@ -146,10 +160,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	subflow->avg_pacing_rate = div_u64((__u64)subflow->avg_pacing_rate * wmem +
 					   ssk->sk_pacing_rate * burst,
 					   burst + wmem);
-	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
-				 BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
-		ptr->snd_burst = burst;
+	set_snd_burst(msk, burst);
 
 out:
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -212,11 +223,33 @@ int BPF_STRUCT_OPS(bpf_burst_get_subflow, struct mptcp_sock *msk,
 	return bpf_burst_get_send(msk, data);
 }
 
+int BPF_STRUCT_OPS(bpf_burst_get_params, struct mptcp_sock *msk,
+		   struct mptcp_sched_params *params)
+{
+	struct mptcp_burst_storage *ptr;
+
+	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
+			BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	params->snd_burst = ptr->snd_burst;
+	return 0;
+}
+
+int BPF_STRUCT_OPS(bpf_burst_set_params, struct mptcp_sock *msk,
+		   struct mptcp_sched_params *params)
+{
+	return set_snd_burst(msk, params->snd_burst);
+}
+
 SEC(".struct_ops")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
 	.data_init	= (void *)bpf_burst_data_init,
 	.get_subflow	= (void *)bpf_burst_get_subflow,
+	.get_params	= (void *)bpf_burst_get_params,
+	.set_params	= (void *)bpf_burst_set_params,
 	.name		= "bpf_burst",
 };
-- 
2.35.3

