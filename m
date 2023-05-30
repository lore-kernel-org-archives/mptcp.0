Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E971DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxxZ00Ge6HW3YjqiO5DuLdJL+WgZWLYwBnF+JRF/V3BKZxLRyvfF5F0D5PbsZuu4ZlMA8Gfpg59XDkEsgZnJDq8fwpxSbMprZA1K05iw6e0TxBEtBsidsLAx/Qw7ElUcAMXrWGgJ6fC+3TAVnH4Emxr84dHFM9QlvqO+gvYuBNNR99REBxXGsFr8vOkUsDzelR5j56/O6eShAW21wDxoSslTwDesi3tJv2BFaj2f02NI5VUBweS8p7+o7qtLMT25R1Qco5bcE14iW2B7Ms21U2qhbhfzAj7T1sJ+2MAhENsVO3uZeXc1UmJHxkJRVjiWlpFznZDnBwRHvD+P06cJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wsrSFADbAXiwpDtU3boCyB5oH9ppyKy3c54um9Zc08=;
 b=ebU4KogBVMrqGZgSbK5Ag7i2AvRd4ZKZ52v1q6fus+EK44ECbKrf5aWZDH8f444aAyOcJFBr0LrM4IfbXxM4OHERjM8+lrKPZfxskYrrTR+O6Ch6DaDRP8tHDd30lZHLSac1AxcScEyD/XXd5AYm9FCcU5uyx0xcX1dZ4sA97cg1GpfF2tPTZxZNx70RW/d6b0NFtoZVOU9d5tFvA1AQ/mOHIKBmc+05MyILHe4OpKc+03GeqfPxAtki6IyLQffspcdox4Zqie39vP9n0e/Zd1kMXK/0Glht+o0o+SgcJHncsZ2E8SD0Lppp5ijIIAw74j2ERYAKMJiUBV3Nu75Hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wsrSFADbAXiwpDtU3boCyB5oH9ppyKy3c54um9Zc08=;
 b=RSKGtuQzGZTUb8nlnpdDZrAndejkv3wY85moW/yghFFITkMObXtrURX1+WGv0Rk7ZrfyY4Qv3rLwaFp9fbyu6PzkoYeVfQmmPv8SBiV0s5O92xE9OxWqqG2fT+5zk1FgY+LE1TIjILUNZ9yIEM9ToemYuNquO+mzGtKSExVES66TXb9zuBgmzjIoJFSxAOfvoOO60+NQlzvx5uv1Rye86HlVh5Hr5R4h8a61TbNgwTYxRuvz+j+izDnuoVGXW905jtSSmk54yueS3zhtXm+3t23vtq25emE+6LNKiZnQJTUWeyleMvA9IFdfnayLqx2sH6reyzT2b1mZIZPHCNuZwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:15:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:15:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/6] selftests/bpf: use random netns name for mptcp
