Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143528E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv1eny2DDITQeOlqu1Q79qIpyxsUvNQljSFyppVqVIs=;
	b=JD/nD67JuERlaGm6fSaDI6mwrTHKE7fil+AeiznxU3fPFmzzMOyTzZQLSbfzw3ngcb47Jh
	kukbvbPdsS0omuQGAnO3ybeGYkgsffAjnVO5eobzv1TW7ACZImtZIK71k/1pjbPbupjqRK
	9KIomB1f1XRA+/H9xV5vkTj7xM6AkQQ=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-qfBvk7zFPqOFuaFAzWJw8A-1; Sun, 20 Feb 2022 03:59:49 +0100
X-MC-Unique: qfBvk7zFPqOFuaFAzWJw8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjWs3elLQOb5t8rv71jyJYfcMzIe3nmYfImjlwrPHIwU5z8acABJQq/jZWw1tYUXEsygxH6vIyPCQmrT5VpimFVnHPkhTrBpxAM9AGUc8Dwar5WySgS2jpzC79KbuHhFErcjGa4UHUky+Ot/bXPMtJaZ+kjvreZmW25RjtwvKftIvLs+8U8fU5Qd3A3KgsGpru9pSVbWz9i1p7Q6ojKhwssLxuXWt5ca+wtF/67Sf8obvGrwWCMAydpLyfQZPxxHBDzTUxC9kjcwhlvJ8/9zo91wChO1bmaUhiBlzuJ+XJyHNxxbG70KXDbo+p0uiktfGTUBTp9+F1QMIaZKxsUGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed6FtBPhAFv4+jVllGpOt0+3heYmsiTf1q7rLJRReQE=;
 b=cvHyp02RWKVjjua+zM/xQ/u1qVzlE6pKHoQPwXZ1KXzGm3fjxb4cc4lO4b3317hJ50zcYR1GaWHjKLNJDO35fWnejy3+4t9fslNVde5JuRgrOvPKX8X0gqMJT9HlcGeO6PMno2/WZcn7WvNnohtur8zWYCWtvcdwCzde2Qb6H/FijOh+4dJgxFRbv9jkzRYl3eZeG/troeuP39cGaHazghOPrZf1TIze2Y9yhbELlBIMqW3a/2890sNHHF4INh+RQTdF7H+cRBkfR/37AsjpNuaoKGAWBUf0QRObnPYGw0PbEn8UhSF3InEnzYOS906sMZWRVaN8o/sATm0kDnwkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 05/12] selftests: mptcp: add extra_args in do_transfer
