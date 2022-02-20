Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AB180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCkMRXkCWgc67rO2c6COStZSQ0PhrnC+sGI0Kkp3NHE=;
	b=BDd7+7x7iKvsCc3jY3lQTt89ZU+8/gigUOjymV8vG/tcmngfY0/rV1SArudhZXCO6Gj3UI
	lY3KjPcTcDo2E9L5arSdJDCTOrDXvD2ZP6seE6f8T8lUJuL33Wg18ietDi6talR2hN3EZw
	aCeHH85sMRtoGrX9jxuZYc0E02BXODI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-awK9vVAYN_2uIJl1OAz62Q-1; Sun, 20 Feb 2022 03:59:57 +0100
X-MC-Unique: awK9vVAYN_2uIJl1OAz62Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig6ZB2/JmyrWzOequm5b/26H0kt2St3x0ilxpdyzxn32qtmNAgjo+YJDdqYsbD4WgcVYnFWdDIUN3xUq1UdSSD1qRy120eoHYHv6INkvp5pWEvFNpGHEqnWvnJQkH6jZuLTshQiqzYX7DG0nGyPnTilCuael4r15UqKrwgNmqMj9xthEDvYFoPpfZgMQwstk+TOmn6am6puejMaaYdnVUCR0zXdliOeeICfJV+q02YZUNdjnqDIsj6wORcdiITfbi74a5413iaBcdVZq9ZxCVuvjJFdqprB3hEVFd0VgiGu8ynbswGiKHfr5qMVy3tRRlufxVHr7oQL6YE588WaxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JySuQqtkZMu599oeoWXGUxZsFVo64NFJPkDlOrMhAM=;
 b=IQVT20aYug39dI5aQBPIOT9tkdNJwgwfJ97AGfDT4QxJQR1arWwsYxmS+OXfq/N5oOiZoEOdbiyGrRS3ZlbGCv3d2FiPgkis7HWL8aM2mfp8MDWOBEtjOMMjvKCOwgfiRuhRR/psxPrXxOaqdQN5YORx1avZPrt0D/Q3TARD5P+IwwNaKRihBzUE0C3ZSCGG9QRp2+rnmYgJ2QuAqZdo39Z7peUnesSL/Nb3HpDA0jerSo276Ml+mPPvIDjoKgjNLtzDtuqD2183SfCi4SZv6Ll4DvAH8zz7nt7QPvVAIs28HubIpcEA6DxwR+RXq2zg/iUo7GDV9PYBlR0FLeBbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 06/12] selftests: mptcp: reuse linkfail to make given size files
