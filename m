Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257955663
	for <mptcp@lists.linux.dev>; Thu,  9 Nov 2023 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dk/LpM9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRdqIqUxPsrphFx43sRGbCVR2QeryF7/3hpImvbcv020o4fCEf6FT9ttTg7g5i7QzE6eZdOQwCrvkLNay/cYM1Dtbns3mTZ5UU3HtVxTxZM9b8ADwnoLFSJnGBLK3x8SSMA5DKD6HqOHKKR4eR4mBudbsAPY2FVqim77bH9TI7N6C4CTqvlnVtfAtqlRplQImzyPpMpGB0pChvfVSPJZymv26fABn1k4KsoRqx8+UPtsxPPf8Bz4PuQpHMJjpRrxAbhwM+r7fWitdzMppN28AcLl1c1zuss3rRoulFNPHGCxYoUzXiZS0wLgbISlihad6TpEk2oGbx00OMq59PfzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQcCIp/KayCeBeSeb0Exck38TUyZMsavjQUJi0KLjYY=;
 b=g3Qk2zOFpZHJ3EOwYDrJtb9UXxFlGmr5W4yfYcAY3wj68F+8wSfiB5XYZwu1q4ChTdIAEr6a0adfwhWYixAhrGVKeOC4IJ808Vr8gxRAp1y3votJpyhZcyexuiZ+pPq2QoeWrWw4mfOaTnoheJAGJhmPC9PxG6kPuK549kNHU7A6Johk5Kew8FCWwe3vC+5czedE1faovMDUqUIWNcE7HAeTuh0x9+RiCaupsNuNjMB3w5tmgtgxwW5Z41gqC9vTX4WYA/lMqObVHQ+3L2OLs0reZl1Cbxv2GfZe8ZWrWnhKi075t3UPSovhkW15flNzZWltmFWjYQJWZ9h8fijYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQcCIp/KayCeBeSeb0Exck38TUyZMsavjQUJi0KLjYY=;
 b=Dk/LpM9LAU8qsFQUx22qc7ISG18Db4YvePKKa5srpHwLlGUx0mb9NatOghzwwQvDXru4faxq6cmf0E4iUKEdVRn6PkxUf1IVDGJOIrfCB2/O72uuhw2997MnCXrcoU/fwW7ljo6OXl05tbTnZHzhf3z77oTRKqu783qvMEhQbgsAi0M7uD0YmS+aI0tj3RsKdifQbAw3PWLU102G0Y2C4lC4mBrKWo4JMB7uN92aLhGj39zJq1zA1cnOH44kRZV6DlM9NUFHXeAgEjI2XpzcgA/Wif3xKBXTlQPmEFz/8NJotRzE6tw0yG/U7qpAhxvy5Pu5lwO3o8bslbIJD/7kGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 04:00:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Thu, 9 Nov 2023
 04:00:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp_lib_echo_* helpers"
