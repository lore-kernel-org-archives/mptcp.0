Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5C2C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjhzF5PoEJuwwWAa22cnMbzTBhyfzDBP4zMPxwH47Yc=;
	b=ifBewEUaj2cUpCHbotI/DsAnyiggKLVW/dVvDaxNxWOcuW59107c3Gld9yIojkG7o1LAF1
	2I9c9O5OsvMeCLu6Z09ZeIX86hAzUAHid7c6Lg5Y/SMM5IrrIlZq80Fo9BHn/5oEK0N+O+
	UtSoo+anXN20K1lNgN6Gy2sbQNOzGzQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-gOsYFcRJMWWks5tJcwpngA-1; Fri, 14 Jan 2022 11:27:01 +0100
X-MC-Unique: gOsYFcRJMWWks5tJcwpngA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3TSitaJCpeuPCfJev3Ls80cniF1vE5NQ8VZcktZ5EL0qSdP/TDOlOsKRg6eaOsfmNaHf2ZgIafwbuBz9SSZkl7FidyVlz3jnEL+TZoH/oLCkuTfQ1ljVvuVj5fBAyN4y6R21Vu6MTwn9D99NtGhBq/tMr8ot3RlBuCz4mP/EJHHlprvIfHe4QDYg4jDH+ab/KgXyDN/a9L7XxxFLyUKTwYq2pma6yY1b7B/Va63MBfQBvvT4KPk4gWQfYr4qv3yQhKbrlwwyKR7YFbEyk1pdMRL57GP3CQ8Zk18+lmbr7YhSC1rYpe9mZxf4VMjYRI8pwYQWXlHJZEc8xTQH+dFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07GI3ftnUr37Z1HJrB3SsxT0T9Jz3pwnTguJIgU49KY=;
 b=WhJcBQxhAPPVAonaYPqh5bxrBt/2GLQnkHhK47rC5U+G4ZbFvs1+N0B+J5Ztnw5CvosiNw4jhQ0hxcJtcZD1tgI8kb9mpBtGDe89cEh7DwBECeW9GTDGp2XQSWPkgYtVgCfRJVMls7GQy/DBMpfm4//92d7k1nGjbA3dvJ3wtwHCqkIbIgIjkEHsA/C4y6nRcH1UCDfNHVWBskXoVDH0g3jzO/gRpnx0M2uRCZP44srMdLqccTpgTGGUVccu2R1ifKDs1dbutwnxCHLXgIpac4w9ElA6YZDDVdpvbKvPjjBBeiSHBuQr/vxtRw+vQXECwOdMxl2S3bWUUv32CoFreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:00 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:26:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/11] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Fri, 14 Jan 2022 18:26:21 +0800
