Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D661134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKC2p2HwWhIHb5q7fMHPW6whVlQwcLRJ8xL59oLFxcIaRP+scECdDY2MmGFbC2n91gONsE7NFXfSkGI8Wa25BUGFmmJ2fKK0IYMHWDWH9TdDugtwbfa8ucJpwNyFFFQVk16HgJdbaJlCoDAYxHOswXTrsYylbn8Y1YdPHaBZq2q5YDzRSx3FHib7Juj30XpFdqSFODNDs4gIpvnFSWCWiWNjydkWUu6Z2rNlPxvFezfeOW84xkIiF1dhBs6OxUQsSkL5lweQNCU8AQWro3YNi0b9ZEo6mMdqsHQB7heM1FHOLBo4mXYGKs/fZxpDHlNFG4q+RxsosfsrxzBtVlULEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=azorVVxKVWMXoRPiXkJo43KoEYGCoiBfVd++f4CGT9QPpzir5ZAeqgE/VnIjw6B4ml25qQ7PgsnwfqroGg0XHNLSER2H6P/27MIgA3KIhCnzKTFi9nnv3lSydm8yPy2iagTmOYQL5I19rDPdCAyeilq0j4xKQzgWvntWI/IQpoqWOmRPn7z4SrjQLCIXaONfu4OpF/aFluNS7r5yhAZP8zMcBOrtPbUHzunuX41hhQ93Z4XfzLzmzULKeQMvfpobmSSRezk26oU8PjlVlF3xnn9Lh8kJQau+CxqJPoJuUnllDVJhaHOfrbdEQpAcQ5XQ0vWi3KuQ8q2iSmXDzdH4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtszVzvOLS7nTJFoB1l8sqjHwPICYRstfULI4y681uw=;
 b=4jGPM5teU08j43iFzfw0D1cMy8yMWM/USJ/3L6uovLzjISGuQ4o21Doq8iCc9Es1pelnvsrQUo9g3Q9pRYDLdgUnymyEX5ktA9c5+1Qs7NV14UgaNHfnuPkypt6/g5mfrC1WdbwG9rtlIKeR0NlJjzzH/raE+J+OBO9o+oAx9jxlQKoPgpAosYqu2A8ITe2jNDVBoyHMvEHVZ6pv2TNcgejeNX1eWcXXYG2eBuGipPX2IsVeneBKjdXXJVijsWStNwZITYWSN7xdzZXM9xhtB96BpQ9ehmPymvu5iXs665azwFBUX7mqYF1bcJVX1IoOb7NgpaOQX1M1YBhK96HhDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 13/15] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue, 30 May 2023 21:17:33 +0800
