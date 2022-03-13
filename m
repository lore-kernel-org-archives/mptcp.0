Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF87E
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647177256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/D2/ZAnLfxPyJWxE+AVg2TynKZHWmcGIngJF8SZS3I=;
	b=DbyqEt/uaackFLvu0oGIWtZrdRrHvAuec+WUPmGc6JcBZtV1Nsa7+Coprbt4/pAe1BV9ou
	0SeuGTN41m3cvzRg8c6AMdi5Fj5jKUV82HZMTsMjGvBM2Hm8RYCVLcj0SQx4fRFC5kDz7e
	ukFdXjmsAi0MqIGnjc0n+wiJFcPuBPo=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-NJmOtkUTPGy612FsWurJeA-1; Sun, 13 Mar 2022 14:14:15 +0100
X-MC-Unique: NJmOtkUTPGy612FsWurJeA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2bXRsm+Ms7NAm9afHbLZ2WbCuY1CzgjPOdiGxwyLq2Odtd/eOMARKt/EMpX7BkQrLDfHrG5LOxauQk/XgCiNdJXsefIMEcw/wYfy6iBoCfBAu4YEaw3UywMdmobxS70eaFD1rJMijcu2D1fLvOEeszAmonRYnuvGHsmR+SCvDrFzTuzVfPS44/+WEWELw3IXqaWW/q4PFSbkYtZckAq4rQQ/h+0fdeTzYINGu2CHpagvfE7qxEnLiHUFZLp155s51RAuntJHQAgng38Dg0Ye4sZAFhgrpHHkuuRfm/RjmDk00ymcMGTuAaNSWzFKuOCkYtgtH1dSGfJ9E+Qnd4trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyI8URDjpQfBTOaPAAg8Be/baJyqmPNfmFg9RpyZejY=;
 b=hu5AJspc38So/4GzUbtgCK4I8rEbverP3ipsrTKN4GYe1OabOb8OGUzs9+cCR6jqai6mUQ6AtrV87rIHV+zIZZodNdqdst328G1hfz38yZsBuWtrFunawEofwvAAyY1S67qkb0bB367Bu01Dt0+f1OIOr1ZoOhHFy2TTtx1DCy7nGsxOsSPW+/Fn/Bif2YFW/lR3ntVdI3815i5YGrypCRmlVVKYgmKRA8K2oy7gN9SCdnChDQ/cqAVGhi5AmMZ5ObD/ldPi43h/K2DeCqOTOurvJMote4du8wi9+oqMXzSrXh/wdVVPhmOxOw/sUyQ3lgsTDnH6dUvmtnsnK9z42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 13:14:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 13:14:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: bpf: verify ca_name of struct mptcp_sock"
