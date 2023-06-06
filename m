Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2C813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGSaH+ae1iFYEkmOZA1E5Eb4p1kGTn2Wq12I45PQrDnwqQmF3zeJTpokLb3mP1ysXhE3H7uinjN2zJ7NqPcRcOZVcNiT6vl+ir90q/1IX+xdxRerkhGzJqsLFQqidVr04gSn9aKpghoTIrmjSSmC7FSSR/LS6sTzBeXBI7bKlzSUF2ssTxfqyuUfioKDzvlm4Swx8a1M3Lsxl3CXudRp0e3LAPIIUie+zND9CsVaZXSra36ae+9Y0HDkWgQagXDqgQGabZp0LT+lEBZ3AieQ/4pFhKNtluCZae3+JtPKC0d8DJ60DnpHCASrklTK0k1mramKRRFgQjIimhs2ZkWApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=WOiXx6yu+sEYIi41zwZWIxGfj2LjXDcLOYKO4qbBc+asJyV1bA6L22KzsTFfRmGxZp447L3vXDY6r9yujSHtDUedRE7GM8RtwVC5IitlC6qPMReZ8zNMdcxD1aFkQVxiZpnAkosDUwGRq6B9J0tl006ceIYvkPnuIH1Me5P5v7dXTxIvPaFXDhZeZBiiAMRZwCIaYFuj2HpePn+Oa6u00EMPmgZeEF7lkMd6ohrsOi3M2bNBglLlGUU9mJ9Ddl3m4V9JxYVHPQfNpiBGtIbVZTBkUtWlYxlTI03FYfiPHaCxDJ8+oji1rDtuKgfqUkBGlR289/GBUQDNSX+JgizIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=E7BWGN9oeG3Mq37HMNmgmlllOfB+F7Uj9dg7YeEkmMq1UHIf41bMImuHMvrp22U4tIxwcazw2JLjyTwVm92Ogdp7NSI8sjLsppwxhOf7r07BKJjlQHUT3O3gdXOpp+EzeYTQABW5ZQs16Z1CY2gWGvbivHVWDEF3v8bpXGkUbRUCIlhVNQpsWqtTbgaI/ubhei6gB4FnsF15VDbjVRwY0BZeG3AoGRr62LcuuDmgD62xjj1JWDHKivFqEQ3V2dIZ1GAf/Dz7O7fu9qp/YursnNmLsJVjDWSIq77mGRovX4iZX964R7Yogi/GRSI6K3rKITfkpKl6CgGBYxFloBcqqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 09/18] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue,  6 Jun 2023 14:45:08 +0800
Message-Id: <9dd59d8a2ce7c6b0d521159d461e61b2a09bcc62.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc821e4-d551-4abd-71f2-08db6659b6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g4cE+sLrb4fva4kjIekRoR/O7QzpY3r6g0JhaAqXZt8A5XWXEFu81+vPD6rlV31RrQ0jK+yCNQEoX5xEbhrpwz/swTMUHvL4mTR6H3RLeXBP2YrFvkApglC75Pmbtvb1xmh40RQNCdhmc5DMEOdWnmmBw3KrlV7fKwu9TiwxlT2EcMDJdMpysm/p4sgadlPYRZnwlmbuRfNsWuOrwN9RdSz+kIgyfH1JxFi99khBW28gBQkjRxC7iTXJVcsxQix8O+ZxGpl+SGW8hKmFi1p+neKHxkDruWFWYGaAjAW+0niT5WgRDSJsyaALxsi/zZVOIMKwq4MHqSkyp+oTIPSrlbwH+OQFBsQmwlqagbgiue15Jba8eylFMc4+ZVXvNx7Kt6mBbz/5WQLTYqnirUBXuRY7HmUzceoYR6PWJB12AwHIqjhIdgq1I8cRFaPtChdoV5nVchBmCwrZooM9GdramOoy5gLh3f8du25FhfFaXDx8A+JIVDbeKOIjGyiPBFmCDTjULq05gjhh74skZH21z7KgQ11TVzt4FgNz5pMLlYNfy48hKnhxqEMqaVdxzSZ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NYl2fmkNBbxcNfDUv3qrSDDF+nRBR3WBPEzF7X9rzJntYKO7Jos/BdWM38/Y?=
 =?us-ascii?Q?HmfwH0EHc3b12ro8Y/FzKBwEHrqSLSiNR0otpTAz1ZWyCZUK8J32yJFGbxou?=
 =?us-ascii?Q?WNy+c8FqCzkJ/m+zXuphoxTWAhHV7/m2T4BWjxkTQ1OSIN7wsvy+upoY9e0t?=
 =?us-ascii?Q?3IhZHFxbK9Nbk5ALBfvCTOZEDkpoBqjTruTFdwtDVFy3OjMykKHZ0DmW5cpq?=
 =?us-ascii?Q?XX4g8gx7KkwrO3EZLrL5qAY7j/JvkpNdMP1vP99OyI/nFjXp+eWyE4+ZbWbT?=
 =?us-ascii?Q?FiTgBo59PaQOIDv98sI0HXROzBXiKX19EuO79K17NUBVKwEINL+eDxG0bYdR?=
 =?us-ascii?Q?wmK7+81AbidmDIhvdJtyPxHDAZa8vffuI4T8uYs1wUsm4xSFGhuMwKRkInzr?=
 =?us-ascii?Q?l7v8Hidk0y40Np9DDyy3mkzIaC3pIqVF0OG26leeJKOCXgQoiSLeMc2lz+tY?=
 =?us-ascii?Q?n+6ks1mbB/Ti4Q2qdQJyZu4USz3B4bFJs2JWsGNlkr+BlH8ZqWDKtH5KW20b?=
 =?us-ascii?Q?7tR0Itfb2npRxyGWDVLlvEtXMyIcjfHfgtqus6+g4CmE+LQJB888H+LtYLGy?=
 =?us-ascii?Q?8yIDgAG9xZo7EKv1rUsaRwkzf5sn3RBFtFGoRjvOTi3s7s+ZA+lkU2Jw2kHw?=
 =?us-ascii?Q?MDvvTQwwsHAjcckOdWUVdqF5JmhjB1Lpu3GX32zZn/8P7QPQxqXawE8Ak603?=
 =?us-ascii?Q?KUnnj3wmbQTj8/un/yOwAPsAvVgZYXsrg2icjbNgR33Cn0CziQQJ61UwNB5l?=
 =?us-ascii?Q?rLW1K86SMq4+m9tAAYxp+NoS1Cplin6h4+o/XNuZBPBdECH3Np2/I1zLZHPC?=
 =?us-ascii?Q?WQk03xQ9SDKu8XMRtfydP/VI0IHLUEa0474XE7+eimrrg+OOG0/9qF3wxkdI?=
 =?us-ascii?Q?F3djFVy7giqz5wMErq55mmNNiC+MofbWGuHVzLyfyAE4t8GdRydeSWWFB439?=
 =?us-ascii?Q?L9Ut56wzntjv5YFzc9tzAXoSarfOy9ayy24UPa2LpYKbSPrt/OUt2XJBpj0S?=
 =?us-ascii?Q?YRBBC3evgZIxwZq1WY03O2ApbxlYDffQQ/JpJy398v8N/ZoVIZoAUGjiGRpU?=
 =?us-ascii?Q?plWJAuPnwPTatnVKV1asRTVaR+6WGeGBfuoVRxkNWOz4koV0ymgCUNTVFSZX?=
 =?us-ascii?Q?h/DCLAUz34O1F8dt2411S98u1QM/Uolu7rSbvu/Zoab/ONNl8djAE+BOzNSp?=
 =?us-ascii?Q?PgiCf/5Nq5XzfF39BCUFikLIn/UfLTHbrqm0BnJgBEVOiu6KdJlYgF+hQ455?=
 =?us-ascii?Q?hKGJ0Dxzgo7ugKp38gg8Yz+ykJ7RIg2v33d81AsaA4J+A7W2tBV9SXVA+Qqi?=
 =?us-ascii?Q?JuejI5TjeDPVoeMWjnu01Ei3vNy5BcrnWxTNC7CvsuIPHaudDty6AuIFWZ0t?=
 =?us-ascii?Q?QFdh8DQvWa9tO4oQ9HN8biF4mMQD7nd0w52TBN/U8B9Cwha3iCy8ADDkKbz6?=
 =?us-ascii?Q?RQdar3WkvOorupGKA/HrPMEhvS+eiHvmjfiPhc7aKBTCOR36ymU66h9a4fxx?=
 =?us-ascii?Q?haBlzFw770GcnTw6xrr4iAfn+ocTQg8BcjNwKHpRp78xvQYAwA5cQHPwIdg3?=
 =?us-ascii?Q?kUJBXqNHOmNWrxfYW9Fv4WUCwTTK9uotutQdfDOj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc821e4-d551-4abd-71f2-08db6659b6e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:11.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jrkDVNMyimNHQUNPl3TQEd4XcTd2A1hzKV1UE41JUcP+kgBSYdkda3nVZb8iAXncTD5FC+uaOrhmm0zNHfn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

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