Message-ID: <f8756ea3fc2217607d8609eeacffb8fdb4013570.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:202::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02e27360-e2ab-4439-9460-08d9d74865f3
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB431743D190D4E98879FE3018F8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d4wsTR/9J11lTyzn77DZcGEJ6ciONissyXxVgW8H0EJkH1s/7OKxHTo5EzETDilHVJpDDywp8B0zqnlrsBszDQHClx75pTZUVywAXYFxBQ6p9ncTRbQvk/d48LRl5EAQ1ype0IotDIrlSGH0sLrFx0CllEMf5HBLBR/fyo7XWUzvcjEZSPs4DGbgyPGASHfXmsFJwKHSrVYc7m7ULeHSI0t/p6ItLmYwcIVFWNJ05hmNoLwIn/SJ6oqtdemj5P4zwMudCfhYDdxEyPPAbiHT6Zi8bCxIr2YDCvQjbkNfcr/sBAViwGdBGe+qp5RiZO/ckMRD3Zl+e+hSA6x+3NsEhATZczNLu1O5AEW5l3+S43XJxI9IdoEwr8NweHjK0pC1R7XtVzSWzF9xXOGoRQt8wEFt8aGOvAXa4oTPtgD5GkZkztuWCclie339yiq95LM7oHcs23hPEGfHJN2z0pfaVvXii5xTsAXWoicV6hzXbvNGshbkktnvbUXjZp1LMO3c8RP9jDJE9zTX+/XTbWhmiVBuGR3z3MfQ5qZF6EJnKs/49nqEYg7Y9tbccuaI9Deflu6V6iYXc9ey6KfYEVDOqa7WwOYFV1knZmm8CY2yFwSyM7Ul55c/oz2RP50iB1o/kiFnaDgXwU3PAdFPuzfEKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khXriM6RX4uff1VLEXfmnwBQaXvRtQ7jKjJR506UKWu/n9o2hj3y+2uQqGs5?=
 =?us-ascii?Q?4tOlPByfT+HYoz5KjioFHC3zaWXKIgu42QHg7sAenWEzuuH1UpSWIanytFCe?=
 =?us-ascii?Q?bWosf0ML3I1BJDW4dHXd4EnQ/grWlDvmB/t9JKd6gWH7dSwWyZUJSAxsIyfb?=
 =?us-ascii?Q?rcpSHTQmzLF8Z1RpOgDn7y+24Sc5eIDgXr9BAe74N5xj5SBwxdWcGUny8hdG?=
 =?us-ascii?Q?SqSWTPvBVSVgE2DGJWYMtFNgSZtE9ZGdAmBcNIGAFCwrFnn6zWC2SFxuj029?=
 =?us-ascii?Q?6+RpNTFGA79gAC7z9R3P4gvgqUiDmZi2MrVaPxB32n84NkTXtIZNUQsDtneg?=
 =?us-ascii?Q?ny2aT9Jg/hN1jLKe1ffaLzi3aKp5IJXuSkWDYXVpgirhZgpn9Xb3o+fRXl6q?=
 =?us-ascii?Q?KY9NI/GsMHF8KupEfA85HZwqtCtSYOCsloFMnu0mVf880xfU0+ZrXYAq07oW?=
 =?us-ascii?Q?RgiF6j9uv+AbiL3oibreLcd0whakrCzdYxpnTFZauy7PusBqPe/CdYJjvOyk?=
 =?us-ascii?Q?ucu62pxMbBeaIngK0H3WZfk8vKDlPMgQTCYNnn1MR3u+d0gAjRveqjM+XxZE?=
 =?us-ascii?Q?WyUCs+/yVLasY0w5i94p15y/Gxsq6LGJp2SR6avp2GHcWA+YTGMEX6+aun1p?=
 =?us-ascii?Q?sdicE/8TXGwQ+Iwvge5b5Yf5CvIW4MVTinmpwSX+n7fv9PUXC54U+49FNQ4q?=
 =?us-ascii?Q?/rnFl9cqHlnWuPfIstW4/G+b+gTE+AXkEvZwtXzmQTm/a3p13hlbl2JAd86e?=
 =?us-ascii?Q?O1yhgHCavB20tiT/Zj28B21PaYqTV7SthHu3PlZXxo+lKNW2IhC+nbT5m8uY?=
 =?us-ascii?Q?taa05qCPy/tM1bnqorBdJSVpYaoIMehcdE5zQGMebDBbdrnsdmZpExP+3fkK?=
 =?us-ascii?Q?SmBxlPUcDHW4f0Msaha1GLz7a3WLPwvLbQ34D5y2R2KnevOUM8hvIoGkH8pL?=
 =?us-ascii?Q?10qjcaJmc2ZaIzgNoYLpsxgDPyRlsikFzFTm0roX313ZtDhwXaOS7oppkKJ7?=
 =?us-ascii?Q?I3oY4Jr6pW+AwOsgU8SzSmVPnycUep8c9PqvyykI1BvJJ8/qGDuCr34HBEJ5?=
 =?us-ascii?Q?u38TD9AP5lljlRVQ/fSGGi2csZtgoFZF9gvO+xOc9WAE9uus4YVKVU2Ir9HV?=
 =?us-ascii?Q?HmB1nggM+kccb8zYQLktnvVDH0qzui63PwUxwhn/tHtc9bYykC4rDg0PzXdO?=
 =?us-ascii?Q?3T/codDWUvZkZLMN2wxkv1h9YUbGJo0KVhsM+/vYgW+i/aZ01uWF3NlvONIF?=
 =?us-ascii?Q?CmK+NRk/TBO9QOGkTRCjUQNgEKLcVlx2cFaPmuIsWva+CMmI/xUEmNgiB4Cu?=
 =?us-ascii?Q?aZyX4wcWmuCtR611kcPDHgQR2Mn0wxDPleluFd2w32Axbf4p47jyuOPF9WKA?=
 =?us-ascii?Q?Yz5YkpFO0IRtuhzTjBoJqzFJffrwWdQrGk19nUuG9k/Luw3McvUygjM2vgyr?=
 =?us-ascii?Q?Dm+cocmaTFguryw5wSTqQHNJD91UnIOsOJCnJAs5fFcpTFRzro21vsVBPF4E?=
 =?us-ascii?Q?CRBx03t3kHM0XMTJCXJwJeYYagaeHJ/BYNxyky4mryvNU7WsCXU5ZlMBwx8N?=
 =?us-ascii?Q?GJ6kkVS8QF9EbVra0ypcZwReEL+ttSCNrheeL9WXUdaTJppi70KL+D3vZ/NL?=
 =?us-ascii?Q?FQoKY0taPTn4+XX70K/mOSE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e27360-e2ab-4439-9460-08d9d74865f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:26:59.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ywaq/7P7sSNskPAXs3TdaFm8WQnzeSV6b/ncPT3DjemodGX9Yf/E2gZdb/YGGNJlVLM5Mq7SHe3Z/KH5sNr5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl set ip flags nofullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..9b6db9d77223 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -709,7 +709,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-				else if (strcmp(tok, "nobackup"))
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (strcmp(tok, "nobackup") &&
+					 strcmp(tok, "nofullmesh"))
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
--=20
2.31.1

