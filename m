Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705A34CCA
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKvCSJ2ErcmKCDf3verWUCpBtSVxNvLlECQGpQZD+/go72rsLlDlFSXO0kgDn905UKDrPg5KxNXE22ht34KamK7R1ndVI80U+ZUWAj+jXNGPnsdyBT17Ru0XTvXy6KoOJq9uOW6/oYzSDf4foREllDqkyEoUT/6jbyiEstsIc+ywUKTMGj2NW+ZZXcAxYSTVyIangrkCn38nx4kq9YjxDZxm2TBl+9PaWBaa+vxEr0kDXNT3pWpk7hLQ9NFNiAoxG8erew0oHDEiYUdV69Jf+zJ7yfQv4Gxi2wau7vjSwHuTB3/ZCGd3H3buVzOgOr2sVja/ViYCq0aCekPMS67Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrYQKTkxiDbmrHrww7JkAgnC3WhfM02wTpBScaPxdT4=;
 b=gayDXYZ3B/jcAbSiBI8D/YHpD9fv0W8wyjmwEM6xFf7TqTNGXFyTsYowVVgFvNz1u34+muRHlzve/iFUQj01wTgB3v28gsmicQHV+y33UEEbT+RAv+JI9akiTwedMUje/YbXompVJ7ZY1Fd64CggHWN3o7Rdh/gxGjmqdYsi8apLKyU02jogUmOtQ/Oi8IE5hkXw7PoxWNoTnCyYKV2j1IxAUtb+oMzBjVr+ARa2oaemXyiaVKHygMgj8kt2d/qauIL8liOjxFbifgy5GL0To2iKN/8f9DcOUs6i8T18EBJfZoqKpBRf0HkygR+5eGOxEFeC73fUvNW3is+ZthmFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrYQKTkxiDbmrHrww7JkAgnC3WhfM02wTpBScaPxdT4=;
 b=fJYTpZa6tJQMknoJROIl5zvGOfBJKqQTG13JBxsvQQX8zDKEtOpfW0paNDmzWnI9D+BY4s073vzH8rdLyueRjJd+D4rEEWb7WiOsAwOJf8atOJGqlgFF/6tM89Lynan+1GUMPBk8S5HyXxU/2D8vG4r0yZUuK2hzHN2j4RxLaAOskOZm5+sC9C9CTeN3vCHeMUfx9YvA+LabQcgxs85AJFWw+Y+500j+GJ2ir8OQCVEg9CX3Ixf2oMcADQVdgWFvf+f3F7sihG3pqhOngok0j/i9GHYcuIcWPFhuecNvl0jyDvZ8v490blZW3cmrUYYCOiSQLppePGn6ID1BIv6lOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/30] selftests: mptcp: add chk_subflows_total helper
