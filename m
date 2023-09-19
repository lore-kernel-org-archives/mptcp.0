Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E931A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzD0VdW3iYAXbooktOg5BEK0ADaVFyBTwa202b5hkgQM4G10/4QnRt6diEJcg8kERJambZsyf4wjcmfkoOOx2edn3Fo4EjgCrDtj/ywnMy0NFxz9I4BaMBuPyOeQZqk8CT9PfQXTIkE3HbfJ0vmDFfokgk4lV/otXmUb3tyeSXmWN3VeaPJ4rba3MJExsmZfIQsVi2KKVRzSdAjRLU5AWhrj6I78rtgNI0kGk79a23PY7TxvGWzyLh+bBXK+o1xY18n9yWxjvNRjS7ogX3Vbc9M1fIyVXRjhmck6TVmHorE4y5ARNR608nJG/DxsevFRYLU3Q+FbiODBgBDwOWDrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=CWFHd5yXj2lNqOUgCgExhcHVpiC4a/RBzCy+C+lhyoDrch2xo39F5Gg5KvnjYt6/0Y0mPlLL/23zyAXwALGXxx0+pGrlSp4SafieS58RPGSlWIW5hj91rN7oFj7buVkLcNiXeu6oA4Koc20tIbskVWxIulg9ZRYMBpWUxFFMcV31g90Zd+uVdRRw+XX+Xix3EuIaFbtPNXffZittwFrTRiPP8gFDFgNGAsqTpYKoZpU5796YHK4ykQBPGg0fHOOZlgubG5hc68xyj8XXEbreZHgLA3ikhrWokZmINfrpfh2SUNvCHRtXgNKoB3XrxwkMQItqjmxR4Nzm9cy7NEcMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=MGVu+MrHXKNrp90NsLQ577LimXK/8XDvgoyYd5l8gGPfaJD07GLuBK0RCpJC94Vw9uPbvDXxAQyXT0C5hX8Xbb0ktvXlZroQmJ44ohI5JPE0UnyqLtg4lsRqA/tc0P7sBSlxMKgN1faiYTOwKpfJElq14HZJ43WNpgm2PJ0A5jAWWzdgtKFZ3W8ubsmG8aJW5joE2mvPZKrkKWP1yvklnbaUNBBP7I3ff7rUKC6mAMGf9QVXZawud5hd4nEpFNOz5heXoI4ymFfmRwAP/GuSZ3dX8d/A5aKDK295AsxNTaxfJEw0HgjBLToAimVs5ewUM8X8ch0NTT8gGeqe1mikAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:05:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:05:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 24/30] selftests: mptcp: userspace: print colored results
Date: Tue, 19 Sep 2023 12:02:25 +0800
Message-Id: <66e8a3500531957615465f72908545dbf98ccf82.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 94680c5d-f95f-4663-a35d-08dbb8c5acde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ia6blU0IFB1w1OGuikPWn/NUZQR574naY3/htgtykvC/syI3Jw537p5OerHNHmYl4LIP3Gti8Av/1pp1muXKLBgualZQ3pHx5WB+pfmHAN0pYn7Qu+i1CiPNc7b47o21U9ZYJao1pnZ8QagD50rnhk8OAbo/VJnL7wSfYzfCZ9nFnBlwlbJQ4Io9XsZYJIT7GDwKlDrKXsAjfkVbf1aqcmzqsD+bkupJkkOj1RV9arV9TMeJUhKmBJePHbqK89yLVqwmaj+QpoH3CtQ+YmwY/hLXVGwebHrxhzmc8UnfWBlYRvGHpTtZ+PJxlUPxUizKskHZffsbZyY6eiwRvlfQg4rlENtnzHW0SWKS9sGpcBqMOw3BOiKueU+1auaW5zd6YI5b3xS/cIw+XyZwWc8ydOzd7wegaHgm9hhwGB8UAitTwR97BYHVV8NFWHT6ZWrA+Obho6zcOsqYbtO+t8WaUB9jbUB2X89ZbGQlU6szOobzxbTJRRxIZXkCvWgLrF+rxZ/vAJafbOmV5UkV2Rkrbnl1o7Vfh6b23SknN1ShyaEKChFmh8YMe1Kh7OS7wrIXPbOygbIu8f+3jE3JKghcjW2xuoMq537H4LS6bX9cZSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGmUU8qjxrI3sqx6FZoBtmm/HMYw4706u6h1O4hj53yv/DjUluWDjeaF6sfJ?=
 =?us-ascii?Q?5FqSjMgX0XQ1Xd+6htzWvWslX8EUnkIrpB1sdOJU8g/wXIUfeWDeqjTX5hTR?=
 =?us-ascii?Q?55a6LPqLotRKZZUgLsxoO6KAPpvm5tcvrc4ceEgxFTLciZH5mXFNBWK04J8p?=
 =?us-ascii?Q?NW5NG/ATja0t+bIg38eSbasuqPy/VARvlTrNLFrUrvNfIIeBP/gG15sMfJG9?=
 =?us-ascii?Q?AWS9gUUFMmLq04RlaTRXtS4Eh5C0rpmrJtXm12H1SRd12nWfAOzaxNsnrtl3?=
 =?us-ascii?Q?IGvkh2Gksp8F3565c79L4+GYdUJiryCcNbqIYVGGnYdIbdWji/WJhZGV5ZAY?=
 =?us-ascii?Q?Xz6rK8+A9r5lFmtJgjFjzCke87m2pDxrvqm+FPm7vvmL91mGAMuge+i1ttqn?=
 =?us-ascii?Q?rd1QdUd1+zyaZXAG+mo5rYpNVru8HSIh5juAFfKJMIiKRv6nxUcfWlV8dpid?=
 =?us-ascii?Q?lZKrFDHc5pLkYhv8p0NVhNKFYqzydDNu7fSMYs00/y05HpHp/X5XZ5gSx+dI?=
 =?us-ascii?Q?JI0nFyVM9pwprCBxHYu4BKV+dZflBTP1KZo4BJ1GcNOrAxdOe7gtJAqlKgDT?=
 =?us-ascii?Q?7vGDHjBogGebriHKxrKybLl66eujNh8OWUOKEW4fZQhZzLSB3VOtHAudekVA?=
 =?us-ascii?Q?cXlu/33lIdTFkV57pAWMnmNQIRmnz242I8xTpDnB7MdePi5czkcMI3yt9eYf?=
 =?us-ascii?Q?mt0j/kZrJbOsxhX4MRVwlFI3Xri2RwNLtXTwqNgBag2ykwtt1+p3Lx3ZyxOj?=
 =?us-ascii?Q?TIsm9LGMtI8TbILwer1l35lNLXKqxpkzBhsM5IoVEDzPMB3yfxRvh8Jj0+w5?=
 =?us-ascii?Q?wAizxLXTQGBBKeakb5jvrUBGhsvPefxjQAqfKi1jfMYCPR9zeTEGOz+CN+PW?=
 =?us-ascii?Q?Yid6+gxYmMeIvzjmIVAPQqWXKBpKSKxd+fQhGBHAcHcNzsE7feojsfoj7dvn?=
 =?us-ascii?Q?YKsCM64xYvhrxm6GHJzA01kPiXJI1EX9W3tKMUmOlKamnVXOOM6WBgptyuov?=
 =?us-ascii?Q?/rkPacNwdzMuGneAFt90B8koKenmfMwDwSpvTNOsVavtHRgTa7XqncodTncj?=
 =?us-ascii?Q?Foi/aeY3HsKFNyUK4gTrc+qGbJzbvuhzIblAjRzrbw+4azp+1K9KN/UlNRaO?=
 =?us-ascii?Q?ecvBYPQE8Ee+mekQTabQHc9p9laNp3Qc0Xq4YNq55e9BdBrlvKu/w0I7rFgl?=
 =?us-ascii?Q?ZhGvmclmkHkilb2rvUPAPFs0C9L1TsQg/iNcM8CXQxzE4/eRIbmLBk7NZdR1?=
 =?us-ascii?Q?vwa0DNx+ZbUgyfo2fGw85rSYkeSjBSKDdJB6jVdsOJ1B44GO/x3bwNBY5tJV?=
 =?us-ascii?Q?s1j++8/tXk5/x/H0YM4+QiyOCfA++xk+9OxrJHvUvtrduOngl5ec7dZhVv5T?=
 =?us-ascii?Q?YiH+KZeByS8AyQyH1MtHR+2lQPFS9ZnY2pe1oXzmwJ3wWGmLfyjXDmdFa8Tq?=
 =?us-ascii?Q?6SETujWoPz/eJq2az8bLA7rKvcB7280sXIiYpnoR0oDXkxW/rs9eTsZo8Iwe?=
 =?us-ascii?Q?8BKZcDg8q6FYIOhwKpjPA/NnS58cBFQA2hVeF6fyc7fo/c5KiJiZBEdMLv9s?=
 =?us-ascii?Q?dK53uArn7TvhGXbdTcaxOleCQQAT40kMjVz1GmgN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94680c5d-f95f-4663-a35d-08dbb8c5acde
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:05:35.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g985m8aNMW2g/1nLPiNgSdIDu05zPo8EQL81KCfCQ6OtuCbQlQOHo0qpdy0yy6o6QpBS3d6ZN2gTmRa1jm4hzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results() in
test_pass(), _skip() and _fail() in userspace_pm.sh to print test
results with colors.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 640273d4d7a1..84a77ee3b633 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -73,27 +73,22 @@ print_test()
 	_printf "%-63s" "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

