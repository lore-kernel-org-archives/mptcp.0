Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6512612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xoQB7dTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMthuBynYIFUUQcRhqEjF8TY9lcYjsI/zS1K2rRSuBX12KOG7RZsH7ELlAVJUN4mt5kcdFm/B4GyERv/+Zsu+L8r3znH+ZUsa+/gSGED60aCmwfeYDsyutIwQ7cK0XNTpp6qSsECK1SYxi8LsU/bWdvFDqkxB/8otLf3Zwi5WrXRjqNAFQBlAvoiGXS3dcdYAwmY7kO/wDLNar1p869JiUUk3K9VPqUE/arhZQ/uE/D9qOdo3NU8Ar1876cZbPvpRlL2nvR5Umlfb19lKo+2jBCzxsUosmAQKBdtXuK9vPG+WbMYyHii1cwpYtQ0eaHJWS2yvHed4v7SV6PsJM8jbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiPIx91PM4eFoIGvm9qwP2zqSLV31oIvgLoyNyBYWug=;
 b=Of+RBJ5I0VFb+GUT4VnXGndsGeaZrdRKEJh9dDnN0SnH8IlAWo52fJHRA7f7UIVoRpoT8fOtu0hExo5sY6hLVJYPlsy/MrQK8beAj6iBAWzesNkgeuuFBcwJ8sPIgGQgeAXxs13xD2UohPRqt1PBcNUPWk6xf8SIxzaTiOeVWt7kuXETNzFDP0F0cqFmnTiqdYsw7d8Jwa9QRJbgGo2wbgrYS0eGJwdvkISS02F537KaHRDQlI1h73gQj4Q0CVig2Dj1NfeYurR3BS8vj6r+KKpvP8WDGCggEv5uzk7tKqHQrdt0wWCoDGlNT319xQ/PlVIog+UgznEAapKKxtRobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiPIx91PM4eFoIGvm9qwP2zqSLV31oIvgLoyNyBYWug=;
 b=xoQB7dTrVUa5QXKes0fiC0G4vAb/fftJG5Df7g/ghhvcxRQ2X4Sl9mF0TIZJl8AitAgQXN4cqTVrAMXlCS3nS05O/K2kwXnPL638d1189zF2cIQgnLUU5V8jHB7mHjyqlM6febUHF0VoKkvBgVjpWk2IfSyfXpzyv3Xpdy1/WRBLx63Xfbcz15zIYMlQ1ML0un7GWr9scTKHUUISe0epqQugHqVrYfSlNOcKpO7CV7gkEGWCkkzUWtGe2sqW1izx3KfKlO7iIDBK3C2p+FJOUYzp0eawxaqgVnFF4XrO9sRyMgRj84dmLXWMIUeV09h+TBGAGGqUhnexIK2Kjz5y3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 22/32] selftests: mptcp: sockopt: print out test counter