Date: Sun, 20 Feb 2022 10:59:31 +0800
Message-ID: <a833c66a699fe580138590c92fbc64c1ff4d071d.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b34456e3-6b39-4120-1de0-08d9f41d0e02
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414DF8586A53AB974C304EBF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcxvevp7d6fAo+z2fbNRE6YtdZkLACHSfLbW7tUI0V3rkciMYouex+Y6+0sjKPunlGwMRCJFm/6YzfSFB+A6YLyIhnyhtzWRAEPgryITYPq7eIGyX3WQikbY9zbOGVGhwe/ZLKb6Qv8FTQffoEtXEhY+7vHGTaJy5hrK2eEa/j84quxc+N03TQ/QOl/o9liiieu9E7ohJwLtm4cT09bNuP2Vb+R1swRgBxQB1pWZ5imr1WzG+1BWqmTfQ2h6ZfhtmdpCz5TaZpB0VoS7Fai0s0ThyZ54YmjIeB5YOC/9UqAsXwFiL26iAxWYfkf8hfPKT17/mrrc/RVH+bPwH4e3Xn+1iaeySQ5RLlYWWXankbuVZzv+p6RenB8/H24Ngof/2KVMuNbNTx4CSa4svWYcwNXTdnB+KG+eo9DBYJ//0tFOcx28ptA3Os3Ryx7oBoaL9sfXb4Bc+iYaDO7RywF+Xlkeo9fEGhtyPCdQBhloBp24pNl9Y1iTv6mGbUy3g0uMBUZsHIlGHZL9S9ZZ+EbmGRzqiB6iva5h848MMJmzjQ7wERo5WwTlQT2MlCNgdGmYWSmsFFLW0+Wh4+SmlsqdsK5G6MAASif9JETpJ+Ll+moJZTPDzpNLRwOUiccREYkLO0/DIBwBee1Oxesg6WnF8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PuXrAWAWsZvjA3zhkZnWpNGNY5zIM8sPijVO9NCCEteXTnjvUgeSfd4Kmnqb?=
 =?us-ascii?Q?JCmkc3Ulo4XYJam51MAXfrFE6xXOxnye2EnncZh7X+dZnP4KcpDyGt7Wu6xZ?=
 =?us-ascii?Q?N4lLF1hGx+hogcrGYFKMf+KIPnxhoLiBwzQTraP8amovqbEABj1fHJHHczna?=
 =?us-ascii?Q?PYGg3KqGp/Jyr26VYm5mxNJl0XCLv2GqgrFoLha2Deux9kO55RlGVJwG2AlF?=
 =?us-ascii?Q?/lTgeXLdPdd31d0ebu+V9biVNTND0cWOkcCA55vkK6pVhoBo9FAVcn2ymHYO?=
 =?us-ascii?Q?Gj/yvFxfHPM5mYAs3cWKGvhcDdWv8aEjHIMAMXxc4QxMLOQqACdtLfmVBZ9p?=
 =?us-ascii?Q?hzDqlaqNG/ovz7xWbBP7MALggpS6V3/dKrKNTjDDyZz1Mnsdl2nkoPdCfUmj?=
 =?us-ascii?Q?uAtEnv1fI6ID2TQT3IK6JpT67ACCWxdSDX6pZ8VtWX3xBGK59e8K3QC7vBeT?=
 =?us-ascii?Q?ueTihsI0kAZSjBh2BWk5n7+6CeVj8EWmeqyJGgmBaDy5a5GKJJltTHMpVIEj?=
 =?us-ascii?Q?jz0WqBZFVCAfmTjStIsgcfZiEqwAAuTb6/b/taI5otR7PPHUSp6AvQKqDDfm?=
 =?us-ascii?Q?fFG657fNI/tS55f2cmug8gUSjJRiYTgAbll+Sb3ff3E2F1kHMq/D90Z5Vp6g?=
 =?us-ascii?Q?CQ4kYZ5GPzstRrC7lrBrlXnSaqObR2ay49zu/27M9X6Fh2D6YoMe4y7MLV/q?=
 =?us-ascii?Q?XaqGWxZ336HSwIT+g0viXaP2P48jQw80TNZbEW3tBCpIPN+8FCt2qkQUr8OR?=
 =?us-ascii?Q?ZjKrDlBDmvM8SIu3+a+mQ2RFZsRRYVW6va3tZWhQzKS8PNgKz2AmACm3Fd6W?=
 =?us-ascii?Q?qhiyL2VFXdK4s2aCy0wVVY1tT8TYG53CAOAnq38TJYmd3sew/45zG1BxvZPv?=
 =?us-ascii?Q?5fkQJKQ7YxJ7IjPbF0T99zceUStb4t6AgbtkmfU5+27pySzreQwhT0YV4vJL?=
 =?us-ascii?Q?9k63aiYlHg5b48mvJwNOD3Rib41ciIWsN/0145IJhyorQx5siUf9ManzGzUs?=
 =?us-ascii?Q?7o8/66JliJz9bQS1bRqdlmj7Laib9RCNZim3VQXvj3WfLfLBIOaGa+Hpg7vl?=
 =?us-ascii?Q?rQHsdP9QJ3L5TSZGczA9paFklgraaJDYvh0+b9Nmfs3UV+eyYoiqmF3L7r73?=
 =?us-ascii?Q?C3zFYG+jRPTaApaMSAiY3Fgh+S7ZlvDQLtZdVKHdQsP1AnW8dDHkhx7Lqxsb?=
 =?us-ascii?Q?1gjIjC+MULkrIofp9Ye/tPn3DsItJDDnxy3CjYk5bKD5RBNgnG5kc+RyaHTh?=
 =?us-ascii?Q?UjGEYw69/6mk6EzQ8lCUNr+n3grLynAoOrzcNs+fBcL/AmYf/znAXxzDE697?=
 =?us-ascii?Q?+DSOw2eRdyTwcZasUBHa3oEk+bJODQIbIowhw3DOuhVHMBvKsas6q0fwav8A?=
 =?us-ascii?Q?7Ysejl+muX1JEdbHSb6+6yZDLvyHNrnCMi93rwXpgf8repBOAr1287rXdY+p?=
 =?us-ascii?Q?Xz3Bso8CY4PzfaUdQu0e1t4tAPd2kYmTqhel++Azsq4KQDF/3oGjv21zMotB?=
 =?us-ascii?Q?NpHWLv1VQT3qlFHx1tEtgtkwqMJClgqbLO0nucBqspIzlBUjfhs9rIJE6n23?=
 =?us-ascii?Q?oNujU/nd/HqLbI4DfgqjNR/ObGuanEk1wAvgGu8Y1RKYQRsEDe0nHSJVDOgK?=
 =?us-ascii?Q?vrjDSttj6gGxl5mBMg2n2usjxtgiX5G5Vn1t2oI4rvlEuP5w6mtLyA/VnkHi?=
 =?us-ascii?Q?9IuC+iw/o8gVvL9t4dN1fbMzeT8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34456e3-6b39-4120-1de0-08d9f41d0e02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:47.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqYyU/PROIU+hORGyDY/PnvqDlx4PSqx8TwCw8ETLHQBORlPsbNp3QaLsxuGtusuWranFsnSedCEtv8oaXQxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

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
index ed4b35652ab5..c06e9e9a0a3f 100755
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
@@ -524,12 +523,13 @@ do_transfer()
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
@@ -542,13 +542,13 @@ do_transfer()
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
@@ -557,15 +557,15 @@ do_transfer()
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
@@ -1620,7 +1620,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
@@ -1630,7 +1630,7 @@ add_addr_timeout_tests()
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

