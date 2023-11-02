Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FD11CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uWT4As9j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSFtlBLu809Z2VUv8CgfVES94XUAwxRyy2IWsp40JiGwI08eh7SKaTmKohFDwUXW4aBxEiaUO8bWfhnoO93WcC3Z8gAnl7db6Qq1wCcyihG9og/BeC2A7NZd+nxEHO6tsH9H0bMiJGEDwdR3cpHn2SUuSScjzD0tLuI6DMvd0q2ur6r9NWjBpl9GzgCljldpJZLuBclN54Of/xiDS84dEIYGr4ROFFjFbMy6BoqrrVrBT1w8pzYfsVLFwyRiFlyYASccvNZgATDVmqIMXeppRjVL2L/f8AqrQot37mTVxFe+R1zJluu105R/1ThiZKhFyMtRNDF2CaO+gBCeZMuOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swNqzRmRhtSA56A63LL7Rx3QeYb+HtEs+UP5N1gK6n0=;
 b=in7fJSex33aAO8zDM3NxOecECR90FKQ6BPgMupMnC4qFo5nq1yt9Zqu6auIX3MIpUPGDpNv5pWcSJO3rgv3x6JTK4YT8fe3DreLuXlO8kIgPEPGTDOmgQ2doXZ+YK+n5bXLGthXn9zoeCaq+TaU7qy5rzYzf8NIS2vf85YudoYPOsfKDkuhPKl1p7ZgXjbPMzVkRCBjGsBx6f0YGBDgFg2ENgOFs44IP5dBfU3CMZNFH33W+XX4EC7mJh3sUy+SQVEk82xuPNXwiju7AxmadmpDJH23BmzVZYeg1p+VO0+OqYlHGQ3bcuW0Ipy5iTr9HDWIzKQZNgxyI6Rl8srBXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swNqzRmRhtSA56A63LL7Rx3QeYb+HtEs+UP5N1gK6n0=;
 b=uWT4As9j2eAQwb6f5MxOYysSE6kqF3MndjxwSTFsle/8snGaAvdVZReepaCED4Sl91YkKEsvIdfqe/w/pWd+xW+aH2lE81PRx4myD3JWu1dqENvECu9Zn7mWSxuR18wxGMHDesWGIEUQDJYx6QqVBv1OYFoAesJNAZvNEYLqFBfKxjgMd6L28Td68yCM3PtUDFl4MJ8B4ELTKDeOxBmULEJS23bRBqY8NbEPeb8Hkq3nOkQBwK4bsiawChCMsDiS1w16lWstjaL7TCyAzkaNiC6Mdjqc+OJ2R/bORDONc6zbLF0T0QgAsxkuo2eKQ5e1oe+eUrlCLRdvHXtH3kcOZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/10] mptcp: rename free_local_addr_list with prefix
