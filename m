Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00087.outbound.protection.outlook.com [40.107.0.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6917F5
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4JyTzVOQDByS8JrIwwJxsaB4FVLoqm6W67ADIFIferQqTDnWr/rdRfR6htrpw/uv+UiQ0gC8G4AKytIzto14tUEk4cPaGoDwj9iI+tx1esaWbesNqtnvFZbKIK44KNZEroUWMuLXmakttTNuVOhHnSYP7b+jS5l+biSUCJ+RronP32Yph4Npz2hchg4intTvKkBBD7VmYYAVMmFPsRM5640JN4uci6IJMO0B14SpNyZKJeuUTNAPd3tdLuG4qkFW+YVo+3MjZz+YeHWqvnjXQu4bchADGyRusNrtmTl9WHnPt5lyTbqpWhtozQkOw/RtL1GbI0x03gE15PAyf34Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70O2qjoJES6OmFCgG6l4fRRtfTmbGOU401JYhm7eRGI=;
 b=CA2H51wsLtyRPwNQTuLa2EnOKTylkA6qY/1xG0gPUXRY+DvyHP9t1Jo8fldLfk6l+z8eBomt4XLJzEp6wSfezVgtFE6SpxJhyiSoNBF4WyEgOYyHVFkyxevzV/Zo/cCXP0n4SIEm4M10l1YOctYBjBQPH6L49aM5XRj0Rh/TbsbfFHuZ7Shh9CBdvXd/Suhf9wd4A93uqBWeCAhEmas4jGBzbtzS6ZB6jLLBd4EtoIBRzRpZPjP8+O5Rc0iiqpyqx8owwV6hIetSzgv2uafiCMw9nN8iq1B++Zz9420VDv619hsbSKrdR2JTBMwvHKUff3bUDBRb8kRMrmppUCSFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70O2qjoJES6OmFCgG6l4fRRtfTmbGOU401JYhm7eRGI=;
 b=e0pxT6/GRZ7/pojbsgNIcHFHhF9qZc6LaFSPeRjBP54XJYw6DkmeeUCbOhy5A8xP1ukMn9VoIlr8IT3wdylxuBpbEy7V5gz/3su8UhmzyW8Va96tASqWGa36FYeUaeAdY39taTalmBGPM4IF1AANGa32Kimx71jz7rwi0/iBGY3s8uKyirDgyngyjRNV3ZEXkkNwwLOmTd47VcccBewL1dAXvIkdHIGWiYWD5OwRz1zs/1w5d4kEfurBJlAaOkBvSfkhwcDNMSaRwBAnUnCUVxK1ekblr0f3UDNUhPatAkLj0yEGrwFA4iID/jsYsBC7X27N3PNOKNIUJQKheE912w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:00:49 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:00:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 01/19] mptcp: refactor push_pending logic