Date: Tue, 30 May 2023 21:15:09 +0800
Message-ID: <7ef4a997949d40bbe4497ac6b0f7546a6e89659a.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: b90ed3c2-c153-47f5-e33e-08db610fff31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BeOXZ2krwYJriOtwGINeDpTSGNLXd28IS/0U+CXnLxCZLFfxuUYhzKNxojgjSPzMACraso4a6IyP38viRqRh3nmXXbwmZn/lsbQ7o1j+lMLLA0xEkRDnExxT6DXrTWJP5yrOo2tuoFM3XcNFnRltWISDLytCjahB+MSJxPdNnK3lklEymm6y8zmczNmVGz6uaxyqyxAujUFgbJtyNyO/e3A7vBr9E43SieXAm2tKrce5KD5PU9I91ZhKz74SEqtPItEIRA7mroZaugVPlUgJ0b+A0IMWgxZnMsIKKhnnKmID9zd0N3MTytEgU73SrPIViE4VDkgYk56lMFWgamvxx2TPb6plGjoAMmoK8X7dF/mKIYy8kkd2JzKP8kL40PP2HBHGxdR3r3RiK2lsYE73qwZEJfg2d0j3ByfIDi7ypBNflZtcZlQiR8Xf9lVWo3xaLrNYoetZyzuXClqbTo+VmcZada2gyWX/aaITpC6UI3CHdC3r3mdJ+TO/ewsZd+4FdF6wLtQ3EyJ7OtjL1vhEoiT+/XE1WcbBIGTh6B/c+9LmZrH7M0F4hlq45n+qkNnLsh97J2T2adOT25ulaHYnlTr9gqnQNgCoisjKYKLcIUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQ2NCiVkq89U53OOpo3kIJTlb9dP8x0bMY1SBuy2+zyFI06nAuN80RjwINBn?=
 =?us-ascii?Q?HtkJROj0yewE+qQX6LF9NzQ0IhBTvTEobT1wgirGvd0wUR4ZjRXfa2D/wyVF?=
 =?us-ascii?Q?b+Oz+Af1Ou5EFv/k5fwab2LyiRe41AbkStt16pOjwuJxohHkM9zWFP2hwzm7?=
 =?us-ascii?Q?MxjYkULparsmwgMj5+ft3F/IWCKuNLgSqXEju1ENpWXq7/1+f+esa0dW3u8+?=
 =?us-ascii?Q?n6xJ2ybae2fAc3xzC39tBniXGn2/F4fbu7jdGm1aH6mqQaDNFl3OLtl58yCj?=
 =?us-ascii?Q?4R5o2DUCF8q/5dCOYsxEeWAILrQ7eU3Y9/4WliZwd4oXrLa1OFFZyDTiXDcn?=
 =?us-ascii?Q?X/4dF1fBeNWvR5oTloMpqKnqdsuYK1sVKiYfkQR/sAqY2QswXmHYHYmDaeqz?=
 =?us-ascii?Q?02meYLjnHDy8hAep8a5Up/n+97ki2Y8yCgcIT2wPLbKpd5CuvjFK61aLFSNw?=
 =?us-ascii?Q?8CqjFi6Yq6BsBBYNvNTrJ1sqJ614LUNxQt3leEqL9BkNTnH8rHrkXoxfnDkE?=
 =?us-ascii?Q?HGvV0X3MRSuRxNMdnnZUR3zPWONnSqyTD5Dc9KHht7tm4fDv726wBlKsyCY1?=
 =?us-ascii?Q?UJOW4Fj8chvWyFzsIad8BmXdd85MNzPAYnpndLJz9d0CG9cy5H3RMI4vkbBA?=
 =?us-ascii?Q?ZkkaBsrJVQVyfc6anp+BaWgeHl1BJ8J4uwMeKlR+TVmg+T3UxVK+I+ej642/?=
 =?us-ascii?Q?Fqce9MSLgBkXMyWN5kYAJonmjw76kDPZ/5kMZGT+AyTtK83TYeEJhdVouwXl?=
 =?us-ascii?Q?qFZWgArrAKlftZOb8fuzv4/k1S3Oj9Ls5U30b42JndhsP+uyAGhdbjSvJiyv?=
 =?us-ascii?Q?NtnqwX0PbTBJA3/CggOy26yGz/JrG80Dif6xEK4W1Z1RcsiEDbZ9pu4ZoKAv?=
 =?us-ascii?Q?+9yRE2unPMTj/qipUbmDzkepg7gNvpFP2IMZW2lh/mWDB9MLWy71FIsTSZdb?=
 =?us-ascii?Q?mfjwweTpPPnhnG6b5L7FdWgpeB/kV05bqMYrOyYXy9KiCApuPqMzcoK7xRQW?=
 =?us-ascii?Q?CNigQZGWDKU8/ZQXorc5H6u6bTp9YV8zrdEh4HP5sVWe5CqmyUQanPDgRbBj?=
 =?us-ascii?Q?TIluRp4iitKZfjbDLd5NETyea57Ke8IUpXHQWT73OrNI/lUDms4AfD2N1cD1?=
 =?us-ascii?Q?zcdwRq5VJm9sWilisfclwTxOU/lgPnEnIZx5cV9SBe4c4AodWCmHptNnQCdV?=
 =?us-ascii?Q?pYgzegej1+SHOaKKNWQoXmf9r1IXi2naFQXaEa7DXviIp1PTORfjUqEoJDdB?=
 =?us-ascii?Q?bhUTetdBCiA2HgeElT/QGqDN+Jw7IJtdFBcNA6VnPsrdoc/lVIwSGGL673Bl?=
 =?us-ascii?Q?v1r+yB9XWsPslcd+w3fBNyA58ceCfgTzrNRb61CxEDfqfVCMdebWbDojbgzI?=
 =?us-ascii?Q?E8kepg2FUtQ4SjPTKuISzXR9Gw1y/rXeINkWu+a/V779WLv5uEaoGQcRMauz?=
 =?us-ascii?Q?0Vu4BxUeCrAQyc9uAMLHZUSwe7fs1E8Ajnz39qtv3FP3g7VQPKLO6oGFFEUe?=
 =?us-ascii?Q?RA9FP6WDfLzwpSFJ3MzMeTEVsUKIXl0GdKmnqtlmhVrGa37hUpxfSpKX5ECk?=
 =?us-ascii?Q?lka7FxpYmZUHYtUQGFHHutrnIn3t+rVq2SlupZ/O?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90ed3c2-c153-47f5-e33e-08db610fff31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:15:53.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGPXgdHZ/71gDBocUaPXCA6uu1bamGpBkQR+GC1fSyo63uhKMOTj3AofbWPUJvJbRn8xHD3HthVlAyUCQ3/9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
Message-ID: <20230530131509.I3GGhJVWk7wylBD2tYbwZXmJYTY60qKJU1sS2vF7JIQ@z>

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d008388554de..ca348bab0afe 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,7 +11,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -144,6 +144,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static struct nstoken *create_netns(void)
 {
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3

