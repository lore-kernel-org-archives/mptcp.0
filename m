Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B28628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NByILl15d/vkfXsZXoTCb8q10/+xso3vMP5L9X05zPu7bNYbpD4BpS/5CGQfeDU3he00EdX2szrSWBJ6upAbWD592XXGhrTYfws7boTPvRw/nffItfrfEXJg7I3Hu5TXOx5k/fJ2YAxXoA/Q9qfAVLb6FbI7tyhYc8dehOZNIxRy9goFnog/VGsSQS1q+qy5Sq8MrlIJdwKybMHmp3a/Tkwf/s6Q0sjRrRaW9gRyK04b3ql7itCfGN35pzaIum6X9yHJDuuAZDYjVYKBjpVLL9l+/j+oYnnjx2AyA5zEARcV8x1TqkylggQ3Rm1sOXVinblvoSaZDIM1qgMO+qS1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=DY6x9RhDsTNq6vVOlxusq+63jjmf+/MHtZa8+SZXk2Wf4skNDnTViawZYYS2u9MoaqxtidKSuTLwrhlhnHLRQbO+anShtU+SFKUjLc+lS4bIvCfTBMSOhdl4/0UhLpxwROTmhMTMy/4tBi3ksl9+WONHf0YyyPXF9cET9FdoqrruMQuNoiRU5KG0gU1aRNhcicsEPKx/bG5e6Xe/V9V+7nUvlpk8Ia010kTG1OTE6uAy3Ry769IXCC3doEwJGvoz9ImPq2Vjv/KCs0uzmxRoBfCgHiGZPAYIOmzuqPJ6ArW92T3TZzQN6cqF0k0wyIYi2qP6DXm1UxrlpEE5ll/LxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=x6KUcZl8/GK4YyAZBtXtYHOIi4wdjDNz89cO7c+eXMNjHxWrZQ9BxzMlY2FMYGkACHMMaCNu6AsDuiiJsG3nJ6zwZ/VD4p0diXH/V+kkbUSgoC7flM9TqhuJFaAKsl55TFBsesEG53ThAilZebgq19E6jSAy0FVHqFBXH17YeWkhOxuELaO/f4pwp1KaD7Xpf8nlZrFfncppb6HIHLVA22/KHSrUeBlm5BcXNgJcRpOAS/LtttD59tTdZp0R4/KFOJhp1bFEwKbT1IAnw/d9GXMVsK6ijarBNs/KwLyAhITSOnFOr30hqjAi10EqVgcZdgSO34K7NJ70AnsohiiAOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 07/17] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Thu,  8 Jun 2023 13:46:45 +0800
Message-Id: <28c3fc14cdceda10becd0940028cdffbc2ad6628.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 803b677b-7fea-4095-dac9-08db67e3ff2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1yL8Yox17owKUKIsBk0z/o/+EKEs/+8Onoe8hbGMXTQP3FBK9R7TvLJwsfWTv9WyGc+gXJRM1wXsjPhgEbgK4pKu7ZLla3nq+WsaQ9XagaPVHsybyB0+2OtBRelVALH7kaI5nIpPUnI1aK5FWdWNYWxrsH6IZ9ocCXZTqaeYE1O9cNHIlnda39NbdNiOcqxj6uqfAjqtgesMRMOZUIVO6lCEK8w20gQTEgdGn8dwltFY11hjlKQQsryRVgB1rEwcXOG/4OxcmiUZEhC6hS/pWrOojDp9Cxn3B3lUwgc3EZDtlHP5PpbUKj3V28VBvpzfGXkFSzdVj9W11s9S2ceha+7C/Lgju5eJVayWv2gy43sFgJz6Ehj2GVpmP09+fqT7TDyvH3Lsw579nzi2B+fr0uGhFHxrYB8qhObZb/vW/Uuy+CVWE8ilU4W6B+N4WOSnpYf1J79foLyD7+kermfdvhg7nEDt9P4LmBdC9tqHzlMe2S+JldjjjNuw36UzCf+fTlRLVF5Z/HsNnL63CW0JivjP+OSNVjG6I16k/Pl69kO445AfIZzqm7OGaYuRqG3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qvf8BE/LO/vWutHjOo1UaQMvwlEWFMZsCO+eif8eFV8dL+0gu1oTXlNlaJeE?=
 =?us-ascii?Q?CwqSbbReAGvg9FRuo45xneN8zeLHBzVmsiGKPhi/44+yt7n297muMr00vKFL?=
 =?us-ascii?Q?lObJQw8JDinK6rYPdggScTD3u7CXHeZ5N7h5/X70FJE8WlVp/B1B+Clls5Qm?=
 =?us-ascii?Q?WT1CLSiZVb40tC/kryy4XfO/LvAFiLw509mFfGXYU0HY6ptdUpdbkdM/JAeZ?=
 =?us-ascii?Q?etsIpoar334tktkk1zclL4CJwx0f5ArgSQITj4ywIspFfFURol27do6P5IGR?=
 =?us-ascii?Q?G0ux6AJ+7w1/e2uPnzwdfju30bCIv+69cGBMnWUwzLLTyZp09c5qn+9FTXAD?=
 =?us-ascii?Q?k0pQIxA4NBLJocizvB62z0CGp3MRaLiLjbXVLU1w/7TrRHddAq4ey+X3C1GU?=
 =?us-ascii?Q?eJisYbWMb98JEOUYgEh5r0waN4TbMG7B2E2xe9WHl822HFGjOpEithqT0Sfb?=
 =?us-ascii?Q?rw6Y7PS8EzJZt05u3JagSBrwxVHaj+fiPKVSaYp2YHnjazL7vyfTkbykHOFX?=
 =?us-ascii?Q?mV6iUduHTFfrZm/qBMOdWwtrJ962WuAddASVi7A6f4T9DcNahTel6UTpVhBt?=
 =?us-ascii?Q?EJs+0+t+d5aS+95hbQXYlAYC4clpNj04B7uS9M31JGe4J1ExJdlwBjCgiOxS?=
 =?us-ascii?Q?95TLR690X5CU3ICV4kVd9nbulIi8MxIAjKbTFWtKWEtj0IOfvMCadLU2qG5C?=
 =?us-ascii?Q?IaUmd9BcagW6MpW0DozAObcuoCwk14S673UcMey7bc9PKX2LIIfyBz15VPor?=
 =?us-ascii?Q?3gRDyrJkov9mRsgH43u8992zQ9L4qlnxy/FfSZXXDgqlAZNxSzyQmfMHNRwv?=
 =?us-ascii?Q?H6FyVGPs84P0kBmNHhp3Y06g2OIki+XDDIuwedxaq5sy9698HgdzS2BVqbGQ?=
 =?us-ascii?Q?M6W3WfOTxJaUDqeAcje/sG+RhEWOAQf67S/mlSkdwv6g9wyi3JfQba7761ij?=
 =?us-ascii?Q?MTZRA8dcigfu+tJFcYRBY/1mvCinhF6tXPEPUOVvbG+r/FpDK2myw7LjWp+F?=
 =?us-ascii?Q?LN/oYMiHDMQVGdfrM3M09sMMKm+A6YYcXxqINBEAtS9IJ8clSH05wUiJN1Rq?=
 =?us-ascii?Q?PE0Ih04OfhxZStHxaXFwE8Q+aX4TeU4tiZDnV34/HatGPqaDex0wZaT2t933?=
 =?us-ascii?Q?7eDaqZmRdFIFuUkMhbkTbYsRdR10EMA9Vk1oGsmJQ0Cm8CN3DVCPw0ige6oL?=
 =?us-ascii?Q?Z2x+uqxISiQPgfr7zyJRUTHFiWOemR+AmNMK5LFouW8Ni3dZS9QryH0b/74t?=
 =?us-ascii?Q?5RgEUAY/LoCVNA5XneTeE0bRkjEaxVSXoOVi09EyEDqx8abXwqasQRFAcNO8?=
 =?us-ascii?Q?RDiHsRWgrnfTzZ82sPWGRX2EBy0VXex5lUvkfmeF831RyIyIIIlzBKzHomch?=
 =?us-ascii?Q?ZoLFKVZ1LwiO73wPKmdmBOVwose76640vm0nIPiP0FB6t62b7A0wi+uddfuW?=
 =?us-ascii?Q?myMuSDzW5sa04+D2j7S2zSdoliWSnmc2uH7cNRUMedleBzvXwr3jcS6ewO4D?=
 =?us-ascii?Q?08GbQOXpU2+wxB8aJ4rAUqrQSDAwH1YVkbwoJuDRmoW8UZE5QI63zn0bOrmV?=
 =?us-ascii?Q?QmMhDPhs63Lbv6GHnMZGLxQyoXP+AF5G5M9xiz//?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803b677b-7fea-4095-dac9-08db67e3ff2c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:34.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl0RNBHdk8FvWYrz6IkocMTPMNZNhRWr91u3wVXF7+56bUb2m7l9wezSALKeZGiZWs9BqN2WESKYw//BpfnqXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

Add struct mptcp_sched_data write access.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..e2ed4223617a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_context_type __read_mostly;
+static const struct btf_type *mptcp_data_type __read_mostly;
+static u32 mptcp_context_id, mptcp_data_id;
 
 static u32 optional_sched_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
@@ -41,8 +42,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_context_type && t != mptcp_data_type) {
+		bpf_log(log, "only access to subflow_context or sched_data is supported\n");
 		return -EACCES;
 	}
 
@@ -50,14 +51,18 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_sched_data, last_snd):
+		end = offsetofend(struct mptcp_sched_data, last_snd);
+		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to %s at off %d\n",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
-			off, size, end);
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off, size, end);
 		return -EACCES;
 	}
 
@@ -141,8 +146,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_context_id = type_id;
+	mptcp_context_type = btf_type_by_id(btf, mptcp_context_id);
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_data_id = type_id;
+	mptcp_data_type = btf_type_by_id(btf, mptcp_data_id);
 
 	return 0;
 }
-- 
2.35.3

