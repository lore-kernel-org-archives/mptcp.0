Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6F7C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuy/lFZZjfGUs/UiGO66+j2+HhssAmN8KaUYPxSDPEI=;
	b=eQPElcmDSGddyVImU/fkWYbNF00iQpdRONGCLCw+Eo5MQz+wwXQEiRcB2EZNiPZl8z/U5B
	DRPZhnLI8yxgK97GuvcRf75OZdw3BtDkdqihU8LoYtOrfx88vfmeYvF0I1bEhU8nU/sEaD
	IkQx+r5CvnhifuraZAM5agW2CgFQX08=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-96qtEqIuMlyXEniM451LTw-1; Mon, 23 May 2022 13:34:00 +0200
X-MC-Unique: 96qtEqIuMlyXEniM451LTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUnb6FH6qYuSUo4FaPEx6+rdBEeHoekLpEWVar+RBYEkx8f2fX+tE2ujZHBFSOj3zENz4+mudC2p7jEvEVc5uEPYu5OT3KXvBZNi31Y9uT7gVGXfvvnh3J3mPVOObFdqZi86mgwHUIF7derh9+WZ77t+gomq5Yaaa/VY8XnXxNokDG2Up46y4/THefsc09n+gOGJAbp3+2eMaq4j1xGpDYotaS5AKz4SzemwrnAFiAskbnxM6TVYJ5IOy1y6YgpX4dKPeIa9/4RbVqTd8FUXC1smLDd7lZ4W6m/2NXFNIalFUicbPIbTrG8JVQnnk1PRq2eMgYgCjck9Q4eTEVKILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/VGgAiZlqtzFB+2ggZ47SMWmE6nwftlmiBoW6X6Ns8=;
 b=mzDoeMfptwSbBTRJX66uWWXLW2CHIgruoHJZAqg1J+xCS6NQ20Pfzx4JyU3GYBLc6HvcjqvlVp1q4cXMhabswBK568vnHYbmCgGZkGpqU1QTnGBUGpPT/OhUCe8y85dx1F4QAHe1IqzApQYzrMl3vU0z5FYtoUiCj7iTJeL/HH2sVcJ5/3KykezZxZay4OztceIzh7AJ+kdscdhzvtoxe18lS/X9CL0Rg8X+VlWryz7r/Xz3YEIXvp5BjeAGofdd3MsfFWTznVGQrqUOyX1mBNRnW2JTgC0UtZ6x03vqC1rixjD3LHsJTsG5GgXs9+WMOwoQyAseuPwL5PtFx+J1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:33:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:33:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow wrappers"
