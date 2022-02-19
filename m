Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14757D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j8VqoE8G9g4aIfJKCZ8Ffc9EzHMYvDKlF51l76hz30=;
	b=EAG1b/hD+IY3IYCx+8RTuGmlTSNo8/WkYCv1kp2rKmGCha1mNrIyCZt5Q6LCjUjbWUAweI
	guZiQhPxi/X0fTvMbbh+omvKUU1ZXA+SgQ0LbQrh5CKmocM6F8Sk0+eiBeczuQ9vGugxaF
	/sib/qff2JpwWPoVmKPEzGqA8agiObo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-HWX3AFW7Mba-1iVRIwlirA-1; Sun, 20 Feb 2022 00:21:34 +0100
X-MC-Unique: HWX3AFW7Mba-1iVRIwlirA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHkStkYsew9aoCOAYA9Eu5nakxdHqgKJXmEVGeglISJ2f2BFkcK7QcdoNq06TJODLkiytSrzTBGkV+Q6hjiXqmXevPFIShGmjWkipNOjzs5qQsq7aOtrdrPb7sZdiviXue0Kj/75OsSp2hxVX5G0by1uVz77t58Sv5hAHWoqBT0gUXL9SSQRSV4O6mTfvDDIr1CMEIOT7l5TMMKQkSnlfOhSdwG++hlGd3soNR90HnnkFpb12necMRvLtRp7lsroF0FYd+d3WgD0pJSUqsMU8oXr7ueWbvyR8YTibwNyMrq5jdPOELMRQeCR9sQ/ds29N7L0U6ZyII63AcOZJa9Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31B/CTJLVc7fbeCmskwdV6udz5I11M7YiBXiZ3Aqlh0=;
 b=aOmIyVGkepEubWnutsy+8MdvEiCyZHxdsx3sxl+40kBl6XO/YwkO/lB9Ehz62rY73bZhyKvpjtx6bEeouIV+BisDVEtj4gqfeqSrR8sE5cgvAh7R6Du+UmGqI4brrinO/12h0duVYTYb6q3TZQXn9xoU546eq/Twu6JPHxvGPzMs0Y6q452tOum9gBWFkaTYEXg1tomSNmha3uCokg40ghxqVbc2z6VN++2PK2Mk48MTdPHvaqLI9kZCHFYnTzivsfZYHlxqrP2Bj5qfLsoRFcReAczWlKFomXvTCjCfy0qHEiH6UV1KvqqPahn7EbdnoNjOk0cl+OUeWeRixJORvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 15/19] selftests: mptcp: add fastclose testcase
