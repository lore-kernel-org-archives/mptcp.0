Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD4125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7SLxRy6twMo8ML5SZ2f++PsBgE2S82tFXZwK9zfANxeSzn7EK1HJLmriqyO2a4AB0xX9xXYLnJ9kQLwILkLDjXKos+hjgq1JPnTMz0P6Rzos7AaJdzpnejOx5PKbsPyRrXGjWD0kXSg05XuAm63jOXJpx9RloctGe0/diRCXfZrCHRVGpQcE2dyvdqvJfRaAix5VSRBV3326fbS4catc8a7tbTWZLxzwEUjJrDbwua8aV0Wf7Q8gtZIXFEhJXVInYdlGOaJPIfHGwcjA228jdGDxEKxHh/ZyTESAXxKmjiaXhZCvElBq1IqWljygbCDeAu6W9is1EQzhlyQAgx3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR0jOb0tBkJ/YkD0fh3SD5h400nX2dUp+Egk8E1WuwU=;
 b=Op47O1i3Nkl6XOow/M6iWapkxAaUBgMapheJv5IrnuwTah7QwnSXUpoNwfmdJ3DQw5pZrH63GUiit3Oq7qlv6guZlZg4jmFFzO3ocmAlvX6YfkODJ1NorZ+2VwyzvgpUeQNIUStkO/3xZmMZO3DWuj/P9UEjVpxkhl2opL5AHWETiCFZQbQ2Cjk7LCi+fXVcomX68FkD29a8f8HoCWYdtAkWK090e06nWtGEM27Ls0YVDkOeKhOnqL7bK8CJlSxgrSMnFm6l2MgvLLVVcW/5b3srGdjSaYDCM62Ch7PooCSos1zaMiWcdrKkuud8rIMppEx9jv5p4UBwkQcy268NYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR0jOb0tBkJ/YkD0fh3SD5h400nX2dUp+Egk8E1WuwU=;
 b=nXVxdzvjkC/s/0+hcVKdDUo7m3U+hrYqaqnYFVHa0yI9T8GBu7CmSQelMKJVHECvd8fdl4tSOsm85cAzUyUwguXyRKZGT2B9VXHHj0BmOmswbUBhVlH9SwKdTcQ/kZBpOJcfmVtcdoa7eRElf8dVzkc8y8BnKQvBNzk4dU2bYwPoFRZpdLiJTsIXrvlNAf3yQdFtPtJfuSSQK7Ikt21a3iglr3INuk0a/DTNzr3QarPDXzbHh7B12GecEGizwDiDK0vvC0bRdnjbkIACqqNfJGLdMTfIFswkqKkGhcsGEX84/6g8v8lxwCn3Jf2pwUb9ydJYTPpLkioFQcPujJTXbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:44:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 25/29] selftests: mptcp: add mptcp_lib_is_v6
