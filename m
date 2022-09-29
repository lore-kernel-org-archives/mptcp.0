Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE22579
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 15:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg3qSA9WXS4acowPZ8unfC14/0h8/kW/NtjEsdJlRsrOKgG/90bEB8Y+0JZxC08GZSF296u7Qu78zjP/Fz3Nvzp2/yQms1158rSugxq+rV0JLUBr8k0h/vvY8R9hhEMwQ/poUMWFKJ4YFdaO+1gUed2lMQs/6S8dUBBRUer9olvsZQRC6/Hnv7ZJLyWp7SjV2J33LyiE0tCLVBILD9ARxp7asj/oBp/0TwprO/6RLQSCWeXP71gGB32Rw74uj3JoJoiK3yJu5JmMpJtODuu2MpuDwOf40oeoD0za8fYAn2mYM95rhwsd14e+UPisK2nPPWl9TTjGVX5BS02ihOmo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2sl7Gfly5hXKlpRgpjaDgPDzb24D8/RBO1bdmjs47g=;
 b=Kzr/oBpICpZ+sDhC14krWHZzEi8eCu+wCaOTBDBRQSkCOBmjE0Sulyy3roowilZrez11WFDDSK+C/verjle6016T/5kjF/x0V8VtzizaPA04uu7nrpE1cOnipqMqYV27HZqMGcaePS9FpRIBQbNOVDF/AwSHY7igx6dq3owNc/tRn0Qxev7b1xJuB3PT3hF6xTKdGI8Qk2HfDqBmr/LoD66ZDl9gnKSW2akNajsc6meLU6fMTXJadhn4jKUK6Ww4NDz6oPDhoGjzxbrAJTa5GAk0N+3ucugLRoAtejAY3xUhKfX4H5brbWWBL5YBtyFgkFEFoTkWQ+Yg0MQYvKjrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2sl7Gfly5hXKlpRgpjaDgPDzb24D8/RBO1bdmjs47g=;
 b=VdKPGUQpQUWn8pMX3pNlTUvaxp9ijtbIse3AwL2CdhwIZHcpN16cfEOcKfYF80kya1E7COSYRJfkx9ib2zTD/euVrJIhaCmXJMel6hG13Qna2sNjXXMhMzaihsq5MMb5/U2CbNMapg3XGsLi3GBMTcpwDFyLM0YHmusjjpYp3z2IsqBTFWHvHwck+eH5y8yjrgU9xp7QmL2ROTo+GE9D1nkFOcCLKPyQvkUGmtmUR4dMsSgUAz5r+YhdpC01JQ6/VnaUTYp6scMe9e8tUKabNawlLnLW18uhJB8NK3RdmQgzLY5RAXZiU2Op3CbFPyzNGuru2NXZaYrJGuh6eiunrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 15:02:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:02:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/4] mptcp: update __mptcp_push_pending
