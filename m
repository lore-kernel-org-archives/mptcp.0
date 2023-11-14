Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889C16412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M1Z9jI75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg/2OPKpkJz7r/sxiOqGlta7To/+KIdsF+hXNzdWCjRFPcSjMf+6D/l19qV8vIhqbIEtBIRZMBzwMFdNbX4MiBc+Z56ZJoSu7Xu+IZRQgbAb6i+u5fObCGX0Hx2qbzlA9P26VUMWpomVTgi3b7T3P9crU0NUgoJkXjf5guekFmceys1oMXTngOUEoqp0B5EqtSTr9/+6qRXJEt9+370aCDut0as7KTbg8EcOuOwDaxi0AhUKUSG4CA/zCaw1kNBFZxMe7z/1IsikHFOXC4Z90KgJ5RHiGfLdkVdcAsHg606hZjr5RwoKNWFwalPSQr9hHa3iGuB1xjKkEItfGMA0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crt14c+XfXZGr+AztNhi8cZ3GTw2J6SRrvjLnY6374U=;
 b=ZQ/enwKJjBpIOEqbynlQCQSerwyx38h0x3LvXgZyMD74Wsw74YTPzriss8CNr3ZtVTzv50zyhZX3rcNysFKHCY9Dqsqms7LaYqAIem5nu7wKjP5OeaJff2pBKLxkZ3JxzTpN+Ou4wq/tYD9+ozGwVQ6OIIdUAbZeN9QAea1qKaXT/7WI3RNmsOFkQLjLizusKIZ3D7nQsy2QRkZ9g7N585BJhvOV2a1A6MFY17PWgVRU1E1whZfbh2CaGyutjpxVsrOJR/Cn5I4uNwt6YA+/0UgJnOoFY/h4Vini5jv31WjSc5PeWaTG/c6sqqEL0uP0TW7UqAVnLkThYCMgMXF4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crt14c+XfXZGr+AztNhi8cZ3GTw2J6SRrvjLnY6374U=;
 b=M1Z9jI750lKAPmMHn1j2ieDQH1fdvHXDV4k3lLfoVHloRzU8eXGQFxzwhExzCMFidb1cyk/7kF3uWt3ti5Lp4DT5Tcxva7LY3XtP2LTyDyD9jvUSH7TPKGtTijVqGTM8nJeqO5COrMdWxLR3NDzbGVcS/PgURzhGmrKQA7x0U1DzdhSjYwyaBfZFR3l8BCdS9S3NyfO2yGk5E1GaZpYwT3GpibD6Y78+SEKG2/p5Ps7m6x0pfWJRKSTq1dYW/L6zh89J5lbburQCKcSIRGkA/+RtJZOLSMVebjLiiawtSo7ReX0rQ65kor7t1stQcxh11cyBXGoDP9dEeU4ZPZAnNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 15/33] selftests: mptcp: sockopt: print colored output