Date: Mon, 25 Sep 2023 16:42:04 +0800
Message-Id: <2f5e6cae3344d7b6e823e461ced5de24c72245f2.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 00726cb0-3021-4aba-8c0d-08dbbda3a63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rJOXHOyDTph1Hov+jHR2uIujRsIjMRYTsdnvl3yTtUaIdkjofTJwyjxFl6n4uD4EK41HcpuLpaqCBg8+KxMD6lGIG37v175JvOxD+THsbKZOyItuTyilmFT4MIm/BDDe9FCwOH3nCVI3FSCAk9wg9mzYSnLxTR/iv6kIKA3wjBr56Iunpq9fZyjd8drZ+zuGXj+/8dQg3yaZC7Wu66g0gqbwDy9iszvkZAPYkpAssHossxqQtnXBNrduGOu8wp6uba9/GkY82cyS19eVqau4ceWei/z+nK4rNDqY+mX99J5njO20Fhdg0gtr0kqSL4p0vXa0r0MlpZX7hXTuxTUj2TYIsAPRMtjtPfqoNkdgomJstUV3odpXsxpauCAtxPhMg9UDN8f33yfA3nbWxNNsICHu+K2WHLlDPGaDum1uW/FsvROEdos/RN2kWd1YVsRyhw1AStErzyqixZiW+kOk/rtVwnRUKOnCFPioV93X8cWjEU1vtgdM7U+a3loByvKRgKLSd0196+9qQk30sp2ZFdzOYaKoB739xM2rnsf8dfew351STZ1L/FwsYH976B0X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(6512007)(6506007)(6666004)(2616005)(26005)(86362001)(66556008)(66476007)(66946007)(478600001)(6486002)(38100700002)(107886003)(83380400001)(2906002)(6916009)(8676002)(36756003)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/qevGvEX7FXmYz3d27hsro6pDsnLueHahTL1Eo+bkzEVW6io0e2npAfBiW9?=
 =?us-ascii?Q?Kd+SMfzuwwaXdtLwyHQ/5d1Ec9guJGBsZvL0bWqXV95cm948DGep9c/CCI4J?=
 =?us-ascii?Q?pjePOGszL9tpfjHc3chHk8FKc+5nImWQINX11XYw2zTb/LMblxkSHUBPlMog?=
 =?us-ascii?Q?BQXfvGegSde0NE/sUO9joUuwNMTecGYOdMwzgY88++kUOXTu8qpVEY/mUQNZ?=
 =?us-ascii?Q?bjBi0+Ew6eZRte5luuLJ9zP3R5PVttblsUklWRcOKJ5tJ8+1h811hAdD0jsi?=
 =?us-ascii?Q?FxP1lxSMO8MCKXRZXM0seu8dsIFDsgpGtUAINWvOZsbZhGR3up+JRLzIuxr4?=
 =?us-ascii?Q?aIMhhXAVr1Z71TBMwHOaJkrPT+AfnOa2mh5nxLmz+8V/zn7SpCfD8zuwIyhk?=
 =?us-ascii?Q?tH9XGf4gHDyfX1Wxv6s93ax+8jvYsjYt2dM/2FUN4mce3QAVDSghTearrFJR?=
 =?us-ascii?Q?HdfXlPvj2j0pyz1jNCSF4HwkUL35/ZqEIzllm6lG787GkP3gK4KjCFo+WSXn?=
 =?us-ascii?Q?TIyHAa5tGmI3DYxPlxbxix1Xg4bk4bJ/U6o1D+JGs0UcgZoNjPg/BWefPaJd?=
 =?us-ascii?Q?z13RLQFH1DA91Xig9rp2TqQCxI3SG31lGT8ysushxWesQfY/W8sDdV06b2YF?=
 =?us-ascii?Q?Bw7FkOlPaglHgk3iPIB9IRbjlX0maHUE4Ax+nveJ2vga5SORt4vpWV3a8yuc?=
 =?us-ascii?Q?8+hRV1zAHVJckh6g/tKJtw2S+FP8+4e7dotCqCFn9bejUv1wxh1slDKrorRF?=
 =?us-ascii?Q?6oD0xcd78UPOhyna8V4cHBlzkqlWPXuCnNn3haIonoRdK0wsg3aFoqPQAqP1?=
 =?us-ascii?Q?iqEU0eUh3WzlNDn70LLM2GYfU7vM4Uak+Abs0sOgrxDVUi4iVHwkqY334RZu?=
 =?us-ascii?Q?D/3Uu+kYJk69cuMS+XXRKdnvsD4woP+to72PmHguCD+vlQzZt2h5jIEsAT4z?=
 =?us-ascii?Q?+oppVGyI++Ycvg11c/xru7lUca6yX+c7Pk3ugdrMpfhANYZLQ3nfhAGL2abU?=
 =?us-ascii?Q?FA6Ry3gvFR68Divwb+z8jou7u+XB9N0wRg6dGm/lhBdWv1OniTXOGPgmSy0I?=
 =?us-ascii?Q?zfIeAphASvQclXPSMBY4xPnxca4JBRB2/f/GOWhMamVxkoBtXXS2PBKg6QJE?=
 =?us-ascii?Q?Mj/J5fgmPdrY0Fv+Qbys20FGBvRmPsXJ9oPqEdJEiMqHV/PGuz6crtPEFAEm?=
 =?us-ascii?Q?J1aSFnLabYw5aAy20PosYWkDI5XtndWWlmc9vh4mgtZCruQSIm9QahUhgheg?=
 =?us-ascii?Q?mowehLvuJU+udSkRJiUDe16Sh/JYVj8/kIJaT4v19r0DghP0zmuN+7e76g0H?=
 =?us-ascii?Q?R+WCg3l2Eg1FLFjTBKsTiu09zPpEDyRcvAzzUsySCSx59ml84g+m1HCNWOWZ?=
 =?us-ascii?Q?tKPw7DRvWGd/eti7GhEYQx/IpJirRCa9BfY1PtSPwmzfTL1y+F8FOqXT0XGr?=
 =?us-ascii?Q?zP5ZrV52bt/TQNz9ei6rZJ4GqKErsUvFsoNoHrhA4M5zhAyYgceydQrJQdIq?=
 =?us-ascii?Q?ZziDAH2EHLwwXBUdpP4l25bgwTbQwXx03jBN00txapVG/KTAB68SGpJr7CX4?=
 =?us-ascii?Q?5hQ5kqIMU3tNIfs/Qfzyf6Q+OirzK5pVnSa1S8C/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00726cb0-3021-4aba-8c0d-08dbbda3a63f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:37.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBY9IosJEWSnqazZ9X9YP4WdrXnkTjpy+aP6ZSyMhBFKhZebUC1iN/9+IuO3LcrCyLfS2Facju3ILwuh2078SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

is_v6() helper is defined in mptcp_connect.sh, mptcp_join.sh and
mptcp_sockopt.sh, so export it into mptcp_lib.sh and rename it as
mptcp_lib_is_v6(). Use this new helper in all scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 +++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh  | 14 ++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh   |  5 +++++
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh |  8 +-------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b1fc8afd072d..4cf62b2b0480 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -635,12 +629,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -708,7 +702,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -741,7 +735,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e59867eed5c2..8ef91a939c1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -577,12 +577,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -879,7 +873,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -931,7 +925,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -973,7 +967,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -3263,7 +3257,7 @@ userspace_pm_rm_sf()
 	local tk da dp sp
 
 	[ "$1" == "$ns2" ] && evts=$client_evts
-	if is_v6 $2; then ip=6; fi
+	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1301af71ad2c..91a17ae81cb8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -323,3 +323,8 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_print_err "[fail] $e_type:$type $e_family:$family \
 		$e_saddr:$saddr $e_sport:$sport"
 }
+
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a817af6616ec..bfa744e350ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.35.3