Date: Tue, 14 Nov 2023 14:35:41 +0800
Message-Id: <fa1bc505a2eeeaf89379ab487811d9693f8c0b0c.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a83927e-3efa-4a17-3f70-08dbe4dc9f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kKaIAUbzO/mzMkihv/fdGFaTeWehNAfUXzeflvhNpUgbahkywGe38zNlnd4DgEoSD+Np+8mjaeCkmVqCllPwQBJOY4vY7JTydZrLiISazjlVyd8J/coTAK6+sKRN6dY4nY9A4DAW4kBXgk0ig9FguQ13JXNH+zxoxFQuzkM01MTTdt6V9606n94mLzNaaCr89iYULTng2VuxpfBqYSE7r1dfCFg3cGjxiwIT/1YxSaLmT71yg+Vl4Q8p1VWml+2KUu5MhXD7BuHeZM86w8HsfKke+53fYJbmNGIt/TmLemmoou0dRxImuthx8YAET3Fz0tmYNPj1ytdqDDcqzhhM7Dm7ADQq4MNhBwGc0dw+IY7mD6rE0l08QCft3XOY3dVnK1+BFRgRBtmnUwG95Ov+zi5mfgEbZsgDIBqS6TLVH0hC52YCHdtBMpZ8vbeK81WfjAImaeDZf+ijmFRSYcsdUDQbq58DQ1lZa5NbnglNfbNrQrX16L8GYAsIutwGGcu5+slCpVAjIghssKkdKPnesXZvIy0DvBM1d0+I9t23gJfTud81PCFkULSY3sBZG0Jx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXGWIlJOUk9YJ+iDUuAP3+AI/Uwyjq3AV+6FzOJUcp3OdhGht4izEUVP9NQc?=
 =?us-ascii?Q?10ZW0R+MYi6B4KJlz739j2RKA185nSVtPLO+/d4PX/c9xQnihtebWNe4f0sm?=
 =?us-ascii?Q?XIovRaIYS2sUp1v9RTC9Tu2KksDc9yRz1e6BazXmpQbp8qdogB1qV4kEBPwo?=
 =?us-ascii?Q?Mm2BP3ok4CFsoF4IW3drJqyLBQFVh6YJHe576B5oNpWyGuJ/voQ6uIBcAVgN?=
 =?us-ascii?Q?hE7CVv0UGufI1uaBujZU0invwvFr/y8zV87rceGh0JsJ8WyFnDxfVik8/QdJ?=
 =?us-ascii?Q?S5UB4JpCZAvOolbltUHFgj4NiVuyXDMMhAKGUrNr7Mp2Uj0bDnfsqoqYDwOb?=
 =?us-ascii?Q?ZOB3tvN/dps7J+VwJP7B9YWSzYBCOZDaT5KWGkgChvlkkmHYPhTJ6HqixxD+?=
 =?us-ascii?Q?pFqXcj0qxy54nwW195CFYwWAEEdT9WOlqDEwwcPDSdQ+EMZ78nKuraPsGD7E?=
 =?us-ascii?Q?hfsh6iShBXJp3inqLwo0UodiJHhzUuU9wk4O0YlYgc53krGUOIbg7RjRuDv0?=
 =?us-ascii?Q?jrHBZxxS0WTlpoT+OJYUxibapqdS0FpM6H/zAB//v9cumfMXzHPcZjSjNRvN?=
 =?us-ascii?Q?bxhyo//rOnNsz2CVlzBWVz9stQKS1bh9qu8eaD9/d/gYEob49wUTy1t/vNbo?=
 =?us-ascii?Q?ZMEjxiGKHnd+bxkRpPsNS8hTzfxmdEniKtWvVpxcQNOl8LsRiaUs6UAyeMtQ?=
 =?us-ascii?Q?MFJqdlfNy/rgrTkNf2YVlZtMU7RIx1T/PUEcUsRQYcm7jvuEtk2w5iNiyP1E?=
 =?us-ascii?Q?+tFfHNl8dYNnoCf9Ooqvz/h38w50xQk0LakDPZ5nRE5Kl16hKob032gSzfjX?=
 =?us-ascii?Q?nYIQqAx6mrBfDJDB2nX4TFY79HhFCGP1SFCY3Z/0UyN6yHxb/8N54tnoaBtm?=
 =?us-ascii?Q?xOk9AL42TDUQJwqpQLrQbo37OzS3/qRhl2tzn4TuARPPNSZiCYEep/t7D4l4?=
 =?us-ascii?Q?T3YvQqQR1rBzcFBfZQRUEFyz9NSNysM68Z6/nBZTmg/ynxiuySG5wUj0SHOe?=
 =?us-ascii?Q?i/AcBhSLdiTo5rIeMHoZH9cXVElVYz0LCnPKIlxkx0nl4oXu+C7e0RccOsEJ?=
 =?us-ascii?Q?LXglf5eA0KDk8u61MF1HS1hQip9WwluJcH0kGUTw5rhIXAcr/Eh1xhVOEmKo?=
 =?us-ascii?Q?ptv4v3TdS8IgP0hxUEmrqhqazipC4Zo6Fzhw2ZTdylsYtHakHXTjNiSU5lcE?=
 =?us-ascii?Q?izetpM3lnZu/pAjOSs5p09L1mSDs4wBXBaojTV7j7+4TKleA1rARnGEFVmvM?=
 =?us-ascii?Q?BUDiXEm9Qbk5FdVSSvNp4e6H8UkTJHoDZufkd0TNRJPQVYJX3q7rvGbwJT0d?=
 =?us-ascii?Q?frdbR5t7o8ja4n6dgj5Kp7wG0OvS03lrN6KvrqrQYfz/TR1Oz5Yx3FlTVzfv?=
 =?us-ascii?Q?6a9lQx4sh12CNgP9XcKlFqArHYZte9r9W8uSgOZG+dpKGFHS6pDKIsHirE7F?=
 =?us-ascii?Q?VFkmKZGXfPhtM74melfXMeThvqtIVLc+OOYn52dQU3yUoA0rQdKZGmdPxA1E?=
 =?us-ascii?Q?RL+KTyb2QmFUlrF+tf39GHW1QnNud3DH50qAq7/XCU7Ge7jW1t5zuO5AaCBm?=
 =?us-ascii?Q?M2ow2IR9QXTiabLEw9CjYQyOmZEA4OiVn2QN4iW0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a83927e-3efa-4a17-3f70-08dbe4dc9f19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:41.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUOhKChwrcAyxGkGkTZj+qi9ZfNF0Tr4Juegz6zY4CjljkThJg2noASFSV//xuEguzTDVNOg2epz9vaSsJPAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch prints out TEST_COUNT for every tests in script
mptcp_sockopt.sh.

The output looks like:

 01 transfer ipv4                                                [ OK ]
 02 mark ipv4                                                    [ OK ]
 03 transfer ipv6                                                [ OK ]
 04 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 05 sockopt v4                                                   [ OK ]
 06 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 07 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 08 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 09 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 10 TCP_INQ: -6 -r tcp                                           [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index d03f9f9daa39..2aff01813058 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,7 +173,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	printf "%-25s %35s" "transfer ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -189,7 +190,8 @@ do_transfer()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	printf "%-25s %35s" "mark ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -236,7 +238,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v4" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
@@ -249,7 +252,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v6" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
@@ -279,7 +283,8 @@ run_tests()
 
 do_tcpinq_test()
 {
-	printf "%-25s %35s" "TCP_INQ: $*" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
-- 
2.35.3

