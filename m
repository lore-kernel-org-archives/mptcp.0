Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18C3FB06
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jaK0O3J7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j53na1v+ETleCrWpxyJ9C+Q26XI85TNpfv7o6UcM0oDRS+gWJOZufDowCX8PfhAw8Sn4/f2ciiga/urT74n6OceVYdia/9KchE9wjyN1xdXKG/Ozna0dxS6XUcSqyKqjitZbnq9L2pk8Whcmw1sjGB9QcfML/AzkPpOBMPHwgoy6tdBLj1WPr8n5eUJqrBAqPmNPkl4ZVrgce7NitNAWYquGF3oX4hob+G0eg100F3peK47xYHeJDHZkB9bHVZid72MoIBLKH4nNSUM4/cBqywuN2Rq1GwhDrg8QTyAV9Es6yExiw2V3VysfIhnYQLh/PH30gGyenafbphYFJvaveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez5RHF4LfzfCD+GmVqTZxoW3gdpwWHF85PM84iNerfI=;
 b=ZZJEMmDVlF9xoR24hvuwfXkcp6M71NGJ95QU7L0oq+4UWeoTTHTRRjT33Rw+Jmi15GYWQXjVuNbJGH1jOAna5K3fEN1C9/nRJ2YBsJuwcxO7NUbHm1bld14uATDAm+4Xd6DH5KJAMBiN7ApqToF9zxyG44OxwIqHE8al7l1wF5ZKGvUEtOB/8Vh3joFLGVowCLOlYIg868Vzpca8YuWP5+U4wLgpBdYUBT1zy6yyOp9GTHOyZZDJMyZX/Rgs9/z0GCW7LaNlhBPru6BgjtgCYh9gLHYDEgyTHPtaNmbjKHPHx5unK3o+hFy3BbObhklFbWtxPfOX88G9aOLDBNPHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez5RHF4LfzfCD+GmVqTZxoW3gdpwWHF85PM84iNerfI=;
 b=jaK0O3J7MLIFI2HDjJlFx1mqobAF70XzT+3QqQ89iagTdXoXZqpWmHYqIpSvkC6lwaRySCB2nvm8Jz8fEeYvNax3hudnmH8TIlu7R+k/iKhRXqrn91aa+t7pYSCw1MoabQPohS0F5bJ//7KFTO2XYlic1YER2raznSeCClA78pzLSNz1JH9iTmy+m6Idc1+tBSsvt/J2Z5vXiMXHZLuTMbl5GM4B+MAhtnVKrQYmKtEtJq+CWuI4G9g7GU27WPrK1GpxMFsVej87IA67/uHH8AzH1jblEjayeGJ3zxfKYkC8Bndqp1jN4fCmGvZGyKkJirV8WMjhBki0M8WVslo7qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 31/33] selftests: mptcp: export timeout_test to mptcp_lib
