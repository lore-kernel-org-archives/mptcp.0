Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825C179BE
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G+FgCrhL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkdwgzQrEKt7pNvJgZHJZ+MBN+m1tK+swFC0rBKnFxNXzxRLW4T/jdwnmOWDeXyDxT3UJwTXqN799TS0MDtI+jJ0JlXNAL+qri+fot4Ao9oQx5YxjrYIthic4EYQteeAlGP9qZjj3ffveizWdJgLaLR2d4QQHD2MWlLthBfL/AKVNbaQdP24vXAmYajTyfJc0te4OgmAkPfHkW0IP7ru8QS2Q0taKM6jKynmIPH7QDe3VfyCPpuinlja4kGygjpGaNjfajEdZ6xVn8prinVuuewCK2N+hSj6wqNtnzkKHpLRzMNajBmqHZZi3FAwCyDGbQx/EaTXq2zgQVIQoWdPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX8B6Hy/CAj6bu0jQ5nDe4DysQWNV+dsjD5nvDagwps=;
 b=Ot1XMH7a+Fb7YtpsLMfS5bnLxygfUG9WNHCOp7Z+/hLNX8/pAg1zfEsYTNu5z089WIQZSkjREqwkShh074ps8iexdhw02KOsVsmb4C4rfWYNA8v0pzcUCLDpCWOfi9cjGvkzvGsTyMAZx8VjUaci0Dn0OWfSdYrXN0U2fhTNT6b6fUw0y7eqvt83EemEFKrvePDn3+zdE4AEnIMo1ZFZZGNDNyO09Ruthuotho+TgVcxUgs45PY6ejN4fhKthBmWRPipv6Lk4UzuwpbGAsbe30bdVgDZP9LrKjDP4gsHGQMwt1IDElxnNbWPyxIvlLdjIKlTaS0tGMmxTlJwSHegcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX8B6Hy/CAj6bu0jQ5nDe4DysQWNV+dsjD5nvDagwps=;
 b=G+FgCrhL5jYQTeGCW51gtRgnlBaAwEwF+RcYsCD0OXkj8u4CKuA2aAXDac8QJnmVCUUxjK6lx6UTAU6huYY7dW7/+DATHsAEyReQhIT/ELnccrYWzpy5SPylJtjwX5z7gMn3LapNU4uHEeXPgwo6kVoujF9gjGCG2NPWKokcq76Xi1mh1PIp1FLfF9ezTgiKOEEcJE2dLGtIbDu9BabMU/sNuYQp5oNlGsdp7O8HCDnUOVMZoylSA9kvKK1w7NYuRT6/jNT03OJ9pTzQfrspuBW52stTLvW0cJXkSSYtvQvdCMakpXC7dg28g/xqFY0ohLjQgDQQ343dtJQ5+uMIwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 18/27] mptcp: remove addrs when freeing userspace pm list
