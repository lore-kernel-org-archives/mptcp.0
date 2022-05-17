Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E197F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfZeGtab6Cz27ROUzdZqdAoXRK3iiXtz7YS6IdQ7+PY=;
	b=JldxEw0a6wey7U3++IOhq6zHD43oQwyHERNlSSPFI4WFo5DXsiaZfn5V2eBGCeHcFKcuFi
	eSKJHC7xvLLJOTZNrMLHwfkHgU3dpzfV2dJy+iGSyPJanLcxRoTsl7qVxilsB8yuiijwnC
	4EFbbRXDr0NZedcuRyNHG2Q3RwTsojs=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-Gi6R60nNOlqYtSc7NDTIEw-1; Tue, 17 May 2022 09:43:51 +0200
X-MC-Unique: Gi6R60nNOlqYtSc7NDTIEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqADwpvYBepgwvfKoyvtu3ICwCPPgB0goulpKzPHdHlV7W0IHdOCPfSzquDxUrQsqtEARaO8duixeFHtWtGtX+ZdwOHY5WQUCW4z1AVEIcLvUuFX15eOs5srjULEKvat3c001COSXqQM4jp8YTa3bq6oCiKEGfvXiiOo0vkm86kItrAIPtV65Wz2kW+3mtpMsrtOf46Nmr8W33YxlI7rB4bc5shMR0//pJYpSuGdY9TKMxNZrTRMofnKBNIRn/Rpp4DdBH8Y0LX20qwW3e3+KEioDKcruCtPUiBFQVyOe75OyLwZMXNl2oNghC1lmrsBeGGRF9PnvyS/ET1OhZ+k3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLrQIR9NLwKYqXZr9a8C+qfmppZ1Tca6CpMnxR6ElI8=;
 b=Kb/y49Fqa8HzpwReSskE/yisIgnorROBhAEHOI4ToNJjBcoBVGoGgpcPHRj/lBHH5n3VMZMhDtazlQKnifbrIqoDvMiWp60ZpmxBy0aGOlTzkRtnPSv8nYSXGypADnok7n0iyolrznoyrX4usBWvUIOAekLEnK63NQFRyQdP6hOLh0gr+JLbLftMvYQVP/KRo5v53vfagVK6vLV2pGZqYS4/5EzRH+KO1k0PPROJdPJ/5ZKYPZn1BBQhIQMvEglEYVoHFL4m5/WPAy3mZ5MtDRlBF8LcuR8TvOlWR3m26O1lTNhMoFqySU/XIeFI0yaBodifYGqw0mOGwRMgubZ6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 17 May
 2022 07:43:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:43:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: verify token of struct mptcp_sock"
