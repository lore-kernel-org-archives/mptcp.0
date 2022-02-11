Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5D7F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcE04E/Kumip33cbkuKqno/Essi+LYAVbRQAhfFnzq0=;
	b=LoxwEtwX9Q6QQMsH4JmQwJnjrJseZt3cb6WEfSyE29gCD7OTfnZFgNXgBt3Dw3mizL4HXG
	4XHAsy3zO0kBBw4oPHTkyrY6yX0jqCGmT+CJ/2JP1Od/r04+G8R7ymvQ8n6KQa6iiCtCQl
	PWKqJ+Sx9DZKHX95JIbL7M3iTmHSmJQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-LNaQkOH_M5aNOkRb0ZS1lg-1; Fri, 11 Feb 2022 23:45:40 +0100
X-MC-Unique: LNaQkOH_M5aNOkRb0ZS1lg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnpyAq7t62yId6cDETT/gUJ+H4gLhalrU16gawNg5P6okfAbQ1mzeXG7Zr4b0F1vEX+F65xypowuq5XTEiil+HJRe0KB0TrU4T7jhRKDJsB9aGtwMDM8miVncZCB/YXGLTFg7QYVqIfMYJP0CpJZDkbOe1CKRvZkj8e7iduB6dvtULScTJh1Lg3/uoPtu2749fswkLYy3W0rnK5GkIYrIN3jo6qR/VAMoudqe9KpDymoEmPetjDfdb9XAtGP0L5xteJaI+z5EUGHbrVZ8X0uumuJpnESAuZnSVBNBnPespkSONJrQUTYZAPWnsj9LkfmtY/e05npQkNIwRDacqW9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGXB4Wk/EDNVmwBPVM6B8P+e1MIhJLamoTbyF8EpBqE=;
 b=Q6FeO5wPXUow3AciY4529U+0774TbonlOrQcnZVugPA7NAk/aH/WmZFHNXgJuG292tVJssqXM/GAbGzVAcBXYiCjJwADV5JSj3oyFl7G+MeUVmJyefpifMyTEjUZcC7PuTCq5ZSbij+4PyrBlx+nVyG5uBryblNo0QP3AVVMHYn+VKzH2AJDmbQk8SmNwkZCp3I0KqPBWqfhCS+Wi4MHzHQ1a8GbAUHAQkLerjN33kqFMDj2T0iuM4cda78G1dRC2+y4jl12o0ot/uKaUMuZrZR4X0a8Em6tXj3cP95dtrBLeFCODWshU9RBJyJxiqfY6FinUhDeMHxVAeAOQLpAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:45:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:45:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 2/7] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Sat, 12 Feb 2022 06:45:38 +0800
