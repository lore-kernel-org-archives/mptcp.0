Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1572C9E
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfrxc6uchz3LgohHyAvfl0pZcYYP4yahr5LYKiBhjwA=;
	b=JUNqlTX8ri1ipwJdTw8GgdYqsO03fTB9Vc6oOiIgjCd8kNYa1OA2umZBUbx/f4i5Lp02Ge
	+eodT3qPMhkM+j35z11BAgcNhkr4w122oiT1936VWDbMpq/FRi5DooLAmfSo77z8zFciFi
	2d5YMI/wXfjfG6CbegeXnSwCRBayy04=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-Bm4tbY9INwSGXjgiotproQ-1; Thu, 10 Feb 2022 07:00:41 +0100
X-MC-Unique: Bm4tbY9INwSGXjgiotproQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMMgk2a4Pt71S7Ep2WO233pnODM4mNXKWDYpscYT5c7wuky1xZhz0V4Ae9VL8NxoimgpJ+c6oGbe6Ua7cLuy3KQIu5S8viCM8aIOYrLN45APej0HSiHZQOGfYC7MxURKtZ2Y2qo++wN1nyYGeLwf/ewGm9/vD/Rfkr5/j//nejxpOMJoBBlOT+S3yreZFyNtYACTqD2ZFtBAU28WiFcXXhaPjL+syEc+n86RYIri1VrQ3t4q9q/GIuaoo2nwt5aymBL4VduqPhHv6mo+WdEGU4WVXNDeVGBwLtW+NkUKMrPA/kGHCJQ9KYOwZsEEdkpmXPB/rqTjOxKwPZ1tq6ePKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBm0FXgBjYAjxZinK//xryRtKDYGI/+ZZ6qchH8Ztjc=;
 b=IJGJGf1uj8VKmMpKCHwwNyp8KscYXKWDOu73VfBi5IHSEL3EzcQ50wN4CMljXWdPfIekBvmBrbAmVumgaG8ZPxF2MhUtbqV4VkCqArKUt3sNC1Q70a4bebJlWy1wlPmT40rguXL09rM94VcQBmHmSPJ9RZH/SqqhbdpBHYeu7p0NgzxCO0IALUgthatfqUEwXjNrb6S/uoPqd5KoDnvMSVhKMNruISvHxG0TQymHnfjDf4EF4yLHrhag27t4avJe8gnfskR9JT8/glEqQvcl9mPyFaLoZ31/5rYlntXoXGMc6OVFKNhcOFGlkYIRTTptxhsJUYpp4USUHTwxvTLbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:40 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 5/7] selftests: mptcp: add more arguments for chk_join_nr