Date: Sun, 20 Feb 2022 10:59:32 +0800
Message-ID: <f16ee5948eacf0b576c429091f6eaa6d8137b2de.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ae9aa8-a76f-4d7f-05d4-08d9f41d12d5
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB34149000196438B523336BFDF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ucgZ8Q4z6Ax7MJcBLFD04lo6gI3kMPT0YioMSUGJIPj6BrBMiMZsQQwf+lBV01BIVARH2UizUXhKc6nB4k+OsyFM5J5LLsSPoqvoV9IALww29csdheberZ9nb2zH77mHcfgggTu1EiGOe06OLYG3mEZD/1MjTFsVDQbO9r5fnInPxsaJhHIhD0DR3n/hBTSe+DsBpTlmRPhbZj/rjGygq6KWfgtDsTrUPps3WHMfIurm867xoDmNEMCTrOujFgUIguo5WTnLC8t05OaM8tBAXAG6c6T0ItlVVzFni9ZtoXjx8BIUMV7G2FROdGtIKngAnNsyWF5J4hsZ0dyD++pUvcEkGhWv36V1JF+KsMjlVcbWDUz5cWPlcwk41/U//1q3756t/E++rdQe3R5I70SERyuLuOaaAM0JJd53kj5asl6N51PfKl+E8jGe1QHk+IrBHt+BA63N7cvA2ba4FTBl+/04kE6TZyl9wm3VGMqh++4GIyE64WYk/WpVDRTF08sY8PynSw+LRmYjiN30bbfzBSEij/RSvNxosBRzjPEdjFQFNb3+RlmJ/olcQ3IZIX5CFLpln17XW3DAg4oswu2Bx4ogBFWwbZl698c3Q7buySOunBifIoVEAC1rXBBB138T7sQVBojkAHstqnjmYvzYpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFw8Cn6TGb29q0dAaUi80DTUNpM7oYiW7rczovFg8u25oVQ8ZOeuNH9Ih9C5?=
 =?us-ascii?Q?Sis5ySe0WVQ+zKJG5PtcYqul3wWI6ul9CP+5EN5+6k1wTu03QdohXnp0OR51?=
 =?us-ascii?Q?4jzi90eLHivj75FViLwtbQnXLwICm3/qr7Lf9rnANOw56Yx+6YXxEfBGME5u?=
 =?us-ascii?Q?kA/baFvGPW8F++ej4FQt4ThUlgfKCVKzlG0f7MAfFvIIfHx9YkjIwaoIHA7M?=
 =?us-ascii?Q?91N2+qreENvAVGOacAezS2ni+O2tmfB+bhhF4KgwKpGUvX7c9NlqcwxZ5YSy?=
 =?us-ascii?Q?3/d0SS36VQHN3RfcI5lcpSMIX/nVLTbry1b+5JJbmz2QcF3nhFd/bP9XyAp7?=
 =?us-ascii?Q?u/gOEiJ2FBWbEKKGiqIJBcoTHH8vjt7x+PzpUpEvL5zwjncHjIZB++pghTcS?=
 =?us-ascii?Q?YjOrNoJU1CPv9HSwJ1deeHlo12XsD4+eX8BhGLb6TAzayjMdLWKSeTg8nJmx?=
 =?us-ascii?Q?vI3P+OIV4jemPrawjgTL2h92Cz8NRp7zjwfMTsdbC7P6sGdIX+qGuEhb8jvN?=
 =?us-ascii?Q?n1RSBfDmzDUvpZVszcoCZFs4FOr8UejIEiGlLxJTNS4YsVwg171eVRRU5bZq?=
 =?us-ascii?Q?iHgdwc2Q7EHSrKWvQRpbRj3l1YbY8w1UJfpZX03zNNX+1rJ13/Fv+aJinLQx?=
 =?us-ascii?Q?/tS5ecJ8uaGZvQ/4Z83b3ArNSd7sKwO/0qBZUNFunXNF7zfDlGF9WUm4hbZ+?=
 =?us-ascii?Q?FpKioL6oUEf+X3dNLToTrcPk9BClehkmnE3HyU5u2X8vCKTKmFBGYSF5CCBW?=
 =?us-ascii?Q?nt5PZZ40o/19uDmnGuiw6sF+K4rqI06XGtqesFX9rro3zrJgq68johz5TRFg?=
 =?us-ascii?Q?dhYzXh1lt8h1JqklbYmx7YdfxPKjt/W0mybiyKxGajdYL/dXaw0sH3khnrtJ?=
 =?us-ascii?Q?Tjq9OqM1+b6bcU8cRhBnwWrFr80F0seQ/CxlfuLDzfMaPRhWUiQzY5R8P3bl?=
 =?us-ascii?Q?GFXtjyUekQ45kblItBLkjo5CbivXcLCzUKxSIxXzH23uHrXrSz6Fnm3+C84z?=
 =?us-ascii?Q?P5Rg/YOCsBx2EI1AX6WYGeqVCNPKT5ytTZJIwPqTBn1zxjHTkb18FdPuSNfI?=
 =?us-ascii?Q?j9vTQ6lF6YnWivvhv9bxLVd1xNabyOMf/uZsDaZFoX+dcsOqVjcha0u7HAw6?=
 =?us-ascii?Q?9nr/tRLXolOkQZbofo+hIXcDscSrY+C0yadPsMvI/HhwoRmEjEnvuDnCmKqQ?=
 =?us-ascii?Q?n76nndRJww6j3V6rwsooQWvuSjhVfwaiYbW1AQX8efheB4y1Gtct0H+xZFOM?=
 =?us-ascii?Q?NeEOVIBxX/ByQcg7/DbSGj5cghZ5O15Zuc0dObJw5aBYRu1YpI5xLq6Wve5H?=
 =?us-ascii?Q?v+VcmIx0FBnlgTToyHhlYY8CXceFuWBQbaoA2CkY/Z1p7e4PjY5JpBOS3dQg?=
 =?us-ascii?Q?v/0/0aZdaS7CVvwu6kYwewODDT6kFS3Nnsvd6UBsIFLTgpSBjspK+uQgGjfh?=
 =?us-ascii?Q?bkGnw3ne9hy8+xHZR1UQgIVCd+NQcK5gKCSwf114tlMxbRT6uhrJkbFW0O3l?=
 =?us-ascii?Q?J2sGzuzNy44bStZvhh2Eb2tsLf/FEYwx8iz3QsOi2GiRAaZmnBE14i8YiGCL?=
 =?us-ascii?Q?mvFVocOKgSFiv8XSX7nvRPRxRCRLjZfoIwvKf9bXGuJh0BTSoKuGNwH+ObjN?=
 =?us-ascii?Q?0Rs7i4xqr0InbjbYR9EMjzdymh5WOTiKZtezHsOL/g0Pr5hNRMOXGVCs8Zno?=
 =?us-ascii?Q?BP9rIlo/b8MIwJz/UEv75sHLt80=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ae9aa8-a76f-4d7f-05d4-08d9f41d12d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:55.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmTIEcbTorhR106iyygfzneEOqtX/K70Wy5Qsmlu2NeiJ8qRDz42/c97dOmM+F9kOTscFOHbiEPZMAxaWworSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It's
useful for the test cases using different file sizes.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index c06e9e9a0a3f..9d2076021df2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -539,7 +539,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -559,13 +559,19 @@ do_transfer()
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
@@ -725,7 +731,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -770,9 +776,18 @@ run_tests()
 	speed=3D"${7:-fast}"
 	sflags=3D"${8:-""}"
=20
+	# The values above 2 are reused to make test files
+	# with the given sizes (KB)
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -785,7 +800,14 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" $size
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
--=20
2.34.1

