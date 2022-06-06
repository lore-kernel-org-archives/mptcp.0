Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFC28E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43Xc4zAAVm2/IrmRTfHq1KjtAt6cuVdaLuPi08o3GQk=;
	b=fiG9yEAxejr4ey0/MvfphDWXi/HsG2Hwj9EO4rz7qzhqYYMnNBCbXs9NwFmCdtdvqc+zyJ
	r8OEQq8pJSUsRhhhU9BHgIMZm/b4BdwPE12vLyem2X8hzkH2XZq3F2VsDoJPeDQ0sizzKB
	IlLHvhffvl4fU5cw7bz0TNDwxihpX9M=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-DPMB7QG_OYqS3bhYTdVGcg-1; Mon, 06 Jun 2022 16:42:11 +0200
X-MC-Unique: DPMB7QG_OYqS3bhYTdVGcg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WitOxU4dw+2LT91JF3bROTkRwos1q4N0r9WUsI7QWDJUS7U+13s72p/Kq5J9oyqYEAmMqup/7sEq2zPzlCDawapzRC/kcEOQ7XH2CH2NI2Lg9fddYLXGr8hVJ0KtdK6SVzMdGfYVXnJR8D4DKwNBibZ2jG12ew/6/uDcgKub0/pAfThASDH/kw27NzdT4QhIjzXQRqaW+AClr+DeEikCI+gtdcIPFbihNIpaT5nK4dbRzxXFsVIp2XoL11qVCdpCJyPhhMuQcykLyFSzO/b+/3YceUKhLKAICnesq/oodFjc2LVRtW8bf4shGBkf6lE5FKefaU0tQ2WozaWqKgExZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nPHL/BQKU/to20kzs5KBBhBIgjNu3B8oHLkt8jhXhc=;
 b=T2T8BADg4yniP8hPHiHo+Pl1O1Nz9HlspM6TBbhUafN7TNAbajXAMZ6uX3kdfiJdk5Mqa0MB6LfBfaakX5JoHztIFSCrONzIBotNAV7OQt1or3gEHmRzXkq7aS/CD6rDwamRoY1+BxytZY/Sdzsqyp7z10lTrOcZkXwA4dSA2RVXgWVGTAitT0WPKXGjXsXg/89FR5sYPX848UtkuieaYsI9jKcgxeMYrLcx6//gCD1fPmTJlfu0OIZEeUYV8MR8SVk1F5Ek4RSLn4r/xclktO/J9eXRi6j29eF+pv+tAggyQqkBvvJ3Rihk7ILG3K8q3Ve8hfrtGKBEEgclkdEfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3364.eurprd04.prod.outlook.com (2603:10a6:208:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:42:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:42:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/7] mptcp: redundant subflows retrans support
