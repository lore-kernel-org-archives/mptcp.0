Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9215AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOgqTKeadq6l6O/it/72C21k4Gpyh+3sAou9+rrZqe8=;
	b=dBbyZgZ3SOFkxr++LxoW74crYqcxAU/yUUsJFgbih/8U/QlTlCNUQ08p4LrQKiJBReoO5p
	Z8vaOdlDqyMR2WtUTBOblVgsYRy6t9ueDGCAXtAgo/7mdtvhhZdqA2cJgA5AZNOKsybyt6
	K3NYULYGuen1uIOb6X+sEF1NqRy0qzc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-4fFfORFxOLGMuNW_RdKeuw-1; Fri, 18 Mar 2022 03:58:52 +0100
X-MC-Unique: 4fFfORFxOLGMuNW_RdKeuw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMmAnp0r8jT+PFEMOEYlm0ImLCiQhpJ5szuB2ERbbRLIg9OYHQNV2jADTolaNZxDcBYBi0sHItQZXDh0zqu2/9kgHerQGDc+U+KsAzrNZtgTq2E2bmXUKFLTzNwhxDlMANncggHmQkoTnrcAJffkv0yet7XS1543uttHYoWKxdDYZ9MnCKJiCpapWsjxkXr9Ltv1GdYgHn1gg12C+eMoGh8ChOGRzrGNEyizO2mklEpqp6ubh4Du8VLNmR2uSbBoDBPI04oIs+OGd5+Lr7Z8AEJ9U8sSzeS5ZaeXwzizthqBL2wQkPRAuLuCmJjKiNcBTYKNUHsEJtqVINH43xIPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG5+r57FIcal6PLgx5YLcfBQ2tyUPHaC9pZOniTysEs=;
 b=G1ez4g5NlzkSpba/U5r5iZGJDAey/tSt+wBQLWp95msMWNdRBzgD3so/lCdF/HDk6uNcAImkdX3r09XOQwiLrP3YHeCp7WvkzgViX6BkmgvA5+G8I61jwbrrir9yFX/c2FIzcuwk+3at+9R/0213lGTSjlSBMQBPaXHHiSC54OGYZ/PVF1hMN6kGmeK8tdxn9LSSPmZXexW6vzD3Iac2VH4lFmmXfEa8v4Ouw56A8fniq6v94frctIlfFXJP2j/wP9o2IRT0zLzldLn3HdUYMdF5I4ouOGRWIVfLNFKPq3LHGQFmoZCYVVpdt3bMGqLtWCTYA8jNg/jPR/5LY0ifzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/8] mptcp: add mptcp_get_subflow wrapper
