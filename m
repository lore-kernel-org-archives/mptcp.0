Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33C7F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGYcNQmr0SeY/iUl9iNOB7B3w8INV0ZwhYQcP2DHQUCD5KPxmY0rW9wkhzbOHSkMouWlkjbHIG79wducDS2XOBiRC1lnDrCd+VrQuejZEgWYrm+wqcm4fSl+1UUMwo5BGLTt6gyY0+KrAkHxSKZtyTXT/UTjWPBxTn7GtFePd9B7E8XFbM8O36pL4KVO8QQZLFkDML1AXSpBJGts8oFf9o8CZyiobysDBWD3+B1RsJvVSpSX0INkqq6rCot+o4qaTwj7UDUUUCTPyezm8w/jnNAjIBI7I0WB0Eylf2RtBYWfLPTvDYlnDBetGEbo3Xr5c5TiGNZlZQtMZHK4DJxGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVGxc1el4vLRit1GBQWFhg7+kx66ErXjSf76RYKCiV4=;
 b=V32BGM8qcAcfufffi8Eg2od+J5QsiKHYWd2ohAtI3fq3FMQMLkjMrFRQ92gy7l871GKTVzkh/7Z3k96qgWTZQ0C9k5WHlLlaGqNXjCDvu8hx/zNjedKRNz2qBMUnzlDxnwIckkJw0ZVhWXT1WSIT3g782iV8QePhE1W5JuvMVG73lg1iTdrplJKBFp3SXIqK9i3r0cbJ/z5i8VJ32jw2FJPFKpbC11VhjOcW6fMJHPITGHnxYZWift4p1AI1ssie8ZQ5a5AGHlwiVd/aOUkbjsCypfGXEyN482dglMIj+mX4C+Fb0KXW7FF2P1tj8Jum/TStI5rmGOgfh8CpC8HyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVGxc1el4vLRit1GBQWFhg7+kx66ErXjSf76RYKCiV4=;
 b=Mxc9YpTJ5UlUWyD0HzZC5OodnaG6aF34Xbb+D7uQowxkdl+FCBKxtYK0I4scwAhJvWsz7h4FMvUEacE4t+3Qr7iho2LJdRC6qBhbJdK/m88rOAJwV/Ol4/ac337VpLwMU7Ozn5xPcJQLRT59wKSIz17SBIv9sOyBtWwFltswLrjRfelIty9G5U8DDXfRe3gWWem7hGWwa32dBcXFAkqNMbxhPbHVH4PDisN5QcdQLoX3DU5FIEKlQzX4KL4LerGaYdMLzJ6NdFzGE8JXFkZn/YPPGRPW3/QifSZthF+jtRc1p8u/B3iSKK2XXMGHSTDVNcbj16NvxqirnwFiH//KRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 03/11] mptcp: refactor push_pending logic
