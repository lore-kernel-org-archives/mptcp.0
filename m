Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9657A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzlDDGUE0JOpwEFpFlHCBykPzzmS/IbST1Q4bRoZxPs=;
	b=aTnQRECm2pnkSzOVT1dZz+xwqPLNM8pyD1nzWWN2hyQqQYHOgM6v9Nwh5uJFRrZRydfPgK
	bJ+fu2eAql/P1h8ZXLKrw/GgB+sWCMMn/1ZGvj/kl4C4PgkV+xY1KUxhy/OHQla15LG1kv
	2vpf9PHOjefDkTovZLy3NUMNR6Ju5XI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-adfHxNcyOye3efxkmOCAQg-1; Thu, 21 Apr 2022 08:22:54 +0200
X-MC-Unique: adfHxNcyOye3efxkmOCAQg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Td20qGTgn+G665aaPE7HdlOdX7i5Jahcu9wDK71gaIiCfJUvk/aHhZvG0Jt2VS5jPtFsdyTql83ZrRtZWGqyZ/vL3qQCnu7MwsSQX6hS4v4y/PoCa2Nm4yMlruV5KDgml62F72G2dMbKBgVKjD+1l8GpT0luZRhQyMXp7i1JQeYV51bcncatSNsWvpgqQc+/AT430LvVI6E/3yrydm51W4hwUWZt1p6TSmHLOlKACgCtdW1fsCzH2CeJylitzecHUQCcetPGtn0tRf559aZ0QBioI5IikkdIHy96IrxrDs4NnBaBBqfbvCgmKPUFBDfuC05hr8R/o5UiXE+rCH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROyS5ZjKGDuHV3eOc9hV4soT7uimS160HaWxWbf2mfQ=;
 b=dFUFj5MNwZLru2umLqHJgWEyAY5mS3yPVNsWpiFsp7QVEbMa2mA16d6N2b1gfmZlORLYNpMbNF7qNUr/QDrpBxEiJTaJ3GxBFt0KKnK6AIGIlrBijapQ/8exJj6w5uC2Q5rqowhbea7WayaDgJ9ePB+OeSxMbml61FMvWkKyMBUSSoiwe3+ub28uHSX7qdg0CZKq1SOtM5P6y0tGx/jovGIBfLipA4HA0jTQ8/AxZoVN02eZj2I0A0NJO8n5pHAUVmgR1zWPaAl2lKuNeRmHVVam8plRuaJcUYAgLpmWFcgIa1Yfu8TAZvpI9u4bS5KmVykpQ4+ALoJGlQnXsqC1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:22:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:22:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/9] mptcp: add get_subflow wrapper
