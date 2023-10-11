Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132B1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gG47uTL0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl+KCFvAGUFZ9HX1lVYYQlz55l8qGRcU2Cca+o3w41gWuC58XZd/kZNnbDzxQhNV/mhfpz7c+OJmWzMjD2Es60055Imwb5qMXS0dyC4FVmIimHZ7tPuqXgyYzykfSD5G5PBoXUx4YhWCkjpZrRL3FSmp69+LGyOWAD8IlWD51WFKUaLaVVVYpmUa5QmmC4UxM1Agpdgg9vE2GWUIcpX2xxH5gUL4qgzmqerYLfvs/fqlwFlaudSBnHYp4S9f9MGhszw8OoCKMvjhmhuQpiKDTLMYtUBHn62PVR8fN+hFdFDc9vZRuk4hHgQKYIM746FzR/nV8RPP/ceomFLSqti3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NpE5dDY1/HQeGrg93X0kLK37iM3BvBi6DRIt+GR8c4=;
 b=Ig1exeLWFYJ4fuv8Q6PkR0sP2S0nrmu0BAKGgw4uujHjsshQSZ6p3D7RVSmq4e+Wh4+EzS7WbiW7IkeO/XfvPYTi2nzX7oEIkpCRzvzrcn2mTo+MHRf+pok94Uied2MG2Uq8tg5WC6t8UQNaepnXeEpspaUpmWdiQbj9womrVX3KRzF+9dEAUOe1NaheL6pL9WcCzum+70f63qO4t4Qw67hGcsQ87XzfzLK//LCM6bePdyESlypRNsD5jdx9J0OFbOokS+BuY876UBs5fWukRL+irzKpGmEW54X2vWnJTmeosQKX+f2nUzQquy+U041sgrcDNuA0+v7gUD/nq2gz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NpE5dDY1/HQeGrg93X0kLK37iM3BvBi6DRIt+GR8c4=;
 b=gG47uTL0VNzOEVdifmJYNi8HeDMYaGZ+XDDXe+nriaOt9OT54usXSdfdAXRNNL711McklSxGyUUiEprWgMHggLSUzC6Xy5iDRRbfSUUV3zC23PDBIbYg2liGu4jYx6lXtiUY0hKDRjL14yIXEiRCkHbYEMzVl/m+iVPjM/k/atO1lK3/Lq1KrFDn7Zvv4ioPbBEHFdedQ0qWdIvHOIFOfGbdDowNXCxcaRHxYeu2yJs+QS2hyHa/ZG8yk9o3W3Y0O5XqqXbhjYVAGo+c+64t+RclMePODzKwAboUHuflEyWaQ+OOC8pdWnL3oGwamuAswwZJ9xKqCrc+DezRt/S3Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Wed, 11 Oct
 2023 13:34:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 7/7] selftests: mptcp: userspace pm send RM_ADDR for ID 0
