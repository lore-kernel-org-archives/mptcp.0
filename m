Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0D846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aiAj/dSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfPWiZh/rYqbE35GJ3pomvD4fkQZ3+7zfMnFmzE7zSvp/xKEM+qHSy2fOCwm00A95vPREeMcWOZNH+I9CMcOmR6Lq5ENMvWwKHeMlhoOUaM/uhlD/Uf4Voi/giw9P6lR2HlNCowyzdrrsqOslzFgUpL0ZqD1Nqg4xskp7iQgLmQfes6qpiT5pDeVVyJ8lCj7f593B9pEY7CMDKVjVhqw9KJ4e2FkE9ZPydHkV+CM3HgGGtRQI2f/qZGSH2+R8UiP3oJfNXmNwM8F3DAvMgmvAnhJKxWcNvn6rRwNzMFHJSyo3cCLNhvimd2NpWlEl6X3Yomlkdjx2px+icXdv8aVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNDnnZJGrrj0q7BjBYijIDETOUpdMFOBm16mtfg0jzU=;
 b=Aj9ji27LSLuh3lAF4+rRiarB8oEKSVvbAESkdlJGnCdqLmGhU7tAT8H8f3wUqL2Q7cRsvLswx9+XjZTmL1ttLisuoeE5lhpjc2rQhO78JWESv2XgEw9FOXwnPkIT8fNB1SaKlHJIYq6W3i9kWowWNE1EXh+SEJgtLrXRQQ+pGRBILEBwdUGAj7Vxpwuw8NOTS4dSmOjDz7k34xNCcuaXvNc/L3NaMgD/KNPFZrgYqJFCsKkOzik0ANnU3DGYhes6qY/Xp6yb7Y3de8TSxHFqzSwEGWdyAtwgZqGD+Ot5lbue4D+HtfBdaP1zQrAM5nRbsY72x3ie1j5YZGy0udtRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNDnnZJGrrj0q7BjBYijIDETOUpdMFOBm16mtfg0jzU=;
 b=aiAj/dSM8nGiCAKW08CT1kOnpysAwzK1GUCn6mxGw5jBEC3mtT8h8wHT4weATKw1axWX8xIT2/dAqvmkb3qsyWPdMu3+h4OarRToXXOMzP6IfirkQ+Ep6+vKxu42l37/7FDor2QCscPcbB0aahA6mNOac5k2yVD+vrTwTZYwACAg99sTjGQTpQLjaFYIRmhjSFcXHQgSFsJLqrN0xzE7to3MvoPmGB/ekuOv2fwwrOSo4iI+p1oR8WhvW1UR5h+u6BwD90U5x6W7S5A6njkCpV7Xcp1z2N3x1XIeJY69UHV+XviXV+CCFxfyYTpe/yaCK6RcqQd8At1gbgmV0N6dSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/12] mptcp: rename free_local_addr_list with prefix
