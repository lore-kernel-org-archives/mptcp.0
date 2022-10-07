Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A2468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Z1SbVugmG0L4li4C2KRQ4iZ1FWjNo/cGudawymV7Uw9O7Jwq0DqgGrNyfGHnh5bw80QDVPWwZprSUWVHBcszcbvn6VRFQUofE7Xp8O+RWkThmiIw5Jr3vKKseX/DyjqlB9oXdHtOh7LWR78GC7hBwl9GZTRcD6aCZlB0Xtq2dmEZYDWmmLBqnl/m//YN4Uk1NoqsEmKi1AKgVSHIJtiZf4InbrHqPccEIKvFZ5zFlta7e6adxw740vcGf/Q9XlZ6i0ZPFm/+kGyJ0iRvexSq7SUjRurwd1gVOVfP6M4eptlbah6+JK2fNqENMSEhvDK8zYTs7NZHg59/hcH0S7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJQHC/2Srjn3q3a+zMBqmfAWiZhT3hw4ikWNeBu57UM=;
 b=mXw9xwnme8xm7SJ+fai2eV1oZUXA1xltoxM0Txj6eKBcFMdr5jUrq1A86dFG0WnTC1ywGO7a0Vtot3NGDu1VPfbfRpO8KvW/Nx+ZlwOm8PblEA73sM8frYFKIBLvqPC5bWr5saH/zpgWHy0pxJP+zNYNrO2kFj3I2fPNnpGPAUv70zxnsoPUt3fqUEhKoPTMdWpz0bW6J/h6dyXbUTbnoxz6Sp8sHXFzCc6SVNHxpKxI5B1xOPcs6wwYoM7sshiVMChiuNNEDIhmy01KNSDTwr1t+q9yHjKvXfP3wq9i3NnVJlDzydFoCgTKzsjBX8g9Bpru6lc85A2OvnlqbP/GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJQHC/2Srjn3q3a+zMBqmfAWiZhT3hw4ikWNeBu57UM=;
 b=nxwJyoeExcoT0HTYU8X3l/a/9lRdoARAWQHtG2Bf2+kIM91ym+ZxU2UGe0O9u4pp4lULjF7yldmCyhqGxfgeaDw6RoBXXjqvifWUw6cJhG2ugy/HoLaNTGGEErJLLMjij0EL5Le5pMwUOmqR2rZobixj6dO8ntIwTRFEpH/MMcoZVjCyL+LVRwXWQVM5ZVfexXuf5uNQ/CfBBB279ccQ9Q31gwJ56IfCbSGiimGwkmwJregTqxjKCMqTJoAh0CfsnmLy4vM/Wjsn/5PVu/4ZdAova61RgNiPzPLeU1ggbbj/7BojkfC/ajbvuuj9tP1ODedpgFgTzzpZbEnRYwkryw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/10] mptcp: add mptcp_sched_data argument