Date: Wed, 11 Oct 2023 21:35:02 +0800
Message-Id: <d17f1677d7c0b65309c98f48a8b88e909c0558a0.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9377:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e64692-0e5d-418a-7e44-08dbca5edc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y5JrUpgf25x5XCrz/3i/kYXa+X432NW2zDFVx+Px4iIrYy+aBrmFfDnsU4B/DbxDcGD4YZDEV3eZnFhcwpiVS9TsI8/O+uvFKgNqqmHV9S0zeOk0/N2vL9v+4Pz3wcNTptFgTKhDrT8PdMVTjjDIW/mW52UBQIfgcfBFvh5ibou2xP99V32AYqyKXfS1osnm26oHhBGL3iOLU5FLRNBa/TyKRsWF5T5Cplg26avNUIGicCsZB4Cabb45xTs7tcp4nwQrmO7Y/Vx4FY1ZIiJmPW15lj3g9R5lZ5HH5X1gFyKJU1H8Zm1KAW5NCHIP84ZqfxohVhxTkeH9mwq+vPx+CD4XSSNItqGy0wU2a31CkZB1YtrtaMZzc6P2n+6whB/PO5ntLhQ/wKX398kDxFNyCixPjfHUkbqSh8fcA7GbImDppEP6MSmorbBlOCaNTQyMm5waNrantz8197Up+2T40ldes6GYbTCfktdubRJBlH6jQaN+KSfUdHTBvWFFiaOaO1U3OhTIL1w5Nw1Ac7/ktKvzYt5iYNs2xCwIJVVMur2N0egOv/v5KJwMrESWfhOw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(6512007)(66556008)(2616005)(6916009)(6666004)(107886003)(83380400001)(26005)(66476007)(8676002)(66946007)(316002)(41300700001)(5660300002)(4326008)(8936002)(44832011)(6486002)(6506007)(2906002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6692qAo4Ggjg/A7EK/YA76FADGk7c8NQczqUHnxhuMVSy05Q1C8B58dBUtv1?=
 =?us-ascii?Q?egGDyqyxT90lK7sStHT9Hp2hcEgREzHMQn5QuG2ASuOUFUM+/MnfyzlpCwKQ?=
 =?us-ascii?Q?BMIPC3WZeIfp0AYpH4CN398flyljHQnDkWDV88qscyuQlgPrXlFBHK3I3rRL?=
 =?us-ascii?Q?Mwy9W7YNskDMsS8DVSy6hwMa35VHt+IrtB2nHjV2S+MvD1oQ/9haxwF8ZWzN?=
 =?us-ascii?Q?iqSemU8Or69BiJ3KI8eBy2OTdapa65BxpkJP0RQxTGi58Srp5033JCyAJxRz?=
 =?us-ascii?Q?z1B74osgGVajHbnsU2O37cOWUTpeH/J+FFVTott2L5ZorvSqC8SPHc+7SVE5?=
 =?us-ascii?Q?vzB4uqVY5j+mQunHABgo3Fd61Hp78E410mWgmphHjW3RZzeeXEAGsOba/g2G?=
 =?us-ascii?Q?yINjAfPoB6M18xhflwzrpzMJMSyooGxFg8HoOWkkc+9DyuLBZEU5p3HZ5/J4?=
 =?us-ascii?Q?+WwKHjP2LevELVkPETK8z3SOdrXm9BHOXUNN2+V9ae6Qi05PT/G9TSdeZ/2I?=
 =?us-ascii?Q?evJEQiZ4vYAn6dFc+YQu3YNN22CdjQ70mGct2c7vDwJJgH3Ew4LFGARPeEwb?=
 =?us-ascii?Q?xO8PBgmRpO2Wn//0/RgzL3GP/EuI+1EIKmQpcJR9xWqbz7w6GGMVJzJf6RRg?=
 =?us-ascii?Q?2nKWfpfcXKFLv9KMTJ0A7jGdQUrPU9HobLKoulp1PAv+PPsa5HMn+c79R71N?=
 =?us-ascii?Q?Ns0+R8WMlqerCqh13l7VVRefrHyo0S3474gzeFG6ILqzU/4Ho29Ksm34pjjx?=
 =?us-ascii?Q?bcQqLggiEZim4bylf3ml+xY1fr2TwcslQokE6TXnK9SZomApal8XWQjEh83n?=
 =?us-ascii?Q?u3pGYiOjpW/KJfgpKYkIAgjln9gpMxtJmHPwIVc9+bVWJJREe/dijkNAn7JV?=
 =?us-ascii?Q?TZE6Y7k18M7wBnVDf8L2JxTD0tknEQcGYY8EBvqVTOVwtGUfPu2lRVzTIKnU?=
 =?us-ascii?Q?ysH2iD4ZznlRxPX6ygfiSKFdQRudnnGEwk7ndouBp25fNcKuE12DSV83y/Y8?=
 =?us-ascii?Q?cyM1FbaJN2uPXSwWyVgj9uryprxERFfSJHXgUEcbJiNTviYWRkVuGcdYlkZm?=
 =?us-ascii?Q?DBRxf7pvzpO5dMTsoIKx9n7MUwuyNOKjzvr7JxPwWj7/EGnmv0Taq+4glza6?=
 =?us-ascii?Q?g9myQWZX4lu2qRM6rMMBUsZoYN1BF31/Um5ZHpGYx6N1TGrc3vME4a3rzfgt?=
 =?us-ascii?Q?Qr9bULz8/810alOTmgWSCrlgWnrybVCD1mzvf0+uyQGFDjwyg3CKNgKWWLX4?=
 =?us-ascii?Q?voj46n1cWqTnA4//7IBSoDRIlPuYkEZubhruAnOeDij4/4ckxOI5htTJP9sk?=
 =?us-ascii?Q?K6q7yL5JP0pA3wBE7hu+Xh6PUDe2mKcTM88ENLsUJzj+lhCkZ15dn6eLFMdJ?=
 =?us-ascii?Q?jmLCsKlW43NH59cdSyemL0c9mpxyc3MzwlBUjGd3yGE8nSCai75XMXkSYx0K?=
 =?us-ascii?Q?dqVOQDSxZtRwPNCsCCgvQpcnScVffYTYX5lO5kOB1sc+l5WdzX9lJLwNA/fG?=
 =?us-ascii?Q?21m/Ashj2qHw+ywN+EF/6YDWNYDGHS2+YJQurvk/SzWEWSQ2vaGmoFO0wabu?=
 =?us-ascii?Q?OM9rgE7tRj3gpUdeR2h83Ud7gI/XoeoLVfcdRe9c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e64692-0e5d-418a-7e44-08dbca5edc7e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:57.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDAk6tE8ROqcjnoUmAUwrc8vKv9DJMxZgb72sdWN2Hb/Cw+DWNOjEOSAbGSXE9SmnBt9M3yRD5mFEGZV8NCTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9377

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e1304383057c..2233b24687cf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3529,6 +3529,31 @@ userspace_tests()
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
+		sleep 0.5
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

