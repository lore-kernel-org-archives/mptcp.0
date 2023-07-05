Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E10FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk2am+XQce/oFu/HvTulWnkmg/q25yFrYEEhSqHd5MAnSWhawWCFB35vsQKc7LUw0kYBBBpu9siNXQA0tuFLm8XFYa0dxSEhO7kLW66VbI8KD5QvvwSvABgO7RQdCKvcVu79MnAET80CXhbzsa/bF+130NfcqUWQZMUxcpf9nCqPuch88eiq9KE7bxaLFvCa+U4UEabD8C1a4OboDgDVQV+25Bq+6QAN3Qjje83HIngYcozpTGqAWd7OoEBIMNk8H69lnllJ8aSGOcNRWC3vjnrmJ5+9KnrDdjHojkQ8nw+thtF3sVYrIpNYIQ6qQGZlj5tD7V4X+D1WNqYFtIRiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=I4Ed0KDHel5XufJPl+FgK059ojcMupoox8sfsXKMB/W2Tjo6hh/Mk/EVzatRe+r1zEE97uZrtGT8/EtomroWYSOyBB4k3N+Eh4JVxP7dXSALzDs44lVpcfEssRutvm6KPol7B7Rbj+plqwqEvrx5Egr3PfzSy5lLIAQMaUYWSscEMmtK3/bpunkk5yFGJUqLv2HXnI3ZGFhW9AKS0ubL9PT9okN0MVysA9ohPNJqTPNQAQjtXwBCw16jL1fpDxTWk9jw30jOMxJuGiWu9zTVV9I7ad/zstIvikRqS3M9mPVz3ThdRvyBaflzFGSMQwflfm/BW/ZUbiaf5IYbLihzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=pjq8pRk4B/OUHqHmoFxy8m0WhxYz/vc+QD2SomtBQIU4oxxIhGpP/vrN6cOcpgEuWnYtnk5XqhG+9FQDjGI7/6Gnf9eBhvoNvBuRhDfx1pcF+zZci1UbHZcJrL34I0WAJ1BpbQUhFMIPEFjZL2kVXiPF272MYG7O/3qEZrWZp04Au38vjXnA/+wil8RaZ1qi8Uls4A2DMuCTxcD0jW0BZA62O21wgSHPqZclnI+JDECW4hDPsOQyXrl8lOuJD1kMoDCK/eccyH2NT/w4QTx4jTje2FNeJ4/Dx3wVggqYebk11Euvd0aXzjBmJEzLdVBfVZWpxYC3KIeoySoLOe212g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:57:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/7] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Wed,  5 Jul 2023 14:56:40 +0800
Message-Id: <46dcc7443cf6f73bb777e40e5c93dea803c9e48e.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3509a3-1099-4836-b6d4-08db7d252197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rnzXlk2yN+QUC/1cODG9vLHvKIN+RTZokuX6f4obOjfaiF+dTKADvlxmEZXrqyUl9AZigtqFWH1Fqegoi909eB4YtdNwG1dNUYTZVQYL9H7YpWEmV/raCw2Sp5F37hdoVdvn5+Nl0Q/CdSGvVu5cFOIo7B4dJIOHAjiFKzo9668QWbJhQEyXRwotVUUGxvwXxyfz0NXzR3QyfVzhGfD9HV0TqSlp2Xp3cxXIjkHqgXSsYpvuwRuVSdIiZxTiBJWTDRssvBM7ImT+QONuAHdjmOdChkcW6crBgpKNmIr0C8J7wo9DmU8afmrIAJnKG5magxQUGCz40t1Ff+8Ejk5M8XcH44ndATLEvHp5bgZkmvOmmEwH93R0z6ZaGC6WVfMF8n+S712/j4ROQSKLC2vJP9zV0hMQn/23lPABKBOKJ6nqpfVvzfpKovTLS5DtSqRK1h03wUpcM/6rHnUJrI1tlhP3/deePSIgmuaVQpihrEDDYPZhwlQTzcmeTUNb1fBOzngDgdTT5oxVkZKCbQQpT0a9VOgwizhzwtCCaQyP6iZ9VyQXaqnT4duSXhUXtIoWONO9Nlk8hZngIxDUNr8t7pHGd2m/XbKw+NmJSGPAqt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(2616005)(4326008)(38100700002)(66946007)(66556008)(66476007)(6916009)(186003)(86362001)(36756003)(6486002)(6512007)(478600001)(6506007)(26005)(107886003)(8936002)(8676002)(44832011)(5660300002)(316002)(2906002)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oX+ox1BZgtgxECV6S0zhEYOAYVsYmSHnWvLoP7FML6CRRykybGIKY6deNI+?=
 =?us-ascii?Q?4Y9Se54M6+EqBb69hzXB3xzOpTxYUotsuxAkX3uxhDX6KO63QWvpBTIo/csP?=
 =?us-ascii?Q?Skn9s11gtADkBLM152NK7KqqA+XPW+qgD5gdSTg07Iv6ZcsPuuWJJyY2x3B+?=
 =?us-ascii?Q?rqWV/ve1b3Mtv8jzkMkKu1SW2ikZOjk97WlCrew+ERba8xwNwMDA5r2/NlW+?=
 =?us-ascii?Q?2F0IcFhvpq4UtreYcg2prqSc9+rPYQMMEma5Z7Iz9ljGLJbdRIwhINRzyVmz?=
 =?us-ascii?Q?EUIdBWp0vFj9dAepT9aXVz+Uv/wJqIUaMz/0zar6JnbayFJ0HhyjRKUUvihn?=
 =?us-ascii?Q?dfNDgSRqzuMAs1XRlYWa7T7K5Y3zCCFgPiMYkAs0BenGRcdELn6j82/yMZ7N?=
 =?us-ascii?Q?gQ9Fnmf4XNrx3utiBJ3APJIULKKFNgBjM8Y/bzMDBS+qhFtdRFJBJ+4lCynJ?=
 =?us-ascii?Q?HbyILroVQyoupH2DIWgDr6z3pIZLTEzE17O1GhnyadVNXBS0EieKmvGPF7VU?=
 =?us-ascii?Q?ji+S61YmebHZm8FwlhiaciwpIF0yDFg57KhQRD40R5qNGm7T67aC7I8nmrYT?=
 =?us-ascii?Q?ZlAnm2vWuiEcweAfQmgYIUrUnG/GXEQ6kUQ/N0aX6TPXbjWx3X1L4wt+ZUnP?=
 =?us-ascii?Q?EZsdC1AkupvM34K8vUVDMbh4aUMZjwXhSrcnIHkCSPtuhrQMNel0N3XwuBrZ?=
 =?us-ascii?Q?bYAyD2D0J4c4iO/TSWpGx6ZpABNK77aBZZGQAR2Nkv5lzXoK6d0N6jzunS0I?=
 =?us-ascii?Q?TP5ZySwsfReuD7bvCycXjuAclEpaXvi4tutx76VhfTtjfaCdk+qhqlRrKOKc?=
 =?us-ascii?Q?yrP+p34V16VLsTPp5/MniPIpOdDHtoITXBb/riNEogC1kj1ArhwJ534lXrI6?=
 =?us-ascii?Q?k0V797DAqtLeYwfF4XiDIY/e1g5MJzVDXScgmVqRSoqZHI3TqLA0Ffetfksd?=
 =?us-ascii?Q?sliBz+jQx+ZKx+qUFkTxVihK5rCOXq81nh0qX+5oD6kU0Kw01Mi5aDEyWAVh?=
 =?us-ascii?Q?5bHGz4Wmpzdfo0Emp2YugM6NziLooqT/Be1DhUSf5c3HxyHZTnwUybIPa0UA?=
 =?us-ascii?Q?6Yodn4RxkkAZ6KPaYJ3g7KlaMhO915CuCpl668svOF7nifJb2jP/bxDmCpaK?=
 =?us-ascii?Q?lo55KlLEvfg2TDFelTD+vK6jE30IqmObGCtS952lgp6l5T7xMB+28pRFMLCN?=
 =?us-ascii?Q?kKIWAoHVInxcilee5TBqdPvAh4wob3lMY3q00X7lQb+61Y2gZCmt2O71nhi1?=
 =?us-ascii?Q?Chrw6SyYELE5Xpm71Rj0RiASrsug5jx4CxtiE7CA1oVYwZFlrHjC4J7rHwgE?=
 =?us-ascii?Q?A0k6w53FHGXqlKC40zvCERnhJUZsb/fUkYo+myGGlzC47fx44rxoZZ2l/sKR?=
 =?us-ascii?Q?4IQwTI2YyMzsxnJiWkukHPfVpiLK3GPnWQy5QFS1fZGHfYlkWc3S1Ae5oTmQ?=
 =?us-ascii?Q?CZb8Khxlnw4jbxHXgXS7E0RaW7aYGXjpl7wzg7eGVlhsfNJPelFab2/gE3sd?=
 =?us-ascii?Q?RJMo/M7U42n4GO5r/cS7JH3ICkS54sg6kwe9kkEEWtLngualtBl4x4RfzaTq?=
 =?us-ascii?Q?eh9JWG283QCs04o5y51kzeFVWHc6taStJOKs36mX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3509a3-1099-4836-b6d4-08db7d252197
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:43.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmJkokWRt5Wq2pVLAVwGUH950bHFCKZGdWmoPX1/w2AY0Eq0ly2AOyBmdKZuNEg+MTM//BOODR1xGx/fclHs6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

Move the helpers to the beginning.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..e430bebebcf0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -26,6 +26,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -142,26 +162,6 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
-static struct nstoken *create_netns(void)
-{
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
-}
-
-static void cleanup_netns(struct nstoken *nstoken)
-{
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
-}
-
 static void test_base(void)
 {
 	struct nstoken *nstoken = NULL;
-- 
2.35.3

