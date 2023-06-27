Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7187FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQdWt9nAnGgHNmr4ouiSk/14ho4b/hG7OaSZV2kVLASruuQjFAEsgm1nCmypWzbAoS8Pd9EcklJ4AuOXPHndJ9/AgU7iVdqbr3YEI4YhZJR+UZa4nJAl8OTqE93t9fVHDyf5Aa1dSP7ZoUOEc+jOO+NF02BgFhsb4sycg8z1KYTbLu2yFPhPEWY1ryR5Td7Yq2xcypRpOk3w2ZCt36V6Z4Rmcd0bPe5/AdpWyALk7oADSc0kNAcrnMpATPeyEm/KOXv8mx8vMwc2PxJtjRMd4oWT9miel6My05TgsMQCQbBeU0dQQL+3PLXdVSmG/jk2URuOSOKhYaTfIVq0hsZz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8w6Fy11ZLX5izmI9cYU+HhaQ515N2DxkYc7IdRsYXo=;
 b=aUaiDuKXdB6iPnu2I1HfKgkxvL9I0omCXNmOfX0wLJu/yEc5Z4CpJIXIDBN5HdFrOZhtoK9x5soRhIX0z+kyNhTdWvnhlz/XALWeZUOyBUmMfDiOT8XEW81qe/HhVjXcpX6zHvPOIRxQaPKF0JjWKJVtC+7TyPoOPInCw5HV0Zc3ZN1m6/AUH5A5Lp9xK7t8sSMOkNkX6OCGmRx+uop1D14C0RpvhLhdDie9dcrj4/vkXRdf3kgs86mGNZSnpBzkWmFp9DAb3yAhI0cbEiSq65cJqNx+2JzGziSGk5rJibTvVKm0zt8QM/9GJCVcMvd/4y9B6qhts7ZPA81MmFN/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8w6Fy11ZLX5izmI9cYU+HhaQ515N2DxkYc7IdRsYXo=;
 b=c0DByD5TA8MdLnnBlqkL/cUyC4PzMSLAYl4lNYHfhOx8gjfNz1DYCofdiyZlAwHmrvpCaX6sUZKOVE28R5MF0gOJaMRwx19l8bBxmAdIo3+QlsTw06xopT/VYcd86Wfi46/V2TIun98XBZjiLfnt8BDS2Tf+MgKcr3RfC+aQUVA85s3pPia3bLfgRAznCqgsvR5GI8S0L8QSKWBHvlQ3rm8DPixUc93Xp8l+m2oXP3VjAIQmykOoB3FtaaoBgRXI2D3GVJjrYhCAxCQAyERrC+bu4rDWIYPBk6M6/jwjrHWBQPZE/fpELNRnmANS8fwUHQOW+Wg9piiW2dMKes26VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 07/11] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Tue, 27 Jun 2023 09:06:50 +0800
