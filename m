Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E7A5E
	for <mptcp@lists.linux.dev>; Tue, 23 Aug 2022 12:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ0hF+KgsiufLX/9Q4l8FHcTSVZWUmH8wX1EPZVPZdIeJ6F3DqOZ+kEmyn7G2e7nvzUaZtGUCBu+PwfiFky5NYFVeY7Xj7XioPnst6t/a7Mdb7UgBtz4pkcyELWONuCZ50gukfxGWDnqMeoW69J3cLURSQZrLN39Pa5JMD029MEEx14xEIlbJDoXoEe0qCcayITlV2KKydZJyV7tKqMr8GQzljLizahikluNo7qdZ9T6Lk7ZJxdcL7/BiCfMdPEJWUQQaDmAqQkkF7e8PSUL45IqyuuEyMkqzleEG0q5mHDfk2t4tPb36lvZFPw2rs9a2n9BcyN9Po6HFnUBEu7tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME80g9GUDRksgLLG0UAbmcjLLAuOhLyLQ3E6Npf+ihE=;
 b=keIcB5KLDtR2aeCU+XB6nRGiwWtuNVmkuDQctUJBsaMk3VXI5ZtlofGVuqBaRylS6cPO3zPJqGWXC/wNgEzuFJVDcb2bNLaUEWgvbzywesKl9YB8E6i7XUtgf2tY8KFbZ2PFv7YemL/qYdOptqkK3pE7KwgmggyD01Db08jk7fwctFxQONAwONkWyg864NavQYiwVZ3obrAnAD2qVW5Wlb4YTPKjhbwgwMU3yU4qx1e9pRggvQtFrwcTY2TB+Jt++UqZDYxTdfqAuUev3C0YFe/LBW0y9ucpwtXZX05GgNEV+8PsLAEttQ8T5caxH16lPpMT8ltDMoQKRk6UF9FdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME80g9GUDRksgLLG0UAbmcjLLAuOhLyLQ3E6Npf+ihE=;
 b=XB2wY6MtSkg6aWrRJvoYpXBlI8dJjRFoOIDAIQQTAjIcEK7LZ04fgbRaPCB5tnTgAJ5gwUs6RZ8SkAUWz23V/KnLpP+FCPxvUUoe+unrOA1Z/9q2RQKYFLTvtYN0tiCoJDkiNjUi0YHgfNz0l6hV1AhiWmsRC8PuCZa5gThV/uEdGeGVIDB/1nNk8fA2kRMLenEfF9XLZXdegIQWNB1GOutB5u9inJX+htRV7B9tdq5RHhvZqASgFVHyQW/LGPU7rQ9ZgFQpTCeeUUE1dBMPF7wl0LG+tLfdErSd0qM92ym+1Y9rq747hUIgdKB5yB3s+4IrOeJtpApdoAFrIbSXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Tue, 23 Aug
 2022 12:52:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c9cf:b207:4052:42e8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c9cf:b207:4052:42e8%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 12:52:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: add do_check_data_fin to replace copied
