Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6F17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDCiXdAfDcocnt1PT9XVrYudU0bfW/SmhqludBmFyBVOH9NUSawlTzAd5fd9Hr0UJSD8tV8ix7VXBy+LuP5BcJxe08VFKUtN3hQtxSK9Fzgw1kexeHFIZHqRn0MYY996Kcf0z6gt+wjge4HnspphHpTndbe6X28NukFgYRU7UCRBFRGC7DaOx0ICnqHP4IGm4BIv0pB4YpmkmGMc3izFFhnkeBO0NZkmHBdnMb+0OsNQ9noBDGqdId7lVCRnKivqq0w7xuePgB4qnnAKtc1+1RGx/eXsZeA0F7FyUWa+wz5yNFzlp0xmQCpYMdOm8B0IN9LZOaw/F9FctYqffHfuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tQoDz3GWU67+/TxFuwZBTovo2X5oTAluJBDUVeaWME=;
 b=gwxyxP236kONBjYXRWTEpBRFsBWk2tvQpjTaamtpxnKgyKS30VtggqskLFkMxnhYad10Jsk8iBmp8yZcmewh5KEQ7y2wYrTbIqqGSR2CwCCXNQNqCRbfT7HUyK7Hrqx4fJ1xfXvQwFGOKlidxmLnEoPHPduKiGwYR3+QKgwP17UfdWLCl7tLISC8ac/UQn6DQxCT8NG3iMEy76VqoFTC3FeqXZpXXhcHJOibDTpFTqZpODSHFj78eBIxR+ybuSB5GmT1+Ax6X0f1JExj1+R4dnYecYG5CmqYwAm8kgVPMSd6RW6+VydkHknOn5rlR6Z/ZFwJ3QNNH7Wyo80PVDwDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tQoDz3GWU67+/TxFuwZBTovo2X5oTAluJBDUVeaWME=;
 b=lyM1X6w2W9/fugAbZpPHKv4fUgpeHOYxnmHlHuqK+Ln3xQpydaynyAK9LsG+290uLgwz1xetFfMSZDZi7YiYzLVZSnw8rSjN7oSKzYQdBVoYhDrF5sJyruse9gcOjFi8aRzOxUJvJm8kPgKC4QoRzoktgQKm3cAraW2K+CCtdwYma5jslLGbJEigPeBRLuJKKZ4iciwIcPEhDhkeorfmzB47S1ZWzu71YMMPaIp9Av4mUmbJy82OcEcLRHR0R5+nyTea0Phnqxzj2qAEPjTW0gXAy9ZIFi5LqR9yWPALRB1FnTGXTzF4DBCnCQAYSXmGnEbgUAC9gor/psF3dRWDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:41:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:41:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 08/12] mptcp: refactor subflow_push_pending logic
