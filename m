Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F523207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvwGbwFZ2n/zAKXE4D6ogYsbmktzDgYyPCR+eF7e/9kjDWuZh7obtaXJP4NnzfJ+X9UpWwebDQ7yS/YWOXxgQbX9dDP+PrFTFo8HwdPZL2JvhIzRJSG9+nr/WRPmyja/dbXcsmwlHkdoQakeVn+FrHNeB7DY/Gnv0OmZfPUxVRuMVB2FONcgMiv+Fx0uTdpb9lnmFZXDzQ2vz/hvBmS66aYmjiYGWcRP6rYObWtmPAocxHYz++mLmcvd9HynsV9s/jfNHeO1TF7+/WLDmrwgQj4x7VrOtLNDB5cN07h7l2kInBh7EcgqQ3Ib7ySilnstdhS4CRAFx8WQEJpUPsjSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5XmRTxGg+iHvA9Ii+5Gb3IcCdv39LVRNfeDrcA4uN4=;
 b=U7N69+veQy4N6gfmQKMwDHb3dAUc+XBmTd7T3mtGgJOR4ubh11DaTNTNMhfo4CB/fFkX/8dk0AT9rsoQZ7FD+9F58P+OGvTn9imDu3F/UxdvweimaDo1H4L1CbXBJiiGABm/SYS9z4iR2I8fLtdx+Nzy3bCPH+4OAAbUI6rVAyuzGfOaTb6rgTynUFmGV2chM7WaEctp2ugHEj40PpLMN/qXioRxbGLKR2HlacVTM52GbWclf9onb613DPVC3vs3wxgEhVZeHtKES2IXOYXOtHi5J3LVFcfdJgsH4htfUuzFF4VDHilEemZ9YB3RRGL8tg8yojGzlUl7fCRY9e59mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5XmRTxGg+iHvA9Ii+5Gb3IcCdv39LVRNfeDrcA4uN4=;
 b=nc1ES5/hMslVHaaDdzBIPgvdbQNLiztzCYh6WPXQsx7zx8qLw6Ip7kfzqHbU2HYgGZWD+HowuAve2pGq6T2o52rkUa9tnwJwDtgWbTAQCfWW3rZ8p5mJ55IAwktUZsKQswaFGDpVjS1ANsFDPwKh9Fz167U94Xm0vVLAZn0wDVFd4a/ebQIH2Al9FujdsJ4DYmhySmFbMAFm9GpTtC9X8ljmFD8QYiPjDvLdDnbouuo7YulGT6qz02f4ACu1NdtJXKnL7cdwvQ9/7VrWJPWh6W9dFJzdF7w21eNQVUZKYtMbHDqTrfpiQbajcTsLBuwaPUodO+V7WKo0dPRc8JdAMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:02:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 10/13] mptcp: simplify subflow_push_pending
