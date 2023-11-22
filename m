Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF64AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uOk/ooSO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsWkYd8AFKQKqiTiHuHU6L1aJ9DVwIHLhXzUdEIM0hI7Kz5jz3GXWbz9xm9qjen2j9gJQFx8tOIrfEjh5nNUBY6duwfpAiOKU4mBj5fUDlLtp3llXxG7d9wfylMceDsK4sorvc2wceNbJrKY19iT7TXptwUezxKYc1VwCdqqnzJWcLWd2y2wwzNA1H1cGhudbnVdFqfASM7rMJZXjwwfeaJ3ZU0AqQC+xEyos9ZffpiwUAbyaLPqDXm0O92oQrJBxE9n/CH8C92+IhjniiCv/geCgo9bqq4qrS9TZ0t9RUIt65FXyNRtnqJQrq37/VaKx6QSF+1UdpCLSFS4Pr51xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2QngMQ+PGthL67bj7WCrZbNsdo8Fzl9hFgUZqDUCys=;
 b=OXp2l8byKXqMxlY9PTGEjrc2Q02ARPumH3wM8/UTJl145s/rDT0nv5MmzE4CZ7Y2PPpi7xAA+xxctHNPFkUflplEuSees+R/hi8KfEBd22SgstSabIVp47bR+ho6UAcRWXKhjx3+rqBWhyrYYjq+XOMvlu1lwePL5Z3JW6qi3mNnY4cJCjWERAos0dDdTu7A77JcQa+QF3Glgoa7s/9PgsjRx6IMh7NS0iPaSuyzWHcL5UAhbxX+nm1vn2pwUdNOrfKfC2hsTJZzXb5QKxPRV8hz6lql+wg+qt8hIY6IIX4be7gLS/kyk+XpGHG7RGuCnihD2oxgHGIwvsoDn3uzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2QngMQ+PGthL67bj7WCrZbNsdo8Fzl9hFgUZqDUCys=;
 b=uOk/ooSOzw8ozImeiiFuiDX8fLZ5mst/yZ/S8lDCEABJztxTIt8Vg4CPakwqv3Y4A8+aTTqBXLdoOE8KB2+XVs0LQNRf89yPFflT58OdnzqD6Zw14W64ulirE66JpVFHeY1AyIekYhS23aYhqpXCif0jv9M3mjkQNqGUUWelnTe7V1zQlx7KoQ2h6lxUTBjQD/xJ1yOTMcYjfZQKOTjKJhhfrGRVnXaS1M37LjJcDzAlofcOeQEzber08Krz/fc21ThCr0QiD5aBHWafwhGGgUCmxnkdq7+oul/lFpPqMfmrNqgRrPmpro6bPTRyRzLiil1/qL931OhkHnEBgXv9yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 28/33] selftests: mptcp: join: change capture/checksum as bool