Date: Tue, 17 May 2022 15:43:22 +0800
Message-ID: <8ab73e65ce4af9e1e6d5797655d65fb4ecbf250e.1652773283.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ef5e9f-25c4-4327-e4a4-08da37d8fb95
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB9126A6E4500F43CDA0FCFD27F8CE9@AS8PR04MB9126.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6qlW3AW3AS31K71adm8W8HVNK6BwUiPLob13S/7cJsoPchhm0WNxfR4ZfVp1z+dgFFbPFPGDPY1Cq6BHm6qvFN4utKP7G9K74TP/5WdYGscIUlLFrKEvfCyrJp7xIb1zG8uYunKM3Ab0Lq6OOZJf/9csp0zGLGdYsRM7kinE9K0xsUC7MAdjXKDFpOJJbzC+oSOu4McuOT9WHeQxBkNYU2hJGe9FRmexXDPZXS8PG4808pXRwEdEkJv0xIr+tJGRDStfVyowsDOwWqsrt+R8KLThXbY4QAsqjIjCOIN4tghMugLZJMYc9piEHHs0ITzcTf+uu5YitqvDwlRBDgeH+ly/+Yzu0SCjO42B1+Ze5JrUJ0lgX8Z7zOi1+giaVu0jH7uWIRXf5qLHzSECixJ7ItPx1W3Ual2FGMWgK65zwAWjBGNQV1ufjB8aWvD0T1R15+1Gz0cM1IFZgN994sw63o4067xWDKCHt4/Gd0azYBXnLuyB4Bpop34Oa9/n4Vtc1LBHniT64c55Pde6tFfz6d3w1A6AHrqxRmxDda3rb7XPcQBL7Xc/Z5WNfreAuQybspjTyyerPYcj++h3hncYWk7cvzZxln3NEzTiiFkmH/qkRWop8eFMlhtOqigVIj8HqBqCPktGYrdaERWqtySVyPsWshRcTrGeNI/zjTmP4vb7FFedzM5/u/4yJ+PVVeR9Z6pZT3aeRlUmJ6G0UPEJ9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(44832011)(15650500001)(2906002)(38100700002)(86362001)(8676002)(66556008)(66476007)(6916009)(508600001)(8936002)(26005)(4326008)(6512007)(83380400001)(6486002)(5660300002)(2616005)(107886003)(6506007)(36756003)(186003)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyFAuYeWPHCHXCORXDm1IqejLd/2h4ks35ucW9fxesyaTdBW5gUVJTFwMfZD?=
 =?us-ascii?Q?Y2URTIFG4TS3UGSHi5AbaaWgKn8TBkp+jI+HJ0MsGJpNAGOeAyjfW65T/D+u?=
 =?us-ascii?Q?eA//tvEkxhDueNkpZKepROn9kXTu/5+BVRmwPmvDasTgpmzpn/UJGQeqCfGX?=
 =?us-ascii?Q?LnSOezUulS1L3A/n5jjyEDmweG4NPNQ8WO60q6Y31cxbbnz+HyfPPNenLibN?=
 =?us-ascii?Q?65IMfs7Id5J2XjfMp+sBfI+00isdTiFqvsX1thKZoBcq3AVzUPB5PLk1rg5l?=
 =?us-ascii?Q?yTIqsdmjsBzb6aMyBwIaRcHjFm7y6YjFZW34KCe4IUw3XlyAos0ICQElQD9L?=
 =?us-ascii?Q?vqNzxcH1PqZGaI9LKSTtvGWhFCc3KJ8VLPgKwU7SJIlARQtjeT0nTUDgBeNe?=
 =?us-ascii?Q?srrkmJaQ075xmegXCpRrecnG46Iw24fDUmlfiNliFO41eeqjjIq1LPikEW1W?=
 =?us-ascii?Q?Uva/SXAMHgXL7pV9R95mNH5Ei58L/ULK8I8JoIbuq3agEZSvAkEtSP9pavjg?=
 =?us-ascii?Q?VN/HvBCKi9SkVraJhp5XkSwJtY4jDdSxMV4yw7x2rp4m1/qYlnDUFEnDEGPZ?=
 =?us-ascii?Q?JS+zWHcBdspCGAJvV/GNesXaXtN2ojn2YGdJVmQQM1h7ror2RbVcIj6DqpHR?=
 =?us-ascii?Q?K2jw1NQHHWyLc19TtvgKLTahnXI37yrCDaV38P64Mo2zX8EeqObNrKQdDGX/?=
 =?us-ascii?Q?f8ogwTLWhwAnjTpoqyylf88JVAmSd/LwQAzhpu8sIwEXeXAx3905oEbdfgMQ?=
 =?us-ascii?Q?9R87oi4CT857/BDVT1dQsWyiuxENfMSdiDMfjABWIBWyDkg19qQtYL5g7LtY?=
 =?us-ascii?Q?mQOYxCDNciQGNKnh+1LHP/kubF0c66YU4JSvkU6lLICKiPg3CdUHN83/6YmW?=
 =?us-ascii?Q?dklbjYohrDncCkuuVjsZVF3CnsnSlqEU95vKUuz8OBIK+Ntg4maRshSf1Zs+?=
 =?us-ascii?Q?BRe9Yuji4U+CMGKUF/6M6cw0Oj2aENco4EE4/46AR7IIRw13/irA0DQQBlfv?=
 =?us-ascii?Q?1gRfpkavwTPSp0FksrcDdCANqK5LyEPfCvEdDK7oJLmejFMh77jD4E3JTBgM?=
 =?us-ascii?Q?pUux31lgRY3TysEFe34kd6bDh6ebK/Sk4Y0bM5MYFtYie8uw3srWmKDIUt2q?=
 =?us-ascii?Q?ml5JLrVMY8txlm6dEFqvITwWIyRr1mGLWtyCW7j28/lg9/47jxyHIcYedCp5?=
 =?us-ascii?Q?4NkvSFcz7FhERCczhDnDBk59xZc2w7WKjVTxNOZ3AK65zrJpIlmajrE5g/Dt?=
 =?us-ascii?Q?SyuiGJNw2Tf9cGcuXhPw4II0cu7SOFOHFzwih3VOm2xNmqRS1VEkZby2irGk?=
 =?us-ascii?Q?AfwJEATiFSLmWLHJ4ieerfuvZr0cV7vXXAPc/iJ8nYY0ORfNpjji4uLJpRw5?=
 =?us-ascii?Q?AgC0xy9Tju4kLmIj5u5odnRWnAVnsLGsa2BajXGUNv0+aGzCCXy+D4naGnnG?=
 =?us-ascii?Q?PXZdm7ImkoORJjsln+n0FPeNZ1gJChVHNBPscevT6sxKqSd8R5+QNFmO85Cw?=
 =?us-ascii?Q?gLyAbfp+GjL0YDiQvro+kMUba30+hYmNdlPF6ziNC2g2AW6JFafA2SvgE4ZO?=
 =?us-ascii?Q?MUP4joD3KvCgHe1L9hzcb0wVQBHkrhHF1GYa5giQNGWGipG57AZHbtS294Ma?=
 =?us-ascii?Q?9IQ0YarTipHasXofwMNn+ZptZ0vH3T3TRXFgTtJsOgQQF3e6ar5wx9RLBsJs?=
 =?us-ascii?Q?XS7DYsnGUy4U5WDjaf7iHcg0Iju+XhWInJ8eJiPnsLIJ8wS2NyVXAQ2s7qEQ?=
 =?us-ascii?Q?nDLraPLRutpNBm1IIK8qKHYZJdxSBfE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ef5e9f-25c4-4327-e4a4-08da37d8fb95
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:43:50.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgmrrYvhSZygc8INbhbNWnJdIbKSsULbGeQ8kK+2eYawqHiAN8cK0qq/pPBlpeiohK+mtzt0kPWnvP3Vae8FnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

