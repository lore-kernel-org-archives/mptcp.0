Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3CD33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcfrVIVSpingaE0xf3N8ApLiZS5FgUlls8jt/iprEQwiAilvkEIQmk2jsVevVZrV1D8jn2gmieWdq9KgXzbdO4DK9z0/XpC20df7vevsF6ky8FptqOB1SStuSTAuFMCfmdycCY+MKz8yKTe9VURsaxaKW/sMsoRns8HgOFhWcoiGbd/Zo47sUU60AtlZi+NQzd2ZnPhVIX1yN7ykx1B2AfTB+GYAyUcNmu8c3UhIpTpFtn3URYR+M/ghgMerOBBRn2RDs7t5kGT1sZMrxeSW5/r0deiCdNqYxgvFF5Rek0GuOyJmeO6Rfk9xTrhhrWOh5PznuvibaChebq2tFfMj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBYCWLHX72eZ0zMJIOGpKvleHTol9CzhsNjQ3EebapI=;
 b=OdO+eO78JP5LJkc5muNoFSXgauVyUeoLaH2yM2ygUx7FXRMvued7A/cH4VM5yN+bstvGKZxx9+WNTYX750idBGPcKzDWIzTHoS/s4Mt1qOJlUfuYzM0nOVl67mEQ4dmF4QIeG1n7K2g7tsqqVKCRhy0Thk14hFCztajnVjgsqi3lKeLqmLKNWfL9YalDYJslRthksYl61IK/4kk8jmYoBGUsjSoZTQRKFUbs0nA9R2Cnvk4Rb9ujMiAkDvPfczI8t2YpSzcAwD0kPJwF7hnHcSseqy7U29vhd1z1wEbTO7uGUQCSUeXNv/saJqyed9xNUXcclFIBsEwG5Tl7nThMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBYCWLHX72eZ0zMJIOGpKvleHTol9CzhsNjQ3EebapI=;
 b=BjNGqH5AqrT0tutYyF/5Kcmhz7+1FgUOsMKlRGBDml2FTDXja3/CPqGR/t6kRqFpsFvC8hQqPQg9/8YpGjwNhUP1BrPsP15lpEaOq4xSYEUg3kypF9VWFDbOmIxc36VNot9ulpIFF1iiIRuMhrNB4Vt411rxrQ79DWQ4klwshWPxq5nN8j2BAu4hvW6grS5QaOLLJ9f6CcQQJRihDahhk6914z9lQEuxTJ1SZouTAp5fo3lTteiybFfvt39I9DdaC45sx308aj9WaaZaXjOSTTcKMczElvlnac0i0OIi9eQpJJg9wU7cg7kkfAXEhOnFZYp7JYeMCgd3mXyDOHhfxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:24:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:24:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/11] mptcp: add new argument ssk_first
