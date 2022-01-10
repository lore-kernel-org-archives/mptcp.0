Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1A2C9D
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2ee6Gq1mVtm45VNgMmbaWyfF+Rcs39fvVaBoAEquT0=;
	b=N4T92oOVWCioZmV5mCM/86GQZ0RzfnR4Fe63c5lHI2J98a7IWFEBl9+bJJ6wV+mGSLgrYy
	unITjTPxIeJeF/GBpAFhRBgY/7sF4vnauKt9ELxa0TuTprr1Ni5fvzLj7R/IMMWiuCOnKe
	Dl4faINzoXUocYeq+PzA06zrJ097liQ=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-pkHviw2cOFe9IxaTNIgZFg-1; Mon, 10 Jan 2022 10:08:44 +0100
X-MC-Unique: pkHviw2cOFe9IxaTNIgZFg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX6F0XUOJa3ZF2Bd3DD5nyBu4u/WqHXs8rpcF9eKiRyr/tX8kE0alSlPoAMe8wJNxABmwxjWlamaGAEDvYV1pAXlfYHN5FSADIoxAk4pAnNbk5KJvhU11LxX33qtwf8AyFATVZiIg2fQ4s7vgMv0WAb7SF2n/UlLVJBLVNRkO5GQ1qOj8Z0pOM+kJ5aELmsxh2av/gpXsKXp2kFLeDsn8aaQfbtMiKG0qCaJHxPA23TodXw+0TDn6wJHzDc9Nnu13T+0cAA5oluwQtb6UNbHJEUSc4kE8x1cvwfIfR3BbpJoMeJavChPdrQG7jYHsLOR5sMO0sM9/bhFO7VEuc9fJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWe3GSHacyDHJ2B76wnAKgLSo0otI/Ew5NmTm/9FXy0=;
 b=lZ9PJTpf346SSFlsiXHZHquof+Bm7ig/UvtIIMTBoawke3v+St1fwcmB3gmGCBK2DgQPwm8sHAz7Tp+fqfi7XMALqg2nagMNk3BhnVrqsyAB/wpqTICplmz21V9I5tNvDCZr6Rv1VqDhQlHA4bhP+ourOsh2CDPTCx24tt8Gskt0asPj1bgqCJO4KWpetAMwXBlDrU+05s1Z6mgdPJucMH1mUAuRobpq+/fZP9hyA5fBLwZaU1+tSzWrgqbOpEL6toNtu5xzJlmuTETU4mGpZjmb8/QHw2u8CywvEdm+gXCFhygAz0QRO4ho3bcegzhy7Ish/2ABJe7zZMK28lcPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3244.eurprd04.prod.outlook.com (2603:10a6:7:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:08:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:08:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 2/5] mptcp: reduce branching when writing MP_FAIL option