Date: Thu, 10 Feb 2022 14:00:29 +0800
Message-ID: <f92bbde8b579e7ef56223d874f2aeae300030407.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817dca85-be54-402d-3efa-08d9ec5aaa87
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB57619B07CE0D3CF7B93AA52AF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6uNI58VxwlBdeYu/mqJYZdCDbDVt8pPVJoKzurDDQq/+u24FkyUMOi/Dsdp8bEQpTV8cJ3y41FPpn3mDlYYeJSG1S9ADU7XvfDbJWniISUYFsIUksBpvLRGceEjLfbNoKMdsEfcsl/YpBNuZjs/gdr3LGKyjW6bIxQ5Lh84dlritjojcZbhETH5GKuRB6nAHoj9Dp3kBPJWCkknFCTJgiTH4/B/YcIAlp8KYmHC/eUxFmC/T2o46seMeuFpVR3FXIPNoU9kiBR+heosxICDkFdBdgDzVywJ/H3pMNCo+E7mDblpDi7L7GZ2LFzXgallods/M97bkZsR4UdrSIJiH1bwxD0+4Q0H8iPAld/LjU8+V/14MAMkUP7wRVU84FSd7xlaU+aegi5qLxC8dmaoJfVDOq8cuFxMbOSBlAb/VjUTfwYzeXi0E3AcceLt0g366D5auLBzLkkCZOSjwT47FqdMpHNNUkgc9O9AOVAt7uMTGDNDRSnLVqxqa9CVAkA5nnxZmNRaKLWz1sMtPYqe1cwVRFXyc2u4nfXmjGat57nsFyw0do4gnG/6nlJ6MvroKjacQsG9rWaf37AhJdA1m14xCF92Y5CoGhhilCAekd2BLEfBiwQl8Lj8yWhrOeFVbKT3MGr9Yd6akTMla64tEfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prmqXgJxthYV5ZBKJtRVyrM5HgEnxujXOuJ/NzSKeS1MM0nKc9GtO6rkF8K/?=
 =?us-ascii?Q?8HOC5eyAmJBrf40t+y6wTQA/HrRbrNSUObftQgwKKGvGKfj9xUbhd1/+kOph?=
 =?us-ascii?Q?Cg2IkEfra1fd8hYnhYZmas+NiUnO0Z4ZdvVH55kxcOuzYrvrHbvje8PG0JIK?=
 =?us-ascii?Q?u9Vq02XCNs7oKr+Qvb0JDw3D/1Wj+1mKHHW61AEnQC/edv26/joF2XDhN0+V?=
 =?us-ascii?Q?51hm0Cc8l3vw6EN3Lqad5dp88g+shwEUkgTLuPYI1WJKbPwcgn25cn0c/T/9?=
 =?us-ascii?Q?zskYALVtAzqdw9OifJidicBCrfChGGDSlTPnpB6Az6qVVs7TOiOJASAMQAdO?=
 =?us-ascii?Q?wsV39iZ+HoaFtWjPTxhaY1kgxF+/MitMFRpEj36hTl4iq/mi2Abp8NqNTyVs?=
 =?us-ascii?Q?gqDmN+u1lr2RqveS6KUaryDs8nDc9Dld9bo4djJmDXozCcnO9vNP7Zx8L1vi?=
 =?us-ascii?Q?p1a3FstwwnCO8rnnW2nF4QE69HkxiwKth0jnxPZi23hFp1w3EaVJ70vHhCrt?=
 =?us-ascii?Q?Lpt0ZeSB+x984aV65+98lm4IP3uU6Kg3D4mrdz1JdW9KX/EOwZ9L/865jlWo?=
 =?us-ascii?Q?/Bjunovii+vga2zH0FtMqCS+uWGH5rrLZZ0tmCtXXXKiur/ewvEa0yCxhm7W?=
 =?us-ascii?Q?gW0+Y/z69DFiNdsVQxnbpYs9SaNL92rA95h7Pc4wILw0rmOedi5Ohmtxqh6j?=
 =?us-ascii?Q?fwEU+0DVrBatqlQOwxDhuystDYWc22lzbwhwthDPXZOzNcNXa4E/MX68PMWk?=
 =?us-ascii?Q?rbTU7S6kxsj2l9LjJEm6T91ZeLnawTOcq+ZhxnZcKjJcgqi+2XdjjBDLGuio?=
 =?us-ascii?Q?FARY0MIOYntYwQtFqtoqjt9UF2gBrbj5dXWjjNBsZhucnXEj9x5wmpAN7GEP?=
 =?us-ascii?Q?ACaejZkCcCWi3WQyAaN8boJ/hbIjeD7j3P7u/2jLi30JpAeyRjzgPwijQI8K?=
 =?us-ascii?Q?7WdCp+jWIzpe48A7MQnCkgKBWHUj9xfYwmCdZ6DgFw9unC28lOwvuqYBcUGx?=
 =?us-ascii?Q?Be5iCHNzLGOQAUVXB5PahoITIy7w107sd/vPNiA0Y3HGCAV/qmZLZdh12tux?=
 =?us-ascii?Q?lS2UX+u7tsbpGUA/US1GjzUMkLs+P4twJR2EcQcRiJ9R3LyJZSwcDBVr1D/Q?=
 =?us-ascii?Q?Txv4o7hr8ND0UNONExo+YJClLJPkgU+7dBZndcE+7kKoHqiNcNFi64KmF/BW?=
 =?us-ascii?Q?YpKJGq2O7LjXOb+dWgY7JynHJ3vJwP0vtCwMpNW0CXhnJvy+uossRlbz7NnP?=
 =?us-ascii?Q?ki95bl9lMLy0e8b1IARH+aqok4HWzZp7GkvMaGxh8/RCzVqZreTWqSJFRWHv?=
 =?us-ascii?Q?wXL5i3fjwOW8Lx9OkyD3lau6kJ1PGsPAMs7kE5Yq6+9fWvto7gnPn6mTqAJy?=
 =?us-ascii?Q?yCz2/PYsPk1KruLIDEunvMMKWFC5Bx42MUQ3UlTN0bqg5iVGNRqSxjz8yeCc?=
 =?us-ascii?Q?oX2eUJLs5gMPxCwEp1OO5uMRvmxUu1Kof06XH3Oa9RE3TEeFp1UT0cGZJX0Q?=
 =?us-ascii?Q?OLHxzn571O4Pmykyt6lZryZQSDVFgmqGOcI/Hc8L9s+MqKMcNV+SmFkjnh7m?=
 =?us-ascii?Q?E17N0xCx7kEfKVfuN72KZfpAky0rS+6XVTxwA+IXB9pTIbXQG2d3ReUz79qn?=
 =?us-ascii?Q?7uzPiqkN9vPnL3DrzOOKigM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817dca85-be54-402d-3efa-08d9ec5aaa87
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:40.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2OeVStwMoGKJ+E7ka+fIEPD7oeZift/ZZcfvhWUou2EJwt8g/Kt56UtCr8FlTHoghpAmUkYPKhi0T4bWIVSbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

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
index 95d61c97ccad..c595b4613ddd 100755
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
=20
@@ -889,10 +894,10 @@ chk_join_nr()
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

