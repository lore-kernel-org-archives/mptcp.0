Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C9B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="iYRXq1ND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyQDvMT9l4U0rMAAEZrs5SZ9S4kjfsbk9P7iI9325aKqLlv9QXM6Ynju6AYgy+BqlysXuxCbdD8Umi0rm2givASQTjfD5B6Cx7hfZ+p2GiNdC1U4QLQV0dr44d4fh+Qh06X9rmVjyiPCwj70u5+HcHgs1iDDqJF8SZ0mAO0E6WQBRUr0rAfR2HyqNmzlK3q4ljiAkA3Xdwc4TvwxZBvaflVJ5iQ0i0fCs0s17qFAAJ9ST974ApFDI7sick9w4HcTRK2Yzbmq7m/MkdEwuIojO5j5v6+0ugg0Rl4oQbYpcboCS1JqQlxgzFqrs95s1bDGc0166nMVI2j8Y3u3flbWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKizeRtkCNykYCfh/WDRPcfFnyiocCES1DS0PtuJJwA=;
 b=UT3CSe52A03dQuau4vJHK9zrUdqnEsJA7JTtss9SC55f7qYgyEn2IkUhv8iTXF8arVr6VC4+JdeVNDFgRh1wyeNYYxaR+7Kx+Y/AKvjQOh0TjleMJGl3heDKshTSVEQNJC3Q2f1Mx3SZrYBGTj6ODNRNDIhB/85No9c6LD8PUcPK0PrtTd+1ZcqKWKM8Vr+KUXXQNyrNz4TyWedq/CgXQ1/Ao632JqXhfWtsTPupq4ErXKNwN2dM0H571WINdd19bR3wePRBOtdwPMRXS+df1uvqEnZX4SFjSL371jrQaGk4vnVvx116fFtdHFD1uNnn6DLCo+f8P0eG7URPXJDX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKizeRtkCNykYCfh/WDRPcfFnyiocCES1DS0PtuJJwA=;
 b=iYRXq1NDLbBpsmlOU00tn+mOL6Kl3KnDkYc/DCylk50G+emOt/D7vsNPn34SjSpdwqcI9Ty/Vt8ZtKdx2uTXqr71/BJSMqBFpl5Iq23ckQ3mi/+kbKIUpPLYVgYKvPC0eBNajuWrlvoCWDk9arB7sd26z4CKBuI5KJkLsjEke/lLXHZhRhQVv4ciXSYHX0rWlJjWO2I30drvnGhlW2yiyUjvr9WNq8oqj5QzUpjAifxw1bwfZhdS1vm88pW40EkLMcoxCQMRSDTD5SW+Ka5h8cawVfrS1pCdX5sov8DVZd0aBewG1PdmPLVU4e7qiiyhPfejio8YCsUjKcl0KAomOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 16/26] mptcp: add a prefix for free_local_addr_list