Date: Fri,  7 Oct 2022 23:02:28 +0800
Message-Id: <e062f1f9630b74c7daee77b71337ef4bafd4709b.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d472a76-dbe1-4479-5278-08daa874ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+4SGkGn6B/wgBhXyWhSBbRFjzjn+wQbGP6QQ/v34rvp0poif8ktQdq0n2qVzrCIJYG7tpdYNGFmt3uZukPcFMRQYDv9VnyTfHRxqLWKDXNPC4cfAHzG5+nQm0kKHIDjEXNFdhVS2LY5JKzer2fv8kWFlbt6jDciujYE/taabTwGFW1q4nJ9IteP1bpPyoeqMGVFBAfOT1qtfV1wWh+dnPa1r9r7qZdSGbZEYMgoWEpokytqYLEj+edxDAljUKU38PwNoNWOPmJ3ZiK5sQz8Ild/p/lVV3E2csy6ulxz29JoDtewk5QCwC3APRHj29Ax1HvQEXbzmaMmilUeTVtx/MZh3ZR8S6eBe9U9skW1/ulNq0bf0u63KQsmMK2c/fmJYlIN6SdVLTakWmlSGsrSKPXtIFB2+jTh93Trt/oFpKo+KZEv42CXQSCLCNGxE2Pvmfl7dtI5MmjxiBrOKIW82c8uC6SxGlUmS2TFXjmrvsanCyfPLSyspTKf0J+22tB+s1vFiNoC+8xNipU6IsE4vFnoXIkWDyd4r6+JqkU6ajiAolTjMaAmFWpoXj1Y+uOAdfLEdx15rahsrx6mZESakKsBDdWAJ+NuR/56SMlYD+jstk5t6mMcwfmV77MAFP58RE1t0Y5ntoFlnpzq55NjigwPAvD1PAo+rJylwkXi0Fx5u5XjUx5TNx+/timuhLRbiOWDbR1MHj9i/Hw4bSDOj6uFBC6yT0nEnwRTsmqwBsUBg+6tqNxROp/gLTwckRfs8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2MRmyXlEVKsRRV2YKcIRn0VMEq36JX4s2s0P9Prm81FkZDqEPltmPG2S00z?=
 =?us-ascii?Q?sUxNcJopGzaW2XxEkexAxiuIbdTGt3x4NPL1KxKFlCqbuAN/alcKH5/su7MT?=
 =?us-ascii?Q?aFCaVCl1IHViJlG4Yz4OLSu9WCS1fgSQNBPniG9/pyOZBnTGf+Q8cs3cCWdj?=
 =?us-ascii?Q?eDMDWV4rW7y6zBozZNR5/yDdZUk2N86e4NjgBZf1u1/cEp/g1au1V/FIO9nr?=
 =?us-ascii?Q?Pe52iTboPYwXbeYnrie5qP2zT4+HTwWKpLMfJ6bUdSpXUyc3a6vpSCXwxHIs?=
 =?us-ascii?Q?TQue3OBixZNw2iLfE0nUd3F2KFvcwfx0ByptMyW1K0RbBDXUAZ/cGehoDHuv?=
 =?us-ascii?Q?1CIFUjdIX83eAMfmF+CQVAasC7geo868twTRnAHh6BMF4b48OY+zUhzgLApX?=
 =?us-ascii?Q?th3ZF/wXtvIqj25jEcUi6MoOPbkKoLSwzCRUtVujG1GzNt28wF7xUI3CHDOh?=
 =?us-ascii?Q?cLTUZYfyW5ZJxKSZRLFav2UrP3/f7ZyoyJC+K4Shzslw3T8BNW5sCNpsvzso?=
 =?us-ascii?Q?JTsbPWX0J6UtqzJ9O5kfw41716vjwWrYwZny+arvQ3AsQ/zSxRDEFnz+dpzK?=
 =?us-ascii?Q?55M8345WvDBaAsXjTuKxrtAdo5ug7r2FAvGmRI2VZYcUwtzZrLyHRFOjqDJT?=
 =?us-ascii?Q?g+nhtoSdD7K+wl5TOVycCXA10c7Ki64hYdqUPc7LWtp5nVFASSJPUZYzsdx7?=
 =?us-ascii?Q?yqsHKwwCUZeqZy2asetiKho540dMG+QmNRWBU+Xfg4jtkRSPkcy/wXc5z5Hp?=
 =?us-ascii?Q?5Y/6h5+SkrM1g73xHxmnkbQo90Jz4KZHn2PXCOY5uIFz+H/WgNDQldY7iYOB?=
 =?us-ascii?Q?V8LD6veXuVFgL0sfbFvGEUj0L2kpdjLRbZkWXnUhPdq7/yrib4PUb2RdrJdR?=
 =?us-ascii?Q?hyzAHED8ZmAX4CuNq50mRBD7v06iGoUC94VkHt40tFG3rofI7v5OZwfNJL/v?=
 =?us-ascii?Q?XOdtCQHdPe0Hpl0fZKEy3LgnKrPJ91CA5dk2Nv/HNIVdA5iO44H3EryOT7Ix?=
 =?us-ascii?Q?90/YWvPEAwqSM0t2/+SxwiX2UUIfxVUYbqs0qkPP6AgqFkx2zR82jfONJ3OK?=
 =?us-ascii?Q?nyPL+w8lEpuHlo0NUf3SM5gghTMkgtow8WrwQWaMUW21mLrMS8VfXVfwkwYm?=
 =?us-ascii?Q?/nnz9rOVMOVW1NrwvC9imil/dGpW47K0RHCWc0LC4LyhaD6IdaTgVejHP5Ui?=
 =?us-ascii?Q?ZNoEc6gzT/Ey56J27Jg3XS7ojpglg9CKFxfYp4k00Kz+Z4Mnhea2U+JKoay8?=
 =?us-ascii?Q?RcvEoq8WK81Wy2PEpe8F7LLu5jGmEfUHGh6QUe/bcWYgAaL1SJpOmPosg3xf?=
 =?us-ascii?Q?i9Q0VKWykxzMn8v7EG/WhHNRaQ4KPeefJBXaUuJIQAZdZG3lc1TG3H5mh9Ge?=
 =?us-ascii?Q?ZC1S0lu59ll8q6Gtfyv10iuVVFsjMYkgBTBoSDduzwEmujPTmQa1YKgCYI67?=
 =?us-ascii?Q?4PENAzVmMf9pNJ6CkrdbOI/nU4S4xFDwcdoD7DHpxkluHb7DZ+AqA0lFzWq0?=
 =?us-ascii?Q?veBEI7yo0Tvfqwp6UOWbzXo3DUuUKkZr+Rpu5GscbB38xm4AA5yF7eqwGHmf?=
 =?us-ascii?Q?HXnxsBlmTM8BwxJp97jnaBSdW68NeV3zo0v0ySSh2W6wSDbmf0gdKXWigUNa?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d472a76-dbe1-4479-5278-08daa874ef2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:21.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkHa17HAlnlu3465ZM7jg98aNgMO2or6czVlo3YpSWaRwbmgADmobhcPxeLkCpKiZ4OUV9codkoi/+q6rwxJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

