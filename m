Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79497FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWW3tcidOjpctx8I7RwcZG8CBrmcwplo6TPp4gEl4++agKSQB85Ptt3cF0q9n7Z1ni+zrlZTPNMZd4xH5wlaKBiGBy09deHLIES29X3a6AvA3c28tJrr3NlYMQe8FyDHXz2/4vryDMFiaMpUGgoI2dpqBvoLT0sqFug/pR+PN9xvZILxyc5bKCEJMAS9AmzMlewaiUqt9HyNl3el5IrZ5yBxa6yHyObg+Y0CR7YP7TIUiabWB1p4wmhN7egtCKDV5Nw9ZrUsvLPfsRqLrq7We/AMM6cI0a0a1+JLRW8tpoSWjRbh9ITGHzizGMfEX+jMHaOVuremC1M87S46fEUZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1Tb5hy2h3gb0Vcbmf0NkiSLxCP+9uIrkp0UqWpbL98=;
 b=lXAISn4BiMWHbMgdbODdRdZ3IndkZMW1bEUdEvZSyAh6aOeQe0Deoj9Ivuq2V/4XsOSvbj1pq/a5/JYKICcBrpbEAY6m8RBltU9mvdeo/llCX7aH2CDtFqKeFBIQN7PNbcNRk6hS9tIZszJ0Q9N0pc/yP/CfJDmUJZYKZdZbxyaitNNd5AxwQtHO79MqT6xlhIEVLtRrPIqhT0nlAK3motkYpBDjwTGflf6SCYLXOA+TQf/hgt21JrazH9YwH4iB9S7RhgzV3H9VenNGbDqZXUaMpaergxcDpPDNMIOInR95cgCqL/1G5HG/L5SJrt9hfMgkO0w4dh3TIGAKDGM7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Tb5hy2h3gb0Vcbmf0NkiSLxCP+9uIrkp0UqWpbL98=;
 b=FI0w6jviGkBrmtFL5B80lCZfWm/5mH3+T9Rzbi3s3E0eyhvTbRQvrBLG8P9+L+qo6koR5brp+U72G9bA/VZmQhVlwk9g6FoXz6HpIj1+I0BMX2juijtIuHxdXVC0hWA5ZirCMX2E7YBXQncUHciCheoYGQiLN9Ys4QVpGcjzSRQCqH+c2eKUNfY1EAJXx3zZ1uQt4qLosVQHCo2zCbvqVM3wlSJVjaiaQOS53PFnexJSGLyllSiG3J+nHmbFn+BQa9g3xlRKtAhVAsIInGtR4SWZhct3TLHcuBLH8AELeAt7lu3LKgClWVpTCaefjNotqXPg7Dmu+8L4/sc7eWTjqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 06/13] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Mon, 26 Jun 2023 10:23:07 +0800
