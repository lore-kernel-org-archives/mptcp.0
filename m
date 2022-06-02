Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCA622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe9efgz0md2SMOik3xDANw3zshyzBbTXhnP5SLliMnY=;
	b=DQZGWZWSwCpWqvLtGJUltqC9ziHqqALrsY+VXGdecYfsqp11gLrvAgJpaHtDxHDRLMaF4Y
	I4iN5rG9kkLq8darixANjg0xefJN+pSl9tHjnD/OgAUd2UzzZyUPUCLpNKLS1cAmcaEhZ4
	idueWA+kaCnMsofzhfcC7ShW9gaUefY=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-K-FgMyCRP_G2QgyyqOn67g-1; Thu, 02 Jun 2022 06:53:55 +0200
X-MC-Unique: K-FgMyCRP_G2QgyyqOn67g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/TDE4fxPotZQUfZ/aa9OzF/giRu37s05+EdMy0FCSZWbs0esRZBzjSjyNLfrKQywlv6+aEKefHx0tRPztxajGNZK0W3LoLyvlITtK2F3zN2PKZnnqUM9TNijLjATU2g3+niy4pALSz78LzXniqYMhu112GFYiSrljvLSKlN91h//NvTJaels41TNrEH6hA2mq7NH+RbvYIlcxCra823r9QREP6WaxZYC76+ua2E7Fy5yK3Yrt8k2kBx6Oirsg7UHTG7+VRH3AUow1Psbfi3kHVKIgwix8XYTExy61629/tcZLB51X1HIteR8EputmMZ6uWdmZ4rGu7f9U4KkXwqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVO1QZIbJ1aqP2Fm8WAfDvTva+RE0yf36bTfo5FVpyI=;
 b=gYC8Lb4Rf27XLR9LslGdZz/rkPZcPxGDM6G/0p+I+9ytM7IzoQZzaqp0ctKyKojYMzPW3eVefdBOq2/4HkMlhnwFxRhBjHpcq7S2UuegHTm+Yv1/q81u3zRvNHOpKtM3V5riLglGJ7UetS6BH80B84BC9s9gwp+JqACMXBf8j1GDh9a3u8rd4qf+eD9W93+qS0Z72GnlbeIw0W74Lu6SoN/AUCwDb57hMv3aRFI/9fsxGuE4rVYy+gBE28e0kHfDalJ/RM+tJgWooYeO87v3iLPlwvD+ABOzE/zsXUlW4ty5SNtDvRVrHnT8zafHEiqTOjQSYtIvCRKLKO3wENLcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:53:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:53:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 01/13] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Thu,  2 Jun 2022 12:53:38 +0800
