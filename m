Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DB2CA0
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1639723325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C6qcFlLVLrX5pa5GAo55jzJ9YnK/9/UkfxLa/whNFjE=;
	b=K0TeV8oBUaXamf+yo4+/UhSGz/MQGmRj1KpC1gYZRn+2OWjN6L/lYwd5MkdNZfrTMnxdnJ
	YBFPLafQryyU553mu+9mp5s+MkFHlTuCDURzFZvvtkGBS/AfTwSybZSv9EVCJi3XEePEj5
	xL1J9aH270GGRH6z/20+LKD0IXkxByI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-BoMluxktMc-V7YSuX2rHRA-1; Fri, 17 Dec 2021 07:42:04 +0100
X-MC-Unique: BoMluxktMc-V7YSuX2rHRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePsJb591DiRzxDR/B5DlJu1IYhxHgOCHbxCtbqDVDUwPZdoB2e6j1/s2W/dpUyOUyZ+HTryNi/7Is6WqidltdOQdtoh2cbzognt17LYJubs5LkEUC4a3QhKopPBNF6uYlQ9NfrEJ3ZyEuZlCIsxcGqlrUftFSrq+SqBS0a51J/dhirJCxllJGnFfknBmkURz/vVkHncAA+DiLqUKLz2Ecv9YowsvY7HIL4xcm/92AMm23is6cCq+E4WbeEaOUzeLQdq9HWPCXNsdzKKETcVET7/KK++FM8AEvw337wqI7HaDOhiR62EkNmrljHxnpoYWjmVxu3jtxTlsiBXTPSss9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8eU9pZvL34pL2vOUSSypvQdGD1A0jvmu6gaLzk98Oc=;
 b=CVksRXmQ9WcLRLGbwF109OEjtvvy0LVuoYVMjOx3fQh6gK3+sPUlkvIB2hp2CdJgkFIc+ZUsd2HJyAKYveec52MIuFPJERKoGRDtWF4fuv2oJfgfcEQLzOuACDSppRkEkdbtUNaTmCZM3FGrnzoHuUc+JTVymAu1OZfc1LMqYalDOwN/jkm3u/HRtSe8hSoucJcWTrC8lQEn+eSFI0mMrwYQzF+Zhj4nuE5d2ZWQgoDkjFZGCWX3beTsLLkhm5sQYuNS/L8SlQuqv2cxrg9XcBrWUuDYiDfEtFsPQOoNmSvnVqfaf8geP/efwcHz//CeHCE4slVKHd4TmR7uHYN/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 06:42:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 06:42:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add tests for subflow creation failure"
