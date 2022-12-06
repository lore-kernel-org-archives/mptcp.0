Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F566AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4uZ2csd61UQtY4jbPKriJws4XZdDd1BKGieySB5YSTM+PWMoI5f9pfjN0SfN3NuHnyUkp+WWBneRZmJANl0moq1VsKbOuZPRBsHikHAUsqTgywpBwoAaVdNv/ZUrajIrf7EMlP2yrDvyLkJxjfJ26J7WqIEh5pBAm7aMnMUTWRsSM8Vs4URlJXYk/yTAmSj0HwykaGc2b7IyL9jUK+6nBtrnKrZRJvsomVNoDeET44OTPVsT0Zg2dVldPpS1GlGcUaxQ6c3U/WVq57qX11Y9GkRCwInKG6qGx3XhSyKopxJfpKq1azXM03ZTF8jPNbHaXQGjWPU4MT95Admv6sL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KoI7I/hk1MY9Ny8F6SQcE7lrvk+WKjElbe/A49ABXE=;
 b=NMyrAX4m72ztNEsEbSxpudb1GU/uFCHQNMihejSTY6tchay3ir+kEakQtnsrMrFyC8k8t1fZparxCP8JAW+PdCz5bNtEE5mlQggAMl7QP6VBQmUNmf/OLHR2oW0hJEiTQ9im8vN0yqNsiXoCmWox+OJs1Rb0xsrfMDb/oPt+jrpqFOLOSraTgxGCijQR9xDI31e0hJHF7/JvpuV2pJpiSP5XawO3byVhPm6JflzN9XxTkwGDrn46+bcz62r4ThNdXKRuCtqJh47ofNCvdsZl20m78akg+yqx/wcZRwLhS1WjnyRr9SKqGBoGnHq6l+VECjYQy9FJn0cR//gwzzmFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KoI7I/hk1MY9Ny8F6SQcE7lrvk+WKjElbe/A49ABXE=;
 b=uIJ6ZzDm/qBAax2g+GRuZ8DHEmNb9FwRMoWld69wkBW34cRS322DZefbiqdIp9k3TlDraEUYAUFvD1YUsHxE6ZsE8bqu3JytPt6gL7coE0G9O6zUkKCyfRGOVjSyPf5Y9mKLbZeHPT4cd48SBYf8U3IVVrODXcJHNFYpmZkKViP4SRlVJzw8HCApKnmYufMFhxDi+CTU2yg8DMhhF/AkbIkVkH8Vp+4kmkKDbbSjQQmzlwjKtyBek7F0nQUwerRfyUhU3VCQJYzVFodp1Y4K3eUw2VINN3VZHlR9gK9D++2MPty9o7iAiKLv5joJbsHMYBIQsOlb41aPoPj7VXrh/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 6 Dec
 2022 13:22:46 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:22:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 1/5] mptcp: add scheduler wrappers