Message-ID: <075df2856987fb4e276cf4308f2cd2b2df032c98.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d30ff6-ab6b-4819-5486-08d9edb03a0c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB565207322A45560F9ACC8E9AF8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OdlpDhFLZXcdZBr/Ih04rBfjssaecT5amotPaJeo/m/5kBNzst2uZ/atKYAZnLhBiBLvgZaBSIIYF2CXGDzrIkZD06e5XBWF8TXF67lvP1/fMB+Ikht1ia/WAFq0G1vbcK+BckCT1I1v4leCwpLHFcsSDG8dqQNTDhaE7CjiF70f67CxR3H2HMDBfsCQaze3LBritvj+NrZP01Pua7Mp5AcD5t5rctWjKvbhBPXCMGukQ6M7CNm6SDMMX4hovAqbvTYjzBbz3pXqdWtsQ4RrpnDrOn6o0a89CiUOD+e2PyBnifvxFS2OxWAvcDzJ0dcpmWj4BXokIxvpMpLHLcjVXTtp3QKASEaQhXPqcWpKpu4OJyl1324XRWqXjj596t8ul2XYtfiMPZ/6ZONETR/l4NDFGPcCBpSMPlwQT8JZa1XSAGWBvie9oHBYfy/TdzV9Iaorul4iDCV1DLS6a3vbMTdUyaW2j0Hz1+KPH9akHWtw7Aak6/KCLnxPGeH3abmrH0VptxUWgT4eVNx8Uen6fBjQoKez36T+sDgkfxtXz+wjL51xE/eX46o5V/1fxN3bXnSwrI0XOlT52pDRJonS3xFoqKt3pc45W7n0r2COpjlyiOfWaf0V9aiieJlHqJUjvdpfyreNY2JOKnh3QCZM+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xqWZGgZO80fhTOyGdadeXpqfqLfD18OsIrRJYEdyERUlHc22FF3ZUtWc0q2?=
 =?us-ascii?Q?JOREUUVFGXN3zuOspypsn6CQSUd6QAmYqHJucaBmmp2rtcESANa6KDIMsFmr?=
 =?us-ascii?Q?Bw0FBgQl4DQdyXcVASvxq7xmCCfZ84RFTnnYpU2MQu6EtX5q/rwMG+JSZL1l?=
 =?us-ascii?Q?BJd1liiQ9KsDRqyVOEgFSFCpy6+2Rp1PutLruhS+DRTG4ibjkQ90JrnJX9UC?=
 =?us-ascii?Q?J2Qam59qkDVQepa0HD7ZzYE2jryDIQmtZSXrUwgHZS2pTnjs7iVrxdxrz++o?=
 =?us-ascii?Q?O4L1vbQEcG8ASCXYAdA1lyvzfLl9yjyIF0uJDowlDy6GwBF6pg/LhDn5BKMS?=
 =?us-ascii?Q?PUdji3ryIXhDOoAsE7bjp0fbDn3rgQkFDB4LxOR8D/liOQMe8Ryvr7m3g13R?=
 =?us-ascii?Q?8vtXhP3jN3ZG214TJRlTzC25OBtOGRRJ6F8wAKfS1yfEtAt+JpPuM6ZmufNp?=
 =?us-ascii?Q?//zucuq3A98QQaXnYH03AUteywgOIxUBCfZGEG1868CBBqt8rJ7m4txYHnTn?=
 =?us-ascii?Q?vij26+i7l2MrCFyYmsbi4P3Sw1ALwv72PJmasFeO1h7JBaSDuQKKMS0Cd82Y?=
 =?us-ascii?Q?6tTPZRe6BN0KjL3+25oTP7K+IHY/pAmsZjYHU7nRpv4wSHZ1LmPtaAum7MIA?=
 =?us-ascii?Q?9CVXjBV1zMMNKOo+LX7PWDAp1V6S2DI6f4XaGWNB5vr5IYyoczS9fz2hpSsd?=
 =?us-ascii?Q?rNwx91Eh1dgefLKd0yxRF/Y8H7dBvOdPRgjk9V7YPjtHKzppssD42MGDTsG7?=
 =?us-ascii?Q?i86/s85a+xQIjRMKQXgWWpwdBFYVxZ7E87wWpBO6pugt7Y/RVHa0+hgsLd6w?=
 =?us-ascii?Q?V6/NODx4F4PTwy1PTNeo4EkA+AVZhvBs8B+n80G5JGHXA0Tu34Hokhg55OZJ?=
 =?us-ascii?Q?sja3YqDHqIQeVradY1jbEVIofryNTSQriFUjpKW5lCPpoZKzft+gxihxqVj2?=
 =?us-ascii?Q?eh8qwncLoOQJNRx8xhg++u3/cnGGGfCsIdFq0L3EIi+Nyp/ioXZ4HZt6vbNh?=
 =?us-ascii?Q?xyqy5DTPf8sQLfZ1lyt0TXraoA+0INyfSU/1I+LflpMAGq0yFYTsFbCfWsZ+?=
 =?us-ascii?Q?TfkKL/gFdAMNIVJsiY7zKmP/xYZ609c9eryAswiFoeyn4qKztdTaUMekRCAs?=
 =?us-ascii?Q?gDZowR2Eef0R5f0zGJY10ZbBNwdaMw47ewhRde0+burcnPoYa1vxaoicmnqP?=
 =?us-ascii?Q?EpfJT3TgR7/T/Nhtvctj+k5M81g6IkhofL4KJ0SOp4riWSTneQr2LNGUlNx6?=
 =?us-ascii?Q?A5wwlD7ScCBOs5ZeMvUhkwF8zZ2g8tD/Gqt+kauFbWtJxpEoYMm/DvSfTRz6?=
 =?us-ascii?Q?hdlA3uuQuCJZ1ejcFLr3LCORj/hF06ES18TH1SejY2pMvysAw6z51tDRfLLn?=
 =?us-ascii?Q?0pFBuHEAsdYruZBvQkc1rMNoFKBvbdJ3t7k3VnOLhDcOFtBQeIpDkTgoVDcl?=
 =?us-ascii?Q?C7aBjlAQHNiqnFUvAe7ekTH0ZlRNh3PoOTwpZL5Wwj9ZAveSmtS++z490v/P?=
 =?us-ascii?Q?uU1/FfqVY25VMMNEGT4JCY7GiZHdpWVpUC5uMkg+8AXFF9wSLdGIGu7FskOR?=
 =?us-ascii?Q?iNJqiXKPkd16/T5HU+zetLwVf2ICcF3nqfvqyM9hgHTS4A6Iwd2kXO8b3elY?=
 =?us-ascii?Q?6yhqT9numFweeHevF/6pvqgk01GeX6WE/HxHNoPg8Ptl60Ygu1c3L+cn9/TR?=
 =?us-ascii?Q?/2yNWsDbLWQ6GhRRfvRnWdaGo90=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d30ff6-ab6b-4819-5486-08d9edb03a0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:45:39.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKxhfU8YZVrqo4kj8yAe5RTsAmwitcj+GWlsl4V4Eb8tcq8LpyTg1j9TSyJTX3DjWRR5Wh8Rew33AQcMqzKVwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0b4bd2df2538..9b75569e423a 100755
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

