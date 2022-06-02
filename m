Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AF622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWjYRB5OJtckchNXQf57vwh7hT8EeaW840K16MRRwUs=;
	b=SxMAIZI1gLzq0Qo16UB1RL1KoEhUnRWDJUALOcnMFFBCwMskUz4Nd0cCa/nW0DtS+uTh2S
	DIBXUHNbSmbxIgXyuBpxv6V6VN+sylSK1QtXosw3gXOWokErPHR3Yk/HWqPiBwF4aUd4BL
	I3J4PwOib49EUli0y5fzSGR9f45nNfQ=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-C3yukS4IPU2S4WEU-qOSNQ-1; Thu, 02 Jun 2022 06:54:22 +0200
X-MC-Unique: C3yukS4IPU2S4WEU-qOSNQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMyk+aok5ztoZwq79Pd8h3ybtNoTqepW1orKkSMYBL0AkWf7Uu0S84mNOa6i5il2FG0NBFnNiuLtJ1KJlka9qxaSqDeKaB8JvmKP9Bz8ooEG/BWP/q+X8jhRekid8X8ph7rHh1ktE/RTSRbvIYMaQOhcOybHhLdO2fGN0VZg0TinO25qorwfpssDa8vybzIJmr++If8sVe1eKmls5thjlrZmAOphVcWB3c3zJEFX8sp5IgQ9TBdiQ8I+FC9owFABioWi8sw2uKuFYuAd71l7EAVcIXYEtOX73Qt1OQQ0q69bgIE221uydD5UsIlaaMld/osU8gasZh9J0iwKBcqstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e17qFR9y0DaP9jMZrHWybPkeG9cCDZ6TiPiC4QKjtYQ=;
 b=B47IKQ/mdRZspIyrDAh9vmlrUJd61pI7g/5GLkH53tPMEpSaiwHw/5Jyoo9tW/nwT5FMZogwEefMELCv7FSTAsS0MW7sYgPO2zO1ypSDR1OcdFx42XW0pG39nvt9RiA9n8KLyXRBkdEVnuKeyQsLsmSDStahhxdPmrKclqlmyylzhsD1BN0Ms4t+9rJyxDIDqMnKsWjDo86DbDiUQK99afvTEqa3CW/Yj21vGkmwBN3WY79IhfI7SeP2QEJMJ6AuPRxd4s0XO58ABMerlRyaDl6PdcXLL8b0JM15lhDX19hNuKPka4FmUKGRLyfu/oADbK5pjg1LR2svVUsv/e6gQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 04/13] Squash to "mptcp: add get_subflow wrappers"