Date: Fri, 21 Oct 2022 18:59:53 +0800
Message-Id: <07c2012e7f8688c9a6977555e906fc691f37bc30.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:404:14::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d8c80c-02de-4b96-c6e2-08dab3538372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p4ooOkKJ06i5s90fVKqeBbETcG3Tne8juHyJC/SVoExPkiobAVPc/fUR+uxG0UngfSAca9gq4C+egdGpNsKrDZOdnLUcP0GZfKoqxvJIOWFdk/l9RQg/w0tt7pHJF1gDvGYzvLqoUbggTY68g3iAxJIb02WAV6axeslqXMYdLIPTWFOl6sdD0FSClp2ralF87smibcuoTNVs/jSg0Us0fdTf1pxibUrBcWTnSvrJ1WyojjkMLqCWhpQF+VYiKyN3ntUAxbL9O2Dp6AE2MwxHwH5NlssBMBKIJ+vszyH4LpGeUW+237v5PwWu6AaBiXOuJpBqdpP2L1vH7MN9q3uGOTSlAOdCCvkJ8dvI8R/1M2fdWycPBtpE9fnJb9O53OQxJYwmXyVuuUztzouRyexUhRjg0gV8J0vl0JhgkAw/mugmibKCylP67IUyWkUUeJgrcIHFM4SnGXW9sR/pSHRWNnIz7jHN1SRnU6n3oazVLT/dZaoiIUsYBcfvwoSK5r0OofUzl1s2+gKA4D56TgI8yIh1OHAz7U3ETOOPO2qxd2wcwjBriU7l2+meVg11UMxaKLvBxvqJSB+8NiJq5TZcbhv3qgCohDsJXWZJmL8hn9wpxukRd1pQFIB8LI+acCxvUEhScAgvKP1I7gEfcc+DWp5DBc7N6yQ0HSm2P2dk3XZkybj65j0fqq31FVljw5s4k0nb3ZmhrTOwnlhbVbmB1xMXK939iYKFjyzD8Kv0vsrmRZnI/DxQMOPyOzHii/3q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U08LndD27gbmu/ZrEvcqcjO+QPzI6/x9k5WENA8pBtF7pOQ7Cjx/O92ffFbZ?=
 =?us-ascii?Q?JJ3335M+sfOovx/gnPCd7q+a2lw5rCj2/9lPjQA9hVDSa9YKOB2F/1SJIZmd?=
 =?us-ascii?Q?EAzES3VDcMDhUItF1aZgPfEHiiMdVgMKt3hst57NYx6M12JiswTwrpw5uP5N?=
 =?us-ascii?Q?VNnxZj98tpbMb5eSp6D7T6Lytp0lCtt0SZkNPSenG0ddPOVoyufqmyOGRScJ?=
 =?us-ascii?Q?gVAK36T34Zhv/GSLAmlNAlZFsSOGdWg3FmwscXYvOZFzmXNKlnlx31946h3m?=
 =?us-ascii?Q?Ab594fUL9M8ScT3cx+0Q7IgdFcvznEomQX2x2Aqo3oeIUPsiuloBkDlV3k0Z?=
 =?us-ascii?Q?lTTD/hxCwpK3xIlMJBcWtVGj1Z+gEfTAW9w44KF+Ug2NxLq5REPIdvrLgmCX?=
 =?us-ascii?Q?jLy+PGpAvdcUV847xIUU2udkb8Jw7Ud1bdTbrwWzJD8qKFptRuwaIvWGIxZS?=
 =?us-ascii?Q?WSM+msltAeTIdJVyCXloESJnDARSmoVl5Zrn32OHrbbvTjPLA8nLaBFxVFiJ?=
 =?us-ascii?Q?nIAfSizL1DRCUJrRGvlmn5WBZ2+kegKSEtQBr9jEY5zf0CiCL6pVHx9Op1Ly?=
 =?us-ascii?Q?i3EcvQmDyGHHuRg8wsEGzPXCtXAPpRLtLszO0Yx/2w3c9LLZW9ZkTjqcoLz0?=
 =?us-ascii?Q?pOcCsBCeaV+uv+HYP4pk/vngsPx+yrciJ9RpvtDRHJghPaP6GPzj6ucf9BDt?=
 =?us-ascii?Q?loDgfb8V4PtXC5c3hjcDT8T2udT8PJyygMRl60Y6xguVcyVHjAWbWQKTvm4j?=
 =?us-ascii?Q?NU46/zmwiZuFqlFj3Lhiyqr13iRR0aDABl5HwKO1G8EoKcDWpnFCuTLXij/b?=
 =?us-ascii?Q?EDuG5g1o1jkmOty7ouEWN4U4uxfus211oa/FnK5g8WmTvEnV9A3/zbt2V19e?=
 =?us-ascii?Q?P1DGlVbCl2Zp6ZyrC8thj4FjvKoPYZxSepNX2jPfuqMTAEsUKbkDrqYM0EHj?=
 =?us-ascii?Q?DzGI2dwRH3XgKatlFAGePD8/O5i5YQ/lVTfehwaHW4ppRqa1hMx/bBzSthFf?=
 =?us-ascii?Q?tapXHRXC1eEkp+0sP9GBdjkVi5lwZJGpNBdcpWfgi7wlzm2gXaezzP+s11cZ?=
 =?us-ascii?Q?faHHd9YFC/oDLr8W34hSfJmHR44vCfzsDF9w9oqJYR27QH2beIWtLgGd8J4q?=
 =?us-ascii?Q?LGBfLv+kWNxBDO/g66H64bE+g+I2QlGbjQAoX1ALBHSfZn6Rr6dHVt69qaR9?=
 =?us-ascii?Q?ii4tC2BdEJ32Eu4G4FQe6QjUxgL8g4B4yQ6K2EbadZVPMTZoA3kD58E81IoH?=
 =?us-ascii?Q?Ro3TEKIbTz2uw24DH8/6gQNEo1G3NaJPnzgb1hpDcHCE3QbB4bGBaisRXFke?=
 =?us-ascii?Q?Jx2X2y5Fs9nrtsx4lRZgdzHTIU6qi67POiKjMAba+aJ9RvKAV9vuG9bGOPFd?=
 =?us-ascii?Q?uB6vDtpuXXobI1wnbqCb91ydChA0dcFsk7jUo4Lhosm50qS63MCGIS+PL+Yo?=
 =?us-ascii?Q?rylyT0quWJQjGipqO9ut3atTl09uLkef938/ctv4TVnOOKJVgPf0n6YXHnnu?=
 =?us-ascii?Q?MLDC9gLl6tBLzy4RdH1Lme87b5oUozTTJw/AD6wK+BdAYpIF2zB8i0dAxW4v?=
 =?us-ascii?Q?xGfuaq4AFECq2crtWPqWjZaRGSCbn/2d4cIAzEL/wr3yHXmG1kiWlGGbDWxI?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d8c80c-02de-4b96-c6e2-08dab3538372
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:00:49.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTMtzQaGH0GUrx7OL/VJRWK3YJ8swvo9Ob+oa79iyxYmXbsTR12tgDQ4QUi6lwXi4mXA5qjLdpi/11nyBk9rdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