Date: Tue,  6 Dec 2022 21:22:17 +0800
Message-Id: <2ac75391ed87ea744bf555d5408fc6781f4794a1.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670332660.git.geliang.tang@suse.com>
References: <cover.1670332660.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fdac57-0b1f-477d-197f-08dad78cf2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JNdDawdnsgcNE9rCsIgPImMHoPObFUc3Pu7OfwxBAKjUO4VWYwCzS1y1qTdWaDjWb9SeumgGvwQTzLvIi71i+Wd/jz9aRQHjKSZTyygILxH4555dJreotV+xXLT0OrLmJI3tat1q/+LiY79lNsccv2rfOnY7GNGkK//+4JP76QC0mSmAtaeCGsbVXZhtuYOfrtHwWwbjVR65hxpYMJ9kzUziF165I7AfhTYrTeW7fnAVWYWWN7HrGCTlAzMLd9HewsP946tyRKEu4f6fAtdQKRwfeaWrsz1dK/JrtENV38GYcBjx6vkGu7cgON193tSeWc0Q2nW258up9D6ynRXWFNh4semRNpxHlwxdU1yUnFbVZ3Cx++7jNSLUsOo3RQh/21RStwuOJyhGW0v+j0FXp74csSxYuivKLZvWCqxwuZoUJzPATCix1tijkwZ6sZTldv5LsCstlJfxmB3+qk3zBGLk6e8zCwSyutBlZwKjD09Ktgwz/ZPcnOpMM2nApI+q39Dd1d8kYTkr8U7orwXRAz0l1CzUiJaf2sjNwzWtfqlv0ygyLUJR9uRjJs6R2kY1Q3gkIini39W1oTraMyyHMMbOPeDcrE5rk//KALRSfE7yeifawrBix00gt58qoy1G3kAlBNY/MTCyNmfw+1FCAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(36756003)(38100700002)(86362001)(41300700001)(8936002)(2906002)(4326008)(5660300002)(44832011)(478600001)(83380400001)(6486002)(66476007)(316002)(66946007)(2616005)(66556008)(6916009)(8676002)(6666004)(107886003)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pRDYXD6Ys+hBSLigZ17rlksnZsrOGE5qx9W4CN2It8bTz+neSZhEdsPlK1AR?=
 =?us-ascii?Q?DpkThqjedRJsveUNR0UBL7fQaciWldKhPlMfOXyq3SxE+PM4nouQiSJFzWS/?=
 =?us-ascii?Q?DU8XaXjSv46Dcvs2x56x38rkYY0mRBH9AnAI4ULc2w+ivzMdFslTdDfoXUDR?=
 =?us-ascii?Q?Sgo9u0zSaOHlAGLS55RYjQLRhjlv4AYk278DoYM+XFkpZDEEderDrqOhn9h6?=
 =?us-ascii?Q?9JY3qcSwZZctNdftx5WxrETNNOO1aKWTTnQJHpzb4g5dhiVrkl6VevN9M9xq?=
 =?us-ascii?Q?raI1PTkuXoR/QMv5PYRI8FZMfWYvJFc8Xzl35Itu8ymHFYvvwbLqeyESANWX?=
 =?us-ascii?Q?XJyrr7ygZAwEAUgh2H9yMzJn4ljnVOrjh3nZFYGLwhWKaMNswZSU2of0MRqL?=
 =?us-ascii?Q?kh3pe6TgFbuzsvrJNoMlgWVLUA24yHdr4V690PAaZYIn8XlY9TvMUa+/JKCs?=
 =?us-ascii?Q?wHwge1xx6wipZj61JHnxMwUrmkVgoLIyWPt4/aYnViOWPadHTx1OuCyilv+E?=
 =?us-ascii?Q?TAbBuD0Jzefwco8qcdAzGpyLZ+5r9d81xUiNZTylZnCjHO1O/awrub9Gp++W?=
 =?us-ascii?Q?V4qWdow6/Y8xrntJYtVbkCuSY+CYnSZ1JAY406slZ1dAP2uEnMbj12yzgJ/u?=
 =?us-ascii?Q?yY6MRAn5u393e3r9EWBW4rGNad7BAFdl8p6qEZ4HHT9hTP1EdjQhxnH69MuD?=
 =?us-ascii?Q?qkEj/ikkh5zppmijF2jocCg94Ebv/tYm45nl3ilMUOLUSySfFx1iCP7yavuP?=
 =?us-ascii?Q?w0zDfILU2NsJChcpO6gKzHX/Emh4EMrErJwIeIqDg5z5X70FLIYP3m9Q6KmS?=
 =?us-ascii?Q?Twbst+Hde+CW3wSuRUceXDtrkBmXESYZrCHKyWKGPuRs8h6cFuGmfim9pL1h?=
 =?us-ascii?Q?LwaVmU72T0Jr2yM8Mp5Iayd/tfUoQTCv5tCiZqmFFoxvVa+ZO4nCRcP+65l4?=
 =?us-ascii?Q?4nrG8UGqz6yFRECJaDMBa5A3C4V1De3qGtLxuA0ZUrLfOQZe8BrB2dsNd1iT?=
 =?us-ascii?Q?ehmalKqfL9Wl405xnZh8FvoyNTVCNuhZRIGVRYAJWHQFricHoAjKW5njczBI?=
 =?us-ascii?Q?dxLU2XdGw64BL0wNJVQx+QoWPHUxchy+vRWgFWvRcLacqJYA1o/X+pOgk+vf?=
 =?us-ascii?Q?A40zEGH1yy/5XHwCZovGh8j8U8I0uFd3I6mXOg0YteSWCfxjzWb2hJX2PjBX?=
 =?us-ascii?Q?VHSCJTdII4lFUR8D6YDZ4EkrK0E5QsMcmG78QqELkkQV3hFQuevwEHqwn0ZP?=
 =?us-ascii?Q?/cexWyRC0XAOxuL3/yw37HwoMWOwRVdN3PBtXQqEpDHFBvMjcvgh8aHUNne/?=
 =?us-ascii?Q?ecAVDHPJSL42etS57YhcC3ntWfqnIfCxRAJeFDirHDQR8EP9QHobQld3s37R?=
 =?us-ascii?Q?wqNT8ABqVfxjiK9aqXcfpiHQZQdBLtz9w5cMed3b63APbHD1shM4Kh6PFJXt?=
 =?us-ascii?Q?R4Y3pR/HTWIJdO42Vlheh4TU5Ca9tqoYagPeIX+sQxTxjqlNngc7JII0Dznf?=
 =?us-ascii?Q?93hPwCmPuQBpyYVc7mcOnDDBFtvhQBz5aYF1TkO597tFfHHbD/C90ZmFmPtm?=
 =?us-ascii?Q?nswoLYPNL+WtJ99yUsNIuWFHG+WPDo+g9VjyJzIxm6winC0lBAAOyNcvhbCe?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fdac57-0b1f-477d-197f-08dad78cf2ef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:22:44.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS793/olUHzYiJ65aFxqjadlA0E5K+sCGl32aWgx+CHi+0AmfHnDPvDDFLidbRdD/L1A3DBb1P7IUSKoWSDzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d03bdcda33e..3d55a02c3f50 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2217,7 +2217,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9ff7028fad8..ecb94ce68ea4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..c4006f142f10 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,53 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

