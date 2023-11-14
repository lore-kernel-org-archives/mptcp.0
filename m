Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84068612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e34fc1QR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmAmAuqiSp3u/AWwDgQvUnAJmPR2ebnwz9gVa0g6V7MY0RVH/eTPqFIVLeeyIkUitoKARR4IfykOCu6AkooqNXA5EuGI6c6MM94rjZEEVI/BxOlsTup3pTrrPYjEGKQObrTgyuMHWD0ra8Gv0GoadlcbFRMBGZr9hPlcqnqoy3NbKlZNIzs6T3zbtCefqhKq0xFhEzzQu9kN0OBeKCtMm9galmvwoC22rcYMG4wxfnAhuUyCPEIL/dQtQg0Yvqh/1sXk0nKcp0v4/G146C0tcf5e/TM4lbAddVZB5z3mJlcaiH2SMPRBb3eXir/hxhvgTcoPcmO9rXK1F1nf9LApIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clNSlez4Ct6xoQU2a04gfMakeRYW5AOV2gMnUNMaCw0=;
 b=IL1LhlXWj1+aAd39sDFjCHBAEe4eWuvL2yDsmXQ/d4RoXHsD1DZtskttktBa2MuIwHM8N0v5TZiCw9HN2aEVGnnSp+VD6dkVazXO2jIPuCo1p9zuk/aLGWNf8q2iFK1fa8TV1fquTY9mXqaf56aP64yBCT0yzeuL9u2oEGU3vDBWF63MqMZh+O0jU81R5XzZ8gHuDmuxL8p0ga2SqHGiWrytDpLnBQ9AOqR5YzDvS18olc53JqzlWC/qCsjfnDLhBWS1jaPz9MxVLZ1RjgPWoqhO8bxn9YtYnQSHKuP4D0+K85j+cQgcrf7yVzPWtCdfhfb9tunEZ3WMGQlAalK3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clNSlez4Ct6xoQU2a04gfMakeRYW5AOV2gMnUNMaCw0=;
 b=e34fc1QRAJlO054k9gFHd1ES70uuUutNan5o5RpsmJk6D4L67moCu53bCGCTP0lpl5KkCBu9onbL099zvaZx8X/p7Tkb4ACi+DBMPDBftrUDjgT9Y+WEehcdytEHElmhlF6dcMGeh09Dmw+yYxyEAy0wDifXjf6+hTiAY1uA3rWzX10eG94Wy05W/mQUvz0t2u3GOuY14yz5mnC7EahXk8IpGXWmlWia1qXDGiONo0rjwYSn3Z83h8hqPA6jw1rQNLWdm2FhZkysYwBIb6ECYw9HzObK2lstq/WJh7VnPvLEbGtASmbdpig/a/S0t9wwCRIy4DoFOBzLcDebDOwLHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 28/32] selftests: mptcp: export capture/checksum vars
