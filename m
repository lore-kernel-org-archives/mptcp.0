Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EC28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3CmzXWoSV+s422OOrtUvM0WW4G8zTwCdTJGiM+Tv98=;
	b=X/lzu+MfeVw1KY/6/ST9ov4O5NCitX/8dqzdLh/bHRTc+AqRJTB7blHstSwyiHfEq9BSs0
	/nictSLIMSm23t3kyYXx3BBydKtbuYrHBeN/LCN1rjhIiWliVHayNrTL4ersVQEUi8qAlE
	cSRpBClEAHePpmMS5mt5/H4aRIus8xs=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-_BFTYsm0M2WIlqTjwebMig-1; Wed, 11 May 2022 14:17:52 +0200
X-MC-Unique: _BFTYsm0M2WIlqTjwebMig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krNqnQbf+n2x5VN/xA13MuKfgtJ7D+QW71NqquJnwcO5K7H9QNJaecouqinH1OXwW29tbwM/VJxKKU4TjvxPX8bA7FKS68ncgcOnPWpx6X1z5xjiTjcXXbVaA/TMn3P7pWsblVX30BN2D7mXXvbTvPazjU2DYd1HK79FdK+/UN8aujDBQ/a7w4Y0oOQKMCV/NeKh5xfbZMsJoFOouvIihoZS71F6VV5SHm4f3JDNm98+VDsFxs0GIycVL2AoWerRB1qeKtxM8jPSnXSBrALCRM2j/ofBAOvoe0UptZtwzrcORnJZeamLYuICJ3/jtrhY1uKQfPCGeitVC3NWCoRdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAAFsTW/SR2wIEcikYy9sDWlIiWAA/zr4GqSTsjKHcs=;
 b=YgTGeqyACBxx3EWI4AAxyrQYp5beZO6Be5SCg9bJQRvUv4xRFkX1QdsX1+1a/aL383oUAgJNQkXfJPy+obSlbW9LUclsZSghw2q2UhesF5ey8hvOxv8C7cdXqjoicyedwsLBNDZzbbub7n64elVvsygKSUpPUkUcEACHDBm2BJf00W0jsx1t/Ffi4Et9O/m+5KcpXLHi/4tw4n/fQrT7rSqdNj10Fdm/JWoJr7KqywaqjvnML0YxFoWAQi4y8bNFrc4HRZK1gZRfg0I+03OauAtozUVC+2yJx9/iDyOWsLQtW0TNjmICWAGjUNgoSGqUPnPmyvau9XQgYTeQm3o0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB6131.eurprd04.prod.outlook.com (2603:10a6:208:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:17:51 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:17:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Wed, 11 May 2022 20:17:41 +0800
Message-ID: <6e5584131d6f5dc59a6162260dd8f5295197acaf.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e2c2fa-bfb4-4786-c4d5-08da334844b0
X-MS-TrafficTypeDiagnostic: AM0PR04MB6131:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6131F7D4A727C68C43B607AFF8C89@AM0PR04MB6131.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dsns9YsnvCdoM60xugKDdDckfXG5m5V3ek2LHXjAp+bVlWUbmd9U9vZsUKZMqXZ8UHiZn7wMSR2v9sNe6TwuMlY9g4RKPWZaPcvOYUHBfWM2VhFptljWPv115EXGhiSlFWZCOkUj1NmUBf2el36vP2WDfWY1HNizTtNGiUjTfl6GK0TYfTFBRgc8qkes1l0GYHurI9iXZ3a/f1iaYaAwOcSY5dX+7D+n1CCSRC/SPYFmBVT9Ud5PT7XNG79JTZMRYGeAvrw0QpzRovTF4RINW9vbzVeNyWFANM2EtEUc+Nh5m6xUQ0vn3LMy7bGcEuWS01MaRk/0/iGE51HW+/0yrbsfyRa24Ep8O4eQ0HqQmaQ9BMg9Ii7C9yGUoF6nsOfkdnHHMMyF2/neKGzRM6SNr5QvR+VJYVBa77MS886dWgp9syD3xZtpdeCR9gnuONGvTSxITCJf4XtlXLmJZwlW08EMv5nDdZz/k+06NmM5Yz1IDxo7vJV1IiFQo8344GrzFd04kYWkFeMrTFXCemMR6Ggm/9sFQtfl4wcLZ7Sw+txvcMvyu1E9Ns16oeaT3jMLYnppZAV1XM8n/nY8/IXqRveI59ZrRxEOUxgqodG+5SZCEzGwnq27qPNtkxkSFpiawx0uICJRuS6XhmSrWgOR+Ke98wdOCMNrJp+D5E8GhXjuzcrFkzkW8Q8oME8zUU8+5tU0szb5YtcodMwxenazsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6666004)(6486002)(38100700002)(107886003)(26005)(316002)(2906002)(6506007)(6512007)(6916009)(508600001)(186003)(83380400001)(36756003)(5660300002)(44832011)(8936002)(4326008)(66556008)(66476007)(86362001)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIoxm/swTrzbVMZ7+fp0lXmoS5XihF8TwUcNXScqdn9N/iNESthoJX3lplpW?=
 =?us-ascii?Q?IV5EG7GTPMb+tuEC7fsKOihNcNAYn2v8T0Uj3xvZUf6HJdj6aIgRScy0lKTo?=
 =?us-ascii?Q?R9xdkIFSvEmApnBXeZ7MGO4uCsAZBsD8euBMws5ITK9AyQx4S6krRZipRsBE?=
 =?us-ascii?Q?bn/1W6XSHf+n+z92tdiRDHrWshrfs4/8OhkTxC3aTYJwSS0+AfGQQwfCqHja?=
 =?us-ascii?Q?94jgbeHFjSPsXlKlBbFbx5siab70+o5kcrJSqEDxrJtwWqqHlldRYLbl1hTT?=
 =?us-ascii?Q?oFPsBNDW264tyfpy/LCb+exmeUEji6eGVSBY2yzriB5U6jgmUYaZ27j4FGR8?=
 =?us-ascii?Q?UFecen1M9VrCELgrzq0aa1frjxXnxHk+0WbixAKU9mDe0SnaTwzwDdoZhj2I?=
 =?us-ascii?Q?tB5X9P6G9xbUXLR4N38uMYdvWddEx08d6uR+Zy6Baqgnx5CK0zqBE3uqZ9SW?=
 =?us-ascii?Q?xKWwL6w0efNxHGz/7aSVhJCU/iWb+Gyl8dNZ7xatbUCe7hLXQePQPFbs1ZRW?=
 =?us-ascii?Q?qDIH4RMrqdmEixckOVPFVNyyDRuxYS/9WeU9MiF3Gud20Bl3AWPgkicmk3vn?=
 =?us-ascii?Q?yZAaDD11RTOYMMDfiv8cP9Dp2gMZpYNg54ctrYt0Ejwu1280naj/CA5PNDtB?=
 =?us-ascii?Q?jm8fH/5axWojgDOH+9zyqFYK+gG121I2WIjzUjOU6btqbHViF6AMD0g/pSJN?=
 =?us-ascii?Q?uhENYGTTw5K1MEQpG4DN1Jy1sBC6/q+Z2MGLOuHdq4bfNKdac1l4hHNgKK6e?=
 =?us-ascii?Q?xt8arKbHzXpf1pCYHKxkLk30Sp6wIEVwkP8cRffzHabGw0EU5XBgoFRXy+j3?=
 =?us-ascii?Q?gmDyf5eHEbq4bPeUaygqL4adKeyO3BwtdVgrCbunvNVBV/dBVKRH4nzxvkb5?=
 =?us-ascii?Q?oZ7WtN1wcn5v4gVKWhxUJY65EbprWFB6LgURQD1tXmnS1gFvmmBO5VLUTvbf?=
 =?us-ascii?Q?NyWZ/Jb7LqCEmVdo3WgPG299nQr4bpvrggvQtBcK5aO3Dn+tOEV49FQQHJOz?=
 =?us-ascii?Q?KmJGKFpUu+6+SfiHIEccbfDwNboqjxLSZyROdVWhSdPlT8yiwePxs4zmhuoR?=
 =?us-ascii?Q?OhqirF8HVgf+0UqDcMHPwGaWfl2OHuXkgDaFJIUXS04szMuSqTt7OieCxdK6?=
 =?us-ascii?Q?Q8rtg7pRkcew0PBSJL6Fd45fwIM7UlsKY60RwLntDuVTTUGY2SKjfjeWAUWM?=
 =?us-ascii?Q?2cbA1q1We3YOqk72ao8D0o+zy+/jQ/bs6OGw7lhRD7k1GZ6eMO4KXEOCR3ay?=
 =?us-ascii?Q?IktGE9wRUW6pe73JbEwTNnFomaAVFYd4Gvfo8J8V5E2Z+3CBC6Y18D0E6vP2?=
 =?us-ascii?Q?2H/gSEnvJJFc4ntiGHlhOJbwQub2g0W0qCvjCtcjPxEnCoNFAAbaCS1zdRRT?=
 =?us-ascii?Q?eMQWuzghD5jgkejWQBzGEGw2OJMSyrYOWJC/C9yIQ6OFSDRUpyoWRC3f7E0h?=
 =?us-ascii?Q?9IbPeEHaC5S5rcTD8dDz087/Jx6EJN+9BB7Dk9o8N8iDdiskkbiLl8rB/6fz?=
 =?us-ascii?Q?sdnoTZCPUVi4498rgXGY0ePwiT3DR8FwmMuP6uXtVvYgscwXM4Qdfi0CAC0j?=
 =?us-ascii?Q?wJf6pxUz0dbJSQ5laBnuNKwyvU5sUkJ9rl4RPFqd11pQMqeYSdK0ty1wYLbk?=
 =?us-ascii?Q?YdH+Re4BPmZPJ9tB6WqYY6rZbtroo4OCmzrQrHlQZ+Oehu9V+FECVT6cR7nY?=
 =?us-ascii?Q?4A44LOxi73Nx23cC4d3WI9YLBSUr4eAfTacuykYd8E89DDdtbslG6QJFeeH5?=
 =?us-ascii?Q?Vgu+N8bBry/eaonytXqiPgSbcc1kQt0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e2c2fa-bfb4-4786-c4d5-08da334844b0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:17:51.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veRTi/wXs2uGTis9PqMI7fhDO/9CIZRge2KmGGWrryNV4R9ELKgrFc20OAYhqIE3AHzaJMXLYGBC2+DJp8mUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6131

