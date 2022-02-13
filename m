Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431D373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8N9fmKvFPoLFvlfQvK8GS/xGzt3Vq64eUt8SG5kMYw=;
	b=iDW80pJ5C4RNGhCFKRvYh8f921LEg++/X5vpgFowwyOC5uKmpGElocNXr6eVSSrYF++KDK
	05xLm1FnIzQaomwIWWh2c8Tf7FOdxNH5I/5uovpeG7oid47acrPuPWjboRemx7jhNyKRV6
	XhRxPnxweQwC17jEWJbgLO71ZMNDtOQ=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-kYu9VhPXNAWuowEww2vuXQ-1; Sun, 13 Feb 2022 15:50:51 +0100
X-MC-Unique: kYu9VhPXNAWuowEww2vuXQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDCnsmIlll5dDgUo6O7su4yNcPW6xuYQtgUaTRiGo6T3fcv9DR+fED7Mh8hoctJmNfnqQrEOXF7A+zvVsVDIarW0il23TtCqku64x1DKyk7LJNj6wWXahGrmBfjROIJJLqqsB+/jloef1Qo8p3Men+nqjKJq7epJOMmTzyd5vOZSfKZoNKRoOl95e4I7N+1wMyTY9dHSQ4vZRs/6gD87Q8GOZ7R4h64SBLK+tYJTTviUzu76Hs5ZN51H29ymSsWB712FUvic1uwkZ9lFTPyMROAmTzshdqupw+8Z+Bt2aCqpgebJnIA3GQvdYlEDE1R/4ILCA/K3TvHsFYFOYv1wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT3Y2XmdtPFZ0kYmf2JdaoETTSXvixTcet+8wQsASOk=;
 b=YZVKE7fzXeMtbEck8wx0ETvXEPElHcPmzlIi7Ux+641HAmyX0zODKpuK7IPrVHsXSmV1lJOpFjHtcYBWwD5pzQW1fC6T0B+w2F9s5WF5nq1WljeTzlnJBG8IrzyTZHSC47TvtFPIM76F09SguXuqBCfbUf6DctZ8qvp6m9hCekiIQn8E5Dn2ekR9EooX2ht4JtfLxVtqwO0w0DdG/s0FtbLFNJt6LUPOYvtyu4LeL2kLn2eZ5tEMc4J7XS+pFFQJWBMHs31PUROtsl0F6EBiUZxuQtvG/KPeyY/el9qq5Rurp/CJQbICaRrQM4U76PJlCIUg2m/8xHGxH8GUP/jx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2384.eurprd04.prod.outlook.com (2603:10a6:800:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 6/6] selftests: mptcp: add fastclose testcases
