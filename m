Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B33FFE
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ4EIBXYpnZvRc9tpmHrggCBL/Uh0JZeRpRNo7lN6Z1X9k3l1AE8+ZuViye63r6KRmVJuWGhcp2nMZdn6ZlvgrMG8SG5zIGBapQjqzV4sNMJr863F0A48wybHddIA9REV4VNPvlR0ZrfUUGN1Zoqi6qYUNhc5Uk3lPdRhu6f6QhKu8O6MKuqL9/8XZYsB/m3K/2Jx4vvkwIpzQkpR2uE7MpsdQbAu7NLW6stStrvxjeu91zQ9zl8MzowQnKPULepax8a4dddekx86eQC4/n8eXQ3RbrLFsjm1Y8DIQo18UpkBWM/BVanAl25Jz7IM/xOyhdn7w+keLJXpiGO+wZmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGqai7DOnvtT5S7TE0eujlgu8GJ97/FpVZQ0aJQvVvk=;
 b=W2kWvkw5kNbeX5IfsjzvIWZtJH3WM0/ai1bz7GCXeT1EN0L1cwULO6d9vsCS4gHR2Sva/MtJaGREfhjMt886hioAu3khi4WciaAobeyJHK9QHKjKVCiYonHxpOe/zsQPsfR/ON9BtrNp2W4fJOcHL8hUrs8FjgMYMiJyJZJjXk4QJ44iNoNEboiE9FJgTubNkTOAc3a+b89gASVaDOwhWXsFJsXIFNnzrwaeQgb/YbXhpqfs0WOXdfLqHsH1dGHrnNKhfHoZ0CDAgeqR4jhg/v4MKOilT/2BNFL0DZFSLpEieeJRZdbQ52MtjoFsyxKLXGo0rMc1AjUQn9KC/M8OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGqai7DOnvtT5S7TE0eujlgu8GJ97/FpVZQ0aJQvVvk=;
 b=Wk/pmq+TJLi2ZEsUjOps152H5lCUhSOLhcHR03lYZSyiG43wEBqoMCuxpA6hW1YIp6YXgx/YH67HB5lKPiZI7XFW8wQ1RszsLeIbvUTSCP2rSHRfLYlqqlMMMnLMuFY3OmAVJp7v3AKD3YF2rrVjI5g+IBPo4vtkRAr8t64ePE6SML4k+H2zKR9WnwfltylmYTtw1k3l8V/SYdaPL+I/7xQI289wlZ5FOeFdzQtVEY09zhZ2ZV7dtm5KTdJRLZBTp69FZ0cJgPsYnQt9Hmnnzrxgyy8OWp9sLKaB/EvX17ojl2Yr5Ylgo+mxokweYgN0nqrJTWHVBZ7mgM6AbmU5JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 11/18] mptcp: add two wrappers needed by bpf_burst
