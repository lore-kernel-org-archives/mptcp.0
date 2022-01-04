Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07572C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641291099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6xLJO4YWijik9jW7an89WAQ8eyUSpg8j7KgugeLUHs=;
	b=JyDIPZMki/H32mWmgkNM876MPOSq5KAwvPxByIrV3jCqTWktbEJa9uxF+Cifwb1r3g2cu3
	vcp2hiXwt/QepgKimBGhwjx2vCjy8f2acwjttMyqQUt63AbrfOCZ59cuSGE4T0VZPg5KeH
	bLDVP12LJTAWexz5p+lOs5uv0cthgkA=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-f2fW8V79Pm2tXMTgJFKk9Q-1; Tue, 04 Jan 2022 11:11:37 +0100
X-MC-Unique: f2fW8V79Pm2tXMTgJFKk9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMNuRm0hXpAUtXWzfw7Kxy0h+OTUl3XT0xnjYsvKiOo6h0ADrpOFWWbcQol0JC0MiL+F8BOWI+t36y2wvA19RBWQEhiOea5watlkHwHPfoonzYub/MYlk0+PY/V2jz3ihbotvCAAmOcCJLp0iuIzuEJncPf9sTsDh4x+NX0fQPIX0H4xQKZngAAkLjhHe2EaMcAmEntuJgxqTv0KQwQwYUZF0eQOoseleb0iBQ3OzIZGX6rofTKmTe4HNNHJe6c5cocDXLxgx2mXQz+atFqSCOSLWrpr1H3nn8kiJhEWW87X3ATravo681dDZTyo8Wvf4xsMmO+Re3AOXw1wcOUcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SMdfNw744UVpC6DCHuc/nTnGfsJzeB1kyw7343qFy4=;
 b=LLc1HRfdOgbXz5a5xvoBfoOInlRyUgAmePzIrZun+M1AcTEi85MCkyo+1eLMoHgYKu9AQm5xDPd7RKq/7w4Y5quY3KzpO3VLSylGQIuzsOq/kCdSGP53KQJTqy6FZsUGQdbBim+ho/H+1FePZRLuwivQzJDir9eRWGEpo31qclbbQG7cjBAp5ofG+JB0LbjgGz4ikONPPE28+l6YFDqS9WNa7xSv8kAZabFW1KiCwQsRmkPSeTJYlQXHBp9VUoSCzJPOCzyRO4H+QEaJ+b1eBaEAi+wVQcuFBfFpiq8zJbUqlGswWML54CkMfq5MEkdlN5g8bT2TrvrT8VYZb5sH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 10:11:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:11:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] selftests: mptcp: use 'ip mptcp' in mptcp_join.sh
