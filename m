Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79A3207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtNMBURhi64qj0Q5adEACVxQaoc48ypnbVLCPs/7Q8R38Klshsi5aaqNBetWuHvXIj+c0uO+ezSyz260lWJ+zwgEsjUlKQ1oiRhpA8LodR6bbcNeNF4B5zP4p5e7ED5+0wYrb287qj8TY/6uCDrAMo+sqpFUjRZpnHqC5Wjr+SNrLeiSzZU52RkS/5Rc1JBA197Vjp7GUR5d0cBzrEVyvZCrc5lDjyy9Exb2hAk6dpLAs+u0V8gmztuQNXvgAhoTuLxA8BPeWIAtwAq0YgZCjomaPAd+Z9VvcHyHV2rOaZ7VxUoIy/3Bi4+zFBXPfkKop0wyrf4dlwnMJ6RwJC3hHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBqcC0XH8lE/uvVbkMxs+vy9jz1fzIz72BZrPVV4gs8=;
 b=jrMxDKggG2dd3geuflta98U+Kq2eRvz+HQers2jHNzCVxWthXKNWJDNIzOPURH1LbQx8XojnQPDbWPN7zs7eKTqb5Kc8sPv8vvf0gzNmNwgkMzadJ8XBgCLRovo1DbwjQ8/PQHtPq7pgIjMWFZJajzNchVFFmiWu8Uw6M3bIjsNsHs8rSulL4q16r539bM98TL068rMunz7q63AvgoAlK4MnfecQpHm8HHvaG9ZgTbHAGCTSvwk7EpwdQadAqnMD2s3YSkhfOFpDw9GIDMS/81eLuguwMGnmEHikCX5eu8YomsYc8QZCpXC2vJFymZHY0/pl1D1NOAS5ZeFwXOUOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBqcC0XH8lE/uvVbkMxs+vy9jz1fzIz72BZrPVV4gs8=;
 b=fF7kgiHOdKiGXIzs1CqeIDQ7FYUmzoHk7Vnfdf3b14HVbSBKtWLv7KZI0BoRUGAF/cGJKY18Ckf48807FSrzgFqtF1zjjkk9HShoQIL3/bNX9tHmn9dv0S/SIT3M7EUnz+mM1Gd8zJFgNsK4PXhCP0CAO74auwKJ4PCyb4UWU1nNhKGq8fw4mnFWt3Tb6fgYUQkcKDGKQIViRoQtc+lJsO0QPl/YZGbUdecRDmqXZKRqtjL/ZjkWexM4F9VPiTYLn9XU8p3p1fjKww/mB6Nu2HqgiYytm6L+bCvL14GH/nUuT+Phf080v5A03t/3FGzVob9bYevY4MUjMCmmZao8Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:01:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 06/13] mptcp: multi subflows push_pending