To support redundant package schedulers more easily, this patch refactors
__mptcp_push_pending() logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Update subflow locks (push/release/acquire as needed)
		Send the dfrag data with mptcp_sendmsg_frag()
		Update already_sent, snd_nxt, snd_burst
	Update msk->first_pending
Push/release on final subflow

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Update subflow locks (push/release/acquire as needed)
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push/release on final subflow

Refactors __mptcp_subflow_push_pending logic from:

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

Move the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). Simplify __mptcp_push_pending() and
__mptcp_subflow_push_pending() by invoking this helper.

Also move the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __subflow_push_pending() in
the inner "for each pending dfrag" loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 154 ++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 74 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dc46c7ec8950..03312e762606 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1528,57 +1520,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
-void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	int len;
+	int len, copied = 0, err = 0;
 
 	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
 			int ret = 0;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+				err = copied ? : ret;
 				goto out;
 			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
+			info->sent += ret;
+			copied += ret;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			err = copied ? : -EAGAIN;
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+	err = copied;
+
+out:
+	return err;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct sock *prev_ssk = NULL, *ssk = NULL;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sendmsg_info info = {
+		.flags = flags,
+	};
+	int ret = 0;
+
+	while (mptcp_send_head(sk)) {
+		prev_ssk = ssk;
+		ssk = mptcp_subflow_get_send(msk);
+
+		/* First check. If the ssk has changed since
+		 * the last round, release prev_ssk
+		 */
+		if (ssk != prev_ssk && prev_ssk)
+			mptcp_push_release(prev_ssk, &info);
+		if (!ssk)
+			goto out;
+
+		/* Need to lock the new subflow only if different
+		 * from the previous one, otherwise we are still
+		 * helding the relevant lock
+		 */
+		if (ssk != prev_ssk)
+			lock_sock(ssk);
+
+		ret = __subflow_push_pending(sk, ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				continue;
+			mptcp_push_release(ssk, &info);
+			goto out;
+		}
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1589,7 +1607,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
@@ -1599,49 +1617,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
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
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
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
 
-			mptcp_update_post_push(msk, dfrag, ret);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		first = false;
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				continue;
+			break;
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
+	if (ret > 0) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
-- 
2.35.3