Date: Fri, 17 Nov 2023 16:56:09 +0800
Message-Id: <196741f2d3541963adbc91ab23ccf256bc45bed2.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: e4386c88-2066-4bed-218c-08dbe74b4ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q2HzXO7lUjeOqCz9Q3TfG+zRz2mirkkMCWUbhe+ma2+odbL/aB1lj+x5FG2TzeXTEmAPeBkqOavQuOtDUwZD8ciINi3zo9KDQ6xr4qbO3P6nyqv4EvybRw1/6+16DRAZ00kiVkBMJ3xgj+pEmjfg8C9FEOqQ52ahwEGRtCi8ekCQZQ+3s5g/BOBleGZzIlhkMaroEOtc7s3gtSoufwbE5dTeKXtwEd5z8ZzPjfY1azfvVvM3zNvpoNETEum6PdE2KjvlZy29/K33jGyRGqOJ7Osu03BqcRnUc/cBPlMc6JKTpn2/DiFOks+Gi26NsyJ32RGRk7Pqe6twAGw3UzmNQsWaJT0xZ6l4SsmsjrrGSiTQLbgFgyax2q7Fl8IuMySdWx855ufTYU4aEqbNFNfpQxm2Gvt2zofzouj5VQq3yYNy2ES1uoQC8MuxX6erH1Mcom6+3psO9wLaQtYnx+mESdCNRNw7kXfPKmX/tvUUAcEB6aQKj2MxlF0tRiqEre3RvBYCRKrKfYfF2JogBUq88bpnmSCS3xbQh5owOtoaYo3MNbkbmrpWjaMVGv4GZEaF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(107886003)(66476007)(6506007)(6666004)(6486002)(2616005)(6512007)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(26005)(83380400001)(41300700001)(316002)(478600001)(6916009)(66946007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gVLxsp1VzuVS1JK6V0FopL8EvkH9AmTcFTByTDvWnrVesBkzMBzIgTpd7hAS?=
 =?us-ascii?Q?KseWgMjbnwSNuxNCfGb8cxONmfiPHjOBjJ1r/3eaer6VJTOOnJptUoibzZ5S?=
 =?us-ascii?Q?S1PtxJ4Yzt7Fs5RQaFQR2K9X9riPviqDOuhd3yhH4Cj04p2AF/ZOU8fyUYKZ?=
 =?us-ascii?Q?wC5peS04QxRC4DV5fDCRt2Sg6kXMTyiqhJ85SB0DtoSzcrgnTuSpCtRyqFYe?=
 =?us-ascii?Q?odzOX5CI5lnHHzKIl1XS5wHBDbNpP/2sGIglcgJxntXx0nuPQddl+Qz6ZnG3?=
 =?us-ascii?Q?NQELX+pUK8ogkamOnZrCDAUDVausy2NAjYfo9Vw0EGyTLG5iyr3dUtqtFK0J?=
 =?us-ascii?Q?3oT0KBDj+T4bvM3gGOItCj0wDdScVCahG8T6roWciyIpMW1gos9YPrsbiB+a?=
 =?us-ascii?Q?7wSrEgzI0FwYdenPBnyT+ZXl/4KCq9iSLILn3NLnmjCOIevyxCDUff0g71YY?=
 =?us-ascii?Q?dhuVgEyIfQcQLkQXZGc+zJWxwPwz0ge2AK0u/AhJZreEoO2MGmINr9BbgX/K?=
 =?us-ascii?Q?jlzRQnVq1xEeIUOlyF8Z9RH4ZpY5uhmNsMLp2vd29BhUlJP/+EANXIKcwaLe?=
 =?us-ascii?Q?X+lRxs9IwgMh0knfNeDYN63Y2jr0fl/LAQL7+hXTBY/d6SGg/pUQgZVEhOuW?=
 =?us-ascii?Q?LGmmOYKT0wlW+nDdrDZEZs7AhFtMXbaOFWgpbhSdBua6OD9BZ0q9FEkqbuSl?=
 =?us-ascii?Q?ZEYyAEhLkvsbrxGNU8yt8Eq+Xu1EUovIk/tRkih8PPUeaoNkCJagZYBEf8qD?=
 =?us-ascii?Q?vlmFIadWMK0H6Jg+hMXwK5heoItYqQolq3V4/5XJDhJ28CD+f0OQAMiux7RT?=
 =?us-ascii?Q?EVbnef/NgodG7gJcpHjT+yXGiJrvR6YTcWN/vJrxRVVYRrlAz+SwPo1bbGPx?=
 =?us-ascii?Q?iprKtfAFTMgjmdzqdwMJZuMItcCoW9qojCgDBnkpeOD1U/7sy6xPDXa1k9gQ?=
 =?us-ascii?Q?HjnoA3JnETj2wziE1199ppPi6RCK94a2qYiCe3amHNpGgOSbvOFZLU+wVZX/?=
 =?us-ascii?Q?QNx6XWugnwjkd3YfPmZZKsCVL1AIQRXuVia94GNXT748hVYxaVGHvivh7eu4?=
 =?us-ascii?Q?xxDDN/b+qBiz8JNX7TMPzJwTwxg0cr1XigZ2P4dMLW4wrmXU0DP/5aU+0I7C?=
 =?us-ascii?Q?DpHLhjvRlfyr76PSxkhQwQjPm+DAj/k2MJj6cdsSlW4fQRwLs2ONzcxuxXxR?=
 =?us-ascii?Q?rr2Mjbz7QQSCk2L2uL3PRw/lzLQlwCom7eHxbwa/CtfEvfW2G6QJm4015V+P?=
 =?us-ascii?Q?zA431l6YXL4VD2fmYkdmiT71bm5yRdbqvz5syJVDi8bE8TaK97fBoP4SxsbA?=
 =?us-ascii?Q?Vi9R5fm/BG6ruIKHKpUewf6yQJ8MYkE6AyHTLuYBAgwCkx7UMbdvYHfTF9w/?=
 =?us-ascii?Q?1jYnWSAWz7F0Q/1ngMBktYa/wQQ4qOOwCNp419lqww4quvse/2+hgFWyqhRk?=
 =?us-ascii?Q?4w/eELnNLrficY8irp8mGsF1i6tu4nxxJWMYe8lp+DKQsxkareqqwnSUT/RF?=
 =?us-ascii?Q?arw8KHQZJ/tI5QMzDhpxbfJAp5sorYxnKx43texQ86ZXPoERApNs9KvkmFOn?=
 =?us-ascii?Q?hOejlBCXA6t9MCjXxwHKip3fNcBU8+NcRM2j4Wydv7xWygVCgEcu2fQoNVql?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4386c88-2066-4bed-218c-08dbe74b4ba1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:58.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzckilPo5z7ED/VEYyMoTsHfo8yUltS3mmKRl4CrA0NI7vhSElCaNKWaH/NdZWUHJvgsYnQX8w/syugJxhBhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 489bb0e61118..87cf27dc1d0a 100644
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
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0460cb391ede..4999bb6241fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,7 +944,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

