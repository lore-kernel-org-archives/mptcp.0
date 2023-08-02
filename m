Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69F6FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nohwULyjMtsVB4wC1cJtY7MVhiFhGSKZ5H7QnTN2jGm6Bg/1nYJAK0AaZhvHwtjMg2PPiTLCSBKxC6etRGngbopDqgsePrTIAf/MIj0F2ozodHEDXAskJkVh0sZXlfTrPlGpZDo9iCnUm48Sc4TsSwg9HfuH4SzWntp74JcFwWgqNjXx3ZUXSI7LzuAZJrz01cKCJpffAnfjMYwWQYldTyEvKBTVXDWVcJQg2bbUoeND5wAA2ypbGAEWVGfhcPLY2Qw7LmDumj44ZlzNlIRtsGtCKoqajeiEt+5u0dd9UehOYw//+ZIxtp67w/3W0jNyhjhg9YzgHcAQDcJda/HdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDH7vk3BxWS0+ozL+wFiIdBBzT/PwSFXF50h0bkZ/wk=;
 b=Rk/R9t380GTQ71OihC2BO/9EWlrbDQXUzMQBZ/HcDTVDCc05Vr1ceFvw9aXLxaqyJaRwBkh5ufyfWeL67FguGsmkQ5FdHmgkzzZ2t1UBGjgCcp7amBUWI5fMPw8R1hOOu6KYLW3vmSz3CqMa44CYZSLJYc/LHPFgBB694r4ODkmSpWM8InWQ7t+h5Max/MJIsfYoSXTvzqSQ/sdQtz4D6Caw7Py8dZaGYL0d5H/U0TgePxiINFdPqVLl8yFXYqJsRgTXmU4LgesJGIEQvEpM7UM1HHFhPanI4Wec6EIlqlIPZE9aXzio33k2Meg2jsrjrAUjOF2HMZNLkrBGD7xS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDH7vk3BxWS0+ozL+wFiIdBBzT/PwSFXF50h0bkZ/wk=;
 b=RPPfODbv5q4qG59HO2O3MoiDnzwELUYZjdUlv41zGnBemn2LkSxIIyGsBVTlObQpucdL4aPMp+K7PzbD6+vNT9vtqCMunaK7y4taE5bXu3pbGXaBtpM+b7PwupyO7rR3+5Px0JivpEikp82UVg2VHPxONkdX+bzqBiy/ErqclC82iAI0SgqrxM4eiwnzvEEMuVwfjTlOuahmxH+Lpb9OKWuBBt3aCZvJaS7m3AslurUPt4ZT+umdVeS13kXE0TfMS9ABVc8nlah6RV0Lwdgo016YR+qBxNBIMGbWqMnq1eTls3OGfGRtyBwxu+xkbtFConfIXbU7sVD1hZlWtlYkAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:55:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:55:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/6] Squash to "mptcp: add sched_data helpers"
