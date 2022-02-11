Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056177F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5wYijvQMIWylQF2S3VEDV6HQoiZHBzJoJSQMMeOYGU=;
	b=m8MKV+D0iPElnS1NAq2XeQ29NEsl1d8uyJZbXwqtqDpEenFPqBr0z/9M5gWOvIzdVPhhbx
	yc8SOfY4BYad02amFiCDnRdydfxjh1/G9dw6sCcnGRFiOOh6hUDeaFGonRgR8K9U0+MbPG
	jIZF+hs1YeX5TOSUVqfYEZFjK9YXY0M=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-y4zeWBw6Nn-HbKW0_F_z5g-1; Fri, 11 Feb 2022 23:46:01 +0100
X-MC-Unique: y4zeWBw6Nn-HbKW0_F_z5g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G01IYxE6zl3/L8FkZsi5uZlcul2ehtIWuEj2w6EwoaXlsX33wjlVg/Ryy9Z5A5HP6LAdUtL6O6UGu1GKdIlqnIJlscGDz62L/uwLpAZTQ6wyx65vmoaOtdiE+ah7NcgW7qZtIC1jZ+x6PR5PrdxYmwfSr9p3W6K96gppNUMzQ76n5yhbnt5bOypfkRK2QyZejE7oBOT4Dfu2wlKBRCLqL1jubwgSvGEuld18RZh4mkloAlZZ6+uQ6pHg2pQS+CBpihC8TkOBSo4PJUAmFk+I9Vb2bI8MPur09Br23PV9+L3lVeQrxmHsRBeqfhK3Ub15hgfqX1+ovY9cuECsTPRX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkSvoh8drXpYj9GquG/Nb8D2U/hlxxkv956Vfc3yMUE=;
 b=oTNSdtrHsoUZmf7InKZ61VA1lhAztVtVNAjw7fRqNKrbgQ8HuiwOgUCX9Nhcdx/AZt+zw9Fgrzk9bf9fOiCXrQyfWEu4KLnC4NS6meTcNory157PlioPqB7YKZKJj5wXQZP+KoxZQp0vC2dipCr28Kqfo0bvtH5OsKoqwMT2+y7vL0uXw3t9cSmYDQbxwQdxRhZLcYQwY2nIQXmm0+t5isgAFLWJ+/uHnd9mhrlHipPN2/aBtmhpgj+gIfpirEIO4XYv++CSlmerbH8wsyGH3ssHjcPlqu+h+VRnXr5Ssyhr1qaLesYr7XYTDqw8b8WXj+YGGhH7iZmdPxlUynAFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:46:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:46:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 5/7] selftests: mptcp: add more arguments for chk_join_nr
