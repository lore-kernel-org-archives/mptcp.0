Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B01388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVsvY0FGcvQbZYEOP+p5wf1KQESjCbxLjtBX+tOU50o=;
	b=RNh9F29pKFaygJIsXOAZpzkXympWRuNnDF4RGOwRjIQaEl33Io6/Ka0a+fHx5dsY+yx/z+
	Bdv2TCJLKuS5TozJqySDO1Ite7u2yUkNw+UDfYomycDT2YsW/5unFHP0iRdhllKQn8X6Xl
	q0W2oaVyO4kvAfZsFZWGoaCXz/l03/w=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-A6IN-i9cPc2WYvpvFTVi2w-1; Tue, 15 Feb 2022 12:25:55 +0100
X-MC-Unique: A6IN-i9cPc2WYvpvFTVi2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfxIPMHc8skEzarvC3LLk+Y1eeMQf6RcRWj3s//hMdpjCKFy8/MvnL2Ohgds5TVMeE3yn/4/CVp6pWJy1MwgUIXCezZCZHxinuFSOG1qtjY7u6IDB+Jy9Cy66OVdnc5VPgxCUvurXKK6A2RLH03Sr+DhVZZwtSBDssIju+t9hh4alslQwo4hAojnmIubGG6LGlsh08OdEBS0/JrgL7JBlaIEuVJK/z6fPF01tZBlPJmdS7HjmiJad+2ETz36wvUs6jnWWN8+iHgDEj7lPVADb00WJg0AAeosoQR4YAwIW30GBAi/n1Z2/rMuRmGH4XXhLpuAKXDRMlrIFp+9923C0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5FayZXx4Dy8UfTKzTWeo82Q4Xsjml1HXtRd080vj9E=;
 b=nvufbnn0Isa9ju6xOoLm93gZSQUPqH0qpyiQy4Hojk3Sl3Unh2f/Ynvrlk/1Q5I54isjIVQtE4gnlkq3niA7nTE2lFa7NO1BslGDDS7AzJ7dbAs7X/E6CPD3E5eHne6b5yhzx/Tx12G3rPeKOG2mLWImbUYDuX+vGGnL1/CwbpdWgtiDwdpibsJTo91L/QRB543G3Y10wbMe7J4ds8VR3RAD4CzB8pvCpP4wWNyUzLQzJMGsHaddndQj0uIs6rVsTYXM7mylR26pB57naMPHwgZsXManwzmP07i4QGQeRrIZ4sZYrmKDHAKtmTGMqBEKfuyZaJfjC9m/VfNFv+uTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4563.eurprd04.prod.outlook.com (2603:10a6:208:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:25:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:25:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/5] selftests: mptcp: reuse linkfail to make given size files
