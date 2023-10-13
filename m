Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5F53BA
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="h5mVy2rN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDI/cYQzlhadli2zFsdPk7uIHMPJyvIs9YOMmUCgjIDNlpp0lq+lobr52qfpPCJL2Ny9bkF1RnLKmfg085KEslEtr9W+m9zZ68CBDlRa67lVed7fUQd35RBQXIQSY9gdTsrwqv3DtjIm3IpbHfIqtY8VLK2eJ232mPz4ornXBwqLqEABAVDVHYL6AQqbTFSGwHnMlLBD1rdrnfzeVEEykW30XbjzniELtRGCWP3dOt/bqgdKRL1IUZ+lUIZPOsCnWToDkWVEDGfcQ2ittC9VGMghS6rQu5jTv3Ln8AQsOVJmYvedktUCMmLvdT0ClKBywpXehU0khUp5Sdoes07diQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sD+6CKt/9NCUpdjvJ2YA3AYwWhYzeLr7mSL0TSbhOg=;
 b=KNombdoOYntpJvGOhQQhiBfl5QQIg607A9SGxNMOX/2a/Ygvraqp75D4+9XWkVsT4QzmSFBzFsy5Myew30qBvexA8leWupzXSNmPXjdUiBjVNd7HabxZOGoL+43vCZ6zefbRBYKvv+aELAc9e0RB6Ytw5d7t7PFvce9gXaTde26S1OhOC/KlJrUeHDqdnYB5g5kqagcG4y4sMvYsDksefCjgC8GZ+mmBZo8kBOWuxbOARuGxdUu6TtS58v8oBuKKxnjLWTpPxQcJOZFy7Un4E4WzW/5Ep/TlLIuu2+3H9PCyS4XGaUWBvQa7iIPBN7ZCkD4JXQwu4d98nvbN/Bu3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sD+6CKt/9NCUpdjvJ2YA3AYwWhYzeLr7mSL0TSbhOg=;
 b=h5mVy2rNatY34VpxTrLUFz2xwuFj+kxHREx33uCgG8mUKOi13IZXP4LmBBXhzb6M1FSKE+S6/OJTVY+GBemAfbyY7tvcz/4v+LGgLMdywI70DphlFu8Gj0OPoD49MVIF7Vlgiapu2dmUsb4tLvDSwmUS4kxZHMohkYKgWK6CN7LnhU8KIv0FIz23v3X/F1NuIhyA0DHSQ/hucoe4lsKwHR6tJIM7eZtz8BSEXEqv5+NlLIvXKEfoBvRkeguv97B4zBZCdDYhHB4K3pWkwBnZJO+FYdbztyDePGlQOMoRAKte4DbAzUMIuGw6EYxbZI5md7wmSRaxdb/Vu8ETO493bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 8/8] selftests: mptcp: userspace pm send RM_ADDR for ID 0
