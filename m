Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A57A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VmazoG2iraY3SpxCd7RljfDFFcxAK23xincRTiSgYk=;
	b=iMaEjbK0NInvgoe31uF3JOKr4H1sqV4V52Kb/gJw0m41pRiGIcbFeG5vS5MLmUCAxjyr2W
	XPXyD5Rz1B/qOnefwc512RColpA7Yq15pxTaOYt2rhp+tQP26L8JpXl9YHGQXYaEu5jEdy
	IO9DlDbLH8a9uKIgS+03iYtHLY6VeRc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-vnr1KJI8MU6CQGnhsnKjnA-1; Thu, 19 May 2022 10:26:22 +0200
X-MC-Unique: vnr1KJI8MU6CQGnhsnKjnA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8w64muXorBrb1CJ3rjwFQj6v+DsG9wzpas8DvW72gzyBoLuRhE05l/JLuXVghoCqB8+HE4BDrOwCDV18cEOEG31HsydWmrDOcR08nXuDiWKvloqjzuCEuGf+UQKpfLUYB7YAF2+ivEbRPKGWaU7+AaZMHee0UYr2zTiBt1N8Nuog1j17EBDCmyRC5MaSYJzyzQ2WF/1zDRoxZzBsvWMPtDNye/iFFHqgCBnpOn+MqvodXlsyVpNG/D0IiGoct9q1TIF2wOMCpGkmxXmgzMk+yFTQZK4QRtvyNkFNrqGMEYUTt8lhYMQvsLn3dx5nzNYkdDXjZw3alBZFBEhzYuluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBP/RPZgMVDtMEnPasbzS/wXF2kJ5DNDGX/LAaLhiV4=;
 b=RYIqkV1JvG3JA1nc95w7VwFJxi29GV/S07IwyGQbvxRx1eJrt65Xh1kFQxz9LWUo/AbBbKkda+VdHm4pTl8wOyDhOO3hHlmCiNKRAMIQrYYVFZ1sTrnhfhIqEknrXxRq5ki3eFrBYf1zNVFoHWcRTyGFeu+xT0ydFEVyx0hdMDiO79vsXv48SAMFZoc7f2HOx+p4wpCFU6iZbUSgmxNj0FhV6CiHFB9CRffM8OZA5AyFxv+i/rhWQnUwzXze9aaY4FJ2T2RYPLfcr7nZBGjzg+s2W9BZorOBlhkn4Vy+jAJmtzi6Y+IqyHwj/HHFpp6eVpmtKpekLgkIre7EFUvVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6527.eurprd04.prod.outlook.com (2603:10a6:803:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 08:26:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:26:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: add bpf_first test"
Date: Thu, 19 May 2022 16:25:19 +0800
Message-ID: <5bf7f96f2668225cbf594c1c601b1b258e5f82cf.1652948256.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0016.apcprd04.prod.outlook.com
 (2603:1096:202:2::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd6faa2-3ce6-4daa-8f83-08da397140d3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6527:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB65273FBA7E7102AE77F34B8CF8D09@VE1PR04MB6527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tqm20wqs3lxEhVtd4YNRE5tNWHdImDKqjyYPR+ku0qsS3YuchqOXQtEHBWKy/V9hsD5XqayZol1YFPD6oF/TbX7ez+ZsvD8/O8qqLOvELe+21oicQdKwPG909GidOajszLAJbTLLa4FrXERI5B+ZcLmb16yWvuXqKzJMKUHXEw3CNVG0FfLDNCSLqoxGcMMBm6SIL4LX+RXyj04W883Pb2NmhEMnKsm5W/AY+VQmSiPJorYcYHj0wRDvQ7wHD0C88Hed4XDT2picmxPzhuTFy5Ck798WXbU4wRhFP5tfYRh7wWhPVaWcsafeP0aJK8KOiB9170tFmcrK/YrkRE1Jpna9VJGQkpbnYXTfQXb1l5Hs9uTuhLeH2aijcYrVPl2YN9cW/6yQWfSK0DWwzYh1ZybxTBMlkDuQ2Iiwd9broanZMscfUT+2KDBUp7iLVt74fcxa/PsOoQsKdGNvOKG+O+ieFFt+2TckXyugrO2IHR6st1489zR4F+d0H23OafkUVvm2z+qPk025iXUSCXNs8Dw/B2hYesgZLZT3NKt7oywQQBRC+duTWyrqz8fPV2jSoraSJYAjci8JzacoiO/fJ6PkHpD8tTOzkU+buXzL0T09xu5IfT5/dcDTu/jKlRxeBC84S1st7+HDhnYQVcpC2w2KZK5YYgkscdBsidIE24YeXXnJEtWr1umo+hJTdBzC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(186003)(107886003)(2616005)(44832011)(2906002)(6512007)(6916009)(6506007)(316002)(26005)(4744005)(5660300002)(66946007)(8936002)(66556008)(8676002)(4326008)(38100700002)(6486002)(86362001)(508600001)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXo7u2YeYAJ8ejUp8I+lyN1LDvkUZqnq9eZ2hvZL+89sJJzwvRV35Mif8G8X?=
 =?us-ascii?Q?e78vJUMFRTulU4xOwGrAWHy5y8NohBpACUkJkFMAkiypBmdrX34pg9ymAgJy?=
 =?us-ascii?Q?OlMyWqC0x9vGyFhR/sOxbxEunqgiJDlnvTDq9ZKQi3tbkQv+mRbmr8HhfZfH?=
 =?us-ascii?Q?h4N5aUo6AoOljb0RTB3vpgd1WPtBB081LZ8kGzGiMD/RgZy4SmaH6B6g6zSe?=
 =?us-ascii?Q?L5H8IrCh2K6gBcPJPKq72/OAqnJDuOZE3WBoW07dr7ykEszOPJcOLFzPWCaa?=
 =?us-ascii?Q?zcwtewVQw8Nqg5YPGBtTYujszSrDox2BCD2o76cikdefPu+QDobyhG+fG0se?=
 =?us-ascii?Q?gE7HKMDr49OSvJj5N1xqRRBzafVMrMN1EsA31j4g43Tihb1t020Vd0LwruFR?=
 =?us-ascii?Q?Yq4Un2Yc0Rbg2lPCpa85nBVeBpPzXBjDNKO3xUvE6WAIgO308FiJ/X/gixoc?=
 =?us-ascii?Q?+sDNsfPnDygSpFh1zXHqR6PmVX1OdMuo2z6DBpkw20E3as7gpaexxxw5pPTG?=
 =?us-ascii?Q?YjY+5o91YOTqfqnqzp4VxkDz+WOHqFEQfMhRFNxCyapC1gUepfJLdVuw/aZD?=
 =?us-ascii?Q?LrLtIOxjr0LpMG1dBSjFfqgY/lSZIFw2IJWEZD1C6/x+stey4K1J0+s9C/jU?=
 =?us-ascii?Q?Y9OV3KbFhqVnGAqvoYSc9+F9qlA9Le4yBMgMa8opH5Y3s/yKr73kXjsRRpZd?=
 =?us-ascii?Q?fhyeKwdT3wr92dxzjEPXcSiwrm83Rize9D3Dcwshu/WkFRIY5BDWGEOagp7e?=
 =?us-ascii?Q?TaDx8Q//GR2+fS59lCNecTIEFjQtqU2uETtaA73N8+4hdEddtEMM55HTzPuL?=
 =?us-ascii?Q?N3s+Zysqe/SU8VFL0F6TZQsK/2vpfWKGWRNpTYNJnz7vXOfdnSLvN1x12/dq?=
 =?us-ascii?Q?K8usar2tkkYQZqUF1MxPgbfYevtrp2Gkf2nL0DVNahKnBWaddKMxrx+tKOxx?=
 =?us-ascii?Q?xZ6ao5yastr23udqxZVtYvzveRasQrFsxXyiaLuR244uvRKuxZxaLCT+M4j5?=
 =?us-ascii?Q?OvvlzENr1aLFyKB+v58qUtio9pgroI+efZ7FPYaSccUOz+FfJ3mikv9oixzv?=
 =?us-ascii?Q?BxbI+1Y3vwn41BlG4O6WLUgef1XEYcLi2v93GkRjn4q4n6rnBbiPUjSoXbkA?=
 =?us-ascii?Q?tbXBYdwi5A/0Md4gFqYtZ2BoYNRaYSLWiycAaKWTwg/NPihTej5Vo31J6Q1i?=
 =?us-ascii?Q?yRcIxBtEGzhW5Gp8d/FYrvN6ifoRvyfX6W8azqIg8yNPTS2WB98DbuEQlGWP?=
 =?us-ascii?Q?Bok/o4hvHYjVKFN8JdPHKqmvCXWVpLSxztDr4mHNfiJ6d0DbW/cHPFnZwxHP?=
 =?us-ascii?Q?a4Hoj9MSPPTqEWPgRnbsJPsvCpgNmf8lSuc9M1SSAJ69FhVqJT38gcH1xYp5?=
 =?us-ascii?Q?b1tFaBmazKJhTzG+DA1Z57HST+VFHKWwtlQBlqxDzS9uyZC/odDJ+PP5zZsF?=
 =?us-ascii?Q?pO2v4VBpmNWe3948qt3nXlFX9sBtWw9GdK96OgFlWZOuDHunNPBc7p+Ts8mO?=
 =?us-ascii?Q?C6xq13esszyrA4p9w+IPqbBvb3cZYhtzNw6rPCJ+jh4Zhr6YOm+/fEe2F0kL?=
 =?us-ascii?Q?jFHWqKQXo0deiCEU2lF1tn3mPhYE77+1EWS6+eRi7qoFQjaklv/jrBb3zZqU?=
 =?us-ascii?Q?eeyvF0mcPFxRBtW1ncBayzWDSpaOBbSpfvzrkQ2LcVv+jhaqj9/Sah62HrB8?=
 =?us-ascii?Q?DH6W+4TITuKQevJSuEy0jaKeQi02IQ7H2JJfyBkqbD/mRW3m2rmKhppQ5yjw?=
 =?us-ascii?Q?b2asJJF8Vjuh8UZu27YcpQS8EitgL6k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd6faa2-3ce6-4daa-8f83-08da397140d3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:26:20.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTbQWbnysUF4YuZPPzxdZ4SqHXA3CDynNqZJlX3+JSyIQekz/A0cD7rDrzF1fnepOJECKJ/rV9pG9c8DFQhL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6527

Drop connect_to_mptcp_fd, use connect_to_fd instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 5a689e758ed0..9d37c509d3ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -268,7 +268,7 @@ static void test_first(void)
=20
 	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
-	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
=20
--=20
2.34.1