Date: Tue, 11 Oct 2022 20:01:34 +0800
Message-Id: <20221011120137.5475-11-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 430dda62-9eed-49c4-18bf-08daab807aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fw2y/DjrHLHky5CdpGUAh/OuGFvxmMmz1zjVEN+iKoSF7PNVA2Ek9ojhp/Vh60pHDYH8K8HmE+g0hViP0ErhLLVgAmMwLD91W3PsPd9/f+7tWJBln14naFcdb6sXIWKs0S9ok8UzqakveSQad0BywuS7dQ39VNMOGKOcdPv45llN/QWdiLaGnCoxTjj2IsGysRuJTwAoxcZXypwCzkn8sIAMZtQuvvtUEW9qoN27lh1wOx3iC81OECENv0vacaYKNTAp35dNVO8ecTIoYmcIdTRlAv6Nx5zaGFYs6E9Oajhl5dW6coibu8Q6A0MavrxriIfLKSrE88wNIFA8nvGi1GTUOF8zdaelHfOJOIDFtke2Z1Vsprf+N5W4EW6J/1wu8V1kH4dLWprls/R3514zycv+ycZ9882t1E+rT7umOHMvZnywMxBD+ZpCDdhjjmMLz5nywEPn1bDXi3sUBZEuTWdZXmnypAbaQcv8odohPTecPFzeROLxobfwnYWLHmJt2bu1FDVE6XrK9O6kM3pQqJ6h0CAfbBhQL9jIoLqntLRkAzzObZVAUNIpuDGDyUvxIlHn+7fBKh+VZXoGnTMZdzQOMwsenYLBVzq20oEKNB7cMCLM6fehMWNrCxrgM5tnvmm03CnAy3eEVECmQxMJs+GVoMAsor1Xlm6ICfO5r5Vr7I692EIMNbnL/iMJP2/XN3EEfCrtFQbCF3ki6VGo5LlXD0fppdG4rLC27gEZcgvQ0G5W9YjRZ397iR5FPg+K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?thYfvdWRg16YFFSbUqniI+xrcggsNPAyPbl1HAkH0hEqjgbFOqWP2vMPVBAk?=
 =?us-ascii?Q?zMr+ZN9gAUBjWkunyyavAN4hYnejVt/ceh6hIIsMAbsj2S2GiQFxLz9ELhLw?=
 =?us-ascii?Q?i0eIrSobuNJ4mxuUrj+JBR1HRHkgqIeMjScggfAacUQqq0TcC+6jsFhkHKy8?=
 =?us-ascii?Q?S9nZ9HmuNiUWqxKt/kk6kmytdc7NFV3e4lw6b4/xr3rttuRTGtRkqIKDG57g?=
 =?us-ascii?Q?Gbmo5BXGPvrFU3U3dTPLcUQ/t/yDNjgDydyXzK2cQz2+zgNFs/VHrk2ihxeJ?=
 =?us-ascii?Q?NH3x9AJZF/KjG1RxTzgrDMi/sMwxeJ/vV7XAQMUJQwWUk2HFMLwzdTo1GCCM?=
 =?us-ascii?Q?CbohEmqCR8lz4VY6piTeA9hIRqiDxAAE4yXv+O714OD9tsnjcy6X57kQC1Ux?=
 =?us-ascii?Q?ljL4XraIfCv3htVde56wHSSKXYhrsC03EKZ1bCjGn1j+un5Kq4sdZhY+Y26P?=
 =?us-ascii?Q?To/zAiKStYz8NtFwXC7mDpjfl6olNc/0FNCTrAwFlnbdC2W/dwDwhp/B6Bqn?=
 =?us-ascii?Q?VM6PY0ctq/Egm6168ORn1uWhsjazC8GE+L1tlCilNdzacZFu7N9uSQtkdf84?=
 =?us-ascii?Q?PKBef1yfISeaCPoXewvwhmrG9MFif0ZzpfPC2twpzBuLwB6A4dmmbIOJCJJF?=
 =?us-ascii?Q?P8OjOB0sZX66CncT9C4d94AXRodfoKXbObR7pXTz4M39fMXKq6mXcupykNwf?=
 =?us-ascii?Q?If7HikFH1DvbnR2AU6ghrZkLdT9UmooTe9+uVbVfceuP7EzCKBSRMJYKPq/C?=
 =?us-ascii?Q?7CdLRZOq3z8Oa27SqOp98EY0pG261Q42KKkKrYdKYpeflWz0oBlj5o37lDqL?=
 =?us-ascii?Q?I6/dSAYeWsXcozDAlWUllcJxWTYobN+8qL5pHPdixxIMUlkoReoAxvviEVa9?=
 =?us-ascii?Q?7DNgsOWazj2ixEaMK7S1HK4dbKCL9OzuBJa270gcR+C8XRLhbCuBSNfza50M?=
 =?us-ascii?Q?ogBQ8H6uJtVgDUJHCABSV+A4Lru3xQkGm0vR9wkVmYQeEmy0XZiiiOYJIKNh?=
 =?us-ascii?Q?0p7rSdhrdVUn37/aSWV/LxHSubHr9uUU3YEQ4gqu2h7L6U5s5FqtuBVNGFP5?=
 =?us-ascii?Q?tZ5tgw9sWfEKrUKSM8ervh8TGuYvU+l40ShO1CrjTeeEI9WvU8gLVs4RyHvF?=
 =?us-ascii?Q?GKH1xGhTbnscZIoTbmyVnvu1edwt6EGh0JAaPdoyYOqK+afmVHG8433AQ/fG?=
 =?us-ascii?Q?V1KGyIbLs1IEF/KMdx2pft6isZhkwEffcMshzVylXQfrBFLXzk7p58GSYbD/?=
 =?us-ascii?Q?HeBZQFMA3Qs/n+r3sGSqP0bgVBLAer0aQDhb1z7LyBEWYzvuvCemSaFgzANB?=
 =?us-ascii?Q?AXLVOzsrS2UsiPpdD8pfJxS0X5qX+h0WEtQyMzrN84OAK4DxrlpORNTL9MHz?=
 =?us-ascii?Q?fm3+SMTePQMBVx4EWdJ7DRlMp2JTvI0U2eYYRUmjnK2f0snf4CFaAp0XCWl3?=
 =?us-ascii?Q?qX9JPFT2V+Jz0galqVk4PuJrnWyuJ4/zP2z5xMeaURqjYqnyuEuK2HESN5us?=
 =?us-ascii?Q?BVO460HZpWN/Qie6G9aMmNrdLa2x2j5kZNvybSL8j5FHvLFhWVAtyXejY1/c?=
 =?us-ascii?Q?1M2d9TqYZ6osTIGNVe2AZob52HxSCoz53jwfqlzMVrCMDt7M/+yRREB3v2bR?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430dda62-9eed-49c4-18bf-08daab807aca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:33.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRdsTwlpyhGDAk7O2mD+vN8PCnxiJn00mHgIk7And4zRPBXXOL85Awn6wpGk4eVMKF07AHeftQuSv7d3Y1Pgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

This patch simplifies __mptcp_subflow_push_pending() by invoking
__subflow_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 676f3bff988b..e9eb1da42418 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1604,11 +1604,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1625,32 +1625,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0)
-					goto out;
-
-				info.sent += ret;
-				copied += ret;
-				len -= ret;
-				first = false;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				goto out;
-			}
-			mptcp_set_timeout(sk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			break;
 		}
 	}
 
@@ -1658,9 +1637,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+	if (ret > 0) {
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

