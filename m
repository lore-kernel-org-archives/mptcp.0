Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6357D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxQnAhIHInR1WP1NMs9nDPf0YzzQ8KIFp2HDU3Z12Ks=;
	b=ZnMRBqkqNU0Ji3zn1VNt8+EjABp6kfGZkCbsRjWSpeyVs5XxVdUIYDUPq3zv4O+Y9oOO7X
	ohduQ+WNpj4KRo5xqh7Vs2anKB3fDOel4xnBI1sJrQ2YP4cn262GFkNcrPFG2HODirQP+B
	gvcW3VmnOspnOveJSBd8wBCiQa6n1Vs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-Xz-Aok_QMPm3z0bDadrR1g-1; Sun, 20 Feb 2022 00:21:21 +0100
X-MC-Unique: Xz-Aok_QMPm3z0bDadrR1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/39ts/bD+I9SLrzn0hgVlA+n5ctUCPfx4KuoN/Gdo4G+zgXywhdzBfaCuuca5TtGlZrFf2T8m2pyuM4hycjrCOMCdP6pD6nhbn+DH8sMQCzVUADA1hHOkH9+OIVKSVmCEjTWqFtPS+FH78tjQUIJ5hgrrHW7kLS1++nuDgQaO+hUXjCJlIEW1TPZoAZ8kUVTf6b3dN8nHBvVB9S1dKDxJ1pEhacY2L6Bx78WdiOlUzSyj75UdmSG90N0IGZiFtYzpXZnuycguqjlA8zz97YPMEEwVNIsiEBrIYlg33FaeKMlAhHkiAAGwEupkwXWQJyc9RMkfg/RK2zcnuJoSEwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFxn+vdiURcNFbtC4YXwTkMjz6mKH432OaZSLHeNwDU=;
 b=KcDfbX7os36E8p5mRLUtrzcPqRgmUhB28/AwvwEYN0bkfOlRZmj97BPVuKZ/ytFmtFjymCQSI7fvlo+G8BwIqeZVIPJygk2panP51/wZvEmhCRxGGKTbc6ISuG0vUWK/aoECyIStubsKXvwuUgyhtUJqzFABSOQjxck6ak1qj3xVu9hULENEqUC3MC2mHpoLE1rJ9obw8fzW5aKi1DKImWAOddkaNy7aOaeNeqZRuiakzxdRwwbFpMbMMxUn3PSwdmuGaE4ZwMUc9p8C28+jK+BazduIb8duDUKqKvYFPsjOJ16ryHV6XGphDURdrttcrAzT52Zi1pRf/6p2zYIBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 13/19] selftests: mptcp: add extra_args in do_transfer
