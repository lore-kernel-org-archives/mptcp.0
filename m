Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC7196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jSKhQOqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvAERaCD0T8xswhml2YueLB7xlsM3ub9dzfW5wrxUVqwj5QDstrgrJ730gUa91BZTbmKFpN7XmxdC4/4YLYR4uRn9SIVEvo1rZslOsVF4gr5Oc70+v29CrkovQEUh4LaD5WXNGwgwUCvCvgvJsHSVuap2vBQxDMQjz5kg5wIZVPTGkaJdwIRMuGpjsVTn5dkz819fHetid5XclVOYfvpHu0VDpK+0FGu1uuAwZC7E1zFA1/thkw4wSObWNSI+4z6T1wGl6VGHlmXlsrcxB26Zf1+E2oPE9TpACwIYYb5WNafkzLDw7Cgm02MzWb24GHB29Tl5ZgcUjq9VHAJCqmsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZaQm2NohJlVpeSBHV9Yj8zp/QYbK9JoDo6m9oRamo4=;
 b=kZO+ul9q5AhRdWph0qBXg2UllDxwM16+MIGi6m94LkwtpTTuF1pZCxfNg6gZABzevt0hTNiO2s1IX3dhen8wPfQ3H0uDZcYkjE2VIV54Jq8CYCEnbyDS+tre129pijdwIZK6AYlNB7mwRUdfbIiIUKV04MP1KnpP9LKHE3NALLVoSiuF+W2aqkFrYsE8+NKTrxG6VEBS7q6HNjO2LjgEmx9ILmQbXwO2FBV+FMWn4UpsemgJvDYG0nN5edTNAA9Nn7W1Z616grYKrYPgVj1V191IgKOHqe+bzJDLqDLaet3lpmLaAq5D+goiykqZ6smjTHgyxpBFwOQ/5O2E2Jwvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZaQm2NohJlVpeSBHV9Yj8zp/QYbK9JoDo6m9oRamo4=;
 b=jSKhQOqj6U3/TPYVvlaNMuX5Qmcz9FnuTANVunMAh1fZEJzUZxd+anJ10k9pL1/X3vdnSAReXmLa2p/Cn0HQxNHAzzGAJV2XD8IyCHw7fO4TeKAE/DsdditejCxL5mTxySwdG0szyYDWmp/A5EZhjXP2u6zjQsGSQbXNL9CpbidC+XQtvCJtZGONkrK7lMKd78P6n8bkwoxwD/QVodPdLIIOIbmiUJIIF3LBo6IwWOoSg2yApASQLFnrn8mTauAH0c4U0RJNo69XHdeQXdhqZHhQ6fZMGKIKbO3eYouKt9rzX4x8cTZGbnxdbiMZTgOYZd4F02PDoBs7s+mJPlivJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/10] selftests: mptcp: extract mptcp_lib_check_expected
