Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2444385
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="40GBzwqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW3iYb6rihrBgzH+sBQHcw7EzwfoMkmqevmWw71cDsvYH4y6F5XroY++ds7/ikghTRkk1rV5EKTORqbf7ZxZe8PPB8/Z91n9Dw3wz2+BOUsvkQR335QJF0tOECLDevk1kRqUpaokI5RpSZiOhEAXSWTL7V8nlQp7bv77Tb0GWH2f/nCxUsmOFuwhyKH4H0rIl/NeRvWDT3cjPszrOSJSi68kYfywvBARTl42k1ZRdAr5foEpSsrXSc2+8x8jbIVW6Ts3YnxYxLzfISTKZlOpLTCTEqKidAkDeN3QlnOjsUASaXufth+2Uud6flljnqVP0SPOfuH+bHhGzF3EIH5OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLqiuDNfS3mT51/7msWDxjiXaUQV1Ypb5avgAFUWd4s=;
 b=RFnPbLA1kJXGaWiBT0jmvou5pMXr2cGeXIgAZQ9eg/yxyrRv6Ae1009yVPUr2B8iRujaMw19t0Rz6v+UEpac4EMezK2Yr8bYdA8yDDsbHhhWKFLwrMQ2erC+Z7QmODEmsG/Av3iOJx1+s8JBi3axwSIkVuwOG/TKgxaKZHIj6kldg3eFTuLkoDQhK1nzdcrB97D60xLbXQxQ0Ae+WQpPJgSdkU82mRD2l6oFsV1gH3JSA5H7c4iCONLEOFdsanD6400y+zkmYJ0hFP66YZEQe3IRHXbLmR3OgtPliHw6sdO4N1bFSA5LZRYlxmfnnrjRS5qP0EujLyZEvjuf0/8+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLqiuDNfS3mT51/7msWDxjiXaUQV1Ypb5avgAFUWd4s=;
 b=40GBzwqbNpc2IxIobDFynENmkU1hQ/xZBPjkZvKW3m3Cg0zMFQFbD7srgTqYcyOihUBKelSUjM5Xi7/iiDhUgv+t7Iwi+plLBjIHL7RemEIXEBUMG9TjxfLtjzDz8Cuax9+r4LFn/wSB1qoMxkVhljxtK8ppWv7NUOnf9rTXfJxxRX52PqOBqsNl8jZ/Ifu/d3XqNMu9kmNCL4ivk3OP25raSKALUU/FgQNhwCGMFWzfSqZSAvAB3ytB58LBxpG6XfkGUnB1SGo/DxI81Zg8UH9f/cnzApbWTHimbdWH/U98FdY7DfxBpYMGLC7yYg1k6XV4BsnWjkwN47rQzbhEtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:11:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:11:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] mptcp: use mptcp_set_state