Date: Fri, 13 Oct 2023 13:46:43 +0800
Message-Id: <594e783ea19b4a53fe4b4d77a449077dc932fa45.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: c99b8968-a42e-48c7-9700-08dbcbafc39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oSImhArJYQ/usn+dnvnlRT2Zw+aewzg5Eny/HH14rf+NbNCq1Zq/IMR47MnWFnK7pYvAQYynbr0IAYY6OczPOclPUNMD3dgOwEZIov7Zgp6mEtN0QeMXMZ3jcOPkE9eK1BCrD/FipG2ZqiaDeA00e1AFTzcHNeT3/EFNvjzByLHRNTXZz1O+b8x81imKPp5p69aZpCq8s5NAeaPZ4sDT1xDiuo+XrmzaczWQBchcAu/L4eiIgZRpTR0VSpQwzL/lChac/0r16JULHxBc+CwCrRSlQn9Sk+dQ5EYJeVsIv/FoJUR1KV5vuw5F7xJQCyQ1pDFhJlnHeO8olwDhk4i5ATFW2YcHGjzjPqaurKSWiEDMpTQSfXIY3RUuswQkk3NMzgB4rmKJlGVdIBs0T/p3MLeth2NbQjZBCCb/5aGTmxHh5q7CDQR96fMBy3PM/ukTS1yw6uK4yNqR2YjonN3qk1cLU28bFgFo7pmMvRO8vrgG1X+pF96iic8Zi27sr/dlFZEmVqKG1MItk8azLlSOol5eKxcGEQ62WK3GbY4Mo1K/XlzYYLg4luSgPKzq+Yp938xRcYFH6cvSbeNvOC0M5pkylJl7bVU0Ma7qgW4y8Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnu/OBzUT21Pj/X7JwVuMUnHpwnZxfkeMSawc32mA0r3+QI5tbdH8WF2T/yt?=
 =?us-ascii?Q?cmyDmhGVleVTJ4yVD/xlJVWPlugUh847/lerGUs+0Y6uLjVuDaJClwhK6bPc?=
 =?us-ascii?Q?yzgS8tavMretJSd4il2bQqIFLPbtMFcsmD9z8ZNcBqNWQXKhIQIAvQyy26DQ?=
 =?us-ascii?Q?Slrbonnruya9LvEg378uFjWlo0knn7XOMbT8ukm7r5ZI8USvSoNNKzOGEw3j?=
 =?us-ascii?Q?4rn5Nc3/DWAtzRB6JJJumBQlKSkY4WJPwucrsgNScNsPvAtsmyiePG4UtC8E?=
 =?us-ascii?Q?tofouxgVCFcKFC1iDZqOZlS8q0XoxqD6L54X+/NVcmsUWeBApHww+ksus0QD?=
 =?us-ascii?Q?8A7pin/0FGXwRP0Lgo2mgwLiUZMoS+hhGyqScECiYDKbmn5Knja3y+xf6o7x?=
 =?us-ascii?Q?1S+mpLC7+NRvLMwxp2FWavE0XXrGKOgj1pg3sViGeifgL2HpzT7OB8jzsKGb?=
 =?us-ascii?Q?Qf3/JwaocT1LgCu0m2ACSldPynbjDbAXagFQYkVqLXxzZFHgOCjY6GXR/4xR?=
 =?us-ascii?Q?AKz1lc22dTyCVftEFYc6e0xG9QkG/zMKIuyBIEw8o/f93rVqHHJkL8JOGfVD?=
 =?us-ascii?Q?JrCNM2tGdyv4Mu5PUS7bS9rUAD28W1p7j+BE5mA1H4EDe3op/BJyXsncn/i5?=
 =?us-ascii?Q?5FunlNBzZ40R6+IJIRkfsok0FXF9t/dLJYCl9eW9vs75vNQaT+1dRGhMNSKy?=
 =?us-ascii?Q?mqNtWZabmRCGSm51W4kEqetlso0k0hzqZz04Bc7zMwUXMp7OVbCW5ScYfVF8?=
 =?us-ascii?Q?YaXGMX1QiAcouIC4bRC0MShFgUp0pqnck+1HH/pMfksljuwITrDolrWx/CJM?=
 =?us-ascii?Q?+Tg/n6W/S1TVNdpWAHJwZUAtre9ajOSVq8BOk8DDqk9R18Fk2bsdk9t9KLLk?=
 =?us-ascii?Q?CKlEo3APnHosyHdSlWBAlxgQt0tQcR4U+8z/AK4OBFlR5tOwAHmKn2haJsaz?=
 =?us-ascii?Q?QGqFhozqK4MjJcSz9i+ijvRicl9wFRpAMbBLX5PYRDXmOzcd5FIRSjDrGZbP?=
 =?us-ascii?Q?Fe28vwvi3IZL7Q+RC8kqzOEEIVxcJO2HFVjS3+Sr5Sbna+r40m2b0ryqb119?=
 =?us-ascii?Q?ycU8Y0Jex+0+J1GsvTyDdph3aIxEh9pvJJF3JwHWzqH4cxHDrymkZCpBEk89?=
 =?us-ascii?Q?dQmB1RqJj0J4Nb6sE29Fg6Ys1Px3fl059PdXwilnSpO2u5O0TrSsVd9lHzGY?=
 =?us-ascii?Q?Ymf9DnHhWrcGb1pE87AH39Il+BlTxmrnD5KNi27WHtC6AszP4hpViGh32Xdh?=
 =?us-ascii?Q?h9ogJxB6fnE+k56QZC5VszpyUsODlE+HDlgwuga+i4DsodW8BfWqu+PgWJQQ?=
 =?us-ascii?Q?zv235nC6oVEUJBCIquJDpf+kGR6Kig7CFBqeIhJVJD9kZv3YEQFCd4aTs+WK?=
 =?us-ascii?Q?C3B7Si5XEnETKdj3rqF1+M4/FEuSSjxmIM821rw+OY1abUXQ+qydim9z3HTa?=
 =?us-ascii?Q?5BmgblEqCbiFwrMLG+rKE6iZYVls9O+dGMH0tXY4kO2dcZbCLJZnpce2cYZX?=
 =?us-ascii?Q?1ikjCOzqPtrAb01lftxNiZLh1zXp2mQoHZTI78tnSAtZp/CgZ0pljloxJgHk?=
 =?us-ascii?Q?FXZnBWAksEwsuvkHXsO40Uv3TW6SRhovy34rTqulmCyJD85//owU2hPpGd0w?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b8968-a42e-48c7-9700-08dbcbafc39b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:36.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuanU21GFf2QppSCrzOCsejOG+oTsH1bLNeMSU+deJta6PA/gNfJnljGXcYfb9QYa/FwHdesEA1fYvKKZ4HIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dcb8464a5f65..5d2015f16028 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3531,6 +3531,33 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm send RM_ADDR for ID 0
+	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
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
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		wait_rm_addr $ns2 1
+		# we don't look at the counter linked to the subflows that
+		# have been removed but to the one linked to the RM_ADDR
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