Date: Thu,  9 Nov 2023 12:00:27 +0800
Message-Id: <e09c693c129222bc07db7b625a4d670d7d6cf174.1699502421.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:3::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: c17a604d-34b7-468d-dda9-08dbe0d867ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PxOaOSP7t+scORog16jCaJct+ic6CIIXNe0jf1mHc4fEYNUYoM2qQJzndDHIXt7DDVp2DsSdWXS+WzGptHcesRwefx5HCT+WZJTCk48DRI5aTgjLPXYGv3UVvtBv21QXWCTKAen5SGw5BMahyzOZmsWfeTmfSkYInRwcKWiNmf63xqehShzFUYxqlrT+l70U9iX/l29MExwHbBsPfDauC3XzE+cLtbomp8iQmF9O6JG6cZ7pDpBN7kPe3bmT4DLH2dJWSwB9arqSn2HDpX/pwl/yJizEr5PkQf2IFtZPwOvguIbnL0t3HWaFqvg2Wynqrmfv/Zmi2SY/87IdPERHR8hnUZ+bvUqsUMnR9KDMB1V/VjY7AAfVdFp4Pm6prpTgPtzJMaAop2TQrixKO182P90FOSogcPTICgCOVQlWZjbeQUuLtfdFhMizfsbSf3cmw98P7t/BIpdRXx5E7Q7f9K8UJAtpwcTQsfe6M9tz5OLJg7UEOTIvPYhFf3AJhiaG7S6oUbNexx9eaPWzdIzfYFju4ohb7b5+GTsSdvbZkJHWZnQq05Kx2oyxIwVkEuH4WHOBugwEoh227/UO3ASnXP31j1bNRtbHhk80AHdcTEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(5660300002)(86362001)(6512007)(6486002)(6506007)(2906002)(38100700002)(36756003)(8676002)(4326008)(8936002)(44832011)(41300700001)(107886003)(83380400001)(66946007)(6916009)(316002)(66556008)(66476007)(26005)(2616005)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZAlFPtabp9y5nNnxe9k2rM7iX5w6QLP3YhmDgZUWqtRPGkRQQWWBE47gIzg?=
 =?us-ascii?Q?war5yU7JG+d6HEW0HjnK3tGKppGsc1+yBnunFrY0k+a9Iy9VAqk4JB8U9KuK?=
 =?us-ascii?Q?UPenHMsPYiy/OmbtBB/5kEJWGk/wVKat9EIv0wqm7vkYA6Oa2GL/QDO5J0oa?=
 =?us-ascii?Q?dT6MS27Sn+r0exH1ZzMKZiTZHks788q+Jd0UHEkEbRk+8EBLFpylyC/WERnR?=
 =?us-ascii?Q?QcjPp+zlD5H2bsMtktpDIIyLTvjQVK/O2iqh2QCloeCwtONZgbkCZX/npCff?=
 =?us-ascii?Q?b7dSv5OVWkvaeu3w39SmnxQ/UXIMsShS3HiOk/C+de4RZ+Uytzq6lXZAjaS0?=
 =?us-ascii?Q?5oLaw2UfNbRJ2rjHqBl8NFX9YPEqfJhMq2pidJWDv++sjXITIIsScDJea2Nu?=
 =?us-ascii?Q?mdAcVnbjKNzQFZTR1QH1jB+hhiPtlYiLtUgBm6+6iXK4ITAqvWCwAQzE8IpM?=
 =?us-ascii?Q?2uNtLn2/nZP7q8SU8eJVZmTJEauElcgSewZM9cXCDmNJOsyNa1T86t35w/3U?=
 =?us-ascii?Q?ixEv5qBT+5c8mKkGaRXY6fDaZ5RlcHVdGXLB6mecJfTdmnsPzvlfBT0d9oHH?=
 =?us-ascii?Q?lIFWc5vJn1CVYfEtuDObtol87Kv/UMY00UwWJhszi0B85itrYu5Ii1fg1Wow?=
 =?us-ascii?Q?u2/HHO1O6RbJfk+rBI+7fVzj4kT+C31k2ARxxe3cEPVmCCtnXVHOpMlc7lx3?=
 =?us-ascii?Q?dUw7YuISmIT7dWA57VZmu2kQNio1fG8LTR96F+gge612Y9nwxaeXN85DgZaZ?=
 =?us-ascii?Q?9Y0AV/mgIHu0gSJIJTLLUYLmAvrRCD74Ibfh4E45oVQHzt/JazIW7v0cezPb?=
 =?us-ascii?Q?YevTa9F5r/dvXawgKdFCLR9g+upOQ4VbC9ehHmZwBsGWZEGPQ0D7PrUxbBW6?=
 =?us-ascii?Q?5xSEznfM2NIfApMbb2zfcwrwJ78p5/U37EgMjs6swBUnQfQXpzVFerJLiy/A?=
 =?us-ascii?Q?JcM7rcJk718qMUYrQl8sVOHa2+yNrIt+iLJuOTnBNSw8bcW+V1mzjXiGBT86?=
 =?us-ascii?Q?BZgm0wvSCX6uhGWRA95VI7U2Ewb8v98sLiqGbAiq580MeR2IebUDes2DGUuF?=
 =?us-ascii?Q?3R/TZP4s7y5YZ8TbkfevxYwJbvRdSZk9dI+QWrwrfcgzt58gZZhuON6nHPwD?=
 =?us-ascii?Q?2bGpOQCDzPZquywKQ3BGUW7dKbelauOfMAH4CitvDXRWgXDOcWQHOu8O5gjL?=
 =?us-ascii?Q?raafYmF3nH1J0eLsk32Cpcs8UHSi+HcePiYxFdwht2I1s41pw44gNAl0QRZU?=
 =?us-ascii?Q?R2Wh5KVmVBtHhIpg4AD7aTOkBqoySey/FcAC7vcGpGF1yXqiqzcnta6RliXl?=
 =?us-ascii?Q?vLZ/b7ofi5sOF/HBXvlHMsXv5h+o9pLiUCebPkKDEnGTkv3AJuLJ5rGMVe+w?=
 =?us-ascii?Q?gUhOD3APafLQQOCwn80k0G/NVEa+XddcIeom8ujFLrY71HO2ac5HLJxEP5lS?=
 =?us-ascii?Q?B9DCTy+i/1z+GCaqCyez7h/lIpuvfnrKXt8j/EelEzOrqa4A3nfzU8uSqgOn?=
 =?us-ascii?Q?yd92ffnIkgiyBOzCdMXh9eMkDLt41yMORz9kL/YMQO49v3FUHBaltSOkg3dM?=
 =?us-ascii?Q?+D1JbuuyD3r9k0uZF/jhlHSZGzWj6OEu366WjyUuV6bJtR3zp1oUjdoDgY7G?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a604d-34b7-468d-dda9-08dbe0d867ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 04:00:27.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE/2yJY1xVQ8ZBmr6JpPMG8JDiNOKrCPhrwS/liS17sYRvC/ePpubvnq2LAbMC6JEOcNYysovIwT93/0IOGAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