Date: Mon, 10 Jan 2022 17:08:19 +0800
Message-ID: <87967253a372abdc01610a2c8a8298b8567752d4.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afaa5785-078a-4acf-8ed9-08d9d418cd50
X-MS-TrafficTypeDiagnostic: HE1PR04MB3244:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB32441D1D030DDE04A847D299F8509@HE1PR04MB3244.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eWLkS5copO2Ck0I7GoL9Hsa3EfWijb1lTi0K0q5K34qfztAPlG3xPT/KewdclyWZdaUw5hUKAF3x9MMC3vFZTAqlXqvCRffqMMGQ/1ltw1ecv49fbV+3JKlQ0SwIjX3q0/Xx/OG/yQq//GljNbDQnVJVbU0yUCVIL2AKGmvTHX5/mpPYn8p2WdJHCbOJhTH5yBpS7diLNLg2HVTyWwgqI4YsH+LDqF5h4HtnKFYEDvKkcei6Oy1f+68FaqayH25raIdglKjYy7rNDvvuWg5Jl69kiYTav7g1sfajPnOkj+80QppUr85Gk9Vql6QFU6BHvAKe1WQhb4r0kyZMSrhrBV0My1BeH63zKCzYRLRLPShNiIVdx5ZrmaLpUKkIP5XR9lELBexgTnUUd7VcYIBSjPD8KttRmysJUEt4ANgWq+MD2JsdnQOywXcC0Zwck8cIrjYm/o1MgTm2u43tlXV3oFuGaNqieb4zJmyniFOnjxQ4k9sRGzFrrVzAcrK0tfZATVbn6EWeXGTfDjsgtDWfBzaREKtMm3Us6zQ8Iwsac99iYfXf6qLN4oOjqdaEewtzru7kO6RNUxR7ePgW/eyIS4vRq2CfzIOz70ZEcFgrWX7UWrai1RLJN7IXEjv2+B00D8C+kUSe6tGTbX6Dds4Guw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66556008)(6666004)(316002)(6916009)(508600001)(83380400001)(2906002)(26005)(54906003)(186003)(55236004)(38100700002)(6512007)(5660300002)(2616005)(66476007)(44832011)(4326008)(107886003)(66946007)(6506007)(8936002)(86362001)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASjAv9RmU57hx9TYT9nqE2apw12SDZXNsITUrR9vAv+saKr6gOOBxRT0BQdp?=
 =?us-ascii?Q?he4UyDQPMSlMkbUJ6+XogIQ8jUmG/kbBs8yFF0hXWplYbXtN1yVgIcphbEn/?=
 =?us-ascii?Q?NKPnXld3vdzmumxIbvqgV0zY+lVCAVCuSO0ZsDaePLWtSgnmoirLe5e+490v?=
 =?us-ascii?Q?KuYWfWOd+E2wEkjoonXldNtj7jMgfriIysSwErYTaNjXB2Id/LfmkXB8YLvj?=
 =?us-ascii?Q?XamqACehgq2vhEtRUysOmFkMKJYyVJzLOd6cDR18smQsaJ0/B7gq39h0hI3O?=
 =?us-ascii?Q?eWteleRPggRsjZjlBSpQ6r2ILKJKL701Qpx4kE0alFR0B9EOdT1MPEdOL4r/?=
 =?us-ascii?Q?sZLWguK3dtH35yIza73yZAHVu3cPJ4BJSECGFEDg+m25YObzVh6Bgjlt8Zxb?=
 =?us-ascii?Q?XJMrIP9zW3Kb0yg2GmCZ6LoKvyzIwGcWfhGJbJWBexmtrUEywSYFFA/6LDT3?=
 =?us-ascii?Q?4tM4QesbIIlneq67mp5dToK3FzfN1z6eeYB3b+GHR29KT/kgZmK01xkKcAJR?=
 =?us-ascii?Q?1Zacqkl0+Pb0qwgMVbvUdyzMOV0e8nb93O9yrJ20OSt28PhAJnblOt+gpUKa?=
 =?us-ascii?Q?p/SM5mVI0lw1SuEdOhK+7NYjfbKSIGyBsQrrweP26QlTXYQ4kk+Ly4oLiZBt?=
 =?us-ascii?Q?qHpjSUyWZZ/4VaYhNgCZotiW7xK4t5ANjaQ+nFRRdx9jeLAAfhHNjgptVICe?=
 =?us-ascii?Q?J72XwBmW52EYPFNzRyv1x909hMCQaFadJ9RzQaQRz1FdVIUjMXHy9qRli5sL?=
 =?us-ascii?Q?BwwQQMwi8pLe5cZYUCjYi05BLyYQsZQnU39PeA5JBefASJiVelrgVZaxMLXw?=
 =?us-ascii?Q?xIIXP5Xoov5Hpnkalk57mdqshcMpjdpwqy44WHpVfRWcSquz22Hxqt9zSMIj?=
 =?us-ascii?Q?IWBZLCuyl8ge4v/NPzgWwfivpVv/M1MCJz0JHPfuoe8yZnVFCj4NtAhqohVE?=
 =?us-ascii?Q?o9YP7TMestesOl6rt6wuuvJeARrEzw9zT2cLiiKBf5H2WgyW9vLxc7PMkVwv?=
 =?us-ascii?Q?uMrHbk8GXRp9WdyohHueRH4uVym9oP4ElClp7wagDiCrEmt6TE5bnT4HtmCP?=
 =?us-ascii?Q?KFBP6jcHeuDb8WLxgr4fZYX91dqVwk0B5Z8VxWfmK9p/eQ0xgLxXCMObzukf?=
 =?us-ascii?Q?JJxmPkQdYQfVecW9VMICEhtbatjr7tgDbDstLWaSs8kiD59+cdoazMOGQ3Ed?=
 =?us-ascii?Q?LAawjWdF5eNQ3WtY0yICdxlAU4vQ3m6eXLlM8HoS9AKQyg/GQ4sM+S/GdynR?=
 =?us-ascii?Q?glrz+p430JzVMiIQiCFNwytaZYqi2XsEPxJilb0dbaxbAJJp+qFWfi0K6RwH?=
 =?us-ascii?Q?Jf8gVJaY3CI74c477nagTJVlK68US2hlApE+HdL95OFEzHcLpDtAtoFH3dP0?=
 =?us-ascii?Q?0hgxhJiPZfjGQNCaaJPg/4rtdJqwCc18lhM5Yte2X15MUZkutIIKSTjVOmeO?=
 =?us-ascii?Q?pofUieoK2T4F2/FHWMS1L6mgitN2PdrV618vP7/iRZycTprykr8KHY8pqqMr?=
 =?us-ascii?Q?6thcNHI1Rj66VPaZcA7JA/VEgt+FXR28+zGxLgnN18gJ81oCq+tijgKEN9YY?=
 =?us-ascii?Q?fz6LfQvE5D14cqLbVwdxsr8WFVFo8TjbRVmCr8Aa5sqidph9tA5Ym13F0aLZ?=
 =?us-ascii?Q?hx+8XzIaVfja4REx0oDs7Zs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa5785-078a-4acf-8ed9-08d9d418cd50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:08:43.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGXWrB7LE78a/fGX7hcS3QvpGDPmhtlmbJwbS2QbjH4JiZoLWLHPOj90pBoha7T1H+23Jx94MNrfHE68jJaXVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3244

