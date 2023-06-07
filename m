Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E9653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXue8rLlrgd26I5uq12oCYtlvPuFMO15+0Azl0k+PM7m5xl6g4DdUV5O2g9FnA7hF9ONK9ecevMwyZQEs/1WD+nKf0YMqjLByvAx79hyJ1DaZL1ZfbZAwABfl9a7NhSNv3+Nr1WNV7R0pwSEVd31HqbI3mBxwr2Tf5p/HSxt0QKgC7X72VbB5t0AWtstH9zmPO6k+9gA3TClNeQo56q0ROHRGH+s+GG0Hx+Nx/Digm5JUeyhXqp64K0zlAanRPYB4Z1E/tccz/EBMFF5fNhOL49Yw6Uva4Z8zo9lBf8uEa267EQNEKjC6tra+U7jTyHAvVFvpHGZR8lPiP2J73pqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sr4sTpsHtPINPIW7Lz3xBzsTvY8sEJbATBG791iwN4=;
 b=QA9SY3Ec+n9Mz9m8Hvgv/6CNji+ppsJQHmWVS11kpChVug5sYVfoYX2xPya96x/XMqJA/NkAeinntRa+X40SKmf+S3R4kwcWSEc1aFMTTNpgsM86ficxQjQjUVWaOTw0MqQub4p5NFNjs4YihP2OlUv7TLkPkqTpiIKlcQT+LBng1THPRE7aIxID9E50WqrUXUYnZmcUksnkM2HwHoeZdC3qyDHVmSfO8jaxebsNCKCr2j5jQqBvgBt9xtFI8HGr9Ypo0uBc9c79pJvJXSnTextIXEhzBwzDC03JeR37bBPuuojfIFXUJev/szPKiWjBvZM0z1OkwbW7dIOQSkB07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sr4sTpsHtPINPIW7Lz3xBzsTvY8sEJbATBG791iwN4=;
 b=G66+wBiCyWya10MPxGAFhNrJX/fWXV97mG4oAN6qJ+KATmAtNudP8lteJv3NHwa0KwqcEfQUWRvaYD9UkGRLGpZSPbmsi/rIfhDU8xNC1Sdp/Hj1+JuiLAr5WU9SJ2EEqg5vy6p1spnzVPBNQ/OFIHeSbyY6bIiRjpjk6YTfQMzfHqZdmCEoDf+8qBn/2c3RWi0c17k08z/JvgvIbGnt5QlLZtIJYr5eUZPMS1jChNxEnlZtJhdl8gYwiepxb/MpVJTCGd26DTozFopcbIaA5gSNUXN+qJzEOVsF3cXZg3AfPNvZZjjqGFhy2bRCePFK6xfZXR4f937XWUh5nG99Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:40:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 12/19] mptcp: add two wrappers needed by bpf_burst