Date: Thu, 21 Apr 2022 14:22:23 +0800
Message-ID: <58abf449ec1fccb3d6bad158e06982467dc18bb6.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 394818c8-eb04-440a-c9aa-08da235f5e47
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8100BD9543B8995687D3A2FBF8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QRBYe4dox4Dj7dSh2In6us4ZQEw2pkiDsFFTrVXmdwgsWXSepwCW+d60gwMW+7WADPRVHScESw7ixKLiSx/IenOigByEaQtxZV+5zuKNGQDmMqGnyR5HkWXQti2hxiGfATEsIKGfcE5yNiWJnyxO0mPWvP+9BucB0eQLaN5QaZ7QdzVbpJB/7SRSIxGi/lRe8XVVnCHzghzc6lPU4phYSvRxx1bR3cpzIQxiAwMziXc2xguxFrqtS9o2UTVDnCLJhj+2GEF2YkkgPEYZAxzZUAU6Dbe84e8Pasp7xLJjaKdEBo/Q/qtkddi5mrI7tdXDlkilAD9wWhB4IsMPiRkPrSiAhJgh5jZyeIvIsVyfpCNWCrmQtzUA9kxtEZzFbayWSkiU4DwSjXgciAv5JcOisJKremxvVIQLl4mRQZ0w+X/S1rSCTR7MTxXtb0CBJdChTbKOaCOtxLiN6/O4hH6d8fA4IpBu6X0NuOpTHXcz2gvcFX2GJIvTwqmoScnqFCjeuBkyjEY4pKMiriXSQip1wM9dqj425hbTEfhmfN1UzC8X3ny2kYwzlaXORI8OIcHE+e4/cn2AC8cWHxVoNJqX8AHmI8S490Bl7//I4hGZtGdxynvOrJ3zR5IvZAVng6rEHY9Z12+WCyzpeVqnRhTWTP2vr5xf8z002YZ8zH70jhE4+wxKeugAfD10tbmRWd++
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGd2j8OI8Fbb2RQMy0RDKERFUdCP4CigSTfTF89kDM9DRqnpsdtY6yoU8xv9?=
 =?us-ascii?Q?tENgysdcUBzUInn8aQJPatJ6CfzEOz39TsZYoKLpcYVukj8dOulCeOJaFGZZ?=
 =?us-ascii?Q?zB03DcJ4ej828ef/8ZhZ6JXd2ktkAMxDULVlZZbjhcNxXDwWkcJwmmoY5bwS?=
 =?us-ascii?Q?nfeG8/tw2BVwwYG3mjhzx0gYAD3vUd98csrOBIEj/j79LMFmON+7prZ8wfHB?=
 =?us-ascii?Q?Rlz4I++751FppoY+GovEuCTwgl8GkDwM/Jqg9hgI/yfTDKSu4zBYsOAZKcbZ?=
 =?us-ascii?Q?QwitSAM38mQdbG5BvlHbx52DmAvUVAN+c/ySabE70/qsPvvCBEEPzmja96XG?=
 =?us-ascii?Q?nh3vt9CQMTJhR2IpUQJsSX4H5RmPr3//IwrsoeEI7o9QzrZ0cWHKshEblA4k?=
 =?us-ascii?Q?Ie9Mav3jtvyikFofFq5lgD+1iJzRLwPTnMklJ/9OMYfA0iw7qsn8/IZs68PC?=
 =?us-ascii?Q?9nV80x06YftFsHxRsSu2zmcqfBNhVpcoH8eQhurgiJMkRYpYnPFt4fKv2nj6?=
 =?us-ascii?Q?/35UASQBNfJ5SdwTS5Y8LWwcd/Tulq1ksl+b2DvakJ7TuHHn9MG3zwLge7MJ?=
 =?us-ascii?Q?R1EV1Fo9PJa5cTZydl2bhn2z/Zx3LqXuA9fxCimf6fDtllh1BOlFXtbHUETW?=
 =?us-ascii?Q?1tnoxbCXq/e/fpLU+nMfGm9/WzEDRqjW+yBhXdwdg8e1z3uYjlMYldBYDEFE?=
 =?us-ascii?Q?X14Dq8BkKB1UkCng79fJzpbbBNGxVuDiGzWmD6o1r96xlx+NYZLlVJKJlX4N?=
 =?us-ascii?Q?ScH872siN7iujAivqx61cjDdWdSYsUW6nN4p+gzbyBLxg3TJ7PsCYZtxWz1c?=
 =?us-ascii?Q?YBRlrVCkkYQHOES2JM21yc9vFKVgt7n8N9PsIZm3Owh6/SSTpUTAgnHnm86Y?=
 =?us-ascii?Q?w/iU34Czzb+qu3TGMWQktRmi2/dAemN2yWu5616hw4lH9IP0Qj7D6L79R+wQ?=
 =?us-ascii?Q?zo7eHeh8Up6CDbVY+GOjLmHXba9N0SDPae/D5gMjvLhaBT7jMu9Pbnbl8EXV?=
 =?us-ascii?Q?ffBqPMN+HSnucmb1/b2+omNJifq+4804ttzPZ9ulN2BZkVuX1R8ozj8cxskE?=
 =?us-ascii?Q?25YIaUSiUKlOzNGfcY639TUMDHI1j6oqmkb1omJfIebnCkqlOJGpX4PddJL/?=
 =?us-ascii?Q?pXa4yNvtRpY0YtaJA7XafWm32ygb4VQZ8Fo14IdVZXXtrZnwAoGeCq+Hiyen?=
 =?us-ascii?Q?DeCpBszowsCxuBjxwgj3DQgBnPpbj86/vicIjIxVmO7aUTq+zAaZsHTCKoxq?=
 =?us-ascii?Q?83V6cS3mXqFumxLfiFTDEciCjj9OVDXDuqFbx91Kh32w/nLVcxFMOk8ARNt6?=
 =?us-ascii?Q?Lck1/C6diwa0rr3QWUmgBFUaFLF4co8EWocrKWX5OdBZIO7hX4Jl7Zv4MKJC?=
 =?us-ascii?Q?TcIMJSZAD0OwE+OtvEeW+9IiHoivzRpajuo9Lj1QDUfGKzfga6mD5RMCc55j?=
 =?us-ascii?Q?iVb4VVRxUEqLVvnEwKr40fJgR0kdIyiGfi0HUNdFttwYbUJlC3YdntSkqiq7?=
 =?us-ascii?Q?hUD9xAQnav74b6unsk7/bqA6dRHCxQrQM3NdpbELs4ppxtf6/tjjYfzW04tn?=
 =?us-ascii?Q?10YQgObEUC5U2gH/QH8LN4YfHW89nxo1Mip4fy9l4G7GxkghJr/pllZRgB0o?=
 =?us-ascii?Q?L70Sb212jdubjpvmJ+xBLT6pJP0K5bK3UH6dWXYi1LOY9ofhR4jNkIum+yFT?=
 =?us-ascii?Q?lK7cmX6g5QEpHovRS+e8S4544VbO5vtzFfrFrd67R29LNc1wqNE4EO4h53XU?=
 =?us-ascii?Q?0RX/Ph93z9o150iJK0l061Cx9ExpzjI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394818c8-eb04-440a-c9aa-08da235f5e47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:22:53.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBCMixKpWPxtvFEPmTq0j5BDePRW8+hkArx2NWVAU/i20KnSQP4EsKoe81tOygf8x8d4k3CfyEFj6yIILkZhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 ++++-----
 net/mptcp/protocol.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a5189b2d9b8..00f65eb71104 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1507,7 +1507,6 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wmem=
 +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd =3D ssk;
 	msk->snd_burst =3D burst;
 	return ssk;
 }
@@ -1567,7 +1566,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk, false);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false)=
;
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2481,7 +2480,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_subflow(msk, true);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3146,7 +3145,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk), false);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 427a42e04ae8..f31bc3271bcc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,6 +632,17 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk,=
 bool reinject)
+{
+	struct sock *ssk =3D msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_su=
bflow,
+							     mptcp_get_subflow_default,
+							     msk, reinject) :
+					mptcp_get_subflow_default(msk, reinject);
+
+	msk->last_snd =3D ssk;
+	return ssk;
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