Date: Tue,  4 Jan 2022 18:11:16 +0800
Message-ID: <9f4ec73636180987e51fddc3b240feccc0a5c553.1641290905.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
References: <cover.1641290905.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e306252-3914-498c-6e60-08d9cf6a9578
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25400EBF0172B074EDBD12A4F84A9@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zsYeiPY0bX9pnRm6ILuXzQxMijTIVY+pc4ZH2bn3oczCVTknE7CzdSO53tyJGm/HWLvqf+COl0+ZGfeRTEKtK6km50+pJ2aGoeRYqsdsVUgwDCAm9HXtZLFIiZvyDP41kGP1gOabyUTqQI7J9ghLFPmzVB2pyVm//cF3BXC/ktI6+00/4GxdTMjno2HBZiQv7ucVr80LH4HJo5WlFvSPxzhTgONWVPGbL/m18MJl7ngP3IFfQf/nntt4WDUmnJ2d91sTR4ODdO7njetIevv51nnLeUa5FsHv92otJEnBIZIHZvnMnjjeZcZzJncLgA5NUBYaXY4cELKZzvTUOat0xOfiWc/FuMHBD5EJacas3HbvH0i2QUqotKJVW7Cy9+FI9zt0tw5jK7Gq/CMjzplQmqVzVhWRV4oUqyzGs0DJRAQNJ1w91SHVEC0PyPuKGdt2dRpIHRAneRX9ZpMX8IAGIa6YrrFBOeJIDhKytb60/6Vlb6xACWpUKLaxQAXhS3ekcESNTUgu8VH3xjPHEHD03l/FR50L4FvrhnUqXnuqIuMh5TbnhMmuf094BpRAhT1nJYRGzWdot6Or9LPUOOqlN+UkLgF5M3/Nh4autMmNTI7bMyZKP3/e7A+n2CXhiDfjO/Cfzt4vb7GQaIDrUydQvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(30864003)(4326008)(66476007)(8676002)(2616005)(508600001)(6916009)(86362001)(6486002)(5660300002)(107886003)(186003)(38100700002)(8936002)(36756003)(66946007)(55236004)(44832011)(316002)(26005)(83380400001)(2906002)(6666004)(6506007)(6512007)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxJ5+FnGR2Vs66Y2TT4NMl7LHm+d+Q0tGTrWpWJvY99XoRMmzZ+pw3tDeVTv?=
 =?us-ascii?Q?tbvvGmwarbBtgFayl5WDIL7K7iNUEJCEiYcrNtvjFwd68fCo75g7twdh2k1M?=
 =?us-ascii?Q?B1lSNSXPLVA+jDsR+jaVCDjOQcCmxt3v8rEw5Oq1oHCwGIXK4wITaY+0Bb7m?=
 =?us-ascii?Q?YU0Pk3tMwa2jQjd77yMtUdz6WSiwiu6PoTHkdSVxZRx4WVvL5LIHy/fxEmV6?=
 =?us-ascii?Q?bbaMsNXym6UayhZdJv7bmjqVbpNRXaMQYrMhcu9v5Fh93fofdFO0SqW4YXT6?=
 =?us-ascii?Q?qEqTpPFRfNfxgekBIn0LLK2++uJfjxbGo/0IAP1qNnJ5bJ0NVSnMt6YwAr5U?=
 =?us-ascii?Q?QCUEeK1t/c82MxSqwrhAfCmENWEAXFAGDWaueuKZQ3Ss0SuKPxqEGoK/+DQu?=
 =?us-ascii?Q?t4pMm2SyjMTtvnFmHc97oFg09nr2GHvSR6Z4HT2UkV2bIiM/Rt8Xbxv3qjWh?=
 =?us-ascii?Q?ESWshbEJXhg/QkZUlWKMP1ZaItXCG2I101y5bk3/0712Pc1D4tB0677PKqkW?=
 =?us-ascii?Q?vx40/m960EF58wEXGvwpEbwZGdTG1pjZ2pEHza/SB1wavocdc/ykce+6E4UR?=
 =?us-ascii?Q?xsYUsDuWIOJv0sVe8Hs0ucqptLdaXnVxFr2ehS6WpAdzM4gT7Onu4VTJnprc?=
 =?us-ascii?Q?mozknJWMWVEOJ1aJzOI/CbAKeqPbAO97rKPRQQK9ojED/whoRfiDVNgOZKcw?=
 =?us-ascii?Q?8L9ur+x5Y9kNPLd3GD0v456uwTC8cG/mpyfCvHOpjkDjhHisO8f+3o1OtKq6?=
 =?us-ascii?Q?8Ub60a8QuBBZ2wRnqVVfdTuDN7Xa83VctDhddBX5coHE1eDGjmVnFQDlTRAb?=
 =?us-ascii?Q?x06QLbNQ/pAINMvCsKnXy4nMpuChTJCuCrNcXllJcSn8EgBeWhmMkQmxLrSW?=
 =?us-ascii?Q?sKkEdQeadYTRSB7+0vs3mFuo3WQzvo+Tx3hbgAcYqoM5lls4v/TcfYMVeMrx?=
 =?us-ascii?Q?scodg/5Xn+nkwXJ2WvWK66oWmrWIy6w61Rag38jrIrSt8TtpJ648YrjL3Ph5?=
 =?us-ascii?Q?7wByK8+n7GYf6AX5nX5A0OSHw3CRuzOcx5wenXTT6XKHC0I2WMyepU2OazcE?=
 =?us-ascii?Q?w2GxPi0JKJLrOSB7+0qqs8VxzRyPjx+5RSd6WJc7hWr51ez5Gk7w0gKYfVjk?=
 =?us-ascii?Q?ezBGGpz4ud8X+6zkCF9zNvqxNAYtn6eDt/GjSZMtPJOgHKXFGM0ngBz+qxPE?=
 =?us-ascii?Q?/T/4mTnJBD8KaHlJjU78beBw1t52H2TqtAJUEm/ySuW0lk/soWch3YkzWSSW?=
 =?us-ascii?Q?5YPw0NHJjzrTYYZWdgrHWaJ5LpdnH/i2hSyxgDvryvREw2B1Y2x6YM36NVMG?=
 =?us-ascii?Q?k21jlryaZCN984jarfLXkgjnf5Bx+kn+drTvjrsZqnNFB9xvJBRphdSSLMN1?=
 =?us-ascii?Q?1fZk5Cz76zpyXrE99sgwPsEFnhYe4a5NmvT7p6qWKBBcDkAOdZdIF/eTUMxV?=
 =?us-ascii?Q?SKyZB01NMCLUOzmpyPOzfc4hlMtS61aNeSdetUUVJLC6m2/mLURoQ+GnakNF?=
 =?us-ascii?Q?A5uubOpK++8Syi4K//1qs2vOpJ9ybWflZTKrGwC6DB+pEqpfQyl60ZjnNeS1?=
 =?us-ascii?Q?rUSNY4etIuBCgToGf0sZvNAASyZ2NiZF0VxyTlXFx9uZS5aZd/UpWaD728ve?=
 =?us-ascii?Q?+6jPC0UInHRAgAuaIQFr7Wg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e306252-3914-498c-6e60-08d9cf6a9578
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:11:33.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vwM3KRLnXfKDxQUQ2OANNpTa84SA57Yr6KdqmkqidJYTLQzn//8KFKuX/Bo24Ifg2mwVjJJyiTPOyPagO5kdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