Date: Fri, 18 Mar 2022 10:58:07 +0800
Message-ID: <287b994479ea2c5b6ac96b4c751e0dbd26bda7fd.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00083ba6-aa53-4a35-34b1-08da088b3b30
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8321EA60D38CA68C65E215C1F8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mLukVtFtTcD3qNFgnh3XPdOghIazWKdDiEVfmUTls0Oz332fVfO5PwqXMQ7vPn45Vd1l+M6S13MtfPFAuE9SRUHfAqs9G3eMungHjBR0s9GYY727ImCvN7klKLnE/JBAUDxM+XpXh5UssT6FFuhe+q+4gAlmsKq2kQzeER4yjgCN7u4xHf1orGXmvtWLjmIz2kfqyFUt74oaSrCEMjV5aAOGFob0xNvJFodV2ER8IuP2SRVr6rpiBBSQrQy7piwrFfKb5I0hElL5ZKvI7e2d5t0J7RgH6bgmkXPumz7Y6KZBPbHDAMrPwVdVKjm7fHQNB+y2fkk4YLiozoQBQu1qT+RLBWdUmRNRmvL3oS4quspr6Y4qhny1LG2Q8AnGeu8Jg/ofaPGc61vz/VC3mFJhm907V1G8bqa90QXgLW5wAmdOCeoxiw7SMwGSLeVD++zbiU+YGh5LWF0qGsU4GqmvlkWyPIj7OVXXLj5Ro5TGcFXxDtNg626cZbIP5lVHOqGFZ1CBGsURw7OGk9VBndOAX0rW5psOISw21uvlessqfweb6eaZJGtKFD/fN9KnN3R63Vff+3ID9gRYtiviADRWRudOyYeHJ3IpwLF2GdGmqm0Rn+gsZ/eW+eH3WZTsGlqtUxzt/Y2AfAcoaAf+I9t7KR7QUdk3fqwFLUhvKrTflKZvBWGTpRgDngQS5fIBcpy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94iIJhSC2vmH1WgwT/fbakuO2VK3fXqzBLWIC4TP+No5AhqR7vL3Lgv6/2uc?=
 =?us-ascii?Q?sK6G6W8/3s0WnFNQzmgiMt/3oKmLMtRzM0OFx4UaM3sKlXeNvnnimoCULIZF?=
 =?us-ascii?Q?hhykCEJ9Inx473AU3UjxpUWBxE8DGuEGIig4grL4LpJH8kdRiKkpgYX3tccV?=
 =?us-ascii?Q?N8gL+Q1ekMHRi+fXLThiQabxTVu4e199QKysa2RfaTE+c2g0dqeE1LdkupwU?=
 =?us-ascii?Q?A1QnXoYcHu9YPPh9xiI4PK1vTKJ6AJqgTcQa3+rMFNFvgEEmZaj6VQJaRTqc?=
 =?us-ascii?Q?kH+/MOBLzKXLEg1CrlbM00L/YnkD2y2v5WDSEENmEtTbtQBh+89MIbVJlr1+?=
 =?us-ascii?Q?jABNsaCYQwQRxfLKKqWEFenEVx311b+fhqOFe1vxVGT4FOsogstR/cjTHplq?=
 =?us-ascii?Q?LJ59V2pAKApqP01C5UH6OmXc6ssFw2tMzZqeJWi4Gviy2zk08wBO4CZVaRCB?=
 =?us-ascii?Q?HLUR19pAS5Mi5Q/uYuRSdql+xt+Rpr0dVZJJuUe1rkb6sGl9qpKukfsVgHN5?=
 =?us-ascii?Q?Ww4b8uhtkVOCHElfSBnUQi93knFuw0wLls+2F6DqUEsRaAzwsjIuYHTLeNid?=
 =?us-ascii?Q?0Ea9dtwhEw/jl5Y0e4+oEcJzmpdUW59tuz/N/Yscxw8ezYIPMcSpc/Hy4UIG?=
 =?us-ascii?Q?WFDYz6jP69gt910kGV+7UI+rjOZYOF8ntkk5twrZUOvH/mQn4Ca9lo3s2Rye?=
 =?us-ascii?Q?X6JgC2zYOXNiOMVxV+CwXoTr5AV2ZnguHUg1eOaxyZA+TjXup4JSASP3lKJa?=
 =?us-ascii?Q?ZMwxdOcJCarYITyFiNb5eFKhx8OTRtCyFg6FoarwNSQeNx6x0IC7x3H7SwW4?=
 =?us-ascii?Q?/P0ieabKD+vFpI9oFzuzqu4mqM9VXQF0GdIsdZ9q7A8374SCnAn9MDd2Vlnd?=
 =?us-ascii?Q?E+zNk3AKinamWWvbNLyhvO6drJhMoVtNAcHpojx3+1wd7dMohCx2Z1TAAD++?=
 =?us-ascii?Q?anz3+U9G/UjQunZq7Cac4hCf4SyTfvAbZKsJdDwtPhp4LMC2BVr6F7WNbMob?=
 =?us-ascii?Q?V+OqS7I0CW87o3u3eO8ma4d1Bfs28RY3c9DoYucAIx2iH2A6uahJK7+qtO9V?=
 =?us-ascii?Q?usYK8Ka6mpUkDjzHBEOqFZegYPVo1GrHFHLcPQspHn6mHEklfV3cBn5UENhu?=
 =?us-ascii?Q?9opeHsIDxN0BDaRLl1G/b+MLY96T5mUXrvjRrHgE4XNvSQhWHhBIgyimj7i1?=
 =?us-ascii?Q?a1mQf0VVEG2fV3kcVNLyiDF7n6OUYHZhlMQXHqPzwhvL3LMSsfgOVsbdqSyZ?=
 =?us-ascii?Q?10XSZD0czQBzwkyqIzgMAz2ePRM3EnwwXOQGySvxWVLmCC6uX8i0GXYxp30c?=
 =?us-ascii?Q?XCZjxCydt64avanQKzXXdmGGdOaIvuA8j5TphCd+cy+wzapxWOKpZP5BADx1?=
 =?us-ascii?Q?4VHU/Z5qiZfAnHJlP7Zw4QOSExLYiVtEjmFzXF06LhMbCOO4qL4eSUzH0K+Y?=
 =?us-ascii?Q?roXNPhWQiSBJO8M/nwgaZLsSpyIYeH2PjDv1yw5DRIMfvQb4WE/eAg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00083ba6-aa53-4a35-34b1-08da088b3b30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:51.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jOPUlNaXG4AFLPdTOMpXy0R+E8lgmZxs5sPc4rprXuorsXM5Uf7DMD7/emWzgsCPqyN1Tglhqz7YmY/2D+mww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

This patch defined a new wrapper mptcp_get_subflow(), used it instead of
mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6b8f41a3ccb..5222849eacb1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3073,7 +3073,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d18c54e2f28c..8871a17f8b82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -613,6 +613,7 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 void mptcp_set_sched(struct sock *sk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 727d185af86e..61cbb0237beb 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -81,3 +81,9 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