Date: Sat, 18 Nov 2023 22:28:33 +0800
Message-Id: <962318bac9e27b7875a5f0747c2707e5395df65a.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: c663137e-d3ef-44ba-4ff7-08dbe8430750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n8la9crwjnuVR25mQjB6N5oNiqH+0buHhTWpBibxSUPSXzfs4dX3qxP/BCDK68jA7WGEJ8xFl0UPQ+xlFYwSYBAapTAE1d+DIh7WqF7oU6hkLqTgAXJHegFGwIyB5u+dq5y6ClQEWwqiQ9kCNYndU3FrvHP4CLIvsXpsw7oeRw8UQpIPDcLz9ZT/8r+rUza6BwUttckiUMHZhP6MTSlCzfbkdMRZUxZkQrMz8N2Zc1V5ftfflBWiG2ido9sx8eBOE7IXk2FLEQEqqF0pqCMjJxrOZbGf9+u9/AxlChWRwoEI+0lHycQbL9waEO9ikm3aF70EaokDu2u0h8zrCH3RPfa9/Ke8MpzfbdPdhKVd3ni7BYXf6+GhH0u3X6mmZlYSQ3ryNoC/dfE3+OyJWgcSA6kUAga+FFRgj/iQybd4gVIj07TezRUUbQjueRecgNG1Jlh8w8842IAAazJJiK42CMI/vLgFqiNxcMSSxVj7oMMI8PJ6Fw/szmLVEimh5DnC7x1pqviQcBnVSq+fpS4BYvwkjGSWTkkloPSIjOgwKq6+lkW92qiae4zlD/80VKl+KFDz7+UF0Ip0SJRN+/L63xjYoiXIV/ZsUXu+QZvVdXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9tE5ASJETpJRavYhNZbDKhgaN4W3aF0n9dIGBNnuhiKNlOnHzQrlXf/8ufR?=
 =?us-ascii?Q?hN5Sxq4HgNG1iXqHwWCl8qzU3TpnA0fuR7+0iu0zevNVj46SEhSr4DvIEUzA?=
 =?us-ascii?Q?/yGr2EY4M4AR+eRz2w40TZCbBWkj5nSg0jT77VCzitceF6NXZ6XaDv8J5dgl?=
 =?us-ascii?Q?A/k3N2O+TRl9jqsIx9C2J64TF+i4VUNA12MKD86kyI4UqwgQi0XgtZIG78CC?=
 =?us-ascii?Q?BMpU3M9kEzGsIk2d1a1/NotYlJ6rk6DyP683RK0m2/vulBf5rmoLxkhQtT5F?=
 =?us-ascii?Q?OmKEwFAMTsWcj3KjEWILGEp0JBpbvTw2P9+PsrogU+goiKe3yMNBl2SmcPep?=
 =?us-ascii?Q?waf14YQawePVdBdtdq0aCOo4iSzhsK+HehMPP2OH89jVdBY0RTOJEhe0Z+QQ?=
 =?us-ascii?Q?75oBNOemBiEzAO2k72w5JB15TwJG+FtfrFgpR8sSxPCl3TEuJ0Hw6iu9tB5L?=
 =?us-ascii?Q?ojFi9HQKqZXYAsgOuxSc7sUoAMDuCGs8p4+s42hSxHxECcA8WwQQxUWoFVOd?=
 =?us-ascii?Q?IYsNwV6ZWhX7Bcyz4m2Lg9Z7TTsJyHK40F5GUSiy1d1LvbxorsIdFFb3rqK3?=
 =?us-ascii?Q?eBKcqsTTOH26eK7ZNmIWAJmqU3KXnud8/kZknVQCq76chM5Wod9G2FNaAa9D?=
 =?us-ascii?Q?wlsPQtZYcd334NkCbC33aDZs+b+wBatqLrzgAQYpQ2McZsMKWbDIwZQ6y4cY?=
 =?us-ascii?Q?53DUEgWZFF9pUOswAq1IfK3dLX97mvR7RtgS6YTbnzW0t4AbKQJ1MBlTwGdK?=
 =?us-ascii?Q?yRiLmPIVKoR6wKw27UO3/zB18oygIDGQ3wNl1tnJLu7X/eGKXAYup9O9mtB4?=
 =?us-ascii?Q?cgqcFtFQkc9vpVxf3So+dFnRVE7lFEuINxVrpV2v6Oddo+U21QhsVhnjEsgP?=
 =?us-ascii?Q?6aCqbLbjSMVAHy+GXh2JcvcgLkyTQbtpVDnv9v4hQ2qB1hQeb7YKlPhZ2c67?=
 =?us-ascii?Q?up3PddwKQa7XQpxKmXb8yCRBmUfSOR2df2tLuO+cjDqIhILMGFnneau30cUG?=
 =?us-ascii?Q?iFVW+tpAAMf6dEhNkP5ojdfok03dR+5DjLti6gsFJRSdrd4+dwGqPLAa0IXh?=
 =?us-ascii?Q?AIi9eqvL8Umd+Okam00hsLfgnAQLn/Om7Pnnl08WvdQU0dn4U3WCatKM5z4E?=
 =?us-ascii?Q?FuAr0jzTdZDt8z1zVtQKPOywq+7ivQfC7GKkwWQ5ysTY9GG9sBDkZMdn3wc/?=
 =?us-ascii?Q?SiJLxIIQXAj10ePOtytxIjQzjX+yqhMTityWI/pziv7H5W1HAhZ5KmHPK9up?=
 =?us-ascii?Q?Xtgkq5syz9K39QN0O/iqOLiwvBf11SlIdwEuihppGSnoTeYGuCb/+Z2ULPXM?=
 =?us-ascii?Q?atlC2z1c5VRPKJIOm54XzVqczzfUu3ikR1e8FaEnyuEl4C6oXMPOxkcwHkko?=
 =?us-ascii?Q?g3s7X607lLXkm4j/A2R9Z27Wa2mVt6QxgiH1DpTnqa6KcTRBrnMOqEx2eMRg?=
 =?us-ascii?Q?mtEv78AEDrmMdmSwjP78/GuilLdU+Ni/yJ6oA6FPG4m0/0U6qzHMJlL+Ewbj?=
 =?us-ascii?Q?mOiA30KdO62bZQv426khxoXv9xpugtbZ66NZxAo19WI6Df4CywATXl0DOFeY?=
 =?us-ascii?Q?OGlHfr4igcG3q5VPfgyIrtv7kQb7YtcApH/x3Zyu/rmhlnh8umkcm4VEfY85?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c663137e-d3ef-44ba-4ff7-08dbe8430750
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:18.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY2yG6NpTZi7s6ZXFqHZYo4IgOXceintTNOplLmMmxEfsRqNoNFNJ7zZhn8rmj2uBB1Yxpq9gvRI7wRI6hkxxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

Before freeing addresses in userspace_pm_local_addr_list, RM_ADDRs for
the addresses should be sent and the subflows established with these
addresses should be deleted.

This patch invokes mptcp_pm_remove_addrs_and_subflows() in
mptcp_userspace_pm_free_local_addr_list() to remove the related
addresses and subflows.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 87cf27dc1d0a..9fc5dbd346db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
-- 
2.35.3

