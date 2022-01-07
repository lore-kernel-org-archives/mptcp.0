Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E342C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmaJ0tmO5pm6SRcNgPXXTgM6+yvTuF+KkWLQWP5YdhU=;
	b=P1LlSAnUp9r+wKOu297DZk7TWfO5ch1CZKOxnTh9LyUOpdMcfijozBCbHn5iCRPkC/eMKr
	j+16Ou+ZsbgGRanMRa4qe1F6MPc4p8FNGahiSxcDEY+c91q5rHFSmC3b+MowkL1FXJwwwY
	SQ2HsKRltx4eeqiHqfl0m+EiYAAUudE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-4jrOm0X9PbaERhpvr1mldg-1; Fri, 07 Jan 2022 07:17:40 +0100
X-MC-Unique: 4jrOm0X9PbaERhpvr1mldg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTtoBrn3nKz2q8mOM9huaZvAKmVHuLV4YLiGv2r6E5rVIl2t7ZysNLbQYgIZgX6Ga0uawyrwmwyB/OJ8i0uYK+NCuYIjn4sVGv9/DPkVU6w8rQAK6n2QG9Cj9hFoTWzz0+TgHFCJ9H5ckX/wPyCxb+1cnX6JLIiysTDK4QW6epyvtepG0YoNcljU5KbZE4kKA0pXcAxqV9qqx5U5vbxrG4OHJ7zTnI8p47l0Fr/vw0wEC61nzo6EpL/ZddjGvMUdxl3Fbb7HnHm5Z58WtJFGN55RJ3CbUZ2o3StCO9Jr4MhW60mZHdflI/mO3wSjvwwiCKT86PQoMzH7z50j7/qmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIE09m9TDx7X9rR0vRH9RbMZsPqnaV13eXpYZXTc5Tw=;
 b=le7BHrds0ykV/t/Kd6EPGIJNJ4CpExQq4JEwIK2B4Bd0wDKvjDYw5Swk/GbBdLj/U71xW2iVddSq8WbI2ohxxO/lmwaCxz8EQGOVwSuzaJ/KoeAvz/uexqGwaL7zMQ2976t4cCHIsUWRgubjIrqDp9WNqQ16os3VOqOkFYnHAlx8cXqXRxUM8sFMsdbLMpS9m7vQO4/cWHa/txeuoO+MSl52yPo3LL+J3sgit30ITR4u6TozRVU5QFtrANfb0FzKl6w7IoFS4Sa1OIKirXSP82UGXbyG1fty13SCqk0pkkIihGrjBIPPWkAv2+Q0nyL31UDyHOHt8AII5xz5HTzfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 4/9] selftests: mptcp: implement pm_nl_add_endpoint
