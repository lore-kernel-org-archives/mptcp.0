Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E53D8A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CszU/cr8Yh2Cc8CUK/yP60ET0m25V3TCZJ+UtHBpUSY71uMjKQqjVw3gWhFLt8bvcVw12oezn5ciVlbojYq6OYfEqKM1nY6+SPb4h/OWzCNHUnC/ni04ha4dxJlx+OHRTP/yxmVncZiGNdZIZvpBgLYQUPSXenGnVi/7T/LG+1gAn7GCJ/oHtueTK3uUSyYCy0VH05/VSYxB/ONV1e6UA30mhSr0NHnCd0AqxEhkdk5+oLgV1Flk4/jMS3Aey6mzqrKmiSKXEDfrrvvJZza3m74O3L6FWzKfJUbHLIKUdupaYBW9FLLp0bzC+hF0J8AhErYWCIBjP9QgbEkBYzMxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=M0CJjusJfAwduNU4ynEoQ2ZAXZrQtd8npXpuuxB1YS9K9GQwdrsYiFHoo4Z1QgmcOuffQDREk3PV7nYletDXsW+ZGbk5Prae4FuNnT7x/x1AK3aYtAv/iQk1sve5vOb9kKctDbMvrBDwvPANExzJBZKbTzR6kUW2LW6D34XhaSgPAEC8/3/apG8MB7kiMNOqU2hLJ5aYI10lyc903wGyU4VVGMTz0AMarBiDxx8NLZGkARV4Ee6YfBe+YtEVh6kxO51I9DzljdbfPR9Pofz2c5yLC5w3fcyvOC01s8x692ODWfEHQIaUrO//PHQMiQkPq8GOCfkxP1g/+MghyfkM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=bhpD3iVXpCRguYxw2mqPmRwPrnm43Oy1Z3avUguSY4webd0LQyheEl2vCVm2WAC6ErayIWRYN1lJL3Cx+BtEtLNmjuziKsd3Yf7Wb69BOeGj/Me8A42WcpQbn+NOPx8MbDcAu79n5LEIU5fjG4kl4SniglIhS4QA9IfkNf12hj2S6k2zj/hRKnS+PL8Rf6S55mhJgJ0e/jVerRfH8z74b9dFV9P0JbFYfXUMnugX1gkzrdEaM1L+JHeYqKv6roAGe8pOTfiuQRLZdAs6iU7MmVr6Xdl6rsUWcQstZ73oZeETy/1VrA/+Fdk9nCDmlzq/JIvG0s3KeYBmoTj+UgLXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:00:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:00:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 03/18] Squash to "mptcp: add scheduler wrappers"
Date: Tue,  6 Jun 2023 16:59:17 +0800
Message-Id: <78c762473c2b299ebaa301b15fa9849ddf7d14ea.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c1399c-692d-4c8f-31de-08db666c79b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IP4DXJ/Yc2o7J9QWH8IS4ktnoEI3MT/AHXV9Ui6W/iF7HcKyN1kRG2mL01xqVxHy361zFQRG/OrMzyfucoTCoK9u1YRDZbgZpp9MkFgv3e/NoifZZ6miFH/MnsPSJBrxkqNS/OA9aer8OEsKnYnvoIT5kqvbcFQTSMrXNkIxHNx24jVLscIK5BhiL/xGGFx1HRSlQts306HNfm4llHvcHadB7wKxvXU4ebeTnG345kbTIPxR6jicW4YP67mAxgXmY9dUlDj2tacPNYCDtbrRkOXSxILHhiFQ6RXfZWbsol6OTIY7hwUcfjWRZEQ9D08eS6t3X8sYZcEmJvdqaXh+aVfL8hsBl03NZkP+4JR+PzOK4pFqq3GaEYDFsiv9ajFmz6cfjm3L3I+a3j4F9hrQLOfA5lIxk7i1OCpqgnxctSlvCf2PQyWBCWIzBTpC5eGqAngPzKB6VJX3KA3Ib7JQTdsRoXKM8uFG7Dj/cJHogoJoZ0cZ3B1axsR+2WwDzsOpok1pxVO+gRQPl9lBTYrTkIvP+fcfCGjJgbPX/kc7HYW6QS7Ba7sK+dvEY8zOBC7Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvCgf4jJEnLm3ooebRtywmOC3MV8lj2PAwSspJW/3vtylZ9R7gieQvyMyUUb?=
 =?us-ascii?Q?cE0ecKcpdz414B5lzPfyVIowqwNyry/UvB85mRC+AyDkwwxWK6OGOrLi/Mjg?=
 =?us-ascii?Q?EwSVlHHhJbUQsA0nJaxXuTmLCWm6QvmES/iJBOV4pja2G/8Q1YTeVAtbVcYy?=
 =?us-ascii?Q?JvWO4ecAuo1HAFTBlFgWRV0vjER7jcs4TZbPrXGPDzH00BriBSs02hW84Pnb?=
 =?us-ascii?Q?rIJ3OJ4puFFF1R1k5fTtYgwKVS1jEtwbKudXm7zeSIOHVE2Osvf/yZFCmIY2?=
 =?us-ascii?Q?XYjgpv2+2F5/4VNL3THyukIZAeAMmSC6frwasNn3QGTpoIWwDM27ruPdTb9W?=
 =?us-ascii?Q?LyQw18alKHyVxatAzB2EIuVp/Abx/+B60ImR5f+CteKoHSQjFqxzvmKLKJF1?=
 =?us-ascii?Q?qw+A0lvqlUWAJl4qnqFECni2NTdbzrfBU2jzTcsY4U1iaDOLgzCwKVfgUPZo?=
 =?us-ascii?Q?uwLesM86sX/h+BR/DVsAx4zBLqyKsPiszwjPLqpzOmElLajjMorROEfSKzcC?=
 =?us-ascii?Q?YUvkJBnCDA0/7xfZ3XmDQrjtA/UAAI/eETEsGkDMONMqfbpZkHaqn8Bq8HAE?=
 =?us-ascii?Q?fqOUxlxN4PXM+JEtYPHE74tgb60KnVlTLFyMCJwzYwnXAd6OQdC6SRs2Kpex?=
 =?us-ascii?Q?5nLQiGZEp9FbpBzUb1M7iLNZjC3wRks6LJjejdunQ0/QpOkYToRvuEdjoSXh?=
 =?us-ascii?Q?ql5Cwl7npmbzTNp9MeGRDwRcSoWgiGVPEeA/8UR3CPcPU27nqte4xuoXrZzR?=
 =?us-ascii?Q?MApPv3gNBHrDdnvgeZRslxeVjO5ExIjuPFhVt9HUr62LKLgwELHPTK+pxSZN?=
 =?us-ascii?Q?LmMp2M07kUs5zdzKm8PILLpeq/mGf3bb0FIsuQinei2Tl0ause/iBTdUxmaG?=
 =?us-ascii?Q?b4kxtNT/PQHQi9jx9b8RCzMWr/jN1tANWQKPqDEM8EGqoH9YpJ5D1/DfaNW2?=
 =?us-ascii?Q?bUuNMxEiLyddXeZJSeMEH99aCFWNRkuKCZITnyfGScS+x4dj0uYAtCVeQH09?=
 =?us-ascii?Q?4nZ8g7r7U6PBYSttc9jAmEZNSnvO2oUGaGKsJ01YLtNFFr4kUfGfr/VhFFHf?=
 =?us-ascii?Q?dFjqP6K1hQhUBzhpyjcvB6tgD5CPQT5VncrvbASQkRb4NndpFOScSyPL7EOa?=
 =?us-ascii?Q?fW6e/Aj+wsz4d9vSMYRrr83kaZfplYpw4MYhKPVtxvvf4PjmthFCtBDzLXMg?=
 =?us-ascii?Q?iCkeL5ysu9VPsmFiyyqPCVcGIlTzSYvLxef0JIerfe5a8rl5pFtyailLNHSj?=
 =?us-ascii?Q?6v5P3s2JnPMDaZoc250sHEPjRgA8+QvjZDf6MoIcXkeBko7fgJDWWEF0a26v?=
 =?us-ascii?Q?wtXqK7fZ42gKbxBwu8U4DwB6LhpbNyxoZ1t9XJefWrU0XrQxiV0hIYbeGrET?=
 =?us-ascii?Q?kulaF53QUHfzvotUwMgna28B9Ri7oGU5KW6wzUjZ6NWUsR08cryw3Ve07ASE?=
 =?us-ascii?Q?0/FJdcQUhBXn4MX6t0YhxvQRt8SJQRANfQnMWda3DR8lbrYeWailIXYaFvox?=
 =?us-ascii?Q?MJ8DLM+OpoNeP0gOiHTH2R5I7JTaGUotYFzpX5MVCVqQF7p8wofBSqYiV1se?=
 =?us-ascii?Q?2osu4CiqMPc1jK/q5y0bmgS+mw1uBuZbbiSF8fXI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1399c-692d-4c8f-31de-08db666c79b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:00:28.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWPiiAnFaNgrbIvc4QDkLfVy2w0F+iQNsV8NofNjaQYcCj+8/KiEotI03ry1HKZoipMVlvkzKR56wr0O0bzBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a053a9504dfd..5438a86e897a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,7 +127,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -157,15 +156,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = false;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -188,7 +186,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = true;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
-- 
2.35.3