Date: Wed, 22 Nov 2023 19:31:19 +0800
Message-Id: <9aa7b3c2c2bcfe9e92cff66789e787f63f539c77.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: d926d0d5-bac4-4453-6c1d-08dbeb4f0365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+XOUkEonDkPWyBfu6x6N+EZ3QxYen8jZBwntxiDvi2imkE0VDJRSZnIcCcp/B4q3gtSAHZywONR8RgwCRalWAw1Mzvf8yCqs0NhgxgWHaIIe5OdhUlR60dwraNwfbALfSA9SXhLGvrydv148/SA6sMhxrxQb7U9HCHb52bK6SpOWBGLNoFhhvYNC/10RII4uDxPwrwUErzUBZgNFF5SCWMdf5nWDwNZUusmgY72O7bJh15osaJtDRLI9pn7dy+jwRn3FAYKLdVSIUBOUBwrPSkcH2uPGpvRHQYTpsVPWlNcmAvIQAJE34B7vi06LRQK36P4/Rn1n6OxGf/E+AS+uOrLJ9GIi3FLwJt9UbuRjBU8AT8xzee2+MBYb0lt/1XoW+Fh/MFvXfuhgXP3CgfHmaX/7nQCfA3Me9J4+5UDsmBqjClIk1zULPfPsnR7K6Rj1MTiySp3exDO4qpfdF09xbBGTgZBjESKyWFtmXp9Ih528QABVYah5MftK5kDKGS7s5h1gjq6e7qW1dUKhyXHvozxLcCphrrCUBaOqa+LPSsV62Amb6hGqGevQYIoeo5my2VaAPEGmjyktrM1Is/GOn6r4Sl2RgRIJkVK5u+xVnPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72Nv3vesFPz/U5p/OmyleEH5u9GOviL1uQ7WAy4aFcyouS17sKXC8cv9SZDb?=
 =?us-ascii?Q?xXsm3XaeKOWN4Ys6FMlqavfpJR+vTIjCbBhpTNc97F7FtLeSARDcqNzlNG/M?=
 =?us-ascii?Q?0rJHyU5XWW78rCZotEli5Hx4aY4zE3DW3DNdhOGPP8vg9fAp0HIxu9Jhy4Gl?=
 =?us-ascii?Q?ryjs8KKweDBI1cHpA2amzwLjpTfms55kT1prbHL/HX6CnXS9ROSPmM6GMCf8?=
 =?us-ascii?Q?5WJrPbLUaa9uFNXTf+hx++Nn6Ad7hA0PSL/ot7PhpWSMuPTCypa6K4ANkE9G?=
 =?us-ascii?Q?kzb7zDaIvLN583WjWIoxhrmKIsXTeusgbkMRA396yXCet72A2t0qRjcUd6fF?=
 =?us-ascii?Q?7O0DRtr/BTX0AOrisu8+5HRpr/cHLn/Qftd9aZ1FpeDOYjGyp+GVVUi5T7nT?=
 =?us-ascii?Q?8C1PgjfVmDK8b3nnFCvSjOc2fzJuqGZSEwazKvyvOXKaUr75aUnKLS8ftlMy?=
 =?us-ascii?Q?zbQvbaiIhwU1sIBMfgHDczA8/ZTIlSycRN5KFxxFtJ0xS57ZK4ZQWwatM1pa?=
 =?us-ascii?Q?+XRDvsIh4JWedQqG9qb6awQA5MrHiW2+Lk0m7XdtTzhp6rO5t5N3PBKIiWnM?=
 =?us-ascii?Q?t1PZQC01MMt8TbdmshsemU4ODFgYMrEsMNODMKf7L8F9ZnIunzDxwes3XCay?=
 =?us-ascii?Q?EIyT0g1L3j3nrTGHKOdKWzwRjDpA74ciRLKCD1LGBk7QXXaY0Je2vahO836R?=
 =?us-ascii?Q?C+DaXvuprD+y0O59Pva1amYxqv0hVIVhD0prlRemPGQNOFjPPjvjL82MzaCc?=
 =?us-ascii?Q?QGymWZAWlzzvuD7uOk6+r6o6gkamRSEIiTM/k/nrPUcqXVyRNnbPG/XBGCV3?=
 =?us-ascii?Q?4hLG+JZZVwftJzvPxahh6iB+heBRdIdwbW7JKric/x0RqrU5TSqMnK9kdXfp?=
 =?us-ascii?Q?tQ5Ur9nUQGjBh9JlV+NU405A0F3wKh+6qL9706vaV5USpFV7CDgxakK8/rRc?=
 =?us-ascii?Q?XW1kBCE5AHxg091bCpyrQ9WDbxSSfzfZBnbuXByuHg0NS6RN6cTVooU62WuL?=
 =?us-ascii?Q?QicbxDG5ZCfUG6B4jcm3JOWQWADNdX9iPzo4rhbjHZFnXnE1mvqDSekaNBsd?=
 =?us-ascii?Q?rCBZRmN3KwCSHgZmHWxoL6i3Ci1KaZLEnbEaOrnaiE1Kyz7y3IEgVsAyCc8n?=
 =?us-ascii?Q?RINH2I4YbCLPCOWBJgebOJdREXy03gVywi724ry/BoTUlKTbXTYxJk6DF9nH?=
 =?us-ascii?Q?upb2JYHwENLn2l5xhe5CNp5aerhuEYhu6RifUpDXQpz3d0kB+UIIhPHETaRa?=
 =?us-ascii?Q?0Gg/tFVyFXvEXNqUSo2EoPZFMDp+UmI6PwwqVmOGOjnYnSgwHwAW2Cvrx5lp?=
 =?us-ascii?Q?oaAw/HAi9177KCPZ5O5jIicWPezWxKte6hrywY0nN3hRgVJ4vSx8L2tq2EGv?=
 =?us-ascii?Q?saCZiuGFqHtQxXZZjA2rnGzBCXOj5lQc9tHNHsILfnftgiWOqn7Am5O4SWGe?=
 =?us-ascii?Q?jN1PhiD3hQyaTDaPVybqkq619xDIdE6CWDPiZt5xLAIxGpvgOYxvbHFGL9Pc?=
 =?us-ascii?Q?6RLenx52tiKP/QHMNIRxTzFxOMaN83zdZOprP8bt2+jgP+aku9AD3wLiPXui?=
 =?us-ascii?Q?11zlgu60w4IwjFKEJslQm1oy7sttjA7eqdXnjVpGtYh6gGDLbOIT+9WwvuCm?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d926d0d5-bac4-4453-6c1d-08dbeb4f0365
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:39.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS4g48uMFGKH1Pu9fxepDhttfzAi7cGDJk7aeRdC8un2SkeaDPscYDrZqLNvObghHH9oE38q92bt6QAlESE/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

Move the variables 'timeout_poll' and 'timeout_test' into mptcp_lib.sh
as public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 --
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 --
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 --
 6 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index b5a17d2b6723..f646fede9872 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,8 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 6311deaeab8b..7bde17ffe20b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,8 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index da209af098a8..f49aa59ca326 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,8 +20,6 @@ capout=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 215dfae871e5..0f5dad2ba3b8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -26,6 +26,9 @@ TEST_COUNT=0
 capture=false
 checksum=false
 
+readonly timeout_poll=30
+timeout_test=$((timeout_poll * 2 + 1))
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 839ce692e099..139b3aff4c4f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -4,8 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 67643ffc5c08..a598deaf890b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -5,8 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
 large=""
-- 
2.35.3