Date: Tue, 15 Feb 2022 19:25:53 +0800
Message-ID: <56feffc2bd83a521f38c0424768441aade4580b2.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce30ed2-d26f-4646-5a7f-08d9f075ee45
X-MS-TrafficTypeDiagnostic: AM0PR04MB4563:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4563D0AA9B0D673B70BF3443F8349@AM0PR04MB4563.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jWIngIO3IkluQGgVFf5iZSg+LFxp/awiY6/EDgrbLXB54gT9EuZw0fxq8Rcv7gaSsZI/+uDjWhxob/PLWqt6UL8jjN/6nbRC8SXugjslB2LSXwhmnALZ3JXOD1bMWCxyYCNAPoEaAHKcep+jvjToPV5NQ2mIfRaf7tJ0v/PjH+wsa+VRlupXNJutsZzm6qVRWd6hPXfP0LKfvMdbn+bJTloHH3/XbuQMmd/H/4uWnisq1S2xhIs2VYdqfMgjw0sBsD4oFiK2d7mrTSlawU9B2w7Dd8+SfXhb2dF6oJxT3hue+uPfsEOCifKf2nU7Ui/lrJAJQBsiRo0I4juuG0JVFRLIgL4y4tEAJ23jhUiTZwNu5Ldp2QC7zOC42LKBwrlyLrfZVIb8yGQtCHUdHc6oTmdAKYBh8ufka2kmh7RuzraJHJPPC9brYDfdufssmPd3uHM6+uPx6aepTpQcf+EPCqLY1gvS5bmto9QVfJndwOlZAufAIOmn/gILg2ApTA/U+AABVvEQr9ATaAP7Zq7fryMOW+/C7fvWS9udmfzOyOSaYhttSxbtIMjFQSt2thDKnCM/Nu6rTDbSw/7zT3nKhIS1i8IzpL9z9EvDBHIkghNsXczmUVWQnyeB83MRZCyek6LVx6qVE+ehifEKfjvEp1bUjhgebwB73RwI3wHF0F+oEGRe8m/fuHJb1jaTqbuofcuMw5Qo/Z2Ch0+zKdA/FQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66476007)(66556008)(83380400001)(6512007)(86362001)(66946007)(107886003)(36756003)(8936002)(55236004)(508600001)(2616005)(5660300002)(6486002)(6916009)(6506007)(316002)(26005)(186003)(2906002)(38100700002)(44832011)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/roKvTd5eRI+4tAqcwTitb7eA4TZzzjAUFIu2C2gyuab8U9t4XvG6cgziM1?=
 =?us-ascii?Q?gerA4QZargIi99/t7782PAPFOhy6eIHf7SHo9KqRW7H5SGEzPWJJclW4oKKM?=
 =?us-ascii?Q?uZS7kpyZUznpRAl3boX38P4fblwJRvxfaOW94JJvZy8Rhv2xoQ6Svih9wQh3?=
 =?us-ascii?Q?IsdUaN+7EtZpGGr2AugMdsvpss6f7ctK4uAhukf2Qr9Qua/Jk1ZkM0Dmvy9w?=
 =?us-ascii?Q?SJdtmU+XX5VlLWSVWip2M1K0vpfIySOeCahOvMQIj6UWcbGq/01G0dt/aMaN?=
 =?us-ascii?Q?H1X+2Ag8mOjU+aANHoKNlpZlgWoGMUKWtHlJfrTAUzbAEPA90DJ1BhuLjRsQ?=
 =?us-ascii?Q?zYdQEUcziERm1HwD16KMWZOtZgt9fb1kQNhlMg6qGRBdQZr+YqspfvN7X0Ea?=
 =?us-ascii?Q?6LMDRLaUqT3lLZRRQUAgZun+4ce28aT9A5RET1SCM1DUIoCw09G6f6vzbuh3?=
 =?us-ascii?Q?p54FSIyaC40wIN0VBShC7vbHcPEnhysLiPRvcWVUFRNOuy0Yu9Dj6a06DH/V?=
 =?us-ascii?Q?Bt3nKNzHVT8MuZs+GnIXrHwJ2EGGw2oVHOj75b0fLd/4thAejf7reNaL+etn?=
 =?us-ascii?Q?3FjutUplV5SyRVhU80rGMGwIAGWMQtp2Y+uFRFFUcFEnfQU2rSK77KGlUXGC?=
 =?us-ascii?Q?Kfkn/BDJI6W9Ede3fcI7apDDteRhmH57p3Wtvhf5uipUNiuc007Jb6OdRc1Q?=
 =?us-ascii?Q?lKE/Jl/LDa8Iad24NLgC3TifqhH/8y0lFkqF5iI9lav90nUx6j9/X9TnuoTf?=
 =?us-ascii?Q?k7ObJ8rx6lZBuriZ3S+k9Eisy5SrebQ0gDjzKIoHHKndbGv3b2kh/lpvyJzg?=
 =?us-ascii?Q?IewoaYnIO+adLTISF3mwmzfWcBTGEAvWEWSLPIcecfRTqA4d9SSwYhvhJmRN?=
 =?us-ascii?Q?7M3H6xSUh551ffyTJmhFqwr2Ywx/Fj6BNUXI4pADSnIrAAzP+wqvEWjiCxz/?=
 =?us-ascii?Q?zeZk4HTXIHKWfJ8hpMPWhkzKB8+jrbM6pv4SyoUpwCG8OBrF7+kDhvkS2Pha?=
 =?us-ascii?Q?EFAhzdFDJo3IDjvepjk4osFGyX6ww9tZsAqAarbzVIKwl1VSy5W9YR2xBvuZ?=
 =?us-ascii?Q?JX/spEXmeHqBS7dKz5+a8IEcCUhFrd1AIvdlRuIJCzsAET0a7FkrZkqVYvZh?=
 =?us-ascii?Q?f3O59GHQqlRJqv3eFaUnNZY1MYEpaVCmMfCdcTYjqy87hOqahKHJpW8QTBnN?=
 =?us-ascii?Q?m/wOFtoWbtn5DLRTEsBMwldqnu7XKrwL5giB4+Cg3uZitMN8TcqYeC4Hyn6O?=
 =?us-ascii?Q?ObP8eHt0O422KoHlFCMj7nvkF1UJSYVk1OqQ7oOByS+wauMGYen0woNNbtkg?=
 =?us-ascii?Q?jnWLWoor0MPealD9S6l8ar4LewiRC81Noyz8y12Q314braaZRMR8ROn9RqVQ?=
 =?us-ascii?Q?RS+zR382EYhSoql5w/9TDIemyN/PB93tD+xvUS0jnz6zVIEeDH1PelSXIGEB?=
 =?us-ascii?Q?gYKNonfgU+/Tgl4uxp9VyktzR2s2gnu+1+8ef1Qn+xIerZqohyWNhsDnBJY6?=
 =?us-ascii?Q?96+Tp3Ko5gQLb7GU53RJD8o3a2yRZpyCv84ffG7XjTQCmqAr12Ih+gA3pfcj?=
 =?us-ascii?Q?Jf+fGJArRxzndOwNKyPZK/V/TVPOZ8Iw5v9PKN37jCH0qAt7BzgBTAFWaNQp?=
 =?us-ascii?Q?+ldFsxDrW57f0oj3JdmVXxo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce30ed2-d26f-4646-5a7f-08d9f075ee45
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:25:54.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxR6H+a3mn0ibZ9D3gjsmAHT9lyJp+qBhg+I8Rtdcc7nayTYybznpLtOlKqZLdVPZtBoPuYRgvDL0p925yESeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It's
useful for the test cases using different file sizes.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ec8d750c19eb..26829fbbc67c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -475,7 +475,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -495,13 +495,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_args $connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -661,7 +667,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -706,9 +712,16 @@ run_tests()
 	speed=3D"${7:-fast}"
 	sflags=3D"${8:-""}"
=20
+	# The values above 2 are reused to make test files
+	# with the given sizes (KB)
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" $test_linkfail
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -721,7 +734,12 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" $test_linkfail
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
--=20
2.34.1