From: Matthieu Baerts <matthieu.baerts@tessares.net>

MP_FAIL should be use in very rare cases, either when the TCP RST flag
is set -- with or without an MP_RST -- or with a DSS, see
mptcp_established_options().

Here, we do the same in mptcp_write_options().

Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3230166d6f83..491362d8dcda 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1267,17 +1267,6 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 	const struct sock *ssk =3D (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
=20
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		subflow =3D mptcp_subflow_ctx(ssk);
-		subflow->send_mp_fail =3D 0;
-
-		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
-				      TCPOLEN_MPTCP_FAIL,
-				      0, 0);
-		put_unaligned_be64(opts->fail_seq, ptr);
-		ptr +=3D 2;
-	}
-
 	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
@@ -1336,6 +1325,10 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 			}
 			ptr +=3D 1;
 		}
+
+		/* We might need to add MP_FAIL options in rare cases */
+		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+			goto mp_fail;
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag =3D MPTCP_CAP_HMAC_SHA256;
=20
@@ -1476,6 +1469,21 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 		put_unaligned_be64(opts->rcvr_key, ptr);
 		ptr +=3D 2;
=20
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
+mp_fail:
+		/* MP_FAIL is mutually exclusive with others except RST */
+		subflow =3D mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail =3D 0;
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr +=3D 2;
+
 		if (OPTION_MPTCP_RST & opts->suboptions)
 			goto mp_rst;
 		return;
--=20
2.31.1

