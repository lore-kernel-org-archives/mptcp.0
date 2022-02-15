Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AB1388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRQFT+nrVqdwa+9VeBIYqDYwyUIsupuN7EArlkMTF08=;
	b=BeR1zg938HUhkzIp3klW6ad+74WiuhbP6rWndA16zK44m16bO7HoBN/hw/jlEkfyahw/Ra
	4jnYggVneMx4LCKcTMgrFEawy1Xp7SuDGeXyMkTy92WUpxHMcj2iGQMG5G4wt1SbIl4Njs
	/7F5f/hENtcFoupoQ6NaPC+rxhB7uu4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-Zu79wExROZOErbqmR3aCZw-1; Tue, 15 Feb 2022 12:25:48 +0100
X-MC-Unique: Zu79wExROZOErbqmR3aCZw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buit9G93EOD82B+kjfqt6mY/2pCBbnHHAwCHWmvjg8ecSYXtvK22l9ypqp4qvD/OFJZHvlDjDEIitQKhnxW/6MCLiciGnRozmM285wObH5Xf3WNWHlr5ZnhDxSGpEHyEYlrxrkiNneOW+PcWmylO0EE1AhAb5JCYwEXaafvTQCN/Mg7u1Ov882XGQUK/PHqu//12+8s9CqKcEMniOfYcBIo1gxBFrabTlBRUy7OFthv8DbDkWlLMFf1ZIVrcAWJuRsDcIKN6fuh/yNjOP7jQiRD4XgVqPi9C250KBNWM9u/ChrSjI5VCQUyN+9oe09X84mmUd9dyr/Os3UclfnxJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F144HjJdOIHMFI+kZ8lsHuRt0wMvKZEiuterjlqHYE=;
 b=AWeGIZz5qSgULnGg8+9Z6MG7MBZP++cBKwmnZlWjjwT1m5nt+Xg/HoC2EOZScIQlCOh44hVXXlYzaf12k0I+j3NWwuX6rjtc5w640iOzQ8hYHj1CxRne3+YACV80JPxE3hu4lc+n9O8eSfo3u4gsP2Eel5Y/C062MpFh1RZJF3H+GMA13AcD64zxfo+jOMxq21zLS+E+xPMiqb4g4NBKaAYfnH/jeKrzjf+ULUssGT1sEpSNfJT+8qe75vYScgBKsM6f0fy61iuvOya8h522SS6rXPfDNiGCFWlpmnPTv/45qUZiajuFAcVHpPCRxeP7saG5smQ56gTf27sPc3aJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2561.eurprd04.prod.outlook.com (2603:10a6:203:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:25:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:25:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/5] selftests: mptcp: add more arguments for chk_join_nr
