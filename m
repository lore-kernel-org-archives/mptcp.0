Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FD35888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jMBVFw6o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw7wOHzSOa2R7fGsb/9m532NF3CAm9ySbmBFiPzROEXsgKTOKzIOmX4KHwI7yT6dsGpktscfkYXEI5hWHfzUJ4Nn7fSIYG49KzSoYhZkxoImBehUatYFCCYtQzW4kRjozIAs4ZqO7zMIKoH+ZJfxu7OMC7PusybqTHRIkRq8y5GWSkYwFZoBXcFSwF9q05W93+cpp/TgHiARRx4FOcGYQFdo1H20uDn/jl/hakmyRDltNVJwszRIykf5C+NZtf1I+P4zJgVOebD4iOjPhLxfPEbhyHhEDO9QRpM/hebo+Im35Ap4u1KeTOXdZGOx3O9fLjYu5vl6YAMiic7NBCKfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwEtQAfnJ0hRvquF1g3hhDaLkAvRuMhlCIw8B+byzSk=;
 b=TgVzS0H+qJQFZFEA2/4tbVe1Q4rmsFV0E5bRLvK+CtIK914xmQcZ3CUpWFAyIinZ578P2yG53Y+F9Xr+4T9a3lUdbcelBB179Fi3z6kk4iFrri60THUkq8wYEo6hxj1jJnWhAy/B8FnawUbeOb+zfamDNd7zAoSvTCM8xGlFbK0vGvNe5cJr7g3j4ZvYWcmtXn7IN3Q6WMHpGg8BfxkK6lK6LIolYvRz8k7T5XkzOV26Zz4y0aoh1Uf/hSyVFa/ztWRCgcv9XaNMyLzV24pTBICC8OCsKSEa1dbwIpaVHUCMtjVQ1tXNLQpkR7NTiJqDkinHGxEyLkS0hmJsiVLkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwEtQAfnJ0hRvquF1g3hhDaLkAvRuMhlCIw8B+byzSk=;
 b=jMBVFw6oFW87ScbCeVO2Hn2AvwgGHmaedEQrfuVKiG2dvomZIV+BllU106POgP1gyRMN4Xnft1s4TJ9oJUfUR4k/HtcMxNRsK+phy+t1/bpLibFB8DdgotdLwy391+ah9zpbv8Q1FzIQ3tYAvPPVBYn8iuWqCwbPdxPQtexihWrCQHUl4wFglNvKSvrW0o8PdY7y3qjtksO2lm9vqXEH93tuhJsssdt0LzxXX+X2YtfUlc7ZezUrebkOODEW9pj2NXwzLEjuUN62dmD64Fjn09//+M5XZQ5Db7Q6X8lwuEQJFhqBNttzhaYlNxO/MPqlylBphQh7DRKuHBR32He/Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 11/32] selftests: mptcp: export ret into mptcp_lib
