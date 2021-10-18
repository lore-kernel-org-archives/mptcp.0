Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56312C80
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634557237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wmu0BcY0IOMtR4CQmsNaf5xJfJGmQD7/ba5vfN8/q+U=;
	b=m8YLDClNbzBda1UOiIA6BLi5MRTkf7mfyk4UxRI6h8mVmZSRUAttK7ydDmDGFqD+sOoWiP
	joaNiwIgUnKh2mzBBusqPpg7Kn60AnM9JxDzs/7MXUJPZeCWGEgoa/A40rGioUuKGeqdqX
	w0/hvo9sS2aqSKXFVXCMi38GVGdLUiE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-mRpsaXROPn-yM49-FKnmKw-1; Mon, 18 Oct 2021 13:40:36 +0200
X-MC-Unique: mRpsaXROPn-yM49-FKnmKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp0pctB3qzzsaZV4CqzcJpZVlTcfuWsXh7WvE3/7ufre47M4OUIVScjwESUqI70AmYmIOSLtyH6dyhojP6ErPmq8BRxrvm7lS3UW71drvmqB+eoNYXZSYv5mXP5mUPdR+MsM12BLpuPHC8jQuXf948uGSJeHbkiT4t3LctTaDQpQ3BQ+uITwfCBHg7bNHeZf2czSC9c9FHWjVD2ar+BVyV+lZtyAtNDDecZb3CborLqa2VoV/FK7hiT9t/jpGBTc5oNjNEsdjRJXNA0YAphfEjrf4JAtLm7TBpY8mlUQP3LrC92Z96ECiz9OSl1qWFVvHxAegxx97a0dNRL+RmuTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS0VAP/Kswv72LeNrfr0vUGw6B9InQSWIphqeo3BG0M=;
 b=SUk0UPmteHi34Xl5Dvxf+BpRwanjDU8ggA3v3B3HSHda6GBrFT2qDUqIhamsTGx3jb11pFj3moHaT7hvFyDDnNKmrg3gJ8TVZ8KBfcyoDLDrNm3iympmN6nUSRHPHmrEZ5X1eT2YsIL4KPv+/7BOJBVAXeLx0+34lLeXmpBMruh5cvRGoazTDlItuxdv3eqSIpI2X/cBzim/2sYX5HcLjtWI42e9G5LfZDBnZwWIBSq6ulYEFR2VJ6S6AzCkGGAhAKGp72WnTDqQC3XqKz6+9ZKPBBMViPtLBt79+OBohf0GF/6YXwL82LDAAV5fRGU4+0wCym273mBh5EnsbRq2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2508.eurprd04.prod.outlook.com (2603:10a6:3:82::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 11:40:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 11:40:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: drop unused sk in mptcp_push_release
Date: Mon, 18 Oct 2021 11:39:51 +0800
Message-ID: <0177e007bc31fd8e5783b115b66c6b18d3dd2387.1634528367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (111.192.100.101) by HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Mon, 18 Oct 2021 11:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29755d0f-4a3f-4bc7-7ed3-08d9922c1815
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25085ABE9BF735B5702DBCD5F8BC9@HE1PR0401MB2508.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zvwKU45F4Kvtq+LaMflqD65eXJuRKKiVYMCPRO+mlevTIwsyPNQf0wgIBJK4GRGoZ3ehy/9iFQVocz53RQOCrvUaa9PdAwaHYysbPasfu6tNJQ3k70LKpaHBCsrnLGYr6eh5u+TZaTCtkzuHXYy3lhyGNLIRPgpil8wPy8SjlO3F9SLtIuEI0XlJMnXOjM7SQGxHs+WhVOR25R6G4gl0m1YP6ybaoq5bMYCZgVZr196YJudZTYgviJrdWx0ZFyiDbZy4F/3DhYXLZ594WaI6SE4pgZfsVorOJSOJ6js8QLpZ21JSwZyUSFbloEGTQz50WIE6Vf+GzG2zcRQ07oqmaI539HCw+y+GemnE2P3jFkPYptU2hv9HuBNwT/A02Yau+Kfnq7PpRTUPQhpCD4KdWoeAe2rz4W2HV8IHNJzyRniYKYoMCOuMoV1BbOcpG3QgNl4JHTHi1+i16c80Mi0r15DKm0K6XF+wkQhz6CT/MJsn6QqOJ0lJzYhrG3irGcGwGRME53EYjYtRlNW9gHaxHVgz52XblnX5U+4IeKAIKAH2DKNDXMhlYDT9YmLPCawCc/lkXq+gJzc92JOQiEQMHe9qggRmh13qzoBhGCauMtgWj8DsoCQ+Yx4XibnNehWOgCeHuMvApwEsaRIiyV7edfrjWoKN+weUrRWBVUNg5qRLIVZiZOWGeAlJGTvcqL66
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(508600001)(6496006)(36756003)(2616005)(66946007)(316002)(6916009)(4326008)(6486002)(107886003)(66556008)(66476007)(86362001)(6666004)(956004)(8936002)(44832011)(5660300002)(8676002)(26005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLRiFjZPyOOJgvyBI89kqSHUy0gtafzyDwHvzkB+Q36euwpvsLq+ZX6zKhsN?=
 =?us-ascii?Q?OOL6wpKBsN0sRG4gqWBeJIuVSfh+9EgsuT5UE856MbcIdLEDTeCwsFytwZKj?=
 =?us-ascii?Q?BuU0SajF+aCzkHNCQa3imyVjfVo+rva6CMZo+ANDdna62CfCV1NrlNiDv94u?=
 =?us-ascii?Q?AFcPircDd6q2Oqf1pd+46XvEhWlyc/ukPeeYG3oYDfR2TEoDUzLhd7nOiWII?=
 =?us-ascii?Q?bvSKFAKnQk2Ufk+6f8poTHQM2KYTaO4WDzRH331mjZKy1nmcutl3+6kL0FcQ?=
 =?us-ascii?Q?55+q3xkMcrkqPGBqLqCc1vAULwnlyMne4FAEl4fFs1VK1wmIn8tRKi+6n20S?=
 =?us-ascii?Q?BVk9s/3FUBXMuzdAqVSh+6/AlkN9hw5rsp1tCCoo7VlNBuAQljBrgKVpKV1Z?=
 =?us-ascii?Q?J32cZB3XjNLNl6TQL5nXHqsShfN5STz4UB9qOFlXwhgmy/R82NXZfn8vewkr?=
 =?us-ascii?Q?cEnGPDmVh3Gg6JEIDTGQFZGzOiPQp1pwRgLcnjc07zPcVz478Q/QeyZYISzt?=
 =?us-ascii?Q?hg51uuenBFmTYwWLmbhQsKLOaR0QJMumQlWbFnafzuv+wMqMpyh2NWuLdNZm?=
 =?us-ascii?Q?lXkQoTA1P5OkYY4C54n5RzopKehoknnv1tA/2RVI6N00AJlb/zhMwu6F/i3H?=
 =?us-ascii?Q?YlJJuDkxxIviMQ+UojpA0ujteM++vgkj3k/NbNQr+2/kKg4bbR1FZUp7CtP7?=
 =?us-ascii?Q?EMcVuq85+TpPuuwO2Uo1Nfiu/feOcV/F03pWlOs9MSMz7L2SXqnxlsrCdVcd?=
 =?us-ascii?Q?s4V/Dt+Dpqh16yNYq7IuXDAyt58/AN+yl4uZQosKykS0vi8ot0geCxafVVYh?=
 =?us-ascii?Q?Vs/kYZ2pkkncIVQl+NOJr+hrHYlm27UGUB7w6QDvDcoKngA+pzpUpQXkrrA3?=
 =?us-ascii?Q?/IHL0zIAG3w1Zhm/UfJP6xcOHildSlo6yCqBow68JBawy0stAJYXboi6w/+l?=
 =?us-ascii?Q?sJDQFzbGy9BV8ki2i6UtcUXX5U5L7H+PI3RwSj2b2MJiF+QozIEWGJbRNzEQ?=
 =?us-ascii?Q?8w521GACEpqQU52U5S22CC+yJRMgK6bnKD5J1gzaWvhmGcwJsC6lfhgQ+Tdn?=
 =?us-ascii?Q?BEg94+/b3kyrleUu2lHwUl3rqPGjaPK3hGLVWgs5CQNEAy1zPQy0wTPxg3Yc?=
 =?us-ascii?Q?WEWCOWZlqJn5Ao+LGv8dvqwVuPig2KuDNp9ThjeEj9/78SXjQFdNye0cKjYL?=
 =?us-ascii?Q?M+Vv+Bd4XhxcD7+c29MDby1iXFbQM8ndFVihXY99bXUds1PvZVDyacQg9OiK?=
 =?us-ascii?Q?hSAlPL8LTeGp1RjtSAvGTonPOTEmC25z0acX686WbhfV7cxrsgdDq/XHJIBt?=
 =?us-ascii?Q?jdZXd/144TRGsbgizMKSyFiM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29755d0f-4a3f-4bc7-7ed3-08d9922c1815
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 11:40:33.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnsyvvTbS3x0LL+TMhMZw3jKEwrNuw+0gEgqxk/RuptcT/9DfD5PMBJiqgX9BEME/L6b4LJBVVPtr8TmH2jV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2508

Since mptcp_set_timeout() had removed from mptcp_push_release() in
commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
sk in mptcp_push_release() became useless. Let's drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 33b94f705096..7803b0dbb1be 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,8 +1469,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	return NULL;
 }
=20
-static void mptcp_push_release(struct sock *sk, struct sock *ssk,
-			       struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info=
 *info)
 {
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
@@ -1533,7 +1532,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			 * the last round, release prev_ssk
 			 */
 			if (ssk !=3D prev_ssk && prev_ssk)
-				mptcp_push_release(sk, prev_ssk, &info);
+				mptcp_push_release(prev_ssk, &info);
 			if (!ssk)
 				goto out;
=20
@@ -1546,7 +1545,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
=20
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <=3D 0) {
-				mptcp_push_release(sk, ssk, &info);
+				mptcp_push_release(ssk, &info);
 				goto out;
 			}
=20
@@ -1561,7 +1560,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
=20
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
-		mptcp_push_release(sk, ssk, &info);
+		mptcp_push_release(ssk, &info);
=20
 out:
 	/* ensure the rtx timer is running */
--=20
2.31.1