Date: Fri,  7 Jan 2022 14:16:56 +0800
Message-ID: <f11f684b066c7970c372e2891395ab10e4bc8f1d.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b267a5-1862-498b-3ef0-08d9d1a566dc
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3369A06C9A7123694C5DC257F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1RNRIqRGVGTCiVxvA1Z7xbzm1WmCVgedUclp27591QDO9awFbcSCFSF3zAJzPqNAEI6qCW8z7PUk5zzn7drKnVKVYdujT6JSqnHuL1fdc33hMGTAsHhu8cWQi0TdwVyQK3i2LMSDPnzsnMPvCxesRrt4KaVuCU6JgHyWEpdjczTq9Qle1JBP4s27UOCbTCY/U+7I6mielpsB8FJpFOA1TRb5G16uwNPOqiTOkSjNKLmRggtthrz9wdcLXUeYOGXjMsSjSGLvibyM3gxgDfasTWlIH7T7B5llNOBov4tUWjkfDOIrm82DOAugybDp3K3Yv66InmbphB+h2EArfF7MSbbYTsNotQM4aukky+7bNcl5o4ZsUYa4EY4BSATGVDawx27/GiFjo6LFSXQR1DwOuMU7z76KKURNfoxo/C4tmVX8u/olpl1gzCPspCOZ1ReMqkv4LNJs+eHoppg1gQ4LJHnsm80irBkx3Ys3ca5AcYjK0M880wxumsnvhWZ6Jb5/Ov8jqdcG4jnVk3T4bfZApZxjUtcSq+sQCRysnUS/Qc2+PW7u1egLRDmC4cLwrZwQA3d21wRjwp5g3R5hQA7dKnm8FKWg5yt4v/hbVCIxdQOdPJDUujOOO4uD5NuJGe7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(30864003)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3y6rurGFVIbHk7joSqZqxkoJm71h65PG+BAonOst9DI/HTwwb9Sa4QOzhlnc?=
 =?us-ascii?Q?+RJs2WJuDsNzIfyIKSrCDXrwOXe3zzeWtWw6O3IoiEL2qTxqa9gBI9AW++8S?=
 =?us-ascii?Q?ltA697xpjAY0hZcrVydPySTjGllMuYMg4zHXpmR65T901HU6wD4tjA6TCOM5?=
 =?us-ascii?Q?4c09uinWGuY/o72M67fEDMNd6PDaU7Bqs+YSZlsqwfp4ol9zYs2ni2j++myX?=
 =?us-ascii?Q?KsyLKiUX9+30mtxc6OFdGtRye3GqgMEViAsh3zhFh/XtrkruFnobR3DGlccV?=
 =?us-ascii?Q?rFjBL1UT3BLVtIqtKzNIKYFfMBprxY5QcPejy+CQClvTT776lMdctLp+q5J8?=
 =?us-ascii?Q?z3WLEhldVQ0uHMyKFYQosm6Xk7Rdhb3cxQPmhFGTxlzAiSLZESsl3Hf26DYy?=
 =?us-ascii?Q?oA/3p+hO3K2IHuzqeXPcs5oxJl//2SS0wA59fvSTx2uqm6a/p82AStmH03qU?=
 =?us-ascii?Q?lLz8ai9UmG+G86OLnwN207N1Op19cqEDc/BliHZ9pjZ+LKGrFG70YvFnhZ/X?=
 =?us-ascii?Q?5Ah8/tc7dyn0v0033bQc2ClAB8smvu2KfCXg6n6mmWNKDT3BwEky+yRZiO8R?=
 =?us-ascii?Q?hQhZUYBKywQVzaLGsIJnzrQ+xA0LrbbpkhhBSulVajIcWgXt+MxwzeFRQTzB?=
 =?us-ascii?Q?CO1sgE4/2O+WLh3OT4jjzfJ2qeLLq0R0aaAljTvXKM26+UkguS0HpjQEjZI4?=
 =?us-ascii?Q?jHkhK8TfjYHoCvxy/vzS6+wj7S8lKA8VCjNnNx6qNVX/6OLcc7Fxt/Vbh9Ie?=
 =?us-ascii?Q?V31soXVrZctxn74IAQWcWIXa9EkJHge43BEWemaciUNz/S4+pCEOhNrFCkqN?=
 =?us-ascii?Q?HCTTB4W3K/2V19zG6SdIqUPsGHHsQm+4YVMQXDWHAVZPIxSSbz0UMVtv5dLq?=
 =?us-ascii?Q?CxsV7xbyW3bHHM4yhvSm/Q5s75fselVs85X16Dvi7KHw4xcBeErlcdzeDfxp?=
 =?us-ascii?Q?+i0jsz9ww4YAdGnI1YIeGkN9vUblAQSnIb7rqXZ3oHkwhrToMNReNuSNXRyT?=
 =?us-ascii?Q?zZDrzkweOLLRTwCK11PrTozBvqDH58s3lh5B7azQWw0k5t94pgULXwpryc5a?=
 =?us-ascii?Q?4x51HWe29kYcsslZErPWEmDJTeAUG0pIq3Ieh/nmqHkhp0DvNh9xT29Ukgpv?=
 =?us-ascii?Q?lZAlZfvmWKMsBGMSG4GC+HkdCupUqTw1P1FrGc5v/260u7Xkz7c8QCEHvyxU?=
 =?us-ascii?Q?ZM6FtEHpgnYJa06/OhwG9sg7EZouzNPFdDo1ngWiPjUahGvP4Vbjxzw8quMD?=
 =?us-ascii?Q?sp1vvAKwpIlV6nKh0COd1jZIC5Wp7kPN9Cko0YrWPQ9bmgjUbEDPNgDbqRe1?=
 =?us-ascii?Q?89tsayowzpPWMi2Lk6eA0hEh4DeNbGTn0ytLoyLmfPUoAhlIv7pkDSTkFvJ6?=
 =?us-ascii?Q?DLRsl5Jln1/nGrSoNU6UoM4k8b+K/6tXS4ecC+LhgSvXnmufyZd6f8JKkrQj?=
 =?us-ascii?Q?phxDybu3W+O+oKcU5UJ51SqRi2andSDzicGmr5YB9ndkxd1fAJVvVwL2ouzw?=
 =?us-ascii?Q?xV4X8XwArYr1kq0jJYwFgz47wE6dS1PHk/Pkrz5psWErfc5+7atN1txaIn79?=
 =?us-ascii?Q?sW8eUL0d3HKdz4cYeJt4haLEQJUsgR5Xg4DpkGhK+byAuHq74fo7tIvQKltz?=
 =?us-ascii?Q?/ziyBzB4Rs8T6mD6fuT4+KM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b267a5-1862-498b-3ef0-08d9d1a566dc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:37.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1672uvPZhFumc6DzNYBKCGf93gau2gYvNC7Na89ncrENK2JtTdsFLqwZo+Oq9lzW6Mp91d8z/EGIXgk0kNRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

