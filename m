Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10072.outbound.protection.outlook.com [40.107.1.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3F33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgRQBxQpfPR7v3XhFL7OHrwnzTaKRkiP25UxYdBnjU1bJ6yQjR9ZpJN/hRqybjhXXYSLrBK9vh4IO7UJPRvd+YHZ/Ikd5BKy9uFWb4/1EatNf5G+6MlyU7LyM7Eh7lkc3CS2fJDDsqVVjH5UB1MRQBx65ioWEZ3yrb1OyNybCanVKt3MsaMcVjb8v4ZURd21I3na3Sl4k/oPsfiOvRPU1I9ziZA96ZnsyGBEj+cHypwfOREpfMk5RdJDIkfej7OO4dXq2uVnhE47iW++cja4YNI3WZrSA1f8jgeg45/eXZWLZCQXfTIdaDFLqV3CV6hC33h0e1pxKjnzWZY4/K3naQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69TInZSkQchlolmeTFEdcz1ewcDzvSfNkHMy+aE/5GY=;
 b=iEtli6bE7QbXCmK4B1SvzvKwzwa0AOzD0EXsBrAab7B8pm88aZ3wzkPw/UWUzsjd1yCbTiLusf9kABOgvpbFR1mCRjKFEfV+LyYOri2Atqsbu7TUWnenuUkfqT2KOirBwRgVszzNFnhVGuwe6Z+1+lJnmaVZ0Fyql/QFx3mrGyiOD/EUM03HWmYhZvAsdHUXOWxkgIp+CaraSXOhKCxebhjcshox8udH/QeLsk3IVDwrQH1Bd2VoB0Qnc0QnKLvwM42wLQL+0nW4RqfYo/jtXR9UNofhsE8h21R+AIyVempe/x866TqMpQu72k0uCp8X1BsDZGiMjycn+Pb4PHSn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69TInZSkQchlolmeTFEdcz1ewcDzvSfNkHMy+aE/5GY=;
 b=tK52rTa61RoIAcIU1Mn9h8RmdblYVwBYulZIORISTXxTY+6tdPWYaoyP2r3cARnV0lRvuKtq42b5vj3FQmgO0q5hTKT21gByj+/Rf3xQSXD004k5qkNJMCViyUY7XoQFkvzpyiPaFvUKZdNSWP36k4w3zqmcsnbqVCqdHE0QGondAdTKOgekMb2H9Xw5YFGj4A4mZcS7NrsqzIoW93xgvHd7SagVNuPWquKiW4aWrVOqmDr6qAH1DJ02A4q31arp9uyRxXPsbraRNjdniwDyZLutX3Wcvy/22M00AdMDcl2u1gUndpalkIOyHH/AFa3kwJflUnGnKanvASF/gW/wrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/11] mptcp: multi subflows push_pending
