Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE05257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alv6QWlquTds02rHDwNb7T2yXShfWBvHJFowt8tkTbg=;
	b=V81BPixZOJZ46ksah479uGZPVhWgAIVCxcPqio5hyVy0SUi2Eq+0YY6u5aULE2mqQjnrRg
	5PTbQglU8I7A5Tr3tngJ/oYjoKlR0vSKwn1Pu63TwrWr5AryjegJhdixWMb7BlI65mKDs1
	O/mmwICAYXrBfpw8pDoPNcFOG2STf4M=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-53INGNjSN4id5Lp3Zf1mxQ-1; Sat, 12 Feb 2022 17:16:05 +0100
X-MC-Unique: 53INGNjSN4id5Lp3Zf1mxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEFEXYChf7BjTPlpCfONcTxIevfh0dJ9olmEG3ngT7xrw4ty2LXxiCwOfvKtjF57/BXb8ObBQDjm7mjO33jsmjgQVMhkV5LYQWF4gNUQhB3tfX0z4M7EBvm5chauoxYLWGiDkRCQcfbvxjbxhOKKn/r+uN5hOsWECstQMcRksUUf8+wbsTIyIxK9NuaaZ8yEiQbt4VLs22ibvdqqNnZhLEy9riU2+uXZ6o3sioJJiWVMZft5Vp2uZ7TiVQnnPYNdMYZ3zWef2PHvvGOeYnBcxPedwsNDss9URvJrjkQyacFAXLfAt9W+PkiWtmg/7PmiSiE0+yPrvUX3s0JPFR8O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcN58+sUeqYQ9tslgs5X40aGqVrwIXc7NksFcglXty0=;
 b=PZST8Tt6nrmFOiLnzPuaSL11EXpCLG3bdIzDR4kXM9G/k03SUcyK3ROv+ssUoCLW2485XXqrkiQww/S5umva0vfuC0Sl332yYo6MPTX3/zem7hyrjkanOBfkfEaK7jvgLJPMbq7VnBSLv+c7HrE+lIBpbMczWkWTIKzkZFSSakvuT2qK4esf2+GbvLqiO5xM5ZafyLPiuYwz2lXoBKHwQa6jfRbtmV7UPyQhzqHUjPaWHCozJ+Z73hc+YkoQbYgH3wbBYSaSGM+8yadhkYx0/rz/njIyUJMk2xXP1fA+0uDG61aMtdqo3zlUdLF5BHaQbeQu/VQ+zvgw3p9GrMXSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:16:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:16:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/6] selftests: mptcp: add fastclose testcases
