Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F024AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U2B10acX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrqBo5E17Bz1qXlN9ccZsbcLqVFeq41OI0VEQwJ58NeGU+5sOOV8rZwE6leQZwDuzZL/mG/b4rxX7rnEiulNL8J18EeBDUpdZTZixSBT4xd61ZJsTrVSkLOSMAnSEWTa1+eKFg7gfoZUJC4wLrGHZpz8b26rziHgIcXjWE7tRQBaCxEw8f/wdm9f2jctvLO3jS634xvl8g/7AoSB6kJfDl3OUfeULHvd6nAdTM9u4hcoQPSB9J8nDYplRtDScf6VJvGKO9BfLt4ueTaWY4AWOLEPNskaQnyz57LsNWqlp7jpuPsBAj4ykc8PUcmHvcvqX5891pIsmLK1HSbeuDSvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLCdd11M8BI59cO3yVnyYd4rQvzPTPGjWD9+nkRw5i4=;
 b=JVb0lcdZm2NKETtKadkEwRgrrACSorVXIkmkIdrk/cT4ZG9Zh9775jGL1WXdtx+pwwRwb5qNltC1TArhaZyI+a5eZJzzhb/lZCLwYi3LHlk3K7X5QWfSOT9L+/sEpT1lvazpIDImZCpUejbpuVvu5UkD0ga3qObtOaDvxpH0+H9L7uVVDItoEK8fglaeorvZhFfgLxpGEEcVPn8fApCyVAMHkOGwasxbOKK1tAIddXMgbEwbdqhp4rpCgPvkUB90PygkiuW+4oDsS+dX/J/aT/QbRcW4ZT4n5uI6bNeWnn0fWU4aBtE568ekr4plxAwqgtBAs4RY2tpdqEtrqzNROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLCdd11M8BI59cO3yVnyYd4rQvzPTPGjWD9+nkRw5i4=;
 b=U2B10acXYUp/y2rAxdnfZbQHaaHE0wXQ7XdsUS9E3EOIBksd085uDbAEsD8V8kRDPtGam8QeNJ7ow2cLR+zDWoVvwreVJ8LWXvKEoWhW87kPVp5vmSkliHN+qd7Rldxnoyb4y0Y9faiEce3vMQX/huMUgMqIjr25BEV81u7lYrjFw9qUTdOme+EB+dZ5Rp5+2dvnsl/EU0GsCNBqnqJ/jILhUaqcmhqbCOguAIAWzSFEcpl0mGmohhx49bFBFp1bGeesFalLzigLpKgzQYmn06k/krN4//Ho4B7kLpvWUmzoUy5ch28USIjUx6HRPbidwicR4C+WsheAk5KLhX3Z+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/33] selftests: mptcp: extract mptcp_lib_check_expected
