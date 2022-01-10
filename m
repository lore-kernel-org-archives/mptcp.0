Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734902CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG9QQe3TlSIGtIG3urZCL54T1+FYQbRuQO5Xlw1z7C8=;
	b=BYzQq+RQxowFp7e7vKLX58sdvnjJJkVviKvVNPxr2F7sFV0NJeb9L+TH9nUIwuMZmpT9YK
	K13mNIo6UCWyCV3ZrT68yENdE/NFv06ufLlfZ4P4199snx1L2nOcbHYYY1XCpt5qGPj0X2
	ETq3kyG9xaLPq5MTI8hfQVm7c3zoYj4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-txUVqQXzPTKqfREaIf1buA-1; Mon, 10 Jan 2022 04:31:06 +0100
X-MC-Unique: txUVqQXzPTKqfREaIf1buA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7iUbtjWojuCZhwfXMltFFwcOMhHnsLhfiUV1bVx/WObeBAotRyHFDAtwTuzdSqOCWQKhEGiDg1yYvre2/y/tt0ERRzs+ZOu2R5m+oWDCxKsLBPY7yrzvT3h/hHV34DvElk71UYpj4gOtDlNzI1AFwTZ8ld1DROQJKvWTnR/pGf89oALndG8j0S9bAiqW5ninzETk3CgP7xNn5n6BgKv/SJuEgjGOLEZZcQLc8/8XMQIaUNxQbZ8RaMx2h/2DuuI8QGSPh8tclUFNQN+EDyzIXVvzgpdAZ5c739IcSNLz0TdhYjYdgtZTv1CWYl3VlnbRy1RHGopE1EWZyz55X9ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI3a/zSwp9W87nhwJGzs9QJVJkQkfZdbTUkrUSG4goE=;
 b=hyODdxufUdBLgOWliDSmW0zkrLBNbo6kk9MRXksax4F3ZCzJOHOfWxnLxIHTg+XR1Yka96r6y975QW+fkWZ4NL5jE1Q9zmXlUVEHr2xEabyDWzai1jfVINXqL1zPK+dHKeGz+44aKsuxk0dk58ONuvVW4AYpLNkB8h6+pL112gr2sxJHBoS4MZ/Mz/8ue22VvxvOp/XtzmB3+0YGTgPA5JlH/K5MCCQLDS0Mqi+CJUHZPilN3MSZPwIqit2jUWHyoDSCastSy+tG52L6ujdT98JQJuqEhSKPs//gD9ChHq1Bx4u+6QhTiz4eZShJrdn6EwBc0rLYSyqJUA8mCstDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:31:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:31:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 7/7] selftests: mptcp: add fullmesh setting tests
