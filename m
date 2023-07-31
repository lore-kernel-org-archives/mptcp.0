Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3ED79E4
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWRHEG41XOIIcYfIgMRRGs39umMFktEgxj/L2yurfWcYLviefaXjM3WWHXRvOw/+G93/85emqn35ROWxwafgguB1ExjvJqm4R3d0jhBzEJ5CR7Byk3EfhDjUrEHE2GRNtbtbuVQc0g3OlkocIYDqcMr/l19C4Lgg+AK2zsfUe+WioRbpQxraAwdiLLXSueuNQ4D90evvvvN/KUtbg//F0R/Rr5qj7HvdzozKJmbS1aMsuPO7GoHEjJJJwAaJj1xuS3y8/eY/v2RZZ9/CB1WX9GdQhS/7yaQO89SkH9rI1A1awfoBr3DWazf55J/o99L9C0DXoiJGv4kPxWLHB158ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW/EL9lfQIks03++5Q/pXyu3v32zXbsmUIRSy+2W1M0=;
 b=lrtHeT8eQpUmOFbRM7YfSjQuYxzzikxCghJA4I5aza9GtcYXffKZOTOSyP6qhF7Y8EU0R9dAmNXdunU8BspNcb4n5yDWIWcd+rTOqWGSvMqRSnK/z/q/aWgfh6NO7Ep460xR8+dgv2sMugH5UsqD7ven3fo9sSr3D2noxA0atlBgHDzdJ3ei4ieZ9fozL7qbkCJB7lrmzq/7cHo+rYTs8Qj3+j3bDBkzIhAA269go5TkHD2Hsduhl+15MJhKaKTnMW8WnriPgS3TBtse6NBYdKxvNWEqiZMAIhBzgmUdxWhECJSNpJ55EhlYk4p1OsNnaHSlbLqCcvGhSwWOlR6FPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW/EL9lfQIks03++5Q/pXyu3v32zXbsmUIRSy+2W1M0=;
 b=QzqEI5Zwk+QDqhvpNtaC5bw/SUgGDiodcjvMOaEjdnATWqE1vcUKOHKCu6gU9cX4oxJaGO3IUSAtYS+YvFAyNthKPRjmyrnoeuQ30r6uzH61tWT5l68UL3eQm0TZ7i8TXnO3e8TbSK2G8p8/bw/ruWaEE/DNAnnzjbVSaRsVNuJN+qqcNV5u5wzrJEaDPT1ksLaK68egXiSWRhhmiRLiNcNBAJJGJ0KEvfENb3ObNizvJvyQxe/QyjPtBXtHaDkJp7SmKWyftmD5iqdVeUYSDZ119UbUYpRcZlLEtF/hmafc/iv1x8EhmCMkkuHppXJGUPyhQsnG2cW5/0YwvQ+fdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 11:03:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:03:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] Squash to "mptcp: add sched_data helpers"
