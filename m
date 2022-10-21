Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A47B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtx1TMShHti79td9Vxk1aJG0uJRQUcTTr4uhfNbrvUdXDx2Md3yXMFip4OvNbFSIlSTZWuHVB5+K8T5A4r3no2lmEIZbnlBG2Tn74G3kRMQcPrkByuRRcovcnC0X9CiuD9zpqpUTpmmXcSLLMvPdLs1k7nuy2gSMp/OdW+FREuVUbnWWYqGGEomz7tHcq25saEy3Bxmgw8XXLjnsiKFIecWG4nYxFJSGR9hpMs7jbfHB/emsZv9rGmZG6eR/jsRuIqndDU0tMBNDeY8hSBjKm7qjS9M+YyiVhEMpQRZiVrL/n7xCAU6z+KnHvPE/CafyYEdfUDpvvTs+UZgdXmz+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vEDYqrey///f+dfd4hXTL5Sic2aadMAP4A10v3UJzw=;
 b=RzY/EErOaJ+EkxQFe0CIltJvGYPe1rs/Z0ptU/xycy1LYdSv6jUlv6cXrYFvbHo7PTkXvX2MQsFVVrPuGNOeIM3XJ3wg1VGD+y+pwSgb8Zt6P6hdPTh8VD2M9b4o5fJ4Hm25TXRMPrNvo1Z2akJmgMoW6gYTqd4cXaXlrlZXPOwu4Mq4KzvbDY46+XRYEypKx3ZJl0OSjXQ/rS+PADG1GdEPZGPY/+Gfd//I75OTBTsOfpdTMFg3VB7ciox9xnDcMz/Gl8lmA9NxG8yo3C3/8UhXqrTB9/ruCKqX+Qx3SFE177GTay/qh0Vuh3pfRLmX2jaLqE+ENXGxRfcF4OYOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vEDYqrey///f+dfd4hXTL5Sic2aadMAP4A10v3UJzw=;
 b=dtiE0MhVIPSjDMzUtKnc2f7uvFw6p17TeetHv5hERQwyI7bL78Ht7i9G9mgvQT//dNFigBgzwCAT7bJ+OkxSt9hMjkcs1nQSqg7kqPOQD9bsD5qeU0r7Kp4g5QXnzBK8qoFLZR0/hcXZmuNvfhOGumzQ/rg3zSoKmFj0tHudDZlirUUf6fXJcp8ysfov1RvaVm4Flf8oMkLa9q4poc79B0RnvoiGZxnM1u4bvoq36XQp5ed7eBkUcQ8hR7gXqG4KhZIZcXnqjTihbOOKZXSmQcWzuiauSkBXIgLV7g3KvTrbtC0Yhjkxr0qYPVV5VwF4Gf1NySGlRr/mlbvQkqUN3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:56 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 14/19] mptcp: use get_send in mptcp_subflow_push_pending
