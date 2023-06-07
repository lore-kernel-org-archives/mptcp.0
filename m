Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC35664
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm1ZMQH8LnebLU6KHjKmH4ckjUOHa+ryV/gP3mquZpEzvhEPsdnfRsfSgQp4DxARPlS1k7ofUP3TOfvCe56S3EdNAZ8fc4PLUD+hKJjKxmt8aQ4/DW1liqe6QoqA+7C/OjwYVgh38lV94G/fzJoN1yzi/GzTEQYS+11RD84EFgr2Lji+3aGB49ePMT7CzOHdSTN33flRGmcjNgE8nMzvIO/cDGKHnmYT1QGfkjtH8B3jeYVgt63VukKup95hf/8RwgfvJRqAob2ureM9gE81zmVWkVDXseQsH2OcOIBxND/DpVzLpdFjleMGIncmY+q5atlPkqiGVprxOndWeRcjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=DvPHrtDgwbu1wJUPLy2E15CDnsaIfruqNaQtX6MGmMLltEdOv8o9+5rg40dl9nfnKvK2ZmghzbpQMHLbv1Tj6fSwjAPcgCk3lq1GZ7P7SvIY2s6EZLn1PHIN6CU6jSYEbIufSCVbwAfK1Xw/ANPHJV0cArXXtr/Z2Li4hqyWDzaqLAFz0VlXYBlnTMj8Q6yB5uR0lTZmTM7x+j1cRXlfKAEGBDCd1BF4zQiDEdD6ykr/ZUQqnIya8dw2dxxMmZOkwsXpURKPiQ0/Q19Yqt4FxMB1t8asQXF6ETctDaJ9nhFcByZAVWTwEsRys5oY5mOOVbvDskrZe/ixAIrwJ53nCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=UkMt7NqrhYb4N0YkkS5W1WzboZi+4A+hKgu5VUeYBOqQWKNRKgIRA6MaBq2+zBKfLWJmOvxKjT/G0iUIXl2npvxhuQS+rOb64eCl//9HkoVZUACNuPhfFAZiWKnqubgfIejeHCapcIw4nvAwpASwb1bW0UwSQ3LsPFjFBOvKnuHeEfRS0V3nCO5M9dMdhC8/erZoZQ+y0yeNkEQvHZeOt56AfiTQ4pkXfVNC9yK6YmKE7HThpggTsKs85zZAzfd849oZ3NtGUf5QS7KX7Z/7ZmMPaTE3j787fxIXjIuNbePwATLyeY7t5VHh8FW8aN7ID//z9slZakOcykaTl1PkPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 04/19] Squash to "mptcp: add scheduler wrappers"
Date: Wed,  7 Jun 2023 16:38:19 +0800
Message-Id: <621738d6206f4db0e152c9a55baa8cf35075212f.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f06829c-dd16-42d6-53f2-08db6732b885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2K9oiRdhCeStLcryKql4eWpQGxUPbOw0imIzcRhrIgTWVnLIvljgsNPbXqd9hzDxScwZsXOclwKvcSaaEF9XeU4CHy7cWHHXNNRZ5LUcrMq/zmYbizccj4QUxEbPqs6YIZ5y9t9KV8KjnLXYpeSsIgOF4kXJzKRiM5N4nWSorb40E58evAxa3lGyDdaPSOTTcX+GrPl+qRYPd788cwZsazRpfydcDInf/LqzlAAfVmzvpfGFnfUOBxv9uMCHbF2UOKS38DRY/cc3CLUkZyl/Wk4yjG7Dk+aDjuPn9zo21V0o8QJpnHygINcYKNdSieXtT/JKoTxcpDjNQfeOchNJgNh2qU+mo88ibdM7nBpB7E6IdS+pSod7nJEqA/F6THQMovbcZmuJ6xrktPH4m+ki7u4zvXwg0y+htEnEd4gz4ldVZDHTNqeX0RyHQ5xWDOTTF6KngQQK4OjOA++tBE6zHEAPM5hidEpEV4SKt8mnCM8Ctp5AoVKMv1VPZIAZjXapbosIdlGVCSuK5MCynKVvQEXtu9Z19bh8/wkBjvCazXqCWokCY7evMb5I55bLy6nW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fOxV8SsZ/90kLr8+1JRK7uj/QpkLW7jTAKPnSbZnr4LYvIHg+FKASHbn9qSK?=
 =?us-ascii?Q?WP0sOdZbl+SrrmOjeNbNpjwYkyvqR+VjSnQoOu6Cv/HBDDutWU6IU9FJYBbg?=
 =?us-ascii?Q?hW2zyXlsml4V2OkcMDBqvlCTxD8CPiYY/khUWIO/Cx122uF1DYgU0MXcdxs3?=
 =?us-ascii?Q?YHqSBhB3xd5UkXaSjG6pGdi0ZuSMqLUM7Ca5drIHcwKiBCFIKm2UXJsz/XVN?=
 =?us-ascii?Q?o2bIrTja1Mj2YngV5CtD4hPaItKkB/6rMcud2vNVsIa1W95xcNrTM/CD1zQ9?=
 =?us-ascii?Q?aTT69EDwplsjbfx1x6wgj6K8x14SwFt35q+E8MgcLn5tZy9Jvm6STzDVIRF7?=
 =?us-ascii?Q?59U7oBXmz5lwHqvmhlYcZsgtCy+CDOJuO4nfKpyz5fpAq0vrVrZiYkpy9Aw4?=
 =?us-ascii?Q?ujzzPW1rmjuDyxbc6mOUzOCJ5iUbo2hQ/p3pwDzSHyKs2fYOKOtb1El1Ddc6?=
 =?us-ascii?Q?d3yAGZhe+JmWbe70yipFJD7+sv+CaSEHof5Vabqs6frJooWP3jq3iD4qhjCu?=
 =?us-ascii?Q?LWf1ZN28HydhdSq3vwhHqPxM1Abz0e7GnAyKxTwtZ3urnLpA4cwZ3jk/YB6R?=
 =?us-ascii?Q?MIrFrHSpf8Mr/1KIfqMhkgTsQsDsfVMR1wzivCB29lCHccKAi5jBYulOEUPr?=
 =?us-ascii?Q?yh5r4areiIm4wdQ+ZNcAQHSPGdsMOPgDe9uTXu42EULkmXFM6LwZajtOPxj+?=
 =?us-ascii?Q?WYoINS3Ajw/BLPQi42t2rdwXkaQ375cb2PDHFlgFaWG+/6jB5vTwONZXMxiU?=
 =?us-ascii?Q?39beimLyp5zAPVJswwfo2CzQbMW98L2qOdBHo0k7xMC3W4evG0xRMdgqCC7M?=
 =?us-ascii?Q?CvgaXId48HoGXcFpjg+2ES3/lrQgRJ2I6261zvEdmMgdp2+4Ve8Y845wzt0Y?=
 =?us-ascii?Q?y9cSkAGq2S4o6MVILBjqBbZVpf+/GQptE7pyhQ7iEQpBE6cY0Ljar/7WH+8m?=
 =?us-ascii?Q?S+SIhvBrdQb6tOgvjcLrkNTJKnzUUJ133YEzR24EE2EF8zXOD7X2Bxt4iRIe?=
 =?us-ascii?Q?u77tQlbXuuZoctodONSlhPpJlAsTWuL6UOFaTaW6+aKyoivw1OZQkt5F0ekX?=
 =?us-ascii?Q?bah1uPNB3MB4mUp0W/CfQY/BZTLkV6v7Ful6cCwyS4CeJvhTB4OFaUHEKCHK?=
 =?us-ascii?Q?3Ssj0npXVv0YZj5hVv7XEZ1dyqSdj+I+rHOvSJv4EfHKet07Sypm2+VQpAMv?=
 =?us-ascii?Q?U6quvcVvjD8Xn1dXQKSUNvGGfkN7eIimxqOYEEd2lWvnn67i2cF/hBi75EDM?=
 =?us-ascii?Q?DKc6Cmag0tr7htLLZ4VAbnwsNn9abxwRZ327aVOnoGqm1yNcPYi2byHaJ4NJ?=
 =?us-ascii?Q?RWbQDCw3/XnJZL9Wuxc7MB4lU0flPxYgPTCcC4TKweBvSpmx6l3IlP9A5QGm?=
 =?us-ascii?Q?+3zEzh3LcuU1KbnZYgRFTgQldUwRTfytCBZ9dxGjbERN+bILYcKE3IN7S1pD?=
 =?us-ascii?Q?ftrfEzkVfm2M8MbR2N7gCh+0eNq+enmSdNV1Lq6TQ6tnMDqsK68zjP62LGsp?=
 =?us-ascii?Q?AeWqFxL8sn7dCIxtMjRrj9FlUWhwI3fAY15c4dRdbsLP7lYx5iBkHsBiq37U?=
 =?us-ascii?Q?LsqUKwRq/5nOms0VCS3KfE1+YBZwTZX7DQO8AK0D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f06829c-dd16-42d6-53f2-08db6732b885
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:34.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFV0zl1K8yGHp2f+6Hm66tZWNkrhrD7pu3waOkQaL1ykxq9+iKZnObkk51s1/JfosnQdV6RDWNuLsrvburIreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

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