Date: Mon, 31 Jul 2023 19:03:15 +0800
Message-Id: <ace8efb8d64edd09e78ace22cd49ee02ccbd07d8.1690801329.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690801329.git.geliang.tang@suse.com>
References: <cover.1690801329.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: efdf0079-cf54-4c00-82f4-08db91b5bd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	07GfmdPiixzZTb0KZrWPhuBgP+7rg0710jnlIPM516WVxiCZLSiPdPgfeTnwWxgUupiMABvBTqWbbVTpmEtLvPepR4AFtEpS18Eii70yPKiRO+pwO7zH2cHn4aHq+D8cAsrtA4Q2j/cUW83EFzw4S0FF6nsdZrDAv4Ap/DGBIqW+Mx2PEgBQh+NXh8SoSSQ9u45X1MlfFkV0PSzWUAOnweOIU/5mmG1sqnYPCQKwR67/ZQEyRteCb8/YK7F35QOEPPlDzo6l5y1OCrorokHV9eLieqTn/WaipkiqdtNR9gY7i+a3LYg7C8/2C+HzMJw0cPsAbROwg0TKUxC4eIrfC6Z2BvjPAa3HBoIcXGhNIb3x0lBIFr5v6u9Vc3gO7UBqtbDQc3aAEWEc60HadLYQPXrjEPE0EmOlEeHp/C/eJvwWI8R4kw/M1eE1kfT9XV9D3E167raSwpLwBpDcLRs6uKddjMyq++zLh36AhdW4MFppPvuVL/1e2WRshcVBkZjyAWG+zzyC3Ag0sdoB0iGBeDJZDTf0aUXBjNs1XWAg4D8CY+tr/JYErqJoV3DBkB1t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(6666004)(83380400001)(6512007)(107886003)(6506007)(26005)(6916009)(66556008)(66946007)(38100700002)(66476007)(2616005)(186003)(4326008)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOKyws5W8WeR0DowcppjC3Rx0r86KAtq3xk5Q2xAZftbRZ2ZG26Cta59tUUc?=
 =?us-ascii?Q?BcReT2uwz/OhY9m/7wq+lHR0LzjgLJRDj5SlOepwBnqGq35vVY2IC7mhGw+O?=
 =?us-ascii?Q?18eEVDOHSEZqEb+jzU/mM3qpY8vOSkBU/lSlwIMXTlqwWPPEOXL2a2LtURLW?=
 =?us-ascii?Q?FORCCSDOrzOOYyFdFBwfjrdVpPGHngrAqV8aWL6KN6RQINH0LtNgopBmNNEw?=
 =?us-ascii?Q?8r2GmwOvbl2ZIjyrnU2qGZjHmrfpzhxu+Bs7QAwRLkactCXCzvJ4QmBETV/i?=
 =?us-ascii?Q?fFQkhWgNAF3H3+bZTFuuMRVBeDCt/b/WA2s8KZ5GqtoAmxEJbiW1rmzrGikf?=
 =?us-ascii?Q?4uz/EdZG4A/z8YyacNm55Z4obXLO66V8kiMr7ubbgIU+tOUiaPT6UafWoyHe?=
 =?us-ascii?Q?JZCawkZOSAQI/lgnRIXx9oJp19EDQV2QMDfYSMxoXjqqA3PAYTCQtGnylaoD?=
 =?us-ascii?Q?4AG77wbZ43cXpaiPsg66TY7NrHO6iUbX7GUzaVAzJKSlimq/tvsqG2Fm3uyL?=
 =?us-ascii?Q?CUMIleM0O4q7XBFMW5N0pEugnFGoZdj17ds2hlklx6Ahp0IsPH9d/Jk6GrPh?=
 =?us-ascii?Q?QHJyaCa4OYCBCoZaJvmeNgMw7Ls7Tcf/n5ZdV4ZXl+GH+LqMJoPDASR52V0B?=
 =?us-ascii?Q?Fkb15TjzwNA098xywInLHVliMv9Rnxs1j4VYMHxo9KP+Ob9UTHEbKfxY4IXb?=
 =?us-ascii?Q?8KFkp8ijyYgm9V/N3Zx2WjpAOlq6LhskIFixXC6A1H8LqU7Os6HJE9H6D7L0?=
 =?us-ascii?Q?ij2KEO8HKsgeBzN6q/EKTXqNvA4z13cpXVzVXzXt0aK8u1uR1AnZrTIIFOMP?=
 =?us-ascii?Q?I4ZG2+vRfL0x+tmD4l9vt6Urt3Wh0LHjiXjCPUlc29sRVPIWpSrKCA1x5BY3?=
 =?us-ascii?Q?QGkC7uNzdrydhanJpGDJoC6lf0mRt5QRlmFyS4b+7fb22cLJqQ+QlnN2yVMa?=
 =?us-ascii?Q?w0IDPECcV00ZBD6p/79Mmb7xRBDKfXiXUTcSqr/58NmzCb09NWWJRM5GyD+Z?=
 =?us-ascii?Q?XX675yWrKqgCXQswnRd5GBr4S4DYfmbkNRpNY4YzBc9JvRumENt3mfV/pr9H?=
 =?us-ascii?Q?FcnRj92lpE4gVRSnmNlDhjIrorW3osi0y8is+RilxUZa9eMBNS1kOfvAx+O2?=
 =?us-ascii?Q?PdpE4s7my2DE2Ju9dDm0jg5HX/tM431nFRfnQXlEbDOW2PFl7G9IYS8EKBN/?=
 =?us-ascii?Q?sjXQ/MpcWySp0+bcD+KFk2xGAGmyD+lVM1TzTKulC2dxzTvyImNrxfjuIUeo?=
 =?us-ascii?Q?5D0YFeYwm1yW4VYovHR+KYcMWZjQGQNIm2Sbo2mNq65OUCOSfPTUBAUjMLkt?=
 =?us-ascii?Q?eBnyPKYchZItbMhJ9TpZCpzuETaiDims/1Y5RSlAHqXswS7Elgtf5GZef5lR?=
 =?us-ascii?Q?ub7fv/lgOShSs0l8Osf4AE6VRia1zwkixXx9UqxMOBfvobcZjoeyX6BFfQ38?=
 =?us-ascii?Q?VcbVz6vfyP8LAuwXHauwY6cYhmURGmM+009Kv6e13cq6pnB3Kh9PFVEwSCBw?=
 =?us-ascii?Q?ATJZ+zVcmLWMgB6NuWT8RgmvpOdoRpgnMeTrfPDnTiAI36FQHqXql+kk+S55?=
 =?us-ascii?Q?yVctxzSPo0CiNiu7RW0ajXtrOf+mBpANfRnp6t8i?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdf0079-cf54-4c00-82f4-08db91b5bd54
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:03:22.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ+ohBYVDYwfffQbe1PO4NzYjFU2ejoqWbBEOjnc3oEohQ6kbiwdgLxf6l/7JGep40gZ7/j55Xf7qHajNF8+4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Add "ignore -Wmissing-prototypes".

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 4 ----
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 915d1fbd554b..bb7215c6b8cb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -672,10 +672,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-				   struct mptcp_sched_data *data);
-struct mptcp_subflow_context *
-mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a80cf0481edf..5d78efc9c96c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,6 +127,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data)
 {
@@ -155,6 +159,8 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 	return data->contexts[pos];
 }
 
+__diag_pop();
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- 
2.35.3

