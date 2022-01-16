Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1A2CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdrGhP5lKliTUPx/gW+lwCi554ynq0Rb0/Lw8p+k9OQ=;
	b=ZHOPr+gxBN7PuiginqutHIcb8BIw9GiYx7ehlz4i7RO8hLMJ+Nnu5CU0aNOA1nsyfrBrcF
	E10RFgX4RuF8TNiGDa4ZD863d8n+W9Cx5ocSXhUydfVx2+X+LvXgQBVKrC/3aFwIX+pcdc
	xWuMedsRVP86dxF5sgX+vXcwWCQU1aQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-WkjK9UVvNoeD-siyDM-z8Q-1; Sun, 16 Jan 2022 09:18:18 +0100
X-MC-Unique: WkjK9UVvNoeD-siyDM-z8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMe9HxkNqGAQP9TZXAeWiAUGAYZTNjQeVk1DYGVXNOgggTFGV0o1X7wVh8lGEjG/G9EWYzxR55NNx5wqxLKbEgnL/xw+cb1tW+0JDnqD3IQ7zG8tKFaAr17RJwv2mcMA1L3Gfg+EKD3C4uAzaZB9nhjc9Lj1IqYafbq04ftjeOpyZ+/4MmGoQEL9Ct33NIc7lt6AJui8XTcXV2iRpzS1M8jaR4ijFtN+vRHJO8x5jCy9IL2YfIV2O7YcXnBbKGfg9YMwYbDkH/f/7ch5fyOa3rRBJLfuM+kzjmAIlAceGPwdDV8TqXTkXvh4ZzYh8KHQSZ+pfRGCloKrdsDfNCa7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEu0FpTBQ0hcjXtCedDQEoBIsY7yFQVpgEI2JMg389U=;
 b=RwkErHTb8YKGDNzfiIKsyPZgTuN8fewvZghlckUakjwvymLClc2ogEgmkjkmYTcCTL6eNYcKBIrjW8wH58nRGCGAEuiT4RYDYqaQzjk0rHR/9uWao0a/+yNTwp9N6AJHxQmf/xPkBj0FGJBFUNZetjsq2MB4TvHgn4uyCm+rH2wI6dgSHTs/lQOjlDDhKvZZVYJp5NfvyH2tXecJbUKvAXmFmJlvZ0cwDcnQav953C18O3KBAcsnfjAi5iRISc2iYw2wOCwj7Q7goKUBZpA2mpGxoNOezyZFBNIG/RYguFy+1B08gpA+TIU+hsATJwp6QM1SW1E2vD4PKLsJCZVjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/10] selftests: mptcp: add fullmesh setting tests
