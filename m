Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0E2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1cnhmfvOg1lGapreID3J2bgUAhluk3TVZnCBFXpbmQ=;
	b=kJJIjbPgqkIC3xTx1X84sOiq4OW1zGgFyIipIiliMA1/kwGv0UlVJWuxkUPgkGzJWNEdkO
	9zTTkOXZYPU5b0UqT63wYcSo4laGlGHT+/EQMorZYm140NfQoOlUMPfWH4Ust3efZWBgys
	peh55X4DuKXForL2xwf9H0oyrVdWYTw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-vxzPnkScPg-jyQ9w2tQfdg-1; Wed, 09 Feb 2022 09:57:37 +0100
X-MC-Unique: vxzPnkScPg-jyQ9w2tQfdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxw0S9G8GZ2ogH7S+dO/PRt7/4saLhgtsj6DLsvM/nCjT413rIMVlFoxi9NDPhgojvNVcsG8Hjdjw30ApCxSED9hW/DPURtAxVvcZkVVcOHA9S5dxoSSL9PN1n5jBLJwKYtdyTHEwFi2ywYxBsPRWOsOEIHadqX5z63iEqNpHWTDuflnBb7k2Q7EsJoK4gSaPhWKqXKKCjBehiboEFsScnzSm21xAJSVvBav0WLRPPg/TqIY39AbOPhgCQKSgbJtYIGG4W5h2LVtss0ghHkGZ6MwcBQB1GpP9Hsi/eMKgo73ff5bJfFPJ8G6t7LFUTylSg3Amxd0tHEmc9429ipGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llTAtFlYKBFVPMj2ywwSufNYjArxy/q7XOS0f5KZK5o=;
 b=gCxI+yvRjfszuuwgUDJTvV/St5FcvrmJsdIzOyrgOLAx30B71668sBg2aZCdofhfxps0nDKokNG0BF9t7e319WJLlP4+tSRWvVFI7xKflsM0iMIN/fDreiQXXPIrcqbJOfPMvfu6pYmgIaUu5XhpC9Vgm+TZFnLRHueN7bijWRSwBgUcOe/oUCUzTBBFUEQ4OYFIhOrPYu4ICBufA3F1ZBJT7Ng1CY1+i2vU7+buQeOjSnoCL3NNWt3vXU6y3V16CHw8BVpIZ4knKyGbfaiHBSgxwswgaOGfIyRcvaKTQn53O40njxE1+rkukH9Eq3ICQa+xRqP8db7Y0OiY/Ui3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2961.eurprd04.prod.outlook.com (2603:10a6:206:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 08:57:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/5] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Wed,  9 Feb 2022 16:57:38 +0800