Date: Sun,  2 Oct 2022 22:25:10 +0800
Message-Id: <03e299e3fa96817a92e0f0f79f7bce938f732d96.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: d13e068d-bfb6-439b-1a1b-08daa481df3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	icMxJCxHbKFINtAt3tEkugL6NNkaZRkWzbP0F3S5O5vdkb7ZGH7Qii6mYzdZNiwBISuuyaGUr54/M7eHmo6E1MY4M78JQyEQd+5zDzt/OMrlHkt+hSB5eP+SXMYe3vRkK8EjlmZbS0rryBEBL4QVz4kD7uyS/u2BO6VvHlj6HnHEmIqYBPvc+AsVv59Sv/b7YfYhTImWo6IoXShWyhWevcbT6RbVjY30mDaamrzHHI9QYmc5qhoIAyUyMq9vlw2YT6vfnse+kxBFlap3v0BvKYNf7/BAyL4Y+mpws33gENMFupAW5HBxpkmUhig14r3OeS20sW9K2xR47HP2A19KoaZwQdhLoq13F/b7BO5uSl7y6DAQHEpVJ9l0apydChokbfuVgMEUz3W3ZkHexnRnvahOsgaz5RbfmYKi1YIxGcnVR6ByofvRJiZLyYOx2HJ9wQRZBlOWtifaLD2qMkN+/syVRFR4kek6FGn5Kv1P8wITCaip92OxlhfQqDgqiSmsjZCU7m9tKl+go8SnGQihLxMLeKNHEL1Lb/R7BI2L4sDsdpzZnHC2LdAUBaMz2F+EsL0tCRDgYBB64WxmetKq54gZ5NvfKkOYtzx8Qk7IluDdrlefy4H9lfm6EIcPMvOaDd4e0mml67j74/wSwgEeiMyFDE1EfongyXsMmdWNFOMqFAkrnZQV11VyphMARej4TobWcMbTbcQGcrRjdKPm8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(66899015)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zqwyd3OpdtdsHtiEQx/xUrHk15Mcvl52KrN3OlNN5DP33rkiItaWc70rvuBP?=
 =?us-ascii?Q?2ciU/JHSWIjad1SGeGZpsMjLiQZExOX310jDcqfECBLGXj+P+GW4po9SbrMc?=
 =?us-ascii?Q?ILQEdlgVRZa7l9S6CmN8wbNFGmKJJoOTWAYf0qJWBD7ZSYJ/r2zyEF3+CVEq?=
 =?us-ascii?Q?wPaKDYpEj/lyexLz3LfX1pCqsMFJFsJg0QKYu6L336f+po3AHw3bQNVODK9L?=
 =?us-ascii?Q?S8B0yhL0E0VMyHvlkdUD4I/BrIimWM6l3Agmh5LnTdNa+k48WJ68Gm/6x04X?=
 =?us-ascii?Q?jzMOwSkBC3HUc4KWoLjUh0sSg+ydFdXGs80crAM2UaD/rQ03+mMrVgklyrOi?=
 =?us-ascii?Q?iGY7L0CWsE3IdXBxrx4/Nh0MhylrDBFC4Nu35LKtDGhO8jDcYzn44Ztof5i0?=
 =?us-ascii?Q?opVKosvECEE3jbJNj21NI4AZDQtM9iWRXDjwSqxHAU2DJ3WFX0Zr83zvLyhH?=
 =?us-ascii?Q?Wg/Vj/5i+ijxnCd6z6d+QFDV+fREoAALAeSS91NhKDmYkCCXQIWWyzWCNY3V?=
 =?us-ascii?Q?RUzvL2NUrQRqlYNBhYcUA+wXvOsAxKOUua8NkCzpU/93xPwRKjRg2VTVgCaF?=
 =?us-ascii?Q?UPk8gz+vY73UyquVzHoC0mFftcPEDO/xXrFGPc8iyINVsPLEkA34pO/TIKg+?=
 =?us-ascii?Q?UjQCbCqjyNCyQeS32JAAWSE/W2X3f70XqyBkzEOPAfuZGPe6hdSf8IVWN+Ks?=
 =?us-ascii?Q?qxHEwkamM5gK9yeHLXTNxje1zV8jP0m/ZvEHg/mepKIJWg86zyXFCeSGaXm8?=
 =?us-ascii?Q?bodgzCaYqsY9ERjTQEQGVOYH8rwTbf8Y9T0DmrSDF+HMY1L7GkUcZ8PRahgJ?=
 =?us-ascii?Q?/Ms2No9U9fA1L8fPDx8xxwESJpZ1HIKTEH7b7F4PAprforRpt5WB2DxrqCWW?=
 =?us-ascii?Q?1RE8Eu/nF5MnpYCETRTqLIfVzvkjwrxCxbuEegIvXiSKAFQM/n7oQoXPmyi0?=
 =?us-ascii?Q?rtJJk1GjVFqBEq19GqCrbzJ4xPCxAQM0dXUvRK7cRqqGff3ztoAYrmy6Q0YY?=
 =?us-ascii?Q?ORq5BInomD54/3cRX3zGze1XaL3dBx87sUAeeHfREEE2dGXvtyQ2sSYfdirX?=
 =?us-ascii?Q?d+yfPQ3PTYVT57jAG+SBRztWpGvbKoUWxcQsItLj/tFC6zPr0Zq600ybmkgM?=
 =?us-ascii?Q?GBdCXoQHbe64/UjG/PbjRV4JVuRoZBdKF1GaJl061Z+vUr8YtUmgjBanOi++?=
 =?us-ascii?Q?uEZQYt0mHFVQhjW68Tp4ov9jptFj1+ddXI1f0AhEP4TqPrPKY2cZQWTbv/9f?=
 =?us-ascii?Q?h2HCW6L7WVfz4dKEIrzqHGccFGOD6X2dzDu1MeqBJN1gYzTt0b6IETLlAEQv?=
 =?us-ascii?Q?MnM8Y3NAF4RcEWGSzmTgvQfUNdQeCEV+wOacuCM6OPKKen0sQxWgFt9psQju?=
 =?us-ascii?Q?n6oAs9C9exgiZ3u2079vmt47hxLH9xlRtQzl9ZrMAURHiNmYInwrVTFLGSpR?=
 =?us-ascii?Q?vmxksu9uYsAt3mQ4L6aRmFaBcVpXuiS4IXvsFAH3it5URVBMh6KyVV4udRbm?=
 =?us-ascii?Q?bbX2vVTcVFTl3RjXBQ3V3e/QQITRhEudUx+dWO7FlaDdsYpePf1za0SJpNYT?=
 =?us-ascii?Q?g4JuP5q88GbVD7PQrP4dWatiMsSITU1I9RNPdp7j?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e068d-bfb6-439b-1a1b-08daa481df3a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:24:53.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9sAFIllG8zGqpP93cJORIB12Q7TyEQZcZY/iqVgaKDisJHhWbBhH0GODyqoPcIEysil+hxvqbGLGpCrcoRt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new argument named ssk_first for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
fuction __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc8e67543e76..bbc43212a20f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,16 +1593,17 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		__mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
+					 bool ssk_first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
 	struct mptcp_data_frag *dfrag;
+	bool first = ssk_first;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1612,8 +1613,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
@@ -3195,16 +3195,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
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
@@ -3295,7 +3289,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
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

