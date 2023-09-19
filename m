Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486634CC3
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjrc2w1KFcN7qDSgvszCwZnYXfhqA7L/XV9zAPXaseBObaVSezFnt+y57Af6xaIswMg9wNF17+W96/jBBT0wyOyTiqaJIxV0u59qPTVmbyZQzxGe+YvtogXwJgB8NjwqDgFuB41leYAnGRrZC1U8atSt6GekaflesJLBVIsZpqDCm7NlpghDP/FivybJEz+lBcM5Z55Kk8bA0MQA+kFtQPkBqtciC5dOBUPUHP5Bb5uWpo0BYxUWfb62oN/4w8mDUCHX0wHmLGTU5I8QMTeQr+d6or2R3wet+bJIqyLoRiEX/fx07f4iCceTdf0Zx1ognrfqhKXs3XrGZ/qHd2gubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdapZy3VHL8/rSV9ddO6iLmmZB/ipwSsYOncBeSeRu0=;
 b=YcEJXVxXkcjvfSmnrLi1/NXwBmROmGpYjHz0adlO5iFmhfrXCWPFE5mU/cdpr6Er12wnujie9rN4Go4sSPWn6Kdf7DXIBwLUa1fpxxfV/QRE9tbDlY3FMSvMva2olUG4OZOnG3pIbxgAD0VlfKZukqacyxOciP9t+HZMnu0GtoekW1ABow3ROnwBbj6YxE7WKcHdYiNR8FBVMmKfiUAWR8qAq1700rFv+0YCgA0Ksms+UanMcOERR4Q6hLUBLtem2+b8wNeR/9uHmyKOESCLZJFsWjdu5qL9czae5mirpBtsFOBui6P1g/aFSp9cKUQP3v7wbXVwaGhqhy5sBZviOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdapZy3VHL8/rSV9ddO6iLmmZB/ipwSsYOncBeSeRu0=;
 b=vay5VGhC+CktXw9Q+ZHYLCnI/AWZR8W69CCOAR840A1hAJK7hnkb4vyXbsBFPd0EjwHa2aDsZsH79RBJ5AJnhqIBxySkULnwIuSG0pZHrdnyDad5WffRAGsIEzMRW3N/US4zbEp0GYMASIc/YupfjYnr257psyvac3u6Jj2CUq7M2kdQipAv7Wc8Q1V7J6K+cASLI5qxsovnOPTanCbmFd4fvsyW2+hi7jrRhIpOsUBRWTps1DXqIFADKCEjRIpd5+8W/7TuWaq8ExOWA9SHAZPyT3uV1uYr5PzaBk404S4ElOcjVDD0WJchDeERfZHgm4lif9uVG6xxiKEz8DUsbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/30] mptcp: move sk assignment statement ahead
