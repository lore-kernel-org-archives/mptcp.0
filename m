Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A891B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f76RwFKA5b8Bwp0PUQTNxsNuvx+bwEcYBtw6HMHVNYg=;
	b=UYV52W7jz/bBf0d0u+e7AySTEiuzUbXBW6iEMPkEXIWsxlBypxit7jaS71XjIGnhJGyXjQ
	o/O6W2oOzWNYNjLksRrnkcp7LhQvyf9a1bkvihSeFk7/Mi0khddz5QMRE+ROltrkgp8Po6
	CI+v+xXRVEa8rSoCZyrjgF8VRQN871c=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-Zxocy9aAPoqhlEizFmOIsQ-1; Tue, 15 Mar 2022 07:59:05 +0100
X-MC-Unique: Zxocy9aAPoqhlEizFmOIsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlWJdL6Vp3YZy1s2a/g+iVNTBzpA6lI84vTqADZkAclKNhAmsZnZLI/YjfCZEch11+3asYMuJoHq3iGdHNflSrB8VlGLifdmkbH/IlLPEGG7ix8KU+N92xsFdOphgHEDUrHP7tQ/YGAxhzTqNj2LNh7zwuIsWTdLcjABvxLvgy7Hk/h+qsDQYatayra+jfb+HT1blAr1XemuHrHMTaDuCG0AqcKqTjnqKD3Ow8iat4DrqDOcQIh2P72pcju2HZMCPZZw4NVdDsHRhw4J20sYv98bZhxZ4SzFJmv7Yn8K0p5mGXleV7hb+TENHo/PAl90ZEXKYmiElwUOoBQseYJCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU1mCqPs4Vw4kAL2cPM5Yvxj80ihZXnk3ObKZFUzFZI=;
 b=g0j0XJaZNLbCv2/3I5Mnn13my4f8PzpRJLqRfbcjit85zpjHILFYRYuvgwA4b++nmjOAxgaQeheYULEZVh9xxGK7dDVcbISoNmNFdYrKSAgxm2TWpdsmTfQV5bZL2dJvKoUZgMuYHlKHcl2Expo8xwrtqAo8u9gdjNh8XuLVNdv2slN66xShaqNEKgVsd3X1UwTdk/neOhwYO6iJms+NWLw5CaQ8HSKVrTd2pj7Yesxkg7x+UlraugaZrNNVqzpg5m8tLsN/2dhe3QZn7Mmkk4snwFCCdzSF86470SuYoFX5z+jICH1G4q3jYL98XVYfeOMZOf9byhXZ8HNn6hIMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:59:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:59:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/6] selftests: mptcp: check MP_FAIL response mibs
