Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC757F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jskjSuq9LaX9BQR7qNTBW8xSFSNDVix2oDuTVWACLT7WtEofYLPOnngXyVtibp2EBOGFkdEme2iJGgsDo8P9s+gK2kJZqJ9o9+eoKD9puHBnWwxCzPB1VhfzozUQMPOKE1Rr6C9dzAF5Y02Jh34lyolY+VtOEe/7Xf2L5H10nKzecsgU2YZcNrfPbcqkiVAotyTBVUDFTdh0VWCuhIWDez9Hwztm4iIW2T+NFCa8gaCK1TPVG90dzXWn1Rx61jB6RHGuZzcnYvN3jOSao01ioR86vV4VjuV7blSWn9wv3azS2hHL4yH12BGtZYKG1KSDbfdlmB3Aeefl8wox//liNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9eHGwwuO48cEZ3JHmhQIt1O7OGSwORo6AHDrAbTUFo=;
 b=caKjfcmdGNXFz7y9AUStsWs/82PA1Si1hTkeYiifFYx8RL86n/wAarDhlKmAPltBbSEvHrCAKKdKFByaKEXSOT7PfcwMk4BJf7KgtpI+A37WmnroF4ATyPjaKNM17kO6XCCrqp5L+YN3e7EF8EwT2XnHfxA8Ybt6WOpcLePf5byTascbjv/YQx3cAouDFKpbllj0/oibqEA+0byUJR7VkYlyCMZt8vek1ZXOo/MkIOjUzBYTDfsbesvd57PH7iDxwgq7oG9FnbGFkniZBBpfoq7h0xMbjmjTKte/H0HNh7aS8uW7X2IqdozdQDpvnhb/5cYJ/7V7937xhXVTK6zJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9eHGwwuO48cEZ3JHmhQIt1O7OGSwORo6AHDrAbTUFo=;
 b=YjtmcRiqJKg3r3ihpsjLXbO9MqaaIRuAofSzseIMvZd840JvOiRqgXoPWfenDgZbo6uNmEK9LKvBipwRnrSUnGellktFEquh1keeqMbT0FUxGeqQuFJb+L9NN+XSTwB79dA7dOttuSyz7Z4mzah5uNF+jFuv8SloRJoOkle1rr9ww5H3I3NygxNmfogldxtXUqCjPZZpe4/FfOOAEmDaFR2U/xzxo0GvtyrbcI2OXOH7suK9IuVU/yB07FgCXx0WdF76lZzUrBi176nl6YNfP3WlKLOjjcRDdWB/Bd6YbYym3t+nyl9Qf8h9PCnlG+r+a6QDbnTxqUe0SOW0VTFHSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:24:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:24:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 16/23] mptcp: add two wrappers needed by bpf_burst