Date: Tue, 14 Nov 2023 14:35:47 +0800
Message-Id: <7e3f2d14221c9932220dfcd7dd9d80cec6470285.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: e6010ba4-7044-4396-1f67-08dbe4dcbace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v/jE4AZe2iPDxWWPsm8HgiizT/Kye4YKeUqVH6ERyZlfcZF2dJ2q9j+pBtL8MLVaIBLAP3yMFFZW96Xb0mp6Ds+KWmvGh4Ikl2oV8zQUQ6+lOGTjc30XZipNGaHfXYEjlBO3isSzvPvwjJJ5e14f6wFRQa+loKHX+5yRxXMHPQxKIsIUiQ1OQ67sCwuSLmSFJ0QX07n0S6eeBPEhWs5KEupbl+mRO2rz9+GRD2OFKkzHQqsH2walpMUM5Cxl2qHUfwLNHAHktybZhtObmNTZ9XPgzTL+A5m606oXF6zeWdicKrQi7Nq7rjQCRA4KM3N5pB01FN1Afyif9hK+YdweZdUYFliX7nqJ8+NeUZshro6EiY2JDgEOPAB9DK4Fybky7GqWi/o4k6CkAJG18dPwTCHebSOUASYEgn+dFjaMuD+A+dgTq9qV7SRO8PzDZVursL5WNBkQOheCV1W3T6ha0jWiZ+wcEMc3HoxOkJZ3w+q2JMssYNj9cgPYzlpY3HtfmsPr6CescrDv6kba7y9vWNR9Uk/2iQMMwtYMBEx8lzkh3m7M/QhqIvMDu5ZGu4vE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueXfUcA4pUdRF09MVjWqxUpsLBixtcuZrMqrr04/fd4tJD+gqmPJx6T9yai+?=
 =?us-ascii?Q?JVLxt1ROQVVq+BMOEcaQGlZoZxQ7BD6m/XWUrc1IYWFK1mYjEl0iJG2mG5DF?=
 =?us-ascii?Q?UhCDYlfxyAxPD+v3EUP20Hr335XrLr4BdD2zNChTY0QEtJ4XNuwyI7XZrtlY?=
 =?us-ascii?Q?VWDCZlL3/wdxy6CFaQBc2w+FPe0sdK9LguCqz8RqYQGzyNzyjn1tcfRpVSRf?=
 =?us-ascii?Q?Bc0F4peUnKbYkBR8TYJrVXdkzncBL5rthgOVMr6OChuCBBSjFT/Zgz0qMVbj?=
 =?us-ascii?Q?Zv1VUeu8RILNomd7AWHaN1IZ8hv8xt4zMghFiVyq/gYCHJjf5dJoejPxQkOx?=
 =?us-ascii?Q?96Aoyil/2VDYzAKypa7AI318sxOXXSW7PyPWZakynprcYPzzC5qVLXiiHWjN?=
 =?us-ascii?Q?Pp1RoRHfLAbK/1+FLv4TbbNVJytlqUMhcN03Hq1dMNgfLfT6pv0SuK0B2/3P?=
 =?us-ascii?Q?sei6bO1hK2+tl35mENXYC2oKt24brPN8kOg9DM7PxO3kM5hP5flIayQbVe2J?=
 =?us-ascii?Q?IcvOWcPkDCJcZFEa45jOn8uTzvSeV8MF3tAN3tkqZc74IKR4IQfwNC+crTxj?=
 =?us-ascii?Q?YgHAAbz+zKvetA7zBdPazX7nPQfceXSIMEQFjZz6GG4C5/EfEVmk3DyeSpBL?=
 =?us-ascii?Q?n9dqQAoEQc+FvsY5M9doCdylrlBGKtW2STRlvRYp/7t+KKflP/973CzYCjwj?=
 =?us-ascii?Q?FLVs9JudYpiKIw7aGSFcA1Ay74yxLH/UhmDLp/1iyYu/5zKhJfUcP9EnDSmI?=
 =?us-ascii?Q?4+BDs+byHTdjr/YrzBCtxv0XiANbtbviCvDqm+O+/gqoNtOnJJpQZSaT3I2s?=
 =?us-ascii?Q?hAF39hb+NSj19mmrb4GcrE3L5TLPeqFUhVAXjmVaBIqCk5nXJHPOyxM/0Wwm?=
 =?us-ascii?Q?L9S7bEstRFHqMrw9BdutONjg61A91k76i/zQQD9W3866zbL8HDsBl5qAOnJK?=
 =?us-ascii?Q?gxBBTRzodunPOcqgnmLIPdFoStdmNZg9L97toHGHWawB7MlK+4281gPOXGEw?=
 =?us-ascii?Q?dSi4wMgMX/Sc89Ad4PVBMXoMm1HTxN4OadgeN6lGoWdxkf13itMG/cy8VO/o?=
 =?us-ascii?Q?BzXZIgn/9Qmk5MF28XyH0sJROOM0wCAAocZRnAs5eqwYaDT15tbGVBGjvVBX?=
 =?us-ascii?Q?l6tjXCxpls74er/uw0s06bL+7suNvIDwg1t6bc70eBOBlU5mRD6nIWHHtMSj?=
 =?us-ascii?Q?ZypO8XJ1STAefN71xShwUk7GNrqvZg+6+yq+GHtnvhla2OQRP6Qgqz9jfGG3?=
 =?us-ascii?Q?7quA5Ewuvz51lOzE/N33p2nkpseokCgjT8c2xKhEMY6R4yMdna6s+DAn0pGg?=
 =?us-ascii?Q?+WzWvRMJoZoP+L1jF2RnxkrwH9amOci5Z13V+kZp5f5n9P9nxwU3UzGS5YPx?=
 =?us-ascii?Q?2eY6r1bG6QgPsl0VngnSbx74YyvaXN62m0SHQ3yeuEvcyv7O2Egl9/ikhDt8?=
 =?us-ascii?Q?62udCyFFxFgmlLmA/zX9jOLIL4stVHnrJff47Ce2UgUm+8rPsa02SECYRz0l?=
 =?us-ascii?Q?6BlIGG8H2n71pLrddY7NeBETrQ02C1KI0M5ySIg+hTikxY06ObvjEYT5iC3b?=
 =?us-ascii?Q?OA2uT1kolqMomdQypZWGXA6XOk2XbEo22MGZqDNZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6010ba4-7044-4396-1f67-08dbe4dcbace
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:28.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l4DmHpqXDiLbUYwdSa96k7XYWRYbZCQDKln1GW3k+4BZBj5uPR3A5dn5Ywcnd/ie7soorlMDhbOsVNLJykb6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

Move the variables 'capture' and 'checksum' into mptcp_lib.sh as public
variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a2511a37d9ce..59482d5476c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,7 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
@@ -21,7 +20,6 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
-checksum=false
 filesize=0
 connect_per_transfer=1
 PORT=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 63f89bc9b7aa..d36639e48027 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=false
-checksum=false
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 11983648fce3..fd54074d5d42 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -20,6 +20,9 @@ readonly AF_INET6=10
 TEST_NAME=""
 TEST_COUNT=0
 
+capture=false
+checksum=false
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2b46c95bb6af..32981972189a 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-- 
2.35.3