This patch passes struct mptcp_sched_data argument to get_subflow()
functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 +++++++++++-------
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/sched.c    | 20 ++++++++++----------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 23c62779e410..1154bc746148 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1512,7 +1512,8 @@ void mptcp_check_and_set_pending(struct sock *sk)
 }
 
 static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
-				  struct mptcp_sendmsg_info *info)
+				  struct mptcp_sendmsg_info *info,
+				  struct mptcp_sched_data *data)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dfrag;
@@ -1561,10 +1562,11 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sched_data data;
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk, &data)) {
 		struct mptcp_subflow_context *subflow;
 		struct mptcp_sendmsg_info info = {
 			.flags = flags,
@@ -1575,7 +1577,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 				lock_sock(ssk);
-				ret = __subflow_push_pending(sk, ssk, &info);
+				ret = __subflow_push_pending(sk, ssk, &info, &data);
 				release_sock(ssk);
 
 				if (ret <= 0) {
@@ -1605,6 +1607,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	struct mptcp_sched_data data;
 	int ret = 0;
 
 again:
@@ -1614,7 +1617,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		 * spooling the first chunk of data
 		 */
 		if (first) {
-			ret = __subflow_push_pending(sk, ssk, &info);
+			ret = __subflow_push_pending(sk, ssk, &info, &data);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
 					goto again;
@@ -1625,7 +1628,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			continue;
 		}
 
-		if (mptcp_sched_get_send(msk))
+		if (mptcp_sched_get_send(msk, &data))
 			goto out;
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -1642,7 +1645,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					continue;
 				}
 
-				ret = __subflow_push_pending(sk, ssk, &info);
+				ret = __subflow_push_pending(sk, ssk, &info, &data);
 				if (ret <= 0) {
 					if (ret == -EAGAIN)
 						goto again;
@@ -2482,6 +2485,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
+	struct mptcp_sched_data data;
 	struct sock *ssk;
 	int ret, err;
 	u16 len = 0;
@@ -2489,7 +2493,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk, &data);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 05f4c6fd0cd8..ffcb9d02896b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -639,8 +639,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-int mptcp_sched_get_send(struct mptcp_sock *msk);
-int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 126cc7fe0b5a..ab4683e15868 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -115,9 +115,9 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		data->contexts[i] = NULL;
 }
 
-int mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data)
 {
-	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
@@ -141,14 +141,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	data->reinject = false;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
 }
 
-int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data)
 {
-	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
@@ -165,7 +165,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	data->reinject = true;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
 }
-- 
2.35.3