Message-Id: <7223763dfcf01d4be73bda6268ddcfa34bf699df.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4661389c-ac74-4e56-685c-08db75ec63a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nl2Tb4sWf79XuUlK9QYRB+B3crpBAoEQ1Q6iXlXg2R2pnD+WSoIPpBBayhzFL8bViHHJ5DLlN2HGtMxNTV3wGvSrUeSi/O2OvlG3ARONeP/BvImuINCdV7fWWwW4RAVSRjOUi50vzLuSg+OyYvYWQY+I8ltxzv7onwTmDumztiDseWuv9Hd1tpO7HSDZiVh+1VD4OmnSuW5GhZYWBzth2R2vUMBlxk67v5m1zuv+swZ6+ax77piawrv9u/XzuFBeJjSSsfyrbk6lS+irnsWCNp9msGZ1uTBuyd0r7ZoP87YqkhUP9flVPzzkMwBgsDJCg/Vuf0x8Z4kmnBNBN1LwwTLTyvl3Eu4D7E0SbhWpi5WRBseP6qdRsBjreM9S/thij13cfzGT9Wh3W8gvFs3n8ol3+SJRyrpDTg9ZoyVdgdXcakn+fjWHdBiqM8HlHXe0JLiLJOmwt8I5wkwghw+r86Om+zLMTz7u+wfZSZbqaLtbjAFzz0NQtNd56WdACwyCvfZ2Foc8oCVAHJYjr8jM+bdum5zuEW3R88xgYIT4XkR1xEQGm+QC+NJlFMbjiGqy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(4744005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wYnz8F1SJ9g3T2Enl9mAC2hqkMMmjcQJHFxIza894OcsyXxaDJG3Bwx7F5T5?=
 =?us-ascii?Q?HMg3et/CKp43nLLdEVIhptSOPvb2QaBObyzWsizHioik39yfYLxrLjY1CSM+?=
 =?us-ascii?Q?QprhcnaBCVLKIGsO5MAMd0axSUftR92xSM4JtCkgnTmBhqZGXfhOd/z7AR38?=
 =?us-ascii?Q?VaG/j+KTKBxDi3HuYbKEi3EJNMWpNYcuvEHsnD3NKxAONc+MkLSgu6XQ57H8?=
 =?us-ascii?Q?Bm8SQywssw9pIQKQ5IKuR6vxBQSyb6b26KxGIQC5iEK85J5y6i7eb9WcJ8oZ?=
 =?us-ascii?Q?Xca6pyoTkm4KYo2TUgGoqwHdPgQqtCtJ4Lfac8SHvHBVGnGY8pDTmRjvh/77?=
 =?us-ascii?Q?AZWp4DNPe898pnwYOzf6mSm8ZRFkSchmAstO5tgmVOfbB3J0eSqcDA44rBNa?=
 =?us-ascii?Q?7r7fElkE+yhXA1tLQHv8jnEyNsF/IWW/QNUZAykENrm51EUF0Vm3YcS6p5AR?=
 =?us-ascii?Q?VL42neL0f70xVGLY41ZnEFYV4AvgkFexYPpKhdsBCD2/u0+cawkyxhebtb5R?=
 =?us-ascii?Q?QzFqVLm44yugTZ47cciUS32Wo4+1Gh+ya81ojLvlqL9GNVfpq5voI6ffZF76?=
 =?us-ascii?Q?1qG1ywMOc1qU1gK3X/+fEZDvtqmd3jhhquljySmwpIhjA9SnDxZE8F3EapDG?=
 =?us-ascii?Q?cg+GnxCuvp1ZK8S7F3Qpe6HtyUVBN41DORzQhjhjCDcEc7BUDZbQYynQqYNp?=
 =?us-ascii?Q?0EsGGJNzwUbtuOzQcilpXhHG7QutxEOWn6Wo64SxGG6h8hZwTK/XdtKIlR8t?=
 =?us-ascii?Q?o0RByxgMvjdErAJH8Rk1KUzCkT/s3hZ9jCw2J+H+03BNx2LX1JX158JBkDdI?=
 =?us-ascii?Q?Hkmgq/ofqt+joq+CgDgQaJOX+qfBfLMuI14OHB69K9MYUMEI9mfaIiztKVii?=
 =?us-ascii?Q?n2RQw2JAw5xKDEkN1kqOku8uO/DJyhpUpsheMRbihO7rCVa4KEtyk14jsMDs?=
 =?us-ascii?Q?GPwghGw//aGsPl3XHvvji7v47v5Yk+jIF2MBxdjASjqjsxR9YCSC0oXIY5z8?=
 =?us-ascii?Q?MvG4qryRhmhxoFWQFvV6TmtgVDLRn+26XF8+nUNL5IdNoh8+WeEgt0YWndRH?=
 =?us-ascii?Q?TPncUCJ3sFsOkO/6Cav6NRp1LxjzTaMMs1hgQ5wBMYUoQ2Vl0Xg4/UGoUMe+?=
 =?us-ascii?Q?GGE6njA7ThL4YiWDz6Q+9a3vt3zkC1wOuL6zDIQC3kl/9wZQZW4BYfIyuhhe?=
 =?us-ascii?Q?qnPLUV79TPvA0ds+eCtLM3t/LBcSQtclKaXM0sXOFN4c0jXEYPy3yoLqNFSP?=
 =?us-ascii?Q?7ZTVeohtLzbRQUQdXhACD4gU83cXE8fTOK3TXAYRXjuvjfNTG70K8sYompam?=
 =?us-ascii?Q?nejl8VRTGmR15Y5xOhqjGNSvFMxy+uXxw1vBkERNgKkLz3wEJLp0vAmHVm5L?=
 =?us-ascii?Q?XFaf0Q8qf1+W4/xFqBNB9OroErSNAVNdQZ77Xo+kdCSCnueF0HO9EKAHwFE2?=
 =?us-ascii?Q?eC05aH+JE8SE3S+XqVLvazvEfKLjNymwrNdT124qkZR3NiG3zbcFk+HsnaUt?=
 =?us-ascii?Q?r7or72YevDwlsJVKN93n0jhW3+cy3AO+RvnKFir3brbOsL2rLv0WzSwWuZwj?=
 =?us-ascii?Q?K7uwx57HHsGbJF0L94gaNlGpSKPeupZltRDolbWC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4661389c-ac74-4e56-685c-08db75ec63a0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:54.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuU+zWTvOuk3bGeHpHmzf/9TBBpqSP+CmufShvYthVs8tHGGUXHuG23SpvxBiA3mafJ/aqmtADibB8Yvpqbt9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Export mptcp_subflow_ctx_by_pos too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index b9fbee8d7bac..7f29c68a0dc3 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -166,6 +166,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