Date: Tue, 15 Feb 2022 19:25:52 +0800
Message-ID: <701fd5e7e3953c1b05c617ac30ef3b9b72b1d470.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98470841-a610-4372-f397-08d9f075e9d8
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2561:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB25613D1EDB05AA52AA566505F8349@AM5PR0401MB2561.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	edNf8xTq9eW7jfc/mfDBA4vruh0yo9qAJZ7SleG0x0oOEyqM1aPQLmUWCIi/LrwuwLlVhBIN52ojDRN3E0u19h+Iyqj+o+d04DGAk+D1Pa3pNgeFhc60wSTx5y2dsN6NN7XNAKVvqjRcEyGEuao2bKhjpGBZPsafaLtienjWcws0ggjkunqami6NjKZjYfNTfOtUPxe4kkVLGPxINw2cRqGdWlhkeLaUeMMdukz5p+Q0AWL9C8ETBxiKC99QXCFc6I2wc+KKuoqEWZPgtQAz8Sp67J1pluLXvjEEcg8ZAQAZyCam1A8Vr8OJFCeE+XD8CpZH6+F/Nq6a37ri3bGICKfxyj41l1lbAgoeu3bmP0aHsRvWr8HlqW3FT1/aJwkoMqTHOx63XDalQUoskG99wz9RhJVqzgUfZoWK1+yKbq1ktOza3lcLYrzR2arkft2B7LRUABUUgBrG+2/5Y0eAKP41XcQSCwR2TlWE8rx3iisgyv0OaIjDK72yHth0amQUC1Knjpt00ubki93ed4i/Erbrcs+wx2WjRTug8Q0YOc0cJoJg3RpPtsRo9TDF9+lDRyp6QnMdPcl0QdNelnKernn5zvIikWoAmlpYBbcurwil7fjka+iQ+Z1/nYdptcu9mplSCnM4PdFRuJ/d37dkuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(8676002)(66946007)(66556008)(508600001)(107886003)(6512007)(2616005)(2906002)(36756003)(86362001)(83380400001)(6506007)(6916009)(55236004)(26005)(316002)(8936002)(44832011)(186003)(6666004)(5660300002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkkq2mj6lrAiVwKcNtzB4o2jW76AJGIN/R7yZ10tIvj2WlgAZ/qf5giOQQHe?=
 =?us-ascii?Q?TVDN/R9MmYvpRhMNPjPPp0qUn7T+vXQC8la16BpXc0YqPA9+2shQySuJQhGJ?=
 =?us-ascii?Q?59O4UrhHMNrbo2/op1vK0hWoc4hLlxWJYmEMNA/JDr9uMiQ8vRtqWmicADYv?=
 =?us-ascii?Q?VAmy8hzDZs39FJ7Q0PMauSjapsCMRoIvfqtpP82qet+xZTO3LAVyYmWnL0cC?=
 =?us-ascii?Q?/+V+gznwHFPvMSnWpEIPf7TkKaRjdJDPTKW6CFIOy+PJMZ6CQqB4m6zW7Kw3?=
 =?us-ascii?Q?sjA5KPj8Vp6XxyCkmlrTmCzUIl2mxR7C/pBNorJJRqGsAijWXD1n62AnFKng?=
 =?us-ascii?Q?jxBRurBS/vxZaESZay2q5Vb9hX4sGELWZbiKQL1t0f264KD/vvTY0l61mv7s?=
 =?us-ascii?Q?5balUF6Z69GuQZPfACcbKj8fpN7uP/ijE/TGGud8C7A9kvJE739raISfgRI+?=
 =?us-ascii?Q?6y42E+IUB/1zQU5Z2JeuxkXMU8zdjuBD6q8ixg1wDbr/kOU9HgWW6VhIwGb/?=
 =?us-ascii?Q?MFyoa4X+CT/ZHx3HuxvQKSl68KfrNQ8K6RgC3KFnKjYhhsCzT1d3b5oCGUqy?=
 =?us-ascii?Q?10tCHeM2JF9oalPM6dPWFtry0oIu6mUePdOtiFjqz6zN+jxWiIMRhHqi+BAw?=
 =?us-ascii?Q?zNE+epEy9Sd4O10ePjsvNCPqD2apR0+iQnTGTwwdR7FXO6o5jHv03QO8UJSh?=
 =?us-ascii?Q?7KlPAAOWnth7H4iPJzfq/KqimGe7sdm469cLLHedjrFBH/gSgVTDGsU6Fg04?=
 =?us-ascii?Q?dwbkVpn4YSAi86rj8CVQcXpSZroG9GKEL/NFRnTNL4mmr/gZbW6UWCgfmHPC?=
 =?us-ascii?Q?r+KMOJPOjYMNVhByciKUNGc+JsUjEd5+RR+266owObFRNBSmKp6rVqe0SDji?=
 =?us-ascii?Q?P5leQXn2+vcr66IQ3phz5wnP6MWwa4wrA+w8IICbrO3Lbo1tCEXehNC5Hhic?=
 =?us-ascii?Q?3JxDdqKl++JqxrgJot5L6J7bMSbv+j68zhdT7BFARkeL99rdTrKevaLWOpjJ?=
 =?us-ascii?Q?aubnmH7GiB431qRkOneI+TVq472XUlnPn0mQGjPD3D6O3nBGAghEp2agSWI4?=
 =?us-ascii?Q?IefPZyFEi3ErOxrON9QoPMw86Kl67sYiTJ9wQrOAcWmI1VxONFofyrCpTk/d?=
 =?us-ascii?Q?M1vu3lIMti5lGZIbUMw4YFshRpH7PWOa8AmRBJHct60Umv5ScQGEOhsLVgj/?=
 =?us-ascii?Q?96CurRlACud4xFPsqjt0xfZ8M7TOZjrijVUpx7Q97YC8eJlzDo8j03fGUiLA?=
 =?us-ascii?Q?V28JqqnQtq8hHw65A7Exb1Zxiz5c7hDrtZnnFwPM2BPxrUzyoTLNrs0z6PoL?=
 =?us-ascii?Q?EODbkwfIYiO6TtT0V4GY3gx70AS2FU0h7SjaVUR+LE6EkK+yQoWD8CZm6sOq?=
 =?us-ascii?Q?TDhJ2pqQT7Rhyp0ZLiOF2uoomkmAZFvzs4hLmYl+tnxOq7rcPW72W9ckqoaz?=
 =?us-ascii?Q?2q2tOSpcQIiAW7i/Savfvdg2ATuQQGpJykYe8WSnYY5jE7o8UaUr0KArd/+k?=
 =?us-ascii?Q?k0YWslAmPGsO3IZlUqsyYSpYM25AYhPpprW4MOtIUlPuuUVA6Wm8EoOFN3Ii?=
 =?us-ascii?Q?H8PNuy+FMWb6sBfk4kMYrrfK1n2slZWxGuCKEmlaA1FnKVb0Du63JtxpvaW0?=
 =?us-ascii?Q?N545jhIG6ktNoJPSnHvVZf4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98470841-a610-4372-f397-08d9f075e9d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:25:47.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3XWcLvDDC3cBR/oOOPM6jqh6Vevk/UAhr4W9xQVpk+c7r+Vjly/7ILwsLmPdu6dIRBMdrSlcBwH9W67g78GwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2561

This patch added five more arguments for chk_join_nr(). The default
values of them are all zero.

The first two, csum_ns1 and csum_ns1, are passed to chk_csum_nr(), to
check the mib counters of the checksum errors in ns1 and ns2. A '+'
can be added into this two arguments to represent that multiple
checksum errors are allowed when doing this check. For example,

        chk_csum_nr "" +2 +2

indicates that two or more checksum errors are allowed in both ns1 and
ns2.

The remaining three, fail_nr, rst_nr and infi_nr, are passed to
chk_fail_nr(), chk_rst_nr() and chk_infi_nr() respectively, to check
the sending and receiving mib counters of MP_FAIL, MP_RST and the
infinite map.

Also did some cleanups in chk_fail_nr(), renamed two local variables
and updated the output message.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 76 ++++++++++++++-----
 1 file changed, 57 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 243eb7e14921..ec8d750c19eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -745,8 +745,21 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
+	local allow_multi_errors_ns1=3D0
+	local allow_multi_errors_ns2=3D0
+
+	if [[ "${csum_ns1}" =3D "+"* ]]; then
+		allow_multi_errors_ns1=3D1
+		csum_ns1=3D${csum_ns1:1}
+	fi
+	if [[ "${csum_ns2}" =3D "+"* ]]; then
+		allow_multi_errors_ns2=3D1
+		csum_ns2=3D${csum_ns2:1}
+	fi
=20
 	if [ ! -z "$msg" ]; then
 		printf "%03u" "$TEST_COUNT"
@@ -756,20 +769,40 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=3D1
-		dump_stats=3D1
+	if [ "$count" !=3D $csum_ns1 ]; then
+		if [ $allow_multi_errors_ns1 -eq 1 ]; then
+			# allow multiple checksum errors
+			if [ "$count" -lt $csum_ns1 ]; then
+				ret=3D1
+			fi
+		else
+			ret=3D1
+		fi
+
+		if [ $ret -eq 1 ]; then
+			echo "[fail] got $count data checksum error[s] expected $csum_ns1"
+			dump_stats=3D1
+		fi
 	else
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=3D1
-		dump_stats=3D1
+	if [ "$count" !=3D $csum_ns2 ]; then
+		if [ $allow_multi_errors_ns2 -eq 1 ]; then
+			# allow multiple checksum errors
+			if [ "$count" -lt $csum_ns2 ]; then
+				ret=3D1
+			fi
+		else
+			ret=3D1
+		fi
+
+		if [ $ret -eq 1 ]; then
+			echo "[fail] got $count data checksum error[s] expected $csum_ns2"
+			dump_stats=3D1
+		fi
 	else
 		echo "[ ok ]"
 	fi
@@ -778,27 +811,27 @@ chk_csum_nr()
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
@@ -927,6 +960,11 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local csum_ns1=3D${5:-0}
+	local csum_ns2=3D${6:-0}
+	local fail_nr=3D${7:-0}
+	local rst_nr=3D${8:-0}
+	local infi_nr=3D${9:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -973,10 +1011,10 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
-		chk_infi_nr 0 0
+		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
--=20
2.34.1

