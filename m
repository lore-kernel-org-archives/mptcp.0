Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F320FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2EWFXOm7umpvVUDW3+zQzHBtq7vOvrQPv3DnXMKD40=;
	b=nEdfA2tC5XJENqQUCLPtK3h3ePExA4hMe05DRS8CJ6bBkU4SThkOFTqPt18BOnYESISOx2
	xkQ8kCyIleQi3yc36F6wjO+MA0sQcLSAjYfU4kLt4c8nRfBRgs9Dwc3RdRyFD5Dg82Qycl
	q8m2sYluuKxkELziuzg8WuO0hlPrZhM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-G_Tg-0fJOYObasMIMSmp1A-1; Tue, 29 Mar 2022 09:09:44 +0200
X-MC-Unique: G_Tg-0fJOYObasMIMSmp1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW9ImFi11M7toTWAwX4j45ngPFNTzWwKPGwn98sZpezkx4fr2mBqK/XaJ+S/VWlBQgos5wngGvKmHNl+CfcU+gIQbq4QekjmvDBX6++sBEyRDAYcNG0CHJrThBn4Mqt2aLaMxv4kSZZ07T699TxBG2MXE6CwPpziJoWkkjHDA9mAJSrUGIPuaOHUHnhFui4NxHszhUR8B6TrxEOCCEf5awo9QgZwNTt3KV4bbV1Rids/UDap5EOf3JFCIRS6cjjGn3zaXb+KNexkM50hpPKdteDIL2CIZxT3tdFEiULX1HUGgWrkisQiO3mQoV/3pyV5Deu7C8jTnTkhTF5kynK+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+4Rg4Gr3iKZnA/EePnh1KwHKsQMmy8fUEmU9ULDMa0=;
 b=C6Y6tX6gy/iNavp9UbeH2yX8/Uy76s3KReX7J0dxx7JPb3f+tOYujoDdYkKms57g/lJWQOTehHTeXSao0NdMOedGC08XGyYocMeHYRBRpJHwAtfj8ncYIeJBA3mVbim/ytdZ6iQqT5hvgaaMrAO6ql+FBbEJtAZ/+MLt1DsDb5F9+95ZTmjTN+Ge6cxsGcKvERPrzQX6zjJ5ivCqlnV3iiatyFqaou8AvTyFiEbZmGbZP826m5gxJ1k6lAbsjTFoznQ0cJw8+1Uy0CunCRjjJpYigAGNNZk1VspUVyU1YmtHBLUMqINIAR1b1wL16cUk2tPBXxXObpbCLtacnIHFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 07:09:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:09:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/8] mptcp: register default scheduler
