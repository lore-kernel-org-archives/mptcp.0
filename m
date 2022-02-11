Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827377D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqZy1pCMxuA5d4wa9OlaQ0s0oOQ3Adj4kZYqQUE9EKc=;
	b=EpoariUfi/alGiMAxhNPm+Xwvx3blUND3/SPvQjH6m0wCOqXDHZTNcm2uU82FxnPq+GERj
	tR43fcURNP1bYpjmde6AtHV1Muv06Zv+tiYu+AyiPUZqD4rpTETOd/teoyUDsUEZOXAlk2
	2wrKSetg/7GhF3+jdJNMo6Zo6NUtqgQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-R7JQHhMaOc2r1br6gJe1Pw-1; Fri, 11 Feb 2022 10:53:26 +0100
X-MC-Unique: R7JQHhMaOc2r1br6gJe1Pw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdxsEynZXtwV2WhmAX1F6OibMTgEo2Zgt9uoZFQv/kdAunMWgyQImvkud1T7LP67fmA+U136X1PrwIOKDci83xeoSzOtsry40iqi4bZO4RwH+txZ3CZDkgTBbi6VfKq2IHUljHSyfC3tsGyvZ9JGcec96mcnR+uofwyILXtNtul+XLdopjIw7FdFH/QgOkewiRqpglJgnLDjQgOKnYul+x9AtQD8NxCnwIE11VCVYzrA5k8uc94IXlQj5B6ry51OZTsWb8Z1yiCrRVQVw/eteDNf95Yip1RIYDkFx728LfZWUr8lmfq9izh6/D3NDBWjdv0JurUQdQhLuRW6rCKvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YnP/TB5HJbDUYaVYmP+KUC0ttDykthAT4dmIslx0yg=;
 b=PhFPEgj0algZlztyH2s0xvoFbWhChjThH8nUPZBfzsNH2i0DIMh9RFTHlxrklJJxf+rUxY//3iZ6KG1Ll23X3lWyhGJM7u87O9cw7EuuwKeonRFm/4Sw2w8hMnfsd7z2eMvQ3m1RJjRDD5F9PTnrrXTL82LmN285YC3+uhdGxVAjV13xhb6Dy9MWZwMCxg/B3nxdkMEorbi2rRTpQBroImH2Tro7dctMmgbptrJZqnQ1tCRLdXRAz7X6mMO0U4nJaFqNZ/x8DTOOQCpNW3jcgaCqWsIWf5UhcIxezY+c1hRbXvH1CMyaVSkraurPg6BT+F7Wh3gUknPmiPs3jp9QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 09:53:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 5/7] selftests: mptcp: add more arguments for chk_join_nr
