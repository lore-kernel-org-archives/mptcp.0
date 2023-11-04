Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12B15486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eyOOuX5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLHTfSMQV5Hf/rNg64aQaMsuTit9W/aUadt3SMlLVpGMUK12oWYyE//6Wtgs72Zrh4huhFPDUHKIksrfW1hqO33TtKzSm6jmR/xE6aA71B4dsWYAXZUsFjcgJdcRjpapPjagdezpIkR219YAgLaeWtlpYy+0obN1J9WyzAm+tOYhCpEk9jg7gnCDvXXmRV37Rgytp/S8s4xId0WniptmifE2AnvG0CDY5JIXSjLNGT4idrp+dJFFThhOcrvjHLT9JDV96IYSgtHW8J0mb55Pw0zitzinhvBAMSmIyrh5H5RMeaSD3x2RQCrmwFDBF0cQyggAI0DSHcugvqLPAp4Gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhIycnYfWtHYIr5mPO7ymBb4JwssV1JuDraoAyfBKAE=;
 b=Ikv664DB72cce2SMlWD2/y0PAsRnigWSL5WWwdKFeg8bkj6KsOnl3YBOdrff2+nrlLmp575Qw78DWU+ey6JwqNrTFu3NKkPJuS64sjrwcIboWdpwKogQKO6swbyEcbeMEdBu+sMvTU7VqMi+V8X/fmwXgTYJaMdLy8XbPYWHN6++6Am3ZbiS+VSMU1J/zIZ48FRqR0oIoc2d7RRHHRlPpmBojxI3+VVn+S8rA7Gu7ASIFwZxKNaliC0a9sewRJhDT0/+ZKM5KtRM0V/w6iDUIbL8Ij6FQA9zGeX/Bi5o4Nxnz6Rn5XlXeClvC2HnJmhYWMuDIfrBHrVONOZ8yRRnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhIycnYfWtHYIr5mPO7ymBb4JwssV1JuDraoAyfBKAE=;
 b=eyOOuX5jDJbzukiALZxca6PHTDtjZ+pMz+OUveekZDLJSYB6Y7CAXSWEz1yaASV78Fok0+B+4EMbovU8gVM9jBpekhus6a5LUVoz3eJE0x8NgjYUNFFiF2DoXhBOE/wiNq1Z3RTC9ahlB5TYKvcXKhnvxTKl1xIrh0ph0TAHWsglafDz9X5LMGtG8YTx1iZW6UvR91MHmDfPe0jdeDuHCGKFfvo7fQRjWusEw+eyyoIYmit77MxamfA9KqTHzvgA8JI2C63vG76vAFZ8MukKGHEvFK7Lw4hBuM7/CBt/nYnHK+rYsSCBQZ5wyt72dzjMSXtBVXKWudmmiOUPVFhEgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:16:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:16:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 03/12] mptcp: rename free_local_addr_list with prefix