Add call_again parameter for mptcp_sched_get_send() and
mptcp_sched_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    | 10 ++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea3c93322592..74dc832a9d9d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1558,6 +1558,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 	};
 	struct mptcp_data_frag *dfrag;
 	int len, copied =3D 0;
+	bool call_again;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
@@ -1567,7 +1568,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_sched_get_send(msk);
+			ssk =3D mptcp_sched_get_send(msk, &call_again);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1618,6 +1619,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 		.data_lock_held =3D true,
 	};
 	struct mptcp_data_frag *dfrag;
+	bool call_again =3D false;
 	struct sock *xmit_ssk;
 	int len, copied =3D 0;
 	bool first =3D true;
@@ -1634,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &call_aga=
in);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2461,12 +2463,13 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	bool call_again;
 	int ret;
=20
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_sched_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk, &call_again);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3111,11 +3114,13 @@ void __mptcp_data_acked(struct sock *sk)
=20
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	bool call_again;
+
 	if (!mptcp_send_head(sk))
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk), &call_again=
);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 59a23838782f..2fe0021a678e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -631,8 +631,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again=
);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_ag=
ain);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f86b97292044..0d5fc96a2ce0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,12 +112,14 @@ static int mptcp_sched_data_init(struct mptcp_sock *m=
sk,
 	return 0;
 }
=20
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again=
)
 {
 	struct mptcp_sched_data data;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
+	*call_again =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
@@ -132,15 +134,18 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	msk->sched->get_subflow(msk, false, &data);
=20
 	msk->last_snd =3D data.sock;
+	*call_again =3D data.call_again;
 	return data.sock;
 }
=20
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_ag=
ain)
 {
 	struct mptcp_sched_data data;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
+	*call_again =3D 0;
+
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
 		return NULL;
@@ -152,5 +157,6 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock =
*msk)
 	msk->sched->get_subflow(msk, true, &data);
=20
 	msk->last_snd =3D data.sock;
+	*call_again =3D data.call_again;
 	return data.sock;
 }
--=20
2.34.1