Date: Sun, 20 Feb 2022 07:21:30 +0800
Message-ID: <34f3d3a75f2ec735514da220046dd7b885223407.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9375940-88cf-4d4c-60ba-08d9f3fe9102
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB684161879C606A1AEAA024BEF8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6asZP+L7lZi7P/62h0y7ceng48xecPC/Q3D/ORdQ2pN7sQJ3TmI4uXg1QILTDXjYFQ3mw05Ta152StaurRxLuRtBct1/e50GKCOMEZyXzSNl2miWUi71hf7oQNIiqZo+VdKp/TBtvnhQ1nMsURW1fRCsIc+UVwJeVfoOlipezskToKTazCdeynHyndElzPgYWD1mmK/RPH4q2/pmdijhIEAfb+ZnpQrLhp5eBdSLa8ALd0wEnG4bexS/H6zmTT0hY/NiK5sg9cvylFvdCjeyiktO42llfQVHoQs3Jb+amRKTFQ5hJrDYCoP/d8NkyFuWJMmG0/mfP3nL9N6EZ3n5CImkxA6NdNFgk6AulCemzt4jhc3IAcK/eIj67xYi79amr/cBkYyjiVDq5Zq7A99IxuJnHsMRJHvrtyXOIr+/T2XRTQu5FogZcVd5Q6qR8gnUftWwTemoGFtCdncLggv//OftwrVfzwmZNdpc9Z+BIQi/qvz3wHdkqjg61zd0o2G2UdE37Cci1eWvO4X8ZenCJ1MLeeXtpz6ugrjpLNDe5qTH8NlVD/CuugTWU7kZA9nMj8BsRq8QWO9jYdZUwvFDagND0Kxlbk+f5MLACfjmlo1cxpuL8fTgSA8G4QdzaUK+SsEZzZ9SYJ0NvsMhlgPGzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(66946007)(316002)(44832011)(19627235002)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFyrTTheJ+vaeAFDvIEoLIl7zQECIJImVdi06GW6S0XnbqlTJH3AEEnwlPrP?=
 =?us-ascii?Q?lkHXut7Ze/0Q8eQEAywopZvYUzYg+AwO1LkL6b0wX3wiIrIslu+G3AqiXbQL?=
 =?us-ascii?Q?Sl/0+pBq/79BqoqstzN1Spib8YrgSLg/ts3Ai52FM7EpdKvE+NNpoI8g0Y7e?=
 =?us-ascii?Q?AHU2GRyBgJjELyfpL92V4bMVQ8Q7HfB0SupsAV4//7Vy/9JsSZAv3tXlC6Cq?=
 =?us-ascii?Q?19rdFTaoNeLZ5CyRkLQil+mPJwag/7yLwgO+VpKH5IVP6V4X1R1q2bvcBe+p?=
 =?us-ascii?Q?7Qbdb9WWDIw61syvWwui/x3NujnwX0z2d22EmMRyWma+vrmViU8ehpruxWL0?=
 =?us-ascii?Q?kxFtBn+3PkOesKrUGc9FzI5bPF04/FxorXoxjKEnXOJuN33nuen5Ou2hmPNt?=
 =?us-ascii?Q?aN+Nxtr/l6nU5Tq+DVEyUr4+eWCQrfppA4iTXPPcTYXkPm+KMC/bz+D2U4iU?=
 =?us-ascii?Q?rkfhDhHVvxBuYBUEdtcsYX3xLAoFhQaRtdv+aBixdrK0wheXpoEqlArfSHqR?=
 =?us-ascii?Q?imdBn0F79ZvwstjVSJaMQQRnaV/T3yVArNMu9Wzb7bn30OcWNDZseokJKPKA?=
 =?us-ascii?Q?Rg3/MPcTQGq70DLpK742Eb/5GBT73NEyT64JUqczUn6a8PZr3iSDDnDXt/f7?=
 =?us-ascii?Q?olUnqeRZdnStkal6XJ7Vbt30BFQhrebGxcJIavlmWVfZhxv9xovTIv+QMD5y?=
 =?us-ascii?Q?fTf7wqsIg7G+hF1fj+xFlWj1DtnX3zCvkThxOObBHJL6Gq2LTgJeaHTzsbC5?=
 =?us-ascii?Q?H1ve9bczMd8fgwPSFMoD3dFwjlm+qfYjrcjbdnYPT47LhREiWXzt26LjBCW1?=
 =?us-ascii?Q?nhdSSz+n6RucJf26TP/4BCr8r8yPG4hQgK7wa8I340kulJGYBxd+bdDevQTP?=
 =?us-ascii?Q?foB4kB35jKBU57w3XgrrZgqGTawXzkLTpPeOHUrSxuO6otASFfI++Eb7hl24?=
 =?us-ascii?Q?GKe2ukirRoZ7U07SkO+SobY+M39eA0t/DLpyF/SxXwwMX8Ch1xiSSn6n/nD8?=
 =?us-ascii?Q?wH2sTeUAcj35u/e745Ks3MbCbcqmWdDepjOwoujd2hy3PkLAsTedh2lGtmSO?=
 =?us-ascii?Q?bCHUzi75wcJiDhhHFw5KoMhlnBo708vTsCb495MTsnX4PK6lK61vsTqrUJEk?=
 =?us-ascii?Q?FM7LBmtkHXkxN0K5GRV3ogJ27ZonBKjqVzaiGlrMAmafCZNzIqt/6sdBAMMB?=
 =?us-ascii?Q?VF/CidCFbFr8KC287mi9WfReQ+XQoeW5t0wC5cy3MVp04EFOkyDfvkJNyaIv?=
 =?us-ascii?Q?lbf0S8kX7nvXnKSgryCZCe7boDLoziP96hcQBX5sDJNc9y6Qv39JqW5LpaUW?=
 =?us-ascii?Q?qFOWpZxLQ4b2IAq1/qdEaLWpZbKAW7q0V81c83cOWTC1Ok6Vqvz+WDGZrwfg?=
 =?us-ascii?Q?NTQyCpY0/O7vCPcljWEXatafT5thZfj5BFmNDvFJQLMo+krH4AkEFeQMmQ4L?=
 =?us-ascii?Q?6uBHoICh7aSBaaIvyXX0Fattn6m0vufece4sxkgitKuVWUBOCFASwfIsP3eN?=
 =?us-ascii?Q?nL0lgjDvH3WPc8yb75dXt40ElqJRqlKasEnMoW4MGCuWf2mTEPNE2RvfyAvr?=
 =?us-ascii?Q?EprtrV4wwp3RGHCxQyqrKJMTDdUOl2o29BcEjUdXPgNqrM51CZKzp1YF8Eyg?=
 =?us-ascii?Q?S/iipVo3HbMm4cZMPpAt6I3OOsrIaUH/x9AEzOZX6uCjxlc59PidQfTnq77N?=
 =?us-ascii?Q?fnqXHdHyh4O7zxJbzP6sX7jNqnU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9375940-88cf-4d4c-60ba-08d9f3fe9102
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:33.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTRURDTSLQEV0w0Kpvd7GZENlh+RT3LzmVauyCh8XW35srO4PUq0czgDgylaPHhRp4RvUKZPhpnCsAiZDPgmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

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
index 9a9e84cc3917..8ceec91933b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -523,6 +523,12 @@ do_transfer()
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
@@ -2400,6 +2406,15 @@ implicit_tests()
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
@@ -2419,6 +2434,7 @@ all_tests()
 	fullmesh_tests
 	userspace_tests
 	implicit_tests
+	fastclose_tests
 }
=20
 # [$1: error message]
@@ -2447,6 +2463,7 @@ usage()
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
 	echo "  -I implicit_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2478,7 +2495,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCSiI' opt; do
+while getopts 'fesltra64bpkdmuchzCSiI' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2528,6 +2545,9 @@ while getopts 'fesltra64bpkdmuchCSiI' opt; do
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

