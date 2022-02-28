Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03717C
	for <mptcp@lists.linux.dev>; Mon, 28 Feb 2022 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646058735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t7Imu3VAsOBs8nUQ12dRR79ffHAtUUtxkFBMA6are7Q=;
	b=J2jvpOYI316EInL81rUllZI+vURInFIuDh3JEgKsuyXY4kIVA6BnpfwxomSBDQf/iiDBWu
	vgUsbfu0LxEjssKvLKIF26XI4c/oqVU6D4oxp8zBPuuujsTQ5OAdbC/rLHOIzwFWt/WMgE
	8nABN2hihC/b4UzmC4WqEK54Vu8aPLM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-1zcjj7vJN3KSSCf9jxAqYg-1; Mon, 28 Feb 2022 15:32:14 +0100
X-MC-Unique: 1zcjj7vJN3KSSCf9jxAqYg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsUQDjNG6Fw9kFkZyijPWtkXaG7nMxcxPUmUuroXLqVCAUbZUI3fQ9zfvYBnjgFTVNBZ4OHfw/JJpFWkuWC1BqK3X+ssyYXPYtaLzDBSFjL3j35uPQFNvRd07+Ae09Wq3bB/QtVrpdCGn83SPNit7SD0LJz63Ycua+qs4YNFaZPTa7/BK+MIiZgU/zTeU3imUl7eoSomoyOR0nCASuLtewiSqOIkkiDwLQLaoCgyy/0bVjfBAS8cRFKJkIBhzQokgR0sEHzz9lTEfjIfWKpFWnXnPYQy4TVk6BhMNIMVc6eWcfV2vQp7dKtvk1YpHQBRSNX12GjYhf+NZltrNVm3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i8jpTqAYH0Q3Z96zlNSboRGtAP43n9YULn5ut3B41g=;
 b=Y+rf/B/Cm6rBzapLfdCux9xXMArBdBgVkws9pRflIi4BwKyUePNrfP+5uRVVYetQHqBw8gVYy/ZoSpYjd0YgDdUg7s0AFeDFvZzupS6mE9DpmzmPznrmHKk4iA8CpbPnWxw29dBemjWu5tA9t/XSwKavZsARty5LXibNV87GtTD+NcuLfedznKDqvCrFWBz13MfSlqJQeSN04qoo+D0/0MpSQlFx3ydA0CwB2kvn1Dfy95NkVLuo4w3JzWX2SlEFEDe2nRp8bPEPjFK8M4t6LUhQ6nqgAEIOHY8K0f+w5LM7E3xmBdVuuYKKL9a/eqoA+v0fSN6ojLzOGvLavaJdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2245.eurprd04.prod.outlook.com (2603:10a6:4:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 14:32:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 14:32:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] fix libbpf 0.7 deprecated warnings
