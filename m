Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31E1388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2BGJBNpRBuiEOOkvfH4fgNyFTtT2cnMyTi/9Gt5RKQ=;
	b=EaIOpf5tEKBTSRfxcAdYfR6nI2oGhLHX8oCgl8RFRr1Nfp+Td9aqx4+P/ha3G/qtlvXWgJ
	/zHMaqFzwTf6DclAF/uX6fY/TdSZa5/fgc0/09SuKpr+Me7Ni4FJk+pZqzdAC7nzf1IqWS
	IocRqzkHGs1iURJo0W/rxj4ErxKoEPo=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-P8K4SiXJOsiiet4d4LdK-w-1; Tue, 15 Feb 2022 12:12:45 +0100
X-MC-Unique: P8K4SiXJOsiiet4d4LdK-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5MoqSVQF3NA3sDcHLfqKKKILSK0ySj8EIW24FxQHSKz4eL346Y2/V+s2C7GoMah93VPtjBS1jJqYRlk6O5wJ5G4aqh56gln/Sqd/yHpSPiI+qhWxofCKq1o91ymp7C8VgBWrgWqqj6jI8VIKdmSe7Y506WFi4P8XDqAdT1dOv2pSt+LthcjuFEeaDB4zscpptADFbWoko3z84OPASaGzIpI1ViTR1sGY4I9xNb02MrZh/6fM+cY98h70YOsp/uWDpOocltgWynUbfd8CoQlDrjYI0tVXOX2kHiJXQcE4gf57GDZfF5R/dpEv4RK/dBSk6wGW4Ouw1BR+kAIbC0kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb6nCRE4vbGMMS8rtS5F2HRnKWoTR2ctKv1p1hC7S1U=;
 b=YmMoZsf8vn5DUsG7GJHquIU1Uf8q+y7PNkl9jtdf1DIVPsC8C9eojVgz3i4VufrXtipNKoZdomYU9lXrJd6u38xkc/4/yVzGAMKRqLsjOq92rlPfnMKKnPwaYSaV1XCzdSy6+XKHg/Bw/brNQKMOVj0xxzRMET9PqPmRbGtd6cOmlgJ9xf32eRmT8KMgcZxqd3hGDpv8DFkurmRnNQKN9RDWzXyziCIvSYaUSB5xtXVHG/M5cB0BIxlUMUwjL/bzB98QmIx83L37C7M989uent3abwqKvPV3D6BjiA5CHQUQ8YI+DyItFJf4HaKK5Z7L1JeVtSz3xHSqe/7j1pQypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/7] selftests: mptcp: add fastclose testcases