Message-Id: <c6df7a5ea96993dc6aaeb6f419374b6573e3dcf8.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b03845-1329-4ea4-90d1-08db76aaebee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q0KtTus+d4kmj8xIkd0bLuPAmvhS2VXdWJHK2o9EJMRGtcuN9KI1lIOmK//wGrlQljzTw8hngpi5v03JtUul/7bt+NCp458xZdnHjuVeJGaO9xyXSz7yhbX0OPzXmEFwkBdj+ZeZwT/c2Meh7M0RD/+HrVFUuEAD9BKgy+qnKiXTdYf9vllElqZYAT3sswcfVcLpLL1KW2p+dXpOQuQNaEGS5Da8qeO7AtrgSkUVLBaMK2dhVPG3B3HiQ5PzGV55WJs9NwTjaffMKyTc1iO9AtIYx9cAFNfgc/PKNhovsQ9zL2JhiMQaT26SffN379xFhb4tn82zcLiek9s1MgU0tYQv/IskFI1MT3zmahSyte2uTTTp2iXp6PHccE7+/KUnuGI8DOsqIH+dvkLQEDziOgP0QTHqlD9T2ik4WAi6Vih6DO23s8dmCYgpOiomnjLeVjFRy3SR8oyvuVK5yflDqEZdRPIInWh83RYcHtLsRZYRv1XHjtK6aLNs5Ect7IDY7d80/xCswONBMX3SGQcHxvSuU5p9gr0OU4PNPOEPuw9MUljSvq1/oQwy5uHZcdu2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsMbPQ3zS8+EZKEwvePXCTrSCnln0OT+mqO1FJlXViukuTitE6jYx7dpoCSK?=
 =?us-ascii?Q?Vd7/RZ0cFetgA1wCNvVaL0AZ9Rvsgpn0s39PWgTIuvwcDIM2yoOmg0NOrxnc?=
 =?us-ascii?Q?tTLTNqqvg8ZWKMJGdjqWog6RcSEKbNOauwTCRlSIc1EW2Eq1NjuptUudNdhl?=
 =?us-ascii?Q?lqVVg35x9Rqk248XkWs34AaWmTq7Kscs2dqsuARcofj/rgL/KLGMy6wDmMrU?=
 =?us-ascii?Q?8CyCiQg2ApnqozHINvUEEUKaM5Iv6yBCjHoBASVrac+uERIrk1A8KGnfKlT2?=
 =?us-ascii?Q?f/Ql/fmK2M7axyPtZRoat3UNY+8kLKrxnx2QXiFavADm1CvNPUHET8GGUgB3?=
 =?us-ascii?Q?gkqrxgxxewfDfIbjTHr8KGZhrVMC8C8xq1C75WJf7A2A+e9acKUeC6571ujp?=
 =?us-ascii?Q?V1QnWXUJEw8eNmQ3JebbrHupNtGti9k3H3WZP85MUYk7DWHt/Df3Z712IBsk?=
 =?us-ascii?Q?onygUluKUwCW0sAeB0Z5W452dzlIqOQhW9mJI4tcusiiVtfFDy4MdEd2otUc?=
 =?us-ascii?Q?CmTA9X33IxOh1HUEH7CNjCBJde20ioPUqBhjLzi1IFL66wY5pjyh5Gd3DCE+?=
 =?us-ascii?Q?flWI5geF5tek/YEU/B741XojupKOkN5jmEutQSjTo6qWJdO5pJYQkdKPKsfZ?=
 =?us-ascii?Q?oNyfPzZZhhceABNW77uzvJNsK8oK3pGlPMkxA7e2IlGalEZmlaoMy3gp+q68?=
 =?us-ascii?Q?7Oedy+kPd/5K9lKdB9Pue489kUHyEQtseZRRZ9gWEMcVxLIABknDFZ2unB5y?=
 =?us-ascii?Q?kvRZaTZPJKZ5hrjS5ZHsG7AjexjsxRmxNvyRNP3/LhdyMzrT/7lM6HX36g9t?=
 =?us-ascii?Q?7hOaZ+eyNychTMzexzD71UX0yNbsDeeaaR/eFcoCaq8WkYBvh1j9sJQq7P39?=
 =?us-ascii?Q?xCaAdSaiYrd4uEq4oB/tM7+pm3+s3ZCHpmqi8TUkyLZQ46QM5C/SgxuljUGw?=
 =?us-ascii?Q?HOL1fqEaomdR/BeFRcaSkPz8KNmBww41CUkmkZVDbZFylfIzwDaGhpRVpXPs?=
 =?us-ascii?Q?j7xI3mBn7cq6XuRNfJ/iyOwv/kLh2pDyy3NspsMTvQKknLysHl32OoLnUFHf?=
 =?us-ascii?Q?MNuvP0BsJ6BUQ/b2ZuhLrSEveF2WVFx/ZCUgUc78t00B+lXWv/aWJ96kx4am?=
 =?us-ascii?Q?IU5SbDSMUC67dGHPKFtwEVv1Dm35JiQ3ADzoZmQVAKtpAZ/no9DONHIERPyT?=
 =?us-ascii?Q?OnKk6ruB6QxbC/Yn4FqiAoZNATBK5q+fwFkKHfusJQ5lxSuaTMQrqOscu3XM?=
 =?us-ascii?Q?71uhH0/j6Q8m0vIO9Gp16uonSSRYWdswe0bSrOpr/vSFkJICZoLlYt0VP+4y?=
 =?us-ascii?Q?khg5OrXXoJ78namHPnsL+xLiDkNoc0dBE6jfoY1NXOA94/BFXftI9JorBrqe?=
 =?us-ascii?Q?67WfjjQ7i9K4cX7fJXsjkm8zLbUdJ4vFZHgCSVoxXfghjJqLuWW5tIK3jOAK?=
 =?us-ascii?Q?tqcuMj1myhLfNX7j3U9UoR2qMNowWmcP3RFZY3mIXs3fpj/VvbxDxcceUuH3?=
 =?us-ascii?Q?V/y3niXyuUr0m2cd4QrVqb+qh3NZBzCukoCIncarXSRi/cD4wDxRfqJTNOUM?=
 =?us-ascii?Q?jMzXirt+gFY6mTFHTVgh9QTUOW3E/T8bPIvGjbic?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b03845-1329-4ea4-90d1-08db76aaebee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:47.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc/+7W0Kpuh2RIuOanlpJH//Ep8sDfJaNOKRiAKQBMEb4G8o5+fsIpWFFFJ/uyHz+7HhE2/iL6bWy7KbM5dyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Update scheduler API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..b4b766c7a68f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -240,19 +240,19 @@ struct mptcp_subflow_context {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	__u8	subflows;
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
 
-	void (*init)(const struct mptcp_sock *msk);
-	void (*release)(const struct mptcp_sock *msk);
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
 
-	void (*data_init)(const struct mptcp_sock *msk,
+	void (*data_init)(struct mptcp_sock *msk,
 			  struct mptcp_sched_data *data);
-	int (*get_subflow)(const struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_subflow)(struct mptcp_sock *msk,
+			   const struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -269,5 +269,7 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
+extern struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
 #endif
-- 
2.35.3