Date: Fri, 11 Feb 2022 17:53:03 +0800
Message-ID: <ea2c637dee8a9089b2f6c01fac0e3e38f33de0db.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552f88ed-0a28-441a-4b97-08d9ed4458c6
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7878581CF57EF09D90F07508F8309@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YdGolvcfgA6044jpsaOIC8bk+AvrwuKaLy0jJINBquxrINjve1oG5WLIA6gAv4i1oPxDDEl5Cfag/MOXg0D/flIeLcBzEAD+Ag13ED8hHh/lKSU+8lugn1SuUS/P0rZGHfxH07mCuAM9AdZtSXCiQT4C9meAE1+NDqr6niegSnln6JaraYz4s7KkQDkLCDusdWD/baOdoeskIyqaF3TgJHhniDP/kvLfcrh7jKRqoAFzUU+CI6/dLp7h90BcHyfta0YDzSzI56ME8jW0daf6m+wuUF+IVWiN1WQlA3U6WBCC9m91+GB/gFZ7LjZm/V0+xxZGcVNXov0+WLji2BsrYB+aBacon5Ti6V2aOss9TQ9t0HoIP9BE/HWdocFFXhoJVVEhcKhvFuYZWOBBJ0eQLDoN5jEkQD82Acx9OgSoSnWd/E8DuFno+tW5eTibbuXaQvMjDJ+yMFJ6x9AkAjWFTZ/wBc8P19s7/Fpt+Yt3VBaKgCwvBRkInGiVqx9BU/t01u2oTiOoMFuujhFlbYeXPptEloUUbGqHoPlrr/dXiMvDoTon/G05cgdLaG7CxSbfgb7/yJk1HdwULuJfum6KIZ/+qH4K/+Z2hiRPmHByfYNAcIPpo+94ZT5QqwbZkqwKOhqpVUU1I1IDguuEnSZQNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(66476007)(66946007)(6916009)(508600001)(38100700002)(8936002)(66556008)(6486002)(4326008)(6506007)(36756003)(6512007)(2906002)(55236004)(6666004)(86362001)(83380400001)(107886003)(5660300002)(8676002)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNbMy4Lb1Lv1uWBEuPY7U6YUA1GCV5/N0uD75OfrMAEI/d5iq1659CZbaf6K?=
 =?us-ascii?Q?a/LsslU6j39ALkArs9Xlo2BlouiI2oNzULuW8kdMOwZ6Dc8FRHs5/mdgIwUP?=
 =?us-ascii?Q?xPXO9xoo8daID0TBn0knWz6xQOf+4biWgL1Q7StpV5YRizrlE48rhH4YNpbn?=
 =?us-ascii?Q?USgNCfs8tP6MOxI4g3itCzBODab8a1lsexpO9puMkUCLb5I+F9GHjTgcqAOp?=
 =?us-ascii?Q?W/DBleHsXgMPRFhxu6XahmMKcAbXEXif7tSKO50X/TpRYTcgBYjcOItR0PXb?=
 =?us-ascii?Q?7kbpjbbvAyC1QRRW1M4uPifF6HDN9MFPhoO9N+9nusvywfGZ4j66Ghkjlz+Q?=
 =?us-ascii?Q?TUlfNzP5L0ik+v/Bccyl++6p87SKQT1pP8PjoLolRcIhVeS2/fEJyOOgYvtf?=
 =?us-ascii?Q?dxHVVjjSkEsLh5jU5Fm2h+mHipGtFe238DIoFOH1xv4RaXRrMCVwudGW2K1M?=
 =?us-ascii?Q?qufs4Q7Ko1k+ZlZ0/IztST40SzbYzj0Rs707DZu6u1jHQpfZ41s9348yKJzq?=
 =?us-ascii?Q?rofa4yvLVIWKYSr+qkLmqUWx1wORlBoKhIeQzhzjktGIP47k1XwbefxuOk6i?=
 =?us-ascii?Q?dvo5AGJyi6E1cgXHoekvNj9nW4K9KlnbfcU1RfaHCtAyEaObMO5HhMufj8IK?=
 =?us-ascii?Q?H49eraBE0ML95Iod3P1hvLzT9LyCaCndIjRjHv1ujXw19JExBcaYi8JeVzLI?=
 =?us-ascii?Q?f6u4k7+9DQg4GbDLr07PuZb096XWGtJ0ph0pXo60R4tPeR+xmugCV+wt1w+v?=
 =?us-ascii?Q?l19iAtkx2ZvOi+baMcJwrPQcciB5J/F2uB5opN9tF6Km91MDuBT3wHrKUw46?=
 =?us-ascii?Q?d87Q6G831WEqpR3goKJw+Zo6gudfqLBe8tmavY6W/asgPXNEMf8qU+lyUp1u?=
 =?us-ascii?Q?9cn9OtINavuNMlB45fSd3VpjeWgNGAO3yk1ABfP1r/0nTuP6fviGy7B1zq5W?=
 =?us-ascii?Q?VuhHMOFsWKicScex389xbS33iHh/Xea2LTZwTB1eCL/9+RdVaXU0GHwjIFCz?=
 =?us-ascii?Q?I4IQOdWjkQhqFieqIbsvMsjhCUCKUwL8E9OkiZKiykt30GnHWMj+mqJgpPN+?=
 =?us-ascii?Q?ZbIkmN+05WNWKh0BBbPCATeY/ZXzcP+ZTQuspYUF0wS3lTwwgI7brH2ZdrEe?=
 =?us-ascii?Q?72tVTHBGzaN8P15RflB7srl0BBP5q0cEyjdqEEqnFcj4glD/bPiWWdsTdnbp?=
 =?us-ascii?Q?cBoQ2aTcSz7r6+by6OSG2SFGRD28N2yfOtNVlvJ1nhl60ri3wgrmTEXzPg5i?=
 =?us-ascii?Q?sGXV2QlRlWS1ReSBnbxlNF6H3aRLbgeedPDIhqzrzoLOpZX5Pnf8VyPbFbrB?=
 =?us-ascii?Q?9wwRzBU3inD7bOmFdpwDSxcE+/g7hTDu54QR9u6cUHeYBfDNm5etHOLyq9Od?=
 =?us-ascii?Q?ouYykYqVB/L3+jJKklZ9VV5Uwm/uOQrACozZjP1C/Dh5B90JQYGPnZXHAccY?=
 =?us-ascii?Q?A4S+5XJ9EjKj+LsRuChKU3JD6+4ovFWczm+QXiQsZjjd0CEhaOV0yx4SP6Er?=
 =?us-ascii?Q?sdSuytmfmjuTj7dTvQAkw1Qie7fx46lwafKv+iUed83K2WpMzDTPF0MuZmlV?=
 =?us-ascii?Q?Yn7u5klWpmAyyYH2pM7kzf1YGMH8RHUYbb3BJlEvxztZL6rmQ5Wi+NjhjO2E?=
 =?us-ascii?Q?4URVpCHNuq2+HlXbOp1k0PA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f88ed-0a28-441a-4b97-08d9ed4458c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:25.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4Kn6S9i/+nawlWZ0AS4hSkU8fDSXJ+XhON5M+ZSNNwNqY/z7S49dMs7s/G89jQJQTeXxYdYPgdZJG+nCpzZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

This patch added three more arguments for the function chk_join_nr,
named fail_nr, rst_nr and infi_nr, for the input numbers of MP_FAIL,
MP_RST and the infinite map needed to check. The default values of the
three arguments are all zero.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7537f4fe8078..f0d0d540ee0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -719,6 +719,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
=20
@@ -730,8 +732,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -740,8 +742,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -752,27 +754,27 @@ chk_csum_nr()
=20
 chk_fail_nr()
 {
-	local mp_fail_nr_tx=3D$1
-	local mp_fail_nr_rx=3D$2
+	local fail_tx=3D$1
+	local fail_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+	if [ "$count" !=3D "$fail_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - frx   "
+	echo -n " - failrx"
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_rx" ]; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+	if [ "$count" !=3D "$fail_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -852,6 +854,9 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local fail_nr=3D${5:-0}
+	local rst_nr=3D${6:-0}
+	local infi_nr=3D${7:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -898,10 +903,10 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
-		chk_infi_nr 0 0
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
--=20
2.34.1