Date: Sat,  4 Nov 2023 22:16:17 +0800
Message-Id: <56d53702b40052fe55a6998a398b372d8d24c35a.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 787c1a44-3f0f-4ee3-a35e-08dbdd40b349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GjfF2FNl0zBiD8kVOv1bjMTWg4DOppYO+YOL9AmyCFl4A7d9B9Yp3t9ESbxkpON142tQzw65tf2VyVjJmaCamfO0i/Wa6DCw+iuCuHJNX9XytLuIrlXSo0FXRGcMsgkSaPqtpADTTxYMFDg946EMlh/Q1UVliyx6r/ZCrw+J3swZqfms6H2TWmIFvDWj91HUYghjiMzye3F5I8JXEUdb3Atez5Aqhm+avawKMR7kli72Qc2K6asGWeSumZ/M4WJhgIw8FjVIOsVuNM1yWe8aVi2Oj7Mqh2qhDhyJsYvPCuMg41z7o9QKIpdJLrwRdwNoAQDO9f/BrkKTk8tTbR/RiR4mzaHbEqbTfueWzt8Z7xzxXc9UBaZ+KuYn6P8ia/J3c6wqiS030lr07cMTVPDkNWlmteCdOmjS8va7YyevlW/cVZH2nSsQw98bQboKieT5m4tyBTLpwbQkyPfdeJmG73yfj/ozcPzwC72xQOOKMYwk82ZpeV+jD9zyilPAyV2I7y3I0ak0uZBkyngT97xzap20dqtTmi5slgGuTUUuwMKvo7uvmR+04tPR/CjVT0rrkk10oH0K22I6+G7IXd+KGVBOyMEwsjqFPc3wsyHWYkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4qkbWJh4kVtkW1oxocsmkM4CsOmrFY4zzbjjhTOSwpdOp3hNqCi055dGhSf?=
 =?us-ascii?Q?7EtDDBqHxzDm9C6vOS01pIFFB16z4t6HWnBjkxY+xruTtAWAP24W7+tSmsRS?=
 =?us-ascii?Q?cyotx9aqWKBORXnRO7LeAozlcsyeU+YErXwjzw9kd/MWBVaPQSgzTjtkI8NQ?=
 =?us-ascii?Q?mv3SbEMaNItPCflR4RZPmhgiqdXFmP7zrc31VmpPFuLJ3THoG8VpEZnbs9Sf?=
 =?us-ascii?Q?3WeTiGhsNtvV0bBgO2CtcPw4yR/l1Aqh1yPnOw6VwQCMi88eDahmfup42BtP?=
 =?us-ascii?Q?4g80dEw5Bg+shK9SlzZ6F6lHDWXJzT9P0R8rNCVoSl+cpdVE7J0NrtOIUmkH?=
 =?us-ascii?Q?KmU9p+MP72v23OWVTM1YJhHa5HF7KjgF5dd9mk2qwXWb9DSJjGYxql5NOSZ+?=
 =?us-ascii?Q?piWHC9LmbHJ3nZ5kI6VyPTiRXlfuTpWy+9ICvAc6r1Irp8iToPFhDm1Poamr?=
 =?us-ascii?Q?AtEsC65RpA1p8n2HQDLKkp9DxMlfk4rXlYZMBkucMa0Qx/gwI8XKTGC1Cjee?=
 =?us-ascii?Q?zhFCwGOqvMLfLpHHSAkHRtDbT0j7T5DI7K+FlFq+065k9RfD2h3MDEYNxJfF?=
 =?us-ascii?Q?JkJvCR4rs3BMNCQLF0VdCLzPsT4WJ9r4bxya5lVzIC9MutaUpjIzjo2U6arp?=
 =?us-ascii?Q?gaOBLXC43Dv/GSNSg0HpX2kqnZ2Pm5dm7wRXekfUrj4ZVobts81njX8HRxaT?=
 =?us-ascii?Q?pPRlL5Y2NITpdWGsYmY12/xShPIxj4pd1oSXo2SLvQ06l9FByjXFbgJJqqSh?=
 =?us-ascii?Q?wvbwZHe+1wkpX3zL6KIzcNc1CwVSSDTsMgYcPXPAXdeY5LgiWpfkgOINa892?=
 =?us-ascii?Q?1Du4V4lEuaV4hc4Q6e+EkNqqXCu1wmsWENpUtIsDcpRo7Rp1/DjKCKaOYKNB?=
 =?us-ascii?Q?aoXo4rRlHz/PNdXpYn/TPFBoZuKxpW8+UgkdM9QDhY4SHBIqDj232fAw71Ox?=
 =?us-ascii?Q?eDlZP1r0c8OMzCXdYZMBEPBlT2mV0xujmHip6NLsvA1Pv4lgLWyx9REp1jGR?=
 =?us-ascii?Q?wPT7SWBz3zfvQWJFcR977EhnuEnpRDMjjwgL6/EiyOXT8GN5iXJDbul/SPKa?=
 =?us-ascii?Q?H2jIxYBec5dwesyJFGvey75eZ6abxAwPw9HrdLUvQl6iF3dP4GBW6mRYcC0d?=
 =?us-ascii?Q?lewhpBjme6VxSK9E8nOAhyQdQ0fx5yHBxUQIzfigoZsLtItUVshcTl4ZikXE?=
 =?us-ascii?Q?2Q4Eh3hfm7ALBGY8KYl7F4uKN2Er+ZkCps4FEZYiqolQKyW7UexIXAFkF7bC?=
 =?us-ascii?Q?MzJ6BXQ4Hi2qmTQXa8iUYb/ZKiTeLhay6Lr9b7/CaJ7N7ZPIvGotOLhBGv3j?=
 =?us-ascii?Q?u5/B1FGMMJDTrj3szGSU9TtLr1IB0lySpBt0bxDBWOQ10I+bxTPEOiXneHkQ?=
 =?us-ascii?Q?HuTPfeiQgnA9B+aWDQx+3rWvyabXv/DcLZlOg1n6DT3NtmWtIWPZ5afaUeF+?=
 =?us-ascii?Q?XSDWxokTTvyreNWeHwbou3DfLsniWLJAoMaNsCE3+KZIAbsnsarONo4JmOMu?=
 =?us-ascii?Q?qyytLFfff4jhGR/NUdn9VSo5EJqSs7LRve8NbYR24pNQd2P0fz4tQMXdDHpj?=
 =?us-ascii?Q?6c9YpmksAqUlopkC2D3OK05fQwbmtoyblPJVb4piJVB3862uhRxpU7rFc4DF?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787c1a44-3f0f-4ee3-a35e-08dbdd40b349
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:16:56.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMHUkMYfPpZtVmPEMRe12JTW9qs1A3HV4wyKbHSRTPgjSRpTy2W15ydACCmYuLTc5NimEEnotJB2QhQWL8UunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch renames mptcp_free_local_addr_list() with the userspace pm
prefix as mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a8e35677b6a7..577b6ff0e3aa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ad507ac6bc7..3bbccb53eb29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3317,7 +3317,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c38a2126071b..953632ba7eb6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

