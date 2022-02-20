Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5528E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUSq7pZtOlg9nJWv9z0SGXbWOO4idnQRXuDHdgttmts=;
	b=kMEWoNR/clhy2g3l03F244IpqkgKmL0sdyFVVxiG7GWd9hFskooI7YrHUClC1l5aBzjvQG
	HymnFFiHTxnOXE6nP4ZHeZ0NE5unnUDlbHPl/XKa4ELl5l325PDh9P41TYc+2KzMx+zW/p
	7e6bFlFYx538/lVZlY57fjfMNuMB6jw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-lpgj7_BPPDeXOGVTc-ao7Q-1; Sun, 20 Feb 2022 04:00:03 +0100
X-MC-Unique: lpgj7_BPPDeXOGVTc-ao7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnAfZcwDOwa+dA7U1nyVJ95J/r69OcJzuOyh139GMQoyTrwyXE6IMMNBISWmxJEyGgIjbuSxJkf75ify7pDj+yXHYoLC6gmR6ifzlwRhMUXrG1LpKbkWmZ9F62LS9Jx1ZC5W8N+JSTYBa8NojP/iGFI1gmOCW24Mo9E2cmahTUKMQmUH/2P4XSWK/uayOvCZxQPf5omA0XpTDg551CkXw6ueZOwpE50ylIZIqWMDZmX23SITb4qSRqdcucPZqmcU36Nx7H/8D22NR37VZzowk16nvb+uSL6R0eYsDQOlAnBTafZq78ZbwHXEN/HyXyFGFEbTf0O+ZqrfhnPQlQLMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgr6uFTb/ZPv258y/qST+tJHvYxPIVubvp9oSA9NjeU=;
 b=J6g1VQkuMm8BThMbwUpZNfmnSWUKLiinOyPujq6AR/3o83Q7uh4WNmHLy2fU3Sd+cD6jNUi1NtxF1t3rfTW3Xczak8CTdtI7PQ9rxOg3qzQnFzWNLfkwu7bzrjyjlDs+A02NMQNw52xFxMtOB9FV0TkHONQs0536erPY6SRXwg8seWF+E5W52RgcrHvitDZV3xuIZ6blBKtC6bK2jcOXGITlnfHXsgM2Kb3m1i3uWsMKDUv0gyRT2yob+SlkKQRENl2kgNt35dTrHGMjxaKVGlDohgxQA1BIaBnA78DVM6lfXhdItqOiIePkd2fgULxCBqQjekB2W/Vv93u26fgd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 07/12] selftests: mptcp: add fastclose testcase
