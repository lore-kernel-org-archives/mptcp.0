Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202141FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k42iFdJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ant3+pqpIPn7C/SIZS1FjLkk/AxRQt/Fq26TWZFOWwbamGYgGBm0nSO5UtB+VrgjOTVc6oRvff0UTDd8lNvsgUfgfpEWUGX6qZOvK53mpNcuSZKspfZLtqTlaj5U08Gea/Z9qrdTQkbSb+kVvR5E6vRLiiSxUCY6vkySr0daDxWr4LFxZq3RFoQYccephMJw8ej4mETVvId6v4Pdd+2omKDYr82e9YjG5OQbnYyEgjCm6vxl2s0qUAL/0X5WTK/b+FiDWiqz/TaR/yu415Vcg2F+FLFX2l485IT18S/Ve4gKFaTOiYUi2LlE2uH8fMTqeLZKm50lJaTrLwsh6NUWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePPCKbrvcYO71HNeRwZE6CAy/2FxyDSgm8y5jFpi/dU=;
 b=TlAWeXgm00ICPZ3gWcel/Jvr+rQI10ly6Wy+12QdxsQMQUbRBALSwMtb7bnmz0vDS5ImFXDhk9C9IH2ptihbGy8jfuHkOsAUVqlwbXpPLcbEC3batWFyI2DBTxXwiP64T2k1BaRfp4AKF9yDBOhXlYTeeb6iow+Ok88V+IxRCCtYClIhDsxGkJz34kvoUSvahOAoOQM5nC3a1vIamryN+QM2vwp6LwEPRAvkYAHoJEgv/O3nz+MEALFoh/g/DskZjh9aZL86aVyr6paje+BtGf7JA+XybOrqaDCzLQlJ/Xg+ziD7Cy331BhOgB3wm7lVNO7kGCcGKIvCUCjEDIMoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePPCKbrvcYO71HNeRwZE6CAy/2FxyDSgm8y5jFpi/dU=;
 b=k42iFdJz3XkfE2QChl78BgVQkrhIZqIVTreS6Lk0lGR2VSNDHd5sW8swk2ozeL/cPF/pO+kTJ+esOyZHPRk/+PK5607J+EkHfs1uBR+PdkD/iGey5ckZWlPqHzD2vh9N/GTJSTRjDcULnvjOpz7mOnKFlkHIaG0stl464J1VRuXXyByq+0g8OMX3OYD0nbE8oyKrfUYtr7Bd3pfAtsyWTL30bR1NSG1yC3GywR8nkg/6OYUAuUE+35ZyYYef5p+UBnfTr/7YXyEteQ+2DStk8i9WWm9IeYPkTRcp2sRvg/gTYHCYdLIN8mcJaAk62hr5YxtZ/56rphyqUvi5yJYLqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 08/21] mptcp: dump userspace pm addrs