Date: Tue, 14 Nov 2023 18:21:45 +0800
Message-Id: <1c38a69593f0c38a5f18fe21a3974ee2cebade9c.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c656ac8-2fc5-470f-d0cb-08dbe4fbbb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgYpiGqWlsvGc0/jb7nEj3CSUfhvmvn/cLw1SO3oRGvCOvOmk3PHRNaLK6fHQ2LfaKVaRzg8yLwvZhGG2MSxTrkuCBehrFqZ623lM6/9lj5fBmXodaOMoV927C3kS+QWCLJQyDohr5+41AEsIBThyEytjj+RGSTUGfFJswtnuFtnkXK8CoxEsJ7lL5o+mRhHUmBRT7KS92V72bsGfrg+m3yA30EMtSlAErj5MH1hbxUu7pH3V3myjc2ROq32odLWWerj1agbhtVdSPrPcsRbCQ/nrQHKWb5mBILn5nAJ9r/RJEpi9/kPFUVguAyL7Y3HX2aFKyc9dzjrfL6JTBixyZV7UqaX8R7kNaL9/zt3Cud+AXYp8J0vB3RkosM3WpjcdcynZFJy53gEJsL1cE0ea00MC+N37p0XUNFoyQ2FzaLTrd1e97R1cEYvwaQSdFUXqx+73axBnlgsMw+wECVk74m1fSJ1HSUpFv2Pmt1/+BslmF6ZOBNlrzlJ2A3jamxOhc1TOWI/NTGJ3DNouV5Gnrv6khSzJcWGgSaWzTqZ/VX2DVH6oesXa3qA7evJMKYf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sd95ywBPYM5jKP/cbE6pkb/wuU6DyaEgXOROnipNTYfpDJKbz4fJK7lWXqg/?=
 =?us-ascii?Q?aEJjiy+mX6zEvAXVjsULzymgIKIVCat2oF4uupPEDSGOpbc4QChgKDo6GImH?=
 =?us-ascii?Q?C260CfxOFIhcuMvzDjG4GofCUijVtICC4wSaHDA+XeSQ0xofYOKnTtMhYbNo?=
 =?us-ascii?Q?UnOgLW1SIIwEW3TSqP2ZJ+WapWFSS0QrSVqqHvly0VUNnlU4y6fcQm9DqL4K?=
 =?us-ascii?Q?EePKWvVxFEym3u6bfaBfVkIxeGncFAp7+hJE+k2sLuiVaz5FN5RKWP9e2BNI?=
 =?us-ascii?Q?Uc434Jysech2H4RvwJaStk6kKrRBrovL+vNq1jlo6ej8b3z/rmssbybzP7rN?=
 =?us-ascii?Q?L6wQxD6r34N5HcWxw0Y4uU9iqbvRoqnRjiAmA1NZCRlUcOX2YddVpA0MfpiX?=
 =?us-ascii?Q?YP5HjkRo4zI319qANvsljhgt2kD7nHHh8wqK4vnFJOtqKrx0GRaFvzz1asa/?=
 =?us-ascii?Q?DoDb0VX0rcAsjWI4n2NCSlQQJgcs8sRy4bJNcDXKrrJCK31g7RwuGIv4SIiX?=
 =?us-ascii?Q?oca8ak+TBS7CFIPINcLWRWQY4sBBRj5ju+g+6e5c+uu1gTmBghw7KSOkNdH2?=
 =?us-ascii?Q?u/66BsLVltKe8PngbtJPOOn4CzGyWoZwR1yHQMMtchdvcI9yFnbc7VRPWzGc?=
 =?us-ascii?Q?hXXz5zNTl1EWiFywwHALF+zqwWkVJbAeZt2iwBwMnvPFiDQ+FqTnpuQBiAYF?=
 =?us-ascii?Q?uRuMpI2Z9fRgpCRPnuLl8z48caQK2ar/uyziugH5VPeBDZEqQJzOlShaNAM7?=
 =?us-ascii?Q?2wBxOW9bp6zbNb/IFH7nyHKAMbxY9jIrfYWI+BuWM+zvHG/blCGgmlr/S7Xh?=
 =?us-ascii?Q?/aymAUZpl+agrjirntIC2dtTjYA9oMB5ldDSckLsuA0iTv9VHstVbND/ao3L?=
 =?us-ascii?Q?9yD/NEZONXgYLu4IfNT0FR+PvGUPvCLg8jchFmFhvF8YMyfMMaxCDq64U7JW?=
 =?us-ascii?Q?h8BND+CCybZcC60m4glPCKdUUoLMm46znEA2n2p3lN1In+iRYTEauMJU375+?=
 =?us-ascii?Q?XDsjHxLJ3iSlgSDnFQeLvF1qAX/AgWsdiYLqiKDZRlPumVcLKpZjs1FmtHoG?=
 =?us-ascii?Q?vdyiNMcNrho8FURe33F2Nsi2yFGVvgHy19kMQ70hefJB7Iu0q+sndHVQUjsK?=
 =?us-ascii?Q?Lk4zNWyRuPs1C8JDolgCiN/wcvnXCum0aUqc1G2173IemDr8K3Tp39/VGkJX?=
 =?us-ascii?Q?LFq3PKjdpv9NbCw0mb1okn6p3pdFeUxy+6OEau2L+U5GmPimVb4CL6Sb3Ey4?=
 =?us-ascii?Q?9HC+6i1VkXNjNMGdcf+IKPsr6WEXg5409OvEhtfbst5SZw3tObFMuk2k38pV?=
 =?us-ascii?Q?GdfT2vtLGTo5lZfZZum1RE5arNpgREJoyoXUwhHLkTe2+3mqsNo58lLTJbQQ?=
 =?us-ascii?Q?BXJa3F40zFPG4Ov4B6DoyFrrl9+ojdu8OS0qUKUhOLL5HGqH0I9j4fS4n3x5?=
 =?us-ascii?Q?WyHQdY5hW0GO8U0uLHHTVNW7enR2p+mYUnq4D7oldVDcBIwWQvJ9238cFtDm?=
 =?us-ascii?Q?h3fWlGUYhUI9rKyMz24gLn8edW7y5HgDr8L4Yb7X7oeJPaxbm8bNMR6S4z/k?=
 =?us-ascii?Q?FfBzXw9uMd/Qz3h8BsP66s1n6YMdzKguN/bSCkwa32OvNUjeMH7M1LcX0YnS?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c656ac8-2fc5-470f-d0cb-08dbe4fbbb4a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:23.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLSEabnyXWWGAsMRtQTuc5MhVH5jQpCm90a1Pc0L9mzz3AJAfLX4Uq8EldtFvQjd8c6VVSYFp4YItJJrXtqoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

Use mptcp_lib_print_info() helper in script mptcp_sockopt.sh to print
test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f445fc685b86..d03f9f9daa39 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -290,7 +290,7 @@ do_tcpinq_test()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -337,12 +337,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
-- 
2.35.3