Message-ID: <04259494e69c548ee9fbbbd79048e6f75466b54e.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2983ae-5497-49a1-7f5b-08da4453e544
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB33846AD44314E8E95276E0CAF8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tA9S8UyLRZ+aG1BSuYlUxaAgj8RuiglsEXjSPQSir1HY7DWWmV747cyJI+ykAdYciL7egOHcJal/Fy730EkraXo4HNyIOKUZoLz+x7L0A1R8+m7eOwlz8J/zco2Z7vOYkuUmYX/hkWWIIhoCU53rELqL60I83t6dZS31AszFRupM5LBQ+NjZGpxt0levakIL4hlvMZKqiskgIJkNooTPfZs4QgBgxzoIIkD75FQJQwjRjgVTs7e+jIxjSAkFWOw9z4p6irZG/GWB3C1xSk/DaAIK6Yv9PEmtzOc1G/X9ZSkA/Syn1v4vBPgaNU2Zw+rJpTcrCt5f56JVR9ZA2w/Z1hADJ99L/rQTIE6076I9pU6/VvIj2put7TanzcEXMvK/696rqcF2K4yD+eaPkLqxr3LQPG4tRlJuv00ft6BlCkWtMDdtLqZsKP/PKaIVIaR+Dopbn/+f894xrOIBSJI/sQndkuAgOfd28bEiKhJ/PY2bdd9tkao5IGOm6AWeHobQP+KfkBf3klMcyhy3P3z6gwWNbyVE7SEgKRZgBsqt5hZP50QGVKpOgxiKccZ/oGLRxwzW2/POAlD3vemLXIDHhYcTN9BLIyYAp9ym8PIp0rtpZmeNjSCB/F/NLPWAxalpdF9/0Xc/8JiLCe47cNl9PKFwx2NF0y7ANlo9jOvFgC36gh0D5qpBkfa4MHP0w8Xg6Wp0qWPCvrmlEcdyMn4zDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCb6n7q+GuJ4MSYTkLWz5ecVkaz0PeaKPG8c+tVmAchLZrW3IL0FS+sl0o3Y?=
 =?us-ascii?Q?P07ODVNDox3IHWHjik8ejqDCP87Pq/tLYP2byaWvCU9SgpplXt1BKV+BY/nn?=
 =?us-ascii?Q?g1P6Bs5iteaknixjSdmbGo4xLk0jdxJ4APtZQrn4AQpSgr/RqtY2VQweGSf6?=
 =?us-ascii?Q?STl/Vmq7HHVcARcPP4sXhCpAMx6ry/I1DB/dbxwPBAv5KJkPetQrs6SNtDan?=
 =?us-ascii?Q?oR4S+qe8WhSepRqGjqrvz8Xoxlb/3YUokcVwY8ogbUVHo9Q7J7f3MlpHgyyX?=
 =?us-ascii?Q?Z9IZcPRYP4di6CbdmSf2KxqKedGvqG+YGSEr4cRS39lB7+iXvC1iCZGPwumS?=
 =?us-ascii?Q?4GEl/BeQLudITp3ONZ2QwyyBiju1oZ1BHehJO9xzlfHU1Exd0f4LxziwCHlR?=
 =?us-ascii?Q?b9EWk8gL/pYwxI29zzhhrJzhqGq7sOw7MaMyI578FxVCnMzLMJk8tA/p0jVe?=
 =?us-ascii?Q?Y56V5jBfxlJoZM6uXD+LepA+oqEcnidq5Te802fXNuZta/kXxjbM/TxS6Xyp?=
 =?us-ascii?Q?L85t2s2vd986AH4SWtEojsggLn6tMm28VDv/5XurEO/QhvvFknvXoK9IlUf4?=
 =?us-ascii?Q?umvov8MTJG6Z/yhXbUgP/NiNQBmuYB07jjz3VpAWR8WqDshKjNH6naoExjvP?=
 =?us-ascii?Q?M9377CWZ08+2E2N9SgaN+s+hEtDWrf5qnak+R2z1rA/fjphrkt4CE1dXtVA1?=
 =?us-ascii?Q?oY44Ld41E/z4lVYZJx7LKcqvuNXY/MTp2xL0r8g+zInDzW9YGati/dx2tl4R?=
 =?us-ascii?Q?R3zzU+A8GthKQHtAEb6ovGcWT3ADUasoBJh/1rmfyDZGzfJ71OpmyqWEBPym?=
 =?us-ascii?Q?K/k+MaogjnzRESKWXAm5eCPvI4IaDkYjAOXnimNmtS11km1fKUFQpCMmKROR?=
 =?us-ascii?Q?Wb2/aRzB6ShiniLFUQQCTJhalh/AT4Behpej29n1QjpiV7aU+6ACfsHgUG9z?=
 =?us-ascii?Q?OJ/+g66WcCRhyNVJDDE4W3IOC3/2NupG6/3b2hu//ziJj+qTP0mNEp2E0ffI?=
 =?us-ascii?Q?tweoHDqNRzF2+hJJMiq8uspiF8KYht3P8d9StRKaI94Q0iWo1FO7M9VXQ7dF?=
 =?us-ascii?Q?dlZGQVZ1YNYYPjdIOg2IkTgXVFZGETU2OcOmR+E1qG9bjKjRxK1W06tVY0iq?=
 =?us-ascii?Q?SAdQUPVDhSHnY2tvZermzIzxtd/dwNU+y2PxkX9+7mL68ok9Di4zE9/eEcuL?=
 =?us-ascii?Q?9xQCgvFzsjJUkc5ciy8FniIUC6ypONq1jitbL3Jp/ziXLIoaXTO+bkiKPLQD?=
 =?us-ascii?Q?zYXAYoG2HK1ef1HFgrscBWE/DXeqWnhD5cK/r482+Slenz6MwDIVNuhZ0onw?=
 =?us-ascii?Q?0sqPBIIHmlkIrm62Bgh6X5NN67zLUt71tKyT180ttfTbmT/UICSFGURUT2Gv?=
 =?us-ascii?Q?zA8/hK0ezpaJjdgBTRDdXcq4fK60ebNGndV418MtDYN+7ydwzdmrK9ajY2rd?=
 =?us-ascii?Q?qPbsH38XR/HfpC3EQ60MgBDNp2RF/jhzZL9bJhwothc1ExrpJfMRgcRIT2/Z?=
 =?us-ascii?Q?CW0rMQcKiMG6YZ67NvI/ebnzBKuz/70q9hGBPLB7FmDXq1GJy/14PyUFuY4E?=
 =?us-ascii?Q?sJAg6WRZ8ZFVZ9OYjD5WYopN5rY7F3s4wcqXri4pKqrpBUJXdpuLKAaqc0wv?=
 =?us-ascii?Q?CAMZkz1OxI07Pv09JOx+63yjUFdMawFarXasKJep45u4tGwQx75C48Jq/hk8?=
 =?us-ascii?Q?RczmbvShtxPKiBX/lJRvCaOlx3jCkiWytrUcDHaAbRKuSoF+GfsAqtjK6ByE?=
 =?us-ascii?Q?CNvA5ssmp4Vg8QKXSnoczQEf75uQLwE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2983ae-5497-49a1-7f5b-08da4453e544
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:53:54.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2VxdO2FLTnTZKkQOF+QnQLEQUeelkys1i1XcfMBUHJIAP6bUvF1/ezKOcBSMwQlJLTDLbsuLgJhTZRGTT8SkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

Use new BPF API.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init(), release() and
get_subflow().

The scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a reinject flag and a mptcp_subflow_context
array.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 ++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 ------------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..7af7fd48acc7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,14 +97,15 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..65bd2c6ab1d2 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -230,24 +230,6 @@ static __always_inline bool tcp_cc_eq(const char *a, c=
onst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
-#define MPTCP_SCHED_NAME_MAX	16
-
-struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
-};
-
-struct mptcp_sched_ops {
-	char name[MPTCP_SCHED_NAME_MAX];
-
-	void (*init)(const struct mptcp_sock *msk);
-	void (*release)(const struct mptcp_sock *msk);
-
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
-			    struct mptcp_sched_data *data);
-	void *owner;
-};
-
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
--=20
2.34.1

