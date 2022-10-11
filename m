Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477473207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvQX+AezlEXTGErSHRkbBzrZsR4Kx4ozHsqcrrihMYN37aKKqQyW0hwAmVgTbjfUJXtN3fUC3rmnDf3HQGgMD+KnBd4WPrnzKrc6npsWKb4M/9zrYX4rYImwdl8vPQ1sET81r40nQxfg/FgO7IH4L+P6H65G01Fvgs8a18qQIdbfroc1IaWG8XYF/PM/TefNcEIFPz0OBp0WIg/eL1dpyjwM6AxGWZuW1/XPljXzQU7V/9/hXR4q9+NGVvNQ6w1fMzmBXfLC6M+C6bs8SpgUg8ZWs02NLrFz5Rf4ukVkgHs29xTmmFF+6wUO+gyNaFly6lze/f/BOVZVyOUUg0ZDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsOnjSqrgkbfkTE6pmyRUwRcDmt/XKW+i4Pe7JdDcAo=;
 b=dvlMzQqLSOfCNqO6K8Lepn7R9EdvtPNm3ORya+sMUL37wcsSPdZO4eBvPkrp4bTjAnRs/fE2BvjQVdskV1SYxG4fNwek4ydxmERRw6hrkkv3WTFdg8Lg8nyCtJ/p+DorzbaxFnTL+41xyREcH5GcYJ6dnlfok8dKDtppnpUW4Pf+4/LHX71eSkLFCbuqZD1hQlz2Ikrb/OndyERk1FTGoPjPugErubRHOodwtRWNwHXEZygzYllU3KnItyyHLZMpC0S7+5veb0RlhQJWA+VjLZL1bhyT4UnplChvZz3qjDPqLU+WAgh8S7iPducpQznwB4eDi6BE6gDfp4lt4yZv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsOnjSqrgkbfkTE6pmyRUwRcDmt/XKW+i4Pe7JdDcAo=;
 b=tFnVNyg0eQ+ohvv5+wYLR8uGrsFmuNKccnGsL4lW4jsI3H19diy6ZGJO1TWwBdnLRv7Nvf79rua29SLXQ6KdX3vzHUun4WCLy2z9UvF3feL6TvaIgsVCTFLVOtMk66bNHx/qTFWHRpgssCNNLbK2Pe+hunYDUSuo+UN0C1jIlKPNeLMKqaouc/QyJNmIh9GVIxyOIP+ZvFbsYfC1Ogq3UNn0Prh3I74+ml4yXB/u3vGpcnerGG7Sqr0rRrSUek+TRF6REdQrigB+mgH7+XVTfAsNIjjXIYY++pXsKTNPxCtC2wgFJNF6EZXG59+T6RIWJ55tOOPSAg7R+BtJwWFymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 12:01:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 02/13] mptcp: change 'first' as a parameter