Date: Tue,  6 Jun 2023 14:45:10 +0800
Message-Id: <c560c8a5eebe7b76408312b02476f5394e20964f.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 33245acc-7ddb-4c7f-68bd-08db6659bf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lwFs9g2g0pz+TC879JB0IJxzQ2GQIPFBodpUGLQXq5zAy7MeES/LFZQ+710EcnF0eALIQ7ZrwPG7gHmPZ0J1w5dqGs4wKYQ6CMV1CmEx6ygNOGv3i8RhqvserTFicN8TBs6O2ZpFKsxsbTIYkKQskmivrqDGa7b+ylWv1QeBD9x2h4dz8TndzKobQ1c/E6y+0eYum1LIDdM4gKiSpr5RhMQV0R1LrYUTcGvATAxwOMc28a9VccwHOq3TPTHdFMIERwVsB57YoXVISt5O73cWTZGSqsio15NCnMkTxs+HCXgyWBmo1H8tEE/Bv6amHl8nGR7CepRNzYc8+q2w5GU1ef8N4kCJ4xLhfDxUp4DZbQaLtS9bpUtEDZ5jZLFk9on90krgBao1zr/zsHTaHCG+jykUwUidpR85p5t8zZBDloLBN1qwyTc2k+nV/HoI2fZH1J8Eg3bm37etNoz/yJHxBNhXknvj6fANQ7YDgqOobYvkpYFnD4RMy0I7+iM2c7I4fllVkCh7p/2QPSw6A/GnvnAnbwq6jRmwBLBzw71wgwzJw+GnQA6T7A6rp28h0hwL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LaZDly8bSFMRWDLJFOuflns/249oZDqwErev1o4Co80dwdJWjL2tPrZegbcx?=
 =?us-ascii?Q?/ZV+Xux7jMGWL4rVrq8NEU49f/uUQxySwASPTmLTMmSXWdWd/lG7aabt0dld?=
 =?us-ascii?Q?jP52l2OdVyhvAcVCAUCKI3I+p4pIGWe0oJWURTP63oYeYWyydLiW3/rNyvP5?=
 =?us-ascii?Q?uCRVrXq+RfhF+vDTdd41dzSfjGO3Ny6WDxF3eqSbihJQcXqDlku56Kszg2bw?=
 =?us-ascii?Q?vi2/Sg5l+pCxmjQSQNU6CSqf1WrStD9s8oW+hxeOH57PfU/zfROV0/PtwtAD?=
 =?us-ascii?Q?ya7M1H+lpQKmrNvCyoiQ0wGUaxnSsvAwtEj0HG8WyXkCP6L0rdw5CwYGGDZF?=
 =?us-ascii?Q?jSECGGN2vhe9TFyrEts42y47HChOfy0T0i/7VcJrmFRuyYNRXG0EKl1FS8V7?=
 =?us-ascii?Q?yNPb4MJkSx0xzqazK4C34hxop9t1xYAozWKPZpmtqafeMtqD1cKicnc31+g/?=
 =?us-ascii?Q?lZl12vRrOTJxa5QaFI6Oke4GFwJ84cO+81F4VkLX5cxqKzVN3EyC3VJD4xN5?=
 =?us-ascii?Q?TL1Jw7OkMLjVmiC2Y7mJmeOQw9EVKt6UF+ipoh5co5JfW/Eswd9bkCo3s/nc?=
 =?us-ascii?Q?8KRLhq4Fo4WDJWsO0tU0/F/Cx8TZ9jOgFey7igZSGxu7fGWOEwxUSOLHl5iU?=
 =?us-ascii?Q?sYyd4NYhtViM8Qcs0y/SX7ZeoxdjOb0kCTNoXrCbnSPBCqiHxRJItxr1ZjEP?=
 =?us-ascii?Q?SQZ4Q4KCVcfdUkaCurzUftB6iyBC3tjK03gwfb0CH3ebGNKLwSgcFF0hJBUq?=
 =?us-ascii?Q?F6MjQNyw4Gd8TZfl/zxF1zSc0WF9wvg/4gEa/fN3MaFrpUYrvf3diD3H2L0j?=
 =?us-ascii?Q?No51J0vWotVHvZxj+N08i96QrOda9UimMjflp7sn3CJP6p7MpFIHDFE+AT+X?=
 =?us-ascii?Q?cy7e73syuU3rh43yfF7lkyDlSngFL4VPmUT1VTN5wyWfRy1YZKBvmGilSwN5?=
 =?us-ascii?Q?faOOqaCBdZlbmOvMCJHFMKuoZNgREHEk5H49kMuXqKEYOsYVfVtpgnjVp+fS?=
 =?us-ascii?Q?6hMKQiqxmubNCRIcFzTRVvePGuYmUWHg60RzdsxuB1op76nOl0jWY11nm48d?=
 =?us-ascii?Q?axnjvgk3iLvgkeYPTtt3eHtravBLK6z9SDOcYtQGgitaTeZXeZfaP+2LY38v?=
 =?us-ascii?Q?htPRqDeANm6DONGxwpsk1uNvBbHWjVWPytClgdWRsLXJfLDnHA4V/0P6k+cj?=
 =?us-ascii?Q?WNZeuDG2lfQMsvcSbNwWuffj5jp1kAGARjIo+cWmEn1kkQSNHyGcO5Yuc4fF?=
 =?us-ascii?Q?mmuoY9kGvuIWU3t5Qocf+oYEoz2saqXMa9TaJpgoCISxv5RLK8Mo+EQiYZP3?=
 =?us-ascii?Q?w21Y7cNCz5qGwbO6CXOe9xUSVVNX8BUIU7rXfdwGtbF/eGYOnwpmP8SMRt+5?=
 =?us-ascii?Q?Z19SaVhDYYxWUJdhzqgBnsS3MFPwdp9dw71Q9EXA2oXKp9MQCyPPzzDPoY4+?=
 =?us-ascii?Q?65096ohjzTvgcStowoFJWOSOVFw5L+xiXGg88uR170+WZqr4t7jT+j1rRzAe?=
 =?us-ascii?Q?6+3CdF/j6XOcdhZU1WHD7ZUmIvwvMCFbEuzVgWEBNhF68wPThvKqGbfsixdC?=
 =?us-ascii?Q?EX27Rol5KhhkmvvllQfyUAbF1zwX7S/7Vg8PLjC2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33245acc-7ddb-4c7f-68bd-08db6659bf8a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:25.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLe3s3L9pJf3sTy+gtL7ErrMSjBXhnE9SMBui56Y7Q1ZJfsm+9UNuhHa3d0epSTEDX91a/FejntG3T9fZ8aQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 12 ++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a2bf8bf691d1..cea6a8562f70 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -166,6 +166,18 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
+}
+
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12c8c95abf52..29bba51b948e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -668,6 +668,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
-- 
2.35.3