Date: Tue, 28 Nov 2023 22:22:04 +0800
Message-Id: <49ec1361b01d98f7ced2200cbaf3a95b83d767f1.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0198.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 349ab230-1c04-4a9b-976a-08dbf01d8d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NzNJ1SRx5s34lNcEgnDU0yOkcRboxmIfoBvM3kXOpeto8AuYFEstjKorcKf2fT+u+DLy7wTDB+y2Z/0CK4XX6JsFvrHZ4awdiitUOHYJnvxTQ3IYdVtQvwMrIuzKuqfg3snCdWxSMwPDZ3TROKOF6+J6DINUqHTvze7UJGjv1/nrSCkV+Mm+hqCFLrfvoj8SBHTtEfiO27JktBuj0TsfHHDlEp5fYtc74AHrXacmAY+y9kLTtzXWop59qIFQ3iFVcA9OnLGCCuoXpAn4vKjorih93gPJts/5DV0qwgYejMizd5Lyh3T/3Gw5rTXV3izl/M76KXeAOmZUsor22q5eqE6PgoSVOzk0DmRh9U4RGsVZgUr09Q3UueBhlxa9I8hYsn2/Nxgh1nk99XJq3uq7/Byf8jQWxgOqsV4oeXvKFeoMh+ceK+V+2iOb4U8oRPBL59fkvuLVBTubH2Mf1GXr3ZgE4KznxLN/5odYcDXx/2Bi2ohwCQDyTbFMYcw9KHj3onmai+9OsPQjXaKgClSH6CLIEL0fegNG02yrlIYBNaETaagBd2LgK6csgStqhjdG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/Ja6U6sChla4ZuvNpm4zJNAC4oeMdxUz/cKZRMprND/MlW/qJ7R7tgxEA1+?=
 =?us-ascii?Q?5RnP3Zsv/1+SFPjDfinCS2wc7W+3YnIefbepznb8fsermgnvzZhZPcN23MTI?=
 =?us-ascii?Q?iUSGXdLJl/8K6C9yl+dOSmGljmBaM3hgOZrM2kTUgQYQUF5WirARGAP/dZqy?=
 =?us-ascii?Q?+F4R64THrZgpZ8qCzpDj1hV0QYAoD1ooxXElFwVw8jNoyImWkfYsyoSbbY9B?=
 =?us-ascii?Q?87KDswJEmRNyTP7s6F4hB2B3oY4rfGj8//YxU4zCuz6KLJLW2SLqEszs2wX+?=
 =?us-ascii?Q?R7olRQlWxrdiLvwS1uVnBTkn9GwKK6p4ZD7kkXHsD3GCUbE6AQuKDTDVoJMo?=
 =?us-ascii?Q?5R0EfaG5tA63J4ysv6rjZElG5Z8KXKYgDFpCwy2uPjxfIZyQk01559QvSy6h?=
 =?us-ascii?Q?KLPoPv+AE97UDXDVklRmuELrC7viNCiENggwyc6ZEevVZ9Z6L/fiooGUQVVW?=
 =?us-ascii?Q?zT2S4Xfr40M8+lBi68tigqBqRcTucksKguzS63UGhrGMWpKkmdEFR6trrgni?=
 =?us-ascii?Q?uHdMiyoguU+l0OE3GH3WTW5x6oxWp11PsFWDjcXqHNQI0B4JHkhit0WEU9XZ?=
 =?us-ascii?Q?TdNk9eOglZfj5zGAV2VmMC1Y7V+L4xtvdWLvkLOudZgkXnbMROn9uSq4i2Xk?=
 =?us-ascii?Q?Iq+6O/wfisSgmrgcfl9GLH8+WRtGJnvMtizDPsc+EaCc69kQkoy9crIE52IR?=
 =?us-ascii?Q?VcYdD6o8y89h9YALnYaGNZcoV79U5fv/eve3OyFvEqSKFa3F2gd3muG6BQck?=
 =?us-ascii?Q?y2qjYP6+aqP1hIwIHePEcMQfnB8l+yhtxf0xJJnV8570Durl902PdhwiRqCn?=
 =?us-ascii?Q?+XsAMGK+8Fuw+AbkthkCa0iOk2Yrjbr8GzFyuKzJWwDwRd/CWJIfVzDt5oZg?=
 =?us-ascii?Q?eJvCiDo7wZdmg8EuKlD0eeUkXe1LJZnaLJmjt4yb5DepnT5Lml19lo5+fUY8?=
 =?us-ascii?Q?71xFZH0lmRmcddVZj2+28x7RCKO4/893cAvUeeej5ARr1SxjY04eXjJsp0Zf?=
 =?us-ascii?Q?fKXE33tnpky7MgcRaGVSHClrsk+fhFbt72Fj68RhZtS7Bq23KZc2T6+bD40J?=
 =?us-ascii?Q?VKAYRG7637g+lZzwW8P3M/0VUK4aMBGCOaUBtZTM+Zj8C3fLSR7xE3oCyJo7?=
 =?us-ascii?Q?hsOUEGpHNwR5le9d/FXRjXPtet+9nsHSZpGHOLHQ7BIXEIPBSGzZek8UB+Cy?=
 =?us-ascii?Q?FQ8ps1zEM3J2GD3HCNjmtrlYFjO+Dl44yIDTkfwNl0tD9RLxs+UQri5vPRrC?=
 =?us-ascii?Q?wYSNxLNe72RYufhtf8krjCo/x7ZGDwyLb4+moVB2oWwl31H0ZZ/sIrnkmO30?=
 =?us-ascii?Q?WDvw/AJLRgUMlo0/ULpHJh6mxd4FHuvehvaWXPNog5rGWtQFQNpUw5YQf0Vu?=
 =?us-ascii?Q?5EiR6ZH3KgrTh4OWugBbPDz/X35RU75HTl0NcW5hbVGQGVtJ91CKk94eylnP?=
 =?us-ascii?Q?UlNHiwmpQzZkN+UfFa863K5SM7nb7uNH3jCEjB0eGOvVI3FyHnRybnHqu81p?=
 =?us-ascii?Q?zZbxuU/Z3y/HLUVVxKp8Bvlckcl9pyDRDdoRL4PSnr6YPzBi8cUfn+sO/L8s?=
 =?us-ascii?Q?xq7x5iRf5lJUcyIwBLqdFU37yA8yRW/JA4Flm9ec?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349ab230-1c04-4a9b-976a-08dbf01d8d60
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:12.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxPNT1OQ6epvHBP3v9baiociWFQEPTaf2swszhGlvMn3QvYG8oEd4fnZMheDAGhIak7CreUjKMTBVnN3zxSXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

The variable 'ret' has been defined in every script. This patch moves it
into mptcp_lib.sh as a public variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 -
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 -
 8 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index a678ee21973b..0734bd9b54b8 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -10,7 +10,6 @@ ksft_skip=4
 test_cnt=1
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
-ret=0
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 98f4e82789ba..5e28292e1889 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -6,7 +6,6 @@
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
-ret=0
 final_ret=0
 sin=""
 sout=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 98b6814af0e5..fa67c833f91f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sin=""
 sinfail=""
 sout=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5b136c8f0827..2a9aaffabbcb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+ret=0
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 75d8c648f9de..45e5b5810a6a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,7 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sin=""
 sout=""
 cin=""
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index c0b6faed50c2..10df0475ac30 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ksft_skip=4
-ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 436500c55e12..0c211496e611 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -13,7 +13,6 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
-ret=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 005251b61d7a..b2b132f61f1f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -58,7 +58,6 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ret=0
 test_name=""
 
 _printf() {
-- 
2.35.3