Date: Wed, 22 Nov 2023 19:30:55 +0800
Message-Id: <98c7c40ab8d8f0217c56c2503a7add701d0b8c65.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:405::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b3d5d5-2dd9-406b-341a-08dbeb4ea376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cT992DDfZc8Y3FDHS0lbj7mIAnIlKTNDt1o+pa5kYNyEaDI4YeTRmmKzWvLhry3amvdtJb/nsRCqHE+DJkyDs2DAdbKRbt384dezKyLDhlbPls/UFPv8bdR/k12OK2Szeun4AxPL3v3m2TpNitFl9qHy0PVpqpKQJP+Rta3oCMKvbN950UgUApLCeEeLCSgB/EuuDSdJawA/mbjWqvJERSVoYfl8pSpEM6nNsqgdEbHlsNRbApiWov1w/WGbetQbYzfWtY9+fHdJPhVsr4FgKsZ+fNOrWcW/BnNEanuS5SA6xEE3LkRGVamCRkkSg3L4sZ1SuspxbH1d/u+sYOL83PIFmA8nbxBSdRDYzDoH5VTxm3pOJtz63jHxSSPTi3i25DCyFoD5fEoao/sWizoPC9IlyRPdvcgQ0D/s3vPsbheBdwrkTAkghG+2ZVfh4ecPs98r0g+W7twDN6kTCs1KCh2euxsOOPNEUdB6kD66mE1vxjR9CjFqSPjaNl52TMzGG66Hc3UfRxXFV+xt+U9USDRy9ka/Bze5BOPkoCvFkBHemxfZ+0zfNB4rdnyfB2qoTCfGq40XMQJt5sh4+y2PuR0YA7tnkKq3Z6ibKZAHe40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2RQO22Y4swlQq73JuyI17MwCjdHfopajD8bP2ml2uD6RvadkcxCZNeYVDW4?=
 =?us-ascii?Q?uTg3txhqi8JM7F6L2/l9MBw+7V4GjWeR8zOsooSsqTVHBS3FfmDKpwdVTZEb?=
 =?us-ascii?Q?LBy8R4YHUn//3P8PjbP2aEGkocUnSxivuxhHi96/DHmQUJvGB3qmyg0Dcpew?=
 =?us-ascii?Q?bjsaWWlJtIhZzwTvYZETfv0O/j7JsXZR6gH2Y1CLObbsABgc+HlUrn1t2WIu?=
 =?us-ascii?Q?JCnLWr1oRExDDjF/lhg0YFO9G5xueI6hcYnCJS93jB63w6OINsTzQbXWIZcK?=
 =?us-ascii?Q?9Kouisx+dYWeov3a/B9AIm1BIk4vQMo6olE9q4fU7mTBJTCOfbR5tOGCFeMz?=
 =?us-ascii?Q?QATK4apANPOsZ9MLdTKYXtyxprnAdES8f5tsxax5nqDnu7SCKWGlOR+mE4PA?=
 =?us-ascii?Q?BtJuBVsATeF1WHppUKS2Jl1PBVupC+yZ0HNhE92tYAhZXC1CIC7pl1bEjucN?=
 =?us-ascii?Q?l8jIswhAGqTmlImiYGkbWF0n23bvDPbu9vwVFvKHu6EhdzD2Fy+rNAL6fekE?=
 =?us-ascii?Q?7a4spweLeaBHUMd59r0zg8sAE92saOOnj1TJwKkEFy9noulIrIVNmZtaLeCY?=
 =?us-ascii?Q?dX9aKjUMyN1E2B37XxE3AU/Q2DjH7JdTOUNgDlrJpu8CxeDrXks6SQ5vL/Cs?=
 =?us-ascii?Q?GERL6XhPgUyHfEBG9jpE7Pyie/HN6MnPJ6e1gGbBbEwsdM+oPXUWcK1fIHzS?=
 =?us-ascii?Q?fNFtJh+CxH4JLGahOXuqwXMxxMr8fUK4dsvT/0WrWlI9jibPk1eIMlyn15pN?=
 =?us-ascii?Q?0thPQWHGREWzBr4p3jvrrqRpL1QNzaDekNWRWdOnm5gkpzacr1SRjy0E2gH2?=
 =?us-ascii?Q?ZuNA5bpP2FvU0JR+qisNuYS8L9QY6RgOZ08cMoabAsDrM68Pkd8DF6bRLaUR?=
 =?us-ascii?Q?ItuuiKqkZjI1sknDWu3ZIdWHagMnb4SOoE/cliUKudds8YwUz/cwNdioo+re?=
 =?us-ascii?Q?hWdDuDBF5Rrto8hzldk416W4u0rh+mMfKkcS9UixlTxM2jzhpO2i9UUMdxti?=
 =?us-ascii?Q?/jgou2HxtXjiso2HlePzInPLtMmRXFxsteYmx8S54+hsofUxq/ejCEpb1Z1i?=
 =?us-ascii?Q?DYV1xSn0hd6TgnJSteyj8z+dQuUR+DbjbPbIr8EqHn6vbsYaaFzUtf0iHsld?=
 =?us-ascii?Q?tRzYNdCWtvidZeD9RlI3l/ZbWIag/FWLEyianEh+GBhlro2YRkbn5biOHHmb?=
 =?us-ascii?Q?eJCBMBSh3+gvyGjdYkehItNwTHFSmYYi9OSu/jhBQiNRitGb3OHsmKvkMQMv?=
 =?us-ascii?Q?sz3ykhE0gqNH2P+vmTSuyRSXMlwngMQzmXC17ttMiQNTaH1l8shH/kIU31JK?=
 =?us-ascii?Q?kfgM+YbaXYnbt4zz3GpmzfqnYMnGN9v+ppmxtP6YMr+j1vq1YAJyBuaYxPYd?=
 =?us-ascii?Q?uHYbsqjhLbuWGVqw1V4g7KOoMLAg9olQntBMGqYAVmOYDDUeztt0gCFMfXJE?=
 =?us-ascii?Q?eTenQGgNiFbpF1o6dLXj4KIZLLvoSSGFwyIOGURFHRRvhPUIqAWau/4oAZ7l?=
 =?us-ascii?Q?Twbxpn+RzE7ZJ+cn/pm2Djm1+GwGHXBfNaBgZZZNw4Rztfr/0DwiylzaWcvF?=
 =?us-ascii?Q?t+m6J/7d6nK6qZfbMPvu82YzBdmQdM8bLHeutxyI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b3d5d5-2dd9-406b-341a-08dbeb4ea376
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:58.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnTYaQq2b66XAMa0H+eFlqRbRcFdjtOsr1kXb39CKGKcCD7tcjG+EUqbrZspxR1DDNWXkbx1nJw+T8U4jlpftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 +++---------------
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4ec23a697d00..9b7e66364c49 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -391,6 +391,48 @@ mptcp_lib_evts_remove() {
 	rm -rf "${server_evts}" "${client_evts}"
 }
 
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
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	fi
+
+	return 1
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 108a7548a1ed..85712f097597 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -237,46 +237,15 @@ make_connection()
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