Date: Wed, 12 Oct 2022 12:40:03 +0800
Message-Id: <d676a257e5f7e9f25128e2a2bc2016bc1925b60e.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 423cfa67-ada2-4f23-7dfe-08daac0bf9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YYIak4jz548htEm89CrZKfOdNLI/cFWOlUgyhB711OOjIozyJgFfBQKgRTB9OeoHRtFE0En8NIYDFDBy+M4P4xMZiwvQE3Kno96ay39J/E0oAiCo8Togdubm44XxnsnsE7sRCwCg8kz/Ns+nPL1HeI5oXj8R8TS6JwUdsIMB2WnJcs24w7YxAJauQjq5haLIEkOv1F/hmaovWNTmqB/OZAyg3FO7Tg7ze546p54equ1PVOBOdcLqgDyp9pj664ROsmtKQH8HjBb8/WaR3BFvPRF+xYWuqZcnJPKgDFMsTBPD5J/Chpj2ILuHRaUM67Qe1a3eFeR4MgGv3RKaR6Z1jzs5m00W4YV3nSKsINE1HfDlyZAAYy9MrNYBrmt+W1/1n3HE03100y6TW6fsTL7PMtNrSPA8i1zOcXcBZ3dlU9MGBdG77jzRPfqsbjWHLeBDaWGhpPU5g6LYdy42aefpSoilj9OdRd8gpRBwfvBYdnIe+jMeILbsl4si+mLfYqlpUm96c5lPzfWawTac40adGSKVHDrtflA7RyrtsvcyY0GQvIxRkTy14GIR1Ho9v/a4jT0xPLIaIOQn5RXaNm/KHBTtWOeHCKbPP7JET77ppLO51vZbuSsgto7s1Ok+IJsnollg+FaD2HCOSxeM945WFLVpfzTlYSy0UPEyNs7XGadNqmAoc3gpzCY+dWAkTsWzl6+pN8AuArH8UApkmmQ98uAGA2055sg75ksdlh4lWZNlBuDCJo/TTgW4Se5aIUKU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnlUa1xuCC765fOkbtqfMx94HpprQcSsdAKnWYRkXn5hRyOr6TrtntvgP0hv?=
 =?us-ascii?Q?h7J2fowTdn93NFBso9O7rrf56RTmKj9tn/axq3QbKXOmVLMLB1HCQmHNd/TW?=
 =?us-ascii?Q?kzrGRblxYQ/69eGuBWpSIEWf+F3Qzx2mB+FCiuM/J96wpOdmyGeDvSKJ4BkY?=
 =?us-ascii?Q?NbtG60vAk7lzBlXcfyeF//z/vSnZB5w4DflZLWswGG7kI3uK425SgnlUsw24?=
 =?us-ascii?Q?WHVXa1XGl3kAeYxa1ZUY7t0Z62wvm05DezBqIMHIdMGt7mIg7Lqib4YQK6V1?=
 =?us-ascii?Q?ayA/aSwoFpz8LVykBOmErZRVdyj8gUgXBWJ4IRjUTFbsaIwayX04tPHpY4Zq?=
 =?us-ascii?Q?C3TSGzbtiIq2USKCfnQ2lvItDzEtshmLC2AMFUxiPIW+g0Hz2tu7EtVp/VQv?=
 =?us-ascii?Q?6rhcChhxDtHYp108mcKnjHbilJdZx3KzXrmXNRQTtZIDa2ewlII9ZwoV6LCW?=
 =?us-ascii?Q?SIkTKXDpbspzGTrO2qZIQuQyIMrXgeK1q4hsYR1lzErRbGEZ9S/dNs4pBFMc?=
 =?us-ascii?Q?+gVHH3Ez75Tpr2PPrvqPJes/xhzRG6iSPdC4BJS6YiFPxmtccPTumzlx1VZA?=
 =?us-ascii?Q?9HZZjAhJKRDwvUdI1ekWiV9A5MIqms1U9Vxa55PbVKXgdaHbM0CXcebMW6Hj?=
 =?us-ascii?Q?LXZjSB9A1tveM78rQ17xQyr6WVV0ozaftBDHBbguVwtN9cBk/zYLrCm+irr5?=
 =?us-ascii?Q?MHX2YhQ/8iCwr+TkyeCkrHkWufpxmCsGirbvlqmHl8a0NRBXQODsh876tYSy?=
 =?us-ascii?Q?tqK2QCiWbdjKZDOZO2eehrISFmCd+1WdMh4NWEJnktsq5xc3oj5EyRHU6xvF?=
 =?us-ascii?Q?JQSJMi+tHEvQHoRLnnJjzHW2fr47PUIDMufCBjiXevit7TLMXQxGlg6q250v?=
 =?us-ascii?Q?RVxnjAhxakcsddY3ODjefXxUMm3dh2iAPMNmcttk2el/qC1VwqG3qFJP2/dv?=
 =?us-ascii?Q?ERk7T2i6saT7GVmXd33hwq73inR+s/kzOsVYEglgoji2KnniYRW4Ujfjw/mR?=
 =?us-ascii?Q?wybZ2rFU0UnJKccxtfifgSTC3qw+50KmZUjxXb5LDfXxcU7BZNkCexINhH74?=
 =?us-ascii?Q?eSXVObu8oq5AKLEgccBeSBOvcNrkTtH0ZIqEWNTHV5NRZjs8WqCW+sy2riiM?=
 =?us-ascii?Q?h5QblKWserEBiEoCoSB8SDf0QvvUadZE3yqUoKYQZCo/wNE21MuxLZNGTcXF?=
 =?us-ascii?Q?wcx3iV+zqduo/6eSLzn3MJHyI0C+dBvrlUudTLx4GLlLO4sz/GK4pm+KGGJi?=
 =?us-ascii?Q?fACJnNPosfJnRs4wCG4fHfKyJiCefPVdIdMQtZWVtzysaS8y3JmzdTvrEdCT?=
 =?us-ascii?Q?KIcD4PU9BheKcBuY6gvZYAczrf8S9unvojOrJRY3FkwaQcJQvbTqKhpip30k?=
 =?us-ascii?Q?tOyA6r+3frQqNAfGg0nDlYzmlOVzvnAKphHSMqC+3v6t5bgqKuukc3E2q3Um?=
 =?us-ascii?Q?a+JLEnziFffQJ4Vyh5BB30hlUgWSahsE0qvgjVbLODd9FvjVBTUQknVKTI0A?=
 =?us-ascii?Q?LMTuFh1KX5bJ8ToEsL32BBPRzAk11gKZO5ctQgJ/IIlMp4i6HqffNQLCxO1L?=
 =?us-ascii?Q?7XPoIwl3Q8G8TV4kf/+EDh09vsM9EASFN0rxPS/3jkM9XGIKrbi/1r51B0WC?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423cfa67-ada2-4f23-7dfe-08daac0bf9ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:41:06.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnRSTg+2bwmietsKEqvDvShZ5uuIP/TQaRfkrHNGTsr82KDu+9rulhDKxUTMwp1/D/RZ0YKr9t8wU8WiutmZiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Send the dfrag data with mptcp_subflow_delegate(), break
	Send the dfrag data with mptcp_sendmsg_frag()
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index abdaeb0d867a..fcb65c4ec774 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1608,44 +1608,46 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	int len, copied = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					goto out;
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+				first = false;
 
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
-		    !sk_stream_memory_free(ssk) ||
-		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			goto out;
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+				goto out;
+			}
+			mptcp_set_timeout(sk);
 		}
-		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