Date: Tue, 29 Mar 2022 15:09:21 +0800
Message-ID: <080d123961d28d18678f642f1526d448cb516e27.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 459f3f75-db27-424f-a2c3-08da1153195f
X-MS-TrafficTypeDiagnostic: DBAPR04MB7335:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB73350DA60304BB8F1B6E3F4BF81E9@DBAPR04MB7335.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vNQ1XJ4oFir1YKLkZYyjgssG/qN0KDp91qYG3QhBVFIwK/oklWje3+7KLDN2YcVn/91LY0i5YnZyWe3mfgauqQ6VS72Szt+rXxgevpjMArbbbzkEOLGFa4ot8pIi/oqM8D68bCbh+5tmTgunsJe73zeDAoHRjZwqxwPNMi5lZL8Fq+iP1iBfBevSyQm2zfBFdZvItn7W7Jgm58TIDVnsdkFiZy6Nj0I4kDWAswtYozuHdlFzBjVrpg6oI2D9z8wEcnn3cyFb0QUh4zApVYIiTgkRIbljin6qTPB7+BTovY6dFZbAuB+/X68njT/WlIuRtEUbGhyNDfEh8lYKY1BH6y/B0hu3RKGkA6HXBAhtvZDhjZm07ObIStXZp13iCjLw7FxoE7nSfUqVhAo/MxZehaKNv/P0dJzXaADCKUc16UXQuC0kl9Xtrj85/MiC50itgBZDLUzJUcTo9c8ZngXmka69fawutr8RRct9gNO1sTDeNht0wEEig3/Nbkc9h+6kC5t8ApaKjupByey9FLvkN81UawKEgJL2CCbNrgfCwFvgA2AcvmYrG08JT3HRvfxLGg8YLklr4gzhT5yxvHn5qZ8mpfpyx9M/MV1YnB4J4vSTVY3OZBdemx/CBHhMPm9Ys2/0W/WbZwqnFODEnbbBAtpl91vQr+5W36iJig6Ip5p6Y+OR0nsQa9mNK1iPnzsyHlWAjdHSXObZipS75sSJpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(83380400001)(36756003)(6916009)(26005)(316002)(186003)(107886003)(38100700002)(2616005)(4326008)(6486002)(6506007)(508600001)(44832011)(66946007)(66556008)(8936002)(8676002)(66476007)(5660300002)(6666004)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZwthK/olv229K+iU7ohi3dFHlZm3H6hCew2M3PGtzauQRlI8Tv9hzIpPl1Oy?=
 =?us-ascii?Q?0oyFG4eSuL6Jx3JvlEqgFCB2GinojlSPY+X8N5T+iSG95gCRwHoKMfPv8ckO?=
 =?us-ascii?Q?FwIYRYc2cGxBVq08esQh6vDAI4sVikGykei7SXPH9QE/yvgBmNfwKyF0g0YO?=
 =?us-ascii?Q?oApH3yytJ8o06yKEXl20rSwQuWj/noQnV4oqKjKeKLfvFaCoc6+mBYIPpoeq?=
 =?us-ascii?Q?we6c31R3uVIqmPrzilV96tWpV79dzMfEoSWZwQCfTLA22xBAlC9zGlhJEJnF?=
 =?us-ascii?Q?WaVB5xGzLHc7u31/c6TMPQvgH1FWodN3YWivcU1e6KT8VNjvWgEAMsjAbKNP?=
 =?us-ascii?Q?FPvpg/X8et5qR0296Abzn2W2whc1HO55G+eOwRSkWjJlqa2LyAt0+59yPZm5?=
 =?us-ascii?Q?9VOVI3EbE+bi6onYKJwR8sSlpM+DJoGfhZzfYPRgzmXqJWThLeWlIsVKqtOo?=
 =?us-ascii?Q?x1UZY8FzXMyIiFGXGU/ZJuFAcntRxSjeu/lgf1ogFVVZ7/1Qxry3J986LLNv?=
 =?us-ascii?Q?05UshqtEweT7gNlFCgvnYNakQgJY36XR4tGli1CtlPxfBX/XT9gUyMGrETGu?=
 =?us-ascii?Q?ag8M1WA+xF6kAniWiY9pEHJeFCoC69+nNdSnuTceWe89l+ZBD+ppWdCSaD/Y?=
 =?us-ascii?Q?WmRXgli2rRqPfrzeabcmHOhWETsdWF6qU/G+hoRNrOXDqjQUxkJcaw2fQM8w?=
 =?us-ascii?Q?8lfXP3g7MhFhhfMOAa2bh8KDTu0x/zVgj1+OmVvq0rSctweOi06DzoJTm9UZ?=
 =?us-ascii?Q?NioybWWE3IGX7cB5pqVPiJkkFAqnNcPRnz8Z2Y0lUXHTDiiEyf6ouyrDOX3w?=
 =?us-ascii?Q?QXl6xECjQxjuQ2S+jL03qSQd17byzcteq1HPsFKHsqd/V1SnNhokr9MRPI3Y?=
 =?us-ascii?Q?7wcR6UD+qw2dUDYBFrIEZ/HjHRd25gE3Gg+PEaLBEubVRElFQ+e0JWrn9ClV?=
 =?us-ascii?Q?/263mUqkRhKM9HU3+WzsE9ZiXzDQeLFnjOa/C+8wM6AdledJtFAEZTSmYvY9?=
 =?us-ascii?Q?Aj0V5ZMyJQfbjOm6w8cLGvt0hvvwcg8Z27SGmvBf/PZxHIB7n3718Z3KNP0h?=
 =?us-ascii?Q?iD+Sep9eKLsFc7+XyEyQ5z+cEhxbFFj1k4gsDcM2CKWdXYCNEjfRQVCQbl87?=
 =?us-ascii?Q?AWxzugehqD1qIBIKwwuvLX4WUQh03ALW8EaVGE1dnI7UTb4b0ix9qlIR562t?=
 =?us-ascii?Q?LKzyd4r3ajf+sAfOaKDW2aWzy3TGg5LYw82ElNRl6chl1YfMW6lvrfD40jAI?=
 =?us-ascii?Q?cMqo0pvi500BRyT22w+jcQBg8tXJqCzlFch8HMiVNw4aUHvfgiSs13gPKadQ?=
 =?us-ascii?Q?b/Rc/lybhG24qvUkD6yC5FhwNWOYvGQ0+USbO59e9/nserlvlOCHkUId8ILx?=
 =?us-ascii?Q?GP5pl6IzoSRe/38fFT5qgJizCfJDi36Jcm0xl5QIiOGLhtJUXpnYu+c/L+y4?=
 =?us-ascii?Q?QgaO3HMFtMLP15yOhtkpCxXrYlcPBY4X2r1eyC4nPk42fKGAmNTAgtKG26ps?=
 =?us-ascii?Q?zm2TMdGiQ5oks6gSustPIIXk9fUBT8v7r7FpdsDryfV+tpibvRH1X+oZyeF7?=
 =?us-ascii?Q?6lmTB/eIlHBFvysGWFZdiGQPQtJqCd9IaxCf9r56mwv+zXu8EJqWJiDPk2A+?=
 =?us-ascii?Q?b37BS5epPHwSg0H0E7k1HXCgu7GCYXyN8Y9G16ttxjMAEjD5S6wL2wSJJyCr?=
 =?us-ascii?Q?6xy++P/kJA5GS5Itt/e/mVt6bzutBVOgxg+pKmo3DPfprbmJfdDbsIMCPWeN?=
 =?us-ascii?Q?85Az+myA9QhjCwYk6WmxftSsNDWdsN4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f3f75-db27-424f-a2c3-08da1153195f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:09:43.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl0bdv3geS8/arV88xusFJ8A60oPPcBRPyqITO7Chop91eWbLkDDjTzKLZmCx5ig6dxUncDNamLmjpo72m0/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

This patch defines the default packet scheduler mptcp_sched_default,
registers it in mptcp_sched_init(). Skip deleting this default scheduler
in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3887f628b54..6c2d6b932d25 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9d264fd4aabe..76b98240921f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -611,6 +611,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..52828eb741c0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

