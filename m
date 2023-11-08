Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA6199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CpKw+POO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1NXuP9mWE1azu34hYzbskE0i08aU1dHKD3ZDHx4/Js7t+jWeXGrAQOUa/34+6AALxmaC0x0cx3irQniMOh3W8p7iGEdVOJOZs3T9E6eDEHFweFXWWZhwjUksxroK90MN8cbMfFXvIoNDyeGGP+7zlyhHF9xW2cbJvQm4bmZgALArxvcSQ5MAKXwIKAm4oqZqF3Lf5SnqgITMJrP+7NFgWv2PF3cOff+t7CUILdl/XcR1fjAle43qvmCVgtVjZs3N8ZflUhgveRfN/Q6ctPhDvU+RPU7Slwp4qf37UuUjw1L9/sfnyzFaj6yeDJTDYz8R0+Z3OmcIMM5q1GGvmyapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fru6z/gNg1/kkNh+Kf1tK3N7k4nyYd9QusDMiFdlX4=;
 b=hoUDrY98ajolDszf2IIPtZzPY6T5ZWikGc6bTgp3ZNlSeGG/YCiSYNTQQNwBz2ByaH40iCZxQwf1cJNoEdwg6YaO6u+JcsIHIK3RLh/yuK/3xY91J/QcOHRtJ8PSsDIRc5Ciw2iP/2eJKVwi2dd+uPCipQ91UmCMfmvcOtfrMpg74htnvo/TmXTfL/8E7Lg54FzgTpB2BQtbvfr9DuTwdJLAJgYvb9AkyFhOmR/2eztFRwwsrMRaDebHawE3u7vmjFN+wEhf6A8CKHXHxbqFkEy5tvGMXURFID9leVwRhve3zy4IRdoAEccOHb5WD3Wr2lEUlsde9tqwMj+uUnGe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fru6z/gNg1/kkNh+Kf1tK3N7k4nyYd9QusDMiFdlX4=;
 b=CpKw+POOI+KM0fUuhlhhcDJyIgSrOwqPlSjvscjPaDGMIusUC4llsaXZUVO9/rO2Gewo2MUVm23NDrzmEhkUonm7TkqoSC+MtT6+ds9zj/74ZMLZmutXfXKlpf/IQr0GfBjrRThK0FXMR7SCN5lwfBeiittmS2u0t8N2N/G0rRIxGykc+UyGFaH2i9is5QALalAXOHTBh9Ru+33aOcB9zHX0Q5YiBeb+Ra11nWWMq5Vcc+pfK/qMZ+zTdmAr2n+WMi+5dD6cCKEW0/VUzOWmLOGBbYJgF0hzZeqCtuUwHdS/miCTGNQTmiZ3nmz7RZq4vrJIj3RMTZeu7mgfKn2Hqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/13] selftests: mptcp: extract mptcp_lib_check_expected