Message-Id: <a88690c5ec4bea6877d5971d9ded162e0a0b6ba4.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0187.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c691d9e-ac9f-40c2-221f-08db6110899b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vtIfL11S/p4g34b1qgedrTbguX6qHOv8GdaBaQuE5glu5bY5Ml4u5E4eXBgYRgasl1OBFWripSx9B49xoVZ7UvSB+et2PUaMQqru2aNvgOQfWX3BT51eC8J+/De4J3FQkPP9GsQHQvd9ry7uI5qGl0S18M4sP+TS2/qx2RhUxjb1Q73VNm3zbfif6Wb1lIDqqlgepOxQvMQ+3eiI0ovKmD/1h5WVR4zR66JH6+UEF7EsqO2o9QzOYDRpW2uL4wQLQ2zEgVwLFcXJhkYDkkI3xNWvAeFuMnFh6eo9SL/fk5s0YwOwk5OgcHliquWCBaXxfyJ+po7c5yIkJlm6qpcR7dPNZGqlHpQmXbgkNlgJQgYEDe+UIPXIo+zEy0HR4gL1YcXnmljxjDA0UO+4tx5UM7Lu70RIgsQnzUT8NN/3wyZQ6vUjV3Vnqlu9H2EkoQdk6ZVjJdUR1qUdlGMriZJmpEKpqmCZbJiFJArPfVuCC9eZlVVjhXmC60JHGD69hMvIbfqoe+h0L//CIkafZbFsgpWPhkBs6fLQWcF1gzj88ojUyQ4Mpr3AKZz/LHSyymrq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UH9e7Yx3uDgsKMsOdeb4JqkYRyGQmbT9UPo3oz6Qq0zve2skhM7JF+lCo2Nt?=
 =?us-ascii?Q?zgWjdxFGtT9XdxZXc+ggfu9aNGea7jwWGTGnWPOmmbUxijEO35X60XVU2uzY?=
 =?us-ascii?Q?MoYTps7PFygPsbxDd4sdn5BOXTm9/4wRRnywEbw+XxtkWGRzOZpab3y5Puz6?=
 =?us-ascii?Q?XC1DWOaHqGLjfA+xJRwHL97BuIwCb7p0sxlLEs30W1/fo1wSfbK8DXIVapMX?=
 =?us-ascii?Q?EnTgIt17fSWbfM4JI6PfMvFRkyhf+RDlMLB7v/JEF5bQhcG0u3J/uAFmNH0k?=
 =?us-ascii?Q?D2PhMxF+TOzrDMkrP9a1b4WJfSSKBh1n8odxMwEKKpXo6JwSYc2mgRFTLU0R?=
 =?us-ascii?Q?tOX82woE4Af5s5qHL/FCBz1srpBhMA1TOS1mpXGYHWftdiZ6qnRGQqxR/4TC?=
 =?us-ascii?Q?iodM9dKZqKjsz7FhPqQazURjnqik1oT6oTeVxvbXhvteWIzyQhOo4c/an1yk?=
 =?us-ascii?Q?4Rx6JInJrtANfpN8DKh4EuKxdVqcc3y/Ug+4dH4QqhlWleGTL1xEB5ZO19WD?=
 =?us-ascii?Q?n5FF0OpWTiC4+jyRQMoiCTxHdqCPFzmzP5Iv13kddBDALHXehY6PfD+g9Uha?=
 =?us-ascii?Q?X8a1yhJCU7LT/vozIlQg8LawkJsbm489n+sMpk1wk4ev9ZNVPQ3MLYSaE5do?=
 =?us-ascii?Q?Tu8BIDbJ3/oGmXMFQwVLrhyB6Pe75e0lGxOGMWj7CV7rvQx56gT44khw8OQA?=
 =?us-ascii?Q?fU2SanWYceOZYdoQSoog9SzQF1R6nqkMkiNTxrvD6oHs93jcMP5ZUVDtoq/k?=
 =?us-ascii?Q?coo5u85hQzXX6g0FkPPTyMyny5A514yCNh9nmz18YrgM3tIZ1ngAxq55+fUy?=
 =?us-ascii?Q?95jSL+KPhm+dP20S5x7m/ewDcplFEcHghxRL1p1U0FQC3MJOgppipO6jfR78?=
 =?us-ascii?Q?f3QaGJnbzyfqBbf4xjL59Zk3xUtjRqRFbd9R+B1Qxue269TcP7A9XMS0OzAW?=
 =?us-ascii?Q?Ak4H+e5doMeO1lpck2DJwx5/tx1BIakayfsCG5lJx+n+8/x+EEs1HqUG7+IX?=
 =?us-ascii?Q?tGeZKiS1WM/N8bcis2ShGLp0P6dxpfTCX6r3j7mUveLZSJ/iXEqvBhX+z52r?=
 =?us-ascii?Q?XwtexgqWCxVPom6TEgVI5lsQcv4L9k16ZSJpVtI78giPA9PnmszCW3h/0jmT?=
 =?us-ascii?Q?FCSZG7+8a0Ss/Qi1pWkrkmBi1sQtn7+CYY+6XqVIbapsGxPQqV2XlnpvSK3Y?=
 =?us-ascii?Q?8SCpJpWPcuUe3vV7SPJD2LHe6Q8Q9VblY6VwTHx0IKfvdkFXQf7S+tg3CYc2?=
 =?us-ascii?Q?bn722NxU9llDRAaOIIWVD/KymRg4EbCcK9IzG+TWZWPViN+c2OW9SdfyJ6Rx?=
 =?us-ascii?Q?gpJ47uqazqBHKXwIgqb2tOYuKQwqppq/+gWxsJUyskpY/e9eghN6xfort2Lw?=
 =?us-ascii?Q?BLF7+h6Bo+fte2z2bUkmvDmFvXg2LTF8TRn0EN8Q9m2/dVfxvOCPAZ90Ld8a?=
 =?us-ascii?Q?VnPePeF558nP5+0Z/ikxKk4+k23f7BnszZzqLO6QS+YM1CthOUMM9EC4ypXL?=
 =?us-ascii?Q?H/LHcHrAo0JowZpGAHzpDU1NsQm4TiQOSZe7sr/5Sbp/Bwz6vG+CVro059mq?=
 =?us-ascii?Q?HuBe7t102xyNyAmHTlP+/0nAXwoYD1939ipiuVLl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c691d9e-ac9f-40c2-221f-08db6110899b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:46.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: creE0wQ4IvkCwaLl+4umxaMogqDujKsBd/xwLZcg28FLCtBvD/8Zt+VgChTj2kWOyYS+iUCO0+eAdfaWGRagBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

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

