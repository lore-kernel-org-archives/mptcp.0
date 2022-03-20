Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D833D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647784525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xadCUbTuOcKUL6zQylzIKvmbipY0sXk7B5oegP8o71c=;
	b=M1VfMsFXuyXhXHm3wZ6ZusV8ITlk0MMPow4Hs1b2KrCi3hzUepAOhNVytZSauLZ13y+Zjj
	oAVkN/iwiMUQRJCmwAQChvrQupyKZQsL0xNanWgTj5W6MRNuDbTDC8fIP1mTYj9c8vd6v8
	TxbmyhxyAkqv9VnSYiFd0F/aLoy2E+Y=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-IwyWZjh3Nu-rcOGYjMymHw-1; Sun, 20 Mar 2022 14:55:24 +0100
X-MC-Unique: IwyWZjh3Nu-rcOGYjMymHw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIgq6buonwQUoCZzrK7935C/5N5EH5dTnzZSdtr+nWrkMCTNdovq4nyCy+n4zg9D9SFmnCdsL923yQ6mFOJ5l67c+NyDsBaqBjsoscne6OvBOx8KLGNDL3V8y+/7hl155lBxZsWp1Xg77SWnZL9su9+Ez7yt8y7KtVoaIEtA5CmQ78BrxLUxWmxDaWd5p8aGfB2GNOXxq/zsOD5TScpi1lwoufteI8pvqoypYzKo3hxDTONG1r+p1PASMuJbiFaDQt7j6b+H3xoxL9UrG0haWT5XWQ/r0dZuP28nDpGjDiq7Oe11cF0AqkfRthOFgFAh9MPar8HLCp3vObLHcjsnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPeka+670wgl8W0TwWkC4v9IDoQ/al85d+jwKtIVhq8=;
 b=bBIxFwF6NcCTcr21SkyTn6JC1arp/zvQTTOZ246+wFX27N5sp52TCaxxri/KOl9k3YsOBOG7vxzdW1Ij5w7qnS4gh1IZcwzq1mfQsVQ1oXFHydnfmL0VLre4TcExnuBSlyRlTAQoTjRY8nb2BbGyabmYHHEJmPos2SA1Bc59z9hwH/6YiZcbX0PB0VIxR8CRZGXYRwr4gsjGpGUigvdGJVsmrsyPyNcOuOOX83/PPSjGBQQotWhvsXdBwfWKL7qshdMBdLa3vXu3mGvTMY1SXmWbKGmo1OH7BYUMNkK3nD2AhwJlb3KWm+54DG1w8btppESYaZVFrIvc7O6eeaDFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 13:55:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 13:55:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Sun, 20 Mar 2022 21:55:09 +0800