Date: Sun, 13 Mar 2022 21:14:09 +0800
Message-ID: <cb6c81062b128045bbe04f6c55f28051696ae1e7.1647177208.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0babd51-49f6-4bfa-e1ed-08da04f35e31
X-MS-TrafficTypeDiagnostic: AM9PR04MB8729:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB872905B13BC719ADA778F455F80E9@AM9PR04MB8729.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6QEHvIXiUBcOsMQ5QXcpv1gD+fsL2bvgxPwYRfUTsbbIQwUZm14rwPDH2eHwB4jqPzx4DcPTcDM2xmReF2YkwebbzzUshGDX86PgElKP9o7ncwJWowX3xUipKXp/8pYSMWjzGaDDcvSTy9qioZkAvfRVCIHc7J8lPPrSN0UIJDpGedvoExRUjEsdud+YioChIMz7vJkBGOwJwVMLsong4W4MaLgYBcIcKLnzmLw1Js0pJdDd3ghAwtMRTh6+PJZECUu4Vd099YyfNoC9Q6KjW9xTl+3JV/7y/plykDluFhUP4YMtodft6qMz67PM+ZcWI0o07mI+R1/K9lObs5OpCx/JiAPBc+LYHM3O8+FIEzTOgo1SxU4D5jfku76utld1oUDzvEW2YeXaitm761UITL+xzi6YnSeHnHY4ooyzoKyviw9VBg1enTnBAFa4wLULnEqkb99VV/KkWwqT7uYDBLGPlPRy2VteSV6EDz+C8Ov1Mrpqqwe3AXpYxiIib5LDsObZIFwLvQuiZ/5gaNdZkwIukkCLBCWTAPNX9646HjjI6HtcwIOv5Kqt2uLKFdzrO184nS0fSXlzFkTelGUCT2MvKBaoXhIpgiOvK+szHY4hryKNQq7RAKTKhdHsEhRFWj52sIe2WDBJ2hZEivPl6gZx0zmaZb1wekFIMc56uPUBzxTURQnRei2c/+F/cVQ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(107886003)(186003)(6916009)(6486002)(2616005)(316002)(86362001)(508600001)(38100700002)(66476007)(5660300002)(26005)(44832011)(2906002)(4744005)(6666004)(4326008)(8676002)(66556008)(66946007)(83380400001)(8936002)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+QahCH0++vSwrENkC7mFCsOmxy3YWtLYXflU90+EPnU8fmSi6YbmDUKqHK5?=
 =?us-ascii?Q?oWfCLqEVBTTZDHdEQzvOx8d42H7nLZPfGkCaWW05JuQV+9pjPvZymQtuLfNI?=
 =?us-ascii?Q?iuAoFHAoryDYPCH8Dk7DRaPepNq8fzXRWTjxa9Ha5lq2UXsaQi1yK89cG0zA?=
 =?us-ascii?Q?E9wepDJB726HPDn1rSXE+7u2j7ixxL5DQdP0DzXKu01+XvS0kSY/pxp7t5yd?=
 =?us-ascii?Q?Apd8tHgCCc7/lXAQdOv1OYe+bNqtCHI6bdiJYMS/jCPwg7vnMGF/dU/ZgpZQ?=
 =?us-ascii?Q?qZt5X7ptrGVxUEjJq8KzlyRiAT1lU093SfxxmDBY16eJszYQtnxwQPXz08oM?=
 =?us-ascii?Q?C8i8KyI5xZIRrTTeoQ8T4NXQzwr+TcAliLngnIH2m6tOpArTX5s0OWxJpNb+?=
 =?us-ascii?Q?2hhI4QIeu9/3BmjPLWc1v8z7xLrk79OGlFUoVqKM+4M5zUSx7BF0urpVoWnn?=
 =?us-ascii?Q?U7ABXNLj8iHXCHQgU8kZJ8BNtYinvocXgXK9vqncfW7MqAHxuo4e0FYXG8Xw?=
 =?us-ascii?Q?w0Pmwu8y5Ms3GwGh6VIwNpB91G3hy004aPhLPE3/HbVs0Pv+DLL6u1SVHnHg?=
 =?us-ascii?Q?OnCNn9YFQ8wGBYN6CqgQ5lxr4tJYUJfpTWe25YraYXrl6p6FfrJVG1N6m364?=
 =?us-ascii?Q?mcaJzwJdLwVZ3J2JpMBnOZVI4UdBeyU9+vUuYtd3yYV7utX3jSo/8at0Vmyv?=
 =?us-ascii?Q?wWAqkHXIC53+OViSRBmU03NbvDjIBnY53AcNhOoQjOTIFMaqUUJITZ+xhRdW?=
 =?us-ascii?Q?yTRejXSgVSfKqn5l8PjC2rMYj6stKXGLbDPxqBKeDJnQ0EUiW1hjLWdvUtRL?=
 =?us-ascii?Q?G8rU7kDZ5RN+RnYKt4RNW59T2I7Yp7+zc98ihwsdoDm10UKyGK32RQIb9PpZ?=
 =?us-ascii?Q?TXNecrccD7HWmcxY0cPLStsWsdKLVFcfUVXNcIHGjnKJwxxbU6QhXw64RzC+?=
 =?us-ascii?Q?wIKpQ/0J9h0ySoEUoyh7j2t9fk5i1tQW2iLKB8zf+WDiBpgXis5lsUKHIdQl?=
 =?us-ascii?Q?UnkAv9Ecov0HkLBhulEqPPsAyPlmPpM2o0LAxKsI5ghwukB/Bv8GPf1IquGh?=
 =?us-ascii?Q?I6qfOTexEf0W9i5raESeZusPAZUWLbZsSni5t5mdzeGHYK7GIa7Z+pg6Xtgz?=
 =?us-ascii?Q?iibx8jdJEX5hRv2xsYvbDzAIq6Znryszvdq5bFQ5dvT5tMOaMy5BswsBhs0W?=
 =?us-ascii?Q?5Bi87kkdUquc6roUNBpYwYfrPrSQYyurJbITpRKnr+aDjBVQqKqXFGeVVknZ?=
 =?us-ascii?Q?TuI14xz5D5+oSk0AQ3unqjwNPPD2Fb38CJ9c7eiegkkRP+BqRPWqzChC8Nym?=
 =?us-ascii?Q?4RfI7oYZG1B/ht1Is26vN0YAgf3PNLxgt2hqVulKIujfXiB1V27IU3P8O332?=
 =?us-ascii?Q?uZdxrOf2oa7eBrrFtsB0CGLKQZxHQSPVOcZVNFxOWdd3KfN9jGpJD4NK20OB?=
 =?us-ascii?Q?n1+xBYUU3cv+0iT+Q3c2vjnvh/ig4Etv674CBleYi3465XIltdEbZg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0babd51-49f6-4bfa-e1ed-08da04f35e31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 13:14:13.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TffT/tGQq0Cx+SVTibPTWbjRwQ7U6876a3LZHOYujGK/XWW2xQQV465wEqdtBX9dnhouc4MhlqaCu9ESnd7saw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729

Drop 'err' label and add 'ifndef TCP_CA_NAME_MAX'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - add 'ifndef TCP_CA_NAME_MAX'
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index aff35ab33379..d2941fbc686c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,7 +4,10 @@
 #include "network_helpers.h"
=20
 #define TCP_CA_SYSCTL	"/proc/sys/net/ipv4/tcp_congestion_control"
+
+#ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
+#endif
=20
 char monitor_log_path[64];
=20
@@ -93,12 +96,9 @@ void get_msk_ca_name(char ca_name[])
 	}
=20
 	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
-	if (CHECK_FAIL(len < 0)) {
+	if (CHECK_FAIL(len < 0))
 		log_err("Failed to read %s", TCP_CA_SYSCTL);
-		goto err;
-	}
=20
-err:
 	close(fd);
 }
=20
--=20
2.34.1