Date: Wed, 29 Nov 2023 19:10:51 +0800
Message-Id: <f411d6ae643029fa9e1591077e20c727e8b19ce4.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
References: <cover.1701256112.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd09a24-f884-4c10-02d9-08dbf0cbe2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/PE3+NN5R3F+hQ9Z6jv1MubguUbTYOuZ6F1LS1fbmIoZxrHzoLPIrPKV3lEaEkWbGcKUNewOFiB+VOB3LapPqCFw5gJae9q3nYW7/D/272mSm/irSjOqtwzFLT+6mVzyLx7H/WOljBjqRTjTOoAM2VPuJxQEyOFexsDCdbsXmaINpHcoyeuzIOdWQi7yfjDmqZ6BBVk0kv9pZe1nwmrtq4nlMP7Nc/KIknxgXoXvgaE3RmrLrlbMXU3mxGx2oOPy4OGloEH5AbFBaQVc/G7CmG6uVfnKGcud0pijPNs/NtjyY7p4lMxF2Hi3lw7GJ0FRLr+W+FvbCPqCEcxFLmULuJBiGYsmagYkyQ0b1gOfpNo2ZJx8krsT7LcCkLUOGZlepY3Md6RA+jl+E0SISO09xwHyHYDX5uKI7AkkUFVhxVw70GZ3gn5NSIhMImgFrEphkn8+odXHChX2Dc3ALc2R9au2fZHOwHmutSYhOz3z+Xg5ZNswNup8UHEJIlABYgpVIYewv/CUh2JMjCoL3cCSpEbj/AI3Qynnw11emQWwxN4FefWEWFUJc3V/Y3wadvp89tMOmvRwAaL2xEA3gxSOU9/DUdNogyvJUR4pAcNjG8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(6666004)(478600001)(83380400001)(2906002)(5660300002)(41300700001)(6486002)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJbu1DUVs9ncH27bzIUI28eQ50b5CXi/w8XN9JNqtvwdH0WLdfqmkhM+UJuv?=
 =?us-ascii?Q?3SN2UnYYmysUjYxR8eGiUR4JyYCgV1521PkMbcKj/enuhp1ReJyYdzmq1Llj?=
 =?us-ascii?Q?FDf70H4unD1Orhi95L8BhU16a44ySMocPaFeQ6tmLyhwT9p2PXoaBdxqb8y2?=
 =?us-ascii?Q?/Me3QSDIiJse4Ht5mXctFBDxlpuql506P9vM4Z2pmjv/78tzhHQww5jOLVI4?=
 =?us-ascii?Q?92o7FnUgbFfotJo3MDGECYBl3b6BCmy9Tzd0IbaDzuAaiOcFYDpmISCLccrE?=
 =?us-ascii?Q?7THq2hsEujgD0mqwtSVJTg7EPXtK9dFGVQ9A8DSGygmrPI57Eb31O0j+B5vh?=
 =?us-ascii?Q?ENsT2zRSbAn73aA7kyQ0PAVnnRCaiGoG/KtHc2QxUiXrklkdgjunzMJ1is+x?=
 =?us-ascii?Q?DLCLNxzDVSo2nmipOjHVxla6kFC9H7xUlhja1Su8tZH8s/iEVl6P8wRW643r?=
 =?us-ascii?Q?XDjbRcDTC0JgGDYD9jYKbCzNWltwBrVqSXnl38+RkV0Ut1QiCXKgyR5FVdHA?=
 =?us-ascii?Q?WtNXgHjyTqmNv1r1NOX46rH4SDamQ+u683JxNzC6sn6eINSH4FepJRW22o0F?=
 =?us-ascii?Q?3oue4nxDIgxPSFDjf9dkZFW35JBOTpekQYToXOq+Ql/bRsEOBwjwfawAll9C?=
 =?us-ascii?Q?xdhDpmJdUgL1qPe9Vi/fTZbH9gDbxTOhIUgW1gBD6ffvSNMjdNkChj7UrmYN?=
 =?us-ascii?Q?hpfPvDkD2uzuK0nxTEeRiYLxGAA0WNxW77X9HUBUGKbIfDBFLmhGv3H93gGT?=
 =?us-ascii?Q?dw5HlIcG9Nr5f2a0xQFUzvGMA4yro1V1+KuW5T9e+R0mdXtIXFEd5kutQaXi?=
 =?us-ascii?Q?Lk319q743bxJz4yGR7A2bleWTtoNl4JkPOLTtpBPe1paYRA6E0ddGX3we4ex?=
 =?us-ascii?Q?GxqO8QhYGG/qSjJSr8nrQmVk9K3DMiZN5TVbXb8k5XzNeLU9UeNV5gSnTf9T?=
 =?us-ascii?Q?t64IDdnGhrUJlvHcVUMJX7RDRwuhHSQtn/CwUj/EuwmtwNyopyJALgRK191U?=
 =?us-ascii?Q?rgCT/FDk1QHQksGXuMkT0Wd17LlOA0e09Jairj6ESBzUUryrVbPDVRI3bnzH?=
 =?us-ascii?Q?e3jID772a9KfENRemUQT528FRv2BTlg05B/SAoJdNeP5uvsqY8xX9IQF8U8d?=
 =?us-ascii?Q?iPIwJYM3JeQSe2k6Dm9HxFTeCPdlSuN4c6dUrYLLm0reb73EzrA6f0JQCArx?=
 =?us-ascii?Q?MbPIvvbeMbagmBNXnWWM5NnEA7cZmvjztfL3abI0EMjtSgYbol/V1NV+Sirk?=
 =?us-ascii?Q?RcPUgvibuS5Mm6AcsshX9Ds4b+kOTTaLdm/gnhee839Pr095o4bCtALaOZbI?=
 =?us-ascii?Q?EqTE6Qg6Xz506YLP4XXUXMABqsWuCDP1jnRhbe7VDMb35lHn0AoKd2fmA9/O?=
 =?us-ascii?Q?Tjrx5st6bnIBnE6u7zxEtUto1mbWNKVkNEwXH0OtzBM7/djkVgzzPsatJSEP?=
 =?us-ascii?Q?Rk6jK+BDxC7F6/ION1FwrrzvpKkXJbRf5DCP3QoTSKkUfFfLvtj6EI4/kbHW?=
 =?us-ascii?Q?AYQisWbyFJOUeeRrucQINbVNdRBwgzm891UbATDNgi94dya88RvnSGn0oA61?=
 =?us-ascii?Q?opKPtbzphasrG7XQhrtikZGuOfu/5Qgp1gCgGPjHdrD/BClw0D9F+c3hq+zu?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd09a24-f884-4c10-02d9-08dbf0cbe2c1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:11:09.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng9PVZSVcUdJCDl5Nf1qcf9A2p3BYOV+Ff3ul5vzGAAdHy4AQLMJp+fwq0Eu9XDpSHPrUPj3uxMfGGedTYD3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

