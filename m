Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B37D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sQvZ9WU9pO5s6WrwiXbaZLwUvbHgS/B6e2Uim5vkuA=;
	b=R28jBFUZ5+secyMTYHt8wD19iqZM/4W73I2SYXwx+8HimacdP21P9mB5d8dSwazT4RIbts
	kkNu8Y4gbgXobdyhn1z4F1mIkSZWQkaPoxTIlml/tZ5cbj9vV8VbxtfvkWBWuKMjEg4xZo
	hSoZ0vPJn2CN5ZmCgMLlL4p5vsCZraQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-1TaUcw0lP1W62NsUAYwJmA-1; Fri, 11 Feb 2022 10:53:33 +0100
X-MC-Unique: 1TaUcw0lP1W62NsUAYwJmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni0lKR28Z1eLaml31SmN0fpChagL+zGGAscjBj85zG/HATpZV/BYv0fkyRpYMK5Igvwrn+iF8BEE/mJjKrdoja64h4mHeRMDebb5AlkrICisY8MBzfrwGmKyK1QFCdAd3aJwpgCyXvD5Cyae3T0fC3m3wq9iBJy/Q+RgdNSA64uWZRSF+iyagI4tLa/bkrWV15Qpw/Wo5El4Y2qR6l5crC8PBT7U36tfwT9tJ5agKypak4nlqD5s4ThOWdkE+TRzI8A/w0sJ2Pb+B6NmkPrKuHY0VSh7CLIebinZwJnmJHs/fx83EXWQiQFpKvztLfuJE0fTZhKv4T6P230j7jcktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfJgG59kT18wGIz2AGhhO4Epk72RHvEYXYWmcdiZRW8=;
 b=mUhW7O0XgTMfq+I/kqDQyHy93Bt7up3u3iWbMnJr3cACD9NRfyD3CE7bPc9azYe1RjtQXxIL6v5MkusIyLw8HalqlSeDypifrvPw1yGoLQHcLvYxulFFK2f4yGBx61wIlcUA68sAe1OfX80bZ7ZU/YDZJIj3prAoZyIat+GPmdupb8rexePJnCON6RbMYMQyIGiYYBFIdxe/8K+J9or/BDpts/bwTx8BE/7WQt31qcAcJcsTSSMzfn9vZXpSxD9eEK9rb4Oh4hmsM/dH1B8xdAsl7XsUx6s5Vgn85z+MyooFXcZGVd4x8p9PK/mysQ97rjix2VVzBWAJcFvbqAo+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 09:53:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 6/7] selftests: mptcp: reuse linkfail to make given size files