Date: Sun, 16 Jan 2022 16:17:33 +0800
Message-ID: <e2d26e9578ff7a14fa4e2b5f3ddca02bdcf6bc84.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7154068-59ba-4667-33d7-08d9d8c8bf96
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB747271024B568490BE1194C7F8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ECCAdXjtnJ2XyFIeVJoq3TLv+CluMlc7s8c0VpG5IiZ0gn6vNQ+tMneiTK/XE7lqE2kIec/nj6yjgo5HEduLKI6QuKzXLsA7ion9VxYd6FtKwLodo5N17QgyNHib0vubm6gWGIi1vsUlZBsUfgVRDtguaomdOVGQ50/kQQFiDjfU9iHA6epE2Xr4o1Egps3IFot+cCg1mr4ooIQPef5YO0NGH2yq67/mvnku8lQVWbAorGA518D0ztN/ZnmeFHcb+t3tuV2QwdO6Ti3T4RKr811nSSNNjm+1CAhRTgytEumqTQ1kgv6ikJaAP2Jd62+p3cXK/7vIMVcpZSOFP3pLbCDcLzrI4xbF04f5m/Ql/F3SjYYKHM1f3860/iZ4tNw3Sql6gYnXa9KyPcjgiQu1F7EKkl5MWnqFodG2QqWSTS+ZfAxlJnan5eLPU8rFSfyzYzLD8lcLxfVhioHPl3pWtImwjVbeIpGW9l4BmdiQW9G6VoTgnkxtQdFTwAiZ1m0xJ6nU35aQWRlHvpZt80sb9+Z44ZScJWJQ6Mf0jepgPKX5N8ML/lwH0uZePsfJFJ/x6q4wBZm5FkG+MYhPnJIsGZ7l0kcsxtTS/zcU5BNaO2VRd95j1t4Zvpw+tPQZRBUiBE02k+rNVtWeP1pP+RsTeStoB604KmWuxNsgzjLvZmMgZVuwQ/TbjsRDsqDT8FC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(6666004)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qv2OLjmujso3MCKD3Oq3NCCiLt3rf5uC9tQJm21Wsj/CFXsy0vHueEk4FH9k?=
 =?us-ascii?Q?aZrq0qYufaMQ+BpuS6B7KJlUcwQPLW5GLAtPPEzN/67SxiBcEznnfC5H1ujH?=
 =?us-ascii?Q?znbkJwMG5058YxBKQEhk0UZtNN38pTuHbqKMRY3Vh8/VfIyMUi0Ttj/z80Wi?=
 =?us-ascii?Q?GUlGZOnPm31OphewFFSNRxPvqwMPNEPZficz4lKvcSgT7ue+b8LmReo+f5Z6?=
 =?us-ascii?Q?63QgendmIIqWxTIlN+aPxv1bsyczKNW2+jb7hNXMzTFN+2FkVguFypjMMPZs?=
 =?us-ascii?Q?Gt4zKVGneILDrBv5mDhgATGE+D8ojF9hLtXc4Xkl3PIimCrU9kGxbkz4a+Lw?=
 =?us-ascii?Q?xV3gyvSmoe6u7fkPYBqrPJQTENZlv9CqXFvOEzZkykUCzjlWhs+8+CJJ8Y7I?=
 =?us-ascii?Q?iCwDoTL6TH/554ZWNwihdTSU03KFkHimhHLQ1E9DLuATv5eBhjSv8SzQB3ct?=
 =?us-ascii?Q?D4Fy0kv1Nls0+KZEagBZKOiFFVfFgU3pp3jRqKf3sKvrtlm6wRYH4RRRiq3F?=
 =?us-ascii?Q?BmCBnpu5KfjLKjACeDUMIhmWJW/fWGjjQgz4q/7fLvNMOMt5j+L+wzuP35Ve?=
 =?us-ascii?Q?sFmjPtTlie2pJwg7SUYK60hydtg9exjFDzsSvSFTwWNpcZCc63myionV8Byg?=
 =?us-ascii?Q?WtQhsynGOgDE4HoOOXF1GT2hnSgbzD60sYaD13MLmkZImA+I1QDi69yEqZxr?=
 =?us-ascii?Q?4CZvB1jSxyaUzptNOECyOpzTi4YYtT2IkAYbkxsaONmSg+iUCa7Z5UDh8pS8?=
 =?us-ascii?Q?j59N2HgF12xCrkthBns6U4bvkNbJe3A/9OX0HchJ3mL/3sANkWZ10c+uPRGK?=
 =?us-ascii?Q?tb6iNttAHf8nGRVGIkH3pWlltqeotPSvmS8JQzre3e8vKEYjY9rxHFuWrwN2?=
 =?us-ascii?Q?vKOspzV2pN0Ks1j34vi/UzDsg2jPOEfiCEBTmp3D4C7YVg7tBVm7KszGZdmf?=
 =?us-ascii?Q?FiIDCjiPAofcUu6RcaEaYpcLSkh4Y4TpBkq4h2wHbLA40hEQh3es/tJ1dbil?=
 =?us-ascii?Q?4FoHqGNg7LwAstvfiC3X1PkOgxQ5sXflzEJFazgUMqKJfZnS6aWajBtS6GSo?=
 =?us-ascii?Q?1l93Jt9IV8lGCyHk9M/q+gPeGmI0coC9AnVcVNOYsjZ505HjVb71HT8XTH/f?=
 =?us-ascii?Q?YcDyCY52lyiQqbfVzfZsirEidvalfc6ks9KpXycpAJCBZf2rGIarsRcC1q8t?=
 =?us-ascii?Q?h0vQB8a5OaH6IuWvkjof3flKHH4NgwOqdQT5u9AV8jXdN2IpKLWY2nB0Qfs4?=
 =?us-ascii?Q?L1ToC1msAkE0f/g7EfLUX9Lg+CpJzTxjYMDlGUDqgi/GatdFV5kERV62Ezr2?=
 =?us-ascii?Q?V/htjesnHjsASLeuZas6zH9BH0R9z0dOhDMcB+l4D1sZXMsLTcUQeep1rLEb?=
 =?us-ascii?Q?US2Lf8O4/HCjWPLeOKPd2zLsy4YnsLgCSWx5euzdZI6CPLKrcaNhgVhmKseS?=
 =?us-ascii?Q?XXP1e5mLg7c/Ii3vBwBpqrnAQ90iPoW295Sxof7ai3CwEOhGT4M1MB6FL4xP?=
 =?us-ascii?Q?47j4NjvuTyhn50FIWzqY2D/b7rIsf/xNNF6cQuo+VzeRLi/3mZL4M5F0KjQ+?=
 =?us-ascii?Q?jPH0mmxxrcCXcWO6KUA31q+VeOR9DnekIpTnKXgAW0kAvmOVg1Wsmb7PB52k?=
 =?us-ascii?Q?Kg9PMFvoVPBeTFLY0sGyBNI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7154068-59ba-4667-33d7-08d9d8c8bf96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:17.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH3tfPsDxZZR4dGNjxddtX2nsy2QS0qiH40XfwMOohCnsJbQXCNFA9Ar66KdyPs7DZbuMUJjlRq5LVHqc3H5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Now we can set both backup and fullmesh flags, so avoid using the
words 'backup' and 'bkup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index de6589d1c541..dde5ccc8ef75 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -297,7 +297,7 @@ do_transfer()
 	addr_nr_ns1=3D"$7"
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
-	bkup=3D"${10}"
+	sflags=3D"${10}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -469,14 +469,13 @@ do_transfer()
 		fi
 	fi
=20
-	if [ ! -z $bkup ]; then
+	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
-				$backup
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
 			fi
 		done
 	fi
@@ -553,7 +552,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	sflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -582,7 +581,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 	lret=3D$?
 }
=20
@@ -1929,6 +1928,44 @@ fullmesh_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
+
+	# set fullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+	chk_join_nr "set fullmesh flag test" 2 2 2
+	chk_rm_nr 0 1
+
+	# set nofullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+	chk_join_nr "set nofullmesh flag test" 2 2 2
+	chk_rm_nr 0 1
+
+	# set backup,fullmesh flags
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+	chk_join_nr "set backup,fullmesh flags test" 2 2 2
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
+
+	# set nobackup,nofullmesh flags
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,backup,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+	chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
+	chk_prio_nr 0 1
+	chk_rm_nr 0 1
 }
=20
 userspace_tests()
--=20
2.31.1