Date: Thu, 29 Sep 2022 23:03:15 +0800
Message-Id: <67d506626dfb793b3fc14380f1aff35e67fc6397.1664463491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664463491.git.geliang.tang@suse.com>
References: <cover.1664463491.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: af633902-f9e1-4799-7a43-08daa22bad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRrswrl1OTdim9g8MDPwgcDNaOGDK0UFiG8Mp0U1kymIQJkgOyGrmejzYeM+1NHbzy9Wj0JY4vQNdseTH80izgy6XcPKGUUA/mfxFofMzeMqCB4yayc9oM7+fTtyLnQ8OrPPHkYCBzpGqVEoFSkWPvzTrOIqqCNOL5NmhSJQGOEtOH7W344UJVrt7m9vcGNliO2bAO7QRp3ZLnbHqqfYlRzzEoxlEsl+VuzwY4Md1RyFF5En2K3Gz3H/svD+kQ9U2d+qd4JTXI8G2adppA3BBvJxaNI/bSzDF22nzZ5PCmUdAHdd+mDIEk3JtAx2T+6+Hp95Eki9ih3IuqYUDG4VTfdynb20vKK5fLkczHN1dimBTiBZtf2Z1cGThqAZlPSCmMOqinGwrxBiUJzjPgxTVd3sC1Q8PVC2UDq3Cnu7aNMJvjz+hz3oQiwNBaBOYIkmG/HVPUINU39Y/3+Ro0WITcpRJvT9kuKimJtzOf/xoM9h0bcU4ccbQiZHzQNlCmbCJPuwgpn5D5dnKQsacOh7LqLe/7+EHiKUf03o/XZAwO5Ock+EIZEA4OpRtRpqvB2ZDdZk6fygVN+YrxoKoVNMRAQ+42KiobVk3BaQHwqD04L9y5DWWxAFWCg7YHGAoQE2t6CdHB/NM85Zndtzi/K8uuxD46rcoXmjHhc+EC96cMSmXuOb4k1NUEytL+zB8rdjP9c0XAELLLsFUYH2s2XGLwPV/aV7RmFIQsXrkI1KgPvpwJD/3lckb4QbKYdC0HAl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(4326008)(36756003)(6512007)(86362001)(8676002)(66476007)(26005)(38100700002)(66946007)(6506007)(66556008)(41300700001)(8936002)(478600001)(6486002)(316002)(6666004)(107886003)(6916009)(2616005)(15650500001)(186003)(44832011)(5660300002)(83380400001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zwIyWmmq54XL3lUxD5WlVE3nPp6BN3um/ynIIhev2rqEBv0gtJBeoigBGVb/?=
 =?us-ascii?Q?9zP328LswEFNHzmq0rtFg+s9QerqihqzfYpjBPwDfcPfXp4iJBxGFYYV3ByN?=
 =?us-ascii?Q?Xs8zBFt2EAhBqMOpCpU+FtkGpZLQwuR7q4kfXBuefC6xzWs4QV1OhA0daGSE?=
 =?us-ascii?Q?Xvfg1WvcvhiZmRvtCs72mH+xsyOiJ9MBrqfWo4FdzoOmx4spQrsI1Z0M+z5F?=
 =?us-ascii?Q?6pwRZEVXYZBv1NAIUSvX2PPqKJJEMvR9CDUR0DqduY47TLQmI211LkpdcGt3?=
 =?us-ascii?Q?2+KszAoiJjHLfARWxEJv4+I/UehFiARQQpmWS+hDpta+X2no43p9Fop2EkOR?=
 =?us-ascii?Q?Lh6eogBzvV+4mxiXRKzJcbkDbWmUIZYDQAmNF4+5bePebgvIkVWq2dfuNgDr?=
 =?us-ascii?Q?DiAq6y4DJHTuBv/0EhvIA8uhlXfDcZUk3Yc+ly4zrCdI9CHojx+WLQ0AuCmZ?=
 =?us-ascii?Q?cLU9rZIPC/UiITxL8WjcrqsLaatLRTIotnTegOlvSTqtbhxa9at1LrTC94RN?=
 =?us-ascii?Q?PMDmFmd9xT6gEiwRrueiCFnSb0SrtXxId41ef1dWtrygb47DQr07juxL80e2?=
 =?us-ascii?Q?SPLUBwaGdyYtUP9+nnrI2vWrTspeugBSxkZDewgv+FApJnN4BFWhvTAs9DUM?=
 =?us-ascii?Q?t/dL2DnFtp8JZpKc2lkMdm1ciaFrnn6aZAIzWn4oIyT9JlQSR8MQfAJk5X0Z?=
 =?us-ascii?Q?ys9cSe+cUlUeyxOy0W+LSe9NuMBpqde7dQroshr3hSB8E1I/lVm4+duNrzXd?=
 =?us-ascii?Q?+bl/HFYMfPT//pcwF3Ma3024YApv0tyanFNYsfXX0Ov3p/1N74apZ+Q4TbqL?=
 =?us-ascii?Q?ikzL4PZHlF5yfzH0ALSEJffwIqpvgGQsL5T+Va1wLL7geVwqbx0FzDVAZhCd?=
 =?us-ascii?Q?pGreoEOQFDRobHAsBGbJXyHE96XfIbEN4fblkEN9BWpPz65gqi9yTjADcpOG?=
 =?us-ascii?Q?DQ7C0crg7knUZUKqEJI0Cj/Z82D1hZChP1tCZca9t+FOi7IYLKeifhAiOdKP?=
 =?us-ascii?Q?zni3e+xhtzo7W3lcbhbQsL6mtMm0xSQMiSHwKwVViQHLluRAu7j1OI7ncfTO?=
 =?us-ascii?Q?JdvNvLOosU9JzTGCa3dxAgN1JkKZCDQyp4DM60Pb/O5sZNHcOZE+SY/DS+8j?=
 =?us-ascii?Q?HFsVl1BTbQAgQweQ+IFr7nS4owk4aIqRN1dlNZcu7k3XAnewSFLxBUMeRq47?=
 =?us-ascii?Q?bxBBRqauDID9wJjbDTBUC43Beo5Rg4s4xlMFMvShQOdZG2NYec1z9okoYJx3?=
 =?us-ascii?Q?QeCJwLChTge/uj2uxrHzDZgKtGoyflfU5KYjnKYbNJaC8/V4zAyi4t2oYFwh?=
 =?us-ascii?Q?boJBtRDQFPWHskQjJxmgYbVORljmK7Bh1waPhzXbJNvCauRo9f8Q2T5llmnp?=
 =?us-ascii?Q?bwPKPzn3dQwGqPbH6Zo0JlUePI27xatc1iRrJa6tcYQfSqKPMid/gV7TdyQp?=
 =?us-ascii?Q?Gi199bXf1Usu/B6JwvP9gY8fVTCBbo41+iGFvalfpvh+6fFf8UP4kUcnYzgQ?=
 =?us-ascii?Q?sC4WaBYPGRUwdvDm+pg5EVPlrk0feB7Mo5/MlIdsz8tHn1lgmV0VHApkHEiB?=
 =?us-ascii?Q?IP40ce4CQZ4a7JQTjJtowEfmCiUiEe4XQ3/0Yi2Q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af633902-f9e1-4799-7a43-08daa22bad9f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:02:50.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46nBDy8/tp8pc2nA7neBdHOUWybdvoAK8jcHhClhO4bjr8uxxfkj9JmJ2UE30RIR4/bfkbs/J4RYGdLLaLbktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362

To support redundant package schedulers more easily, this patch moves the
packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
mptcp_sched_get_send() only once. And update the socket locks
correspondingly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ca21915b3d1..37a252a3f05b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1530,15 +1522,21 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
+	ssk = mptcp_sched_get_send(msk);
+	if (!ssk)
+		goto out;
+
+	lock_sock(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info.sent = dfrag->already_sent;
 		info.limit = dfrag->data_len;
@@ -1546,24 +1544,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		while (len > 0) {
 			int ret = 0;
 
-			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
@@ -1579,11 +1559,21 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst > 0 &&
+		    sk_stream_memory_free(ssk) &&
+		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			mptcp_set_timeout(sk);
+		} else {
+			break;
+		}
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	if (do_check_data_fin) {
+		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+			 info.size_goal);
+	}
+	release_sock(ssk);
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.35.3