Date: Thu,  2 Jun 2022 12:53:41 +0800
Message-ID: <79d1cf14bb4e5619f5dd148fbdc7d89b09c0ac7f.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0084.apcprd04.prod.outlook.com
 (2603:1096:202:15::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1709bbde-8523-4b6d-e745-08da4453f535
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB33845CD80054F8999FE9040DF8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m0NQBsjEzRWaruRAvjekNsxqOyiQvGKH+E0HObeRv3E0gV5y5xuXDYJ6kHOZMSrdSWWpwn3A8sB/YGBicAcoWp4eMTeYDcziQbw6OiaRXq62ORs1EC5ED4pzI7PH7NE/tqVeEh3oj/Nbnl8TJTbltD8M6mGerPsdBTTOLriL7f3v96HhqT59LjKNqrydQdDFbjEogGcYkLy40Vi34/lxYm7cs5ip+4t3MpI99ucDNFtum47POkMzPhiBvhB7j/zyhVzhlbAHAcoeQHyIqqEPSECXSPV/iKtgJfO2gPzaEeHOCZnTahWV3i3gteUjUHPgFqkfBy6bgtodYiKwo4V3dFM/7/g5qC5JU3hqi1u7RduIfzlZWn56LKjwqhpEOkBYI3gz/cg74Uy8RlDTtvGN1t+FBoebckSESaNcEEk1BCQbCt+64kvC29/7R+rfk6L5RUvx3K7YURwQEbA+VZSjmMyE6FbUQC51SfjWvV50Wh70LJy7Q9SPH35m/5d0A9U3FTWDG02hgTSqtuTMek6V9fbV2RtZmuFipY2O6v0jI3NTXOouj3rT94TsEuq8dFUJp55r6rDFlm8umGiyULLoVqnrM7mZEY1ZHbkdo4MkfQQN6RSCOB/PgAR6JsY4ZLJX7Ac6FO98UmqMlKXPLOrV39m0z7F3XZiQg9JVCbQnIH5eY10C9/M4oETnTPZXGZMzvKhhuJiCygOM1eQGOyshJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvvZIvxVAxBJmqv/Q+Uqp2ErPjBqJOazntsxLEYCvt3ZzrJrAtC/rMqm9zE5?=
 =?us-ascii?Q?mBqnJzszhAKl9YI8/WzFxRXWtaMNWdR2OMGrfBUUdVIZKlPnxF94qDsNlOgr?=
 =?us-ascii?Q?QSbdMUt0YRGf3H2sBURafZqfiyN5fASaioIBd/XdLcG5OBRU03q1dzr/OwZs?=
 =?us-ascii?Q?23JerG37tZlszyEGEcyUmEQTmhzIeN4toqP8dmjSwJOM4Oz9HvbdsD+yIvf5?=
 =?us-ascii?Q?Hnt6uoK/L8QWU2y82PLMNu7y6s6ZKY0lmb4oqj5+kNju3VMvfXqgCM0UC97/?=
 =?us-ascii?Q?ZZqsn8DOTJFObDr5ybdLKTYV3VifKb+OGUtTbTtfZk1uR/xwU/toPr0OFLZR?=
 =?us-ascii?Q?8oBmTkRKnvOgF0p0jf2L5s7i2WD7B16QSsTNca0rlAnc7GTi0YKLuvDa/703?=
 =?us-ascii?Q?KLIccZGQlJly+Cg0CMU/2StsWZITJuiZsMbKxzOwN673V8x5TAyWc0TJwuq6?=
 =?us-ascii?Q?Be608/BF+RomCSRZkdblbQaSu+FjM6gEwmYnThyAnYxOhNFES3RYiRdND8qx?=
 =?us-ascii?Q?VkA6RjCOoTQdHt34SGszLEOPgKyqvgeP7lLilVJXrT1OX0DR2r4bTw5fTSH/?=
 =?us-ascii?Q?QZJxGQRfCs22YViCMyw3SWMJrKBv7w1u8jFkesafPxyQWiSxXWbBSyAHIbRC?=
 =?us-ascii?Q?ssRiYpXv9TKQiNF6yB01dGzsOqrmFTWut+1JErPUcoENODWTeTvMkcXiBQMs?=
 =?us-ascii?Q?uxlU2iTt+zTbChQjA9tq2p4FHc5G90TRPdy52QaYOULgAizGt+FQpoH91Qr6?=
 =?us-ascii?Q?qgv8PW1LJVNN8soQVn5u6nFyyOa7qaDwrcfgQoklIPjOld+3CzjB8sI48FNE?=
 =?us-ascii?Q?QK4C5dyXHr5SVypRh2e6Fsc0HVLnUitdvarEn2L0mAAbmUzOq9btvgTVt1MO?=
 =?us-ascii?Q?z8OnyZwhTvLWKSSwzY7impOZItrPnFI1x8OQUR4WIZLN93oWUXi3pvtP1JR9?=
 =?us-ascii?Q?LVc07I+lGlirKp5lrT2B5JNYqUXXSSMUyH44lnKoJR15GuS8XL9FUZWZvoMB?=
 =?us-ascii?Q?ebbeTSmzOrtSwszIJ8Cg005VLOhNmgxH8FiT4QpGVBC/CmLIgxJ8hes7FHTa?=
 =?us-ascii?Q?3fBKRtaL9fDKQMTwCtXHLTJVAJIotHZAZ+zA/p9qLKuNHmYqdN0PTOCNovMK?=
 =?us-ascii?Q?+H10SsMFBsHQmmWRV76Gcnw2FA78CX+s5sD7fTjeq018nUjmlcvfhHqkt0Pb?=
 =?us-ascii?Q?pXowME6pAjvNtbouqjKd9Ae/WrKksA9c2bmfB6/eOjJTWTkfJB/4+bvV/emz?=
 =?us-ascii?Q?aktHw1hA1dwPOkeUzfzk0ipy23VvA1BWODLuoxfMLv9vapbau9LxEb6ZxJqj?=
 =?us-ascii?Q?U9ZvowJMn71TGaIM9ev+IPjjAEcrMVz61hxqDJgIIwdIvXZ56BJDZEt6wYZM?=
 =?us-ascii?Q?+H5Z/Prm0R2wm4RZ+h2gmazQCko+wTbVNObiDuilNjxm5O5nLkq5ZFAVaeFR?=
 =?us-ascii?Q?HkVwYs4z3r+5haDS81ISrSv2zto/QspCmBbMzDfZHdawG6rXIIYIoa5sTEuf?=
 =?us-ascii?Q?e30snVyOusEBkv+CLp7seopintFaZ0YpRzgzXvlmTXsGkCcnHGh1yvz+6Hsg?=
 =?us-ascii?Q?Ungw6Cy9JUiVyjeZjNi0Wz9VYkrfcW+RlW2WXL76h5pzFDFwnRqAh6siv/St?=
 =?us-ascii?Q?rRHWgpD4AUvgtQlnSyBAv/pLEgu9aZg/FUDcMVlE4XA7fKG6ZSVjh//3VB4x?=
 =?us-ascii?Q?h66R4afMof1gEF28A+u/DMpjZIWgJfu2xlhExAWlK8FQxK5UOj2zPBhANuIG?=
 =?us-ascii?Q?0K5ZZfo6HCty8gXeeTEh2T7kkYRyFyw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1709bbde-8523-4b6d-e745-08da4453f535
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:21.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ2dmEqt5aae3Cy1owXTYqh6EVzCFKAes3m412Y7Ma93VV9wRYedZv536umqDNTCmXWfLF7UnzfkotIgVHM02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 54 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5a6f289ad985..8858e1fc8b74 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -94,11 +94,25 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_c=
ontext *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
=20
-static int mptcp_sched_data_init(struct mptcp_sock *msk,
+static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	data->reinject =3D reinject;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] =3D NULL;
=20
 	return 0;
 }
@@ -106,6 +120,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -119,16 +135,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, false, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
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
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -139,9 +164,16 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
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