Date: Tue, 19 Sep 2023 12:02:11 +0800
Message-Id: <3a48bc6d1b3fab45017afa8cf7bef1d5d6bf6708.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f237dec-c212-47b9-237c-08dbb8c558a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h9RUqtN4DG5ODYeaJ/X6KXpDit84uxDubdQfijxYQssXMHfqwQGcgMu61Yf8PlYDj6aDQkiTkDYbUgEK9PtVi/lMCqHlUYPCzwccSOdVXSUKvEXi4pvU10tPHYn5qWMdCm/EcoJVr0QGSrg+HUnOJYgKPh/8mE6p2w5GbneeAM2bOb3sii/zV4CIwDkOyIaoLcwrXR21zymZcpy1JxGIJPUUPF4ni+S/iKhcxsBvmVrTrEM00rA7zq486/IIQxVlXv65NpvaVUX9yeiL9o7u7k8l6uQEhTDGi9xI2XuFlqQ6JgTJlaz873dPJ/T3crmtek2dRoxx02eaPMuJ/3a527zVxQISXGOuZmckc0QPTycvVf8gT/AEs8e34G8hUEXBBcP9PfunRSxhBu7TQhZ8YTO3WQQOpqhqb1baqty94uswIp4/74QfIsmClwA+R3eAAr77M7Iy+ISEUABXikDalnCD/TSsN+3p0qqyvdZ+JLXn0mxN5I6LcdSHezkJ1iMCMt2Hg5NRGP6Nf8gnUGOpcWSoqnINfKoG++pTn5MZ5uFqykDiKtPBEfeCBQyLiROCUXPhiNH1GddixrH8Gf0HBKHCDw39laxQdnlwIRPbIFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnRd1g4qQUKaVUIMRJHVOxzH9hugN0GkrcGzuhGIGaSrymGd4DrLtKO+rU/W?=
 =?us-ascii?Q?fpz/mLSxU+BeE8ggFotcISI7F/SEsQNXdTlXuGoiW16x9z/HWVXT2ok1SwEW?=
 =?us-ascii?Q?dYLq95kB12OLoGq2NW8k9ZYVYAclENeA6ymNd3H4BcRvvlD1a0nXT8rQ+Wn6?=
 =?us-ascii?Q?M63NfJPXFiI4t6SgkWiEzlW+HdWrzr8NfhaPN1YwD3ZNhrrvRW4tmFWLXCbe?=
 =?us-ascii?Q?W45LozRdHBQF7n4ypfzwKmP13xDUw878mjvYFpocfhi7B/Vi2S5ZGPmPffet?=
 =?us-ascii?Q?M3vXZV1FMT5jUr1hh/DKPS9iGGMR2JrrI4ph5X3uiOrg+IaR5/m3HsjRgNF6?=
 =?us-ascii?Q?3jHf4Ir1XuB/qf0LBDUD+1qgbrImiJ7Jux0g9XfHDmqXAbbOEhIu0x5ODLMH?=
 =?us-ascii?Q?gSkQDJfk6acI9iw2F7VcJFyAazpFcbMZOfcq+yGS5MHciP9+rCmoa38/W/lB?=
 =?us-ascii?Q?8PeAmvor86w3c5bKqHnxBOUJO/1RqPs0/pBvCzlp/tPf0RrBKdw3ykDcxgP7?=
 =?us-ascii?Q?TlcAcBB49rbZzL0YiSziiR4VTEO2RKtGzZVD/4op0eRkuPGQlSXKDhW0mvvs?=
 =?us-ascii?Q?foBGULBk4r5eeI/37YOpr/NDTkPo1hSOeEcxFaoBLzvTytL4WT0oXI9xTb04?=
 =?us-ascii?Q?GdmcE3iPkvj5LcGM3Wan1/n2Tb+khheuM840nW/zr4bDQShssHuWcFQlKq6M?=
 =?us-ascii?Q?zg85o7SJLTClUjDP+Ykkl1y4hq8fb7dMFDd7N2ngU7Jt3OeTPl78ilZNxuCw?=
 =?us-ascii?Q?MlMfpt7JdDXLfIzY73f9AW3w5Q9Kl9AEcAwsav72x6LRdaEk1C0HtCLeeHvk?=
 =?us-ascii?Q?jZ+C8K2aQLGr/M++ZlTXz/eYKpo2uUW4mE8L+7AtbhgC4C+EVr2L1iNe/P8m?=
 =?us-ascii?Q?5Q67wr/w2DF5W3eD+g5X93qYUfEhA89QTm6KT4g0FqFulh4KvHAdHM+XdxPa?=
 =?us-ascii?Q?FRiBIL4slD2GcgEIFT83jVFSDTwydWhWu7jpNb/ayJp2ARdg1Wl1BtdU5sS8?=
 =?us-ascii?Q?woaJKFNinXl5uAidrLZdOt47BS57LNP6WLdr0Xf+P+doSE9rGsCOJs501WTM?=
 =?us-ascii?Q?xkzdgUU8Qq6c8kS0EqmZGTdKAL4YtLYLvEIybxNX/re2EAePIk1/+Vz/luio?=
 =?us-ascii?Q?vCSO9nP+fLRZigcRI7ikuNwz/GXuaFbcauwSUvVqOiPgmTfLSDX3/eiHA9zA?=
 =?us-ascii?Q?3et5bxNTVHIXpa3NdTn/CkwadQvbNpsSejcackqrPCM65EE67SY7oM0f8rx/?=
 =?us-ascii?Q?A6qPbuqcRFWrS/tHMIJos/t18t3YsVZyaLgMkSCBb7s1e0aAOxcb8LMFLYbo?=
 =?us-ascii?Q?Vk2vF80XWtk8f6MP2sMEXPQOVKWfVAcI+uiZWnHkq6Cge1+Q6TXOYkEJ+drp?=
 =?us-ascii?Q?Dmh/T47M/vQSFdY2Y3TDrKufa+YaqpjIhp5FvmIQVECRvkkMx8WowKLWp85q?=
 =?us-ascii?Q?WcTJnCI9t+KsEF5oQM0dD8GvGbMpqAZO3C4PioIUL5K51scrDUBqgHFf4oIT?=
 =?us-ascii?Q?PTWf+Y+Yde+a00Nga+YEVIxk2zUcBHjgMWtouOBfzQ1W5P2pgRciaDjomRso?=
 =?us-ascii?Q?xVVl4WkCPg47CRXfy4d0tTpKAkEFQXHnSqonybIe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f237dec-c212-47b9-237c-08dbb8c558a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:13.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmYMZivZNpO/p2OhA25X6XDXGov3C+LWUILaodZ+azOymfIAo5gaVmH8NFTvrU3jkuAmv0IZ98HBK+THWciwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one. To be compatible with old 'ss'
version without this counter, get the total subflows using this 'ss'
command:

        ss -ti | grep -c tcp-ulp-mptcp.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d02e53be8b31..784eb695f42d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1862,7 +1862,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
 	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
@@ -1885,6 +1885,37 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+
+	if [ $(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info) ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3410,10 +3441,12 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3430,9 +3463,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