Date: Mon,  6 Jun 2022 22:41:20 +0800
Message-ID: <625ee43a83e329cab83eac38cf3c96bc7de330fa.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37d4213-d04e-4392-8504-08da47cabc84
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3364:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB336467A9F8173318B671CFA1F8A29@AM0PR0402MB3364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yp36ZxE6EStIKz+24AeLdtMnjpluUwCE/QLrtRv4Lh4X3JBwe/h0XuiMvUogCaRacbf7hOsmwKiVPVO8Fl7a8ciyIxEhL3D1m9h1B4V8uAz1EIcl0z5gX+LGTdqxfavHGJshr3v4aJiBFt6/npRl2VCAoIiT88IKr1zo55UzYupuLMS3wxlnXiE2QOUvcgDzHKNZ3AJsTrNFW8ahItH6CistPhjWpFK+DIApL6I0mLck+nYGQ3BKyo3JLror3UVFmyy+UWjnLR6WbGwm8SjWxohrgMNRl1YsDhUHpzMU4q6THRxMvCJyI1fa2A+dxRFKfA7HelKrg9vNn6/GGlXffQZbxV3fWrEdAwayMGMWWZw+oclRqBGqLGa53e4vOZlxdbp9C5Wr0PYwbxtv8SMr4h9WcNDJpgpdmHQYd7xdPBcvVjms/PyqBs4LVw+XuaK17H/4SXAdPOE9KxtgQWF21qdRyGDlr6Ojxk+6dLbgH5diMApfSef5le6AEBM28IEmRtMQvzjvIKfdW82ps9awD9s4w1DOYgdNGmGM+6pu/Irjrwu+awNYuWac+SXyOHXEIcjWiQnqNJnq0mr0Ibo30DO4JL5nyyvY7wSW2pmdxhpqLWxiBFBeh72+3BsWFRSgdPzmaYZR+cu0Vf89gU0312qZu3h+P+YWbcD44GgC9MJsmLd5w5KU3lhGdDIXP5LFE5VTAiIfwBh+BU6udvzcwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(36756003)(8936002)(66476007)(38100700002)(107886003)(26005)(316002)(66946007)(5660300002)(6512007)(4326008)(66556008)(8676002)(83380400001)(44832011)(6506007)(6666004)(2616005)(508600001)(6486002)(186003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/lI0aiMa+djBccMDFJhAV66i943iQZGlD7z5+u1cB/ZLwF7Wv2PL3/rFfj4g?=
 =?us-ascii?Q?hkBFo5Dgz++bsVs2eIrZj/rPCmloCDidBMTQ18j7Arl9BRPwoMpPN1XuusUk?=
 =?us-ascii?Q?yLR57OxMRIKbXuJs4rU4yFp2YuC2QDQL+GwyNMNiQ3xSfspMfKbBXD+dXViu?=
 =?us-ascii?Q?oGeghFb9UMLpowODMgYWFGWAvD3hRAuP0+FkRt51wRV7sx0Ta0e7q/VwPrwC?=
 =?us-ascii?Q?QUcmi5PjG1lvWwgzJOWfcjQ7ufV9ZdbSFhylAICaMLZDk1FxpECCr8ZZQUQz?=
 =?us-ascii?Q?rkiWDMjXEW+22kaoleOpoNb9NOmwjURcD+gzFtdKzkIl3Uk4m8PiHqqXXflU?=
 =?us-ascii?Q?Sv7fxY7uukN/v1MUHToS0rmZZhbMLyIMfyRN2DZWW9lcHMSceqraZlwJdl05?=
 =?us-ascii?Q?Y2LX24ez+q8YmCutzlLjR6tv24fQ12fBegXblQGAI98obfzoAvTKejLLqUcw?=
 =?us-ascii?Q?61rNp706SC8tmOyGyGRxkNaN3I8vL08QAID0atMmPJw2MAiMjLRwcph74t+F?=
 =?us-ascii?Q?JLS8EPnMokPo1JpiLcGjPNCnaJR7Wc6KcwKCfjR4elG9GWIYmn2rYcUQMNh0?=
 =?us-ascii?Q?uN+XhDnMC3Bqf6RkOTxgMa8SpsyRkwsAsV3kfOPNzCmbFExqSHO1qxH9Qvdx?=
 =?us-ascii?Q?THNynS41x/PEPraOKOpZ7TQWMKcOjVuoUTwDNxGjPjHf1Gb6UHEOdUfSUsO+?=
 =?us-ascii?Q?1yTjdNxSiYJGUc0HXvflgzFFgI999N3XHJNyYhKK9dI2XdREiybhH/YcE42F?=
 =?us-ascii?Q?43KJ0jW4wCi/dE/2sLfRqic0t1iHVhDfp63nA/bkxZag8Q6FbdjYygDgWDfN?=
 =?us-ascii?Q?ahabUJK64/XRKjniSmg6Q93+FRfmf3s12CTAKQgddnbmBt/2IHlYahBQ27g0?=
 =?us-ascii?Q?5tvtFZ1Ra4owamThpcIe2DlBqAh/G+0V+w0pp9+LZGLvtG9crrl7afxV3kMN?=
 =?us-ascii?Q?BFxzsLWCtiuccTeatBBFEm51WWjMryLTL3SWTNuledP5TRespRvplxB5mZmL?=
 =?us-ascii?Q?fWLBgVKoD9kvXCj74qbcwO8wGQ6zyVdrAZDir/TiUCJ3QNNV9nwPXtKuYCiD?=
 =?us-ascii?Q?vbFumpbN6/+VbqK35gUAld7DqcOqLXoOpkDgEwgkn2iMsBeuDIV3fAjuAcPx?=
 =?us-ascii?Q?fQiU054v73DfcmrcOuuoqcDdhBHL70tSjGoxT7/MXN0Uw3f1WwVBCwbSRTib?=
 =?us-ascii?Q?v0zDzxteyDPZH1+qzouoXhURpkvtaMu2pAOfnzhJWmjt5ZkIJWbNrzZ5Ggh4?=
 =?us-ascii?Q?ixYqFZF82wEuOdmUfiyMRRAUyOmKW/Wq0PUS/42tYck/E5sLVN+X7iyR3awV?=
 =?us-ascii?Q?W/0gGivV9VxhG4z1ooeW4BIWheB6TeojZO2OB4WqpriBh0Ilog9KWUGUrhtO?=
 =?us-ascii?Q?dTiZx8sgUckQOSgg5JdI8FV0muFNWifnl2M5llDHD+3f5+JXUQ4chlZuZGuF?=
 =?us-ascii?Q?wmk3mimzueSlMj5CFNFYUINHer1yO2XeF3HpmY8SpHyR/Ov8Lwyqx0Vby6M1?=
 =?us-ascii?Q?yAMP5jrBuD//WisIR7jHT5z+CPYouNUyyBBldvDzSZ1rhTQ6kHnxq+RYJ+jH?=
 =?us-ascii?Q?JV0YnvY6h12NNaf0w05L+kuxkb6+gLPNebXTrRkAJKsxwhrFbfjOu/G6SICp?=
 =?us-ascii?Q?scNJFQWVAwMaWsacnUgouH+q8t9apnhnjX+debRHq95aEUDcA4GnIW5ZrRyd?=
 =?us-ascii?Q?sCX3ucbxxpN6is2CJmwmyy1iB/C0iIstZcOubxUW0VsdSrHr5XlKdeXvrrW0?=
 =?us-ascii?Q?3Xm29wHZWthBMOL3OuY3TYdiF6Z9kaA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37d4213-d04e-4392-8504-08da47cabc84
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:42:10.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTq56yIawXBQjzdeGdpFFLMSkpQ/aZTJCp5OPThQb2VKfoiZaZA910TT9s9JBhh3PXnAy4R7Wd2FOH1F6TOpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3364

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b583454cfc91..f39318f5a21e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2445,16 +2445,17 @@ static void mptcp_check_fastclose(struct mptcp_sock=
 *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int ret;
+	int err;
=20
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	err =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2473,32 +2474,48 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
=20
-	if (!ssk)
+	if (err)
 		goto reset_timer;
=20
-	lock_sock(ssk);
-
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent =3D 0;
 	info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->al=
ready_sent;
 	while (info.sent < info.limit) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <=3D 0)
-			break;
+		int ret =3D 0, max =3D 0;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				ssk =3D mptcp_subflow_tcp_sock(subflow);
+				if (!ssk)
+					goto reset_timer;
+
+				lock_sock(ssk);
=20
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					break;
+
+				if (ret > max)
+					max =3D ret;
+
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+
+				release_sock(ssk);
+
+				msk->last_snd =3D ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
-		info.sent +=3D ret;
+		copied +=3D max;
+		info.sent +=3D max;
 	}
 	if (copied) {
 		dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
=20
-	release_sock(ssk);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
=20
--=20
2.34.1