Date: Wed,  2 Aug 2023 19:55:27 +0800
Message-Id: <f193c348cd133709c349da9cef4b5657b91620b4.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690976940.git.geliang.tang@suse.com>
References: <cover.1690976940.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: d2af69ec-ee17-4299-7dc4-08db934f6125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9+TUT6rYXNlYrR93gaf13dR9VcIO369L3ntjwKcQFCLPrQ3U+v5SFKdV19wvJ0tl9tjAIv4fenbo9gQKEUqmW9dMcPqC+/rIMWsFapGp8PKpkVpFmRo6rLN0cbuYI/PbbnB3k3zUlkGb6ZZXk6dErtWyOmw4teZ07R//GoApJPTuoXLZfAhVH1pLDYFsINrYmptR9hxzkPMZeipx+RRRxdTC05JjV5bv0WVulGYuUxRYUVURJv3NGqv9d8Ibh1wsY0CVW6R6fyn+nclVMGBZllFdIbP/PMawnrhi/3u1miMawb8gpyELJ8vdcGBlgt0urFw3+qgfLtq0+R4UBom07veK+8KsGLzs6Pl8bVour53/98GcduKF86fcZ65IQOHEpyfDpcUgjgHRYIdqIHAJSuLPgaulG8uCA/qJnRQ1fapQiXUdGl/SM34BLA2GFyPZW8kPJEeXe99yOom4otUpEJTihRMwNIQshY6+ril971+AC0oLvXVhANF658fYD8+MxJcit/v7i0qj+zwTl+DiMRj0fXVRrImxhAeWd2/c17T12AyXyFIxNF70OfG9k1hjufweGZ4TacenxAM0w3PHiPysR7tfPPptR4+cPFEc64Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9MySO7vlfEkHZnklLPr89B73XzBIaJ0ae9Nh27fpc8rJEMblm32Uhegbos83?=
 =?us-ascii?Q?KRRWIVlTawciIgfazSKAbIsAPBgrxiKdHoKLKf38T4aYEOXIObG70uiq2jjP?=
 =?us-ascii?Q?6B1msfTOrKk1vA/TM4oHGBuo7tp98FWPkW2s021GeQTcuDAjAa7BO00YHBbX?=
 =?us-ascii?Q?3wrag4P2TGYrdzYe9jGp1GCNQS2vmnqfr+GB10cVBnmBYVsEefZhJJH9kZVc?=
 =?us-ascii?Q?C912Yn4bQqqmiyvLapYzR2e8Q7+DEvwdOC1zRdJjUyMJF7zdXOHSr2oidtbj?=
 =?us-ascii?Q?Cl2JtNglAHJiN3bGdsbj6W/z/bCp9hCv6ssbt53+PQMCaCCl5nGOiPmk6YE6?=
 =?us-ascii?Q?hLmh201XnsCVEk40cnTWqIOMKW0jo4oqjnFWplIKIl8F3DilqG86By0sqmI6?=
 =?us-ascii?Q?InzXr7GEwXQaZIpLXpoBtfilkKhdiBDdQRHRwQNRhvRi3ypu9CFWS1NjL2+r?=
 =?us-ascii?Q?mHYRGKHgyRjisHbFK7AjoOdxJLuaDqqjcN86Endvz82tvjJOD+gRA2QckOJj?=
 =?us-ascii?Q?DIL8ssYtZO3mBNxI96SRfsiIC30eQtmxk/R/Rg3RdDOn7TZyNxcsacdKxM7S?=
 =?us-ascii?Q?bkPuubY3RXot90GdsaNeBynTkreESUfhwIaXUCtpB+6uWzCj+sBv2kktanrU?=
 =?us-ascii?Q?luCgAGQBrP/rkAkflRjh1f4XkvfsVUpk/Lu6a8LC6y4b6IS9OkN05atqA1Nx?=
 =?us-ascii?Q?cf4tWQISmxqyIF1ARqb3uqtNgBkdtGMhW6mjlJn8Dw2UlVtpp2x23MDAZqkT?=
 =?us-ascii?Q?UpRfxgV/tZslLIxgB1b8xbweMi51aMTWbe/ndhDH5RCG+Stk/9fvnQDU+8gV?=
 =?us-ascii?Q?QnIV0e5kDIJ4GgZqti11ux9vIUrPd03fJipCvS63ewWMBevy5N1zcsYswZI9?=
 =?us-ascii?Q?fqkXzyqtruWa/uLIi84RmkjIjgjTSkgS5fnklvTrSjKJcUYHNVHLvYkTvueq?=
 =?us-ascii?Q?b+jUGbxrVH2UWvloP0ygAI2/f9oZeDATR2C4hoS8uZYZZ21Ev2aT18yzsO5e?=
 =?us-ascii?Q?uAwHru10flrVZNP0fi5vzq/Ys7/EoHN5zp1BRdhUQIZ5ma9RMRMAJ8emLEgy?=
 =?us-ascii?Q?QXzXo1tWpYNFMWQ3z5fkofmr9SsPCqKLOxBr620rD9YEH71+IXtwaM5iAiGa?=
 =?us-ascii?Q?NsooLIQL1r/c4STTalRiUJLNFFdJul3BXmCY71g2XR6d8yqGBrFUOO3JBzpk?=
 =?us-ascii?Q?i7FrIoHLgRRZHST3GX+gXNTkoS83xdK0L9NMfUPPIytgHsj4YviJqGUWM2kL?=
 =?us-ascii?Q?f+la4qCWvI+7x8TmKbFvDTKMXMbdMwBXd/MrkP55udjowaAtBOOGILRitDbA?=
 =?us-ascii?Q?ar+QYrXsBsHX75q0WYf9DxGQHTGoZMQkj6vUaeBB+3kPDf2cI4an5L0RJrBz?=
 =?us-ascii?Q?hyoYoRHTtvoRdPUq+aGvGPEnwUSNFLQFBwWqNq/eXDIKnA/rByMImzAsDN9S?=
 =?us-ascii?Q?MeH0oRg2nYoqiV1g/1AlP8TfnjpHYLDpy4zS1i9hsRUc5ZUolRJ6cHPuuZQh?=
 =?us-ascii?Q?bB1DkOpLEmLqnNI4fHk+kj2K+dnzv9OqHFlMryrTy+ysiaLgfgkOuQcWpAqK?=
 =?us-ascii?Q?gv54jq65YhWFsvr4ooqF+4SbAkCo00UnZQtHgL1d?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2af69ec-ee17-4299-7dc4-08db934f6125
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:55:35.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHSzCMaCAGpeilApqhfL4lCxO7+o5VpgPKCj4uJ2CHHkpoUVrzaNyWinBD1zMqmmq5YoK14aKmysv7fGDgrOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

Add "ignore -Wmissing-prototypes".

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 4 ----
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eb0dc1027bab..ba6a63e6d39c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -671,10 +671,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
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

