Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE117C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz9DIDVLPzBZyC/vYx4ukIQ0M3r9sRHpVbcJ0qPVmv4G3ZpREx9a17JLNKxhmydQ/y/tIHq31cAgzpfrbUEmHmyY//CJou+BweIaaEOOqXvWxqbiXyJUMgxfserRJMUC9noCQhsdFRU7OZH2Pi7yBRggjLWx6AjMzh4a/92dVWyNBhSqQkZa1y3L7tSvWkTedieZVugYBUsfrH2RIQKQUzFSA807EN6N/BqmvSAonJVQ3s9AfTx5S5pSvFUpBdL3sdRi5kaHDDLrV7D1M5RY2EphnD+ICcCij6um9FwmpL1Jn4+xo0/BarGgDOp/gUcYU64ToyPz96k8CPFE+SYCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwajF9lNBsqY7bvbCkMlVPzjyxa5LGUI8Zw9kn7gAm4=;
 b=mUtI5diCwDhrN7RqavdgIAc7XNDknbTR1pSQgZSWT41POOjwWZPXqOUk7llXUS8Gp4XE155GOnTeenYmWv6bcQ0IOsyykHg6YDWmXrYJO5Iv2zZWG0DRTIYvQ8Zf6tOI+HLJqJ4l/yUUQ18ELJp018QshR56aia6xkBbuufmLwssozGHbqgkh5WxOC5bTn+lkUmF5qsfQIUL7/a75q+aN77hQMmjUUnq2tsiZdOzVPSkyu6oFNArBU3/mFpyrmXnJt3O9u/UUK+fj6qdQ/E8xEiOEM7fmxkBsEQib+50idppopy9Wpqt0YoVNNzc0kN0pPhzZmyjP0UgsXNkrFkFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwajF9lNBsqY7bvbCkMlVPzjyxa5LGUI8Zw9kn7gAm4=;
 b=1HR0JNRh2pNyKohNR3CqphEde40d9DMeioXRSGXCXOQEP4pOy5TJSO5Ir6pWhaWUzWdUtLxWM8X33+W5WaHKGJWjNftOxfOft1IwuPoHF/dh0y6eEG9MDBPflj8Ze6kDwGavtW2R1nRIWXB6pw4F87pyf2Zok5S8nWxuXYUYvVHo/Lff1UfoCWfPRDwbIIjpnqyghcQWQiBkgHgknZvF/4gPhAGMCqQvr2Qd7AvT2Z5Eadpn6J/VyFJJ7glGsNNVgAnbSSTafnGA1yy0J/QaGjc+21TdiWfZDcnwb+4iQrhaPwhdrlZ5d0mOrvFleY9HufLQ8Y3IFkNOdLAkh+fYDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:00:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:00:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/7] mptcp: don't clear userspace pm addr id
