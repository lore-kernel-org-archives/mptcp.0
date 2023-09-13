Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FEA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3hgDsiVwWcl1RhM6QYPuBwFiEw22bIMGE3gTpFuVa3Iq4TU2em8jCmQ6x9KgZG4NdbXk6GnwJQ68v+Cj5eRVmr1sI9UIa34QKA4/oqCAMlnKfOtYHYOx72DmQ04esz8wMLtn1DRSzKlUeVLbbOYkiKZyhyjDtpagY8X0dk2bII+WXmKCksdfShKHQjrZcyDrt/y6eNZJcVrPWDO4rlhJ8tYd0XWbIp2tBs9NjyOiQG6NacB4yTYlV+Gclv/xSBq5diucJm6mY9y+W55VK3wDKd0h2OWxX6sBZBFtdf1Mj1hxQ5XsAa5XDCFByk7e1jrBkdv0RnxKPpvHKR3I6iLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=M0juEPCDZN/sdQ8qFhUNrYxpjYmhBPkv/0stI0ZPE63EwKeWon8Uzn/3QyS+Kd3mgXXqwG1yUGeb2yv6p8j1MuZGAqkIeTgeLVsjzAZ+DlRSrtnnSwX8LMJ9P8zm3GMHvYl8br1CviEn5vnW2/JOFTbtf9i0mctfJi0y6MmqUiYxo3rxw+ZLo8UCNtH/ULO7Q8w7l6cOcHvpSy6/CuU54WoVH93HJSGGOXaqcemP+x8PfiB69Zkf+QiIo4f3/NrT3BbRg1fhhubfQ2ozCP4QptrOdkuKI/I1JaqjoyjckA6ZIx5U1oXEDXCZ70uRZesfCcjacKW8vjH2qqfEE53F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJMYVcUnJHOmrvVRb6sHxKxtGacHjISedN79M97i4GQ=;
 b=jvfsxBCUa5KMep/Dn3eaHAeOkV1qYjQQi2a1Tz1tHPbHxjbD2QIOkB0oU+1g4hgPQfg1xBbHDiwVmyVbZcIDHP0tKlrw1a0jmN3YaKvhDpbBPVqHi2B2LAcFD6BABC67dTRjpGwoLJVijemXpQryWj+fVQbhW4uv6RkTNdBqXQu0wKL3D6LAErvpjBRfl20Js5zrflGdjfZvFj2+vlqpd+P+bZiU3R5EYP7K4aEAfjYEYIESDHZeJ3yH0GtNfR4bssP+70xqiiPLjpVgKT5o8Bu80MYhuPRbDUAMrs9Qtpx0aGCpxPahJhjQmXke7O5ug3hb71qCwi5HuVfPUHN3Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/13] selftests: mptcp: userspace: print colored results