This patch implemented a new function named pm_nl_add_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for adding the PM endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 337 ++++++++++--------
 1 file changed, 192 insertions(+), 145 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index d9142ad820e4..788a2ec75458 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -292,6 +292,53 @@ pm_nl_set_limits()
 	fi
 }
=20
+pm_nl_add_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local flags
+	local port
+	local dev
+	local id
+	local nr=3D2
+
+	for p in $@
+	do
+		if [ $p =3D "flags" ]; then
+			eval _flags=3D\$"$nr"
+			if [ ! -z $_flags ]; then
+				flags=3D"flags $_flags"
+			fi
+		fi
+		if [ $p =3D "dev" ]; then
+			eval _dev=3D\$"$nr"
+			if [ ! -z $_dev ]; then
+				dev=3D"dev $_dev"
+			fi
+		fi
+		if [ $p =3D "id" ]; then
+			eval _id=3D\$"$nr"
+			if [ ! -z $_id ]; then
+				id=3D"id $_id"
+			fi
+		fi
+		if [ $p =3D "port" ]; then
+			eval _port=3D\$"$nr"
+			if [ ! -z $_port ]; then
+				port=3D"port $_port"
+			fi
+		fi
+
+		let nr+=3D1
+	done
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint add $addr ${_flags/,/ } $dev $id $port
+	else
+		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -392,7 +439,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			let counter+=3D1
 			let add_nr_ns1-=3D1
 		done
@@ -445,7 +492,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			let counter+=3D1
 			let add_nr_ns2-=3D1
 		done
@@ -1040,7 +1087,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 0
 	pm_nl_set_limits $ns2 0 0
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
@@ -1048,7 +1095,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 0
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
@@ -1056,7 +1103,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
@@ -1064,8 +1111,8 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows" 2 2 2
=20
@@ -1073,8 +1120,8 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
=20
@@ -1082,7 +1129,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
 }
@@ -1094,7 +1141,7 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
@@ -1102,8 +1149,8 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with failing subflow" 1 1 1
@@ -1112,8 +1159,8 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
@@ -1124,7 +1171,7 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
=20
@@ -1134,7 +1181,7 @@ subflows_error_tests()
=20
 	# mpj subflow will be in TW after the reset
 	wait_for_tw $ns2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
=20
 	# additional subflow could be created only if the PM select