Message-ID: <d133ed1ceac1bd9ba3b55c9b9601cb3d01b6d7bb.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644396927.git.geliang.tang@suse.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8584d6a-9ffb-4a18-9c19-08d9ebaa3791
X-MS-TrafficTypeDiagnostic: AM5PR04MB2961:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB29610C2C25FFD438F7E37F00F82E9@AM5PR04MB2961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WYvp6lsh0hyX9FmWOPEKeHputVcpA6R5KHCywYmwtbEZz9WSuNYBTaYYSratADh4u9ok+xeLoBATtYHd9RFhVPzKxJ+sVvS54P382/8xXd0C7zGE4FbKBm+KK7FlEg2ORVHmi6Vw8Xi9tNAQjgRSKAWHPa/mS7Yieyc/uN6h7oQ1qvcDN4Z74XJPnQbZGgUYuY+YmZnkeoPrkHvLfCc25tuM702a1KuoDg1RtynJVK1xSgWZx+y7IzCwDqybC3Tuq/bWqkLCIBfvi9YF2BeS4MiP/CJS7IMiD+4ty5G8aqagQ4210RvEJ8SHLntXs8tv1qeiHJE88gR2MyFNSebVmuSSpAkbFgO0kGnia3YqLuK4mNuKY1GdCdUV4joAc0Nj2FeS8ifdNRsVhKQFRe2tJx0mzHE+RqSl+zofDotBrnaZoVEQGnHAarSjh5BUy3csCR28q0Z1rqXXL3E6cQ7b2DVfJPkjRhxx3NL5qQRtphyMtYGGEArTzKW4kc8Q1VWCnewRGqgy5PUlZeYG4hZ8J4HluAlmuesIvIoSGer/J6Akm/kWStPrn0vFI3Q5seRRc8uSlgQWE6E6g2gDy/5KQYSeXWTz7Ug0D30Gi8TVGyt2S/ypGhmgh0fMoGilMKyBvNb2N7YpkZLuxo2us6HGvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(8936002)(66476007)(4326008)(508600001)(38100700002)(55236004)(2906002)(66946007)(6486002)(8676002)(66556008)(36756003)(83380400001)(186003)(26005)(107886003)(2616005)(6916009)(44832011)(6512007)(5660300002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkKWHEUL/nmjkAqYPZi89pF+RFovVfZ1LY8rwJF2MdIdB/Ux97uI7Uhf5EVs?=
 =?us-ascii?Q?1pwW+P+elRTk4xSxGfXRcaDgPRWDtYhpE2gg7wNvB4oOyhkLvsilH0uFlSF4?=
 =?us-ascii?Q?bodyUhQIUW5dc9OUtsnibZxWYwvsYaLM2rvlJvrZwdNqxaBWW/8/N2q/nvQU?=
 =?us-ascii?Q?RSi2ixYxqhcUscJ9sL9pj28DwSDDs0XkxolqaxlvVlJRElhteLHK7LLhLrO3?=
 =?us-ascii?Q?mufo8xWgJgsuzwJs+M6rxcqjS42tNHXw6/24VV8Php+pg3rfz1kwLcg0IWHf?=
 =?us-ascii?Q?/9nPqO+Fa/sINqpa3CD0/oxgo4oxVcOX0//5ahB4azzh2qp2+U4RKd9JPrmg?=
 =?us-ascii?Q?XVAjbMOgNVd5Pv7AQq6/cY9h62fh/ccmC1FAOv4QY665HjcTBaJWKb7F71tD?=
 =?us-ascii?Q?XnRjF+HHrl2dkABiOTsYjPXBgCp7MXYXk0BoL1HbeNoDvN1nXr98l0UAd4YI?=
 =?us-ascii?Q?0AZZ7D76xXoCqULOn9TqrPh1dTbAXlwe3ZYymMH52Tvn9csS8bjWBCDSQhT3?=
 =?us-ascii?Q?O5wcghpGa3k1SSircomgzDv8OT/Q9iFeQDgcGcrrDL1RuEZW3gJZBp0mmEAb?=
 =?us-ascii?Q?v7o/gfQdIbGmnHOHMkyuXo/SdVqFxUEd7d5hVfhIPGFUh8VS1G/PXkZpGsow?=
 =?us-ascii?Q?KUMkgURGRW4RvcGGx0nq5OWwccpJ2Dq9FuVbmZfnL/h1lbDRAkyWXSNibGhG?=
 =?us-ascii?Q?FgVCyLO03v41wmciUR/gDrM8lSOwnJsKir8AkGVb32VcENLhHpcgZ+o/bEal?=
 =?us-ascii?Q?+GpeMxMokdUXex1T20420EXhg5xLIkA/NfWYv/1NbIYdLvLmlsTqqIX8CQO7?=
 =?us-ascii?Q?n2ZuaPELM0oN2z3suw96yyHCHZN9F7ddwudCgtLjuQTKcQuoB4w7ah7/5Zke?=
 =?us-ascii?Q?elyekZmFdK75J3ZlDw5qJBJPy/Fu8BzwijjLgrXqLyxs7fkxcs5GCcnwz+b/?=
 =?us-ascii?Q?Xgt/j7wOwL+RNdDwxklAzSzj0bM4Jqafz3c8zJpMpikjKwyMWl4GIwwoYbvK?=
 =?us-ascii?Q?Hk63iRoxbp1KFshcTlFR8lSqqZ+q4NSHXkDKmuxoG7Lw+uYifEfeANGALW5u?=
 =?us-ascii?Q?unVw8RNZRoHyHJUAhO7cjXYY1clpHLoI5hHiA7/pyW7w9TQnSxM4/PSJRniW?=
 =?us-ascii?Q?Yvn5Az8MN3ZQ8L96nO7UIbCWERCqiUci9cffUFRuPqVtmrpmPAcD4Z7MluXn?=
 =?us-ascii?Q?lJCCt+rJrD2ZhfSbrXolG44De1UEl0+wedReAz04v8l56yowAmada1txbmhl?=
 =?us-ascii?Q?rht8y4/Xf8KRPVnQ3JawxFNw4ReiAXAfjuSoAsRW9x2dSDUKN2y11ItCUTDz?=
 =?us-ascii?Q?pYkPLy3jUq+3zHM9E3aAgz26kT1HRhfMWcj8Yy6X1b2sfQ2o3QpsjF8jdi2u?=
 =?us-ascii?Q?O27brGO0akSnFBnE1nzxlUD5dMsRzhkv8hDiKqCCZP1DpXF/eOHpNBGtMslv?=
 =?us-ascii?Q?DYntV4tKAti46XAKB31MYeC9nccQ1RIcnT7KGgo0E37/YNBbIG2p6C4I0rc4?=
 =?us-ascii?Q?mGF6s0rosPHFMFQb3fvCVjVvL5flE7v09TyGppiH5qYsSaM1ZY+QhKcAMHGv?=
 =?us-ascii?Q?PxZD2NXqgmsrLnezPDWkeYaOPW1+ZZP5b5W/VXXzrJDBAb609yevBUYbd8RK?=
 =?us-ascii?Q?TjB05t0dAmchEBuUTyU6GrI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8584d6a-9ffb-4a18-9c19-08d9ebaa3791
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:36.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR9yjUkO++Ni43kvewVZKDP8t5s1C4OMpVZc/vBiPfQbDh9WzmN3xpYnrYuzbEEgQXZNYbbU6oT/3Aa+THfCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2961

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 90a6adc36490..3577716cd5e6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -784,27 +784,27 @@ chk_fail_nr()
=20
 chk_infi_nr()
 {
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
+	local infi_tx=3D$1
+	local infi_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - irx   "
+	echo -n " - infirx"
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
--=20
2.34.1

