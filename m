Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA657FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRmOIXNATj9kh4APL9v8TKuR/y1OMPYY3wK2Ycyp8ud7RCvqE2vGCcVT3ju+OD8TquaqygmVAGRAuZ7Beb++Ke6QBgjNTCaE3jJZaRgp/hyCscVOIdAijiTFEqRZ3XAGJAE5K65kGSdrn3R43iK9FbKdYOmmaYEu/Kc+81ngOiGqL7Sriqxy+c7BtB+ZVQyK5aNpvgZj312id8r19P/U0b+AJJ9Qm70gwY6QrLAE+2Uvg2pW++xwMKsS08C+bfmallBrn3DTaMGFKPDQapHEV44JV5pWMTG2gmInIfX8ozfUboZxc6wP+8UWt9M4lhtqiTmYoqFFs4GooR/TsI1C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpdock9eMDsSOaOjd18QWdwWQwYYF43moOlqVaSz+fc=;
 b=ELbhIsNUMzjvM0HnxJGzOvEOZohXxhJCkNBU3PWWyZCd08C+FlMT/6dcy5ca8GUEh1x0r793TkwXjKRRvUdqo4+JPIL/1uc2zFSKAzbwQR8ITAzRxmLesh3xJdBiglp5SUx9xYUac7JIhqgzq9CIWBeo491dP6bX2F8iGh6kHc+UnTKFH+fn9KhrmhilsJF7Xwt8+GQuCA1WUXB3HlEyFD0tygqDo2iG5AhNmMlgQ6/lN3nR6w420Sx5ZbS0UKwnp418xBF2GTJNTHANTGo8/T/bDhYt1GXny+CKLrMkKfmJTteHy5cc+vi3ntddQ/r+HK8S9iSGQfXCFuhxfdlqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpdock9eMDsSOaOjd18QWdwWQwYYF43moOlqVaSz+fc=;
 b=TTKT7LOh1GjchnIahUmRwUILeRsOd897wx9nifjV2pRZ0pMry6UIYRERpS9mNrnq031ZHxiWz5PU/J/j9Fixfu2eALivSAGICP2IKJzh+qGHhCNNEnLMy6iUl6bANw5vGbk0lOq7VcEAjci/v5ZjeDpCzblrWb+x3YkjWA5bASSwKE59xIA1Nb68yA0uAEoPNbJeas2LGv92P294xqG5ovxnlKyWO50V5mtQAJzkIzpxny5QRp3bvLK4Em0gBpEDhxpSqJ69mO/KB67VP1vpeJLFxYnfnrwZ0lsbMXJ+fyOP6uKi7qxvmK4A6/uyXtyqL63ilavxQYnnxm12Em/oyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 05/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue, 27 Jun 2023 09:06:48 +0800
