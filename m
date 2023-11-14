Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41518C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vriV4eoP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BykNOvv1v4AxHo+XNdJg8hxU688cSuImMMHAd/mY1txHtrFezZ2ufelw18Q7230UruaEHNmwAwr/FHQybmgxicBL1iCjD/gISsaeX3z9CZ5BLY0/kRbj6rnxzYd76mrDNaBZ6TceJrFMZhet3lV3Gu+X3rgU+rNh/yFvBodd+HdYmkRoljo7kdKqhRmp0XnrVSNLFt72Zp5OC5S9Qe3m+Q5HJ8htVPZtD9FH4Mj6Hi4aMDPUk5AE0TjT6E+nQptJ4tUfXQ9iJgceQzw2wupKO4eFZT5FCHPdTPsAn/M36KyZjsBge/Q+fyVnW7o6HH1HyQwPkvpaIMENFeXVTmOHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R07kNJawyzlHpf3LIoGYdhQd0fUV9zMxON6SSgrlLk=;
 b=Dvg0e/vMJSUw8KIjANRk4qpph3yw6QQnaPJtnzU1KZVDWNmwIPRkGWESRATB9J66tEs6Oy66/Nsu+EGHmJ+79tumB3RUiOHuSRBJZg+FHMrA44i9Y1vv31/Dvwr4EdDjkcKzquyR+AaEI5XfdLprNvGLpcl1Wf5jCdsgl/zag8Cz79/Rf/iDA09p/zSBy9MYeL4Qr6bWa7nIvdax6QvsBkjdFef6n9RvKtvKE5lcvgnVi9Ja8XlgGlwoUf5bJg2DlGfMVJK/TG5Uk0E0Nrgq5lO+I9L4DMV6spGET46DqJSexyW1Syd8ps43JUoITLI0+LiB+yAMtPxpIZOiGI2PSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R07kNJawyzlHpf3LIoGYdhQd0fUV9zMxON6SSgrlLk=;
 b=vriV4eoPgnDsXgfinnL/P+OBABZt4EeB4ElsPbmHhcSR0PcdHIgm9et2KkwNRPm0C9YRUlKXDKLO5Ho7OZlDroR9PSKdK2gety46LWSa3LRjlJMZmZKpMBvX3MLhuBuCMNToNj1iUNDdWZnTFpZM1js7MixGZpTWuyKLsiWjHUduM49/28iw6x0np7BeMSLpfT6A8cpSy+AgSM5pHwjwWHGT1l0LsbL6gWglUt0lrgNoU5eNP27fmduw9hT60Z090PXdwswBb7X/hLUd+BdoycmRKiiiWK2ZHWuF8JXEtq//JDTXF8dZPBAsddlZbxyA/RVaPyTD/yuwB7uqbk1x9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 03/33] selftests: mptcp: userspace: print colored output