Date: Mon, 23 May 2022 19:33:37 +0800
Message-ID: <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653305364.git.geliang.tang@suse.com>
References: <cover.1653305364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b25a6f8-6abc-49aa-cfe3-08da3cb0206e
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB38997FA7939A7F70D6D67766F8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0FAWUqT7tNuzTViyNQPPc0I2AHTnPNd5rvmhX+VLCk0WaifM/lMnLAOOLBOHC+upSUQqOTeqDQxPptOSV11Jo923ORMVwCRUm5WJP1YdB7f47QrTsxdjEAQjAQsx9WsWEtvHrs+JY20bnj6rZmQ6MFeKpNknMlPDGEJkC0ikIrSsDzUDW5HAPQFPd2xI3BI+nw1gkYP04HGAOD995ZEs5X7ghL1laQzwlzT40H/Uu+IFhPglahRSMNpvfrRm6u71LPfP6tF8+vKqqLtrkoZOa0B10+XfsDoulgHcyJL7it9pcm9k5l1eqIeHQ6CAe29ojnRRECTW3uFofrEBLIG4DFnpj5/9Ld13UD+TGcNFYXRykta3wzoGbzxFJOle6KLnqbttaucmgXaIpS94lf0rQNx69iaGkUs4YlBSHXn5W2JgF6HYDShGOlIBHVPvcjILYbULoxnlNjU94flxSv/RA7qFctmFnuN4ovAY80JxC17DKqD/yONU/pCK2EGRfado57/asGICYhGUwXhkzgMAxP31rA1QXGEhU6yUtSdKQ0iwxlvZsJm1Stq8uH54e2UWwbjuv2QwCXlN6bMOOJEiocna9G2Ebt4sIDE4xl3aRs/CAcSlX0kTBOb3YMie1cWwwbZBbZXcNJSgQY0pO2tgEnDUfEos7II2geqbLqNqwlHSUfE0KqxJtL8YnlDjEnHlDnUK5dT/gcKUD9ImEbwjLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(6666004)(508600001)(38100700002)(6506007)(26005)(6512007)(44832011)(5660300002)(6486002)(83380400001)(8676002)(107886003)(8936002)(6916009)(316002)(66556008)(66476007)(4326008)(66946007)(36756003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ky7KDoUyik1aRGK86YW2spVSdyWBjzYLVuGZfittWFqTlPrN3wMfrP5zSfbM?=
 =?us-ascii?Q?I2QTb0ZXiy5gh+BEIyLMzdwJWczQSy52cdQqA+caSdF0a97LEpjCLJ2cNLmR?=
 =?us-ascii?Q?dpRZ1xTVGhOkiFRI8HsExCX4IUrF2kk0y42YVrl8yJwZ55Hw1mK4jGoKO3Nf?=
 =?us-ascii?Q?e3DTqF9k5IlT9yUpq4X7fbCJ1buLqaJFzTekdg0xK0UkssACHuNPirEflcOP?=
 =?us-ascii?Q?z7ebhtOgUralL+j2j5RLbaxWjjU/XytY+5EVR7bFeqgAkaklhKBCTwQD5vQq?=
 =?us-ascii?Q?g9mSKK03MKUFYJQQmzHjkleIl/LHyhLWv9ZxguOhefEJ0ABx7byP8M2TY1gs?=
 =?us-ascii?Q?aVzdteCU6zlrh666EsBErUfb3nqvb6fxWDUOLH/jhUGOHzMkhSwY6v0RnMxJ?=
 =?us-ascii?Q?s7IVcDXdHcC9JFnSL5CYidt4SXSDopVki6WvyjnNMVxX9jCUXXClJHNawtHi?=
 =?us-ascii?Q?gS6coxR8IYdpwrQ4AdrXwvupEPuPDoX2hPrGKDoXMvk+NpZkHPN9JOpm9XkD?=
 =?us-ascii?Q?o4RFnHcoBYKQvBkuNs3yX4ErmOE+ZQcLrA66YaxuC0idEFSWXq567PqiDmqO?=
 =?us-ascii?Q?L4MNNZEd18YtKxzd05K9PObOnubNluA+YhpB+RAXpkrexpYRgPi/93PDvdNw?=
 =?us-ascii?Q?LIVGqU/6R+XT1Kc7OlwmxXbyZo7sEBm/5JPC5+kWeY5HMWp2gVBus/rT2cWx?=
 =?us-ascii?Q?Br7arbVyPNdEpJq/6WMzyRfplmqUyzl8wHgQkeclkfE9TmBdy9BqPCvRscG7?=
 =?us-ascii?Q?fLkuF4nVWzNuA7U4nEuYsWcWcuJYeDabRsxXxjtawg6v/uPh7cvxAjohOLlK?=
 =?us-ascii?Q?jhXtRfAYKgbD+9XWXsMAg9kKur+FEZIdHGXR/fC4ZPcHNXY4VNsHcSUD+CUb?=
 =?us-ascii?Q?DkZnhuJazy6l1JeQN7r5T/DcRb7F/Pz9VlyvJRg+FXl13APp5pvtlpGG9qEy?=
 =?us-ascii?Q?GXOyK+F4wgyxGgfRCWhuKqFkR9OW7iddJNfESJxyhL4aiWL0RrUJEJGW2kVU?=
 =?us-ascii?Q?Da2OhZquKPlBLOC6E0dCXUsAGqAL4RltIS1d4R4WDSE+VvkEnmsrVwv4MpyB?=
 =?us-ascii?Q?QGX6B1l+oOcdE6+DknRIXK1MjzgLEqaxyXE8lzqXt8lt0I5ZF85f+oF7j2tF?=
 =?us-ascii?Q?yaUgDYHE8lmwfzsqFUoL4B6HCEKdiHG6zIRybO+WFXy9OwJDDp5XOtMSwGlA?=
 =?us-ascii?Q?Qb+sxvOPS3/aMDA4Z6WnuIC5m8+3KGld5I2KbJVqbJJPyPSG3MJNTa9WyHsq?=
 =?us-ascii?Q?P2iaG0kuqsoglE9b9xSu8t0bCB0v1zKlO+x07QxhdMAVxDrquuaKscZhILXO?=
 =?us-ascii?Q?42dddeohHNyGvp3ZFe4p5eU9ky01f7yNRUJr9vup2CAe4i0Pk3FiDKMBQeiO?=
 =?us-ascii?Q?SmxikFTil9OdFIaTGvpTUlKS8z1xlvm1emvxZmT3olTrM0B1kjZFk031JFbH?=
 =?us-ascii?Q?v0vLSogBRubl0sOtFGiSL0Q5AoHlINi0EFunoaqXhi/axrkmL4JkfZHL4wSX?=
 =?us-ascii?Q?5FOk9Dq0savGDJ5jrKEw38NHd268dsSKopA2HReC9IXtp6o2JCM33WcpxsEo?=
 =?us-ascii?Q?9GzjKth72ef/ik8hRKgwq5y3uo910NAUKryWKPwP1nqY91CGioT3HaZV4GKX?=
 =?us-ascii?Q?CHy+wnfKlDlji/oGSIA6819ZwXZVH09TZWoIpJq2VrVhVPDk112uKdnrsrw2?=
 =?us-ascii?Q?5V3IshzX/sUk3QsOtGkxA+Ga0hXWjq+lgWZGN54NN1Pkq5CVcpsGzSAJFQnX?=
 =?us-ascii?Q?FMeJRhq+GTx0DVgt05ZL5u7o4T4hyoA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b25a6f8-6abc-49aa-cfe3-08da3cb0206e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:33:58.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKwfolRUTgBfWV+4vtZuFqxpeXAQkbB0YXiwDZgfjKj7Lj8l4Ji2ZYL4CaVkJBYja74eZsEHTp5/AXdbv498EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Get the return bitmap of get_subflow() and test which subflow or subflows
are picked by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..0ef805c489ab 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i++] =3D NULL;
=20
 	return 0;
 }
@@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	unsigned long bitmap;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 		return mptcp_subflow_get_send(msk);
=20
 	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	bitmap =3D msk->sched->get_subflow(msk, false, &data);
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (test_bit(i, &bitmap) && data.contexts[i]) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
+
+	return ssk;
 }
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	unsigned long bitmap;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -134,8 +158,15 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 		return mptcp_subflow_get_retrans(msk);
=20
 	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	bitmap =3D msk->sched->get_subflow(msk, true, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (test_bit(i, &bitmap) && data.contexts[i]) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
--=20
2.34.1