Use ASSERT_EQ and cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 2015a6c93a99..f41336e41f04 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -50,17 +50,15 @@ static __u32 get_msk_token(void)
 	sync();
=20
 	fd =3D open(monitor_log_path, O_RDONLY);
-	if (!ASSERT_GE(fd, 0, "Failed to open monitor_log_path"))
+	if (!ASSERT_GE(fd, 0, "failed to open monitor_log_path"))
 		return token;
=20
 	len =3D read(fd, buf, sizeof(buf));
-	if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
+	if (!ASSERT_GT(len, 0, "failed to read monitor_log_path"))
 		goto err;
=20
-	if (strncmp(buf, prefix, strlen(prefix))) {
-		log_err("Invalid prefix %s", buf);
+	if (!ASSERT_STRNEQ(buf, prefix, strlen(prefix), "invalid prefix"))
 		goto err;
-	}
=20
 	token =3D strtol(buf + strlen(prefix), NULL, 16);
=20
@@ -76,7 +74,7 @@ static int verify_msk(int map_fd, int client_fd)
 	__u32 token;
=20
 	token =3D get_msk_token();
-	if (!ASSERT_GT(token, 0, "Unexpected token"))
+	if (!ASSERT_GT(token, 0, "invalid token"))
 		return -1;
=20
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
@@ -89,11 +87,8 @@ static int verify_msk(int map_fd, int client_fd)
 	if (!ASSERT_EQ(val.is_mptcp, 1, "unexpected is_mptcp"))
 		err++;
=20
-	if (val.token !=3D token) {
-		log_err("Unexpected mptcp_sock.token %x !=3D %x",
-			val.token, token);
+	if (!ASSERT_EQ(val.token, token, "unexpected token"))
 		err++;
-	}
=20
 	return err;
 }
--=20
2.34.1

