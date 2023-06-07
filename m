Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957A653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFzTO/0pMZZCp1AdZKD4QRtWuvj+3r1vkMFrq4eIHmUZUdaYbt4ej6SrSv2p99kS2IR4fFkd623MLdrKLLTtA4omX2qmuFNI5WDSLlTmae+q3GQGx6LKycx7diQRdTYMA3MyhIfiJr+JKH70isUakL5M14gEi2Y7tbDBrVM6JWVy+ADAsB5gYnBEfQfmqRFN7fk2nwqI9IYje9QH24dKMGzV20YIppMonne99R49MjHMehP0F/CbuCqMd1/rfQrKrLP10YbFSch4uaRDr5NVDZDNmuw9bYoVDnlOO4OOHZks4kueFpxHtLi8s6V176uABTLVmy2eqPo49pep2/99Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0tNSe541t6C7Eb376DWnMqtQlci/zhdSGydtxW6N5c=;
 b=d0HRBIQOtWSOC/+/lv6cdD6uC/lO+rwcwJ0zTXGzmXhS19hyij+W8uJE2TO+kz0hoeaYxawzPL57oWK5h4TqyOIPBr/tfDos3392Xb6hwi1gbVYj3opMxRG3xOIsUpU3sEyMTAgJNBhJYV+Q8DN6glF676ZIOfGjt3XzBVVUtaPKr5wxo+vrhO8M3lIeGcQ7KSo5t2Ex0E2h9rILZYcj/nhcVqCSclVyk8ASnxVYbuQ+WlrNecb6qrVrYdtIij0JtyBThqP34D1ayZLmherkGMVNAl/NtFKlCZeRdhr3Ic419kQxDp+dMZe+Q+wa8xwYDxmqQAj9/73FqDLkl4MacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0tNSe541t6C7Eb376DWnMqtQlci/zhdSGydtxW6N5c=;
 b=ZJrQEyrauqHWbfJQQLpdz+XyMSdti8pcADXehTYYUQ7SE1OqMxDiqA56fD56YfFkE+hi6a9hSfGBAuLLnohQ3yWBBioAV/f24ty/uh1VxiR3qpIhCiVl7RrCG1al2kLd1eDOqH8OGKQsHS4f2zfjngSVLF66pDqZD9YnGSnbTSCoew+sTbGS4y0Q/P5E6xt9cC+hlX0AZrLJfq6sM55WGJnkWeCZAMbJoXWdNAXqktNqdvuLnDBwgA0S6vSijFqMT+UzJBaV044axD4qhLsOvuhsmqkEdqIXY58JBhN/3KMxJ4OHQaSMwBX++1ar6yImT2j2y2VoG6CXHx2s1yknmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:40:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 10/19] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed,  7 Jun 2023 16:38:25 +0800
