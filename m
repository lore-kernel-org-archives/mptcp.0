Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7D2F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiimmyhbETHdx8YZLz7kRwgfIr1Yi65u+9AZAtPhZ7/p+fZBx55ZjeG2o6NTTWfq7Yuz6As6ryA3EPPsbAXKr3tYKjzskJ4lHuyh2Ao3aPUu+EEKZEZZX/LxY81IwmX2wtFF2NJ9clrXNy4e5cN2zDxRCtQzRZRxhhO7ZDabm6eqvmKG9/AKdPEOi+Jmkteh2j9PUtIj3RdXjzHhoh5G32eiyOcHQgUGixITDN31iWVHFRJa5wVd2fSJtW8vFnNIAiLBGm234T5GwS2niDcHhOcTeZ/elPkT7He1auHJcsMMgZ20GDptiE6V9ql67AkONhXn133ruB4UvNtvLuh0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwjlW6J69Yye0slij0JEGkLPmDlM9OilptOWmUlvGIM=;
 b=VQgxYmFAUP2zLFrtZcNA4AGW13wl2V2I5JacFl4JOe1dUc433BT4vD5dSnbwKf8GndftGyhvF9IFFWhYi43jKUoODhYSRvR96gRuULLrRcxTqC01sWru01HwAKLQWP0vPkHrO6Z07nEZ30aMVu8ee9+2xePDGezcIVg1Q0jr81NSXazp2BvW2w4IBpxmJ1dsw+oct8feXA7OtS5bECNZso4PKgZEDir7URSVx/yqbEpo/VhROjTWZ11rFAPFZjM3bK8wOAvTHad4ngA3GBmaXLeQXPH9OOFo4kwQoMU1vI8ed3kIKQFX2A95HIQ2Rq1OYQ947JVs7vtz0nzM7U67Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwjlW6J69Yye0slij0JEGkLPmDlM9OilptOWmUlvGIM=;
 b=Kl45/tGDySnzdwROWfTB3UsugkScDKK14ot13B2KbIWoL/uyAy+wmVIKo7shcbBCQ3c+hzh+kSeCfmuJBsyh3dosx7RmJMYRqFdb8DkKkS92sYxcNe7kvt7HDuSyTOVkVHYuzKkMW5Vf5MlmcwnX6W3vjk7+d14SjmpJTcqhNMrSnD7MulzDI3PvPTKMoy+nLXf2Et0oBhwxXRVFWLkZJSm7sYf218YM4utTp3Y7YyxBlUeW42CDVyEs7eQZIkonLPqy5qT7zGiRwt2CWjG0vsxVoJzeEkMFclFwWvOkZC+5+AonkRynGBnRxntzSQ1xCI/7IFMlZh0HtVf+LsCEew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/7] mptcp: use get_send wrapper