Date: Sat,  4 Nov 2023 08:26:28 +0800
Message-Id: <66f80e081119f2ad102c0d34c97976c52a1adeec.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: af8bef87-a77b-4243-f036-08dbdcccf792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dCguSrHgzvSmNA7lvd2YsbR4heG3DnTRO92bgd5BPRL3kHEjtkkL5pr4J0wBMlxcgbXNccEhddEq90hXkmUKzmlK5q4KvCHO8epYL/0kiTAs4vfiWtJI7T0IBtOXW9pcTsKq0t/zyAyVIqfk6Eg766y9eCOqLcW88Z88kYG8PMB2R6dNh9CdcMeI5nA6RLsYmUQ/R0cUHyjHwwkGE5Q4d4axyIyrfSMdx1fck5K1b5+DF13Zw0qYMRrjCv5PLhM+Dscd9S6vnC8CdBKvHZ29XUyHnBHskHepGpCV2Bl4xvoVE8xf4Bef8Fr0v8yFVKvKHBw1hPqcNy2udLPFIRlGvdQzgeG2gl5gzhuliR2/VP4HiT+tMLVM+8OfqzWPS02fmGh9E6WIGTtuuJD6t5LDlHF/Z5kDnaEckCJ1/ZrVUzFrceCi7BXx5wpaI/T7qcnQCQdP8kl00yYPUjOJKL/reVUyrZjUCXCsslmD0+G/OJrIGCPDkTUKI/ezYQ0yboL+w8P/ziv6IfbeHSV/N3Vvq2nOHKosKSNtbqw+UgOA0keYNXPj/G1Qmp6MgmZKdb9nr42tZzORkiGNou/NAFRMkSOIqpn/f+Io8dm1bighgoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWJKTMa+SZ24Dy/6e/2cmvZ6SAsQVqr+FggmSfc+EsnwrXw5boEFi3YKNaYO?=
 =?us-ascii?Q?kc10l1ZYCqhE2FEQsIHDKUG22KUKSnjLTNMROzEjL95zGyVHV+pl2CbD/QGj?=
 =?us-ascii?Q?EAwB4tq7+ccHs5DVuMK+7asRRj+5Ev9uvKSCleh3dCgHvoUA07egBaIp/NPO?=
 =?us-ascii?Q?zlBQSzqNwcl4oXyKgq7KlpzbKHyRguf1D0O0mF8+3f6x1fHXbaGHzWaFgr3Q?=
 =?us-ascii?Q?7YCFpDPaJtJpN+0XtTvN6D6wQ/ENG1CX4JjGNYMGyz35MhNm53Kjh1/4bxYA?=
 =?us-ascii?Q?EzkzDzmLHKn/nU1VOSA3QlpcYhlCVsRG5p0iv2ktujdBPVYunexHPuhTkpSG?=
 =?us-ascii?Q?xR4+tuaffBbYfz/Hnq6E9psH2+gj6xzGdN7HbNdm+ClKgDf5tVHjBzguz/ab?=
 =?us-ascii?Q?rZouC7q+D/eJ+euH7e4ugWb/AygBNN1eTfNDsDlBKbbkAU5G2Ral1ukq1MYu?=
 =?us-ascii?Q?8zHz7bSqciQ1AA+V0v2tPY4djSWcrr0/OXIPLFnVrEUuwFtqLmT3Z5yh2pFi?=
 =?us-ascii?Q?KOVEpuqbamYX50IMjUf6geUtSHrurlfOEyRgQj+7TWzK9VRCFIjlfFYh3Re6?=
 =?us-ascii?Q?j88oMLLpSu9wU74kDF6NKGW1GyAzyVKfnQKwvO9RzchKJD5NrukSyiPoDBqi?=
 =?us-ascii?Q?41TqkLtuOyLZTp2DPGbGDR7SvhtFK6mpVTnTDur1njyOqwIYxGd7Pdc7fgP5?=
 =?us-ascii?Q?tgy+JQKieE98KZqJS+qcQSvqW4sxkBiiZgKAFeB1Gl7oGUEVmgFLDqU5vKzw?=
 =?us-ascii?Q?QCsLu0qYXwBo+OCCnWjeJqggW4OrbkH7oguFKoDAAMCU3pie57yL/AGGA+RK?=
 =?us-ascii?Q?+dezd/1sl97jl6xk9Sk7CfY72xsWEnwRy/lWG83m5WalYpcoTC6+Lhg4QuMi?=
 =?us-ascii?Q?WozvyLV2TQAMfZsQAmx8M4Zk6f5zo6Px9qKbaZzJBQATVZX6LvVpXoBF9ek8?=
 =?us-ascii?Q?P+gEipydMGlT6vMAMzZInJn7mvyXOgL/oayKvp9erru7EUEArhRv8x1KM0bN?=
 =?us-ascii?Q?dECC4td7brij2oWmHRR8ZlkteJwSjNvhZmgRocnrGrkFETYeG1CWsRsoAvIQ?=
 =?us-ascii?Q?6+58X8zIKbUT1yGxd2EeywrmvDnJhHHlntmn5u4b5G6mbo7KK4GlHDNCtsPE?=
 =?us-ascii?Q?8KwXrQ0yVAzXMeBEHDQ9C790U8OWi0sxvV3GlmBUS9/CGd+ommlNs5YjyAuI?=
 =?us-ascii?Q?BcINOwdZ5dkBjQO+GgDz+eA8HfJUKxaYP1pwj+XvyB6JoojXL4Atv9Xj9yps?=
 =?us-ascii?Q?W2nJw8E54vK+JceRL22mvY7gxd1Px2ZPsxDCjUcck7iVTee77iugBmICiy24?=
 =?us-ascii?Q?KzaxsvNQHjACjg24oGHcyUBifgqSqJykJqdNq1RC4F7GrRWJHLn0E/JBTOr1?=
 =?us-ascii?Q?CRQGrQ57LAHj+o4gYHklsXZdqOeEDS18ELfH7RYLaNOeoZefgUEv5QE8w8Iz?=
 =?us-ascii?Q?x7VpPKScJ785PIKI7Rzi6A/uZimPKi0YLki0Y0RIojW17QE2NmWqznys+qe2?=
 =?us-ascii?Q?rfCOTVCsv5Zjk52LZP+76yH0FH96mMDqOXRfD+bci0X6EgFN3Hc7+9ewS/Dv?=
 =?us-ascii?Q?G0D/eBkG4J01A3O5TiKTZIl56l1yPFj/SyAD9E/B69owjMGqjVSjFzAd5MAx?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8bef87-a77b-4243-f036-08dbdcccf792
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:29.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CokliO+irX+jQmkhm//3Auj4mAvVySjmCnTclT48G/3K4og0W5I3o3KCGwX0jbVLPXEUQe1kcp93L72pPtvNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 39 +----------------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ffd78187237b..68b07216e47a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -369,3 +369,45 @@ mptcp_lib_evts_remove() {
 
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
+		mptcp_lib_result_fail
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
index fb05d207fa44..6a84e563b2ca 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -231,46 +231,11 @@ make_connection()
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
-	fi
-
-	return 1
+	mptcp_lib_check_expected ${*}
+	[ $? -eq 0 ] && mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 verify_announce_event()
-- 
2.35.3