Date: Tue, 14 Mar 2023 11:01:40 +0800
Message-Id: <c913793939e57514aa7143d70751749961ede71f.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a6cc12-f0d5-4b4f-fe65-08db2438478d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IHhpocPB5FJAo7nn9cv6XolgvudAMqTd3zqNYVJbo7Kt1kYWjcwkouLdb3Ena0uyK31hEHVFxmQ3lHvgAM3FkmTuOMn4u/w0GSXho1FHtdJ1dK//DBOCvqSfD6KWenzQVPxx+LOaNtd+9saJc0mTpI+ldj0ar79LpRDxGVFIiMaZADi0kDVA//WmgB9EeHh1df8dELqmklAtv02Z+5oS+AUueTiknLplIwxSi4+OJlyyjeLDy/S1MAIDBMwiyS3k3BH6om4XibCNsnxAvI8G9eYPzshUlkuzP0xpWsK24q2gcoV+QaM3CzJ87BVt/2cTFLeA2JhCRpDY2MDIMSyq1WdmBgt1tlhByLRSQ1MPmFvXmSuE3eEWEH+qVOPGQesWjjC0W1c/C+sKyz8XSX5ZJx9FB6iZskgHbM5nTgnld9/4elQmFWfsk+Iz/TUx9mV5YoCI2Krf3xs33V5CXsgWSN7XXZaIwoxauuuCZICIkQmEjuM9bjC0ucvE/hOXwA1G1INB3wmvnsmw198izv/WC0k9sIB29J2CZpPI/aQln23DRD7MYugk5UVUCZnf+VeKgzlr1DCALUNRl433Fjrm7y2DLNYvPBjfkphWLmaZidCb/FitnuqJsOa8XNHf4NMK6pslRntOGuacWckrBNehbeBRrvkUjXFefJv7jZIhrbrFrZwFPTQ5MzbMp1bKcY8v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trsaw91QmjAsbWty6ZHbnB0CZEjgDpzs3C90XYTmhHtuZ8tESbfS+WzKTCXr?=
 =?us-ascii?Q?5NBKOsWmzG5QnOZSwWV4aVV9XxeLD9yJF6t5gajIuAJCsyCcqUyyTSDPc4dm?=
 =?us-ascii?Q?J9CzHVqRSWP6IuI66KeZY749cGPcW/C6/8tIhxqU+SG5gajzS7Em7enWmhkc?=
 =?us-ascii?Q?ONBDYNoXabN8isI+9Se5xmYf/+iqRH5nWkmvDGzt572hcmPLPK59+PqnulSb?=
 =?us-ascii?Q?Bm1XweMLTV8S14GdWZu6+LFMokr/ymjsZvye+bYxVAbuwUQ47kOrpxdjog53?=
 =?us-ascii?Q?eVZbN9ERG38enQa1ZvgeA5X8LdEpdoXRWUc1+qYMIVk5chcnMTVmokpD14ca?=
 =?us-ascii?Q?cSJfNvy1YCQ26EQux/ATTBfIfLZZ2Pu5AcVEEjkmvd8U+N5QHNYNYT8o6uCT?=
 =?us-ascii?Q?lDsaE96koTb1g+W9EJ7X/xneLniDPgzA2Xo+oUgH439/xZ2Zdegh0RBKmjH7?=
 =?us-ascii?Q?wgr6B3hKaykGAYJth29WhoM8p9CxCm/HQz3TvGUBfMcTbZX1LeQPZ2+byk5W?=
 =?us-ascii?Q?ZkTwRReH7SxI/rWGPwtOL+FnfPN1ryocuKOjFlWhhaWlF8/HEp2M2QQ4mTud?=
 =?us-ascii?Q?6GQgT4oH9wsIbTyOK9H6uVXbudJn//TbPOFsJrE4q/niChLIHMUKhNyvqm9p?=
 =?us-ascii?Q?l57BGkK8WPIuTEYdkHb38ohZ5ygP8YW4jlhjnXin1Jo5miYnyXy8CIcaWvsN?=
 =?us-ascii?Q?V6jxsroSEiKonvOl6HEDefgfgTzgOCWRDIC4FbsBAIfok0rQQCUP7jpW3ZFx?=
 =?us-ascii?Q?ChnR2z/CMWxWesnEVqETftEhwwPZN9kLYkAXyMZM4lERB0l/iSNXxPTWqvvp?=
 =?us-ascii?Q?rY4YXf6lB6WNiCw1zciFbNpDfUM38kHor4jcSR9sllLY5rUIRwrHjwdZ4jHx?=
 =?us-ascii?Q?+o8+cooZZWMvA/iqlkMIajP8VrcVYRyU/Huio1Rx7+Z2sc6OcmplBnPwpJT5?=
 =?us-ascii?Q?4wZs6UxQAw4tPh/JnYEAEZmQdd7OxpIGed24MnrXElmOPGT7U5LoM3zlBLOc?=
 =?us-ascii?Q?69knitt0r2Nc1f/vanaUtc9zpbiHT+awJO9WQxLiIJKVhqZXv1MM6IiiuZT/?=
 =?us-ascii?Q?yFvXucaqNxB4voLxas+QoMX6eBDQMpOk+GdvzSKbNMMg/1KrqPqm3vGncNBu?=
 =?us-ascii?Q?kWe4Jlj1rXWI/EXWONo+GTCYY12VE9AWFqMH6694zcFA8+TA9TddEbpNPpkr?=
 =?us-ascii?Q?eFMiNhDc9f+hP2NNiRCCcl/yfI/IRPBbxf5sfuMbxrHeoCj5ixFFZF8YJf0v?=
 =?us-ascii?Q?DDBYkoDAek/fJVrIXsjomzjjpreEy1H3Eh2wWd7FERPXPLlpQ/hC7FbnH7kb?=
 =?us-ascii?Q?Vbuor9Z/FRPPtGCL1Jbznb+jThVE5ZIKLxSPpEpfa4qYQJG312I4qpdgtMil?=
 =?us-ascii?Q?rjArKO4FKWAgYA0lg7quBcS5QVZ4FFBSv8wa1Hjs09WBjxmgsROzyYNz/wRV?=
 =?us-ascii?Q?rj+A+4PGoSv2M68oD54xBoznjg9YhdULZCeEvhXIj0OwcoYCmO0AnJPI6qIc?=
 =?us-ascii?Q?cSLH7IWUX3D/doeALv/ofrWHcFUwqK4fZruphYOrc/JgfHJoche/Xrk9k2G2?=
 =?us-ascii?Q?upI7NbgCFduv4nCjiX1a/r9CopIX5FOcXCUzY7I3ncwuyfhRtIQeqHi0z9Ml?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a6cc12-f0d5-4b4f-fe65-08db2438478d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:00:34.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ+gDcaC4b/HerNo9k7qgtBx6ZNKAcBG9FucWii52oROntMw2B70HOwKEpJRhmka4i1FbxbQ1LLVeQHR/Wmnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Don't clear the addr id in mptcp_userspace_pm_get_local_id(), clear it
in mptcp_pm_nl_get_local_id() instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 67995cb4f8b8..df15d846e7db 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local = { 0 };
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..fe4c29a17466 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
 	if (new_entry.addr.port == msk_sport)
-- 
2.35.3