Date: Tue, 19 Sep 2023 12:02:06 +0800
Message-Id: <e959428e38d2948e0ae51fd354979e7ff04151bd.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb85f23-f385-4ea1-a10e-08dbb8c540f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lb1hdQtvzijWKj01vdHChUKW2IkdJ9nfF69hsj+f7eRvZNxFEhHnX3+IWARYwc5xWnbfkDOz3IwTxMbkLAOU5kfFcnlzWMf9+yTiy2cFw0uDVlwvQxLyZ0BuiSX8gww15R2Y0gCf3PEgzF5uRDFXaS93dIEg4VVn1fED17PhqfawNiX+w1M+H2w88VME4vtn0eEJ3LzXUAtrv79Ck7CoWTOUKPU+flzOwb063xUN6xyJGM4BM85T2TS+uJ6Be1Nu0j5UmnCjriFn4o1GAwXoXpZl3blW0zvXmOqvqXIsEVjJpUkkQHmSSc/U0KEr5pJjLkDBV9mzRWLdfk6tjziNqSNMWm0hyfHbdva64w7RoNG0matIEmSC2S7yh+L0auKBT76UQO44n21uwxtPmj2Xattraq4C3dFiB1Ut/irV7VNrCQo1JNCsMkAYlbn8WDVyx2g1u5KYo2flYMDOSWW1WuqCZ1Zs3tmgYVfSpiNSTm3FwXTD7SsLUaZ3XYETIbWt+sNba7ZnFbUMhTjbDQIFxn187rKQ8sILTPvSMW2Pg+OpnOJYXncBGlrk+Xwbr6coPtBiYaWDii5fZ32Bt+1R2nkobHxKAJBlZpOWxXna1Us=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWBtD2h0xjgbnvLva4LRyRBJPGU7lU2XdoWGIn4MfUeKqBFy+zVhJ9xQrLCm?=
 =?us-ascii?Q?1GxRESkCWojurPWmSpnxIoKWyRQZPZcSZibPbu2y5SkoQssgLOLaJbd3+9X5?=
 =?us-ascii?Q?8l1x/a4D5X8r/3AZvxvlIXXA757SPw6yuyRPZQiT0Ie5i3Vav8/VDLlm5Ojk?=
 =?us-ascii?Q?uDvQ/gfJ8TvHKkcwJCA1LvWozf6QZQPA7HYoPC/JM+p2F1X+gKthhCz9F0y4?=
 =?us-ascii?Q?95amiZpsyUK3V9X4YSgWND3FwNuBrVMlHfH4XTa9whTcxJg86pfb8YFNQY0q?=
 =?us-ascii?Q?kAJk52fwfhCosBMgo4DPvxxy29NazPkbH1ujByr8vCpIazEEqp+giBwjBb1t?=
 =?us-ascii?Q?59gc4LW1YJgJY/ohB1+iz6fbkp8aGAPyPEjLCGQw7AWYlVKeadEOrfh8IWj2?=
 =?us-ascii?Q?8U2VmRulcRwiw/Pz2zinSA6ukyIBcQX19hhCKqfps8E3jP4OnBGagtssTMuz?=
 =?us-ascii?Q?8nH2d3tw8IGIDEnDsjk0M5Oqd3kjvdJI5qOoTO+BMnb43BPSake4NtumgH96?=
 =?us-ascii?Q?QcHgZkIXRaVJ9rziPEUra2oUkPvgPA93LMZTnDN395ubHQr4UDpN7xg/SjXk?=
 =?us-ascii?Q?zLRoHT1rAft9gT2QjSKVZqnGwJbcQHOqTOuRliJXR/Xtk6o6mKHoRwvpdED/?=
 =?us-ascii?Q?hkedtdZTt5GZJ8oVRCahTewegY0K59t6H1YLjyeKJC89rAS6RfKrN0Ine5VT?=
 =?us-ascii?Q?xz1d2FiaBByQIfT2Yma7/Kr0XRgNrFjLECygIyN76kjUAifIdjWGqFV/ej47?=
 =?us-ascii?Q?LybRsuenoZ0CK4/iJs6lwg2Duc/cgAJxlLEHtt9hwRxmg5JilQMOjpvLUh0i?=
 =?us-ascii?Q?6v+qNdrQivO/oVEnV2kI3N4u5S+MhQNFRnz2WyeJfnSAoVlg0gquNzHzbCkD?=
 =?us-ascii?Q?6pdraeSfOkHhYDXOOXEZSbFVNviDKJA/tN5JL3M4bfqHzRdb8n9QD5z6GvoH?=
 =?us-ascii?Q?Xj+6X3r5EtHC5VyuuGzEl7ZAMYegrxU2WLhHAvS6B4chNqn/jtrEuwJGZzrt?=
 =?us-ascii?Q?dwofKt0FJg7lhpl7dKdrNVbfSiTRUcaEtlmxwtILFo+QnsytfmAGwbbjBT7/?=
 =?us-ascii?Q?7CzrA4B1bJLRSnQgdfwhPShW0k2F4moL0mMNIudxx9ng+e5rQfJHNfwUxmMB?=
 =?us-ascii?Q?ca4JgYzibMKvSKUu05qBEEx6hlSCfv/zEA1RKhsR3byKy+IK/0OHXkXukECU?=
 =?us-ascii?Q?WzmsLGPW8YyX9F4BfQ8/eZUpeYerc058W1i0+ukJiCHghkK6corRySECNLaD?=
 =?us-ascii?Q?8klV89qZOEld1mNohwgYJE4Jp4UkmKnqqJrwUWQqUQYGhAg7AK3ERWg3OweJ?=
 =?us-ascii?Q?1v5UfaO+GCWz0DQAYiTH7KKulm/iT/fdXOZqLc8f2G2oRDuydaEWkngLTGfq?=
 =?us-ascii?Q?qXWK46j3f2KAXwO3M5HBeJSRIijFk1wvsi04TqqNl3oa0biRkwXFFe9KLCMw?=
 =?us-ascii?Q?pe1cxznIr6viVQTthYLjTlikgjSUJcqaqk6Ti2WoYQ6wosWAETGX59bmmH+p?=
 =?us-ascii?Q?BxGYZJORM/YmlcnnmDafrm2epz3Nxay755kK2FnrpC3SFiz5gK2unF7cDGTC?=
 =?us-ascii?Q?w98EjlN8uGgiGINfnS+T3E+O5A1y9wgOT5VhHxSm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb85f23-f385-4ea1-a10e-08dbb8c540f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:34.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8wqHyhDyhpChVBgq8iuyCSK3I8CPXZVna4dOlCciLKCfIf9F2UMfJHxr05FQh9MJcLP52Qd9RtsNz+7h3GDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

If we move the sk assignment statement ahead in mptcp_nl_cmd_sf_create()
or mptcp_nl_cmd_sf_destroy(), right after the msk null-check statements,
sk can be used after the create_err or destroy_err labels instead of
open-coding it again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..78b935ab7d3b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -296,6 +296,8 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto create_err;
@@ -319,8 +321,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = (struct sock *)msk;
-
 	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
@@ -348,7 +348,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -425,6 +425,8 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto destroy_err;
@@ -454,7 +456,6 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
@@ -474,7 +475,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 destroy_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.35.3