Date: Tue, 11 Oct 2022 20:01:26 +0800
Message-Id: <20221011120137.5475-3-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 199f3605-8e53-435f-5eb3-08daab80514d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9uE80ah0y26gsrQTQIkFRaXIM+/BkLq1Uk+MM8Kx/xq/Hub2PcompVXzWytluVxZN3mFXUiPNvDcaHVL4AVh8weI5UhbXnZy0T4GRAtnnvS4RUw+nUDoisPMgochvsca3pG5eTPhB8kiv/fxtm4dW4wWqBg4mW13pLgFUhdwdO/F8wjwWKRo6ffAiX4Rp7+8L3XtclYWZvkFED5UUd2KtQ2LiBcnAOFI4yuGGDIY2pCNanCNmkTmZ9Ic31U5RXC14wJMYLmxeWVdjotj5YFApEYqduXqKQkNx6si5lvpO4iq3QZYfAv2gkfi/fecZTbYUVtri2M/z1HvD5+6NZOS1dwek2F+BY6mo7RCSwrisaXBf5LX9t6v9RC5dOfuEyQ+lYLUuiCeiL9N1ICjSWL1CdLSYVVi2z/R3U+JXPHEsSzjYEOiXL0Ybeu8j5OgInCMXtyUnSKt+B4bjeR5XjYInsm0v8eM6iInR1l8SYPSLt/A5x1yuU17MFVP8HiepSYx10SKhNbBjT2YkkZl4cxpkcxV072X4zeoWX/qg/HUV9cuQXWRx2rnm9/WcoG9H6uuMmOhYTO3IzDpkMQAndfrlS1zcS43uPC24g72x4I6albkzMbZVpiv0xqmSjtUPXVFOXLQlcxZWwF8c0Dp/RgSNOoiuSJIZTpeFdpK1ok/6Avas6jFwKd2RenXVf91WrA/a3qwrgi79eg/zXstFP3w+SPagk6500fzeZ0WJnDfhhnCtlmvXzzzGx05LBgZIsWK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199015)(5660300002)(41300700001)(8936002)(2906002)(86362001)(44832011)(6506007)(107886003)(2616005)(186003)(1076003)(26005)(83380400001)(6512007)(6916009)(66946007)(4326008)(8676002)(66476007)(66556008)(316002)(6486002)(38100700002)(478600001)(66899015)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0h5KoOd0lwDA4KOZ//RBw3GHG2vDr/dh9MLEFxEs4dfBtD8EXzz6T39UDoq?=
 =?us-ascii?Q?ohlZv/4wdRCR/iobSHVlsqOfuRmKPnArA4ChiO8fpFg0aZYQqhVlVTEtuzwY?=
 =?us-ascii?Q?n6po+5DugnUYH260bd9YV3n2W1+fK/Nl/g2F5VIBt6hPvG/M2DHpfSI1HOob?=
 =?us-ascii?Q?Iq2HpX+gi0xzDnxKFnJ93iE0Oj8aSv0a/SzWqvnDUbFLYxIUpEpKbioh9vZK?=
 =?us-ascii?Q?ftcH5TBeQSZI4T+O/ifnbiSxvLjNPUtfb1ONwP2JFJvsZtEfjlXk1ctjrgDK?=
 =?us-ascii?Q?nzMRiPnKYRjzEYHPn/Po8St/wlAolc5+S1pvh3ghWMcF9eafYQmAu08dvBlg?=
 =?us-ascii?Q?Ha8AEMmF2DFIhCSw4o7SNoCT/tsnHTrmktpbDRSwbOUIRTFw5+b0wrnI605C?=
 =?us-ascii?Q?W83dgOzZS5ABxlCamqV8NsDeoE84fdUCvVXT0KWuh+/XEc2W4HGTv5iQ3TPq?=
 =?us-ascii?Q?oOL6YC0FJHyxioWQYdUgvI/Ir1etWBT7+HX9HQdQ5G2aJgFYOzyVRqYcxRt4?=
 =?us-ascii?Q?Kbz1MG2y7f7Hms09LNNkXJdyetPTdtdLDxmuJ3CunSkxbovJtmCxT7WNb/tx?=
 =?us-ascii?Q?2NDbT9sEKDW85d0eH2XeQSOlMZXCF+RItrO15HN0IDPz7GCklMEIcd+xCzoI?=
 =?us-ascii?Q?a0rDr1k0P9Zo7M6UOHvYHQFomi2/6nfGwXVW5m6D5tKn5wT2x3qWp7XxQAXH?=
 =?us-ascii?Q?JXE0irj/S61HrCWgj6sHZgyjs6AFOAJhewVQhUTDOiOXo00g3EAgVmTwYag2?=
 =?us-ascii?Q?mgAliYxLvQqu9AwCH4dtD17N8n2Io6WmJwYBxtMVQnDG8x8PMDRREp+WSQAI?=
 =?us-ascii?Q?RgtYZVl0M8BXZO9DRUPDCwJ2ed2pxPM/9LPBcCNXj4GBIGDsJi8fen1uRSsp?=
 =?us-ascii?Q?QfYhn3xefn2ifd6dEQl382hqvwM+hj4bpgI3GMSlE5YREDu34nuBZL4wahmf?=
 =?us-ascii?Q?cb/5o0zzQX0UD4ogHtTztM0Du5m2vLXbniHC+rVw8K79ZSSevD0vtAtmymPZ?=
 =?us-ascii?Q?qYxPcGP8DjC7XPqGO3RuDmKwykKyWonrZBuPHWMYEchFpISfh+k0jeaHHRcW?=
 =?us-ascii?Q?PLQe5Iu7SdxJdqURX0/jlDw5x5qD3x3g9LbM4YgTs16iSlrePozERTe+CsTd?=
 =?us-ascii?Q?TaSJ6Z6TZh3z9mlU6FMUjim+sRN4+mT3mSmlY/yZabWbO+E0ZPnMCaNpYjTl?=
 =?us-ascii?Q?2d9hD5BILaoSVo8v7kyIb3P/7sLZ03ZBhuG5FStXKzZKdPNxHHuLEgPxCk4r?=
 =?us-ascii?Q?gYxXxFWS81MQXaCuqVDFsSHcbF9Sa8JmcMQMIU4ejkpBnNE6g1Jyr5M4rgsQ?=
 =?us-ascii?Q?2P7ZIMgqy2btzAud139jgEzDdIj9KyYzfFE/ZANUKWsBrtRMhOXnIJqFJ392?=
 =?us-ascii?Q?sMP4DrXINQJXMcXBAObOa0VkFQKtxiUluWyCP73fEONqtFJuHCZZGy6sn3eo?=
 =?us-ascii?Q?WHah07j0g3EF53fFgkFNetNeV3g3jVcAn2CE5zo05lK/nVLmU8ilVPv0Jwk0?=
 =?us-ascii?Q?j6jU8PYsbZEHgndrwAHXfvE13isSgTT9gKiAoK6cU59TwQiKpusXHfS/UUMT?=
 =?us-ascii?Q?7+lXaBrM4RGSSnW4709K8ORjW1sj5NEP/htnAgj/IxlcKEfCzP26ImEHrR0X?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199f3605-8e53-435f-5eb3-08daab80514d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:23.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x69yp9TeFeT0cgfOLIPQyCH5ADZfvYC+VD8JxuIJLQzaUltwIv2I3KpLIOdMHxoIKYxxJYtHKa9ZVcHS5wSlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a2253436f50..0285b21ff912 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,7 +1593,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		__mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
+					 bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1602,7 +1603,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1612,8 +1612,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
@@ -3198,16 +3197,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3298,7 +3291,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-- 
2.35.3