Date: Tue, 15 Mar 2022 14:58:25 +0800
Message-ID: <240eb41a0d8773685a552ba5950ae8198ee11e5f.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94962a4-ba49-467d-6e98-08da06514b0b
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB313810052F27F42EEE5BD771F8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPu7z2KR/djxd4fnklBOxTa4QM2wR6SfMl8guUo7LX4I7unEGFjpcdVsNbGcZ4cn/YJtl0Joh8yyhrWs2LAgPJ41LwNnauC4nYe1WPy9WUUDChisEbs8kGgym0eMHD6DGDI0RSr/2hwmpzRxfOX4hxDyp/XJcGMJolgJka6nq7BaP4Titd2x9Y7RaHd11rV3ixbO5RcJxJcs9BU+DuiEkM78sOCEtSU6c3yjkWy7SFb+fecXq3l79Fp17RXk/k/a1ngj6pKjLm490Uq0EGXKV/BaD2DNpx4mYJfu5Y/vBWixCiCDISd6SMQdd+UiIEjdui00XFechyQa7xyyGNRGGql83GmagValVTgRLzOIZBseBjq1F4MHV0Xef1fA69QNVJLUrAsOxGOk9nOoT9Q7t+5pMx5sbf42Y8KUKm2CcHGs92hXPAxjTulYteT7Ol1X6HfCrS4l3PsIaDr30O4j4LEZOZPU2eDxBhTt2h4pfzd9/Qkbu0zQp046/C/Ngi2J4L+nYd06W9VHLgriEil9hJtIu+HYAg8p3XWN7z1dC3Za4XXke4O0zo9Roym46NvNFFLRAO3RPa6sCOaKUmnM38NvIcUbDYXjRipSIihl8fssHaltX3snnAlEEPnA0AFMhdqkixWZnB1MYrKLS6292g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYgvRbgk93UAA7bT4xLczWa6/yN78t8kJGy1/KwmtXP27NMUAjxUr32iiBgk?=
 =?us-ascii?Q?nLyUxsz7Nrkpo1lyUItrOsauiPWk8fsTtexXkEhm8n0wb2CLkbUh7Omb+I+G?=
 =?us-ascii?Q?QMikidtijM7vi3eaN6edG/Wfnhe7O52dpqQSZwHR7OCk4XNb+ehKCDO+Gfho?=
 =?us-ascii?Q?ZhCQ4AJlrh0qz39iyreUDzJg64qncrLzwGx3ElsgM2T9SpiFNz7vqaSQ+aX2?=
 =?us-ascii?Q?3Nf0ilzoz2cssOKTR/uzPUlTPQPYiVgRv3cofIKuDJZFKFHdfLxPEahuMIo4?=
 =?us-ascii?Q?EnXmx+nuolnc8hOCnVidPEDDc0yroRbYndbPkeaOlQ/dstBOMb9qMvXlWVKD?=
 =?us-ascii?Q?XJTTteEwFq9lCnZrC9g6MIKPHvVUXdaUrZqjPT9GNbuxABnN5hhQyBexvPku?=
 =?us-ascii?Q?l7NJe1lmTpFS9EFA+cLYbK1N5g46XH/Bni3YsZHsr92/ogPJTGyBKHGevr3B?=
 =?us-ascii?Q?3Iw8FISuWbtV/UwygvU6Qemj/kC6SNB818fnP3KEFbnCIuj918jXSXTOiwwN?=
 =?us-ascii?Q?77+6V/bFHscr6Rqs8fo/hKNGtjof68+Bvzo2XFrsWAs2sVjiwu52/ZzyW12Q?=
 =?us-ascii?Q?sm65vpD1mC3Mkh4ZFX0WV0XKFfR0PVXjrBc3lRZt5cuUPROetJ6sy62EKN4k?=
 =?us-ascii?Q?FpBq2j8rEKxCYO55+lbw2bZORZZi6z8+K4Zx0cNN/EP4KtOo1+WWHT3z9iK6?=
 =?us-ascii?Q?LEPi67LmYkZvQNvdIEQSNrdAnFbt9fL4eA530T8Vho2NcGHK7wKSSDUEXACK?=
 =?us-ascii?Q?EE0jB88/+DX0uoOIuataCt3FT6QcJG+VHlI+768lFb+rItyLkuv4pC4bsJqr?=
 =?us-ascii?Q?bOZFVdNOcMNqfk7v0Tf/xjL/PXFIELG240fZKnQLU6U+zj52uO9v5ZZX83G3?=
 =?us-ascii?Q?5zd4u2hIWl8yi/CaMEuu6CNMY5h3UMrDcqMLkxxD5KQ6Hbfr5GouCJdoucDA?=
 =?us-ascii?Q?6UVTBcgtUTAz3HbsMI0zIqZyI2MP0SpJ5mbKLnrMvqUMjL7MeyV+rWpFpCgR?=
 =?us-ascii?Q?dnIp0e6m18jhknGF3f38mXJH9K46DIwOjI9sXK4NYWW1eAOYGKOR0wmuNoWb?=
 =?us-ascii?Q?xmkP7YnJmN6WLLYyGGepmo8eVBcayH9fk/Of9GKuImyLhZWLTnzajL3sXzgt?=
 =?us-ascii?Q?3Na4+XFZyBvqb9AezJIWrhmkSlp+D6Eud92v2ydM02Wawme6vJYN3CDIXbCu?=
 =?us-ascii?Q?aEmCsWERT/7X60nqHrfurbMSccLf+FCZPgZIQ9YWe7T4Q8kNE3J8Njk9Wk/c?=
 =?us-ascii?Q?WOCA8ZAMcBzs2r1jG2yvWs3YFNyD8duIP1J+wApzJTiwFS7TY/dndbx5NuNU?=
 =?us-ascii?Q?IxKDljfcpCGibT3uX5eJXeogAq8jp1CHqkS0iI2xE4R0yLiXHjLAaJ1pRVUN?=
 =?us-ascii?Q?FW9Gq4kiV1ft3VG+TIL8WskDiszrO69+8ufDYgUb6VnGV7eol8ic2+P/QaPm?=
 =?us-ascii?Q?+mT1DaosijQLfcNbLksEabi7KBMZmY5Qcn//Vji1pslpOwSTUCC4pSaO3eDc?=
 =?us-ascii?Q?IKLwE5ThPruJGX0g2f4E02UW+akAz1ZbKtG84D+Q5/DaFj/Ra6LDrCpoqQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94962a4-ba49-467d-6e98-08da06514b0b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:59:05.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmyFz4/qCn7iNoL69MEFqoa/DCseVTm27W+ntaSKn8ZIm9i84i0xhskicHQHrPy1Bp9KK/aYif4s7KUYY+dLpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

This patch extended chk_fail_nr to check the MP_FAIL response mibs.

Added a new argument invert for chk_fail_nr to allow it can check the
MP_FAIL TX and RX mibs from the opposite direction.

When the infinite map was received before the MP_FAIL response, the
response will be lost. A '-' can be added into fail_tx or fail_rx to
represent that MP_FAIL response TX or RX can be lost when doing the
checks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 959e46122a84..2b77576d773c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1055,13 +1055,38 @@ chk_fail_nr()
 {
 	local fail_tx=3D$1
 	local fail_rx=3D$2
+	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
+	local allow_tx_lost=3D0
+	local allow_rx_lost=3D0
+
+	if [[ $ns_invert =3D "invert" ]]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+		extra_msg=3D" invert"
+	fi
+
+	if [[ "${fail_tx}" =3D "-"* ]]; then
+		allow_tx_lost=3D1
+		fail_tx=3D${fail_tx:1}
+	fi
+	if [[ "${fail_rx}" =3D "-"* ]]; then
+		allow_rx_lost=3D1
+		fail_rx=3D${fail_rx:1}
+	fi
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fail_tx" ]; then
+		extra_msg=3D"$extra_msg,tx=3D$count"
+	fi
+	if { [ "$count" !=3D "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=3D1
@@ -1070,17 +1095,23 @@ chk_fail_nr()
 	fi
=20
 	echo -n " - failrx"
-	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fail_rx" ]; then
+		extra_msg=3D"$extra_msg,rx=3D$count"
+	fi
+	if { [ "$count" !=3D "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_fclose_nr()
@@ -2672,6 +2703,7 @@ fail_tests()
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		chk_fail_nr 1 -1 invert
 	fi
 }
=20
--=20
2.34.1