Date: Mon, 10 Jan 2022 11:30:05 +0800
Message-ID: <5949ad258a4e24ef86492869f2e7db39247a075a.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc696eb-e7a0-42b0-1c94-08d9d3e9a221
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2569511B3FFC658A23105E4CF8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mwP1pqTezGqqLn5FjSRTq6NQNYKwwio+kdc5GMbdv/vfqiafCyKioNujDyqmdm6hdSJDqDYraoC4txWK3PujpxI3n++4omlFkBTcc72zHIiLdQ6g39LYyeM5gciV8uzwaoFV1PGU4cDc+p5Mx3h7ZoXpEr4lqUoPUcdVHmVTqjTUBtv4n4cYQ6/KxC5YuRgxZpwxPwgnNE4N+KPbirk2ai6tzrT3XK0jjNMUO4iZ2KzvHqyIF730ZH2b5O2rXTewwh1Ku99x5RdwgwaqJiUTX4xcFDxntb1fhC1leUO1I7yCl5Jyg1x3f24hDFeNvzO7iDdzG6Fx7SswCpXv/n0pWkRM2tpvbmvQdmhOve56uT82yBn9WQ1KTfuSNW/yREoPJ15ob02gOCu/9ow+khmk1HPdxDzuNYp9KJ/z/5RtpbHw8xGvUxgDI8jA29L5iO68dczlhjiZ4MpZaPk7NoRzY3YjWCDtLsRzp2of1ceURGvnTghh/bn4pkzj/WWY0vCU6Bmelvs58JiQPkkiuMCPZo6wVNb1B4wSGMBrXNuL7zBkrwkc3FPT4SVzNFdj1kC7LrQT2ndLKAYs1y8gsCNmVTWQEELn6JyBGEm2kt1ItmT3wv+giRMzfSkguMpD9iAIh4qp7yH+upgbwQfM55RanQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(55236004)(86362001)(186003)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHulJWDBoGHQZv3DAEfNDqmttl4pkyw9ZJY2/XMfoWcbeLU0hMpdPAJ+TC3D?=
 =?us-ascii?Q?cV4kLMBslzQpdn74JXdtXtGkZK/SAXjwdhy9lJ//g7BdHDTJHPll7LNMb4iN?=
 =?us-ascii?Q?x6sfTc1un1ssu/kic+u2XBzxfKZM00VSdqz5WbxYkIXw1J/O/WmVmV22iTTX?=
 =?us-ascii?Q?5ZetZrpkDDVvB7hWgAoDBA5YuuTCWzxBMrD70Mtdcjo2kIYnOTFMWYF0D2nt?=
 =?us-ascii?Q?rCJNrhCRYA2Pk9JNoIVbmFlCepH2p3dPd5gOPoBYZ/NedQdQK0UvHTc0TTKB?=
 =?us-ascii?Q?Hyn3xgaM6wQlPB6Q8iAP61NV3vnn8f1FcGoDrbAI5AQDPeah+KyxGwsjm9S5?=
 =?us-ascii?Q?hBtLhltuDR89oPGFSwwZY6qMgJ1ohiYZLU07zu0aduXj3RxV5lUXQJ6LaaUD?=
 =?us-ascii?Q?W7peKQiNex/t6ZpfBtnxhhth+qSe8oNHfuRr+qWhFBxI+m2ECRfiPwSu1VV9?=
 =?us-ascii?Q?QXGFTjSoTACTgwb7NDGmjXMBIIaEp5ogz+VnZuT12TH+5RjweacTuYCL6/Ot?=
 =?us-ascii?Q?c1knh9RubHop/M5+rm7vplajSdi/jZ+PVr+/JmHEH8iDZVP3CXPljSImV1DY?=
 =?us-ascii?Q?oWh1WxViVcjJNT2VigEjw+NmCteKySKsMDWfey4qUpAs3fVRxOKeooWc565l?=
 =?us-ascii?Q?oRK6pPiAsi5KsV/BqQUsFNApUi3p41WGmFn+YbABjOvaqjFqsCt7x15HPVYh?=
 =?us-ascii?Q?BruZopApBGoaod0ZDytyeqVRzZfrJhE40+066ctemPMruzJgVVEue+LP5Ktp?=
 =?us-ascii?Q?KvXozvDgaJRQgSSxHBaEu6vcdtO+oh6u+qz1aLMu0z5S66SXmr0O8TNPa0Bb?=
 =?us-ascii?Q?y1HY38PLPFET+yLXHe80NiErfWrjfR64Qxn/H32L1oX6TWvE5eP2WKnsyMxz?=
 =?us-ascii?Q?K/LSM80cueNR3DdLNy9vMyn/9odt5fqZCEHoMFEjZSfpgOGBWJBuZWuqQhhu?=
 =?us-ascii?Q?BviWIznA1obhoN0YbOO3iOtWBhPDWVq687lNF9j91OQdWvej7PU70BBE3ADO?=
 =?us-ascii?Q?DBDnmcmfF68ZVyZy8GfyupNZxFNYpU8LCllkf1mZLgxISXT+Mukw7zjCQdTT?=
 =?us-ascii?Q?Cfi4GCwSA+TjVKR1jpJyUItgzVn6n5FLdky6Zut/rh8uGug49CWjblg0is6l?=
 =?us-ascii?Q?GJ5SvpZUw1t2Dw0CrbUcwVbK8Ti38pTpfqOMvzxkHlqfPYPIQQQFADdtzx5T?=
 =?us-ascii?Q?7Q0bOAAh2vaZbNf8vwSCHCRPJ9ZwtCF7ph2ZsjPoB44llA6gyzUZKyoUFcwK?=
 =?us-ascii?Q?aIS1ZI4zgxpe4ZMQnpxVugYZVSxuur8xF/YpEz9OlN0Tb0W/oAayLKrTB5NG?=
 =?us-ascii?Q?8/QYRtOavhSdFxAqjrQ4TlXXQuVXATx9Sq4IhpYmqHrLPz5SOCFmt3/b4d6/?=
 =?us-ascii?Q?iTJX4neHVQwGquTWsZQQUnimH3PLOJnrisPrhgljIYhaUYzMPiwXxI8/4q0q?=
 =?us-ascii?Q?mCwYPrbKOLXj+8MW0IAYT6tjqwLj6mMX0xOIt+gL6SUm9pZDJzCCkufEVEDD?=
 =?us-ascii?Q?BRQmLosEkZCsWCRgcTBgZ2mz0sqQPmoro0B98o5l7hMVBcK7fHj/Wyy2mmM5?=
 =?us-ascii?Q?7eROF2360L7zLQYzUvUrO3fIHjX6QqsMqsRXoPy1YEyWvK0fkZbCtCTGEKK9?=
 =?us-ascii?Q?yyoVm08/8b3+igFZBFbAIGo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc696eb-e7a0-42b0-1c94-08d9d3e9a221
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:31:05.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyrFxx+gVC89YZlHlZ/rAsLq41UfEWSjvO15gO8jrwE6E+rmzVyssrH3Dl4ZBTitZFTacrMrc+f7Yy/fi3HL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7dbd36c558cd..8c4ee9092e83 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -473,6 +473,12 @@ do_transfer()
 				elif [ $setflags =3D "nobackup" ]; then
 					cmd=3Dclear
 					flags=3Dbackup
+				elif [ $setflags =3D "fullmesh" ]; then
+					cmd=3Dset
+					flags=3Dfullmesh
+				elif [ $setflags =3D "nofullmesh" ]; then
+					cmd=3Dclear
+					flags=3Dfullmesh
 				fi
 				ip netns exec $netns ./pm_nl_ctl $cmd $addr flags $flags
 			fi
@@ -1927,6 +1933,24 @@ fullmesh_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
+
+	# fullmesh flag setting test
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+	chk_join_nr "fullmesh flag setting test" 2 2 2
+	chk_rm_nr 1 1
+
+	# fullmesh flag clearing test
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+	chk_join_nr "fullmesh flag clearing test" 2 2 2
+	chk_rm_nr 1 1
 }
=20
 userspace_tests()
--=20
2.31.1