Date: Fri, 21 Oct 2022 19:00:06 +0800
Message-Id: <9e8b82d557eac7f826282e3ac2a374c72e820237.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a01d02-7ab6-4025-d4af-08dab353cf02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OF3nPPjfm5WG+wOza+4Fkd/HyWZFGpua/gAcYaWYFXdsnDuBiebteKXu+r5cSQrfliVD0UvN2RzXnl2xlSeppGrQuF7yeelV7yCH8HdNu29hQhcfQi+u3s/MaGBDT4sTtDGSDOCJJ/NSdgtPcQXX2xygN8XExoGu5Ra53HSGQt8zy26L6em5kDj9EtNgmrystqvDMAYsdP/KC7UnE3DctSzalao2TrjReB5/AwRwFJ21tG7GaMRKKEJ6SoJsMakImXSEBJJRPYc/Y9zgYRprd9+ZebC10BV919DmHYsC0bkEsOFdH1u5PDDsqLD3yTqCZTtyMXTVqw/U1JlizxilXv5wMTDDMZ59SJVp+dn7pLDqTkNs45JE9VfPhLbo5EH0lL+29hd2PbbwcYjETdJYujMHe7m28YQgfZlVm1DHIfzunzUHkwdFtfEHb/0uBbF76UU0Z4hg/FZE9SjElJMvPYvPrRgVG45wJNFg3Ytss8g5PNp4G80uOJ/0gmI+ujwyhRp4xsGcs6xpnpImPbomsPg/c0pXxm0IH+0Ja5Vi/p9Z9ccK11PUb4Unc5izEQtjXcPx96M+cbK7kDfBqJ1j2RWc4fmqPV3bfqHNUElLFTKBOG29wOEi7xEF1oVelfe/YWKiJvao+VVs29LBhzZ0OPCAjieO+ryXKeT+TGrnBYEK+kDqPuqzaIIpZlMORhC6VGBMFbie0D8FanPF+/0mPqFTSB+ERt8fJx8qBgWLollpfmG6lnDwJRZwBdFA4QMO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(83380400001)(186003)(6506007)(2906002)(44832011)(38100700002)(86362001)(2616005)(4326008)(107886003)(41300700001)(5660300002)(6666004)(6916009)(26005)(478600001)(8936002)(6512007)(66946007)(6486002)(66556008)(66476007)(316002)(8676002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkIq8gVrYAvkf4youOE88lFR6m+BKaKGwAEr21TrpmjpKgk//2ijrJKhJqqf?=
 =?us-ascii?Q?wWydLSXL3C0ynRtp70DXNTwoKvXKXQpkv8PQ3quLDnj6h8wncB8+TNU0c5vj?=
 =?us-ascii?Q?2s7QbTEuFUIM9Z941Ao48846MHTZw724tzZ8YGbx/zn7IJqIVBSffyKqoe5m?=
 =?us-ascii?Q?lMizwvWvxIgy41zmp41VmRScedZmEDUZb6tsZ0rcCU8WR3h7VOwy5Wf+GnF0?=
 =?us-ascii?Q?N8hZRdgNA7NozHeswj30AZcvE8PmlDDiA9fM91aEtp1mfplWqjmBxvUpYGZL?=
 =?us-ascii?Q?6RtuhWtpjiengtdwdnSldrrM+A7yQrzLhlUjpnExJo1SKz5y+fdN35X2FRjk?=
 =?us-ascii?Q?ge5FiEh46fcsv6Ui0fyxxDzlnYOUc7A5ykEEFplXW7qTnppEAbB9IBL8uHiX?=
 =?us-ascii?Q?fbrSjSwDo/bHs9MZD2als9tVA8Kyu3hjkxjacnHq2McA1lZ7A96pN1z1vtk7?=
 =?us-ascii?Q?Eqcm942yQFV0t0nuzdyYx5MsKlBLG6uFYm0xy00jEmRagkZUwEw2f1obbRRm?=
 =?us-ascii?Q?Ob5DQLJLITzj/E7BPtV8t/Z7FXUL7W+8yT4YxinPdLBSB7Utom8c7cIWEnxU?=
 =?us-ascii?Q?0nUOdRscxZclph60kqiUTz4Bo+5oheOeHgwStoA32B0wFSWnNnRV+TyMv1AJ?=
 =?us-ascii?Q?md1jpDKT5bKIxinbdzBwNtf/uaveinv41oUshxXMYJ/PjuXFJv+O+NrOI0fX?=
 =?us-ascii?Q?XPUc4E28pCb3obhDLl8zyyrtEtU81bm1sbqT4c0oUwfLixFZxPvBxvI8FRgm?=
 =?us-ascii?Q?Yd47RP6cT7OwAKdkbBelbkgezkGEYJv8O3/PVz4uHB6XTjKOvh3tb1iA1nw8?=
 =?us-ascii?Q?k0Lx7R597x9e7/MA6HD9MfYXeS6f2nn3ystkiBhjJpxqw3/Fq3eUUx2g4e5B?=
 =?us-ascii?Q?HIRrFJ+brWtCYgRPiy6R5aGinhO9BpnKl3dVHdeiT7uIBAQXL7oli1JH0rGy?=
 =?us-ascii?Q?hbMTo38UY7sdQvlpwfsCI9Jg93RqnW6Hj4u2D4PttEVM1Z6ZvwxgazMEeOGG?=
 =?us-ascii?Q?NBxaKMXWCJsaAOt0DJFhu3BfeTEP6ka6E64thd9BcTXyXyNRDm1hw8BnRSzH?=
 =?us-ascii?Q?pIt4EhgGc6h8ewOLvlVsWXueOanSlnXMkTgHxGW1xPiSSgXXJ7+pfYx9/AWS?=
 =?us-ascii?Q?v2tke4TL6lvg2j9RTZCkA3b5ljrX08WuPe0jnQOT/0i/eT+AXGKMV8tVY/Ve?=
 =?us-ascii?Q?Q2WJGiN9DQ/i/E1rNAGCNfd8a7uX4wVrEX2ZL04LALLGl/qvd5cPxfTLwZV3?=
 =?us-ascii?Q?lAOeDMqxN8iM1N/ReDPvyyQyrG8jqtAZa5chBaDyWDcE3ai8KLynVL8oURE4?=
 =?us-ascii?Q?Jk392qGtzqQOtSMTQwHFe0JcAjXkV8vD+HczU5iY7keS/AL0LJyZ0xsdyCfv?=
 =?us-ascii?Q?BQqGWcJVs2nAubeaiWHsSA+D9PCV6Ysa92QMZj1t4yWgiAfAlN2eAKMuaXQR?=
 =?us-ascii?Q?WFfKDfbKnOjfeIynDukmHY8X+DmH0eSO/tMtLGZxDpckfWV/JWp2Rw+zIrmE?=
 =?us-ascii?Q?uFDec20mBzhForq4jqjsCSxOe42osm/48fACYQ14nJfiLAiWAPULognQaU/c?=
 =?us-ascii?Q?45HmA/3Rdd1dC6KR8o6g6usDkqVJuq+XexJCfWCQXlcVwSWL/6yNFa2iz3eu?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a01d02-7ab6-4025-d4af-08dab353cf02
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:56.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mujfAyGlecWqfzMsI0aNO4Irmr7rfL+Qps1VuKuwaFN4VZKc3OUQJgnW/eZ3aLi/X7GtziyU8sZRi7n0EbxMoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8245

This patch adds the multiple subflows support for
__mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 50 +++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 56c76cae93ba..0dfe78c0856f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1617,32 +1617,54 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			msk->sched->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			break;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->sched->last_snd = ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+					goto out;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				msk->sched->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

