Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1228E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpMJ2UzmNJ6uDfxYInMXrEfSPpn+EXxLlb3hwC8YZdrg7J+s8Ha3Zzpzp4ooLTOdWLh9TP6ezJuo4I4ODNIxILhEGp6DyGwvxtt2HipzIRsXsj9eZcOM5cRsvQ7hmfEq4TQ+jcOgXaxb2kmP2Pl/SQE6LEjega4luqw24lRQJXVgx6VKek5a2nZ3Bgsi5UB6wDqnd4hqqf+y6pG9JNDuak0leeB6otsvw4yAZtLcLGHxSGmSPH3CG8AE3I0VK8mKhG/NuaE55mIKi+LnQTi1vKw7KYXYyGtnP6+o+ZWsv5/+TYUYU/pjA3Fa/M2KriB8cnAz5q7gJ2ERRZ9RD4qugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH/rwau1Cj41M+0DSjekLM32cLFRiEtdtnhwO0LMdGY=;
 b=MKOYkk4dZSiB6EYRp4uTGasU6UaS36V4CwfQidN7wqKsCkkroaIvFWc9FXaC2+wVzUvasuzfMFVd8etI98JT3uy6PXYpfmEk2qTyXF3Lm0n8oAbKgWi/mcyWmS1SaeBCpDpD658Q5a42iBHoebf0IEznaKEufgPm/9SMQmahhCUu0IHfS0HiI6fhUIE5X34smFkNBK2HvFEkw2CLC5SohCXNGF4Xh2a4NOfp6hzhfUbZylURN+BZCsG76MMtVxiAptkX6DuZ76uTb+5nwNBNxeoFF+Egi8fXX1807mvtRmmFYUkbNj9Ar/wn4gFrGab+407dW8E3uWQnNepGRZSfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH/rwau1Cj41M+0DSjekLM32cLFRiEtdtnhwO0LMdGY=;
 b=lz7arJeI0RnvzizfP/l1Isfjmaa4wtbmSs26z+nBeYJbmhK6CT9/wWEgs+nRPq52kWB02ahENhtx3aIVeu7ATEqq/ygxhV30uDgSNcbCrVQIbkORkUNab+waumEWthzm8CO2H0spVaRTDiMCJT9/E2a3vdGl/rxPOENiBs7zOTIITKkqa7J7XZD+MMLBJIkM2mDuJ9n+wmnnRtLWT3gyv2rxqKjH6v8bP4mwFxpEviPjDQhzir7HQymsI6mNiC0xK0yj3xT5ZTriyxLo8r9O4vfykrctbq6GyR4/EkwL3aTzsPCc6WHh2Lz/D5wv5UJbQbCgc+L1kgTc1omfKhJ5PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 6/9] mptcp: add no_initial_subflow mptcpi_flags
