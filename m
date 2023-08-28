Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB3634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izHtLa41yAGCZAXKgsmcpY/5QUJOGMADcQqJA/phqMxKH43zuhB9yK5Plp29DJBAyCK7MblsNebWP2dHAVeyqY5CSGw7UJh3A7oqYn54cEY1OFUbe6oir54kibFoSAvqszcZgAdNH9AeeN4gatgcD/DAA97uvaGbDAMV1j4BWTQiHT9I3Kn+21piwbKqbJe9d10UmlX7GuUXwWjF5ZTrIIZ5wZ0SQ4I3XNeNph34sAABlPg6ddiStjUWhKu+XbUcDcq6kXajW4+fBxupYY6p4lmAmzydRtei1xkzkBQI1hjuk9UKQ3p6eVU2m8i21U15p8z8B1q2tvgF8giItOyxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaTGuf25Ae9PPi/JV9Vfq4U44YpWB2K+4/07fa9Pmg4=;
 b=Ijr4CN9KqoGDWqvEbZAQ7dRzt99qxEFuJBFWO1O2zcH7COZTjJcTJilliqH+1Zm1/hE2A6qz+AmFSdGEe2FO8ZrbWlxSr5oHAaFThW8GRTvNtJU1tx7GK8m9V2l7yyNj72auPUM/6g2p1pCCM2U1vubKujFA2qmNe8kow4qwkMBob1zk3vHxqpm0OaAmOeAPoe4oipzuv6+warcqHgbNEazHdy8/hLWNMduWv8lI4sJ5Jsmboxm7d1F8K/yXgufKZLr01OYM+JCb7tq0zbVilK+tISAHrwOAwk699BzvounWVrzz0IlpkkbU20Z/HklaH5UNYaxFj8kDbJCT+S1D5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaTGuf25Ae9PPi/JV9Vfq4U44YpWB2K+4/07fa9Pmg4=;
 b=YJmKsPMfsq36z+Lg03RLxw6xY1Sbo1DW2RQT7EGH+2kuRZxTXp/tv6ifs0srxZaOScwAqoJHsVa8CknbQVA55Tdefwy3pZ+vOBVSf1uZV5ML3//FX/ACB2HS2bDXDk/cuQiOFiVLIFufDxNzODrOxOWCQ9OX2s8QfxIhUB/KoKUVbsGiH7qwLSYk4BQOTjvVLOY73XWNhrC7+r3a3wDTEIsP6vKNsjeFppo4hYRRkIBWYs49SvjU3UZ14KNs4jfCXgiGuhUIUyTbpGZ4DVonTN1t77vUBCPbAqc1QDGQJl+MY3TqaYU4paWQv4Ab10xuq7bujF9sylGVMuyKeCXIMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:36:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:36:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 7/7] selftests: mptcp: userspace pm remove id 0 address
