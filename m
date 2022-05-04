Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1617C9
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651625297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ew/VUYamN2a5DlKzUOna2Ag9BRMZpqMSVG/HZpgPK2I=;
	b=m9AFS7vW8VJUJnhVRH/9KjCbaDtzO8XP5ELOauJF0GZ/qDH27uo29FCVr8NMfACNzWRQNb
	Qsl5knWogVuyBTskEaPsrEXG0H89Ttt+oVEAs3W6cFYHm6gdi9QFGUWKmyJjI9rNvAeL0x
	lyNq838e9GRlYGlBaLtRCsNgAcTB/Nk=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-6hOIGIyxPSmo07tJsLwieg-1; Wed, 04 May 2022 02:48:16 +0200
X-MC-Unique: 6hOIGIyxPSmo07tJsLwieg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5nkGuBUqP2+vBhoULukECZ9JGRc01KJqQCWNAczOe+1FXcW5fO8pMbsByGOHAwzbEeLnuYu9Chzzco2KFCpxtITaqbxrHvUmZdsjWURSFt0qkUoO6Ukb2qDlKbK+0KFJPgcZETnXGRvYm2de6aW5/OFzCXtsk1vkkMhiBHJwTcoM1+rY+T7+p8r0WCdlgW4X5cZJHJtfSMtI3Z+fuKABZzj7G/2MYiUcDcNkHNZe0JJlBqMaVJ/F2Ng/9dhODCeZ/AsEzCxc9jpclqHW8U+9fj5oTQh7glUn9jMCNW/nostdg+GCYq1EJv9cSUT8gV/yvTUVeIbObmUi08HFDgdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir+cZ8Zh0VitG8sQW0GbTRsDaKWP6XIJA5kri9WrkbU=;
 b=WaLQUlJCTKcNxgQQzCwLL6aliKHjt2hFbJWr1J2vM5BQ+7K2JkaTRa4vQHjgfXae3UeVAPcpb0ytkGOceARbt771znMr9IZWjezPoXIIfSUang0+wR4sSDUjzeRTuKgVFDwuFseIRS/G3UIkdDNQ2qq+4EkvTx1aMk/pWkZ1B3TVoi1KhgFPQ4c1S3LROw9Wgso7QENNTSJ6b6bhLfVhIN+2qANYPh8hjj/TvOakPiKB7iK4qJrwiotez9/tUsXaq0g2G28SblvlEf3gH6weL5gaoDOFFWCnHS/GQz4TMOStXzEtbZeBM8KmiNpiZZFZWoS4fYmgL5dLcO5CdbjiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 00:48:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:48:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: bpf: add bpf_rr test v11"