Date: Sun,  2 Oct 2022 22:25:14 +0800
Message-Id: <0138de3ef6d2e3678138fe4d875e73cf67227cb0.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3d1879-d3c4-4895-1f82-08daa481f3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7CbK1Y3Yi7l/f62Yw44ONJYnNqfeuBznPr+LUh/sA4ZKRNshtYcCEqkTGxC31H91hDn8xkqyPI5dg0RCC5ADJd78pmknEEPAkd9wYWNw8sMLCZH01wGCYm3KRdNVQOqHKOQICXZxhILgRM1cC+40q7OPDvnPrPXcKV9meOGvB5rkeVCWfEhCxAPnzvYubbHs7g76SGQimLmpIMXx6VSyTPP/RZkYf1Xa4VeLrnm7ZnAO2cWvaW1DBXJWZoOMgQ7VvfH/WSFGlCT1JMO3YxL5U0f3vGGBX81WADcS8FHNRvcYMx18FKMdula9r8JXHiXTHIMFqCBAF+DVYNTT+Sg2tUN3CM5yUpwdqGt3ypojil2dQs1hwgxI7vjUPQxcM9bgYGVa2dUbT0ABb5TNDf6DzFU3+AR/qwIaa2Ek8+zcagfmpP94E4qreUOAIz9SxT0Yuv5UpSiZt9dRKdfVI0o/fbjojRsbNRYEIKNyzvrLbQh9g9RZNAD3FKjI/cSiUchfOxcyOU+LLOg75vkOTPa1bz7r8UzCtSm01IeK8SU8ye10cQXuUCfa413eY9ZH+fg+0PvGwK9GTi0WSsPUlvnn8ezz52RyKJt8qzBhBprz5qJ2kJ6zn/3g3a0FpF2SctSNSXbpHYWSDDBOWr4jn0LMC/JfL6zTzBjcM84qmM6fbikXoKMGgJm5wmKIHx3DR5OR/qN98YCQrrR81IMyCFsx2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwrwOb50NI2QetA/9mTavx/pJ42E2NCixuAXIYWKJUqIo5oMBXB3xKqpEmeE?=
 =?us-ascii?Q?wEp0v0DfXsZ9nN2UyrRVl0qe5HstSqEDErQkVafei8+zan7XYQ0mWENgOTef?=
 =?us-ascii?Q?EB3/wuu8d4E5MG7Cuu9kkXb6/RzF4ge02Dqf+dNefmAcVVnT2RrtnK6YTHdt?=
 =?us-ascii?Q?5S6JbT118P9A4YF/vejEfEMInD3yLr7rVlRnV2D6cBPIxm7mtzdSLTRHZ/Yj?=
 =?us-ascii?Q?85374xncDQhjEAaCWXDdyXOnB//6gGvCIIIhZY6o6he1awQNs42OsJaCLgra?=
 =?us-ascii?Q?QwMIt7AEX0FDdrZ1nOpRNh7+x7A8poEsxJW+xKEzbIsM5mahpqK+zd3pQUEo?=
 =?us-ascii?Q?3cQTeAqDf3u5YqPqxGTplhkyXGCrvPCpFTpR9FUg+oQpwS3pQ6brcQO4zH0S?=
 =?us-ascii?Q?EldV18i1SmF0FQShsIUtNXZrRvx4u+pvWL9NSkz9kUMrWrvPxaoyEcEQqttr?=
 =?us-ascii?Q?MipRFLFvNbpVKOJFR32n7ImNhhRiDZpIG0BWe6GMdu8zHrSY/+7HZttEO7q5?=
 =?us-ascii?Q?RzAjWLKNgzG/MfUKc4wYffBa3+iRQGrt+FCuhPAl4vnUN+PctgZ0VbYz+nuX?=
 =?us-ascii?Q?xxux7CAB4WtJx6lI6niW5nrJhp+6kOROJ1VGFh4ETv/8uFCDd/DmIDwYkjz8?=
 =?us-ascii?Q?FuCnKRYVUNWRQbn3hh2Mhsp6rg/a5A9YQxC0ZLEd8ylQX/Uuw4D3rGB7ayxu?=
 =?us-ascii?Q?p2upetKO/geveG7/NguRI9/L3UakS3rw3uCdnMGbn4pLQEa/gSof6Z5b/1Ec?=
 =?us-ascii?Q?iMQ7XGmBhZYrGNVtfpvvpdivcLLZ/nS87qdPdHWA5Z7Txb9uDpr5PGrbJQ6R?=
 =?us-ascii?Q?jCGOmd5tvTR3LeLRKgQb1sXuq5ZwBdJCThnctWRHFJWnRTeJO63MDi/AYGec?=
 =?us-ascii?Q?m6D8yMsSy/pNkHcRBzDQjIBesuTJJLtKviyLr6LxZK4g0HG8yLdSbjZ07AF9?=
 =?us-ascii?Q?8h7L+IJb+N2TIV246V8I9CHslKDpEJnaOdQIkfYyvov+JhgBJ2b1zubnPW9f?=
 =?us-ascii?Q?wUjZarCSquN2knfLmVZ17CpTp7ofw1gr0RkEgl2vwd1E0FCTJBh86R7/mhEn?=
 =?us-ascii?Q?Tl29TB9JZcmtdsGRskUBTPaNlZ3B2giCUqzDhOkSRUoE2dWKSRSuGDzOOjzQ?=
 =?us-ascii?Q?/rTBqH7mtbfSTo7v95u1yJwN/0MZzCiqqSQqedxOYxN+2U7bjzEibF5y2O1M?=
 =?us-ascii?Q?w4A47pDeD8rOrv3YQiKnxpGeePrJv6enMNjzn8sYyjq+tf853nrG3B70bl24?=
 =?us-ascii?Q?rM3WsdhvcVfBx3z0yvltk/ghL9+wfEItxypPxGX1XFdNVaX6O4vI2TGxyyiH?=
 =?us-ascii?Q?kPvvycikzXrPKXEspdl3X0wPFSr2+vlLLYxAndFg8PYPNg/6EOJB81+BAHxe?=
 =?us-ascii?Q?Ft6IfeAf62ETjr3thxffj28FRLQ4yZZ0kllEBEnpYHV9tROSj7Bk9HtCEcy3?=
 =?us-ascii?Q?OYhi5A5x7gGtyoWTp1sFQXHPcZA23RI/InsLEx0xD/esZvsWhp84rAEz3HF1?=
 =?us-ascii?Q?i/KLqfwsZYPlOT2TmVgrVHKxBEiYLXEZ3zV7GtODuJL0kTCz6XEStHBepNXY?=
 =?us-ascii?Q?AB2JixPJNwL2SM931z9DFJoKa1dxnjFgINM4k8GF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3d1879-d3c4-4895-1f82-08daa481f3b2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:27.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/5Q2nsafmmtnlUBOcVKgxXbGhGOrwDiwQpSsvHImFwTq2MDZ+wIiZ3H4mwArQMRzfei7+ySTpPVCYC/WVetIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch adds the multiple subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 66c97ac06a4e..7108eda00b6f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1560,16 +1560,26 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
 	bool do_check_data_fin = false;
-	struct sock *ssk;
 
-	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
-		lock_sock(ssk);
-		do_check_data_fin = __subflow_push_pending(sk, ssk, &info);
-		release_sock(ssk);
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		struct mptcp_subflow_context *subflow;
+		struct mptcp_sendmsg_info info = {
+			.flags = flags,
+		};
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				do_check_data_fin = __subflow_push_pending(sk, ssk, &info);
+				release_sock(ssk);
+
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 	}
 
 	/* ensure the rtx timer is running */
-- 
2.35.3