Date: Wed,  8 Nov 2023 22:11:49 +0800
Message-Id: <37c9bf15948724cda68fb31899bfe0f3c6cd6508.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efa4516-56d1-4a26-90f2-08dbe064ca63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z9hoZRp7yUqwjuupYsFrfX/CndQzmt7zNIvb0lQUyTDLVhLl9x3RnL0ZgPmiKnx6+cRV+GWgWdCx5/wkbAYatjimZs/fKD4ZwMInANJ9KVl6j1SkH1Jtd7e/YBQl/A/8qhN4Jz0QtU4YDlCRNtPtHYiU8m2bzFcbQv4ZEDeR4nXSB4Uf0TwbYZDxrNDnQdCH9Dj9hBPQIkpIf0ffk/aaCgh4KA4a5JRKNL8O8mGc3DUEe5KjVxm0U8ni7G7qBA/YKkRpK0RxNklM/E3mMJbMjmzvify5xZR+Q1M82y14yNrnv00W4Jm8pSeqtJ788LCX10ZvFOm8aTnwKbQs/5Cs9CIxTjKD/iF6gdd8HvUFet3K6kQk15BJo73Pc5YX1eOqY6Bp5lKJ5dR3kKrhDGZdO0iFLJaba953+ti4joHOHavPnQZPNv6uxBMpTao8jZsnhi2bzRxg6KVncyaK1P51LyNkfuC8FI+GLtl55dSNixlOZR9TZIohm2mCGFx+YepYWidtcuEQAKtcGvazcGk/2J11IMZo4XNzImMTfZM7KqlnDwGIqR9rdRm4mxU3HmA9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BC/t1RKzycUiHFYn1L+L2gcohlfwMjHoXbrL3r4V+DJmofUYBG8zic/rkH3F?=
 =?us-ascii?Q?O7CpMZU/6HMRsJlZl9zuxqLb/1NjmdBYW9sz/i04uYhUGLJk1j1USlsJ8O85?=
 =?us-ascii?Q?hXNPnm1p8Oo5uVKHrSpry1qp0N2C/X29wPuVcAez6hFDKQ1cDhL4Lc7ZANUG?=
 =?us-ascii?Q?JfUCmXRhuUiGZXcBTxF1l1v2+0pceLgRn+W57yMQL8qyagDTbYn5JWKmdPuG?=
 =?us-ascii?Q?4LuIgTg4IZVaYjKRFA/SFu3R90NLsfkyiLlXqr1+Iv/fGRQJBIqim+EcGkSQ?=
 =?us-ascii?Q?5yRbuQaIZ/4gqi5Mvnt57EtEP3qBAicxFGbZbncq4jqS4XYyPfCLoxXV4BoT?=
 =?us-ascii?Q?s1VaVMnvg/lRM+DLgnmZuPMUFwqFOU++M0ITC+HtmRo2ntkmJSik7k2Zrnzv?=
 =?us-ascii?Q?E/VgbDjbejiNo4XDlsyqMnQzEsyW+4hYSTgOsLzJ+o3fIpP+tovmpVj0UlwF?=
 =?us-ascii?Q?G/cBjlf3YlNwdwYOzRi9cF0fQjtKLwIUCT+juNtpVoacNo4IIJGZpo+Gwwn0?=
 =?us-ascii?Q?3+IV+i+DSGcwC2aKNyWglQPlAd52aLewtH4yRwtHtSQd56oh6/OtPqsygHae?=
 =?us-ascii?Q?j7v9eCY655bBxebNVkEdm6HUYi1oggGAkK84kqbHy7op7QBnfvuGh8OPrr52?=
 =?us-ascii?Q?djj5vtzjWUQtHfg3Nww0trhvTEifZoBSEekH8nNRE9y0LnQhCVfS/iB2YfC+?=
 =?us-ascii?Q?zab0hU8XdzhMbLG5upMcjZ6YZvBCMU27otPylWWdbC+6ZevZtH9erQRSHhE8?=
 =?us-ascii?Q?gRZlA8wn4VIPpY8muM9sdsWeCis8pdXOdGA3QyI4ZNFTnTAbKY8BzdKPJGxF?=
 =?us-ascii?Q?RKOx8UP0fX9sslcZOSaOPBpVSlrn61u92tN3klhwmcumovoBBOH3jLW1UJYC?=
 =?us-ascii?Q?+O8BVcghvtq8BLyqhORGk15g0UAuXMN7ii1Hl4UqICSnPhAid/tTEXkXu9FA?=
 =?us-ascii?Q?l17MefAcpOeHroGc6+QK7JUFwiWzW6SYjn7muuOqNfIYWUngw8cfiVucTuzB?=
 =?us-ascii?Q?WeCJg7jHmQ1iXfxRX8qisd3VBI5mR/dynFDJXmCF6lt4JRL29SV2V8Rbizit?=
 =?us-ascii?Q?9ONfPegPghkhttCxUyLle0dCjJXgzA/wBNB6ty2MGiw64XoTrawgpVFpFlPT?=
 =?us-ascii?Q?0x/0IGj75uvot0ExLChxh6eaQ+QP7h5lH90vEDdV00GJL3Fd0359knPZvgr8?=
 =?us-ascii?Q?5lHt3NOkr+MOQJoEbFs2MT976Uh12/mrKqG9PzkedGflBVQE/L6SWJIUs8RU?=
 =?us-ascii?Q?vgKDaoI306hUHCKLrF5kMoFKOYkWDY3er4F3Fr2hJmSMbrsDUsYIHwWkequq?=
 =?us-ascii?Q?l9nmhq3ues4Fb0UCc4QBB3kCTH1gfB0Xzx+FOYHA23iPCMG/PhK2WDDtuKJ2?=
 =?us-ascii?Q?5HRfK51q98PQU+3X8j/5C/fKEU6EezDP7b2r7JWbgsIhlyQmJ7tMp26XOzzc?=
 =?us-ascii?Q?gJS7XIlTxKB86git9QggD/sgEHp3I4ezXMx4eTRSyWSJiubpqH2LRU+MEtlx?=
 =?us-ascii?Q?Fw1wT/cQeIS41CWdGwcyNOsVhDDXEoLoJSzKc/1yIW0OGhgot70xKr1g5EVl?=
 =?us-ascii?Q?Q+yYuq7cqREVOMGm9hf5yE9lkpu72LfKxg4RkdU4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efa4516-56d1-4a26-90f2-08dbe064ca63
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:50.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qppw0Tt99c0Viwj3j16D5DB+odHVW1caQH6m8YTFO0n2uO3jCW3JYT1SlKjQQg4oFVD3Y2oSu/0z1eaUpV4aRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 +++---------------
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7a68791c5773..19e6ceb2b4b0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -387,3 +387,45 @@ mptcp_lib_evts_remove() {
 
 	rm -rf "${server_evts}" "${client_evts}"
 }
+
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one()
+{
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		ret=1
+	fi
+
+	printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!exp}" "${!var}"
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected()
+{
+	local rc=0
+	local var
+
+	for var in "${@}"
+	do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ ok ]"
+		return 0
+	fi
+
+	return 1
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 7f4aaca032dd..cc6e8120ed10 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -233,46 +233,15 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		test_fail
-	fi
-
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
-	then
-		test_pass
-		return 0
+	mptcp_lib_check_expected ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	else
+		test_fail
 	fi
-
-	return 1
 }
 
 verify_announce_event()
-- 
2.35.3