Message-Id: <8fcf20d2861428ab866c52d170200ecf6fb86a35.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd84648-9177-4d89-88f4-08db6732dddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tnsSMJStMI0O9ktf0k7RCRe9rfATy9jeJgnR+pdkd3vx512n/xKmz70ydLNdN5GXOJGoZh+PbUpuMr39d1OdPzdOUgGItfIbRg8h74dus/uIyxSC+f85E6wMqsftTmTvBJLzl79BBGmT2Criyrd9eVXsE5B0k1IQ7go45/jQliPhRZGej3mt/jg6Vb85sVRmDbSQ6hS/EiRhp+XBPqRjzgUoEaDNDD6Q/rAVxqGCHQwsTnA6pF2CPo9WRnkrivsVk/3EAWKWrVncp6lpHY8hrgjNAljf+RT+Ucp9wRoAY9jcSIqhK+rorudOM9A/Ud8oLDrZAbJUQivfADj2zCJyhvGxL80i2fgxQDWffkPddwcyeTH9Smaa68KUqPNNNsZkAEEEfIGdAQ8aPOWTuRQ8VyiSQeK7lQzxB3rf7zvhWl9MzTiULiu/rfkVYKH2ZQ+eNM5aVMgMhmnz1DshgqrSPK99J8g08AGrgjuIe3JE1n8CpBM7XgNDtmPrZO/Br9CEuixPsvDu42i37A2zWPH34za24LA9+6EUaMGIfrfhU+CdJjQYsgxljHMxRs8pXb/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwqq5mAa0fhfW2FgIC7b2zYGkBTRjmh8fNnuLOwKDrrn+NfhWOclECr0BSBx?=
 =?us-ascii?Q?Wid3i7WIxOwUrL4spR6SwHHi2+Sp6Kh/pbc680IINdhhwERj+pgXJfpJwVp5?=
 =?us-ascii?Q?qsYSZkFakgz2JDEaElm/oi4q69/KJ2NuXsfi//94J8rp0y5s4ias/zmwuMh8?=
 =?us-ascii?Q?xYUa8TKEgPAWf7hY71dHEe3gHHrCEt3AE4udaDZX1mEQ3RWuYixlFoBlb6l/?=
 =?us-ascii?Q?0MxGkCoiT1UOMZt2blLT9jotBegoNYvRy4vpqg39Qsl7o5ZbFwhvQneYJ2hl?=
 =?us-ascii?Q?ZShE2LlfI7iV+a9Pm9Dg+sY0mOnR/qkACOnXTZrC2cTqUtnhAdvxGKbK8rE2?=
 =?us-ascii?Q?dKLLd6ZZtTBH3XUZo3QpoA8BIaa+oAKnwmdgK2gR55Q5mc7pjemmQL9OvesO?=
 =?us-ascii?Q?gqyWt72uAU4Wn6KMA7zuqTOZ22rA3B28k4ZfKFg0NldFiuUUHb//ITnFlCh/?=
 =?us-ascii?Q?kMHnmkMXAEQjKHc8mXqAJsmi/UFQe6lPkLi7GQnyAwRk1oTDhzFTnHxKdcLn?=
 =?us-ascii?Q?jUv8zJCPXCNGk1JFGQZujESWOCDEV3oKGW7UjsYVIN0u90qWnNw7KL5ok4qW?=
 =?us-ascii?Q?00kddsSPvTSydhB1Wsc0n9X3skDCCYgpZca7hCpQZ4CgXHy89axpsir8Xyyw?=
 =?us-ascii?Q?aTlrwPE2oAIYX0NRoQdT5ZrXVfYnPHQqnMx7jPRAkLVvJqBsAPOJgVIaKxdd?=
 =?us-ascii?Q?VPH+Q7m39eAovBl2gSa7HCdds37XK1fvvG+IOmyT/OfXwXkTY54TRpX70Mks?=
 =?us-ascii?Q?NRTWi3AB15ryanvOHZCGS1ynLCF3cck07LRI/Mxx8O7o0uilYC6/nv7xtE66?=
 =?us-ascii?Q?9F9Q95I92tw2zrPxt5F+TUKbziupNl6klu7hoVToUTq80Go7LkZJKmzLtO54?=
 =?us-ascii?Q?GvzRNQ9I9dt7KVNAFcddDQ7itZ1smdnPuTFkX1XvBzcMoE+1akD8GRXfFn74?=
 =?us-ascii?Q?PQLOemaL2vdn2Ku6rRr8uPgQazqvp1CsyfY83qajcfll1bYMhIGnMc9BhuAk?=
 =?us-ascii?Q?fnZqrD7tLwvfycyFMqEnes7PTrN86g67tqj4Jp41Q7NLuTfBuCDRotwHIY6c?=
 =?us-ascii?Q?VI2MFDPhXQT4NMUzaher0RHANGlfWP+G4dGVlcTrmAHFDMCWwSpTfGV6EiO8?=
 =?us-ascii?Q?sPlD8uP2zgWr4FUVyKEEDsBHYUF9vMvB4q6wMyzNIrkuorpMJVLkmFfiI7nL?=
 =?us-ascii?Q?r/+pAP8NwGAxfI3ojjb8VthWG0uaBmcUzxve79o4fOIbHp9eTEOdTd0HNjE9?=
 =?us-ascii?Q?DgyVEPrnCBBVVIHmbdoj9URb7TITl22A+zHyF/kF1kbkj1IESdBLZc3wws3V?=
 =?us-ascii?Q?tFYVC45Q5VCNKyfNtV6UX/0YxQA8GhaJGzLx24sosJxCVoAzK5vzAQQsxJym?=
 =?us-ascii?Q?DtX9AzGaHocdRxbgCcdtruaKLVxWqDdrT1Spf2XGqwZsvBcQURjd5shUJ2lt?=
 =?us-ascii?Q?o3cYnCxHhxhO/IExyA5c+4SnA5MJjYst4b5J9XCzO7ua4V+PpTXZUNsbY5UP?=
 =?us-ascii?Q?BMXdu/ekQ3d5lCgDHSF5JyYeUZCEZzFv3RLcBl2sbtDd9KORABACFZHdcKzZ?=
 =?us-ascii?Q?RiL8/74OnC+6Yzht0JZddTCKQ1i7VfdCTK2xg4ix?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd84648-9177-4d89-88f4-08db6732dddf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:37.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HvonyS011DX2feteUlQhGOTsSIK+wudkSI9zsyx2BbrR+HKR8sVqaWljaUQbns13aA4dW6IwLRV6eo+hxmpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

Use data->last_snd instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index e101428e5906..1b858524984e 100644
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
 
@@ -41,6 +41,7 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	data->last_snd = data->contexts[nr]->tcp_sock;
 	return 0;
 }
 
-- 
2.35.3