Message-ID: <b7439fa6adb7883bc69cee726bb1d3bd0a683756.1647783989.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647783989.git.geliang.tang@suse.com>
References: <cover.1647783989.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32100670-04c3-4515-f4d7-08da0a794783
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4558AE6FEF06FDA31ACB2680F8159@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6IdNhuBo+XSzWH80AqIem7630mgbodGPt9DBf8rOGQLYa7JDolkRiaoC3igFwrs8x7kCmYCHForTipoe61K0qcn5lpwJfkCedv6hoGiTiVVV0R7KLlAhhC1vbkc8YPxfVmdJadU4xGuJ6yPKFjz2O0Nw1eFyD0PB223R87zn61VVTw6Ijz/ZOjlgC5TIqmgMp7t7Ud97wGauXz06kRUno8XYKhWU6g5zXx9G5MiZKuCBtRdPhq6lt8e0igbxvAkTNrVML8PTQ7IN+tdHDaT0sZ6/4B1KwzRRryB4HBQC3+hmWBaO+TjcTuhO0ZC9X1CV3LtrwH6Hz5XlIwv51MhMGEZGUv8phrxxfGJol0qcU7ytleK00uYM5ehVCuCUeqEdLljl2f2c4KusDs3Kcur7b6cowvpOmuDh8UotQOzRWwpGIyJrYFtf+ApBQTcQq033w6e1r0ubGa90hNiGgqC4iLvQbXSbYleVzJUz1gHy6eg5COishQZg4486DIBd6M+hO9WvGnl1zyr/Og021+as806o4ICDiGEYExrY0GRlf3ZbxqIbomR3FkrYpqSKiJjunh0xIntF0bxM7X2HlLS9shGF0rofc8ovv3xFEsIpHkPL5rdL0i14xMxW4UlfZkUKAR+BihiiJTcmjRMWPSQB8EC8ncNarVY72KsJYMi5RXhMkCij3bN78AxXLsG7T7uYYk7bJBfyr3Oa3SYDrCkgSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(5660300002)(316002)(26005)(186003)(6486002)(6506007)(38100700002)(44832011)(86362001)(107886003)(6512007)(6666004)(2906002)(508600001)(8676002)(36756003)(4326008)(2616005)(8936002)(66946007)(66476007)(66556008)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp+WVp9ACQbi3u5lkp1FTHt6N6K18Xkgo9kgpzhd0N6egXY1b7+8eah5AHTA?=
 =?us-ascii?Q?9kiAsQtMx2XfXh0dCntyWtxjBr2elcTtecfblvQ/3GvUo/SHr3g5p0l+m813?=
 =?us-ascii?Q?EwoAp5y2JWpIRTWJ4St3cxG1tjlJipe2Kvm5NvihUOIADScpKJkRiNzv0NLF?=
 =?us-ascii?Q?rDGk/qR6ieqsyPU1YizrjjtZR4DBto0djya48h4Jzq1JAj++YqmSrHcXagAu?=
 =?us-ascii?Q?uTKNtcsHBOKEpdViddqL7zFJAcTTTKmso0OAARn77knbTeWI1MYDhyM9cjW3?=
 =?us-ascii?Q?nEWGof28S84V0eg8l+qGiLPtqh6MU4+B1mkLICWGUEGhyTwzTPEjWfIbk10b?=
 =?us-ascii?Q?R61fRjSOSOCycZwygJHqmgmNxEBXNIf0sf4nShg5sWWeUBWYtt5d+7IueaDU?=
 =?us-ascii?Q?QX/EesnqbNIEPDFWv8C6pQyMZ2PwApcfjHCPB+2c5VOAP0aUIL0QdB97sK/c?=
 =?us-ascii?Q?xAsexv+wV/uVEt84hJlwbwcokFHMxHU8AtgCDGhSkR9Mb0sFrHoaH1i+zICg?=
 =?us-ascii?Q?pl26kCIzB0SaGP9MadbuFeHjlagCKZ3WAI1wBsQqnLJ0EPCp2ezO2EtjD6B5?=
 =?us-ascii?Q?ttXlk+F3Kf/0wA2BpAg66NDWCBRVY7KP5XAPcam9qtSIaUxRHCT7ATVJ1/E8?=
 =?us-ascii?Q?7br6TO+nyRZsGgGBLyWwEcFn2MTtQQR6M6jzqi7O4eV8b68Wz6Vtnn03JhHq?=
 =?us-ascii?Q?r4y4qvsc30t/I0YdPPcsPEXXMaLfLqzL7pjHIoYBE0A7NVhpty8TqmZa9H6h?=
 =?us-ascii?Q?0XozlFZgIkx/AY48c1jhnc+LBwrINPXekNteQ/B6ZMPTqHeNjUOOyJ7KYPfd?=
 =?us-ascii?Q?1gLN6Zv7eYQZePZEmHdkLWO/FibmzXEv3M6TO3p+25dse78byAHPOk0ydRdP?=
 =?us-ascii?Q?+Dj3Hsr6wLxhSRe/wPQwkXaFLn3tBH4d5stGuGKgitHd4vb8st3aSZHYY/Ld?=
 =?us-ascii?Q?IHsFVkAXUZaLJvu7tbvZg+9Y/LpVw4iWFkiQbxLYNVM89N9KUeVj51QqNfGd?=
 =?us-ascii?Q?vQwUS6ZZ08oOT8lvPWzYpP9RAHbdCMqi9sJGTW0Qm3l/ETcuVblYv5cLXiQp?=
 =?us-ascii?Q?sDMuD6DNQixaAgePepBJMdMSQlwgxOfELs8iGTy7XngTfhg595OWXmTUlS1J?=
 =?us-ascii?Q?/fpm2ehV17xG0X5wktcqm7bqAH8qN3tT24HCyTNyMKxzIv2bYvSZY2dqvA/i?=
 =?us-ascii?Q?uC6PbT9VtDscKcfbBsIHJHuDpPNN+R3oo+7foRv9ICd1YDhKAwqzAvAoYU2H?=
 =?us-ascii?Q?qrfICbN4/xdAoiixqSQMBNbwHz3gS6hD+fRwq2yt4SvNEq7MVvFFlBbWq3rK?=
 =?us-ascii?Q?MhDkDoq6LAMKBBuIbcSKiJ3YdF1WZr1Lxnrdr59FOY4VuMytz8o8XzUmEsmu?=
 =?us-ascii?Q?becFD/bjYnmuYGCCBJVfdUjwjRbBEhGAcVtX+b4r+E/4xCZ7V7lYiK493QHk?=
 =?us-ascii?Q?D45dH9Tn+C8P7VzGQCFWbp7m9+VLcz3JM3pXW8g9jehzscbuszxHFw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32100670-04c3-4515-f4d7-08da0a794783
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 13:55:23.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtKB61MgDBdHAkMu27xmzLzTv40Ph3Btoc0Fsu2tb63J3yMOUe8aS3z5qtQpqXRoPgkPrj0QQnkiGMK98NtEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

Some small cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 05f62f81cc4d..9ea6687c8f4d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -86,7 +86,7 @@ struct tcp_sock {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
-	__u32	token;
+	__u32		token;
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 035a87755b94..80ae5a9777bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -56,7 +56,7 @@ static __u32 get_msk_token(void)
 	fd =3D open(monitor_log_path, O_RDONLY);
 	if (CHECK_FAIL(fd < 0)) {
 		log_err("Failed to open %s", monitor_log_path);
-		goto err;
+		return token;
 	}
=20
 	len =3D read(fd, buf, sizeof(buf));
--=20
2.34.1

