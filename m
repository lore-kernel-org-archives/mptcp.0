Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74751035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iklhxcqf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV/LSrW1cTcAg5RgGva4/zC/50APy6ZXhIIV0XR6TagjTJVPvredaA9ksnGDppJVHoY69/WWqzAC71E6b4ra/iS0UBLQbBsPG+YHxGFs1Uz6y5HKeeUQfnJ0mwG8BC/kmVmKyZfMvE7B6mN8GxJX/wunOqWjWAghcBNlGLyEiicEnWMfD1TbnI43KsIGVgjdpzZbm6XOcJFmVMVl1PoUkuJETyGuQ6n0FNYOf0pntlZOTMlJmuuOR7cpt1PpzQfYS86/5DXh9a5FbQTiNjruT/mn0LcXJhjdi7KFHFfJzhMuaq0G65yPSt6rSxDXnGzWnusWqfzpPKKmXCQ4B0ewiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXdhkXyIhwwBHZLmJMvqfT9N353Nof0PwdnLlwcEnLc=;
 b=et2WhqhGtdvYmTftq9uw4d0GlLcYDDoW2/JOB2cGLxuGwJV5iqDKZ3YsIrE4Lv1wj61vbHgLdA83a8Uw0LPGDzJCEoZirhBRqWj3Puwg1o5ZGhV9TtccrFCrqx93FhdwrrmGJtVnSsjSYzh4Okcfts10xZ4audz7ddqbl/YESDehmyVDDiK0GMdZIWwr+oB3RocczPcvFfaIG5hyUMAu7sBsPcQqiOuYNL54YMl4VoHkOTFHOUhmQe4FNWWw/Srof5GJSJ+uq2Si3vvx0kOdL0aalpuI4yMVCuLhyG3a+WGiOZ4rRxIQoGkTzcuu+w98E9pNcwVqLBTp+hMGOTOAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXdhkXyIhwwBHZLmJMvqfT9N353Nof0PwdnLlwcEnLc=;
 b=Iklhxcqfgcv2mYo0TnVCRXQ9I5DSbDHjpubvCzg9tgcLpI7YvtFR9KoKtV4DYOewaVflG448ITpEvhaSEfT8F8ZnVh2HjdA8IR3A2KE7/Q5Fh/mIRBIpP6qC0aQBiesWcvNxlaOjXQOfqn7+eZiJ7iFZ91unijFo04FEThLUUUPz/Ty2RrXbOn2Qif57tLRXbWyUKuX/BfQEnjgZ5HApmndrkCR53y31FOXuxRYWeAbpMu4KuLjkZYYfHe14DMuzWx1iLScoclFcFRfwi3EJIRnpq6ctS8NBLJvoX1zJDj1kTzAmRqxDu5RQACP7gf1lYGMx/b4/sfoCgVwFa+T2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 25/33] selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