Date: Tue, 23 Aug 2022 20:52:22 +0800
Message-Id: <95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d524fa61-d61e-4037-a720-08da85064b6c
X-MS-TrafficTypeDiagnostic: AM8PR04MB7201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	76ysNxt4Do5y3kKrvAzQPdhT8OTQE6Rk4ogAMIU2HgVHFSqIvR2xqTN8insUggvH2+bb0IuTvoVVD39AEAJVXMicQ9fR+FVC0LveFyobuyBoD+O4Q/JJAP0tOIioClX454XNplm1IrL6nVoobC/37l8Ypi6fTa9niVbg2tSYa7+1OPFcs0eFbcqfuaZMaFplQrUPw0LYb69ZunkHEqtj17848oF+lW2RS+AK/SFdxPDrmwq72RJLEgz/3GXlDetJy2pApfTjYq/4PciHAYlcojOJo2FcSfFikRA19JH1v+C0KyFGLUsCupMfQboR8Wg2xq6Ixt/5Ex5B3/QkhKKCEqj6O0Rf4yR4yNtV2Xy0Tmg3SkiqjyOJISsXzuK7mbXH23m8S7vG1KbXDmdX6t+a/nMgN8GE1KTVGKXUkBRTYoXrNFcC6yZWVq7feOU8/2o2pC0s48vfrk+iGuOgZSthn1iKGfDSMypoHRNWVkucJRyU47MwqKINCDMBDqrdlQFETVj151nUNClNNAzyKVB1M7iIcWluyKieB0NaTHZC3T69YcZqwHPeVk23TukhzrNa1ZHs5NFk9OeG4wfn1doZPgkNqo3nTmtQbyeXEF/2ptDCTSCLj2ATs5RxeTmbin7Br5ub9LTk7wBtqK2LybjinEkDmmuD1MuAPlyp1QMSUIom75HtQJ1Z8L/Z16AKrbR4gOJW6ftPeRANlT9rizrtC30VU3wi82RHENIc/M3UCHgjv4SSRZveYLWXWqALE7/4oo7lyAxby6RjMPtGwVb48Yh9x83d/9Wb2eICc6X5Szc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(39860400002)(346002)(366004)(26005)(8936002)(6666004)(6512007)(38100700002)(41300700001)(6506007)(66556008)(66946007)(66476007)(83380400001)(4326008)(8676002)(44832011)(2906002)(2616005)(5660300002)(36756003)(186003)(316002)(6486002)(54906003)(6916009)(966005)(86362001)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2n2eOH3jhPwbIh39/RBCSXlJ4YBBNC0p3wNF8BgbS2vfCmC8jvnZyd/VZXYz?=
 =?us-ascii?Q?3umCeXlGQP9Fp0BQK1XWNOjdx4MetdYnzeaxK1FfSpdA4tIKeG4STeWMHRX8?=
 =?us-ascii?Q?7RyMXAYVtAkmQM4vsajEtBOspX2u+4abq8QCKnloUZseolnj9q8Vofk4YCY6?=
 =?us-ascii?Q?utessku3p37rJlUrZJHcI4i1W6i2YLqgDXdYjWKaH0/xpYu5XuRVi2+jQGDW?=
 =?us-ascii?Q?mvwIjJbSwsB/EEI8Pp6gymmLm6sAzNrV50o6VfjZN4kXtWoe4MmrI7H1EuHb?=
 =?us-ascii?Q?lCfLikib2SqpRhTvhGIX015GoOXG1Ao5JYcWsffK5y5iKuFZZdyRSQaHugVW?=
 =?us-ascii?Q?sdA+sUPdlnfti+3WNn1cwAXYOeROuVrVCBcQg3LiV0Ib5zOZpG6U22+D3Zsg?=
 =?us-ascii?Q?HVdzv66V5d4U8YIUEmuti4H/KgHVFLVOYJvjvGgckObwJqtF4Bg8Uf9WU2AS?=
 =?us-ascii?Q?6f7B002M+bm0BCfB1zIO5FUaUJR0x7XVzjBfXuUyi6PmU0SomWy3hzIVaAtf?=
 =?us-ascii?Q?xwZIAwDdEGYfZDW9gpx79qjEfXZEOSmrszp4U1Sn8kC3H2gRs6nsEQ0XVWta?=
 =?us-ascii?Q?1RKeCvpDFoEtIDCMK0nrkhAcuslOPpq1X5F5gT36CNJIBbFrtVKmGNfT1irh?=
 =?us-ascii?Q?4zyqlCop/QhRSS2pNYbrFdti+fLeaNGrYshRKDtdfb0n8sYZtyJAz1J5tWvR?=
 =?us-ascii?Q?odB8jqsAwrbSk83zXzZaZOXP4xRKUWuFC7rZUdc5nITae6+dq9bRU7XsbhFS?=
 =?us-ascii?Q?3kZZFyvTM52K2ULB0ptSfmixcpNOTgu62s4L1/hWMY5A++9AGYZHxef985Ys?=
 =?us-ascii?Q?H7oFBQatdTKCwemgwSTCET86WV4v/62kiMTIQ00F01F9tsCrLoiTlVFhO+BI?=
 =?us-ascii?Q?ndSRgtpNkOqgvi8VAFmDmbX7XJ9m0rX0+g0dri6yjHbnRFrkL59UrbDVibF5?=
 =?us-ascii?Q?j4nuMK9Jim9jHcyAzlzRVG/yAIW0qEsmvS+dJZKhbMK2HNX/SYHAUQB6tj5T?=
 =?us-ascii?Q?wIY6cVLybPlv88G6wsho6REwbtwipEc1fZom9jlbkg1KCI9Eo6OzwKiUS7O8?=
 =?us-ascii?Q?vDN2nmTYtvO7doJCtCLCnKEeZ1aT0BVJ4lUUguH0+ELUcFtcmslMR+Wfproo?=
 =?us-ascii?Q?OX1pGvRXOKUBZc94/yDJLVT0GyDEUREPntaqWhyJ3GYeBkCj3coFOuHb136x?=
 =?us-ascii?Q?UZQlsy4RfHYxbEYrem7jIRRuzPiMWIgH/ZthTKW9HbMl2WKlViT7SsFGYU4U?=
 =?us-ascii?Q?Co1UpdaZb7vcl35/WijYTJOUf8hp22MZMk4frLXuZrj4/U6ooZ/AgETkHFRv?=
 =?us-ascii?Q?wFfPvZ9OZnZ9Qnq2TCVvNKY/n/dY2SJfTVg5aUen071BhqT4Dx5NBHcjTejG?=
 =?us-ascii?Q?Y3iI7QK01j1X9FYEqWUT2wh9Biv/8Dnrlb9HYPPDfPj7SjCMT8tNRhKHoymQ?=
 =?us-ascii?Q?KZ/Xtv14HkDqOcq+AWEKtAId7/RD8b+GKQb+FzPFloFz/aCBD/xodNdHS0IL?=
 =?us-ascii?Q?L3jQvxXmZkrrtiMTgtJ5RSj83JhkQf4PCAtVQ2P3OFZboKgi9eCJIImVc6JT?=
 =?us-ascii?Q?dZPOGXBpxqVckZZanrONCVd6g2mNQoB0uK6M6dZx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d524fa61-d61e-4037-a720-08da85064b6c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 12:52:11.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx/GpSAStE9mcQwa6dH1daY6Qp3k9en4Vz6ZGk9t7+tq4ARVr6CNKiMSi/0lQdva4NMEW9bv9URbBZr6/KOC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201

This patch adds a new bool variable 'do_check_data_fin' to replace the
original int variable 'copied' in __mptcp_push_pending(), check it to
determine whether to call __mptcp_check_send_data_fin().

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Do a small cleanup as Mat suggested in [1].

[1]
https://patchwork.kernel.org/project/mptcp/patch/ef3d52ff98c97b3c3e5b1efd84a1d4bf3448df5d.1656578856.git.geliang.tang@suse.com/
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74699bd47edf..fb574d135002 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1473,8 +1473,9 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
+	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	int len, copied = 0;
+	int len;
 
 	while ((dfrag = mptcp_send_head(sk))) {
 		info.sent = dfrag->already_sent;
@@ -1510,7 +1511,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			}
 
 			info.sent += ret;
-			copied += ret;
+			do_check_data_fin = true;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
@@ -1526,7 +1527,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (copied)
+	if (do_check_data_fin)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