mptcp_lib_print_ok prints unexpected green color at the beginning of
the next line. If a system time like [14:38:45.388] is printed at the
beginning of the next line, then it, along with the following '#',
will be in green. Such as the outputs below, where the first column
is mostly green:

[14:38:30.356] + tee /tmp/cirrus-ci-build/selftest_mptcp_join.tap.tmp
[14:38:32.089] # 001 no JOIN
[14:38:45.388] #       syn                                 [ ok ]
[14:38:46.038] #       synack                              [ ok ]
[14:38:46.457] #       ack                                 [ ok ]
[14:38:46.465] # 002 single subflow, limited by client
[14:39:00.617] #       syn                                 [ ok ]
[14:39:01.250] #       synack                              [ ok ]
[14:39:01.685] #       ack                                 [ ok ]
[14:39:01.693] # 003 single subflow, limited by server

With this change, the first column will be printed without color
normally.

Please update the commit log:

'''
The helpers mptcp_lib_print_* print the text with a newline, but
sometimes this EOL dosen't needed. So this patch adds another set
of helpers mptcp_lib_echo_*, do not output the trailing newline.

Use 'echo -n' in mptcp_lib_print_color() to skip the newline, it's
invoked directly in mptcp_lib_echo_ok(), _warn(), _info() and _err()
with different colors to print colored text without newline.

The original helpers mptcp_lib_print_ok(), _warn(), _info() and _err()
invoke mptcp_lib_print_color() with different colors to print the text,
and after it print a '\n' with MPTCP_LIB_COLOR_RESET, that is a newline
without color.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7a68791c5773..69d7af1a9f03 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -33,43 +33,43 @@ else
 	readonly MPTCP_LIB_COLOR_RESET=
 fi
 
-# mptcp_lib_echo_*: do not output the trailing newline
 # $1: color, $2: text
-mptcp_lib_echo_color() {
+mptcp_lib_print_color() {
 	echo -n -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
 }
 
-mptcp_lib_echo_ok() {
-	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+# mptcp_lib_print_*: output with EOL
+mptcp_lib_print_ok() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}${MPTCP_LIB_COLOR_RESET}\n"
 }
 
-mptcp_lib_echo_warn() {
-	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+mptcp_lib_print_warn() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}${MPTCP_LIB_COLOR_RESET}\n"
 }
 
-mptcp_lib_echo_info() {
-	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+mptcp_lib_print_info() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}${MPTCP_LIB_COLOR_RESET}\n"
 }
 
-mptcp_lib_echo_err() {
-	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_RED}${*}"
+mptcp_lib_print_err() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}${MPTCP_LIB_COLOR_RESET}\n"
 }
 
-# mptcp_lib_print_*: output with EOL
-mptcp_lib_print_ok() {
-	mptcp_lib_echo_ok "${*}\n"
+# mptcp_lib_echo_*: do not output the trailing newline
+mptcp_lib_echo_ok() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
 }
 
-mptcp_lib_print_warn() {
-	mptcp_lib_echo_warn "${*}\n"
+mptcp_lib_echo_warn() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
 }
 
-mptcp_lib_print_info() {
-	mptcp_lib_echo_info "${*}\n"
+mptcp_lib_echo_info() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
 }
 
-mptcp_lib_print_err() {
-	mptcp_lib_echo_err "${*}\n"
+mptcp_lib_echo_err() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
 }
 
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
-- 
2.35.3

