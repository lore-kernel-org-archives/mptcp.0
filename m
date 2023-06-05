Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958E5684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDgXSWQaF1cMmj4mWc6Gaok2spNUz4spS01lo6UOaNZ8OEQFZisgLbOVt9a4a8PzNhdYNS9oH8+9RlQ9ESRmgBDU76K1lditqcwT153v7CnmRZjl4oXTEeerJEWsymRafYd0kAkE4QH1N5XVWuaw89R3JCQntmULfFROBzidSYeQ8XL/HIC48FIK+DbSDyMW669I4XvLpSBeB9TchqMEL99tR9pbzWSKKxhKMS5+8xS6UX6egidBQVcpeanOA4y5BEEcstr85EUE1uyHuIh0/BEfMGDs9lE65KiNZC2xcpVQDzgSytf/AQVJ9WRpOfeYhH2YEK6uINvk4jRuB+NGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=ccidK3nUjK7QMwik72VUi2FzC6ZTScXQsFMwaCQhNpKgKYe4QcyRvbO0np9YxrmLbmiZHNt8eXgiQdzHPok6oJQn98N9jxHflJrr83zpV5kHPrzUM2gq4D2ijSI2Hvoc0FfEMKb0pDwcu5hGEVdIFCht3DVAbJwNPABtdWaMAsU/3u3E4FjtcSiwcbAtjHm173xR4S0TGYHPU4SLTqIWyWLbrrSCLCYXcvn2N8T7AzdrOgH7A2KrHKlnNtRlVLEvl7GkPHkfAW3JX07irnl0NYu7WUbycweILrwPx/CHUjSt3jz04SPaRIWQkAWOgFeaq3pv3SMa4p2XjXSm1R5WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=FhdU4BfUStOmB/H96AjzhzXjBmJZOc/+Y82MIhjzq4SoZ8P6G+z2WEhWiHu2oRWRsYbztZHhna8FIhw0TqiFS47Exqk4M2sFvNRs+jyoj+1J9XrcZswek1SVmG7W9D9SHRtEA1rOL+asqvLEN7moN0mUzOtQJ2rFTknjepjqcWV8iMF5pLcbKCYJVsPB3VckmEYz5tF3mS7oBpGJcUdzwm1PSnL/FvJPZYe488Wc8DOKFtBQb0Zpkfz+S5kVI1d3P8HLhXZA3UV6BNy+udFLxpygDgjcCMY0ri0n1W4u7aUSf9RkDY/1MXXagKLJMr2eEMQWpqvuwgHaGR166yCNGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:06:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:06:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 12/14] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Mon,  5 Jun 2023 18:04:07 +0800
Message-Id: <04b131a44cc727b0906aeac511a42f5f1e084cc4.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adcaddc-c8c0-4d89-6d2c-08db65ac77fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PpRce+LdJ3Yt9pa1gFhJ8H0eB5vurfq9H/wZyosNIabaHXdKM/i822ARDo4MnWeyS4PBgTYdw4X8byLG4qH9KF7uANrOqww3whIj6YJ63ejjFDZPhJyyUBEcqkhiJmlts5DU3ikgnY4W7xiV8yIlr52hOGKxEPvwtHKRtmKmOuFxUae7k9F/anHSPZPghEJPsJE3kncvJpLyjGGOaxmJdH2t8Hl9RoIuNes1pqGTCq5E0mna8Cq9mq1Qvphb4/TcYziMslYSi2e1d/juEWZBufcSO2+gn1iBUryVlhZPM+1Cx8lXrBqQhaZOm7Bzl7rxspdzhmUOq06F4atQqvthK+PlSs2e9k265cUg8KJ116EMiJhQ4FjjgUUnPbo8wnT4G0AQ0EeB5+6Sy+AR8txcD+GGVtZM/e3AIxLdprTgojqEWLKj0Oo+9aBDRKg6DomBo4I38tnh2TXvkGytWClfDr4pL8NdZgm6yWY8xMNcFkPzmGDCIA1EtdF9HCB/+KuwV1Sl96+LDPbvaNXomDr8QmftyCr28OxbqmK9SF7o9gEXNnfUABHHmNEHanDDGfj4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hiq1UXvtteC36JnuMH/AXbuFsW8eDxlfA/JeRsHNqsNhZOFfSnVWb2uwME5/?=
 =?us-ascii?Q?IMVIV1EVb+xAEuXk59G7Ph2HfiVeXyzERpoQSNR2xwzUMMuFtmNu22ytpdfW?=
 =?us-ascii?Q?mW1FarKfVLNVvEZUH8zVjtpklY4iVCnlC7OpzKhxX+TyldunquCx9lvsBHly?=
 =?us-ascii?Q?ks0NjbNwuUXeSdaUVzzrsRCdaQJBcnGT3nBKC1Qkx+HH1sATnPh2xOs/5TCh?=
 =?us-ascii?Q?bLr6QTBclY8T3a2DOyad+2l6MU3zhzn255xXGeAOR04bI5vczUWayrNFRW27?=
 =?us-ascii?Q?fpDstpUmAyRS6qafanuXhXPU+Cy6EEsuBDiwgHK8Hx7yhJCGpNIETTI5p8S/?=
 =?us-ascii?Q?4bWWaTajZr4qQzMtoc1pZ+cK7wQu4vKSoP7R//Dd/YhVG+N/JJKd0ARH8Rlx?=
 =?us-ascii?Q?Mj8jTwfL0qsJmtb9R47bRc6rdXuwlOcQFNWhzB6CiWeH7AeitxSDtop0I4TW?=
 =?us-ascii?Q?kpRs2UsY4XLRY50v5LiklrSyE6w+eTDSdrHExXBHfSZC/pBZosxlRfchhssc?=
 =?us-ascii?Q?f4ydVzQk9n9Cu3wQ2eJs2qxaVb0ZpW6kJuL9i55xwI6YQ44Rh+jXFW58w1z5?=
 =?us-ascii?Q?+ap18CeQu119IumqUd0Zq7JwcjYkz/dB9Ilzls+kLdzZhbSJ4g3hhTEjcZ8P?=
 =?us-ascii?Q?zG8ITUZ8My7+I8cPOT5WXlGdmie/mj5mbKmdOdOStkStIW6fNKnbBLxvKiNM?=
 =?us-ascii?Q?AWOuu0g3PtnJe6YV6FomX6wvNtb99x9yq0LRHdjY3TKOUzVpKM+O4YHViIr+?=
 =?us-ascii?Q?QGPCUv0aKzX7ub0x3VQ2jKKf9qmgmeWEt7HHHAzjwQoCNsFiHZKU5/0dZ7wC?=
 =?us-ascii?Q?1dxEu9ZYkMfXFtTyz6ioC2DqKRGODCJ4qsilj7lx1BX7g9gDaU1h4G7UvmkE?=
 =?us-ascii?Q?PKRWmLMtVBu3QvadljNy9Jqjg23lCo6SGdqgMoZpX8iUyX4RfKwM6rjnQAaZ?=
 =?us-ascii?Q?wYFl98tvc2heE5T/2pZjupNsfRXBax4ROnVKQGL05LYWgYUHgO7et4sCaS54?=
 =?us-ascii?Q?NP+xJWWTDa/q0JbXxmrUwvBR+VhulAQQyh/yR21ch0fmfcw9R/cj35TJBBCW?=
 =?us-ascii?Q?0XBX/Iqa/Zw98uugOkLH5c3p/iGyUd7vvJsziZUA2aeXmFdKnMF2mBBJyrLE?=
 =?us-ascii?Q?MzczEoMUaXHFeEqMtpEV1+JHh9tC0QHi7eKL5HZwLK90cg49H9Bn6WHp+dgr?=
 =?us-ascii?Q?e+4LOj+lLiPM1PP2D52/aXD1WX0SurwT+2wVUe8y8SwYkDrpXAwuqfMtNqcx?=
 =?us-ascii?Q?7joArDYztY+Zgn06Qt76pNSGvcevy3iptDzKdPfJpCUYMx74a4baGwN8RNRJ?=
 =?us-ascii?Q?ug1/2FUaN3zvXgEG7cEm4d/nvtIjR1AR+a5qZjZC2KSaKpkfHx7pQs4A5hXD?=
 =?us-ascii?Q?K66GMeqwg/jNA3zQE2+KlJBthwuC6n9IDVBMC+PH2e99hdpyqlKJOpQbhNqB?=
 =?us-ascii?Q?ts7dp2/dvqabXnehNojUExuA5qewKUG6nwGRkgRRa11fIRP5a+Y+GRA0NhxT?=
 =?us-ascii?Q?2HAWec5MLdk4G0yuLytZepiRixaPcCNTA4dJ360IF64c8K+RizYLvd1UdQS3?=
 =?us-ascii?Q?meWwMjzXcCGNNcdY2w9IQ4EvaUJGxrHUA9XMMVpyu1Pc8eIyH8m9g6rqmjrN?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adcaddc-c8c0-4d89-6d2c-08db65ac77fb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:06:02.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD6maNN/bjzVTeagna0w9f2MwfV9ziHTAM2kTLymWR9DPhvJXOfwDD6reg1IsAhhL3KtTbuxvOKQ/S3cAepZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

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