Date: Mon, 28 Feb 2022 22:32:46 +0800
Message-ID: <cover.1646058641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5382be0c-130d-4dfa-8156-08d9fac71c0f
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2245:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB224526CC3E1EC52392308775F8019@DB6PR0401MB2245.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WI70F/C0V15l02+Bgg2bNRRaSxptVMI2HGW9QpxdO4Asya+Dkg+j87Klo5L8y+oBQfDyPf7V+DqQmDTM3QF2ngf9cInaH4oADR7ZJKXX6AubBX3ZISVrfE2ryWPZSaiwjn/bbxaTSplDPjhaVTIHi7VpAdUoSlSxqVEXbyB9K7gm81iRkJinUxyhY1Fqff/fM/3Ke6flMGdZAbYQIu3+qa3q6IyzgMRHlJQlZFDahcs+uvnfioapt8ObZqJVesJMxyufBcsGY1qErKiw+5GQs+9xhI4Eeh52PjIWYjKidMyfDsdWA1OEr1CxYAPoeuR7MIYeuRte3H/JlSUtV3wf/BZbMBttITYiw3CRBiXAta2+Ix9vvtn+Loj92zdLSXLeKIn5Ys8+vR08MnJNEP6bqsx+TDGsvR2gPBye4gA5RrEzv4/NYl0hV9m4mFPZxPud8O7fOzaeL0UPSQNKWeP9VddCZ/KU7t447ELCRXS7pGDo6R5l8TERFSUrG80Vtb5mMdjEV50Qss7IA0T0S+2GjDxXlg9GYvsCNA8GkbrBCt6CLGCbmRe4J7dQhwm/rRbmT8Q+PV497WjAvnHQWhhfmY8E16M4fgRlBBwxz0rPiYAP81FaF1o4jGdL9PP8awja2HsW+fjBSs1Cbz/MllIgSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(86362001)(6666004)(6506007)(2616005)(508600001)(107886003)(186003)(83380400001)(6916009)(66556008)(66476007)(4326008)(8676002)(66946007)(38100700002)(5660300002)(6512007)(44832011)(8936002)(4744005)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+XAcpOVU8rLYPqvaHfjQx1Omec9GodCyKjc+uZnpoTNFGTQts5UA1TJmyTYb?=
 =?us-ascii?Q?GjC55hUh28q76FJqjxtY/F7QJEmfO5yTyxs9YTeLBIB6pukZ/kKM1PiE4mF1?=
 =?us-ascii?Q?rfr9ks0LpbSvsLAqOUmBZwG1QvYXzvIdnSPfy53zV7SU4g5MOVg3BLC1Pf6J?=
 =?us-ascii?Q?b4itcPGTleynj4VkLzsKCvn308GRI2G5TvAjcMZB1i+7knz47gMgvtxqQe9h?=
 =?us-ascii?Q?BduRqd3YF3zZk6OlbRVq5KbbffTaYkY6OxE7Z60Qsfj2rYeiL33UlL9Mpbzu?=
 =?us-ascii?Q?ok+1vPWbOTk/IvUnxHkLFDjolJplpPFFM+RE8ohboZAh/dau7Hsncf4h+8bl?=
 =?us-ascii?Q?yeSF4W81xmd9AEnnuUU3rtHm5DtnibgUl1xjH0Vdi8ailYw7w2fv6rpddise?=
 =?us-ascii?Q?sBSUNqnwIdRo5gdMVFtI5yGLwUBvb8TaSp+yIGV6h3p12vSJt1Db+jKsotXi?=
 =?us-ascii?Q?BvcWs0I7UCnVpwZ9S7n9S6OQtUoJbYrk3FwDIhoGoelO6nOYxze6GdKa84yz?=
 =?us-ascii?Q?JlvcfeIwPCJN9oe3IUnHDCx4mnz/9U05WGzcIxYMqlDpwQnG4yDk4D0wsok/?=
 =?us-ascii?Q?GGQGwmxWCel/Qs6wkcdgw6VIzWMswKsiuFEBAX3sQjEdExEX6V6KESCPrYOx?=
 =?us-ascii?Q?9NO8Fn1SE1N7B9cF3JSkNcu/gzPzZMqmtuYcE7lvZkN2IEEw3KjmO5Vynq78?=
 =?us-ascii?Q?OQfWiHOkwvz45Ur5ARJKsgQuwtb7I8hE411OxZ/UKopQdSkpPkoaU04NGQAd?=
 =?us-ascii?Q?qSF45Zgpj7odyRcHC1kgReUzwOI/s7bdLlxCuMb1W58+hivzgAq6ezZ8F5ro?=
 =?us-ascii?Q?ucXTEoy5t8Cctg5xejUs/94PgFU1Sv8ZGRQ8lsiBXIaQ/kBNzbwFJA1ZgSHr?=
 =?us-ascii?Q?W5yptoOw+La05ip0SeOPuXopH1yxn5vQRnhFnX9A0HtdposntWU7GbnEI07E?=
 =?us-ascii?Q?i6bEWtDsrCcuSVZbOaGJLRupGO/9J7gHvUeMY4UGmqBtMjODruU6bOqofcpo?=
 =?us-ascii?Q?PoH5zUBGhD8n8QLyc5K2vAiioR8cxE0JN2zeKX8yPCN3XieGXP6OJ0cx+rBO?=
 =?us-ascii?Q?HCRsRrgWIEiZACz9VqQOvqHZOGNzglvuvyzGOVEfyaPsYlY8ktePyZ1Afh5i?=
 =?us-ascii?Q?WxbSm6/S+2HWImk25Jd+VgVdR/Y8qmQbEoLCcE1wEvnhs6KRFcZHNbM6IIoe?=
 =?us-ascii?Q?Cu133mA+lHA1z5v/wcf+DPMFf1NTJZ9MwrJBZp9jF6HGJ3zwLW47+2wFG+TE?=
 =?us-ascii?Q?rdGyT3FUtiMvolVFrCboRiSmoOYKy89O2+tI/TgLPGKvlpn7RkqinwAknsJk?=
 =?us-ascii?Q?zzuAfg97GLSp7moEQiSpT4hcTPNlMnQNrPgVfQDuM3eq+zOlh0/Tw40RG/ek?=
 =?us-ascii?Q?AE+yHio83bK21oyJsYuc3aVD+rbIA5wTpjMatkTrbDBwZm9jtHoZRIY86jJo?=
 =?us-ascii?Q?a57JW4lzZxnavy1vxFbB6Rm28/gdk4IyEMmnk5INK87f1DKcKcBar8kL3urm?=
 =?us-ascii?Q?bsUwCbEvY0eUXNh7pkyu7ioVYCapbLOdlvjiuYItrk3j3lnfQIcr1OkCVJU/?=
 =?us-ascii?Q?72Y4OLHJTsZEZJQVRgMpy+jPQaE331xQUkY2TQb5rNwZUKA5ZT0U5zEJ3J/3?=
 =?us-ascii?Q?WQkWQTAysB9Tgf4s4tCy5aTMoxM0+EN9cJPpYdnFlBHaOQaBa5M5UBpx9Ne8?=
 =?us-ascii?Q?wk7cB6F3n4hIvOw5yItUGcBYu2g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5382be0c-130d-4dfa-8156-08d9fac71c0f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 14:32:12.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0iXITbYj5cm9dHrWsNxQL0h6BW6xyhErse1VAFsKBK6tiDMKLUZqOXX8RXeFzhicMWqLVw4UmjCTm660i10IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2245

v2:
 - update the Makefile as Mat suggested.

Geliang Tang (2):
  bpf: examples: static library link to libbpf
  bpf: examples: fix libbpf 0.7 deprecated warnings

 bpf/examples/Makefile                    |  4 ++--
 bpf/examples/loader.c                    |  4 ++--
 bpf/examples/mptcp_set_sf_sockopt_kern.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

--=20
2.34.1