Date: Wed,  4 May 2022 08:48:09 +0800
Message-ID: <53d647be06e5ae276e124efe10f68e6a355d13de.1651625218.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d750629d-f17d-4d1a-83cc-08da2d67c5d1
X-MS-TrafficTypeDiagnostic: AM9PR04MB8384:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8384F2B0F31E0841CBAB242EF8C39@AM9PR04MB8384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9UCikx5lC+AJmSAoGQ7chvQ1lPNYjIPMVEYpUsZghU4QWDRSuSwRjB64uyShb4gvx65f4360Ex2Xm8vv2BBijyBFkOtAryBGYDfOl4f6AidbfyPap69QKBKYOTn896GcHcs8gazUPoEACUgY6UWdUdUCRHqFQt/oq8CXZfbyemSJmIFxM9H23lsQMEeb49M35zB/mkAc8MduetepBu+TeGngPAf3SICi2Ly1kxWkIXC+ZTSmFhLurr38bWFGVHr18Wpr9n3SQZmdf9xHCObYgzF5ito5w00+KyVIddZ7Em+haKaU/wTqLabnT7P076Uhub/EhcwHrzlDUIhMUPaaFio+Kh96w++Q4icbzxXWkk3hSCwBkZhdvyispJjAbCYKMJWSonLGvTEk3bP/x9ZCFxNBp0wPOfTeZciBU+K6pP0nkoU97P2ML/Rb3IzD1zflrBxN2tJcL3ACVUpBNYi+JBCPe4vnvSI6WlUH/pEpSVA+uIYl5P9xcRyZejWK7eqYZ/jMF7H+oc8TF4elo9a/cL9yG6aVk4ehZRuEAe3VpWsxlYbcaVUKmqMnSVzsoPj59JN+AyhIJqXkbSsxpgT45TwQ6UwVGH/VMIKsbQsZbgTZ8DjhsKfgJDgC6ePjbbJZ0a3iSL42NiwGqfcTVnUbFz2PLvcUWWxScRbQF/leGs9HICIAdn3mhJ5y9Nfga/NX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(8676002)(4326008)(44832011)(36756003)(6486002)(86362001)(66476007)(2906002)(6666004)(66556008)(66946007)(5660300002)(8936002)(508600001)(2616005)(186003)(6506007)(26005)(107886003)(83380400001)(6512007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6it0gyi5zhazcWEpc/88RDccla+sOS/c0MJ4K0YBl5K7rJ5VN0p+aGvo+x4X?=
 =?us-ascii?Q?RSrXlIqjbvJQorI9IY157dz6nroscODGL2htdo2YLIYCESm1KT7xDCN65VqS?=
 =?us-ascii?Q?OiQlfqodthLCIPaz5lPC7c5HGBrQXjtR7zU8+ZtBVZneUcw/qFGVARgqr2Id?=
 =?us-ascii?Q?T/7cZ4cWFfb/tjdyKtckxYCBUJbmh61w607G2Wslv5miw9qTUIUZn0a5qBbb?=
 =?us-ascii?Q?8B+WZ6Lc1By6LHBxCrqNQtl8lbTyiKcA4OFK03b4Vy+YO8fg+U4tUj2GudZQ?=
 =?us-ascii?Q?j6dd9Ua5XYN2q1Xy891x6OFbr6Cx/eL65wBthc9yDiYmkwkmZvKZZvjxv4S6?=
 =?us-ascii?Q?29re5RtNYab5/2B8BXLzc5eg5rY/KCZxKpn3HxAAupeWUmHBHbvgZIuE5aVV?=
 =?us-ascii?Q?jxcm3qfSngg13IB/Voj2+EW3zXMOJOATFYPVgNWHkKvKPdQJCVFv28eiUMnr?=
 =?us-ascii?Q?s++XVchruJ3oJt1sbhwjix8Jx3tTca/3cNxdvTxSZlb93GOGsNeVGcviJPuR?=
 =?us-ascii?Q?2FM2wc3C05sMZgb+TPsmz2vbjeDX77NGJgorWxMRbFyl3yIDkaHMAuQsXfVO?=
 =?us-ascii?Q?qIna6VENwANLOS85JOszHPh1DtrnbeHj4D8X6ygN2CHWubX59HbOvROObuG/?=
 =?us-ascii?Q?KR4cvE/Nvb+w/P7U3tuqlNkSZ8Mapn9RA5jK+OadeOMWJGOhZ+g+nsSGKJcL?=
 =?us-ascii?Q?oD/+RwwnRyC6L914y7Fu30V3Nzm8XRca0dxYMzs8mqcO4fE46VD8GmrMMijz?=
 =?us-ascii?Q?8tntrsYxfPKF7pgc0RmZi3sqMBtE0GWJ1gC2Y4pJcLVCdyCwzeAXawbNKoEu?=
 =?us-ascii?Q?+UY5KS9mLEjs5NSVddzx4Q8UZCVUA57mkGOu6Gy4pBN2MEnuxe5PdiCks/9T?=
 =?us-ascii?Q?N4aGp0rU/KzzqwtvkcOGeXJxS6ohmN8iMPcxp3eCIs/UbaSv23WuUlUnDVnB?=
 =?us-ascii?Q?AgzmzenSmoXNhwVMoiYF+PtI5O3vkxEUHsf7VdP5SVIZeegk8H63B0ISb71Q?=
 =?us-ascii?Q?pQD54vBSe/oPJsC5hpNbPEJnLs5UzS6zvhLMKw/ozziw/CAv7NwiXZ2epDwd?=
 =?us-ascii?Q?SvjdXRm6lF57l93rDwOLChelQPN5r35MTTWSKLKPC965IARrxOrwlp1KSbUa?=
 =?us-ascii?Q?Y10ZuEK5EcFBXP07BIzqe6dGxKodqBVNN7eFOwhmw4yuXYCBIGHpB7dhrpkC?=
 =?us-ascii?Q?0KSJWGv1PX9q30RilE1YaDLbbsX+hqgVa1+FWABPCSJXLBCUfu0Fwzitr+On?=
 =?us-ascii?Q?vhbg6BKTEPIQz0+BhW3NFNnz8b1HV20g3hzhsHYfD4cl15R1jtq/Q+PWvfVw?=
 =?us-ascii?Q?0XbQSjdQOaJWPyqOKiifxH0YNN6NKC6+5a22bp9loMRW3Sv4uPDdHIoe6T77?=
 =?us-ascii?Q?sXKXu5xVFnt47b9k9UtMzuMZ+/aW0nH8vK3wuSH/0RxCGgeeeIFjy/I6CqiW?=
 =?us-ascii?Q?i70bX3IVIKhf/4PXRU1HW+q8ZAtOG33K0mJAwotLokSv2G3Eh2Wl8Gfx47Hv?=
 =?us-ascii?Q?ppSwQW1xhf9Rmt7lVvBIIqcz/0RiQabxRrgPmUToXBLhhXSHseXWUzT3lP9q?=
 =?us-ascii?Q?6cEpFF4h86tF9S5LZZwKAyFAPME5TGY42T5uwS25t6Tl+/HHOOV0iG01V9XB?=
 =?us-ascii?Q?i1bmuQToTuR4o9YNDELJzDwIlrYLQrjQ/mssE3ugBi2l5Ol0eT7rK+oW9vPt?=
 =?us-ascii?Q?TOfhvukT47ZN1aqWQ7/TWUfG8D1PD+0bjf5pW/DJLUzuQxzSM3v+77OnCP/0?=
 =?us-ascii?Q?wUMjbFTEv9wXVQ3Vyz7PVmtoUlIeK0Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d750629d-f17d-4d1a-83cc-08da2d67c5d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 00:48:15.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KmdzZsSqprbxJ7slIkEmss/34NUJcGLzGal3a7CP/WJL604JVQQEwMecaL64vx35RsxafTFXzh+Qz/PJNv6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384

Some cleanups:

- Make the sysctl command working with busybox too.

- Set scheduler to default after test.

- Fix the checkpatch.pl warning:
WARNING: Avoid line continuations in quoted strings
+	system("ip link add veth1 type veth; \

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 0768eb850b6c..cc65e9afb796 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -393,11 +393,11 @@ static void test_rr(void)
 		return;
 	}
=20
-	system("ip link add veth1 type veth; \
-		ip addr add 10.0.1.1/24 dev veth1; \
-		ip link set veth1 up");
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
 	system("ip mptcp endpoint add 10.0.1.1 subflow");
-	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
=20
@@ -405,6 +405,7 @@ static void test_rr(void)
=20
 	close(client_fd);
 	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
 	system("ip mptcp endpoint flush");
 	system("ip link del veth1");
 	bpf_link__destroy(link);
--=20
2.34.1

