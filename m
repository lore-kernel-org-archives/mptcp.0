Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606273219
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645159619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEeHs3z+tK+2uwB9RC6AsfZqCxuN7qqE/kEao+u/EkU=;
	b=BcLdwWWfWi4okBqhSt6rbBO9say2kpR9t/OmUEM92xeq6LAdYX1v3wx1SWlIvPnVgz211G
	qcxQstLfu8E64CHCPXVcnedHu/A5EWVi561DMUsVAoeRbVEd99CVEYWEqVzcTn+E9vdg1D
	FG4i4j5AokYtx9JRDgBiX0+uQMohSOU=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-u0eXSTq2MbOAv6-Ao0ab8g-1; Fri, 18 Feb 2022 05:51:05 +0100
X-MC-Unique: u0eXSTq2MbOAv6-Ao0ab8g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxCQISR1n4g0qV2QU+z88aPZUq53UnimT6IKQ6AymI4weWKQXjLSoiMyl9SwVddiZ0AzxnKm8CdKqV7h5mbt5Chk35f1b89T8UWI91h4ZOt/dwa/r54OEQmkuVkeRoHMn5bLv/dapSBZhKBN2Fp0nrw5l1I1kisH5eccwCR0MtC8xJYjXPEER5/rxWbVRtRMyAuTLFVz+rwkB0m1SMmHOKy47F7HY1VKW2Jq1H+0He8GXgQ4CjEtyYMf0VEwUBQNTFFPbZZ1M+DW3bqn4RUTSMBJVDkKnBD13mPz7pDggl6xh4epK/Xz4KYj5W3l7r6EyKAsNoH+NwThYhn4femAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCWabBYO0cM6F19aXRGhG/jXDXKQL/FIWUSqs2EjjXE=;
 b=PAq5vZgku4HadaUk7svdss2VmgCnqCfbNqCTWPneml/p2ve4v49iZmgS31TNZdLwA0NqMwnV/V/UJbsREl+D+SE9w1YXMS0tkzO7E6VNMynAomSK73jbRqYGCAtUwqrKo4BiZMPBqaXOS1L+DbEZ17e590pJrw1uZNyP1N1vQJnInEtdczOdyLDPmJOgvClR7gbGv+hC7BiPJ5MrCY35qcc67lkA1O632jpW+tinOcJaVmCkfUE9hkG24X2zdn4WvNsDbJ3KYPsGOnJS26CfHrs5ZolMRqEvAj/N9kI0kFCqxojxdpU84fEkhHD7/QAzfnfHUUrg0QjGdjVv00pZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7375.eurprd04.prod.outlook.com (2603:10a6:800:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 04:51:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 18 Feb 2022
 04:51:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add fastclose testcases"
Date: Fri, 18 Feb 2022 12:51:29 +0800
Message-ID: <22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75115101-bfd8-4dd1-523d-08d9f29a4360
X-MS-TrafficTypeDiagnostic: VE1PR04MB7375:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7375FD07E154AAEC299FE8C8F8379@VE1PR04MB7375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0EZVvrCXZgWCxDFuugruDPafyBx1g7WUXARD6eNFaOfGd0l0M1d19RXO66rzR94cSSqGsJxvc2h1b76bOmUfsO0HQS5b8TnnL4ifaIcy+WRID6+qBQJ+NQeE/v+oPSdzOSwjl/G4x2imrZMIVQZabRIS7YiyjeWJB0TMTd+ZxAaPN7DTAr4muf5ezLYVhXT5xBZFu5PFaxdfL+nnPQKogR6x4Ys+9WTtCPXHj59qDIHzJvpTRoOxKvTZW0XHToda1K+WisEN9T7c7/t/iq9ju/tw7fGuHUyzTDXKuW1mi/o41ydscA/x2AIpT9KBxlJs7FHygrJQeQA8aTQ4+154FBapNK9ajAwiYTK2aaNekM/yl+s5Mqt9fTrMMGVWuGf7KJrNtzXMuLIpkbXYiazHW+0vKHaHuLzusIr7PnAtshZ7Fag8nugGci76NuWFvoRGJTcxfZ0X6doN0U4lyfkeE2sRnfCfN4yn6of/xdYcF9DL4mNgJ6M8byYGuFgrW/7keDnGFBfBMZ0gtPx9rMy7/PChHVUXK5KA8g9vN5bEBM3HQGByGK4oHS5G03K3iVVNhYXTnLemjRAe12opKCBfezVo4mOeRwdIcWnpS1yL58+XcGFQg+S5gRDhaixhkg1t1UNASaRwnuNQ4nuebDk8yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6666004)(6916009)(66476007)(83380400001)(4326008)(8676002)(316002)(66946007)(8936002)(36756003)(107886003)(2616005)(86362001)(6512007)(186003)(19627235002)(66556008)(508600001)(6486002)(6506007)(55236004)(2906002)(38100700002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kvj39RW5EX/QVfyxEhcEhTllNMv9/9JRiqH0r/NzfI9miZPEINpTznqhzVTe?=
 =?us-ascii?Q?9VN87oIJlYD6hPsLoMJJLVrNmH5AdmWf3RPB+imFlj9B1cztRUWU0Nq/eRs2?=
 =?us-ascii?Q?pv3LEfi2tbPgXVB8cRBOho1IVVZWpxUl35WVucjjPqOF8sEA79i/DQDarVfS?=
 =?us-ascii?Q?i2+kj13DUWyd2YJPvHD4DAIr4yTpNY+YUdOf91CuyK9kp49jfVKQSAAHgbMJ?=
 =?us-ascii?Q?6SvZ+WNUxCQ7OZmvEgbM/XqjNIRvUUa11kDTQTg4UYuQF5i3L3wEH/NE7ak/?=
 =?us-ascii?Q?rtrw1tNIQadwFjAB0atJMpY/ya+3G+FYDhSiB/yeFpakQDqOGW8S9gYFAFq3?=
 =?us-ascii?Q?hcUcu7/Dc7RZflOhboTYn/kXlKh+wWGouiSs7BJ6fv0mlngxmo7pEEDLuL6A?=
 =?us-ascii?Q?vgAJ9LOivhpTXzaf6vT2mwLNTSkYBV0KohunASXT4gbHKnmjuUXuQKtUdS2R?=
 =?us-ascii?Q?p8P0NgVo6+VmT0Pu7HjaqLCS1H60CbTM/ynkv0RPKPBLCCIxFYM1RSjsTamh?=
 =?us-ascii?Q?xc8/2hEtl5bOCMbXfqrTK8P0QRhQA6F8zVXVldcYIjdtQwwH/bC2Vktr90Z0?=
 =?us-ascii?Q?o1wA0XQAsi8YztdQq8wDPIhPSyBRn/BXASZIx62yAjV7ugBJsXcya+xezve8?=
 =?us-ascii?Q?bYQjmkTtlA9BjpbaHMLG0GuDtLBwric589TrY5LC3cTFJ51ScLl1loug65kT?=
 =?us-ascii?Q?VPtmsOKaopgLMzvMP9hqPXh9qYPbfKopGT9GTEek9CtzyVWSoljKHKitvcya?=
 =?us-ascii?Q?qo69Z3XWQP3pmviUJqGFslnyMaK8Ul47VUNkt4GnY7Q775JtaqGJNFAQ37iw?=
 =?us-ascii?Q?tdYk4TaMn0dMYLpOSvCml7TmUMDGqfVAl5kb4SQEvxkojZVWWAZn0QwrugTe?=
 =?us-ascii?Q?Gx2TdsOqVmJmyhAaqfHKnmtuA1bneOTWnP+t88bNYOEaSgDfjftA37suMzVB?=
 =?us-ascii?Q?jQnlyUbFizfKJcHxA2BofSpgUr3QQHYRKWvfJMFLKQIICVA6MUWC5hcPsYFi?=
 =?us-ascii?Q?wWgDwgrANsNmB4gxB8BrNpqEXsGyZ5ZLiKP55oUkidLV1VkpuBWmCP9dpFfi?=
 =?us-ascii?Q?hR2snasIL6RDr4/owS0RDRG8AnELkOYt850swpnRQfAdFbxWjUDqLO/8EWpT?=
 =?us-ascii?Q?uy1vR2nZKAZBg0G5egmBE1AqgJrahE5GHQosfZzQJm8OxuPBOt4lt74bREgg?=
 =?us-ascii?Q?Zh07SQb7+9O1lEevG8SaonzyOb+AZFv2N3s9ME/NmtBg9A0E0XcCWYZSd59I?=
 =?us-ascii?Q?7CJuTwK2uZ3DHyUGn76xXVkd+IRRh9cf3TuvU7nOveq10Cx5ponmEPNVFQad?=
 =?us-ascii?Q?ruOvYZiNshRLiaeQ0YYWsdJZL7IH1wK46rSR1iG1Odxndvczxmowk8/2qqMu?=
 =?us-ascii?Q?uf90ZkxDVQ3JOvwDcwvzp/cN8DQzqDuRIL5e0XeyxEsmweB6LLQa+ZxQTPQS?=
 =?us-ascii?Q?7J3rKJXvmzTA+EEXd6BilcC7GB60SD2/ijXyYf+EouaxjMgfaRK1jD6rfYd0?=
 =?us-ascii?Q?aBR/6PPTYe5e7vKA9V/Ju/R9tg5jTWUhkOUT0bbOotWUHga1pvLP5azF9tjc?=
 =?us-ascii?Q?1MeTHO/30VLIKkT327PpgWWyhDXaJpQAh6etK/T/IAvvCmBCvQva/lADcITI?=
 =?us-ascii?Q?kJiQ6E8TWaEcnwfgMUmgOiA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75115101-bfd8-4dd1-523d-08d9f29a4360
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 04:51:02.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZKXcZCh3M6J+vA4P9K1lMEp9n3TSCaHukAWCL8SpeIl/Sm2wK0JWBk8mrzmEXPkZD1FtTw6NVoioxFpRdpc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7375

This patch makes the fastclose testcase more stable. I had tested it
over 10,000 times, no failures occurred.

1. Drop "fastclose test 2". The two tests are somewhat repetitive, and
test 2 is more likely to fail than test 1.

And patch 7 in this series ("selftests: mptcp: fastclose check in
mptcp_connect") should be dropped too. It may break mptcp_connect.sh.

2. Use the test_linkfail value to make 1024KB test files. So patch 4
in the "add mp_fail testcases" series ("selftests: mptcp: reuse linkfail
to make given size files") and its squash-to patch (Squash to "selftests:
mptcp: reuse linkfail to make given size files v8") need to be moved into
this series, just before the commit ("selftests: mptcp: add fastclose
testcases").

The order of all the mp_fastclose and mp_fail testcases patches in my
tree looks like this:

pick a854ead2766e mptcp: add the mibs for MP_FASTCLOSE
pick 57f50b740bdc selftests: mptcp: add the MP_FASTCLOSE mibs check
pick 12ae36a6ccc1 mptcp: add the mibs for MP_RST
pick fc3da2c8bcbc selftests: mptcp: add the MP_RST mibs check
pick 963f2f26574e Squash to "selftests: mptcp: add the MP_RST mibs check v3=
"
pick 46680be81472 selftests: mptcp: add extra_args in do_transfer
pick 81803638389d selftests: mptcp: reuse linkfail to make given size files
pick fe9ed20f6bdc Squash to "selftests: mptcp: reuse linkfail to make given=
 size files v8"
pick 24ba919394f9 selftests: mptcp: add fastclose testcases
pick fb989057969a Squash to "selftests: mptcp: add fastclose testcases"
pick 9985ed286b3a Squash to "mptcp: infinite mapping receiving"
pick 0d5bc6ecc54d Squash to "selftests: mptcp: add infinite map mibs check"
pick 2ed9ce9e914b selftests: mptcp: add more arguments for chk_join_nr
pick 82435d67b9e8 Squash to "selftests: mptcp: add more arguments for chk_j=
oin_nr v8"
pick bcc0e73c5acb selftests: mptcp: add the MP_FAIL testcases

If it's better to resend the whole series, please let me know.

3. Please update the subject:

'''
selftests: mptcp: add fastclose testcase
'''

And update the commit log:

'''
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
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2e95a8d321ab..1ef0119d7b7a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2289,16 +2289,10 @@ userspace_tests()
 fastclose_tests()
 {
 	reset
-	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_2
-	chk_join_nr "fastclose test 1" 0 0 0
+	run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
+	chk_join_nr "fastclose test" 0 0 0
 	chk_fclose_nr 1 1
 	chk_rst_nr 1 1 invert
-
-	reset
-	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_3 slow
-	chk_join_nr "fastclose test 2" 0 0 0
-	chk_fclose_nr 2 2
-	chk_rst_nr 2 2 invert
 }
=20
 all_tests()
--=20
2.34.1