Date: Sun, 20 Feb 2022 10:59:33 +0800
Message-ID: <5d516ae3f2c943c4ea10d14c0f5a22553b10e647.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34ce57f1-93fc-4a92-fa47-08d9f41d16ed
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB341409EF7A2EEDB243B7489BF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gB1ldN1dNAOUsU3h8VtuX1QYpN41CPXmi1Vy3hu3fh5nlhVF4jquVM2SG+LKMxvEsWs3XlEhW1PVeILZ1Afq+7gdNyhEjcs0QXNjdBV7rIYLKJkB8v9WBjtqQoSR9ZpLO2yNgZSpwT7lMjvb57uGp1HdxR+0vTWSimjBsL9AxECGxWbNrgrq6xgITkpGQYsJQ+JRNzoyA3dHoVcSHVocx1B82M8L0msUF6cD3ItDOmyH87n7LqsKwnYAxOspvnWfOn3GoU3tbmLUyMwa70wx1ah1W3KJdwpdIH/mzCTWM1UQsZPanShmUF/xUpZqtzYy+RwSn+rnu8o3O9fn4tNo6nIQHTAkN8rY0mq2p+LABnU8BK8fZiKMkuNHFWcq6/1Z+ysTMguU+6uMUC8KP3zInIffAO99GACEbrC5W8FsR9PnEbIiz0b4V4TkQfrn7Hq9RKHC4HEFnzM1RMbT1u+scTOrAVA4VVnSCmuVlUvbwRysmdw1ykd4r9nt4gcgP6k5CpX09Z2q5eLWDZ3REHUfhZhOiMsnC0JbvA3VeA0iZ8NYjH3dgGA9TlKItmZZAQY+YA5KkAVUYziMJLWODzKX2dYOXjKDQsRmXj7bIwm/RE/3qYy4ej1KX0J+lwfhiQnVspZ+0/1A4eQHEsw7oszHcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(19627235002)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvkYkCUdAe+fzejf2kfzmGiaKcuULmFz4ZDq3yMIjgMOJj39UTs8sVCV5Ivw?=
 =?us-ascii?Q?LttvtCBO+wvoeaNYs3XgJIi/ldGlbOWeG1W1yaGRXm8vLaONRxAbZxBOMgWe?=
 =?us-ascii?Q?6NvIKIWHmH8gkKkI22L3fo9fpb9+Nf3/jAAc3G1hqajmjn7vu0Rd2B//cLec?=
 =?us-ascii?Q?kXEAoE2OlQmYLq2YMpkG96j1TFFAtHf6IWdnl8E/24EoClOWdX4IlRAzH/8F?=
 =?us-ascii?Q?Bw94TQ51IF0R/a0cSDzklBNNs+ZVCHaZp2FuKKSz5QTWRCZOlg+rCTau+lXz?=
 =?us-ascii?Q?4UxBo3hXrHCjSlLe0wP2tMUSSIiCnKgdnMQyEftzO3YEaGqUj6e6Yw+GJRf3?=
 =?us-ascii?Q?AaWQcnHqZxwklpIUXk+MrnnOoTZRM+Cl3RvSxet8B31dFNJihB4eA5M+iY8z?=
 =?us-ascii?Q?pYrzNNccAXLVujkguFZXwyLcBuUnDxZyOuC7UP59uUFAiwO4K4zRmUeKryjs?=
 =?us-ascii?Q?JvhdwRH5kaxzwRi9N4HuSCWv8et6Env0Rxbx48QCUlL+8M7mgiYbfB5WeiGY?=
 =?us-ascii?Q?VvWGDdaZ5I9k8crdmd1P8R72+5G1fS6bkcRjHg07B1dEGYPaKemimHWD23op?=
 =?us-ascii?Q?SiYhZiWQMIfvzNOlG1eSv8htOKkdxlPBrc/7kPL0078d2V2LxFKV60N69qFR?=
 =?us-ascii?Q?AEYKgEHde+elPpex2W5oIdOkcuq5gGyzJQjU4Xi5D8XVUKO8UE9ItTMGXCSn?=
 =?us-ascii?Q?KLSlG1FZSMaUS0tPTGi0+mb5RAFZc08QmKm62MdUn6M8c2lkwZ/6KSHALMxj?=
 =?us-ascii?Q?pLotqAQyd9CG2xHH3zmPpbPww1mPrWTtm7Bu2b+Hse70wP4BeZBfePmBf/SK?=
 =?us-ascii?Q?0YVSvdzJf6DvQ/T8HrKFAELryQBwbCxQCUTyHUM22YHgTsNmdidbj7+CcwU9?=
 =?us-ascii?Q?FyhDYnfxyPfCeF1S85ulDqwKOTPA4ogkr05z2aiddZi72R3XZEOsfKkWDhF7?=
 =?us-ascii?Q?4zeKg4e6Oc0cDeeV0347n2yMNfOLYjToFCMDi/8jQWgW1nH7T3iPZdThPkx5?=
 =?us-ascii?Q?uvNqyGVJiPg8j43x5uWYQDaHskouAcfdTMxfBdSstZq2Dn24djmJKTkWe6K2?=
 =?us-ascii?Q?FIUysyRRBlam/N48CvFsvA+UNmbgNj0jxPTPfk1ZlInke2l01Ad7NGxGSmnf?=
 =?us-ascii?Q?U3Ugset96fU9oLbq7WlhJi2ndbAuendIL8lS3ffpMqk2452tKuSvFN84tlFi?=
 =?us-ascii?Q?qBltHkB7MqXM8/DFmBBi3Am80P2/kSuZ5TBOXgsC8vzkfop4SG6RuDXIFOxT?=
 =?us-ascii?Q?aGHsSNyDjee9jOOvxsVJrohCtFyEtgOSyyUYO/BMHkoojJEVsxnM38jZQnUy?=
 =?us-ascii?Q?U5DWJW5oY9KgnR21Y1LpPtQqFQFE1IiFogWQxH7LtwnqgNKgklsfTE2t7ose?=
 =?us-ascii?Q?KNTJy6JK+mQu4H/1p/ss2iUUH/JlYvTCoL1XlXPNFW6nmIB1nZ3xcJmjkgEE?=
 =?us-ascii?Q?9RQOj4QGFpk3mLsdf/LhE+WD988G78quE/HL+A6FGNcYc4xOvM4e2iO/AM0j?=
 =?us-ascii?Q?RwvIE/BF3OeLQW1ObpRfNBnjHWlLt3vApm6TsGlHFXR9h8JnHGS3gc802FuY?=
 =?us-ascii?Q?STrrKPUPPiGKzpsvAzIWLH0HTSZ3VRoY80QWHp3nzsLYDQ8HyFOg6dNGJiIy?=
 =?us-ascii?Q?u7SB3u1+woRYu/bleSsN04yfoAnj5S+yvz7+FIRNDiFHsMpplOiwW6g7YCvL?=
 =?us-ascii?Q?UG+VxaN/fIyKYOci9JbfAmZaQPs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce57f1-93fc-4a92-fa47-08d9f41d16ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:02.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfGAuNfpwKYV5Fk2WWxY7Ez99RG/NOwMuLCLX55653zLHf+rbsoWq6cgKfxpt0E+S6VwHgq1xj0dcXHi2p2Rng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added the self test for MP_FASTCLOSE. Reused the argment