@@ -1146,7 +1193,7 @@ signal_address_tests()
 {
 	# add_address, unused
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "unused signal address" 0 0 0
 	chk_add_nr 1 1
@@ -1155,7 +1202,7 @@ signal_address_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1165,10 +1212,10 @@ signal_address_tests()
 	# belong to different subnets or one of the listed local address could be
 	# used for 'add_addr' subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1176,10 +1223,10 @@ signal_address_tests()
 	# accept and use add_addr with additional subflows
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1187,9 +1234,9 @@ signal_address_tests()
 	# signal addresses
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
@@ -1198,9 +1245,9 @@ signal_address_tests()
 	# signal invalid addresses
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
@@ -1210,14 +1257,14 @@ signal_address_tests()
 	reset
 	pm_nl_set_limits $ns1 4 4
 	pm_nl_set_limits $ns2 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
=20
 	# the server will not signal the address terminating
@@ -1238,10 +1285,10 @@ link_failure_tests()
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "multiple flows, signal, link failure" 3 3 3
 	chk_add_nr 1 1
@@ -1252,10 +1299,10 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 	chk_add_nr 1 1
@@ -1266,10 +1313,10 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	export FAILING_LINKS=3D"1"
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1280,9 +1327,9 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
@@ -1295,9 +1342,9 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1311,7 +1358,7 @@ add_addr_timeout_tests()
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1320,7 +1367,7 @@ add_addr_timeout_tests()
 	reset_with_add_addr_timeout 6
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1328,8 +1375,8 @@ add_addr_timeout_tests()
 	# signal addresses timeout
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
@@ -1338,8 +1385,8 @@ add_addr_timeout_tests()
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
@@ -1352,7 +1399,7 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1361,8 +1408,8 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
@@ -1370,7 +1417,7 @@ remove_tests()
 	# single address, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
@@ -1380,9 +1427,9 @@ remove_tests()
 	# subflow and signal, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1391,10 +1438,10 @@ remove_tests()
 	# subflows and signal, remove
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1403,9 +1450,9 @@ remove_tests()
 	# addresses remove
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
@@ -1415,9 +1462,9 @@ remove_tests()
 	# invalid addresses remove
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
@@ -1427,10 +1474,10 @@ remove_tests()
 	# subflows and signal, flush
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1440,9 +1487,9 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 3 3
 	pm_nl_set_limits $ns2 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
@@ -1450,9 +1497,9 @@ remove_tests()
 	# addresses flush
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
@@ -1462,9 +1509,9 @@ remove_tests()
 	# invalid addresses flush
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
@@ -1475,7 +1522,7 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1483,7 +1530,7 @@ remove_tests()
 	# remove id 0 address
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
@@ -1537,13 +1584,13 @@ ipv6_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
=20
 	# add_address, unused IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "unused signal address IPv6" 0 0 0
 	chk_add_nr 1 1
@@ -1551,7 +1598,7 @@ ipv6_tests()
 	# signal address IPv6
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
@@ -1560,7 +1607,7 @@ ipv6_tests()
 	# single address IPv6, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
@@ -1570,9 +1617,9 @@ ipv6_tests()
 	# subflow and signal IPv6, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1585,7 +1632,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
@@ -1593,7 +1640,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
 	chk_add_nr 1 1
@@ -1602,7 +1649,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
@@ -1610,7 +1657,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
 	chk_add_nr 1 1
@@ -1619,7 +1666,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
@@ -1627,7 +1674,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
 	chk_add_nr 1 1
@@ -1636,7 +1683,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
@@ -1644,7 +1691,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
@@ -1652,7 +1699,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
 }
@@ -1663,7 +1710,7 @@ backup_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
@@ -1671,7 +1718,7 @@ backup_tests()
 	# single address, backup
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
@@ -1685,17 +1732,17 @@ add_addr_ports_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
 	chk_add_nr 1 1 1
=20
 	# subflow and signal with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1703,7 +1750,7 @@ add_addr_ports_tests()
 	# single address with port, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
@@ -1713,9 +1760,9 @@ add_addr_ports_tests()
 	# subflow and signal with port, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1724,10 +1771,10 @@ add_addr_ports_tests()
 	# subflows and signal with port, flush
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
@@ -1736,8 +1783,8 @@ add_addr_ports_tests()
 	# multiple addresses with port
 	reset
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
@@ -1746,8 +1793,8 @@ add_addr_ports_tests()
 	# multiple addresses with ports
 	reset
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
@@ -1760,7 +1807,7 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
@@ -1768,8 +1815,8 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows with syn cookies" 2 2 2
=20
@@ -1777,8 +1824,8 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows limited by server w cookies" 2 1 1
=20
@@ -1786,17 +1833,17 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
 	chk_add_nr 1 1
=20
 	# test cookie with subflow and signal
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
 	chk_add_nr 1 1
@@ -1804,10 +1851,10 @@ syncookies_tests()
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows and signal w. cookies" 3 3 3
 	chk_add_nr 1 1
@@ -1850,7 +1897,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
@@ -1858,7 +1905,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
=20
@@ -1867,7 +1914,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
 	chk_add_nr 1 1
@@ -1877,7 +1924,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
 	chk_add_nr 1 1
@@ -1886,8 +1933,8 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 2 2
 	pm_nl_set_limits $ns2 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 1" 2 2 2
=20
@@ -1895,8 +1942,8 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 2 2
 	pm_nl_set_limits $ns2 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
@@ -1909,8 +1956,8 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 0 4
 	pm_nl_set_limits $ns2 1 4
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "fullmesh test 2x1" 4 4 4
 	chk_add_nr 1 1
@@ -1921,7 +1968,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 1 3
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
@@ -1932,7 +1979,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 2 5
 	pm_nl_set_limits $ns2 1 5
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
@@ -1944,7 +1991,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 2 4
 	pm_nl_set_limits $ns2 1 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
@@ -1957,7 +2004,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 	chk_add_nr 0 0
@@ -1967,7 +2014,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 	chk_add_nr 1 1
@@ -1977,7 +2024,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
=20
@@ -1986,7 +2033,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
=20
@@ -1995,7 +2042,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 	chk_prio_nr 0 0
@@ -2006,7 +2053,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 	chk_rm_nr 0 0
--=20
2.31.1