Date: Fri, 11 Feb 2022 17:53:04 +0800
Message-ID: <5b016d511da3e1cae3a98c0758e912761b3d6bb5.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6836a84-d34e-4275-69c7-08d9ed445cc7
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7878DB391D4A9C68B74AEE87F8309@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xkvH6KOtKJLps8PbpIS0YYGDsJZO6GpexUFjG1ZVTEglceePn4cDoBIVG2kUzECVwGIOku2tec/Uk27FRfssqytssPn+RFLofmICgLmSmgWauRMrWXiJ1ueqnpNSpc5RnLxbcA3+0OvVcb4uoPkYsVGGT5gUw5j6DAiv33DgAgdHfx0JbG8Ni5biuuztqxSp7fDtZowW4b6+y/YGT5xUsOqy7dU+CuTbrEI0dzoVWQ7jQCu1lOnXcyNtvkj6robVEmsr9S7izkk5Fxb11S+FRtlIRIIca+FRvsqdPsOuBndtjLAP/hV0ifjfdLR0g+Z/bWXlxyB1TgRxWzvoeoWsORm9AYr5jtQkBtYqE9OIJ+i+mtBpXCuvFL/9Pin9GB1KPSXwphvYSLEDJw/xgKhSge94yAbVXX4/eHw66yFG5ovJy4e/cPd1HTOL3vV+qxhj9JwD82c8AByDUuoPPQp7aHgWQbAy118/dI6Szqc8YLdMpE4xfgCLIV2iBu9Gt4ms7CPJibm6mSPjN6fhzfcQpx7WT5xUhcX8WQ5GQQSYau2DtvHfozwIGtC7AuL0VfX8cE6PYnUIXQ1dsPh+H+trI07vmlWUMc5SHtZSzQlQAECBVlrxY3OKoS8rLaUGgPrZ6GqSLSDPPjBsF/Xnh8OMTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(66476007)(66946007)(6916009)(508600001)(38100700002)(8936002)(66556008)(6486002)(4326008)(6506007)(36756003)(6512007)(2906002)(55236004)(6666004)(86362001)(83380400001)(107886003)(5660300002)(8676002)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T0+ERLXeUx7DPrJXsRG5uVYHl9bC8yELEkjb49x5Jj2WnW2pHEAyCBKNP9vg?=
 =?us-ascii?Q?IGJKO3lnd6XZhaaB9cUN94f1xTQs0kppyPkCH+F5FuV3gRc2wVdwpAY6fQ8Z?=
 =?us-ascii?Q?9u2q12Z+qx0bN4LnAhV8JDsXoijsgg0bEXxH4cIQUZsd5tvsZ445UvonTkWK?=
 =?us-ascii?Q?qrk0soW9JpSXs69lEN9iaSM3qg/C1IMZQ4rGaMWnN6yKAkGXX0JRjckXk5YM?=
 =?us-ascii?Q?rFcLJtkBgOfkx4KvzhAQS54KPXwlCpEStM/B3IkY2IH5rpvSm+J9+SOE82IQ?=
 =?us-ascii?Q?QSJdC1FKrIt/Y1DaOOJFjGlfJk0DG891k4ImbleZOuuP5ZmdtxxzkBKdtny1?=
 =?us-ascii?Q?sfkmeQl7wT+DqIxuN2mmB9A3FEthWqENq6b7MenU16JftWP8HIqyVNoljMwJ?=
 =?us-ascii?Q?NgF+BBlQtW7rNYX4Uw1R5QcO9f5cXCIvPnuMbksHB37b/I8nK9/RMrGOAg5U?=
 =?us-ascii?Q?lniirm6iZOoKyO11a8JE4tSctMmbwyxOkwWm8W78nYyYA9ZhziZ0/NWyjqqX?=
 =?us-ascii?Q?s9TnTiTTpQdVkE30rm/sqXwsfgZ8e3Exhxdh2BIU42t/d0VRHcNnVVYr4b+j?=
 =?us-ascii?Q?MSW+27yxkBRGGyVGjif4FtFLZY0e3GjPBxKbhxXgOcGDAkOz/EYP+xWeok0V?=
 =?us-ascii?Q?swchN0hAoeM6QSR2dk43RMh00FRKHK8KDKfwMADPKDTy01a8DzfLU9I05qI5?=
 =?us-ascii?Q?KWbagk8zqLDFngn/ukm8/8HyDaHLThDkhHI+0iq+5SyWl1zSdAzwx7NWZd9c?=
 =?us-ascii?Q?910m+iQr35doQDNpDNf4nQfZP8Vi7AXyxf9DtGoPetI3bFH5JpCkYVQ3TR4v?=
 =?us-ascii?Q?VjgLE5SPPKxC8d7kgmZe7+PCMEfHfw/f704TFj97wrLAqFmfvqVxHt/MAAds?=
 =?us-ascii?Q?EPaHfmSWjzoxl4e10siRXeob7SWGWm5rDG0HuFzmGAQvYf6V33kQwpkuQ4yK?=
 =?us-ascii?Q?YkRBYlnse0e+eaC9W3M7EjmkM9g4B2FByP5UpzGInIE/7pUmK5zM0WIjB/4R?=
 =?us-ascii?Q?kpaEGB/+8nHBshj5/37g8iFKWAyaWdf/Br0otshNdJ+ePtH+pDQVRxzO6eJ/?=
 =?us-ascii?Q?W/kYIJ1uDrtGJYc6SIXR0L9pTPdV/h7tbf0USRTEzPmLDbqJqr/6d8N24kGL?=
 =?us-ascii?Q?xj3KfzFLtPq6q0S98ix9ryRpRqjG2S/cYXQPAR+Dm0YqaVKBShzgiT84AyEy?=
 =?us-ascii?Q?KK5tOspHRn69DobV86bpiXyrVwObAtZouvX/vZDQC8aFeg+jRbzm4fQmkUW8?=
 =?us-ascii?Q?kn+8lqj10xiIv/QvmhF5QmKFsm759MazGT2D/n+LKcXVinMQYl6TyUfMNtpY?=
 =?us-ascii?Q?rHwvLpJJZZEY4pXWJjrzt1v0XR2OhLyIfkFFHiMCxel+08oS9QuQHy8ijZcj?=
 =?us-ascii?Q?6rRK20X+npG2XX7PwtVy7DjTojqjiIGDPwuhit9WefEPcEdlQZydCcYvMqgl?=
 =?us-ascii?Q?tje3gieQGOU/I6P0AasnCwgTEFXYPMY0W4Aw8lFZ4DsxGdVSApnRBIkxEeQF?=
 =?us-ascii?Q?C5CizwZtuKzwVGw5yqNFax1tjzjlVyPcC9b+G49nKnavyGTNhjsxDIVLZg3U?=
 =?us-ascii?Q?PpT+Hxi7H+DqUv1B/5WNQr2Tb8wYXSFxwk6nw0HfeqDsUujL3tCsMXUC1H9O?=
 =?us-ascii?Q?Z4PCLIWimL/4JuDUehhuLpg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6836a84-d34e-4275-69c7-08d9ed445cc7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:32.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7CeGegmvHICmbjGcqyGfjXMYcN4I1BGFsqVzi/cG3umke4hELgWO8nRVlBIAx403cPJwO0hztV05uH/x3WNKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It will
be used by the MP_FAIL testcases.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f0d0d540ee0c..244c4aac1c6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -446,7 +446,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +466,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -632,7 +638,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -679,9 +685,15 @@ run_tests()
 	lret=3D0
 	oldin=3D""
=20
+	# values above 2 reuse to make test files with the given sizes (KB)
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
@@ -694,7 +706,12 @@ run_tests()
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