Date: Sat, 12 Feb 2022 06:45:41 +0800
Message-ID: <e49e65fd1f2b77ce3e0a16725d4780e54f6bf970.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da9f318-9c70-4b82-ff05-08d9edb04662
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB565204401126644946743C6FF8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOiFxI13tjaAzGnKhKZHS1pvt/zu3DBjsi3u6qJ2L/4HBtPfXkBKA+p0dl2nCoxIklqL7vhkdB7a2vE+KwUmiWpyGPw3Pd+anGpfo3hRiO+UZDGOr+HrrLw0ubtIyKmDxHc2f7YCn0EIyX2RUbtB6sfgpkjviwBebeH0RWQ02YtmX6HD25qG/sj4SxHTj14mPeX3VtkcSxIlv8SNs7sGBkUdqJjtuIYC18UuFE22uVLrrVb4sRBCPWjiEVdplExqpPbn3Jyl6JQjM1bz+rr0X5Kztlmw3nQQ9WVLuY0SwvHJfF3mMgDrWFOVm9ddX4wyDYFBnF0fxVeYK+1nJ0Xy/Im8FgBbwmjaFVAMZxWoSivovOysUbbOsaZzhPdYMcDDpKOtoH7ZmClDjlmgIiXFw6/I9+nIXtOOz+0y+9zINn0ki+EYuEQfKPPOL8RXHEgkb2t4ZIfXZznL5nN+9/kwM/3197+unAyssbpT8CsRwyvUrZZA40niQ5v4FV9Q50uPBvbZBCjnXZqSDIbY9WaU8lMvMHpS4XuTHtoXmqT2AwWOfyfN0WWN2HMR05Ul8FUsUcKKL73BRM3rj++96h9RTDDEaUk1S4VCA4nKWB5TT8JRMZA5DXl+I72kHN+YR5uFty6rqrVd3tJvvfvIsXBi0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(6666004)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wv1LPaAXCsP46cfD4m1jS0GS4Dd2ShNPMeKFj1GtDoIkklmsZNqSt7XR+VK1?=
 =?us-ascii?Q?K2pSpX2V5+yNULrXS+ySQxzDcbGTJuiQPcZ/AcuNhyYyocUjdfHqLGzDCPNk?=
 =?us-ascii?Q?weL9xypt0/vKZi63euZtRJdvgG7oO3dZ3ipzgSR557FV1XjvN70BoCikt8qM?=
 =?us-ascii?Q?rTMhxjGQ0D4LtUHhOOV7BTHvdBOx5/CgooE4kshcVk+nQAN6l2jusLPrlHFY?=
 =?us-ascii?Q?cwD+e47Dd/+yPrpHz/q8sNBaQBaKTmMptvmcTfLucSestUCwAMM77grnOGCk?=
 =?us-ascii?Q?5jc8oklaGRH5v64o4mdKKANglWTPEjUwrcgLjWgypleIrOIit0Z19VGDOhq8?=
 =?us-ascii?Q?BfpPTID2LxLvRRrZUbJFCAacK8g8EH+FSRS+qqJazC0guhl+6JF4rs4xDSBk?=
 =?us-ascii?Q?A4XRs/7bJWbGwjYK9zxTuoAwmh0OXuQ/T9HFvcxwxEX3I742AAKp3P2fckvJ?=
 =?us-ascii?Q?2h2sZx/bHVUMpKpO0x1+o3iseJL8x6WfnZwMDwvDfnUF/tugJOLu5L5POn9K?=
 =?us-ascii?Q?4ytj5wueLSW+tR3Drhf+dMk4m8YvLuWGNcoJuTB2GhJJ4RhUuEtjmWag42qF?=
 =?us-ascii?Q?dRywGiNhb0c9AIdjqtzqwoQ+B7bgRREUg15sXqfGvoAKfDbwhov4TQxQ3aWo?=
 =?us-ascii?Q?e+8ar8xuMe3S4b1pP7UdJcbnAKAgwomeQOKSGKAUsB4xmJdBmEG/PK3a9xkP?=
 =?us-ascii?Q?Iuhpd+b23S81JITvvbzQJqgAOhjk9iuREljR8BBOtw1/aqdgrdHQKrIYmiJ9?=
 =?us-ascii?Q?fRKMno0VX0qZhdPDCSvC0z+3RwH1XF8XovF+oHRXmQ5lUXhLuWHSs/G1Lrcg?=
 =?us-ascii?Q?MBf5q2AFrigURmKDGiOhff3K6AKmrj3g9HGTxS5WJWacmM/4sPElvrdcxQNB?=
 =?us-ascii?Q?BYwgLstwmgFoBV5rAaEPu8SqcRoBHBdCG638M5CXeqlb7odH8q0VD+NBlE2B?=
 =?us-ascii?Q?AfQovqpYcdfmYmRMKUQHzYweDHMM5oom5zArzO9zchEj85RucIUIPu7kT8SO?=
 =?us-ascii?Q?msWQX6BM/kiO4QI72HZ23MrLcctm6mjNtX/zvqK3PJ8ZITzvhJGAY39m7Dn+?=
 =?us-ascii?Q?1S67+uXZSSeooidCC6+72tmEM9EZTkO+4yhV9RC48DCNTGf7EDHEGzI46KQQ?=
 =?us-ascii?Q?PxePw+TbWp0W2vAw5Mgiik5iwkwceZWH+7/kGiYBdwPcfPalz8A+nEGFuv1S?=
 =?us-ascii?Q?NZNnz+dF7TfoG/GYFtc6Ezg4DpsJyMDtcqGs3u2AefeRLBlBdcF+8ufcR2lo?=
 =?us-ascii?Q?l6wX3xtE2pOFpyMMzukW+C1ZNFnjFDJgJDgK0A7KWfmj1GqlI2RoHT6FbOXh?=
 =?us-ascii?Q?53D6Q9cBAHu6WHJ3d6fRI83+C6VVxyUu40eIe7z5S1/s3sz/LEYs3I0Rhj/6?=
 =?us-ascii?Q?+idXC/au4Sm8vbmCmfpoTEcGEprlSbX3adaDswPc8S/WvW7KpIkDh7/LMNe3?=
 =?us-ascii?Q?G/t6BLB+xUZTb85vdj4dEF6fye0Hgdlh71ADUG08/Qk3m8J9QCSd33H/EgGH?=
 =?us-ascii?Q?0M3Y2/O+S2a3ueR/w5kmzMaEC8Quz/fBe9djkl58d8hxKi0zISn5ds4ctJ9M?=
 =?us-ascii?Q?TraTicHjjDUj85/lOyDfxvugIQ1ky36wzH2CRGN1C2Nlvvy2EyQBLd3CZBJ+?=
 =?us-ascii?Q?lT2wAFAi1AXwaf68SEwcyhlzv93P/+v154jBRl3Gu9b4p3DJhW279kG4SaRQ?=
 =?us-ascii?Q?mrzDsnSx0e2ap4fRG3cD0V9MWZI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da9f318-9c70-4b82-ff05-08d9edb04662
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:46:00.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBtsuDaTIdL67KNMtNxhDzw7NsRMf6COGw49WVQgzoT73kyU2lTQejpIcGQ9/kwMiF1yT3jxw87jq/07JlxCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch added three more arguments for the function chk_join_nr,
named fail_nr, rst_nr and infi_nr, for the input numbers of MP_FAIL,
MP_RST and the infinite map, which are needed to check. The default
values of them are all zero.

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