Message-Id: <f14791ebc5ae873ba661f7c35a908dd2f761914c.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d4befd-b188-4c4f-9365-08db76aae3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hvyBsEToS4UWt2Sf8n/ShnsiPdvpJ8jUtcaj03Ps3doCyShrod9tLccVjCGquZwFRS1NQUBSl/gl6VSn4FlBRoMUmgThXIPe8JDbJYg/ZspRel/BDORm/8AdvOh4qONEayon1t948ETiUH2I9HJALdfuLsV5OaP/WdWiRMRKdmPNYmowV9i9TUajR9/9yqQfWPH5O7WJ7UohzmODnF4Hcmp5vhaVGTInLYf6GqNj0lzNrRfbFvfKngCVxP7sVcN+qRumegANhdgW/uARkkd3gh8pOfxKfALEvtxkZ4+Z12oxzwDY7kyi1Ax7DpxsSs/PZPmydPn0Z9j8W5+cCliUqrYXoQs5NcAXSHWYBFw3GusHIiFT2y4R5fj2j3jZHZx6wYu54vJ7Bd6lFTiAZvnZlehD8FrZTPYtET6KihCDi0GOPz2DiGSLILk45/2Cyx1g2hZ2ODW26yJ8ZGpe5magmIvejXRPLjLLg3+lolPl+tgPKViat6UmH8lzv4MAkAZcmtMocdslvoAbmciTqgSy9lA2gppOYrAuT/CYcouQ3ttyBgyRKa4GO4QMfi0puK1b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SD5BcbgAcMEMs4g4svjZ20Yv2Fp5r+9mQfFkqJdQnesGYQO28I8b9wTOA2Tw?=
 =?us-ascii?Q?f/6aKDfvNSrElA7etd/8+Vdqh2ehkUCCn9rYqFOtUI3/LqbDQvdpqtfL6ILw?=
 =?us-ascii?Q?RCVddygbCO7H8dqs7DapfL0IH2iTsORglMB288eL48uydG93D0YyIxeu5eeU?=
 =?us-ascii?Q?X41Ss/VDqPnewtD385rySh+Kh1MRvgUDyPqpIJdL7lY54oMCEqxLgEwSeRDw?=
 =?us-ascii?Q?WUurEjJxlcSC5mUxPILnFhIkvnUlCbX869icfhS6rRwt6vWhVIhbURTdLnM5?=
 =?us-ascii?Q?cQF0qBIbgA5k4ngaBsJbQlicsWxcgdOxOWtbdpmWdTIRiPanre/fT2lIXyzB?=
 =?us-ascii?Q?B0SOxJAzCNN5iJYFy5PMKGkTtAQcegVd2O9aU9YE8YBzViTlylhHloBunmiz?=
 =?us-ascii?Q?ws2qP5JBl6wc2+/nXtjIrg8D2pAH7ovsvPCrxIoU6umpZLNhho6GlbcPBiy+?=
 =?us-ascii?Q?vPiFaP/iu+qGiZfrYKS9AgakETiGn1O4ozxEb+jFe9voqlFzi6qP7Uxs0kR6?=
 =?us-ascii?Q?BOI6++SwJhlwrWb1WNjJpefB/LwNe/elmbSR0kybWMkqqAyDV12r268MZ/4b?=
 =?us-ascii?Q?iigfE+Gf2Q8u0KRBw/BxZVyabPbw6h28t2uJXfee3KJ24Dyc8tTrldqzBWbR?=
 =?us-ascii?Q?jSe0DX/9szBFlb99yfDAcZ5NA4/O6RM0WRZzJT4t6G/rGdZGOTg8tE//WXu3?=
 =?us-ascii?Q?V8iIeU3aCErv9Z131jNiNxzHpvgjlbs9MwpJ3mksrF3ZgnXysLhEBiegnRlU?=
 =?us-ascii?Q?offqvmCDs1DbO0EiUZqxONixV7kwLucMbKrprm6UYAjJlmV1ksI1hHsaJ9Xk?=
 =?us-ascii?Q?WvnXwKoZPcpRbKQnSMoUz++v1Zq2D4LATBIPSBD0Npf3mbTacVIHe043T8zX?=
 =?us-ascii?Q?9cQ6FaQ0gnCLOZAHpl5KJrQkoRzf9ghns3pcAXyubw3AkbF8lA/AID+hJgl4?=
 =?us-ascii?Q?6RZgjq6FJdkaR5QEcJQ/FPLmUHdUl4oTmE9roj0DQ7A0QENAc4ZtaJSrHHB2?=
 =?us-ascii?Q?gRIrYGC6p6aObFs0x/y196KWldRXJsHfc4M1IPD+cvEIfux9O2imTUxdkpWL?=
 =?us-ascii?Q?PmISTkzJDWyPZ2YBrW2Qf2YtrpFuehSpTYr1BFABL3gnaLpNP7Z1Njm14HsG?=
 =?us-ascii?Q?I0W3QRH5RsY/zqRx7T5FF1miGk7xrrBBRz/+/bhRIzxQha5XHAhM/7zvr6Zm?=
 =?us-ascii?Q?/EY+JOwIfBgSiMWr5FRKomrivcKaPdFoinh5N7nbKwbxmPnGwg8J3PVgbaD5?=
 =?us-ascii?Q?W2OVnFH4WrfqbwLRggozwG03CIVmS5DLMKiuWAY9nWV/IO0pbTN1fDkvqCkQ?=
 =?us-ascii?Q?TPJh7vLSzTjHaPtFsuv0jXsgyh+FW4lyhfJEeCYbNjoMYHyTUsE68kcs8Qav?=
 =?us-ascii?Q?i06SMOan5//cFOVq4ICwehfb4toxUhIEpEhrEyJmUif0fOAVXt88h1uQyEKA?=
 =?us-ascii?Q?ecbwZwu07x5O4KC0lDl9UMcl9qmVZQS4IfILJYEzqTAfI6UNCI7qKwXlzZS6?=
 =?us-ascii?Q?Lg0yMldZjUGfyJSa8zbwke8M/RlsmABe799y/DTGcsrHAGeeGv0713DMa3Q5?=
 =?us-ascii?Q?KVXFHAiMDZxqlxpgsV6xpdoQiJJyqxPBaUp+2MJZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d4befd-b188-4c4f-9365-08db76aae3a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:34.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTcaD7wSjxhiyGfxYbQmRF8zfec/NkcUZm+GJB8veAeqJYFaxTrJUfEaavnj9HafUCh6MVIaVtpV/9/xIuoL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Add accesses for bpf_sk_storage_get and bpf_sk_storage_delete.

Add write accesses for avg_pacing_rate of struct mptcp_subflow_context
in .btf_struct_access. They will be used in the bpf_burst selftests.

Add write accesses for all bit flags of struct mptcp_subflow_context
between map_csum_len and data_avail in .btf_struct_access. The stale
flag will be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..204dc37e31cd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <net/bpf_sk_storage.h>
 #include "protocol.h"
 
 #ifdef CONFIG_BPF_JIT
@@ -30,7 +31,14 @@ static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 			       const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	switch (func_id) {
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
+	default:
+		return bpf_base_func_proto(func_id);
+	}
 }
 
 static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
@@ -50,6 +58,12 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
 	default:
 		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
 		return -EACCES;
-- 
2.35.3