Date: Wed, 14 Jun 2023 10:21:03 +0800
Message-Id: <91f0bbfa705d3cc4f41e49f03b3229a4a81acce4.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: ac790021-21e7-42e7-35f9-08db6c7e7029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b8+dqcSdBfk6dugZwT6IYcQ91tbUhav8Gk3TkNPJKe+I+EU1TSgmEERj4JvFCspet1JlKUvOKaWB1ISe+EL/tqk6BfpPUXVtgL0aKAcMF/07jfl9mc4nFyFCsMfq/W9bc0QuAEUBzJkKY9Ju19T3QdyovUdVJtYhZ7BPwuY+cjSnh/HYOkyY81ILSW1lOsuU+lBoCeJnGsttv96rEf7nLuOTAvGoL592Uy2/ntxEaancoHBhQ0Wuv4vsCUo28B5rWE1jxk8s8uYQvCf0KSf2flenHcq0ljb4AGEkbmUl4dv+Bm+r3WYdn03BqhKBd7j1XUd5JptG3rh7ghR8/jCuRMRbbq94oa8vA4wcUEPE1R2LGown8kfmR9bfglEHRiEY9eUeTF6YVkSvWcpSz8qt5VIbEEj4VKx7w5YtHiiygr+8PLGmj4o8cq67S6/cnBPCfZC1yBf4AOZSwDllkEu8kWPEU8LLWaC90nYml8MAVkgXdRg2TyWOASyoO3dvJr4lA8HNZmgs6jEH4mp0/O+Aqa3We41wnM4mbXY+OYGU355aaO3x/Ysjd10PifKRitYE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYLn740IZ2Q7S17oaJQOY/SZ6bfmlBErwYTWGRwY3vIC+s2O//EPuxuQGfFP?=
 =?us-ascii?Q?bfITDlDItuS+fl7DitqDvh351aQK9sBzmtEO3oA5YaTamiyLgoWgU2P7rFNa?=
 =?us-ascii?Q?g74okKp4eS2ke4I9/rjRtPeEO3wGV5RMIut9YjiCc621A34EMGvzsGfAMo8p?=
 =?us-ascii?Q?Z/E/KPk2g1OoO3bK7Y8OcPX4zuhGDs1olBWEn7IQ/et2ADBeQ8JxXq1HHqPd?=
 =?us-ascii?Q?SwTn+UTpfSw/2f+rAGkpIRVrlS+zT6elu5cAYE5RSKcvjxdUcywFPn5VX1ST?=
 =?us-ascii?Q?7/sJE8YQnPS5ba5ZqrlT5ONo3JAKErBBQdMOjf/DuOf9vCDNo052qRPZXryE?=
 =?us-ascii?Q?r/MDKO5G118T5DhnKjA5IYvbo/uXT9TwNSFwCODiPnlhqPO+BJtpeQfuhaS3?=
 =?us-ascii?Q?TQQEJMEPCM1XzXwzxlYf3a3oS2qtM1uHo7+715Ew4UfxK9lZ4SUjlO8tPkhd?=
 =?us-ascii?Q?vaZtnWyXPCee9JgStdAjaMPVvY/CuGQuq+rT1OhD64nFUIXuMsC9GOiFqA0o?=
 =?us-ascii?Q?xqfHpNS/luh2JLdwQq9+dph64/sW46O/e93/ALKBHGn+F+M+/X12NmUIPmel?=
 =?us-ascii?Q?XXoblS0641f/YRSAw9ewPYBSIFsChSJ2NlLS0Dca8+YZ1yzs+Y9IG0C86mDy?=
 =?us-ascii?Q?XM4lhwAlZ7gigTLtsNzunYyBzZ1bZfAdqNQ1y4QIJ7FG0F9C2jGgdVUdMb9R?=
 =?us-ascii?Q?0kcXpttnghmcW03abF/O2iR3D7OfXIKW7Sv9Eaxd50TeMteqSktIORhfAS1y?=
 =?us-ascii?Q?wX5VHTzBK1Scyh454Fl4vgV5WN02HDCKBwbl9PGDTRDp/tzPh7pUWze/3ew1?=
 =?us-ascii?Q?QKX3Pl1Ib7eF4TRADOOsQLL7Aor7g7meTfVMCJooCjijJIEkWKsIFP4mMN4d?=
 =?us-ascii?Q?ps1riYB8UykLpirhF1NTtAe81V3WCMPtk3i5R6xXZffjdqecPDhDHQf9iKNh?=
 =?us-ascii?Q?cLiYDd+twVYRyuhkPKYpg6HW64vnol0RcOaXGkw4nYXH7udRYNW0Q5pBPNq/?=
 =?us-ascii?Q?X2EQ3MNrjD4dQPabtKcWcd4GrHhjsR2n7EE2sUlZxtRQZyAEdianM8xmW5VS?=
 =?us-ascii?Q?Dp1fVT4dMfy+VaIMpQeUiP8lZWihabxo2SWY3B2JwDWZE5ZiDjr+7SCVsSzE?=
 =?us-ascii?Q?xDCP1oxmrBhbilu7137qEovPYWiJ2pMiaa5yQqRzL8kcgzZZQwjEZFFHwfPR?=
 =?us-ascii?Q?b1dP1ztZBH9+6409CgYFnpRSHByq00Fvt7Iq4EvVdwa2o/msq7ZRThtMpzTj?=
 =?us-ascii?Q?qfvZSkQUDmJmdy8SBmJS0mjpsYyYSH1A/SS6AkXI6AZBAviaEEjEAWifHA9u?=
 =?us-ascii?Q?SzbREFbG+s5cglig3kWtdhQ7i/0QeGwU+rDDNN5d70AquPufKPk9WSE/zQdW?=
 =?us-ascii?Q?763i7opwsQ5jFjEmGzEyoZD2/jdyBOBZw09ozGnARO3VifvAQpomkEZhX7QE?=
 =?us-ascii?Q?iPk7lBnkOxLGphh2r/vTHfCNoCLRNUsWTKaVHycEiDQL8LZKnAhCwyMhQCfY?=
 =?us-ascii?Q?80ciTLFIrByklF+w/26AadGOf7UmOo5/LSCKsl4M70ABuEMB6q9D6mF8t0bU?=
 =?us-ascii?Q?K4tOMjvfTQBWLvp8AtdEpp1o4JGtVKm8QOMyX6lD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac790021-21e7-42e7-35f9-08db6c7e7029
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:24:10.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02kXis1fnpHe2/9E+aKLXlw9C5ly9eqN0/Y7sNIHBWemS+LLMtxhO5qzatGEXBw9wtX81Rm+ZLf8LHBMRyoLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 10 ++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0558e6a0e794..066a02bb26bd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -169,6 +169,16 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(const struct sock *sk)
+{
+	return sk_stream_memory_free(sk);
+}
+
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e41b76f16729..784f4643831c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -669,6 +669,8 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos);
+bool bpf_sk_stream_memory_free(const struct sock *sk);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
-- 
2.35.3