Date: Tue,  7 Nov 2023 14:01:52 +0800
Message-Id: <07b0de0955e26e58ade8772ab58536c8783aea8d.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dd3a4f-f214-4ee2-4dff-08dbdf5731a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RmbeNKxDYiIcPWoQJp1C+uR+ltVr549j41kYcMijs9Oq1Qj+XVozvuV8RaKO3cEuc2457d+cPdA/yDFy3D0WJ+U1XCZqu7As4PtAZSBfocKs+V4iiIDbAWtxnpOEUmx6FiThNSiEsWJusSacXBqWmREfJoa4H9W8ZQ75mAwZxaVbsheo9NTov7DCPK7Yb5ojzfV5HaXVGd2Ed83vjI7i73Q5xQp0WbZZQxL9RHjZqUTXcfKs9tDSz9LHTJA+qQwiT59l8GvObyHnvVUKq8pAihHmFdz6RgZ0o1yw7ruU7cW5v/vGJT7y5YqWg/aJHql+ZOoyx6f9xc626IRUaj4H4RaIeBeuIdhxquL8OwtmengJPp+u29/DGDeumtCdx57xQ89+pPISLlDQsPxy1W9JUZZCZi2EnVKFYkYb6eImhoC7H2B+QtbHGaJ+TAnXC++9vIahPp55hg/HscmntcQbJgc+c579Talm3o65eug/RYToQdNAT3LM+2hi+KMfY+ADzc8vKGuYFGAYTTjtd2WlniOyUaIsFZVmRQKn6uMoG7YnA1Pmr8d2AuIsdYHJtjls
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pnJ0482WGjLuAH4fvckXz8gwzLMWkTR1pH010zwGJgNIQA5GpGeU0K7haSqB?=
 =?us-ascii?Q?J/10M+zvgzgEfuh0pduC/fnYhlv5cydwfLqdeDVZr3tTFY1MT2L6ZvEq7qDS?=
 =?us-ascii?Q?WeJ6UibfoiD5pqu+BPgcCAf1Llequq+2us9GcktgWMEw16TccXG9HxOUuGcv?=
 =?us-ascii?Q?MYN4KO8A+VzF4B1GZxtBBHTIgWxjEgi9LKl9oUSXaL6LsNfUKcFV2oqxcpzD?=
 =?us-ascii?Q?yHdc+4ylQZIin7Oi18aIfEYHuqUPb4IjdgisSusuKEzEB4/lXAk0ho9Nh96t?=
 =?us-ascii?Q?Y7yN6AVjJ5J/csM7vQKDcoocQwduqWNKqVoC7YG0RPph49/PccOodqQ749Vn?=
 =?us-ascii?Q?z/AAKw02mtg+oopwLHOMzW/0zA9AYy0mfLLEY5hyldnmkI3uXAtyh47U+wkk?=
 =?us-ascii?Q?WkzHQ03iPbZKPmgr05zJVgSqfgY84iOyJO3NsUSE6pft3NzkVLjklznmyfxq?=
 =?us-ascii?Q?F3S4+4Hrvu9rl4FQsPeVpJ/GzqtDEcTXOqLlsH5BVmqWzY0hgMUQmliQakCA?=
 =?us-ascii?Q?hyvHh7ujmHxr2hYEiaDKR5bYFUqFFQewo1O98/EBqx7pzE9RKUGpnGeEhQR7?=
 =?us-ascii?Q?2jrwso22RksjuNRBlhSYBPGwZPCb7LUDZuIISPBCwzzS8CGCUUrunPDrytRX?=
 =?us-ascii?Q?2l4ZQ1kRpjTBpFoissVhh4jpCwlk03wimSdtpZyNwdsu1CbGBvN08HBLzr2V?=
 =?us-ascii?Q?VlDhKJslZeonTMJ/3XF/dz1AOaoC9Xw3W5g+J4oFrKu4JM2zOkYE9sO9t9BH?=
 =?us-ascii?Q?Ck425GNZ3EydaHnsPCnV6XO+9eM06V1kazHkJC9qfO/3l5uXVMOfvOnSK0w1?=
 =?us-ascii?Q?kzAmmpx0mrAarrEcxjTBmirC8Hu5AgBdoryp0C5S4Q6YOlHvldtb7ELeoRI5?=
 =?us-ascii?Q?DpZNnCMDlKw0qREJsG13bmkR3/ZzJPupR0Nxw28W7pGqWVvAQWyIFhIIwXpS?=
 =?us-ascii?Q?VDIHViAxHeUPrPXActWbsaIy9H80Hpc29/Yc09mhU2OA7dENldFw3w1IMQ1m?=
 =?us-ascii?Q?1mAvMxqmzeF5tUO9yCMYYshgm2nKpkLc6RUMWA6/9nZqubyq553jlXpHJUel?=
 =?us-ascii?Q?swT6/PUMYxEiydm7Go/1REzyViGXR7DuqTVWhuB95xou/brg3+VyhpwBAe8p?=
 =?us-ascii?Q?lkvWHAbof9F3VnlJ3ei7Wln+jLnYWiUNFKcFQNxQDnOc3yRw77MjJh8vfVWK?=
 =?us-ascii?Q?u3ArskpkwKb6SOskLrfVoEQU5d/dOTK4aDoTSH5FrhomAw7t+iPN19fnQOSY?=
 =?us-ascii?Q?QWh0pmO3DYzF0/bvQwm+aO0r1SrFHLGdrxaSKCr2SAsXjSQFi1qLBjhRNJTo?=
 =?us-ascii?Q?IxwMBO+Om2fgB0rjkDkkd+dQ84UlOfn0jiJNyUj1tGIArTkkacPRHeBSwSN2?=
 =?us-ascii?Q?dU5/7qVS2G2x8LE9M8z93b8RdLkBaA0A6jCFeres0jixeCWquTFJ1Ll5fSjj?=
 =?us-ascii?Q?OyB2ySUgACmxwvtWw4ExU20TeBM47dO+HjPHOPGHZ3IysoCYuHfNaRdvja8+?=
 =?us-ascii?Q?zQoJc220i4+kfq9ldvBi0DB2Yhsb2tZtNd/978SMXYleMz0eH0RYKQUMHRak?=
 =?us-ascii?Q?fNUrMywImq8j+bLBb5rKAcn7kzxxcXI17cAofVZA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dd3a4f-f214-4ee2-4dff-08dbdf5731a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:59.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9uftiLvXv2xv4XMaVZvnVa00J5BBTPGVD2r7hwBrsRek/VP9uWLdfBRgUiix5s4KLFrsFCPBTtOnUk915UgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d42b62cc3f6..b7e4c8d21078 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1675,8 +1675,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 73d16c8006d1..bd491b78171c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -574,3 +574,28 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
 		cond_resched();
 	}
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 54f96e7f7603..089fbebd21d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