addr_nr_ns2 of do_transfer() to pass the extra argments '-I 2' to
mptcp_connect commands. Then mptcp_connect disconnected the
connections to trigger the MP_FASTCLOSE sending and receiving. Used
chk_fclose_nr to check the MP_FASTCLOSE mibs and used chk_rst_nr to
check the MP_RST mibs. This test used the test_linkfail value to make
1024KB test files.

The output looks like this:

Created /tmp/tmp.XB8sfv1hJ0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.RtTDbzqrXI (size 1024 KB) containing data sent by server
001 fastclose test                syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  ctx[ ok ] - fclzrx[ ok ]
                                  rtx[ ok ] - rstrx [ ok ]   invert

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9d2076021df2..1b8b531c8a87 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -532,6 +532,12 @@ do_transfer()
 		extra_args=3D"-r ${speed:6}"
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
@@ -2409,6 +2415,15 @@ implicit_tests()
 	wait
 }
=20
+fastclose_tests()
+{
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
+	chk_join_nr "fastclose test" 0 0 0
+	chk_fclose_nr 1 1
+	chk_rst_nr 1 1 invert
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2428,6 +2443,7 @@ all_tests()
 	fullmesh_tests
 	userspace_tests
 	implicit_tests
+	fastclose_tests
 }
=20
 # [$1: error message]
@@ -2456,6 +2472,7 @@ usage()
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
 	echo "  -I implicit_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2487,7 +2504,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSiI' opt; do
+while getopts 'fesltra64bpkdmuchzCSiI' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2537,6 +2554,9 @@ while getopts 'fesltra64bpkdmuchCSiI' opt; do
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