This patch replaces all the 'inet_sk_state_store()' calls under net/mptcp
with the new helper mptcp_set_state().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c |  3 +++
 net/mptcp/protocol.c   | 38 +++++++++++++++++++-------------------
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..b93683b5e618 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1048,6 +1048,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	/* avoid replacing inet_sk_state_store with mptcp_set_state here, as the
+	 * old status is known to be TCP_CLOSE, hence will not affect the count.
+	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd0d54d85080..c7c3ee453479 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -443,11 +443,11 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
+			mptcp_set_state(sk, TCP_FIN_WAIT2);
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
 
@@ -608,13 +608,13 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
-			inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+			mptcp_set_state(sk, TCP_CLOSE_WAIT);
 			break;
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_CLOSING);
+			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:
 			/* Other states not expected */
@@ -789,7 +789,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	 */
 	ssk_state = inet_sk_state_load(ssk);
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		inet_sk_state_store(sk, ssk_state);
+		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
@@ -2477,7 +2477,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
 		if (sk->sk_state != TCP_ESTABLISHED ||
 		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
 		} else {
 			mptcp_start_tout_timer(sk);
@@ -2572,7 +2572,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	}
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
@@ -2707,7 +2707,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2926,7 +2926,7 @@ static int mptcp_close_state(struct sock *sk)
 	int next = (int)new_state[sk->sk_state];
 	int ns = next & TCP_STATE_MASK;
 
-	inet_sk_state_store(sk, ns);
+	mptcp_set_state(sk, ns);
 
 	return next & TCP_ACTION_FIN;
 }
@@ -3037,7 +3037,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		mptcp_check_listen_stop(sk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		goto cleanup;
 	}
 
@@ -3080,7 +3080,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	 * state, let's not keep resources busy for no reasons
 	 */
 	if (subflows_alive == 0)
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
@@ -3146,7 +3146,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		return -EBUSY;
 
 	mptcp_check_listen_stop(sk);
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
@@ -3234,7 +3234,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* this can't race with mptcp_close(), as the msk is
 	 * not yet exposted to user-space
 	 */
-	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+	mptcp_set_state(nsk, TCP_ESTABLISHED);
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
@@ -3693,7 +3693,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
-	inet_sk_state_store(sk, TCP_SYN_SENT);
+	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3743,7 +3743,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		return err;
 	}
 
@@ -3833,13 +3833,13 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	inet_sk_state_store(sk, TCP_LISTEN);
+	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
 	release_sock(ssk);
-	inet_sk_state_store(sk, inet_sk_state_load(ssk));
+	mptcp_set_state(sk, inet_sk_state_load(ssk));
 
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -3899,7 +3899,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			__mptcp_close_ssk(newsk, msk->first,
 					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
-				inet_sk_state_store(newsk, TCP_CLOSE);
+				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	}
 	release_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a4f3c27f0309..ef1e22da5837 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -423,7 +423,7 @@ void __mptcp_set_connected(struct sock *sk)
 {
 	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
-		inet_sk_state_store(sk, TCP_ESTABLISHED);
+		mptcp_set_state(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
 	}
 }
-- 
2.35.3