Date: Wed, 19 Oct 2022 21:36:00 +0800
Message-Id: <c4caba14a3378673867216e1abd04a0aa46d43d4.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5737b98a-58aa-43e3-ff7d-08dab1d6ee1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/MMPbVuC9Sjn0xgZXHi5o0kccN4naQJeDuk34rjZZst2UdhkYfqdxZnIape0NiDC75C/4svfLVpoZpjXGmvcehjDUrLZO1CgxAw5r9kbreIt8/54/99me61wH7gQAOXIEnirwfxOhIz1QBgvmK2i8BhgO9G74wjIQIpfLkbY/tHstu1K3uyyALahCYy2t4APyMuX4Bd1cdyCGMmI/MlfGm+eom319koa/3CM4Z90yoAse9ixe7qXu/uq+/EYpkpPDSvLrjEFdN03Y+JN7Y4ogFHf8ErByXRwoC0lcsoWiIS6VRXO42vKX3+XCnuouJ6SZcOCXgYgYRSa0CITZGTFjoYAQUkUQaijpRN4MrS9taoBg75KAgkafc6ET5H0eXFIy25ey64oI6eycA2lHJTBMcjiJj6/KBtk9L+Yg1Oqbxk1/gMKsi9UPla3SwC/trjZdL9jKxhshUUhumiIXIqG1sCE0fa7cNomaJbmmuNVYf8uR0+tr34BgvSHScM8fQgJJbn5K/quXTfOV2FnZlIa8+IdqTVK8PiCipygdJj2Acdrr0Fxsdvk5/YhelFcc2r73u7CF1IvN2JF3CqY1wizdcSvgV44UdXB7SU06Iryvdi4qYQnm6039IM/Mhd64q3DTvNTtUYmh3A4HIBCNZYzjNfJ04M4+5A6VZCwSvdk3W5Bligtsd3LNTc1UthWsdZhJ7V8ZKIhq8xoNhzz03Sa64QSPMLoUCM1TwRij85YpezsrfG2wXwmqmUyxbZw1S37
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0txH1k3/xG7XarH4Tw+lUVQnc+DR2mHgSkvw8NmPCsWbzwjSiV4GvfGMPK7?=
 =?us-ascii?Q?53x/YdmCMMTMQNw78oSIv1fQFWEVfIzoh82ZPU47wPXq/90uRJO2UlBbIN6s?=
 =?us-ascii?Q?H12jGCRIO62lsg1n9IDUhGus7v//kFcZLog8OHnmZUaZZ1DDh7/Fwb0etL27?=
 =?us-ascii?Q?3SKffvYdQWoUKvoRkBARJlgOVuj/2ab6Xt7qrVuNLxWn3xU2vy1O1Ai2NvyQ?=
 =?us-ascii?Q?GG+sEuCSHjAl6pkSIxS3W/VCxVnpp+eE5k6pxq5oWyqhjR47LK6v3SFUNBqp?=
 =?us-ascii?Q?cxclyOuL6TBQyV7M7RtfQoC6Gf3BTjzZCCFb7p5njQk/SdzDByVtREu16JHD?=
 =?us-ascii?Q?r8nN9HPzb3wQhv2nRJP5G/6Te3xHdNHpcJ75qvYfkHINX86BkmfvQaiFdU3t?=
 =?us-ascii?Q?reUfc108ZicZ3YAUVWqRSZ6PweQKhriyaJafovz6Nh9EHBQa/T0ZoWnXRfb5?=
 =?us-ascii?Q?lFBo2NKTwtEmtJ8Oi20szkiYADwY3fbZ61ia3/0nVwqMGW2J1lURjVR84gKm?=
 =?us-ascii?Q?f1mbU2TjLqVxUl4IgIQ6sRGxr0uMVe6wQnsVtXrEdxafgliI4R69fQnhbtFQ?=
 =?us-ascii?Q?e4k2B4gtKrpWB7S9vm1DmyeJJlMPM3iPd82upxAglw9o6Sr7EdjnYKeUmvC/?=
 =?us-ascii?Q?DwLXIcHnpMmBXEiXTmWNkMAkcxJXmwaP6h2DLR4Eha+k9cMtEtcXxteLUXxQ?=
 =?us-ascii?Q?KMXZH0jLHz08rGacL/xAWh7G8e8L8TtSjQ7m6/FDOQQygYkr4MsLGe/RJ4l2?=
 =?us-ascii?Q?wqgjG3QucUJYp7Mhn0jPD1cDE8xIL3u4R9BpePyI/0ctgXkNkEiKRXEkZJFd?=
 =?us-ascii?Q?XjpIbNEZ5Vy7tiprkTYc+ymLGMOibV+rHNhjFgS6Bxqfl4+hgUtO7W1jAj37?=
 =?us-ascii?Q?Eb42mGjO3OGC8okwl906flfdB5+Ff2RdUQwHEnoOG+xDW+VGzyFjwh9EqJZv?=
 =?us-ascii?Q?XT3ZR/gzBH0wtsS2/EwLg++cpJavacDWYcuDHF+bJbOIxwsJY1iCsc/JH4Fy?=
 =?us-ascii?Q?lQQG68NMdw23rLrfJRylXjuAs9Pp2ztuesAL9ztMMMSuWDr3tUidqaSDBo6y?=
 =?us-ascii?Q?qtBvul3/UFG1E+pUco9RqUqSisEFBy1RuPdamHeYt65NaM/5jSLOKRJKEnry?=
 =?us-ascii?Q?1yjNs8/9qsHRqkF4mc42k+A2kZlSNvhxMwySWn2g9yN3cCsip1hKaaakrl65?=
 =?us-ascii?Q?AVVe4Sqqgvvv1o5vY6wW5qNld3yINdERkQsHCxsKGzzA8THTbzzPRh/BuVyB?=
 =?us-ascii?Q?Kbo1MlI7Z7DZo7YrOv+Jd3mgR+vPwZco0ZsXih5pamK+G6XCdJo7pF9y5Ej2?=
 =?us-ascii?Q?+z8BVhpBDofIf+qxLo0yb46WApz3qrU2xL5WdtfPFbniSZaeo8DMehBBBgoS?=
 =?us-ascii?Q?7qoV2vczUevxlDwc4F573/nDDFoBZSwtDhoR3zQe7JgJ/x8FD4ti8NL98ks+?=
 =?us-ascii?Q?BYKC4dR+wKUE79jG6pZDDMhaaMkllJIxNqhUZURjtn10lfzkSI2c8CLgUSBq?=
 =?us-ascii?Q?hLqUhSSCf5ALMaExwz0DTLsidfpgNzzv2WaSQ4tRmeAOcaYNQRoEYpd9Bit7?=
 =?us-ascii?Q?6/o11FwHjklLhJzC4/1ObtqIoZqsE/3Ck+bSC28GCYBY/s6W0Eai0RGG64li?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5737b98a-58aa-43e3-ff7d-08dab1d6ee1f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:30.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6z6KTTkSjOHrflLL0EwNI5qawQeXetiLfi535Y16R6RNctBgM6LGdVlYeGWfy4WrB2lxbPsS2h5rWMrUPY2Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

This patch adds the multiple subflows support for __mptcp_push_pending()
and __mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 98 +++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 67450378cb97..05238a0313f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1566,36 +1566,41 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.flags = flags,
 	};
 	int ret = 0;
 
-	while (mptcp_send_head(sk)) {
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
-
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+again:
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
@@ -1614,32 +1619,51 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
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
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