Date: Tue, 11 Oct 2022 20:01:30 +0800
Message-Id: <20221011120137.5475-7-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5b107f-7108-4975-25f4-08daab8064fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dXjqWZTWS9WBFj/lV8Atx/OCuiTBUf+loJRKuQZUQRhCw9rWdvJc63ThHs6eWETtFulXweqUyr7rFdrzNwjug7j44s6/laO/CN2dKPHVFOySSTj6pVn2XJJvy9WD0B6Vab0vRbb+FEvC35wDwS98EHBsDAwsQ3/+3gz/ndLET94nlp+GsLMY7oSsTmQ6iAoX3CdUOZzRv8FGYMHuQhr9aS4pYcSARoBDAWCqvWU6hfAVaU/KfPxipnHmxpRS+snDJJR2wXzs6oei6J1oxGxJaSpt7RPoE6hyHlIyS6lDo5Vx2FpVgh7EhX/h1Fj7gvbWHySH1mgaBAmolX82f9QTskxgF7FOoDY6bwgD+b7LWHmAW32e8VXBy1tNNaOHMZBSMJ+OSgSkHTsmpu3ts9LFz21fiRUgofdSo9JaiwnrAniREtIPRPtRQzWj70exaqeB6hi0+hfA2I1Ux2/d1ZkVJn2WO9LqLbzNAQQ4U+pdgG1P5Ssx0XVraNUESoBrPJaVsS6bb/5aqVfj34+D4KN5QFp47sm+9AAqm3A57oPTzcZR38VuCcWV23qgTnxg7CJs9LgBQGMvXPAP0RPokHTj91OjPcpkJTV70qS79MTqqxqnYEU9HhdPpyr00KjPurDMsQSMEguJQqPw+wjHA98i3upY52+v8HMVcYptQgSMBmf/SDMgs9qRws2rPTLTrxB3vx+4r5uQfvE7+W9ZxDv2uEqYnWVpyvrDtXm69NUrXiGSmlpgmiDfok8MDVImTmux
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAOf7fLGEUZAo0Z3X7zKikMWu3TVLZDNwFqj2yxYXYepDdPTXEMr3Qtflgo2?=
 =?us-ascii?Q?b0sXx787xDMPoY23DVSRBco95bQHTS9ONjiWwQLupTWJqLmZos6ao/HkRrPE?=
 =?us-ascii?Q?dtKR3K8KrzyZ9CoAXeR3Yi+qsfFRSl2ywl0PKN4oO/8a134w73HXlXWVh195?=
 =?us-ascii?Q?swy7iuIByVUbK0XDzWXLvPK2qFxghVLhY/CxVd1qA4gqEsTv7QvgDR+gQGwx?=
 =?us-ascii?Q?uJtbXkjat6qavOunRlOhhnCL3POLiTxIaETsdbky6+/bJJTduqoK5XT1Cg+s?=
 =?us-ascii?Q?NcG/ZV1+/ISKVntYjtVQNmNlpqKy21mrdoPq0ScCy+GeXsxhjjA6noHJCEnl?=
 =?us-ascii?Q?YvBzM52BhbYnmaiOMJZzevIm5hs0TIYgSR9WGmrGksZvRAAZFdkNHUCamzWN?=
 =?us-ascii?Q?vn9ohWUurHS1ACucLhqmLql3DyyvSOGRIwn+KvuKOV0huuLCPxojM7RgHhRu?=
 =?us-ascii?Q?tLcYBjqpz9dDFnu5FVWfPrM8yjJLPjVj7l6/ZyRSvQNWO0omihiYQt1vZRHI?=
 =?us-ascii?Q?KBFe0pKQBoIIyDCje+iPH06LKJpseF2J5zkwfj8ouPKYlv1phGCR3FWcMNeh?=
 =?us-ascii?Q?kgWpXW0vGtVa0mox0c3UtabvRc75mp5UnV26UHycdNnNoyyYOt0ZakTzhTAl?=
 =?us-ascii?Q?D2PYMezqBURPrch3kAUYbq0mSDuEi4aa82R3i4s+d2VYhmEw97myiZTCKxb9?=
 =?us-ascii?Q?ut//QRxBiOWrLLccdxkAcY/BPmWXxd5Cu/VDp/Oqd7pSM3ShE5fepdt+T5ka?=
 =?us-ascii?Q?oQvYS6YickfDqacRkgYN5U+HO7YhJALKgfuKP3PtbFUpEHMQNnJK8o8+JDAD?=
 =?us-ascii?Q?eA459tbqZ/kimAzj9I4GbHWrDtjY18X2aL0QZxR7eOwOdaUJ8jb4YYL0uonT?=
 =?us-ascii?Q?yfL7oSerLvPOsK5pUX8Ca6R7x+4+c0rCuwHq2cOt9BtYBYgQnYCpB1ClvCEK?=
 =?us-ascii?Q?R67+jAkzQOQhKqdhmt+77lEnl1fgjHU9Sz+Zp+Qkw9OEGLeg7NTR/0NKZjXm?=
 =?us-ascii?Q?idN9EOQ7H/cMjbBRQCYWsi2Pzr+MahyeIVIZ+SP1paD6cQlp3p/zMoo2lmQU?=
 =?us-ascii?Q?mWYnoeySnBCqmUc7uTCIanKXCto6exrYxIh9oXTXpub5ukrpoV93gSHhK7+i?=
 =?us-ascii?Q?2Kic2MFrqnmOlf3FZtWPhHdUHeLcvTfbCqscLvNF1jw5zodYJPXCvB59ODzc?=
 =?us-ascii?Q?NJCT0zwp228yVaNHYEYXzwkhLv/lMKWOQPwfzbFVOWweyNr6X7Juxjwi5dld?=
 =?us-ascii?Q?I1S2XEakbCJMZV5Z/95GdcXzwOhe5rpSWW3PD/Ge5CUovGrhedLhW8KOKSjf?=
 =?us-ascii?Q?tEeeXnzdqRN2V5LEBdjr1sZnwuENeTEnUuQLZU9Dd4EejFVCXUQlqTqbG+pa?=
 =?us-ascii?Q?5kY/1Gh1/OR2FNbzWByZHqj5+ppEZcC531WbLpsXCY2uFxZ5bum6s6ASSRJS?=
 =?us-ascii?Q?U0ZO1PAgyhDfq/J+ds/BI3a3NZw6hu+3RFjDn8pZRXvE2Z2JTDzX4VOV1GjZ?=
 =?us-ascii?Q?KShCGBiBW0LkJiOHJZIBvC0/pG3awqVCg27v6JNaSjVXFGV1SWElBOyp7XSM?=
 =?us-ascii?Q?PWXjq9h8nbtYMsmgpc2ZRFrq+QD2Sw6pPNHMaHpruAflePM8/PLKNX/J60rD?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5b107f-7108-4975-25f4-08daab8064fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:56.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFMbIg/c8jOADNGSmroJ1hiE1DSIyboWqExi5HgBFa9miQ5o1NtNZT+bWkumy0y8NSkFn4QwX41/OnyRoPpAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

This patch adds the multiple subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 817e539d1d12..86ac38d10bc4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1561,22 +1561,30 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	struct sock *ssk;
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
-		lock_sock(ssk);
-		ret = __subflow_push_pending(sk, ssk, &info);
-		release_sock(ssk);
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		struct mptcp_subflow_context *subflow;
+		struct mptcp_sendmsg_info info = {
+			.flags = flags,
+		};
 
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				ret = __subflow_push_pending(sk, ssk, &info);
+				release_sock(ssk);
+
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