Date: Tue, 15 Feb 2022 19:12:22 +0800
Message-ID: <314613f6979364071c139f9e7688bf5976f2da70.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d62c5f31-2952-4af8-1528-08d9f07416ca
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB292128A664885F03D8D8DF2BF8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uS8dYMtIyR4FYrjo13W8PM01s3RXngy9/ARAX2FujcxoB+Zvwoas8jITngWd1aX9AiKbawLfZIBmCB+edUgYK6hgwiJYTmvBftRCAMxa2GjjSKXkiBYORyIeqO+7UXxYatQEVLDJ7pyc1giEfv5rl4GnZARq7kBZCu40W8gJj8qDSy8KIDAfekYD16uoZB9lmInV3o1snP5ESKc0jE5cuLaguTbPNot2NCYc6bDYSPJ2GpK/8Aj5DCHIx5xkabnBVL4PQRC4x0zFd5wJ6xMk5GALxy+s4AT/I8zfZSe970S6vaGevjskZryXu/B8fX3LAv92i2fePMIxIaTJYaKzWcR0sSCmENrV+PGyk/yOJvM7slVGe+msDHCuFSBv9H5bHLuSF9fCu6/lqcBdXXJzj8wnkCk70X1Ikp9vdHnMy7S0NgGYc6AztgYe7VpnQT7xBt6HbzqA5cmdM/vM0/DLfx75vJ3VrSs9k5lbXcHuL2DQ+aFklr95nlnh2oXB7zrFHXtHHxGk+EP/aoMYFVEJKZ1mK5T74PaWakBvhkN6With6nn+KUXkuto/NnVwVc5VYNYiVnRQzOvvE2KzwMwb/ePak9k3f4rtfpKB0ixdKfudKoe1iJmlRVp+MbaTKPUzbEgN55BRTSmwphEdQvZkFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6666004)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBAESBcpRQ1HNKiSb0tA5IBSX2DoXlGljofWXisaB/kAZUbtxcD9X5nfSc8z?=
 =?us-ascii?Q?s9Oc7j5e88O5n7kEAYr5eaJ/d1jHIkuNvZY3aVPdf5IZY67RxzNp1V/Us0vP?=
 =?us-ascii?Q?QpNBKydVBxjeJvI9frb0IvZnVMqQh4Otg7GfFERRVaS/zoDrfc9s898kc4xR?=
 =?us-ascii?Q?3UNQu9myrwrhauRrDCzhBIIHtm82IdxeURxbt59j8hia2N+BcAsXCmu29Ts0?=
 =?us-ascii?Q?HPRaKnMlHWP4zT5sC3XgnlJJnYJcQ5qmEuBYyO3EQDYhebCutfJY4vjboY2p?=
 =?us-ascii?Q?ZVwegZLYzz53C8WiXStmh1/N3o7M720KAtHeKGbHS7MBQw6tF9kGnEvk7kxx?=
 =?us-ascii?Q?2658j0neGCbZ+TBpxA+pU9I+uRxtF3rQ0w+RER6QnklgbwQ7jlKXusOmnx67?=
 =?us-ascii?Q?d0kU8IKTk89WFSXdBr1MCZpv//l3djM4orUIfzzHhbeUbQj857r/EaPRQcoL?=
 =?us-ascii?Q?nnUPuz0VbDqIbw1+aaWunz3UTRj523gH+8p8nWV1/kq9Iao+YAAthL/j0fz5?=
 =?us-ascii?Q?0j+svEuxzZYw5lZfIozx5Dc/1qcUExpvByz9mSrVBHiVZE2ImxlMmecAF1A+?=
 =?us-ascii?Q?G0e63+fib43nsyA0aRhG94XDXp8/i9gT8gxuVB9wCj+lxNx2IWC4N+uvZcJA?=
 =?us-ascii?Q?PxwdZr7z2GK21adVlopA4YlxgfnDPRJi7FOw4aKgfnBqNVcAKq6uOKngagZ2?=
 =?us-ascii?Q?c0qDeXP4STseB1GX+ghFbmlz4eB1iQwK3MbaCavSKhV3qobJnoThT5c6P/hb?=
 =?us-ascii?Q?d14fi18i8FsaIfyETWFEFRdhzS4pPqM88vhgWYnhXJBLdRxB46jnnTLJgiVs?=
 =?us-ascii?Q?s16FSFKO6Qyadi2YSVHiAFuHGllIE3wcKavAWJaYeEFLgSDxQrchpZ6vmpHQ?=
 =?us-ascii?Q?dkQzJv3Tv605pPrh7SdCSFTPNfsKqpQL8ElbMbOR2M1fPxjOtvUla7zj/qRP?=
 =?us-ascii?Q?9BV502obKfBSkJuNlvd/H+4ZtZTUayOD258EwW+HldB892ZZmRoK7miQky+g?=
 =?us-ascii?Q?4x69xfO5oJLSxgvIU3IPb2PB/mhO/ET1e4vKAPOqO5H0Um3nUkUgpd88bfkB?=
 =?us-ascii?Q?1TWkq64wYklmxsxKfNsSB2BkHwVlynqbBoCaQvEEmx5wudqMXmoWykR26NUh?=
 =?us-ascii?Q?b9vyM9+b/ULLKDVulMBU8iJgwuH8QTq9NL3xDooETTibK4jI96ndKFisWfkS?=
 =?us-ascii?Q?FzEG2wa+Q9HDu0AFXfsc9c9ZZkU57Yzz+77gur9V9ukEAfmYiw2HXIaPlcL4?=
 =?us-ascii?Q?kGKmTyNAKyMy0cVFAH0zV/BnHywGNaXetJGZatKHHdyavFylrHZ8qCJhU2c8?=
 =?us-ascii?Q?61J6fzuyFRe3B2wysUk8AtlzgbriMFiSrRqM/jPdTEyiGUNHuqzNYKeZnhzR?=
 =?us-ascii?Q?M8NlG3oI0P+6NN8yeMzpCi32Cc+cLeLTuT01/KjYHAGNzBK/CMWeFIG92LLS?=
 =?us-ascii?Q?SsumzvnH8ErVrgqf/zUU9oEq6IxkE14ftI002xwTRIdjkvJ40WQ52stdS7/N?=
 =?us-ascii?Q?0qAc3bJt3xb2MpYsLWRG9WYX3lsuyDwl8GfDPvuv+Je3Qju8f6w1rb07H6NJ?=
 =?us-ascii?Q?ibyh56TzqMXGpKVxtwUBIWASIk2YK5eUzjPTYQGR+F4/tNzDH/xJwmYu1qVd?=
 =?us-ascii?Q?uDzkmJwebQRYVl+41buDBss=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62c5f31-2952-4af8-1528-08d9f07416ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:44.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FnPLDaFpA/qLzoxW6TsNa5WaSw5R/e3uvloEKFRjpIm5m1aecMh5/O7Xu9IXq7AHRtuxFAC8DAgmdYU9XViCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added the self tests for MP_FASTCLOSE. Reused the argment
addr_nr_ns2 of do_transfer() to pass the extra argments '-I 2' or
'-I 3' to mptcp_connect commands. Then mptcp_connect disconnected the
connections to trigger the MP_FASTCLOSE sending and receiving. Used
chk_fclose_nr to check the MP_FASTCLOSE mibs and used chk_rst_nr to
check the MP_RST mibs.

The output looks like this:

001 fastclose test 1              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  sum[ ok ] - csum  [ ok ]
                                  ftx[ ok ] - frx   [ ok ]
                                  rtx[ ok ] - rstrx [ ok ]
                                  itx[ ok ] - irx   [ ok ]
                                  ctx[ ok ] - fclzrx[ ok ]
                                  rtx[ ok ] - rstrx [ ok ] - invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ee747f4a4c7d..00a35601f319 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -462,6 +462,12 @@ do_transfer()
 		extra_args=3D"-r 10"
 	fi
=20
+	if [[ "${addr_nr_ns2}" =3D "fastclose_"* ]]; then
+		# disconnect
+		extra_args=3D"$extra_args -I ${addr_nr_ns2:10}"
+		addr_nr_ns2=3D0
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr=3D"::"
@@ -2285,6 +2291,21 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
=20
+fastclose_tests()
+{
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_2
+	chk_join_nr "fastclose test 1" 0 0 0
+	chk_fclose_nr 1 1
+	chk_rst_nr 1 1 invert
+
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_3 slow
+	chk_join_nr "fastclose test 2" 0 0 0
+	chk_fclose_nr 2 2
+	chk_rst_nr 2 2 invert
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2303,6 +2324,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fastclose_tests
 }
=20
 # [$1: error message]
@@ -2330,6 +2352,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2361,7 +2384,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts 'fesltra64bpkdmuchzCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2411,6 +2434,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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