Date: Tue, 14 Nov 2023 18:21:33 +0800
Message-Id: <557d147ff232371a76538789eaa90525b187a26c.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a5bcda-a2be-4d32-f9b8-08dbe4fb90de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K6b/4T/3e/yB3xXqKFKoBofGTuDPENTy00fSM30YAFBKFGkMgHLvMk2AYpe5xCDKAUZ3qL1pka+kble6FXzhAx1geczYzRKsSFE9ok8mMNuSq4Au9CvDLKIT24Fe3IhYaPCdQbO7fDyiRudeyzXnZHIRlnBb+I59sY8Bdga1/7z9GAUGo4N4/vYXvfLbVfp940mlrii8xb4Uo6XVNAV1LT/kAUz8PFe7VdMvkQwHQuU0fkqpPsuh2TuAyMMyViMND8BF3FS40Ov9tenM2BbP3ZBEGJmwGySSEwtoDbB3DctteqjqnYE5B9sgLFCPQ3rFKotq8Bywxw51ylTx4MIwzS2e5+ixMsNBSg9xtA2zu0jWwOTPdCU244IrV5WE5wX5RTqkLciI7AkjR5zQ/KDxbiQrr1v4MB8AYToe2OuwXH+RxIPeAlCF/oMGsVkvU+BjEiipb5eX0qBuTqY4PLvDE6nTj/uanIxG+5S4XoFHVJOJX3t4872Fc/NP3Vr/oYZl63RYf8iKK8eN4PRBfy+oH8/nPMi8BmavBCu1aJvVGLROy4K/JGqooqxjMCQEOsol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(54906003)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SyJt2Tg6ndxxHhxxSKFUQECdwQz3U8r7WZOJUucwEZlBXdsv76MtZl3tf+8O?=
 =?us-ascii?Q?Ce2uQt5znTcgy98T92G8HvOwd58+0nBXZlCqOV+Ap5OlI0iBy+FGwtjbQXid?=
 =?us-ascii?Q?LrDCNPd3JX2EBgxvcevCEHM7SyXXDKU5byIm/7OMluxKNoAI7erh8+ZIOaSF?=
 =?us-ascii?Q?rfznqZBjO7Rm988syAbtCJ8jF6+NB6bVMU+ufEJlWzvHJerium6qnNJu+ECs?=
 =?us-ascii?Q?TC8HPjGjv+81p/6qv5QmDhYUkzxLJ9jjTLBPJI5z7yOSHv1815EDNxbK9MNU?=
 =?us-ascii?Q?yHT4ngBSVp0YIGlJXcnuHtbUrMe35EtJJSzQziBqMXw5V5GfIACCJZ8A9rAm?=
 =?us-ascii?Q?FkugE27xe2xxWiSGr5djO5Cw8hxwKOyqx4IMpCWL4cvObhFlNnQnX3zw6l8Z?=
 =?us-ascii?Q?cxvb1jHi4r5NS/7TwvYaGl7Q6X0Ao1FVD4GHyhwFtsiq24PtHxMOSvP6SPPu?=
 =?us-ascii?Q?+cFgX8zn+dLwsDXf/wlC6BB05HcZVpIxLQltIWn2v0vJiYeSZFWuxQZaBIb6?=
 =?us-ascii?Q?8vMHhOwEQStyED23CnFLcqESeMJg6bsDCGe4o3VSj3cYQ8PPt8xk/WiWKEuL?=
 =?us-ascii?Q?XTVaq7jJL42HjEddweq/pU6zgARyZX9ZOOYBe+RlpdNnkUxP5bX5RukoPuDG?=
 =?us-ascii?Q?kHAtlR5YkJuCot+zX2r/MldCWX2FkFTcPNYPm3k7/B7nPcyNr5rMkbBkCNlk?=
 =?us-ascii?Q?dYdcwpZ+QMKdJEg5nTi/Yq8PVavw8x1H0aJUfLgbVjD2tfvURgQ5SUW7gPkh?=
 =?us-ascii?Q?8GJ3wABphrp5ypi0aOtoiMC5da0VJXnuqp1Nc3L68IUNcvOIcG5E+xtign10?=
 =?us-ascii?Q?W8dgxb3lNUmw9uMRyCG4xcXVkyATGydAebvXI9zHZQ99e1GFHgc06EFUP0Dq?=
 =?us-ascii?Q?F6srVHaASC04gyJDzgtsmp5e+LjTtwSg99RewRLbRj1OOs82RMXze0mS9K4Y?=
 =?us-ascii?Q?Ew+IAq8uKjskHAZB8yGYwbw1g8iA/uwoDK+NfYq9nr2c6XjwqEBi60p7Sxwa?=
 =?us-ascii?Q?x0NnF30bF714TIbgn395X2BMvVnTCFMzsSyzpo1gvQ51bQ5mN091pAKUjhN3?=
 =?us-ascii?Q?V1GIUS8M3Xs8z0mj4Ik39JKMVvtr48AGCj7C8I5I3qVrqZMWE4e9l7anhwGR?=
 =?us-ascii?Q?Hvbi408hQRqySzjr0RqA9X/p6sS8UWPDI3hYCU3ijo7d7zIcQuTwJC594kxJ?=
 =?us-ascii?Q?1Rfrl5sSBuZnq7s/DEngluhYBikCg+8+X5hEluBJKCfmtJIkEtw8t4r2LXPI?=
 =?us-ascii?Q?HGsyL8zQEu9jiQQRJjPcC7WO2Dse3BZ0lPEA9inLNcJkexkGIkyQRCx0XF1S?=
 =?us-ascii?Q?CA/QBNZSEkCKKF0sqMW3T7iXtX+0n8yX5VMlDn3jbE89HmrjM1bJ7xnTF+cB?=
 =?us-ascii?Q?2YCah4TPHUhBoP0/Ol8LIlQ30YDpBpE6CfmbQXXHPzWA1KOef/A5b3+Jb04x?=
 =?us-ascii?Q?G54eiN5ALfzf0py4073gEkYygubi25MqhYCq7Mavg6XxHKrLqBOrSdF+EJQC?=
 =?us-ascii?Q?n5+PaBQVzMEkCdZq7pQTWGjH/iZy9VYwQlJ3dqz4+m4F8bD2QZRhak7gjYvd?=
 =?us-ascii?Q?Atz2lgLoOz3tQz8MrvSJ2Q3P8xLsK7GFTzfUKszK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a5bcda-a2be-4d32-f9b8-08dbe4fb90de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:12.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mE6FlHPPDY1jNPBY3w78CtYMDw/CasYWW6mH60moEB/H0kyMpA028LDP3aObDYLCoCNeb6vppA3GPzzJVa/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

The helper mptcp_lib_verify_listener_events() will be added latter in
mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
former prints colored output while the latter is not. It makes sense
to unify them.

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail(), and use mptcp_lib_print_info() to
instead _printf() in print_title() to print test results with colors
in userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f1d5cd4ab95a..0614611b7821 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -63,7 +63,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