Date: Sun, 13 Feb 2022 00:15:40 +0800
Message-ID: <9eaa5384986ccd5d42efcceab5fe722cbb876382.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ad1954-2001-4ebf-04a7-08d9ee42f75f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB65484272ECCC57742A7F215FF8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hZmBDJmd7Prl8tZrO7TeJcKmgOdJshcoXyeXkpkbEF+le5Y9LE/BKUQGiRNYGSrVOH8i9veVVJB676lWHfCYuVJj3so1alcnLYodAQb6Z8zkxqzX7lEPD9w6S81IEFl24vz/4NP0pQh8XNtBYoOmBqNNbW4vtvFibeUjL7BnO2k/iN2YujwSLwJQm76jkWhiQuxp5wJ701/KXzqxEOAhuW+CxinNUW1D9jxbvN/6laXweTlHVina3wSK0uj76m+oq167d/QzPVDhGAi3WVmjlVS70PNHXMlnW5X7YNPAb0R2ezsal0+57i0P09JYoTvtuPEQbivOYgOXa2Czoeyn2p1L+ugKezm0CYjvMxOUpQRf+AyHgQISKQf9elms2eVVeUwzZooRDn2edjwR8F8cuWuB0t9LbqMbHa5YQSEdktVkiKs3lsvsVgHcfPBP32k1zeNYA/1nS4VKs1vI9ivrLdApCGmNcfMyxOvLVMf//MWojd1C2cWgKcXsFUANM53Ikt1Sed7v5p1zoUAFNpdEUkSMksvF1sig7DObuMWjmbre/EdnKXZzz9oeXivb+UgwEvrc0zRFFq4IKTdFUkJYl5rTF3UUBtVgoVgSNMHBObJ0pfWkZZ1mFQRr3m7ARjZRIYFMLFPquvlo6BfDtoFs0KXxnpQKviC8Fh5uN7bL2MNasuuVwMjtrX8xdbf2a2BQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2D14dh4qOc3urKp+F2S8Fdnac6LQYfG/A+AM1H5c0AOI6MbXMIJgsGxJvikj?=
 =?us-ascii?Q?/e0IbkVuz2ESik7lg4OtiXSu5P3datCbDI5yQAnXCDvWSspxnJqd2e6ykk4Y?=
 =?us-ascii?Q?73KQZwye36HQSgQD2DGUwVM8aI9ZbYG58cxTmndaQ1lpl3vYXVQr5VMVHEr6?=
 =?us-ascii?Q?3L9K4jiiXRwKVqwBRUihL3PUO51Orysg+yXX8S6yjm0eQ+4iX14YDRIYmgru?=
 =?us-ascii?Q?+3uHwOOOeg+KWzx+pOyCQIly3QL1JR4nkLxYcgN3sTIQXrrYIAM6ryeSwgIl?=
 =?us-ascii?Q?u0aE68MnroJKfXjn20ONtZDN0kZfFQSKMx73dBeioGl3wLOHEtm+SO68NBL/?=
 =?us-ascii?Q?9fRXT5alkiSggQSsV5CDdbAluQXa1gvB2+PU9NMgDvQcCXMLoBXFuXshb0WV?=
 =?us-ascii?Q?TcqRQPaEx3PdSI//utO4DvWthlE/ScX8XjHfbHXZdhQl6kQBtnAYXHbZBC7d?=
 =?us-ascii?Q?VdoJbIBX563dGIqpqIUgVl+TDlSkXEdPkQh1Qbx5yygErOYyjRdVg0mO+gTQ?=
 =?us-ascii?Q?hZ6fZEiBnbcAGm1l+lLYB4d+EYsC4Yp897vgFOGr6Jc/jl6J24o7bvj2dctl?=
 =?us-ascii?Q?aYM57XyY0Ydr+AQOhKAD2jKy1ANc13ONhRPGYGCggtQQ7+4LncaQo701na7M?=
 =?us-ascii?Q?Y93Iv0cV/wmUHRJDc86XgURp4v2yXDuGWAA2W4eki8kRyH8r5TPNz9YfqnjJ?=
 =?us-ascii?Q?nIHFX/8IlUonDLimLZfPTq7vcBDW05tYYCdtCVxQuHNP+AiXOlwOAMre9Ivd?=
 =?us-ascii?Q?croUz80N/tELuK5rHKD1QMcH+XQRI9KcUd4OVtwupEtN7b9AJmZMabPEnX5n?=
 =?us-ascii?Q?SSIkdlX4jxaPzfPdII13b/70aLd3/ida3kU7pH4BxpLZ22Qs7K84AmiiQPGR?=
 =?us-ascii?Q?8QMItrhaS3EqxAncakSQIiEuJCEUunf1UY9mU8Uqe1MZzoyAo+p0JlQ0ebYG?=
 =?us-ascii?Q?4c2KmZdZx+gNqmctwCOa88zJBkLQeIRwwzt6vSUm75Eu5ByTTyZnEtGpDLme?=
 =?us-ascii?Q?RrNwsBrjnw12juxvXoiMEmpo22fmRU5PylVHdQQQ/Bhg9jbXJINygMMpzrQa?=
 =?us-ascii?Q?1y0LlfFfDB35Cj3albwZ/l4ZWLHxWP8AWI2ZKaTRNpEHqowbMcmQVk7r83Tn?=
 =?us-ascii?Q?LU4ghbVretVlISo8ldJCi5CKDYatntLakLo0QgDKJ2wWCzUxdDpvIJE3bJ81?=
 =?us-ascii?Q?tSIaRonMnaslknYLlY62c0Hpc0/aPnp3+vHFIDMHPVUWBDd/RgcJMZGW4Tq8?=
 =?us-ascii?Q?BmnMDzPa32YjH4zmdASGxtNc6qTL9F43u3BAjWzttn6zgoAe6RTb5DMkth6y?=
 =?us-ascii?Q?JlWBKQQ/yoawegT8+6A2io1QSF1v/A00Mfxo54qJJYWlzFXvKCpCOkWlAh4g?=
 =?us-ascii?Q?9/2Sdqm6Fc3uN8G+q3yfXx+8BID9dlU31JbXQS6WbhTAf5JIUDM4fv7mJoTw?=
 =?us-ascii?Q?Ylew/BqNVuJ6akqTg9NUWvsQ61CDBRrOhaoI/BJZkQwNEukTBasYzZ00gomD?=
 =?us-ascii?Q?7Opxx3zaCZtnqBJpIj3s0TwDqAxbUe9GKLVnHBHO8n03tEF78d8+w9+bEmNx?=
 =?us-ascii?Q?byZvcYsm9DsKuDMXLoRDHSZtcyua/zeo88kcPjV08CvNjA10BpXuGoYDZRtA?=
 =?us-ascii?Q?tHKSLYd7NfMjyAsI0mj8RIc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad1954-2001-4ebf-04a7-08d9ee42f75f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:16:03.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bwp4bsHSl1iH855WllwBaYdF9ssCR45xls/b4IBZ00EosmjgF41/f9APohfCkKdL0pqSNAJw63xCb1hw9aSq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patch added the self tests for MP_FASTCLOSE. Added a new argment
fastclose for the function do_transfer(). Passed the extra argments '-I 2'
and '-I 3' to the mptcp_connect commands to disconnect the connections to
trigger the MP_FASTCLOSE sending and receiving. Used chk_fclose_nr to check
the MP_FASTCLOSE mibs and used chk_rst_nr to check the MP_RST mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 5321cab1400c..e4f4117fad36 100755
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
@@ -2277,6 +2286,21 @@ userspace_tests()
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
@@ -2295,6 +2319,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fastclose_tests
 }
=20
 # [$1: error message]
@@ -2322,6 +2347,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2353,7 +2379,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchzCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2403,6 +2429,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

