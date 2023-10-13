Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F215692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tDtTJgGG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2m1TgJAa0/yS85ou0ptcVkku+DrJVvTbDSDmDB89V6qh3WpcPvIOeKabcbMbGpYtUVEKZ5dYoStKzTPklP34DyFR6sUGI9LlvrEPck3eWsJZ3i+LMsPUHRw8BfZrBEub9FXTc5P2XKi1igC7HMrGjCTUNz61YwQD1myIjzfXY/TO611BonL6ygeK5f4HKkeumgUlJZWb64r2pkrJ0127tjQAipY5uT+vw8S++18fGUhzB7yKSYx7oIm9hdceLXdKCWIlhhPv7X4brmExlxyBl4dcGOIg/uFfog316cvLCsuJJyv9nIKxQuLhfALWQM38IMLD27zkUU53nbxmEeScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuC4+7HL+QqC7IG6nolWtOtnRoo+3h/2ZDu35FqM9Us=;
 b=Ffqc5neDIlD66jYMjlXbUivWklS9adDDiVAnzrBrqpV7vFDhXguYtUw4aS4e7y0FeWyi8Nr53b3drXLe2krxf8ZzD6NPm8uU0uZcxDD/Mgf5HIlQNkTBT0EJgsk3CxtygBy7HDRCtR4Vlsm/CujmDBD2ucgI90mEpMULofwyvWZjRJgwXVXridZTocCmBsoy6Bli5IvHQzQHgo7jOuemPe1h63x56tGoU21OYjl2DkJT/4uXzSa7m5cp1yr2AYw+iDRaH7Zb5gJNjiLj5YMNbe+i1CRIbvluIY8LWlXGbsE1zrJgeNqKaAe0CwtWYQeYLIVz9lF634AsL895ppv6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuC4+7HL+QqC7IG6nolWtOtnRoo+3h/2ZDu35FqM9Us=;
 b=tDtTJgGGHsU5JwK45DFvGUqtwUYBSyn83zn1l2C9Y7gfOuJYsEyz9nutVpIVjsOK9vuJiKGY68NKLJwrfzB5rynyiV+e9n5ljodVi4Glr5b3Ejl6kT/355pXWOeHsd7ufmirMo70V1SzqlTnUaFWWoAeK1CfAqyeUgwovTSJIpi6NTwpsnVUwJPf9quWnTPXruFMjKfnmK/8QjMrFAQNkZtRlB56PZtPtutAmqSKWxku7VbqbYWuO0xD7jbIhaEWtahu3hdimd64KGw56fRFaB1XzwPIFfoBkd84X1ykKS1oUkVNCHmji+xgTyaGsnxU+WspUIHSA4rbo5CrNq8zRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 2/7] selftests: mptcp: add mptcp_lib_is_v6