This patch replaced all the pm_nl_ctl commands in the mptcp_join.sh script
with the 'ip mptcp' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 686 +++++++++---------
 1 file changed, 343 insertions(+), 343 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..1a2a6d878d71 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -378,7 +378,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			ip -n $ns1 mptcp endpoint add $addr signal
 			let counter+=3D1
 			let add_nr_ns1-=3D1
 		done
@@ -386,29 +386,29 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
+			pos=3D0
+			dump=3D(`ip -n ${listener_ns} mptcp endpoint show | awk -F "id " '{ pri=
nt $2 }'`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				while [ $counter -le $rm_nr_ns1 ]
 				do
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${connector_ns})
-					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+					ip -n ${listener_ns} mptcp endpoint delete id $id
 					wait_rm_addr ${connector_ns} ${rm_addr}
 					let counter+=3D1
-					let pos+=3D5
+					let pos+=3D2
 				done
 			fi
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+			ip -n ${listener_ns} mptcp endpoint flush
 		elif [ $rm_nr_ns1 -eq 9 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
+			ip -n ${listener_ns} mptcp endpoint delete id 0 ${connect_addr}
 		fi
 	fi
=20
 	flags=3D"subflow"
 	if [[ "${addr_nr_ns2}" =3D "fullmesh_"* ]]; then
-		flags=3D"${flags},fullmesh"
+		flags=3D"${flags} fullmesh"
 		addr_nr_ns2=3D${addr_nr_ns2:9}
 	fi
=20
@@ -426,7 +426,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
+			ip -n $ns2 mptcp endpoint add $addr $flags
 			let counter+=3D1
 			let add_nr_ns2-=3D1
 		done
@@ -434,22 +434,22 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
+			pos=3D0
+			dump=3D(`ip -n ${connector_ns} mptcp endpoint show | awk -F"id " '{ pri=
nt $2 }'`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				while [ $counter -le $rm_nr_ns2 ]
 				do
 					# rm_addr are serialized, allow the previous one to complete
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${listener_ns})
-					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+					ip -n ${connector_ns} mptcp endpoint delete id $id
 					wait_rm_addr ${listener_ns} ${rm_addr}
 					let counter+=3D1
-					let pos+=3D5
+					let pos+=3D2
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+			ip -n ${connector_ns} mptcp endpoint flush
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -457,17 +457,17 @@ do_transfer()
 			else
 				addr=3D"10.0.1.2"
 			fi
-			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+			ip -n ${connector_ns} mptcp endpoint delete id 0 $addr
 		fi
 	fi
=20
 	if [ ! -z $bkup ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
+			dump=3D(`ip -n $netns mptcp endpoint show`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
+				addr=3D${dump[0]}
+				backup=3D"ip -n $netns mptcp endpoint set $addr $bkup"
 				$backup
 			fi
 		done
@@ -1011,51 +1011,51 @@ subflows_tests()
=20
 	# subflow limited by client
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 0
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 0
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
 	# subflow limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 0
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
 	# subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
 	# multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows" 2 2 2
=20
 	# multiple subflows limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
=20
 	# single subflow, dev
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
 }
@@ -1065,28 +1065,28 @@ subflows_error_tests()
 	# If a single subflow is configured, and matches the MPC src
 	# address, no additional subflow should be created
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.1.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
 	# multiple subflows, with subflow creation error
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with failing subflow" 1 1 1
=20
 	# multiple subflows, with subflow timeout on MPJ
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
@@ -1095,9 +1095,9 @@ subflows_error_tests()
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
=20
@@ -1107,7 +1107,7 @@ subflows_error_tests()
=20
 	# mpj subflow will be in TW after the reset
 	wait_for_tw $ns2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	wait
=20
 	# additional subflow could be created only if the PM select
@@ -1119,16 +1119,16 @@ signal_address_tests()
 {
 	# add_address, unused
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "unused signal address" 0 0 0
 	chk_add_nr 1 1
=20
 	# accept and use add_addr
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1138,59 +1138,59 @@ signal_address_tests()
 	# belong to different subnets or one of the listed local address could be
 	# used for 'add_addr' subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
 	chk_add_nr 1 1
=20
 	# accept and use add_addr with additional subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
=20
 	# signal addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.4.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
 	chk_add_nr 3 3
=20
 	# signal invalid addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.12.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.14.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
=20
 	# signal addresses race test
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 4 subflows 4
+	ip -n $ns2 mptcp limits set add_addr_accepted 4 subflows 4
+	ip -n $ns1 mptcp endpoint add 10.0.1.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.4.1 signal
+	ip -n $ns2 mptcp endpoint add 10.0.1.2 signal
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 signal
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 signal
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 signal
 	run_tests $ns1 $ns2 10.0.1.1
=20
 	# the server will not signal the address terminating
@@ -1210,11 +1210,11 @@ link_failure_tests()
 	# active backup and link switch-over.
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 dev ns1eth2 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 dev ns2eth3 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 dev ns2eth4 subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "multiple flows, signal, link failure" 3 3 3
 	chk_add_nr 1 1
@@ -1224,11 +1224,11 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 dev ns1eth2 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 dev ns2eth3 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 dev ns2eth4 subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 	chk_add_nr 1 1
@@ -1238,11 +1238,11 @@ link_failure_tests()
 	# will never be used
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 dev ns1eth2 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
 	export FAILING_LINKS=3D"1"
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 dev ns2eth3 subflow backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1252,10 +1252,10 @@ link_failure_tests()
 	# the traffic
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 dev ns1eth2 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 dev ns2eth3 subflow backup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
@@ -1267,10 +1267,10 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 dev ns1eth2 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 dev ns2eth3 subflow backup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1282,38 +1282,38 @@ add_addr_timeout_tests()
 {
 	# add_addr timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflow 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 4 0
=20
 	# add_addr timeout IPv6
 	reset_with_add_addr_timeout 6
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add dead:beef:2::1 signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
=20
 	# signal addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.12.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
@@ -1323,28 +1323,28 @@ remove_tests()
 {
 	# single subflow, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
=20
 	# multiple subflows, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
=20
 	# single address, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
@@ -1352,10 +1352,10 @@ remove_tests()
=20
 	# subflow and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1363,11 +1363,11 @@ remove_tests()
=20
 	# subflows and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1375,11 +1375,11 @@ remove_tests()
=20
 	# addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal id 250
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.4.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1387,11 +1387,11 @@ remove_tests()
=20
 	# invalid addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.12.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.14.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1399,11 +1399,11 @@ remove_tests()
=20
 	# subflows and signal, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1411,22 +1411,22 @@ remove_tests()
=20
 	# subflows flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow id 150
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
=20
 	# addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal id 250
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.4.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1434,11 +1434,11 @@ remove_tests()
=20
 	# invalid addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip -n $ns1 mptcp limits set add_addr_accepted 3 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.12.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal
+	ip -n $ns1 mptcp endpoint add 10.0.14.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 3 subflows 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1446,18 +1446,18 @@ remove_tests()
=20
 	# remove id 0 subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
 	chk_rm_nr 1 1
=20
 	# remove id 0 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
 	chk_add_nr 1 1
@@ -1468,37 +1468,37 @@ add_tests()
 {
 	# add single subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 	chk_join_nr "add single subflow" 1 1 1
=20
 	# add signal address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "add signal address" 1 1 1
 	chk_add_nr 1 1
=20
 	# add multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 	chk_join_nr "add multiple subflows" 2 2 2
=20
 	# add multiple subflows IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 	chk_join_nr "add multiple subflows IPv6" 2 2 2
=20
 	# add multiple addresses IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 	chk_join_nr "add multiple addresses IPv6" 2 2 2
 	chk_add_nr 2 2
@@ -1508,33 +1508,33 @@ ipv6_tests()
 {
 	# subflow IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add dead:beef:3::2 subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
=20
 	# add_address, unused IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	ip -n $ns1 mptcp endpoint add dead:beef:2::1 signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "unused signal address IPv6" 0 0 0
 	chk_add_nr 1 1
=20
 	# signal address IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add dead:beef:2::1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
 	chk_add_nr 1 1
=20
 	# single address IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add dead:beef:2::1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1542,10 +1542,10 @@ ipv6_tests()
=20
 	# subflow and signal IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add dead:beef:2::1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add dead:beef:3::2 subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1556,76 +1556,76 @@ v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add "::ffff:10.0.3.2" subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
 	# signal address IPv4-mapped with IPv4-mapped sk
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add "::ffff:10.0.2.1" signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
 	# signal address v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add "::ffff:10.0.3.2" subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
 	# signal address v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add "::ffff:10.0.2.1" signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
 	chk_add_nr 1 1
=20
 	# no subflow IPv6 to v4 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add dead:beef:2::2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add dead:beef:2::10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
 	# no subflow IPv4 to v6 address, no need to slow down too then
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
 }
@@ -1634,18 +1634,18 @@ backup_tests()
 {
 	# single subflow, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
=20
 	# single address, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
@@ -1656,28 +1656,28 @@ add_addr_ports_tests()
 {
 	# signal address with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
 	chk_add_nr 1 1 1
=20
 	# subflow and signal with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
=20
 	# single address with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1685,10 +1685,10 @@ add_addr_ports_tests()
=20
 	# subflow and signal with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1696,11 +1696,11 @@ add_addr_ports_tests()
=20
 	# subflows and signal with port, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
@@ -1708,20 +1708,20 @@ add_addr_ports_tests()
=20
 	# multiple addresses with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal port 10100
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
 	chk_add_nr 2 2 2
=20
 	# multiple addresses with ports
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal port 10100
+	ip -n $ns1 mptcp endpoint add 10.0.3.1 signal port 10101
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
 	chk_add_nr 2 2 2
@@ -1731,56 +1731,56 @@ syncookies_tests()
 {
 	# single subflow, syncookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
 	# multiple subflows with syn cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows with syn cookies" 2 2 2
=20
 	# multiple subflows limited by server
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows limited by server w cookies" 2 1 1
=20
 	# test signal address with cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
 	chk_add_nr 1 1
=20
 	# test cookie with subflow and signal
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 2
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
 	chk_add_nr 1 1
=20
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
+	ip -n $ns2 mptcp endpoint add 10.0.4.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows and signal w. cookies" 3 3 3
 	chk_add_nr 1 1
@@ -1790,29 +1790,29 @@ checksum_tests()
 {
 	# checksum test 0 0
 	reset_with_checksum 0 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 0"
=20
 	# checksum test 1 1
 	reset_with_checksum 1 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 1"
=20
 	# checksum test 0 1
 	reset_with_checksum 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 1"
=20
 	# checksum test 1 0
 	reset_with_checksum 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 0"
 }
@@ -1821,26 +1821,26 @@ deny_join_id0_tests()
 {
 	# subflow allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
 	# subflow allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
=20
 	# signal address allow join id0 ns1
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
 	chk_add_nr 1 1
@@ -1848,28 +1848,28 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns2
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
 	chk_add_nr 1 1
=20
 	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 1" 2 2 2
=20
 	# subflow and address allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 2 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
@@ -1880,10 +1880,10 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added before the connection,
 	# 1 non-fullmesh addr in ns1, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 4
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 4
+	ip -n $ns2 mptcp endpoint add 10.0.2.2 subflow fullmesh
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "fullmesh test 2x1" 4 4 4
 	chk_add_nr 1 1
@@ -1892,9 +1892,9 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 1 fullmesh addr in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 3
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
@@ -1903,9 +1903,9 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 2 fullmesh addrs in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 5
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 5
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
@@ -1915,9 +1915,9 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection,
 	# limit max_subflows to 4.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 2 subflows 4
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 4
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
@@ -1928,9 +1928,9 @@ userspace_tests()
 	# userspace pm type prevents add_addr
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 	chk_add_nr 0 0
@@ -1938,9 +1938,9 @@ userspace_tests()
 	# userspace pm type echoes add_addr
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 2
+	ip -n $ns1 mptcp endpoint add 10.0.2.1 signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 	chk_add_nr 1 1
@@ -1948,27 +1948,27 @@ userspace_tests()
 	# userspace pm type rejects join
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
=20
 	# userspace pm type does not send join
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
=20
 	# userspace pm type prevents mp_prio
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 1 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 	chk_prio_nr 0 0
@@ -1977,9 +1977,9 @@ userspace_tests()
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip -n $ns1 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp limits set add_addr_accepted 0 subflows 1
+	ip -n $ns2 mptcp endpoint add 10.0.3.2 subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 	chk_rm_nr 0 0
--=20
2.31.1