Date: Wed, 13 Sep 2023 14:04:55 +0800
Message-Id: <20c827b13b38ffb53f3648aba1c6aa45190d6227.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0403d3-d251-4a71-9ff4-08dbb41f6347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ro5BrC3S1Ai0YZpy9te0oORyMxNyran29m5mmUpcFTmMOtif/2lKtUcyqosfzYehOdHwpfrDur4s4w+JPKvpsVe0MpI9iKJclZV+VcHLe8OSfl47vUgIp2Uxc1QITWjnjeY7gQqNL6Rsef2uKZQxt+EYD+vHNFEasts5N1ezc1EHiE81RnvLkOKd9oIksWluGlptcHYAkUnNviTJnVke+fUyd+mb9Y3v+uopZsRVNf2tud+SM7rW64vODsa2TWzuH8I02B9C7P1Nd6oKepdGJRjwA9hug/eodWZNUikcgzkgh9HjzSHdjU1yvmrgMxbLZYrVHqAJ19VffkwSFPXh5FtDdB6i/ZVvU9ZKOIEONwtQGB6qNeAy6xLYUS0ZzRI6U9Ud4Ncb3Mz2nMxIfyxUT7uNRa8izoBPIttIacp1WhmnLc5R1tgD7PQ1/P7omPlp3BUQldWU4wUTd2qv8soXFicXI/9R+vnb2zOS+lMa3sB6NRpS8GvlMx+YaHwbY/2nUmnM5D2iT/dObP1CmKD0Ssp+dcCt5GpZbixZ2gLy/UjzPmKlQZgEl2Fq8zKtaRte806F32dkNAZZYccIwJixQrGOSqcTwttGJPWy1pWQ9/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zz9mM9epmkDozHFj/b6UeffRvwVE0uMhcqjXbbppbpjhbHM2Zi7xWdbNLEFD?=
 =?us-ascii?Q?lui/bvxhdoHsuIiRPPY0CoeV1BOSA4j2ZpVTkSRtmGDE27iA/3P3twYiIs/Y?=
 =?us-ascii?Q?Il4rvIuHBuKMNJnsoTy/v4bdHLSC/R0GJ9NngCtPqyvrLqNDd+NM5/HR+LNZ?=
 =?us-ascii?Q?xMAOq+jpQRQNZKhO2FIIwPXOpumOt2X1Xgqge1mTGW1GjJCQdVROVoJaJJrK?=
 =?us-ascii?Q?hS+SKg605BMFozEM3M6hgh2+0yfIdk15aJlxjujfW+ICxwMxM3OHt0X/YURm?=
 =?us-ascii?Q?QrGMSS1AcK1GFq7btDCP5Y0P4ikin7UagBAH3dvSyNvWvaBdmoatWvKHT9Az?=
 =?us-ascii?Q?BOt8i3Xo1ohzzLvaywWt6pNpuqkcf5Q09aqhr2X0V2Ur7y2h3K0vZrzHlptc?=
 =?us-ascii?Q?hshTnEIop5TkejVDJvknKvhXzvaj0SnCmbZm606o9AOosJ+cF6Q9zHrgRuDO?=
 =?us-ascii?Q?UV09JBSuijNWSFzqNETf1GwQKYa8BQ5+AZF5zdvflOkX6XoNCX+4ovyb+RtX?=
 =?us-ascii?Q?av32hdk3fcTASVv6X73cLsuWMAcMDla3Q0wVcgko353CINyLqFSzbGajz2QR?=
 =?us-ascii?Q?tuvH6vyL9fjK3Nn9VIOCGPj2Su12eOQcpIw9ddMml8QT/ZpAECVEWlwVPoy9?=
 =?us-ascii?Q?ppVyM583RnH2wSqQsA6no70RuauX1GzxghqcwSkh9D8JjVjfRh+eqQaW2CYk?=
 =?us-ascii?Q?X4dF2YiNDHcQIpxFv7/+XDR6kTHxvAeVyGkm/aqWVyRaN/oOmdWtdH10HK9g?=
 =?us-ascii?Q?cAS9XPmFCPKJoubXkGWDxAQdyOf/z14u5igmLjOrh1QVshtDygHCO/4tPilv?=
 =?us-ascii?Q?OBJUQYmRMGbn67L4/mTPxr8/UGyXjjWynqFLb9HpJNHaLwE5OIlBygMwrD9H?=
 =?us-ascii?Q?mmFl10EOugcxWKefnrGRcZXW2mozCSH6GWWaEM79eo4RFiQBn6ZRKyycI47G?=
 =?us-ascii?Q?43eeiorjRWu4Dvb7OF0JhONejEdUG46Yrt7rpfoQp+W4TwEotsgaKIv+cYxe?=
 =?us-ascii?Q?M21mTYzJnAjCbv7TgNMncbHIs9+aPJM9VZLlr+CO8Lr6yUPZG2qd1E12yguq?=
 =?us-ascii?Q?r1LWgzJ3kl+JbP9gQU9aRMvh7njCw6Pxd2ba8l8TuE4fACIVIbJdTtwCONC3?=
 =?us-ascii?Q?rwdT7ULZGUG2JV1mUKtXAQXVPO9q3uRiFhnAbzPKNrB9aUmEcvbzelpBPN6A?=
 =?us-ascii?Q?1aMSW3CTn4Vhj71tN3G/soYx/fCN5AW7RV+K6mQI/lE8muTU9Q6Y7JbmQOnl?=
 =?us-ascii?Q?kOAmBX9zgM/UrmgoI5Cgo3QvO7Xa1JICWix8sOxxGD07aLqTSt1cT9HAN5wC?=
 =?us-ascii?Q?PiadAuXeUhYjI/kSEKX7zhmx98QSzbwthUzwXTg/sAQTYZS/cu/baucD6MxQ?=
 =?us-ascii?Q?eJVJhpp8iMGYts+l/lIZDHfnKyIcGCfdg8JPUrzSmjSjRixFxWSTD50nQiTy?=
 =?us-ascii?Q?fC4s9DrA9Esm+Kho0Ei51Zwf93UmJLs0fd+JDC0DmNFaSWgqigui26TSnx6b?=
 =?us-ascii?Q?TqmYGCxZDb5jQxPX0GAVImn843sgDzpkzyGdJlSUJvcsAVnzmLbDIOe4uPQO?=
 =?us-ascii?Q?xZTY5l6hRX62nX7SzKxPwb2vLgSitMtm/qUNj3ZH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0403d3-d251-4a71-9ff4-08dbb41f6347
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:10.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNBNQF32Q3pluTBFPrswt60xX072SZJjL+XXi1cK+6su6wF7lmeZxs8f0eryfdr8k3FDhXMXGkHnm/XzEO/+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

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