Date: Sun, 20 Feb 2022 07:21:28 +0800
Message-ID: <3f40b1a00dd7b75cde9019a2e0f02883f54305be.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9424b1a-36ad-4072-12af-08d9f3fe88ed
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB68418F343CF11EBB162440FCF8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVk9Fp7FmVi2qc5gXs58cLP6e+yv/AkWDrTMRFNYFY6Ibe82Oq7pHv9FFF70n5WjwxFqvXfdj/8BChWvcR85QJ3Q9KmsfU10TOMcrbVLqK4OYMO1cFWXGcV+6Etfms2WnIyRwtFUt7grahw/AvAZufuPW70uF0d2BIPQYKwicid+M1DVYJmfNEoYbjUSkKfp9bgj8kudAoNijuKPCB+ALmLOytR5y2iesevzgQ7dDMf7xBICMsxJy8JyspSDcfCDHQvnF5czUMiM41mKKL0EfFBiSEYFqrZAsSM/SRVTt/r9LJPUzRdpGJDAEDHTrsVSSjjX4VuYHPQAHyBCI2DsSqj7oYhc17OiPBGm5hRfREkGmS+KEkGTBLJzODLh59t1Ih/R01Wj4yiNYxyNgqHbNLkG/MDHw7z/kKnpWdJzknIa7BGuXbod5ehBH5TK3q8WjmWfH3U7xHkyOg+iLn77k+KwSOim+3/R/oNwR7h1YqXegd9WTsld+V3q423LNHoEyC7UuraFgKhDkG7n3661FcC4eM/OwL657gsRHXr6I2bVf1QALJIZqfOrMB1sbr7P9PjcUxi0sW/JBcuweGrLTsGrLVjosYhmwM0qsdwnlN/SwthmhkPzkjx6bkOqi/TXfE3HbSpeFvUIuMFVwblRBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LkaNl4/iHoe1glEzIpOEouz4vxpRAJ5jN/futeVoHW8jZF3Qw+9klwUaob69?=
 =?us-ascii?Q?UXmfzg6jE9dKFKQkCHcwUa/ymhUKJVuLDUrcRZd5/vdb9Bg9lnQYzaNLgfIT?=
 =?us-ascii?Q?hR+WHkBSGFeAvLa1jOGH5o1LoZyua5tzCtFkWCASRPQLrg3KB83AkyEekyRZ?=
 =?us-ascii?Q?ckIlppo+YRrbr/NfbxwlknDUcDpRoJL2fE/bZVWCCkyyQ4p0XwikLrTWdOAd?=
 =?us-ascii?Q?BWDNzSQjRJSygBMHOm7xzH4ppkAdez6ylPhrtwLRsWqW0/qBpXqrX3rZpNLY?=
 =?us-ascii?Q?qzYSHNV+3HAm4gaYRDpVjxdmTNhQ+zPfp6blHQluv24NdxR3ARhQfLXN59Fh?=
 =?us-ascii?Q?F7tiXIafToZV2oYiMO720z1kAm12LCrR+XZNh2TJ9fgVGXtjcTdvuhc15AD3?=
 =?us-ascii?Q?XjOi1YUkVal7yhhr0JfhAQ/cAhY39iC0rcGItMcdvQdRzL4sWHS82M1rgpNB?=
 =?us-ascii?Q?252sWcl2FiuYijC1a2isbUiq4vX3IgZcK2zQEe7z4R5mTpHtDsx9YMH71Xh7?=
 =?us-ascii?Q?P/cyLTGaNXEECorHIYXFAeA8gLVxQZ3kSK/o3dUkZ2j42Vc69iyfnl2cAbL9?=
 =?us-ascii?Q?qfUjLOSq/woPvNjAlpdsnH09Ep+sP5XuGlCWul3JjPZRJ/ysQQIsXry0aV8g?=
 =?us-ascii?Q?ii4MkH57QYZn/EyIJK1sKNQUvYh/8C2n6Ug8tEyRAE8dfLK/aIWsIOcpfn07?=
 =?us-ascii?Q?6CI0DYIiMyq+LlRwNDQOonuezRKK+TyrYy1B2Nurg5gIW3zaV2mMvjgyFd7/?=
 =?us-ascii?Q?LsBEYXxyxrj8493dyOJCjtOZ34DZcNNCEzvDJPBYPRaCRReMVxekHA/GccaS?=
 =?us-ascii?Q?EsF4peail0kdAwkLBq8oRs1XIwVbZlNBmaxWYHS0+llc8mO4Y1RvO5tR6T/2?=
 =?us-ascii?Q?1O7q42EMHwGllpAzlj1h9c59D5ZEI3UH66+X0ZNTsNJdwMm7mmBwqxWlFJtZ?=
 =?us-ascii?Q?DqhUL9z87+9iAgc2Tw+Lf/ZvprZaWyg2GE1n1NAMrQkTmYT5GbY/vCvGjTIv?=
 =?us-ascii?Q?k21Rw3S1x1TWZLQSfEp5Icn3dkus7IUHmWZ/cijh++ClYm+mnjFB7yv89IuT?=
 =?us-ascii?Q?zV5aQW5l08m3XESz5TGZgIYze+t2q1EYWC0rpiX2EkpydenZLwvX/OiNa4m8?=
 =?us-ascii?Q?8yL5wnOtXYENYcvouNrfPnJ8LwzVO6Cf3IQykEvcjTrh/n1EhMPN2TYlC8cp?=
 =?us-ascii?Q?MFYnaJ2SD4bMXRMWmnJZBuQxIsSCZaSVjwSBZYb94u2lGbnPbBFE1YuIGQR/?=
 =?us-ascii?Q?zug0mrmwkW5xZsk5TPgK4IIBvuqcYePGgu6WmGNJH98I2w5kLEDTUAstnTAY?=
 =?us-ascii?Q?zlExriaCNig+1p40rURcA6CEycS5qNpUEouaSM+I5E7XYPN0IkgIlV6RTnBO?=
 =?us-ascii?Q?xI6jZP5gjjG5NXm+3ZGuylV1yvcxUTDBknl2kVct6NzQoif1D/12yR/X5uEt?=
 =?us-ascii?Q?XkXa3CsES/JXecPVPBXDDpjnTNE2k4RlRVDg7YsP0EgYRZM5IOiSGvMhb8Ob?=
 =?us-ascii?Q?DsMKzOvWxCuhHXFjf9ENe2bojFRpdJmhfWHr03B4+J5VFRUlSED+ODcuY+nI?=
 =?us-ascii?Q?AhrthuH73iWeOLRb6m8vgyohMcXhQQZqJPGaQhVXNqKHkz8NqhqiFOjqzrJF?=
 =?us-ascii?Q?iv4rci2eDJoIrZ+q5oAeOcD7p9BQzNZqfptvla5OqXOIvbIzFff8IkTXc9Ye?=
 =?us-ascii?Q?iLoRqFl+szcMM+fgBefJoCH8X2c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9424b1a-36ad-4072-12af-08d9f3fe88ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:19.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSZM4Zg3E8HSvYlYz5qtoMI2XXPoyitJjfLdnFTrAe9Ti6iBjXDqXzXBTLKnn962ukMkGCyjW3F2P+7z4z1Puw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
argments passing to the mptcp_connect commands.

This patch also renamed the speed level 'least' to 'speed_*'. This
more flexible way can avoid the need to add new speed levels in the
future.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index bef029de5876..4ce578fda369 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@ cout=3D""
 ksft_skip=3D4
 timeout_poll=3D30
 timeout_test=3D$((timeout_poll * 2 + 1))
-mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
@@ -515,12 +514,13 @@ do_transfer()
 	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} =
\
 		nstat -n
=20
+	local extra_args
 	if [ $speed =3D "fast" ]; then
-		mptcp_connect=3D"./mptcp_connect -j"
+		extra_args=3D"-j"
 	elif [ $speed =3D "slow" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 50"
-	elif [ $speed =3D "least" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 10"
+		extra_args=3D"-r 50"
+	elif [[ $speed =3D "speed_"* ]]; then
+		extra_args=3D"-r ${speed:6}"
 	fi
=20
 	local local_addr
@@ -533,13 +533,13 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	spid=3D$!
=20
@@ -548,15 +548,15 @@ do_transfer()
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_args $connect_addr < "$cin" > "$cout" &
 	else
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -1611,7 +1611,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
@@ -1621,7 +1621,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
 }
--=20
2.34.1