Date: Thu,  2 Nov 2023 17:50:48 +0800
Message-Id: <61cdf44410799803e0c980cec907f8e64af4c837.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0193.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe014a8-946e-42cc-a1f5-08dbdb8949d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FjwBqktV438jkhuXwRL88ZVp+B2qEvHDt9Y+qpHT5+coU03NTjT1HfZmKz90U9HyESiZV+Pq4pARS/9VnCy2Tkuq99qPsQXo604qa3CD5gRjn8zepyC3niO/A71uXBceKTLsTF/mdKwmv/WygfSbpwNn4dvnMpZah/dHwq5zAmp9Imq1MYf1CdZ0QDeZyXKtoPo3Lx7HYF1eq/H07y2MkbDP4ixrY8lFSvh4eRRFPiw73Lc/WMsc3taiTKgwe7VpjUn1otHSLOkpK+an1qcKgEEkcYn6PC+hu6kMvCHhsFhFdhzmRJdokGHha6jCe9k2KJTIsDcWre087Imnp4z/0BblOnRL+1ZCbTdnIS1+R3gZwz9mrllbElBV/hcBMsd50tEQac09Tg2ErxyxsTPbEXVJWtGBE2hzu2Cv3BAv4bEiwpjpN1wm0/SqQSY7mhRrmyoFLKo2MmCUQXazD16j3uic2fkM+bV1pHEYGg6bSfOqfH6MnHYJvPj8jSWcyGiegZgSXOQ3NQL7QpVuuaYdkRBv/iRhZSQP3Y/5nwfV7B+C+JKDo5BVxhMXDW8Pu9Xtnm4LF9FHY3sb4UFnMQkBihkPfwYzE3rPHwCTLqr7QYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFWE18M8G3j/EkeB+T15h3LSrXUw5BA6o9FeNRCfIOqj0R4bdvdqBaVt0QIA?=
 =?us-ascii?Q?b9DftUEUWF7na1ZZtrUx5rbWuntcYka65b63fOW21Z/Phx6Mbu9dEPo2nILF?=
 =?us-ascii?Q?CHThru7rK3bW5nEYoj+SVyOA96SCTRCdGiRhzwObb5TNbg31K9/14iDNtMxe?=
 =?us-ascii?Q?Yo1Zt0e9cc3qTfermoNoLSwxkMwHN5a9pLNTOHzkOJLKSYBfnCxyBag+i5kq?=
 =?us-ascii?Q?Cl/7kuLQ1AAb3i5zQOMmhrY8nCfCrDKkfHkQgRxHsq1rKWhK3Ek1ncW/di1U?=
 =?us-ascii?Q?h3G7mpSjH8f5PIrarK8gLlXYjwmAKNLVsqqaelmBWd0GFdtg2qP8Zo/70X4X?=
 =?us-ascii?Q?ZG7lADfIFiYROzSk0DnlyVUZuzwzVFkQuoMKZj/K4S6h1DF+mOgxBLsfMa4k?=
 =?us-ascii?Q?LI3pZ6FWtJuktTQlfo4PiiNS6MXiguZRyK+d5ZSkI6ybPcnVPNGBwl86q/VH?=
 =?us-ascii?Q?cQYQ2b66m4Ruw+trihe6W5aHcuJbBrs1LBBC1gurek4d0uSUpHwADmTslFL/?=
 =?us-ascii?Q?NW60vnXTDXLMszzdj4g4sfZ+3HKdyRmy257JYCXJCsxtLZ1yUaXcXbAJNa0P?=
 =?us-ascii?Q?AbnuKMmqnX+u8iDlc8Lzpyb5JOsKqqEMuyDunU24ttspJwLy7Ph/2zassvND?=
 =?us-ascii?Q?24K1auiIwydwrXUFv34jKD1Jevata89EadtD5PjDYqLDFQr3ekfWQiY+Qlvp?=
 =?us-ascii?Q?w9bQ61dQyyZ8KIrPVF/TLnYDv05qNIQKFAwUe29v9qxKKO8UDwIPkQ7VgVLL?=
 =?us-ascii?Q?yPcrcWCj55cPKPafxqI4S7/zKegH94bj7AfuaTjohbuNvc2EAuD/IQyzuEy4?=
 =?us-ascii?Q?If6w9Ltbxo8nieSRPLgQyMLcjkMDNNRd5F6VglW6mRw3hb/9kbcYWsJPzaDz?=
 =?us-ascii?Q?jNhIvlszDcWRdbuAeEAIxyK9E4woRWNRcLibIEEiqHlcCDadH/DJd0rIrEEu?=
 =?us-ascii?Q?5+/AL356RiC2ac9O/PStrXrWcyYPwx4wT8gxRzf5EWkp7cwwsvHGTiHlq2EF?=
 =?us-ascii?Q?cQRggxH+cd+ExdPQ1uagy3wKWE59fLmam7y/rc8pAeLz8AE0j5DaVYtb6Kks?=
 =?us-ascii?Q?VuFk4cSIm50VmjvK2NiH6YEpn/E032FhNWe6Z8b7NtUI2GIeEL0WtqH3Jpvz?=
 =?us-ascii?Q?rjFANEJ3G9bvqyoUmHiObE9C5ubCPxnvHxnmHENtRBjybQOpXnKjYemyB4Gw?=
 =?us-ascii?Q?xcmrw1s5cXMBCccm6a4l25P0DI5+7TltvfuP1KxZZBsfk0tRbiYK9mRq0mgx?=
 =?us-ascii?Q?3Z/gQjl4FlOlS3+aO962VRXXf7Vt+o/o4k6m9pd2NPwG8LLsoGtWPL8/JMXA?=
 =?us-ascii?Q?+DEq5VRxMLssDenADL4XBQBCnroYUojE3HL/jjHeOCyf+DBH0dzdzic1751+?=
 =?us-ascii?Q?HSf6qrx5lkbcm7iC/jN1VSYa0f12qO5DKvh9oGsgz08LTKh252lZChJIjzVU?=
 =?us-ascii?Q?ZwRorY8RCDQL0hvgZjopPdntkue6QJfqW9WjwV/AGWCH3er2mxndQSn6HWSO?=
 =?us-ascii?Q?xu/y7duLChr32um0ugrEV+T4SwnXV81PgpYKYQpygA+FQD/Z+5cvkmYUY7Q4?=
 =?us-ascii?Q?P00OZmyGJ/m4qYEW/AfMJzX8tOUgtkg1E57MmgG3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe014a8-946e-42cc-a1f5-08dbdb8949d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:30.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/Hi8ebddunxqYqJ5du4UX5ojXAFs81uTzIpzkeLKTray9B44gB9N2N94P2NpUjua0bUp+THsB9eohi03k3Adg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch renames mptcp_free_local_addr_list() with the userspace pm
prefix as mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b7fa9481e3b3..86f3809c0b28 100644
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
index cf72a57e6c54..2d9e8a78625c 100644
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