Date: Thu, 14 Sep 2023 22:50:21 +0800
Message-Id: <20644cd216983d409e5e2092f3fa5bd50211dc4c.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0b594e-cad2-4c6d-98cb-08dbb531f4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a8Td7DhMoECWS1goKGy7sO6QdWzx9E58POc7bb/Efc6oVChn6HHYzMAfJUFhytNPCls0YBmUGm2zdxVeTkJbgtJuL1vYGLAJ6T6yNGtst5cW5ktbGXoHC5pYmLPBq/+MV6zPRy4Cig9bjLMr7oDjKH/epfteSRE/rv9WpgWsuqXCfE37TPGiQ3O5+BHsMRyqLfqdZfvzAVEQzzazGjnqu+bbvYz010im7a7gKRKo10kOr0XkVVr29iTaQzKbOsjKIVVYuwrEnk03EmTgeJ3ktX+Y8+XxMWeQDwkCQ1Ldawy0qofs2q1TSWgKNM0b1DBQ8uvpiRQw+D2jPQHJSRZL5wxuRGjbNIpMrv0RFIeGl42NrHv2ALGJ8EZQbjLOoheQpGLVXXbdmN6zeQXpDYJx2Am3Et9QfZZ3IZjd0xvOBZpxwY9WnhXzFeSKL4yJaeYpfUEDMdY6j5eKUJWzK6U19Zfqg2zHQZSI5ZObMNHpggMh7CeE4oSKx2w8bA1xMKPn7EeKj57HsSnu17+NgLq9kgEDFxjpGv3wUNWAA8TKvZsKNfEAgJgHhOzlgTFHyTyY+vF1cgh47IjJ4+0omJibuXjxNzYEej/jwvKkidx2V1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(966005)(26005)(107886003)(86362001)(36756003)(478600001)(6506007)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWeBEMNz32U7s+d1jPimqrd0JnPeyahoo1e+aQYudQ425xhFoDY6E1i65Glb?=
 =?us-ascii?Q?O1ZZ3rOlqupDfVhMa8G1Y6FBTsBdPIzyflaeLaEavc/PpCzx7kCsfXKi1KYF?=
 =?us-ascii?Q?3I3rY/fBRG7d6vhmtADJB5CrFCzndpF+aTREl2wNMFi96zaUzNBjL2E54bzH?=
 =?us-ascii?Q?DPVL+g7E24ZiaEoINJm1zLZPRVWAJTAurp5m2RsHZUdvjTXmexWspHWCdMs9?=
 =?us-ascii?Q?u9kY7bEaY0BVU9QSCvygW2QTglzPREP0OGKy9Hi1cCMJdt2ZRdCIbmc1/qFO?=
 =?us-ascii?Q?TRGLi6NW1/Z4JK2znDJybcNwiQieYdvGVJLcaqppyDgsHaxMOu2iGsG3Zmd8?=
 =?us-ascii?Q?qIoICWjrW3zmwvIxF87Sg4D1VO7/fAVFdTYo2Tm+Bpa0oEGf4XYiQcEWNwCN?=
 =?us-ascii?Q?w6xZz1Ed7TU1WXynA0dZFqltvrkJ54GywroLsl3fKMD+jo4ZH0Dgr7ihDfvK?=
 =?us-ascii?Q?R9UOqzDKmHSAU25B5Qm9otQFaIoGJgRLe7muV5H7Se6OghBDN5/Qp40P4xMP?=
 =?us-ascii?Q?UtIdW98aQT2AM9TciHQr1gLwu7A3k4XiwXI1FhMcKkM1H0cyGBYBI5t+CQGJ?=
 =?us-ascii?Q?xsVYUXefxuVD9e6b7Ui6cSRoBsyd3SXqShja5UYU0pJcbZunGfaAtTU6NDlw?=
 =?us-ascii?Q?AibUGqDQGz4G1qpeVgkxrNFvPOPyuxJpOL3BpnngaeVHJmV/6PIVXIYEK0ET?=
 =?us-ascii?Q?bMarbazPJINm1+eNn0ljqD2VGqLlxO+24UYgKGeJnWSCIeiNivqolN0Ov+kC?=
 =?us-ascii?Q?TFxZ4uwnrT11M1Eid9IhPXaeirdPJEdAdhllxqmnc7zmYre32+XUArmRoiAH?=
 =?us-ascii?Q?4KIzC9Ua1aaGb3wSL6MhMysMOqmSNGM6RRQrLehxjM7vdFyFtXL0ADPmr1rC?=
 =?us-ascii?Q?UOfbM3OCoqn4qFJVSrAlIXkrMN03Jp792yNV9uoJusIKIWn6yINTxXknvCLW?=
 =?us-ascii?Q?b9VAw8bUR7izCPifFBEwd+BVM1xqUdC48I5kN8y4J+LsxQ1gJeD3Z8/Yd27z?=
 =?us-ascii?Q?iwr6RgiZ2fzws9ox5ydr8cTZYES129KCWQMiaKa747fzJsASB0inDGAWnA78?=
 =?us-ascii?Q?4Pp+ToddhcESQUz4jWD9HEYMT0MumgqzyZEunDKc5sh+UfogVp9EfqCboseK?=
 =?us-ascii?Q?bKlUW180e5DsdwrvLVBHBSJ6ZUGDnQ/3CmYfBJ5v0Q6Q15GXJBUqSsUoGCdf?=
 =?us-ascii?Q?U1YuwQ6vc0erd6aQfO8S7JtjXxi3MPus6qhOeR4NXVNMQ1c39r203dFeM60M?=
 =?us-ascii?Q?M9O1QS7d9vfdmde9xrjeOduT4WzdewZXucxiyhAN+ljdnyaQN8weFUOEdqeA?=
 =?us-ascii?Q?0awVHayw1hk1z9Xv9hpyb9uWHo5KkuK5ptHoVqPyq5AfKRU65380dyMUEHFZ?=
 =?us-ascii?Q?RoqVkiMYWTlvxN5+BC2QG33M4KN1Me8ks/V3hjyD3pGfrF7qUhhwIPCLo1Sd?=
 =?us-ascii?Q?5HHZyuejs1rhEyvf5IVtu0P6I1r2dJ5Nfm4pKtTgwcDAxStmZxs9YXec/TIE?=
 =?us-ascii?Q?xJazlp0M5b6YJVo+0mAoBtG+gHj5aJfrIUr41W3xWpTJM2fXtaADKmu21ArU?=
 =?us-ascii?Q?KP7PxTJMFZxzJlkb2TtUWlSnir3Q6EoQ+p9PXkbSEGYvMDEIRINCUqRDyfmn?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0b594e-cad2-4c6d-98cb-08dbb531f4cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:37.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohrj53xnnZBSISdZt3aDpFsh1PDfhyTXeMQygG9aK9cZVnIOi/VcNVS8wWqTRoQEtZsdsHLXZwkBRgYIglbbvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new flag NO_INITIAL_SUBFLOW in mptcpi_flags to know if
the initial subflow has been removed.

Add a new helper __mptcp_check_initial_subflow() to check whether the
initial subflow is closing or closed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 net/mptcp/protocol.h       | 5 +++++
 net/mptcp/sockopt.c        | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..c92421866aaf 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -107,6 +107,7 @@ enum {
 
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
+#define MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW	_BITUL(2)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..4b196235c058 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1462,7 +1462,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk) ||
+		    !__mptcp_check_initial_subflow(msk))
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..96e3846b50fe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,11 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_check_initial_subflow(const struct mptcp_sock *msk)
+{
+	return msk->first && inet_sk_state_load(msk->first) != TCP_CLOSE;
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..a2e1c3d159d6 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -919,6 +919,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
+	if (!__mptcp_check_initial_subflow(msk))
+		flags |= MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW;
 	info->mptcpi_flags = flags;
 	mptcp_data_lock(sk);
 	info->mptcpi_snd_una = msk->snd_una;
-- 
2.35.3

