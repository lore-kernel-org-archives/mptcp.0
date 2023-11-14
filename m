Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3C612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vdT03B37"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrevQogMbE2oTUZcRVV14kYVhY7IPXqe6eBIedcdhdx3OmNknHBc/kBRwgNy+lx/RxB8z717C+ZXyTbHqECBWJe7OH0dpAM4f4oOJjoZxb6SIwc3Fu9Wm0AMvsBrrWMCm6wMpneiBVPVYGxp9mUvfSBH3/4xK4lD3kbN5otPjOnlMCl0SQ4pzJb8gBXMq2lUMg5lRAqlxK1e+sPG8Z4hyU2uNb9pt9bVjqBaZOTJYE+nsbgzKiJFemPqEqL/1dawtrJ6WwMG7zyYZs/fsEFkJeRevzh1BIxHxcm84P4eTU0BdWugE7aG2orbw1cLiOAoaCTGeoG6y64Jc+FKoWPdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3BCn6v/3t8cDRrchM9NcZkCTbYGzcZxtuPvN+j9cQ0=;
 b=cfnJ/3KveZOpbjbLgwtaPy/HfuMZJhVLIo0HkygMjGnqWKtHaM++zvqZ4wv2TzpTCxEtG/3fK2JEAIxEabH/PXQ9Dv3hpErk4i9moLGgnSQQfHBUoViedwwmE+x5bAfWVUPixfsePwBDCD9JXL86s4P7eh1vDh0ke7qJh9CYhkXD7cIBiY2JY7MCpYb3o+sZA1O51eDHG7XiI/HCOaPbC9rIeiCxXyDk4mI7jcsQVHqg0ojjYdumlp7q1UY6QJ0fbDPS4m0OR+y4C6gDaRP5PqLiKWhjIWc7gApgXjvhnUOMewlsqndymrFAXJkqBeWCkeMsLhESCjLGggQ92ac6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3BCn6v/3t8cDRrchM9NcZkCTbYGzcZxtuPvN+j9cQ0=;
 b=vdT03B37hGTe9aYJ1OMtwcd/X51XDDYFWFKJ+LQXqwxD4uvGvd/Z5XlDLxPY1zi2w29VT9C0u82HRjGg7b09bsU200zpTEQULiGSlCBkcBiiy7yauIizWvjNfKUhM5K29UqLLSVB2I5/sCF9Kwu+9WsOo4qO/30nNRFqplHYyTiaY6elPV2ZLWZS5xCSazgdkunIGs6M98YKVijvon5ZKzhywzS2nAO104bHxHFpa/jGkWJf0nhQTdAODGpYtWs5OINRvEJEwxkc527L1oXwxfIZSTgennZQnUpjEiVBttMSxTlTnB4+XGwiwqTXYOHW+hOEvJ+f8eCmcZC0KqbixA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 30/32] selftests: mptcp: export timeout_test to mptcp_lib