Date: Thu,  6 Oct 2022 20:17:51 +0800
Message-Id: <c2a2b84b94b75d02fedd4166d2d1d73297a76bbc.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: f9095ec2-4b36-4870-4915-08daa794cf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jLoFaPGDVWlULqI7v09tqVP+qpvOXEyJcL7ahLGhth+n25y2wpZfIUWuP8isLXGFR1YerLVvWznw/GJeysXPp1/Jkfcs8oKz8d/Pb01Njs/jCVQ4x1thdNkmpzEqM6sIs243qwgJvl/wprnjSnmyzArmkHxCX5im9dCqJfC8yNbnx99/th3F5mxie7BL492Ev0NtHpNjsWRDrcPJhtgQIH9DeE5a5nv0PA3vXPaFo8h002R4FdQ/+kOLeLQgT6jBMXU2EIUXhU8ue04qLnDfMdUa1IaSDKJVa016SSBbZ26+e/dzX9gxKFnj3j/mEvKwzx9Vr2Hl2+ZQENhlTob8A2N96leTKM+g8otXznGsWxwvQIc5iBOLOxVJwnn+wHjfy/xFHe3uRA9p9/0CBtSyDMnYwBC/U2L/qQs7CosUBW0TWHj2j8MqV4OULCwECbVzzn+lDIVJu4u8WWAmkUHU5uI6CxmZpXNbJREG1G+29nUQmMI/uiEp6PbjTiKiDXzpbo9wkJrD/cdWDPXswDV1xR0x9bpcU0EBFMaDQpvyBRtya+2JhubUx+QQYDfkyBuCi+xaoaryYSjDI4aHpaNzCo7RsrlgC0ZnYNUkDpmOo/WPm6V0FT/l3UXihfZOz/P5UxW8m1N1jFMG1ht4v0nS8GWWx62HrBsN9FgoSU9lZe0616F/63c4D8C5def5sW1cpp45gHiss9YZqwVSssJiwyfthgdmclszbkHNY433kr3GfFPGX7NKfEXlm7BtvLcV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ho3jvNNn+nTLTrjo1SSPOJmcgHs1gQUt55A3SYml4zARTwjF5ZoDaqwmPzI2?=
 =?us-ascii?Q?H4TtIS++/Xh7LXIQt/5h3c+wnNqv07+Mtn4MJ5t8WF6IwAo/KwocAIShkX0b?=
 =?us-ascii?Q?HhQZFK2D961T4x/YnsQObeX2moGimawk7nRVsM9I5F+MeS6t3a2r+y5ne3j3?=
 =?us-ascii?Q?YQjmcKmyIzXBPTXuIsKJ0nDLxSX5BArvMVvWyA+8/CAAl44c59Vm64piTYnl?=
 =?us-ascii?Q?+hKBXFhC4HYmZgx9Gu4jfcP0X1gqT95bOoCkeBE/+3O5l4K/t4VmPMkiI5Qa?=
 =?us-ascii?Q?givsUvaLv3RsLe0iaOARICG+MD7MRA+fTBhrha8DHOO/eAFlGVy2Vk6a1esk?=
 =?us-ascii?Q?+zNGJG81rsb0d534TGZu/5s5pXTX64mccFlMv+pza2GW9DAaSU1T+eB39XZh?=
 =?us-ascii?Q?KZbXZf0Dh12IuSfUywlUPe61IgOCy/CExjKr6ItDdT2fnLdF8yFnAI0hxU9+?=
 =?us-ascii?Q?FmZc1ktytISj0H0pAbnOZDUtPqEYraotaN0lLpk3hn7HYA8xVGCQaJmFwc0J?=
 =?us-ascii?Q?rdATUcCjbkHpW1+IS4XIDniZeFwq+DUlK0iWZT86haHpZ+Nev+Fi2p8e4IvD?=
 =?us-ascii?Q?C92jCw1lHMAsSE6ydsF47zDpMTl0xGZxGzlI29XQ5ErgCrZOfpWGK8CK7dKH?=
 =?us-ascii?Q?MbOAJIv0TcMVjI+p7amhFnPeXwWWdy9ylQjb4ZSo+FLUuYh65nibli4pIqGb?=
 =?us-ascii?Q?CXv21/vA4OSBFCFEeQDP/nkodeSfNWOtKrXj+1zmhkMERYOWJ1fOhy7/SATF?=
 =?us-ascii?Q?BgZUHL2p/82hlwOcAl1g070sz2HRXZFAEZQbuI5n7sTGx37/Dh89qXZHhoHY?=
 =?us-ascii?Q?qvDKp/ixbxMBd9mkqaTtcUthdGtQa02bYhNk2NZOF8wMESw/AxKXy3OJCFT+?=
 =?us-ascii?Q?wNZlAFpzAvZpFYHGP0RV0iBFnkmUfGgyhuwXW0cPZhUP0SzDP2qR46OjILkP?=
 =?us-ascii?Q?zKrK2K38CNQB59mqlRkZm5VxAF56G69HAwZ+FtXQuRyGSEJ5sCHYcjluB+Ki?=
 =?us-ascii?Q?kWQEr+OGgnW82oWkWqRm5J31q4fpiomLIQSObQXvpTjgRTHlehsBmVvix9bx?=
 =?us-ascii?Q?ViM7a0svD0Ib3FzlqvrmzD3dX+ArPeDfxVs/IjOwNFYn0ogIsf5ec0N8CiPJ?=
 =?us-ascii?Q?xP0ruDX2rgrh4dAIU7seDCF63H4bgxAppKaghzpp/cHdeVWTCDu8riV5/Fki?=
 =?us-ascii?Q?uX87BdRajiTHNGjpexaKYP+1sgEKud6XHYoPtd5xstzRqLlD7QBtxeCO2icU?=
 =?us-ascii?Q?DqgF8EFB2YEuy47QEd7foYK4NSDqCK9IvOrFI158K1MCIe7RJcWvoJbTHbzI?=
 =?us-ascii?Q?pJS9kJFGt7wCi2SBO/F6liBnUSNv5fh6Ji4xVN29I5dtuCzux6ZVo5fFC1Mt?=
 =?us-ascii?Q?ZDmK3wfnGhq6JroxkKzs3Bc9EJUvEFdYtza3FBJjRXoJJrzZMJqvcM6ISllj?=
 =?us-ascii?Q?HsJQOQ29GKUZoUpDoOrY7T/Ogk9l+tHOCeQKCEBjU6bdTQzaeLZFOc3M7K7X?=
 =?us-ascii?Q?lPKWd6Ap2KLZRdAsanezltdrR89CkaEugjH3WkX32aDQQ13aUSbUVMPFa/AC?=
 =?us-ascii?Q?AX24PPbvDKGbnHx5ekBfcnojbRuTX3OVUAQD/xoM8ZmweotUyvJ5aW7f2FVX?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9095ec2-4b36-4870-4915-08daa794cf91
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:00.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z2ffNlRrg4QNev/nDIEmpBf0JtopGHODezeRRyD6YQoxQ27K26TLxE8ObfV5ixVb7lPA86Q6VHdno8nnjuKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

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

to:

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

This patch alse moves the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag"
loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84d33393d24e..bf77defbc546 100644
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
@@ -1530,60 +1522,53 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
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
+again:
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
+		lock_sock(ssk);
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+
+				do_check_data_fin = true;
+				info.sent += ret;
+				len -= ret;
+
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 				mptcp_push_release(ssk, &info);
-				goto out;
+				goto again;
 			}
-
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_set_timeout(sk);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
 		mptcp_push_release(ssk, &info);
+	}
 
 out:
 	/* ensure the rtx timer is running */
@@ -1636,6 +1621,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