Date: Wed, 22 Nov 2023 19:31:16 +0800
Message-Id: <14dd4340471de6ec6a8e085218608c1b2e0eb0c6.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a10bd0-9db9-4426-3564-08dbeb4ef9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8R8Z2KJ3JC0x8K0myWeM8MAYqQDbWYc5EQjrj4jFsuLPR9RiY1pn1UuJuDqoBqCbU87n1q9gcY4XnCQAdZsgZaicoOj8L1649kpH9AXMkA80PAYtVHxxsG0BcWRl3rWnUxX2SxNalVdTY/JDI2MY6LnZNSiG6xpkD8iOc07Hgt4g9Oq67B8z2jbL9YFqUbPi2/dDWXo5RhRPVTFN5u8++/j2osCf6VQWL5wDPiBtQUnDjhgHVQncq0kJuMvNYXegtzk2dCcsvW8KDLJf5p9cCIco/dcJRyGFQOibTQGmL//jjKmXxDLIvCx11h8M8MY27+iq/RVzil2DAQDhUOaUeGsmDAGQNKM0EgdTklx10Dp4iIrDF5m7qSdFJQCLVOUfMikAT7hIUd/32+ZLzbgtmPuaW1n5h3sk22k0OFiQZxqhs6uuB35poRAj/9rU0Ccjrrz8O+4VVCa3h4EQPBze7BbNBq37EOp92zi1HWqUvG4I2/+o1+tB5gGRlFdof9DTEiosRUENqbrRBd2P7jB18yYmuWvsDgOePQTt2Zl6FwdQ6K1MBggM7a+dsmk3anaDDf6xzcRgwjFyztR3lGEwoHnYkXoyp98/n++FXxJToEM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQ6D/kQKIDN4QRuGZIeRqNsp2/PzvDkBJTNSje9l3d8wlwDLf+efX2sY+Taw?=
 =?us-ascii?Q?Kqnv/RnfA+MGaMumtiu3jcdDHc0rFdIKsrXDuNmP9M3t8UonIZ62U/VUT3xQ?=
 =?us-ascii?Q?Ds1ng+jxcgR7nnChvZPjSvouR4FUFTiSQjErgYoh7scHZi1RKrM8mNgSQmOh?=
 =?us-ascii?Q?RCdfbvcMTk9XZkseRGtDO6Q1DGn/yvzj0cxMePTE0ioFj02/tjOVgLHfJYd8?=
 =?us-ascii?Q?C5fE9g0T84XVG53Fhc+0xBlHzPU8IS/ktXPXc239nbnn2X3CDkmmJz1E66/C?=
 =?us-ascii?Q?VRc4+kOLvFUHybb9eU/R7xG+Qj818GE7G1H0FviRgH5x3OFbGxjP0MTROLWK?=
 =?us-ascii?Q?v0SmZmU10oNmG8LzZ3PaN029iaV8ybNH758E3lUVcVDWS+qkkKkr+zg77FIl?=
 =?us-ascii?Q?s4GJrqLPnUArbiZeuQY8Zw/v2onopmh40aqv4hw4iC5Ph6cvR7hwIXO0g5RB?=
 =?us-ascii?Q?BXXeSo0DWUaOoI98ynXPKTsx7EmO6LXXNhO7XK9ZPPJXdr8CqAhVAGXgVx4v?=
 =?us-ascii?Q?lsMjJdf8GgmwLAFN/CSyZRIGC0Mk20HDBkytyNkJqpHQK2XGSw2swknyT8p6?=
 =?us-ascii?Q?RSJJZ8pHscvcfVvEy/a/ZsRrbBSFhQT3ynZ7Pznr2DgkEuq5yahJvJzoIPVm?=
 =?us-ascii?Q?GzZPlupz62qw9Kc5tTpBHBie426jjDFycD+XVI0f1daOz811AiUNTkGz+eEC?=
 =?us-ascii?Q?Ftxx45Q54pkpwWST/eM79oxCeDtbVsJGVPWipv3+nrJTVrOuiAymrxL2rRkb?=
 =?us-ascii?Q?ecjmtUPvU7Te5ZHMcWaJ1Ru5sRgXxaKYnVXwt8jh7oMbSGXdWKQVbA4A0jlX?=
 =?us-ascii?Q?asY1LZ1GMUcrqLtScuJp+bFeKFwkj6XW9E9wc/zIttQAPLayK+aTukuIx4Sh?=
 =?us-ascii?Q?IA+fxWq6yDQtFFl4w1TdFNHz9XKIv5KHtTkAOKFRibW+roma2GAGek/j+NVF?=
 =?us-ascii?Q?EmBBD6oD/7zFYD6P+hpizKt3tVXh2NU+ehfWiFl3y19u7Wd8u8kVckxUU6l2?=
 =?us-ascii?Q?fUoqRJO5v8rlon63KtKCphf10/qYXaVrbLMZdKj+7L5/A1tVPC2Hx06SP840?=
 =?us-ascii?Q?pMcyboWNlM3FeoRyjHqyiNXZ2fLCSNT3hscPWCzFr+VLPNMHkt3DGPpy/stB?=
 =?us-ascii?Q?URcncw7OhkgQJDziGmkXnr4x2E+EJoZZgAczcjv7alFV67xI22Nl0L63Ui9S?=
 =?us-ascii?Q?Y5AOpcquZ4R4T/bIN1cWLDpo1NQRj0mcYAq6rm9fTALxJlfueCyn5UNckIJ/?=
 =?us-ascii?Q?cfAE12GMpSI8yT4lR9y+qtTr3qSWg+wmOUlcvXQ7Y8gEqNZO5UUhpLY29/Pe?=
 =?us-ascii?Q?16oEyqpYL3HAAiaQEx6u76b4Ae530ZkW6r1+gyAI77WEDw1Yx45Zo+WKTphZ?=
 =?us-ascii?Q?7ILZFDtry/HX19B/UoF6PcriCWK45FLhcgc2PGOWxJ8CG9iMoESI+JRBcseZ?=
 =?us-ascii?Q?lH1n71AWkTMxU+7jACYjvnepSEFxdVnnbV55v74Y5YLACBCaoJWuBVgKgi5/?=
 =?us-ascii?Q?lV9WhKdNeSfmHgtiLJkDZS96wsKQcx3W1L2pHIkIQv6J/vDOD5gx8H+s9LIH?=
 =?us-ascii?Q?6fV4fll0Ai5kVfrnYxKNIVNi13udCggC+xuLa11gktNkySWn1kBFnYyIewka?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a10bd0-9db9-4426-3564-08dbeb4ef9a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:23.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oytqQBiy2DZN6whxLZqRsoXMtAyMgMK93NSpmeQqskgcPAZ9Ukv4Bt62C0rTFkWzYastYDuMB3LigoOwBN412A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 806eae63fbd3..a3b895c845a3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,11 +22,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 last_test_failed=0
 last_test_skipped=0
@@ -76,7 +76,7 @@ init_partial()
 	for netns in "$ns1" "$ns2"; do
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -348,7 +348,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -381,7 +381,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -953,7 +953,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1054,7 +1054,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1442,7 +1442,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3630,10 +3630,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1
-- 
2.35.3