Date: Wed,  7 Jun 2023 16:38:27 +0800
Message-Id: <7942dcf09b6d394736ece4769cb0ebb78826e7cd.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: ac84a756-d10a-4afc-56a5-08db6732e7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+BpacYKZ679hY1w/6ZYuelLSQtM3u0Qo/7yXzkr1yWK60URAmLthi7PwF/zCFhf5oCgQp1BxSZa0+ChxqsXGA8jXUw2hrY90gNCsBU88bT1zQSdZ5J8tbocBFIHrwee+fGK1hayT3DmthjxnCrQHoNrq5Cqv5uiqsv+jCkGC4Hn4Q8vL9GRuB6+6CjchLPcKU+mlH7f9Jjqd8PlXQNrapUgYC0v7EmcHkGJIomp3y2Ki/4F4PXSe8o+RscOw9QF9dPhZnSIlOr/X6gr+35SGZ3JRraN05/mBirOOqpu5ZcvxKB5wtlTfKf2Qs6cj2v14bEAJfin8GUD9CctOaRPTAE1kCQPQtih2+OvSEs+BW43QLeXRv0Bhii3eXGtaoPPhZ4rJCIrgvOPBt+Dj5viMVWIwbsaC2KHVVY9jotAX6mKFOjscCPyOdPzRWIMpP/7BDjjq2MkZrfVp0UqkPAA7nd1VoKRIJymVG9PeJoQ0m/tGY7gPHWzVciFUpHpeM9AyOehW5AkNZt4kMyYIcAglgBlvzRSwbrKJJFA68HJAeeql0f1vKZjPwyxesd7CkN+L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8iSEcJ94wUf5rzRBW0PXSGA0GxSruzbiU2xM07vnrdHn3Eih5b7AFsWc5ifq?=
 =?us-ascii?Q?VI1ZhI61aG89veCJ6peUwTbQ/PdZUKWdNZL187bIlix5v2+TE5dNt3jDrUh4?=
 =?us-ascii?Q?cFK9jMHIRxvMPx1vIIObgG4F2UFvCfuO+ePSyRNaRQpRg+4gkNJVbiIe/thz?=
 =?us-ascii?Q?jbRitksDq4M0tgJOTlJn9HT8aw+tZo+svxXKWQzezLrqaiY5wSDZswne1ocM?=
 =?us-ascii?Q?9qhuE7dEI72Cr2Tu4+JBOXluZz9Bg9gHaJpr5RK8q2EQcFIg3rH+SUXA0x0Y?=
 =?us-ascii?Q?wwcEyEICd5VHQqcFs6w+Wpg9ObLu6M7h95P1w67pjIwJDD0aMhM8UdOHnMp6?=
 =?us-ascii?Q?0IOMWpGo42RRpIeUSjvl+Px2sOa1+Mo7PGccZBXZn0R4Z9eHJ4HPAG2TlVnO?=
 =?us-ascii?Q?j0V2epE44T2N6PTTs3P/hgCrtYeDYsCYrO8DNzyW0K/wXiPFb+nbiaPF2GO9?=
 =?us-ascii?Q?clFxTxj7AnTlYknK9/PZ6YpioL9s+sDIo+skQyHciTyHnYYkwnoiF0cDWkLH?=
 =?us-ascii?Q?Ur+2lRFKiu/QLvs22ey3GHqQ1NLMOJgnm3Hl3tloykjpGJNGe9ODt98mlIv9?=
 =?us-ascii?Q?wINuCopj9HRV6XE+wDdmNn/U43GzDaPZnFhqzrQrmQ9P6pCUOp6bWCBczGvL?=
 =?us-ascii?Q?uRKrqNSaK88MMtgfTBwk261woZ+a8D7MpwzsZgULUracGASiPGYCOLQ91U9c?=
 =?us-ascii?Q?6smSR+p+b+eOuZK+aIRw0SMBG7bddQJ+GAhwv6egmaUlDjz7yTd82JCJ1XoP?=
 =?us-ascii?Q?7NJyiqeUZPoa4gzCFl26bS+Oapy/AjkhwidqSEaRZpxm+EuRdwLyzWoipdLD?=
 =?us-ascii?Q?m8nI09+/an6UeuHgxCDVacpi5X45HF8om7+srNifiR3KZEVL6TLXoSa3/CIi?=
 =?us-ascii?Q?6ejEGJBCr+ZFO4Mu2HmJOF9yD5H5NMkf2jqKknN3fTgfhwG9zQV9PCYHN47K?=
 =?us-ascii?Q?VPmBlnUKbaZK9f0oiUHxYPkxcr0+0+Gx4dshug1NfgquH67QbjTRL7KHTECj?=
 =?us-ascii?Q?qDL95Gi1a6hkERHFIwS7TM7doMpk92HqnkDyXWi4YHRAV9NENdwtThndw62q?=
 =?us-ascii?Q?suoFiEz/WHlpSf1xk2u//MF3CvhLK+6Zl1a7RKUvgp6PIijs4X+xMBDgft3n?=
 =?us-ascii?Q?0MZkz0d7iCcklQykr5VFkXUWAlF4q18lcCV/FgUo8SDt/hW6IvE/8ZNzRQ3E?=
 =?us-ascii?Q?iZBo4FezksReiVRfurL/E2lTWspj/4dgqdhvLJnKRaDwAD2Sj759ryKeVMeG?=
 =?us-ascii?Q?1eoeh/H8F+1JYoczsb0Y1a7oXRCUPzAkeRm9yyNZRI0PYrphVNnHTpg8+lyO?=
 =?us-ascii?Q?z2nPCXQvhoqNNp6N1OXAbhKSJeKDvq1O5Eyd/DFLtkleRAha+lw125Sa/cm4?=
 =?us-ascii?Q?xwoIj4YVKffejNUAkRXj9Zsz1UGN5IQt6pec/J3TKdRQq06uCPJ140ggs40f?=
 =?us-ascii?Q?ujJjqtxd5kigMm6Sr1smHk7a0X9JcNn5WMEtgH1MfOFAXNdgrFE2D5ZW2qSX?=
 =?us-ascii?Q?Ad8qpuyhjXtVPqUhLyO0ac6wW/j4rt/VaBgPG3IhyD1jH/68TDTfM9rbXp7g?=
 =?us-ascii?Q?I377fdtQyfiJNCs/nfTKMkOmz4KtAuR/2hp+jjvc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac84a756-d10a-4afc-56a5-08db6732e7c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:53.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPtk2Z5s/GafiL+bsU62GnJzjb4wCr0k5BpjkU3rdg84GlymmZ2hd5Ccrc/F9rwW93Hsk0+sYRPYxyQ+X7n9rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 12 ++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e2ed4223617a..b9fba77a30bf 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -169,6 +169,18 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
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
index 12c8c95abf52..29bba51b948e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -668,6 +668,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
-- 
2.35.3