Date: Tue, 14 Nov 2023 14:35:49 +0800
Message-Id: <c6fbededf2799f144dc317bafa89fe35faa28e69.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 170512c3-047c-42cc-6c2a-08dbe4dcc463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UCLPlYh4SbON8ZVv3Xy05rspaJX0fvI6OvchMEb68WkMaV1tIdjmvDwrD4kYLgZrJ6TXdscbGdTJhHIPXkXX6JrVWcbmrrQXe9GvjJpfBg+kOh0z+eU/zWLYS2hXrz5gztIF5CfNF2AFHTMTb/oSThQH1Fj88J+FBT9mWvxg5IoX65NveYIoSdMp8n6dGsc/jOfNE+KnuaEd7NrrvvOylXpRbkUkGT+68DJl6dTS6LtJNUxRZ5qGw8vaR+o9kHU4EEnWRyigI/66yUiXNgr54vXsvO0Z3skGLzVu3J4X1lZZ6lLZk6Wn+jCkGIrzp7RjJU2uByTSQt6ntyHI+zo3qIyJdQtpQHQrf6i0J3aIprMrcvcNV2qFHdZbm2o9MIVgtTv5TcvD+M+Qpt8axsMZCOw6p7Xt8hKa9CgQ9W60n+cIaMvYa6kbbBRiG4WaizFAg5HBggvJas7OxdmZWACb/a1s19JtYnjGTy6fejcsqEDBzUcCqoamRbfBiFOmt7toeohjZ250gStbqPuinjNG75qCxFqOsOf/SIIuwjnTorhx1kmECu/utOFB65PwesHg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yLmoTqz3r7jJE46BUBqfBShCvnwXTnkX0piTcfqp153Z6/NvuoLhfTCnhfH?=
 =?us-ascii?Q?pfDYm97PoDsG30Ej1+W+CR5eWfckFHmruit74xdJlyrMUFj+TMkaJ5bxvl2F?=
 =?us-ascii?Q?yARJXl14+kG+ZBB0eKx8j+k3GNJhTF7PzTjw0bQknaNvpQ53EA5pyj7UGxr9?=
 =?us-ascii?Q?jUz+A7XKQH0+mrT2CgsLgIViIpwm+ZwLODHaSg6yWxqtBu7FBh1+vAAPuCus?=
 =?us-ascii?Q?xHOONhlo2KgF77lJ6IuWxTGWvFcMLiVQ1+XLVZ+4iUc4TpKBQPlr6eIk232P?=
 =?us-ascii?Q?pmVq+GrBmqI7kdRVG16nmIDoDVA7JdglfeGw8Kv37eYhSlfVERAZsesb2zT/?=
 =?us-ascii?Q?/FLkP6BNHYxioEhv9a2TWSFs4g4z9EgwyOLlq3V1d6sZt25dAAFqFfWhNzCw?=
 =?us-ascii?Q?3qtEZQcCWVDWh5qMuWX/fntYT7tRfFaPYlvWNg8VDtdxWtnYbgbMA2hC/m1v?=
 =?us-ascii?Q?6AcdRGm0Y5e3ajH8ic3iTwn2Vfz21rT3Vdi9qJzwXxnGG4/MSnFzR2vsq+cz?=
 =?us-ascii?Q?s41mtjvG1l3cvu2xcq7kWArOI9eICigjePSQi7v8X4Rfoql6Q3w0zS6CL3E2?=
 =?us-ascii?Q?vDO+676Bypb4FtdNB/hr0qabBf5jL5u5tvIjPXN5Fzy4RfcCuwCzNcW7fR/G?=
 =?us-ascii?Q?NP9uyRSD6ySE/2K/XF/0sWMz1qskacTihF2CKHhhClSn/jlx8ryZqzP0qTdf?=
 =?us-ascii?Q?ASlD4egBL2j5OQbAQ+GZhC06N2p16bxPUcssBcvSO8G/ElNIwJBxifbfRUjb?=
 =?us-ascii?Q?k1kCCvNCRnWTdNytC5WlT7uzGNsPHu6GiZDHz/x0Qt/kTnvXBXBonuLQFVxg?=
 =?us-ascii?Q?j8nWRJFP2ItOOVRcyPuy+WLu2CidEIR+CabvBNOmjoBhbEDHG3JCuM05mY/W?=
 =?us-ascii?Q?gVRz492eWW8G5XXcHb1Y+3lyoHrWOme8MFvSerQIikt0WlJhC7xZDQMFcP03?=
 =?us-ascii?Q?yahFC90q9LP1kTMTxkK/wQmFDji3P8eMhwfp01bcnGZIQalW2HW0X03dTIRH?=
 =?us-ascii?Q?5HVP5YF/42JzA4nsGFyx6V5xWbXjnsEG2nMs/gHf897Ax6mXMi1R76YQeYdM?=
 =?us-ascii?Q?4srNcGYGr79qfgJpLC7Wqj480KEHfSMq621WPb5gf2pfmg3dcREoEyI2EB0Q?=
 =?us-ascii?Q?Fx6ulJgdnLbBranBg7SJDyuuL5aAQVN1hWXw5ni0T5up4Uw8hD9tFeJU+3g2?=
 =?us-ascii?Q?aA+f9rrq6ns1YwFqb0xvQQ4T/BcRN1SzBE1/0rG7Lz2TxQ9Zaq2RWfQCYKmS?=
 =?us-ascii?Q?CL9MhaULZY83FEAMRLJ8Jlg1AlfU9YSEf+INKZD9wLVTrl9kJnLTIwYJ5mUF?=
 =?us-ascii?Q?Ak9+RYAsUa8FkBYOI0nd6YSAHaCOyNuwNOK2g9X/LEaq4nClWuS0I6IuUnU6?=
 =?us-ascii?Q?PFDmY9OEEL/H99mWgXLBWwkWFRzMdprIaLDUAYi6aVvbmus0LuJr8yXNeFz8?=
 =?us-ascii?Q?7t+mYD7YIYHCoNmGYamx2A5l++BJldj0/UfUOJ9bYUZ9gEt8sQUHD4LcHCQC?=
 =?us-ascii?Q?4ijWt75euZhHw1+H1AD01v46gM5wXu5XnvRkpR7uKlMUMuPfwN6dKh3EjF47?=
 =?us-ascii?Q?XGOlgVEwKekp+iLzgmz3onKrKTpVTAYNblO3AaXo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170512c3-047c-42cc-6c2a-08dbe4dcc463
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:44.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzVEXiDro2YHYNicOvH3hTah/k1G1qigJXgl+vg/BjYZW+J/kCj86U1GAczCXjlvg4nWr67xOeDPl8uc2Ob+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

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
index 59482d5476c2..683172e626b8 100755
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
index d36639e48027..3b92a0b78605 100755
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
index fd54074d5d42..f404ac8d4b14 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,9 @@ TEST_COUNT=0
 capture=false
 checksum=false
 
+readonly timeout_poll=30
+timeout_test=$((timeout_poll * 2 + 1))
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8640dea7abca..2d5b6ade7df0 100755
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
index 32981972189a..0ba26a749571 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -5,8 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
 
-- 
2.35.3