Date: Sun, 13 Feb 2022 22:50:36 +0800
Message-ID: <98edc678127c5f44994606ca3b3ccd9fd0e20669.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78be513f-47a7-480f-5b69-08d9ef0039d7
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2384:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB23840F95F21CD97120B80DDDF8329@VI1PR0401MB2384.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sevRwt4IU3p+zBLTrfgVqYNBeWm89lYdk6p6WcnqXIXv7IrllzIpwYh/tKWSfUJXfLi6N1BViaYoxNW6fEEFRqQmjf4SmT5m7so4jTObrjvWG+2o2bOmPnD+OWJnT6ECzMDIVvOxIxYP58/WE+A7sAFF8OGcvpOwB/RuvxfdieT3XyXSntGuKzIR43KO7ga74miXB1nbGrFmKJCuSsC/h8kWyvuSVCuYTS7+S5vN3tAZJghQ44a8Ev7ww/o3wX55dHilCt/S/Cz0jD250f4ZgMXDiV5to7V0VmfVhaUQtIcpMVEVrllm+xtqQgj9MKx9hZCu4XzwRmudHByu6AYNdiWua9D5E+jJ0qLy5kP5hlS62IqH5d0/LtCz7PoLqfpT7S3sgu/6weDmMzf4nqpb/BoaBFPQM8yCDZe6E8Lj/b4ZBr4ds/erfIITOoxI39hNPrXoswOlzsTgSgxxRHD9VXvvlk960TBepkcWGSgTMllvZS08v0GCiOSQSL7LhJwO273Y4DbHBf6JxB4K7HW/fBtofatY/7BQXGGgNHETSZsxl82/7pHKJS5UVpJuhbMXTeT3Go0hDGuiWFnutP0yLMYbjRAC66MQ6c6nTiOmy4gCKwHRyosL3Vfu7JM2/ilpZVT6mONFYKPpEOOmg+E1Hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(316002)(6916009)(6506007)(86362001)(66556008)(66946007)(66476007)(6486002)(508600001)(2616005)(8936002)(186003)(107886003)(38100700002)(83380400001)(36756003)(2906002)(8676002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bojt4oKagKjppI25RHRUdGuQNF2m+OtLUshxY0rij+laedORFCng5NuXErSl?=
 =?us-ascii?Q?WoqzzbmR9IHqWF+Yl2YmoapPS6bpvc8sPuosWkgkVwK1f6dFis94P86gnISi?=
 =?us-ascii?Q?P6aKa3tT/vLwal2+Himt6fKcaYVMGKsNYHfxHPQS1Y01pSa5WeK2TIicmaZF?=
 =?us-ascii?Q?HU4cnWBqAhjejkOmzp8PAfyNelIZn+WAninUG+WVgYNkHs+3UqCRI+lHJqkO?=
 =?us-ascii?Q?+PPesQ/bRBIcQGHchGpHRD5cUQ926V3pU+nwX0DO+w9ys3lVLPEG2MubOhOY?=
 =?us-ascii?Q?T/d0zGQIlsym1ZtuJVn/JvB2KPC0Gg1L4O1JLCm+m7j1X3sPGFkjQaHnmxL0?=
 =?us-ascii?Q?5OGDVTsAx4rXen/P/BOqrD2+WpvcD8dEI5Ay4ny3WutRylk+Ogzh/T8vbakT?=
 =?us-ascii?Q?v4iIvjcJcDUWU/0lPPgqXqu7Jz9Ax6ck6WFVoWY2XNhuso9J3xqJwXWzk/S3?=
 =?us-ascii?Q?Vd0c+9oVhuPuI/phvupKONhbzlKcYiUz5B3GSbhLsMk+3aj+3KbuixKXoTkZ?=
 =?us-ascii?Q?vt2K7Pre+omQHfG7tDSMXBMPql1gujF1LhtG4IMGf5f6NA6OeY2XXHy7YFru?=
 =?us-ascii?Q?4F/wZkitjiXJwi+u0lZxguVkOFplAP44Ywi3JvwDvrOjunHTZZlquMoWRK2Q?=
 =?us-ascii?Q?bgWeY6RpIrv6AqeP2gccZVumgVBGfnhvJHRSLgfdbQjKgoCwoLYplCHyLlZg?=
 =?us-ascii?Q?LY455utPlrEsYas3rLonOOYAyHjmZu+j9YmpB8MIB9O4Dfm3E5NRcq0JJSYh?=
 =?us-ascii?Q?/5xMAm1lGZS65BRNE1FPpaQm/ZVe0gxmDh2aRiObXChxAbmKO3zwNxcCT41u?=
 =?us-ascii?Q?h6hT5EiA9Blm7NQsoK7twUj1pXVUG0eqHoc+gJ+taiE9zEmdnVk4G+YkxC27?=
 =?us-ascii?Q?Tz/JOV17HPFfgFZOWroo9Z7EXSUQWqjaF29E5d8H6atgPf/GfIfujdCGEve4?=
 =?us-ascii?Q?4J6Cv0b3+iSuVEJBcmLvVlKdsRDRw4qcfPxV3HvxYdJdPDhc0h2hso4NjQWl?=
 =?us-ascii?Q?6boZWq6hTG+8XhHOPdaEwfhOHHY5MuCWZhuvMss9xd8XrU9Ji7Z8MXD3y7oz?=
 =?us-ascii?Q?aNTr9w02NtLOnw7PljvAx1W2Jbhy4Hw+0yk66Tz1nTyEkqRNsS9ZjhPWby9h?=
 =?us-ascii?Q?VJjVl1YLDR3yFXTUe1Esno8FutaFTo1VHpnZci69fBSnhddhdiSkyI6/W1fZ?=
 =?us-ascii?Q?w0c3zdNBhyhYP/WQgeb3BUuNYyA9b+ArH7m+bIZxswAOnPmWEBgKFRtbxMEo?=
 =?us-ascii?Q?9qO64krennLvITRGlfLPZcCIgOaxu3y4LwiOSXEGdpLMauFULYhUSIPy04Av?=
 =?us-ascii?Q?ALoZB2p0P+P/Mi2H6vMKWaW8IgvNPlvRIh2wmuB43A96m7jh+Rw0EM54AiZQ?=
 =?us-ascii?Q?Wr3LtsReOaboZVOr6ljugIUEzM+B6LICR530dpcNbw1xzsidimC7PBxpZnSm?=
 =?us-ascii?Q?wXolIdNpiO8WSDyeftgmMc2tkO1SZKkxjcBD2k3/nrxS2g/6NOtJ1m2X85sc?=
 =?us-ascii?Q?wlb5S/QaqKi87wcsHp/A1iRcktPyr+eaEt8pe2312JYh0fb274MmKQZdyrM4?=
 =?us-ascii?Q?WE1MT5xQwMRv3gVYixobc56XVQ4DyREn7AsBopFicMgiyTR3pA3M+1ZT7ens?=
 =?us-ascii?Q?xGbpM+HQzhmT8u+8Yam+e/I3LzkEWrXDix7G6RZjIlGVtUtsK8g48XOiK8V6?=
 =?us-ascii?Q?Y1MhA9UB4hJCIAQHXZIXWw9txTU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78be513f-47a7-480f-5b69-08d9ef0039d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:50.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARQaQW7ekAoJSiKNvyrPowK9fUIYi5s/H4Kq1/sI9YSkV2X0YWyUc/AnuRMrzoFyYWIJctAUvbuVEKYAP6882Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2384

This patch added the self tests for MP_FASTCLOSE. Added a new argment
fastclose for the function do_transfer(). Passed the extra argments '-I 2'
and '-I 3' to the mptcp_connect commands to disconnect the connections to
trigger the MP_FASTCLOSE sending and receiving. Used chk_fclose_nr to check
the MP_FASTCLOSE mibs and used chk_rst_nr to check the MP_RST mibs.

The output looks like this:

001 fastclose test 1              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  sum[ ok ] - csum  [ ok ]
                                  ftx[ ok ] - frx   [ ok ]
                                  rtx[ ok ] - rstrx [ ok ]
                                  itx[ ok ] - irx   [ ok ]
                                  ctx[ ok ] - fclzrx[ ok ]
                                  rtx[ ok ] - rstrx [ ok ] - invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ee747f4a4c7d..2fc26fe68a9d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -424,6 +424,7 @@ do_transfer()
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
 	sflags=3D"${10}"
+	fastclose=3D"${11}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -462,6 +463,13 @@ do_transfer()
 		extra_args=3D"-r 10"
 	fi
=20
+	if [ $fastclose -eq 2 ]; then
+		# disconnect
+		extra_args=3D"$extra_args -I 2"
+	elif [ $fastclose -eq 3 ]; then
+		extra_args=3D"$extra_args -I 3"
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr=3D"::"
@@ -607,7 +615,7 @@ do_transfer()
 		fi
 	fi
=20
-	if [ ! -z $sflags ]; then
+	if [ $sflags !=3D "null" ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			pm_nl_show_endpoints $netns | while read line; do
@@ -698,7 +706,8 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	sflags=3D"${8:-""}"
+	sflags=3D"${8:-null}"
+	fastclose=3D"${9:-0}"
=20
 	# create the input file for the failure test when
 	# the first failure test run
@@ -725,7 +734,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags} ${fast=
close}
 }
=20
 dump_stats()
@@ -2285,6 +2294,21 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+fastclose_tests()
+{
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast null 2
+	chk_join_nr "fastclose test 1" 0 0 0
+	chk_fclose_nr 1 1
+	chk_rst_nr 1 1 invert
+
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow null 3
+	chk_join_nr "fastclose test 2" 0 0 0
+	chk_fclose_nr 2 2
+	chk_rst_nr 2 2 invert
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2303,6 +2327,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fastclose_tests
 }
=20
 # [$1: error message]
@@ -2330,6 +2355,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2361,7 +2387,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchzCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2411,6 +2437,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 		u)
 			userspace_tests
 			;;
+		z)
+			fastclose_tests
+			;;
 		c)
 			;;
 		C)
--=20
2.34.1