Date: Sat,  4 Nov 2023 16:35:38 +0800
Message-Id: <afbab0f27aedafa10d44e153a8cb0770c85c4037.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: b573b1a1-ac35-4d45-3971-08dbdd11198d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XBHzKhZwnJXMDir9kc0ZjHNpxxz+5GKmEoptwDStqBx5y31SwgvKC480s73XtgFIs+6xlMifPFLRl4puKB/hHxaUhPL5zEAP5CbgcpF1GJOhF7wYIm2pGXxCt+id6VCX4v8xcyMD9v5BqHlQHgyEXSDEKMdjI36q6XLy92szmID720J+foOmwsrrEZZ/XiKkHwOnWl6icUo/tl6uVf1OZ7p7Gr4hC5x5n3DTFm3J+GGa/SoCjI1hq4SV211ZCqfVmrRFA9D7tncsrPWW99DA9g/7jDkqWhi1/zt0MdV/L4Np/uy79kannc7vqD6M9mdifFQJlXpUQ7eu3WxetSSf0kjpWWh5Fukd04aGCpe5b9BtCfe9zAi/2+UprqUfBAU9wdSq8h9PVhS+yvlu+fpdxweJLK86lo7eUAdeVct26Y2lDbzZJguHIs/f39SazWJnEbOC3zvmb6FElBoDD+x2yq29FRDVo2u+XhrsWaU4K/GdvowHtaOeXPadJJoZJ+BRQRN+oO9YlxTX1h4mJ7+ZgOoZmvNyGeNFrjKC13L4SMA7NEuQpC4SZt11wkaZmmRIjN4MsW2dM6YKLAFNjRRlWBSpigYK5k3NTCLIgL8TUhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHt+2x8mKaUeWN2+cbnz6C7xsgp0+sizm/vlJs+YYqBvAWqlwT3jwH3b/2dt?=
 =?us-ascii?Q?f3KK9+piLJhdz6lKpKFp8PmvIIrTjy4kmAbxYaA8sDyCa6ytr4VnwI49wDID?=
 =?us-ascii?Q?okYvRhmXoWmkuBB+3mlkGlHqc2Buukj80QjE6JXJ4x1WEYEpH4RvXqO6UER3?=
 =?us-ascii?Q?vOCnt2KvvnTPFP1GhzF5mswsZ/qiZ0g2LC8BWiWgAmdDY+9BkIXdMYNO+Qyi?=
 =?us-ascii?Q?2RzHbj4Qs6ecWyuVy1RYlgeMGcvpPer1XhnXC4IK8xg8DOeatMLKoZ2Cajqr?=
 =?us-ascii?Q?KXLzHqt4u5tLRMjQdr1Qu2BqHVUKBj7JktZRJ3GcEdBrgARoFTXt2qWCykH6?=
 =?us-ascii?Q?eHCtYutm4RHq9ZPiJiY1n4P2NCr7kLgwK1Hdmn5vYgGHSpmF8ipzjiYzZuZP?=
 =?us-ascii?Q?ncNEK4l9oG42f7PH8AYe9SEQcKRHs+cl747W07iYkrW9LLJJYEHFcv7I2PKu?=
 =?us-ascii?Q?2vdZ+m1NzsjmrF9w6lnNguCpUZdwew9AZYVnK7GDqNwSnjxotXcCf0dUCc8C?=
 =?us-ascii?Q?dydK1N9RXqfU9UuxWKNCJOqFlNLPPKl04LFxa4Om2fGG7JMNVn3z2rzvLyrB?=
 =?us-ascii?Q?/O8a9eeAy3UIqAzsjeZQ6+SuU21GGk4GUUbvAcpZXt0Vttvw+nBWWGN2C0Y3?=
 =?us-ascii?Q?CqTlcKZswLByX/c/clLc76pAiQ8E0McQGOlAVFCafJNvrUzHbOf6ilZWvOJN?=
 =?us-ascii?Q?VYuZW/le6ppNxPw8s3Hvo66wKbHD8dAUmUzF31VrxykVMKg6uDuTr4KxisGm?=
 =?us-ascii?Q?8Yu/Dbn9kNYKL8T91SWgPY2djRsUuB1rYjXtR64zbQ1EBNLJvOXKhziBsIjN?=
 =?us-ascii?Q?N/ACiTOh+LqW1i8O3w5p4cjBLhIs3Gf1PEVv9XXpI9l0PbNtzH3vsPvFEwpp?=
 =?us-ascii?Q?pj9hwnEd64E1IW3AjB3jTXD4Tu6PR1xW20VCI1GWZv+DxXvNq9e7o3hZWs/n?=
 =?us-ascii?Q?xVwZcexWmx9hm0vqf4KB2hDb906LTpc7kViG5fuxbiEcNkR6IADzhL7KxaS/?=
 =?us-ascii?Q?WvJLNhloBCTWD7edxN5tBEfPhe6IzsQqjXiKFgycnTqYPZ3cNgTpVyLgRyXW?=
 =?us-ascii?Q?KIVP2TEQsFLl7Cg/9X70F3QkWWmzcHTcLZOENU3nyEitF0mhs8aO0lVP/9tg?=
 =?us-ascii?Q?dTvN5A3qMRIdBYNiV6KICDvl/t9aD4MIjsKYhG45wjFfx9U7fQjYnNUTOOg/?=
 =?us-ascii?Q?jwQVwbMb2X9bAcjudxjlEWLT4mB3Rn2Ss8gp9GnfcS3ZIFd1oziwt2nRtoRT?=
 =?us-ascii?Q?nEH5QzMV+vRWbHsZRXMESE4Z0RHZto952nIJxtBiyBTE/+IUuDSwuqD8NOQ+?=
 =?us-ascii?Q?w1fbDnYTjvoNpO3WlBXDhbGptgqkdM/7yaXLxlGQadjsr2Oaps5M2QaT893R?=
 =?us-ascii?Q?cCb3Fbmdzi/VPmeOpWL7Q1fttPFssOX/lDfOamOWyvYbEkQCs7UP0DQSmSPm?=
 =?us-ascii?Q?i0GXV3/WUGSR+jJqOv3byqrHSp59BT5TzBp79QelPCt+bwHNgZX74Cgqr+We?=
 =?us-ascii?Q?TqK3PSf80jlK4nV01mOwi3SRR+8XP9G/T+fzvLTBYmPApxmWxwCybvKBZRTr?=
 =?us-ascii?Q?YN6Z8K7Rkrw+7ZEoFm86yxY+Pgeo6SO4Jz5L+I5V8b9REENfGqXUYTsI6dEQ?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b573b1a1-ac35-4d45-3971-08dbdd11198d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:11.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjzMvapdBaFcbdDxrjbCZ3UZzyy9GJF/tjGuqQtrPYX7ciglhUByXiv2NhijOs7Td2WeN3gI/7p7Z2LrVI0O5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

This patch renames mptcp_free_local_addr_list() with the userspace pm
prefix as mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ab953eed7aac..720d58ccab70 100644
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