Date: Fri, 13 Oct 2023 15:44:32 +0800
Message-Id: <cf2e03ec8ad31358954be8ec7b23838f7ef5be1c.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: ea40be36-86b6-4a19-b646-08dbcbc019c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YtalnvYcwvCsKasBMNrDN290t5Dqd5JOTGji2RhFQqj1cFPpcspurJmvbwFHLqLOvvZkg7vPTLf3Cd8J5M+HWwz4qmtIT67ImS0VO91kmZUpA40NhDoNj4JB4DWc39J5xesAMidl1H4Tre4BXnc8SmeuGpk7IIb0DxlOYks2j/s+u3TlWLjC7ondZpeqouw/SCoSATmAkpU5yKRG+Ve6NkVp8Hb68z0PtiTo0PYqahFPOFJIu89FilUmvHRq+5sCgp3O2pMQzBkeDe7xFfR9ECY3/nw0sAubStf6rwpgump2Kcxr0YlMuChdOjoXaOkgUzDpUufDYsLau/g3BxTMJFqFTCbpBAt4NO/zKECkCpw1Q5V/3GqqLXxl0g7JeqeErKMO52eYHk4Oc0vfIXwQ9WZZRngEpV5OEB+fx0utflQSjFs8LHGs1eckRxm/6W5SNA+AbgtabWyKtD3BK50mFm2KNz7Gg/M8vh4ETozirIkcUv2eAKvCRihKxpJY7+u5OxOj+ZpnQVbLHzfFNH2DR8VnT5jPUOoLDni7hoI7BwiPxc3RQWSAJjTjSelIbronZ+k3iM9JjZrrhDhqc/dkDT6CTVHDROefDtqXJrikpf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(38100700002)(316002)(66946007)(6916009)(41300700001)(2616005)(66476007)(54906003)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYEpqDRkPmYAKCEB/TncgOb2a0qswVVkkgYK6UcoBQsHEHA2MsP4KlLRschh?=
 =?us-ascii?Q?dkBJON1f9k7WJJU/QCWnkcSZFV2M7inRhZwEPbAg2hvHJSiKrO/kGHGAC+7+?=
 =?us-ascii?Q?0ATyZWBdREC5baWwFIgG/VQ6o8bPotAUTPo+ZrsAv285WZYf1oHpbefitzdk?=
 =?us-ascii?Q?RMfanXLPVH5/VeVad1U9C1+afVtYnEtAuRyvXXNCY64PnuVgnW841cuZhyfM?=
 =?us-ascii?Q?g3MWyq7vAGcthnW9IBU38IkP2IjTjZJ4pkhEVo4iLDS8da+GUrIavWRdaj4k?=
 =?us-ascii?Q?83S3lEUaMAa65e/iiWxz5qduqEVBVBjmaht0FQgeoP9nr5UqmIOsr4MOJD8K?=
 =?us-ascii?Q?ewXdlmd3ICCKpmAT3N/JcUiq8esfGYH/GVlfRwL86B0/beC0r2uZx3BuEIO4?=
 =?us-ascii?Q?qqVcnCRpdkhmTeieqB41fhGlgBM2igrWA0IE9Tg1/ipS3WNSw9k2hnZolRMd?=
 =?us-ascii?Q?mEgKN2SANhIiwQbfXPQe94h7b2EYbT0OJk+izUWpzq2GIJpnG3B5MYOBQ5vS?=
 =?us-ascii?Q?QFaXDW6XEvEae37rW90ho1kqXGOjVCRrO4Y8dXU9C6fq3KRD9E7Uv7bU19tP?=
 =?us-ascii?Q?6P2CqhLUtLcJSToqI7OReDyfZJtgeQM1+Iet3J4Z2seS8TtBeZ2qPwHL7aMi?=
 =?us-ascii?Q?d0dKwHhZq0EC0fLgrtLJ/mIlEWOZ7LooVr++S+bKXHe/f4rI8Azc3UjJjfFY?=
 =?us-ascii?Q?tKm4Jf30ELMwTUwoOg1meWwYwFB+9HH3q11pCKgnPFkOMGcm8xQ0i4sePPZT?=
 =?us-ascii?Q?siAZptUiu9b0i8mlkXmaDMQ1C+fciSxXb1jxbz/gx1oGzZDwHqEgoQ7eXYw2?=
 =?us-ascii?Q?dx0iC0FG8H5vs/bgN39dCqTdny5N9gApyon3ssyQb+vsAMidfNFd75WxUcc0?=
 =?us-ascii?Q?/KQgHtn99oU/9St+JOyoIGwXqkVU8MVK9BYJ+wNpVqnAAnp6v9ZcdL3HZSu5?=
 =?us-ascii?Q?0SFoRCtNxu60ovT3S4FE+ClLcl0c7LrOm/ae+NjH5i801dlYzpVw2vIBis6o?=
 =?us-ascii?Q?bDgLN98PZEmlvE3OhsCCoLaHWJWHMd5Ia60WJBsJr6VjkU5zH1kj02G22NA2?=
 =?us-ascii?Q?oHhSCoR/2TfUAjmTi51GNgMfXFHPZ5OQb86evZL3+5BmaeHFo925KzSrtrfp?=
 =?us-ascii?Q?L9vUJUTukM8lFtd2WIrKqZta/i68uYZSjigorXhrdBi9rsADKE3lHSxnFHtp?=
 =?us-ascii?Q?7uPyxqBMooxqd0dm0RV3+rR4NpjJFpXeH346Yq9sc+9+RqgOgQ4G03xmusIb?=
 =?us-ascii?Q?eYt5JG7m/mGqi4W+ZxGbmXkmoibV0spXRsWirlxenzHVmbd2NjFPIAwMDfao?=
 =?us-ascii?Q?VOmdrGLM1Hyp5+ebLDmjN6Xk8fdqe0UQ8b0JOqU5qUEXcZGopdhM45ykLhbq?=
 =?us-ascii?Q?lMZu4uPFDyAAEs088Z3UIfjKlmGdG5NzPD9niE/4nAScJlZCCQkPSbFn1cpn?=
 =?us-ascii?Q?buYwZvAHYKf6yJBEUEUiGBdOOfrnQrgGk1opn9mc5AUSeIxqjmW8Oe1ZjxYJ?=
 =?us-ascii?Q?BHKq9974Vd8PbWUS54GxjEihowBo3R23erpZx6dO1VgwM39SgWfIqhaCHuFc?=
 =?us-ascii?Q?4lzX3M8eEWiMUHyEjN/wmYeL5rA98svOXZDCdhdD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea40be36-86b6-4a19-b646-08dbcbc019c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:33.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o6PCZ/2CDNnumB2tSsKVoeucr3p1GfHn21g+ePeB8V/Tl3oWoII7RCe3K6b341ELDtsDq6z1wNrRtYU0bkvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

is_v6() helper is defined in mptcp_connect.sh, mptcp_join.sh and
mptcp_sockopt.sh, so export it into mptcp_lib.sh and rename it as
mptcp_lib_is_v6(). Use this new helper in all scripts.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 +++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh  | 14 ++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh   |  5 +++++
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh |  8 +-------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 61a2a1988ce6..9ea4f0d6673a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -635,12 +629,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -708,7 +702,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -741,7 +735,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 46dd7b1b6872..bb2a56c2dc37 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -587,12 +587,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -895,7 +889,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -947,7 +941,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -989,7 +983,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -3351,7 +3345,7 @@ userspace_pm_rm_sf()
 	local tk da dp sp
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if is_v6 $2; then ip=6; fi
+	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 692a73252830..8d0480d2a8f9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -226,3 +226,8 @@ mptcp_lib_kill_wait() {
 	kill "${1}" > /dev/null 2>&1
 	wait "${1}" 2>/dev/null
 }
+
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a817af6616ec..bfa744e350ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.35.3