Date: Fri, 17 Dec 2021 14:42:06 +0800
Message-ID: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806482c7-02f0-45d5-79fe-08d9c12855b8
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB254061E64D6C2AB85F6ACF74F8789@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n80QRXXZwU2QH1SnySRJjR2KIa6iqD6ZqgkRKgPhCIlS/g6ZrxnE09OgohhSFzSJPT355Xa8dKk2JOL0Bf+/5s0wWJJJAWtpvbC5miciZkLkFDPGd4wS0DEnms9VC6FzRIcZAkUs2gAv2JbWtVvVBvDtWuaG9ElWF0QusCOmXy6Lgh3iT5tCqri6urITNoZKSzAQ4eDA3uy/un56GceaXG4m/+On2zpYwrSkf06XfzwdL96gQp91HiM27MfVmxzIMnT5EvKgUSI8Wd2/G7F+qmro28bUh/urRVoglVInhUhBa8xOiKZewR3Jv55I+9GS9ysQmaWVYWAP9fLd+nFNInRYyjutED585pgk7z9KTB0voLuzm+EWdJgn1kvNS7bf8Fz/9gvUnz2gvFfMPh5X5XHyX4Myi33+zZkuTLudkxOeZaTN+iieYojdPXNZouORyqUeif95I0t2UI7r9lsApfYmMUPdrU+7neQekGnhE5dLMVMIhCB3V95tdNB8+DJhOVeWeQm8Fh0sm5qx9OqrA4Sesr7CdiKG1oFxIAqBeIIOQhZ6ex9M2ADjw7dMIiBIbFPuKcgsWt5Gc6uBxo9kM01tZPK978Nd9AjHrwNeFJLyJKT70dcNP3zhhtw4YGdgaS7rwatIr6Zpzetj+s3Zxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(4326008)(55236004)(38100700002)(86362001)(5660300002)(6486002)(8936002)(8676002)(66556008)(508600001)(83380400001)(186003)(66476007)(66946007)(26005)(2906002)(36756003)(6916009)(6512007)(2616005)(44832011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cSvJn3ZjkEaEfT8kZ2/RK7K69d9PGz9J6B0elRGCTykbdyB68WL4KZfsgcck?=
 =?us-ascii?Q?LjaGqUYyU3TW2DQn7CYz6g/z7YRhFmtDSr5MDx0rAx6ApwUajKNpu2pX37TL?=
 =?us-ascii?Q?tk4ndCP5DZe/x//7LVuYgT61qckA6w2Sb0VFgl/PoH8AIQar4FK5FdrHI29w?=
 =?us-ascii?Q?NIUx4dOEp61FCatVVlacUMQt6YG73pAm9tYSZWh6sm4N9yEQL41lXl0Uy5TY?=
 =?us-ascii?Q?mDIa+9buiilzB52h7wn/iTqPrMdZreDs/bdz9U+xou7g6ayrDahrTOzb8eoa?=
 =?us-ascii?Q?314UHJIJVVisVt+q/Fl81lQ2sIY58WhHbDl+3mzUShG7ECah5jz9KkSD2BUK?=
 =?us-ascii?Q?g5Z2xAAAABseEcrPBW6UP1kZjawjCS/pHqdUw8cVCZ76i8P+ejhiUqvMt8Ll?=
 =?us-ascii?Q?3yVfsT+4B/PdbljOBp57G1clI/0ZOQo6fH2RGMLRF0yMWoFw1NZh+uIByZol?=
 =?us-ascii?Q?+DjRN0aiUJ7Ubm+nL6F20dnxFghnHoPtOCpoEdJe4Z9gGA5hQfeEsx2jKwU9?=
 =?us-ascii?Q?ZSfvqeDrXpx+8Ykg0dqjdLfuxE+gpZOayaNSm3kRLQ2IOZzoe8KIDH+8mxi5?=
 =?us-ascii?Q?doh7kl0RGUoTsc3AkMK83Y0Xm7b28BeDc1WNe2COMgYtEhKvYSfmluDwzLgG?=
 =?us-ascii?Q?MYeSszbgl6hbrCJyHORD1durhvJqVhssmJVew2Po2xTkNo5qeQWM3dFioYNj?=
 =?us-ascii?Q?TpcmOlBjobgeje6z0RIQkI/gtIUuf77NvPvmspW2NeCGAjg2J0SxY1jqjSBl?=
 =?us-ascii?Q?eTSj7OTuhDzp3bsTvU99o0g5FNDrdWcze1BimHSpojxVLILwFVN/bE39O1FS?=
 =?us-ascii?Q?D9bc4csuLE6mBqgnTGV7HoYrY68kLcPTXp15Ku2c7l2rLHSr0+8Sl0OKy967?=
 =?us-ascii?Q?nBC3Y695TqJS+GF/+mWRneJC6UW1D8HqA3TnUTaKwaDHtwlFWPBO6rMcVK33?=
 =?us-ascii?Q?YwpRaErOoygO8ujLnua6BvhiPZncGy12Hc8eB/fYXXGdKI+aj1XB4WE68Gm1?=
 =?us-ascii?Q?lt86UAwOYdl+mKQ+VLbTdnnDldtJ4+aADjSp4HTXafynn5zxcrImyCLAEYaE?=
 =?us-ascii?Q?4XU6/u/0cRp65j3znu/2lgQzGFSsxROjnPBfp7wpFA24qNZvgRncLfjP1+v4?=
 =?us-ascii?Q?Gslx3XEl3Qs6MCJ70R4AhPlQcPBUstWIQ7iKTSzQ9V96hyJBzqTIUBxQ9r8P?=
 =?us-ascii?Q?6TxeHmEdWSW8Bs1r173y/d4f+ifaqkADH8n1eghbRULAHNEmYXSudCY4apvV?=
 =?us-ascii?Q?B8izGhNey2zdlXbQtLKUzWJvCHXgehcESKmeB7yvEWFH6P5Nbu2lL2ybXlQV?=
 =?us-ascii?Q?vC6KGVntrrTrrTPNFay612BmGEJo0ljI8VfdwRPCJgk3IWIQrDGykAlGIuJH?=
 =?us-ascii?Q?wc5WgNEk9P00FqgLCuImcGHpB+I9L1WcDPnX6EdtsMXNyBqM8pWEO2rfG/Em?=
 =?us-ascii?Q?9unemWeKrDrosH3Z2JDAB3FVG8v+/PIUOagCmJiqEjE7LqM8N+nB/1sXO3Fc?=
 =?us-ascii?Q?ieJEzQJIT7wCSIYOEFZ+iDTq6qflfQrrjak0AzbQADemZeqKOZmom5U4txRA?=
 =?us-ascii?Q?HB4DxT66ng1d36XoG0+pB2KgXy4h1Rtdk9DhU42HBDoQWopPj3UAa51PI1Jc?=
 =?us-ascii?Q?LqCfsc1GMKubIenbSd60b9c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806482c7-02f0-45d5-79fe-08d9c12855b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:42:03.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTI6T+vWPfHKuOxAex+J0LHy1jX6sivFE1izR/ryiunbqBdolEp74MVbR03Q/zNww81IgkdoxUsu8frZoPlKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

Align the output logs with others.

01 no MPC address reuse with single endpoint syn[ ok ] - synack[ ok ] - ack=
[ ok ]
02 multiple subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ =
ok ]
03 multiple subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ =
ok ]
04 multiple subflows, fair usage on close syn[ ok ] - synack[ ok ] - ack[ o=
k ]
05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok =
]
06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok =
]
07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok =
]
08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok =
]
09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok =
]
10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok =
]
11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok =
]

->

01 no MPC reuse with single endpoint    syn[ ok ] - synack[ ok ] - ack[ ok =
]
02 multi subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok =
]
03 multi subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok =
]
04 multi subflows, fair usage on close  syn[ ok ] - synack[ ok ] - ack[ ok =
]
05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok =
]
06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok =
]
07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok =
]
08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok =
]
09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok =
]
10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok =
]
11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok =
]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index d70621700281..e48ce23d2386 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1069,7 +1069,7 @@ subflows_error_tests()
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
+	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
 	# multiple subflows, with subflow creation error
 	reset
@@ -1079,7 +1079,7 @@ subflows_error_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
+	chk_join_nr "multi subflows, with failing subflow" 1 1 1
=20
 	# multiple subflows, with subflow timeout on MPJ
 	reset
@@ -1089,7 +1089,7 @@ subflows_error_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
+	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
=20
 	# multiple subflows, check that the endpoint corresponding to
 	# closed subflow (due to reset) is not reused if additional
@@ -1112,7 +1112,7 @@ subflows_error_tests()
=20
 	# additional subflow could be created only if the PM select
 	# the later endpoint, skipping the already used one
-	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
+	chk_join_nr "multi subflows, fair usage on close" 1 1 1
 }
=20
 signal_address_tests()
--=20
2.31.1