Date: Wed, 22 Nov 2023 19:31:13 +0800
Message-Id: <710932d51dcc62eaf27963a7cbdc69f27bcfd026.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1497b636-626f-404d-ea53-08dbeb4eeff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1vWscwVG9vTlgqzhSqd1ddayc2AJV4PaYT4UudZAXJhfNO5kK12UQEGyz/ItLTYkUGD82d/PpwE0HHdc5H3Dv50WtuojVVy7whPHeDG1WtqXBPaDjQqmNMM7m9KqJGW4pSzitkku8zUoZClLxy37AD/mszRHg/twQJKd7xwqRTK7x7DSA9p+Ua5m7QwfQH1BTUycGaaBQfUykL7JKr5HioD/AiFZ4q+OVbGnZJbw/oAupqyLvYBpTnTLTaUuym1/PiK1/r+67smWXxDwmJEqp+OFuYEh5UQIvpEVNqiWxNMRujGQIlPzBMKCZYCWQjiBM6obn6xti/VSJQpCmZKpuIr2uLcXBl363aiSIf+TwRVyPpvjuaFz2eoSwR+KxHxHl3umBO4wbSBzeG8ck0f1wVVS2DgpLc5hKa7dwEc9DV0X/uayIvSdhNGGjQORtVvnDpG4asKCpS8g3/sBiQFdsFzgLV+v/zopqgTiyrCtuJw/WthCa38ih/F6mM5N1O7QZkyahbtyGGHSKqoXNFb3RNXP+L/PiCCYAslMtLWH2hSAxA4HNPHLauIt9THXs4zvdd6DgHEvMe2uwFWKUs/m9XRUILijCpO2UT2bijASqB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZ/oPOIYvd2ib5qfnir1wbfTug7TJpTvg33aqkH0ovNnr6OvhHNcFvsHrGQr?=
 =?us-ascii?Q?BigwD5oolrfs2ySBnqqrA8MVzPmb0r0eAM8FxbnR/e9eMhx4/aOfOOr3jrTu?=
 =?us-ascii?Q?4dXjhzvEcsGoMwdTruDhKO9/m/JqF0XY7zfPemE7Uqv8Qw4XSjHc4JeYfajj?=
 =?us-ascii?Q?tRn5JyQhaxpEFDZawEnvfZ2+kAZ3iGKbDs8qE2IxDeBnmQutXENATeSdfLVJ?=
 =?us-ascii?Q?lphI64OxjWL7kOIlYXOT8/N1ybpSFKxWOktbQ+/Gr02TcFctlQ8sM08URGBF?=
 =?us-ascii?Q?mjRpf695cAviNzMECOcgIoFL8Xk3Z1o+gpt9MnNFTET7ZdyijpcNzw8ws3w7?=
 =?us-ascii?Q?3s1qyfQzU9KztUaTzBIkRTb/BVozei3sgQVUHDmSCzgv3M06FW1Uou9abPb5?=
 =?us-ascii?Q?lRuJUq95G97EA9GU2UT96E+yB6hd/Eib/xQQKbwx7x9cwOnXQ21vmbcLBOAp?=
 =?us-ascii?Q?SZKk0ysEM3CluZfoL0ZBhY+8HqXl7x1ETtjde0hy4Lag1itOi0hE5rpsKHhN?=
 =?us-ascii?Q?PB/kfDL2ipbuu0Qm7eIQnm/W+DK0T1s/IgyJuErTd2/tC+BC8vPSVWDnt0Ue?=
 =?us-ascii?Q?n8m1J5Tz5kcqesQ46S/KU9dHVSgal4HWFe9aG+Wpo2VnGYshSam+3MR9zixV?=
 =?us-ascii?Q?oIfjEFqG2lp20DOIsrpBeOaIop9/cj6HhguH/+d358hyzPuh3/K4KfqCtgHd?=
 =?us-ascii?Q?nXUTRBCOGWGO2KO+YePmVcf1kOxmnoqSHkBT4xkrVNXHvD0C5G2HS2KDgWxn?=
 =?us-ascii?Q?ABLcgBda7mXfxHF5zdp/pm1m86seRXIQMbUYX04iguqTPKeiYM1lEuS1mjdd?=
 =?us-ascii?Q?qV0BOgSCVHw/29MV8F0CZFr6Nt14Hr8no5DURyUskLztxRI8M3Dda/fKCk+a?=
 =?us-ascii?Q?D+C+jHGHBGVnb6JqK2npYVszl7/3E3zB5MJ9JGjJXj6oR2/ftdLXNOeQyAoq?=
 =?us-ascii?Q?MIaA+56RjLsSHnflUNYqHiZUEzt86KYu/tM0c96f4x4iZtbVPNmoBkaA27da?=
 =?us-ascii?Q?PK7aLOXEjIehHHk7v6LhJYKg3PGIMpdFYapi27hYJjsTFu3jAUxfoEymkt1w?=
 =?us-ascii?Q?IcMexbjtfLT8ydIuFOhPPJX5yxR4ch1uhqhXjyBjPDcQzm3zKU3mC/etN54I?=
 =?us-ascii?Q?qL+3weiAvQLTWhvBaHfjcc0m/D6c5TtTY5QGQy/pEHSslAosGD8WH8oSiGV9?=
 =?us-ascii?Q?Lr1z8XTr/fuFOHnviXkVPDAosgC7zCAA8gBb1hRwR4WFVLb5BrvWtlbSr5aq?=
 =?us-ascii?Q?8WeTNneAFJXtOb67l808ICnKN1E8CUwU8LuHS/leG6QEzpjEZDW6M9ejL8kp?=
 =?us-ascii?Q?pIaWsV2u1m9MmLcXn4gBvGG0l2yEiihcXPzS1k9jeaArYmHWDO7gb++hThTK?=
 =?us-ascii?Q?dN09IynmpB3Eh6CTs3vWJ/YJU/rGF/jpZrP82IiMfNn6ZFzPSS1vL4Eq14Ne?=
 =?us-ascii?Q?UPS2BV61B8ekDuUVL9KJE7u3CeBYUwHbZgVzDIyDtYSg/XWfBqIw+5NIC8te?=
 =?us-ascii?Q?mqdopHFOrxr0uoe1/kgBu9g66DmzqRNIDjcaynDz+Y2TTxG8HtfQZUxdeWc5?=
 =?us-ascii?Q?ez40o6bUymsrhedPZchQZz2dHOTgFYi4pyvDFFcGfJTZ8bFzzghIaITVoBFT?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1497b636-626f-404d-ea53-08dbeb4eeff0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:07.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M46FD6QPd3wGb/0C/KbPKC4k53Z/26+QBI1zpdBBUA31T4N9AZ4lMYF9PQ1KNsOjVkc7JcogjWJwgi2aFphueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

Move the variables 'TEST_NAME' and 'TEST_COUNT' into mptcp_lib.sh as
public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4279bb59939d..c7a7c0d2792c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f4f7112a06bd..a52784a14b76 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -123,7 +123,6 @@ done
 
 mptcp_lib_ns_init
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7b9e3e3ea8c4..eac5485616b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -40,8 +40,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
-TEST_NAME=""
 nr_blank=6
 
 # These var are used only in some tests, make sure they are not already set
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2d28d0980b85..070c277cad4c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -20,6 +20,9 @@ MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 readonly AF_INET=2
 readonly AF_INET6=10
 
+TEST_NAME=""
+TEST_COUNT=0
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a9e14698c179..e1f4ddf04bc3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,6 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f1fc0a4f3624..9ed8cafde8f3 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -41,8 +41,6 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
-TEST_NAME=""
-TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