Date: Mon, 28 Aug 2023 12:35:29 +0800
Message-Id: <2778378b42d7a74fcef65dfffb80145f19c37eb8.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cf4a48-58f1-4c36-e687-08dba7804fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jIPy1RXhZKPuijYhTbnTQbXdfuO3Z4NK591EW920LP3sLfaB5d7H72jNwJAz3Ar5Uu7nc6/QlE6nqjatw0wy16g0xbSaTxfvpBYbaOuWgaQpFO1YjIx2QGwW+NHxklpLQv7mRYSF3G+VVFCSiIOZUkzfJPCVQn4cu6zS0hWhXI9S8x7mN5Xi15SUymSraBfpFTdCNte+1HMfiNVsmuJUyvsQwVRh/T6jEFiEKeuSAN0xL/sGLAJNUkUbEEb3GB47eUyPcAKvVjk9AHRVl6CjA00KDHjzKM9coKhK/xkLclODFiepNNcRKzbZDGJxg1FYpJf1Wo9iP/OeaDpHTr+3sXK4Ub5WZhXaUTxLD7KwudyoaHD6Kfrb9NP/hERdZCgwvyPsBx7iR20q6uJ1ax4+9tWaiJ/bsQlNPOWQ7+86rQs73ZetZy7eUyWbcFk7pGsw/fwOZiFdyXeUX9MgMDzE2ocQClJSUPjNHUFzwU7qllVcpnizIPg8Xv+YXW6nN3N6SsanYy2PbL0nx6b4w01kX3HWVimBjLW1lLjjvtOoXoAqUe+GLlnUvIOz7HYfI8aT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2zxe1kH/HbtEemNqDtv4cHdMmP2Blxi+/uw0gECFwE0K4ddE9v6EFUaatrG?=
 =?us-ascii?Q?iUy27BLagTO7g6XW/h8NfLxyric+a16RFIwguJrjcH4kEzSi/JI4opIH54jl?=
 =?us-ascii?Q?WIw5GoOagVXN0NEMv271UrBgBw2FHhhmA08gaCIWTsfjw7jVvyyD1a8CU1Vh?=
 =?us-ascii?Q?SFtD/276o8gACZkznAsj5yuO+HKcQLFoX85WqY3kal4Rsko5TKqLNmjJkJ8A?=
 =?us-ascii?Q?3b5EL17PLM8Fups4Ux7/+zQehbB57QcNA/cTEfiNDtgc+e+H7ZXfKQWQ/Jxy?=
 =?us-ascii?Q?Y7uW5SJlLqP58bnhQujVNVRG4nEGWyr+mDHgSrb9ctr3Zdv5jcKoJfhmqo4i?=
 =?us-ascii?Q?NcJBGSlCYvpKNjnnmNzZYisfM1Hj3QNVh1ndQRsQ1UvNZhR4OxWnkI85ZuPp?=
 =?us-ascii?Q?JqdVfG16irOSd9uFEKmrraBVhffC3txQZlmNpEKvfyEOQjr4q5rw6iyb63Lz?=
 =?us-ascii?Q?2WnC3ShumE8sK8YpNxt6EyvGskOH8C5Gtm9h8p+hTeAyYG8sdPIyMRljfikI?=
 =?us-ascii?Q?Q3CJ2k49iIgP4RzE5NMgYMbSalg6SCJUaDqk7kpJXbeQRocAl7ltdHLI8v/B?=
 =?us-ascii?Q?S5GBdb6MIDiXfaxjxb1nfKoouKVmct2Bme9zEfWkVtHIi0rJ9oqRdcbKToVk?=
 =?us-ascii?Q?zxl6PX5urqtkndOI6CdaDLfRlZTrYF+BOWKXyQL3e26dO31PIrSgOPRPu2Pf?=
 =?us-ascii?Q?6jSLO5eIx/29SXv3S+O8aSAGCAZHJeyRtFgEJeBLafthNUat13AcfiFvwdT5?=
 =?us-ascii?Q?AyGNkN1W4/7ZFrttzDOoSx7JTHlHY4cP/3zOq9DSfHj4IBufSpoif/VQUQTQ?=
 =?us-ascii?Q?bK5aXJSGYkGOFg9sRnyzlQZF/x80YgIBn+sD7dEA/vogzxuDyeCz9vWiJkkR?=
 =?us-ascii?Q?VHMvFYbkemjg4Y6JQxftFDQKGskZCdrNJXSqWcqcbMi+hLrpLYv/ONjSpDPZ?=
 =?us-ascii?Q?3M9rAytEMlqb47EXZb3pR4sbIHmxarZVwe3g55HxwioJSOGIhj4HYjDj07CY?=
 =?us-ascii?Q?L/EvIVisy7e/YzQQwIFZIiPxdYhNlOjDZGkF3Z8Ps9QI9zvkr9wQrYO/ueRO?=
 =?us-ascii?Q?LTMkcMjxhMy1I+8LqF8zD6DXjSIU1EBoHPKNFr6lavWv9jUcIYlHCotqoZPo?=
 =?us-ascii?Q?E8F0TrGSo4tCi1HfKhkGqiW7+SP+mGwp/RGQmvHa0VRwpEHDH2vBSVcmPUkq?=
 =?us-ascii?Q?vvZG6lFwZPN+VJtIRvIWxCHCYDGQu5CkKLmpVICjxQ+J3qiTeZacGmowehEi?=
 =?us-ascii?Q?yVIGoOqu/c9nIbrTVfhnxuYpUSUN4Y2SifNUP6OqllFRTswf8SHhrdxUBbhT?=
 =?us-ascii?Q?Yfh9oCcdlPc8K5PAe5RqwM1miv9NNy88QtNkXVNv0KSUgAFEOty1a0QXYZkg?=
 =?us-ascii?Q?4q57p4DnOAJuotah/v8uJKoqPmCJPDrL1zaWn5Xcs6x8GBdo0d9lZoWDteUh?=
 =?us-ascii?Q?9ViZ/GQ/S/3QGFVMT+Yrfbt8E8ihoFIWNzYszamDqV10gYCMMVXkLQ8lYpw7?=
 =?us-ascii?Q?D00KRGl1zfG7EJ+YCR4skgM6jL2bmBnr1PNxZnNf/nFKt8csn82DPxw9c31d?=
 =?us-ascii?Q?ctgOCq7BrmqE37vOMDWJpgi7J8ErmQ34w2GZGj2v?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cf4a48-58f1-4c36-e687-08dba7804fda
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:36:14.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3VSreaSF+rghOGTocSkRhCY7YPUqcqO08fZCpGaEEUmq0TkQzMTL0/fTaKvoKRCo6R2UjLsphXuP7WIDdX/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6a5019d1f95c..c6453f29b852 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3490,6 +3490,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

