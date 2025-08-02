Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48D11CBA
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178752; cv=none; b=F0myw+WG6LMesPSBw/DOpfSeuIJgC4Zk22cWOsw3Xty7RTHa+/syhkW8YayL/k95mDp4cCHYM71y5xNY69+PH2CCMkrCCqDjsh6VphrMmD7SS9LTR/zba8zTSjSKhXPYa6guxY/B8zwAYmv08yfUy3Li0veHSa217fr8768wCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178752; c=relaxed/simple;
	bh=Q9QdlX9iRwg5358aQvt7Nk0+FfIalsM7HdXambuk3fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3YBr95A8U+exFXSuvCduWahf0R+70i8GUhYhokRCJefk/azpADhEKfTticNLdM5YJliMx6sVqez9xLx8TAHts6G0LxY9Y4nc8WrF4Q+Wbcormp4YRGMa6LS8Y1m6Mo5xi/SkLcX2VHArNuyzPbAT0riz8zk+eDA3mRJhiOD/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qly+Fl2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qly+Fl2O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77529C4CEF7;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754178752;
	bh=Q9QdlX9iRwg5358aQvt7Nk0+FfIalsM7HdXambuk3fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qly+Fl2OQ0ZvkDnK5dbZwu+ohvVkRvuoniODXQr2PX94s7DoPrBVN2K3cOaPrcDIg
	 J6hYyIUvt6OcflamtjjsX696S5M1mykjFANEVksI+c7Au8k7YRql4C0mKbV/AHKGma
	 zDtz5iVN5i4NFAmTDaYoaUkYdRvwjK0ogULoFfr4GF1QulX+07o/ywIHb/NTpIO3Jk
	 SfVV9yJKr71/pDzyeESmHbW/UNvKKW9GNL54Pg2TjzvcXM/8DSS6i6Ajzma7SaJSeb
	 1BqCEIHFetNXfqRJ+SpLDgmGFX1QTNBeHVbaCb0vStdNjj5CTmXP2tG54rOkv+VnPy
	 9CQZnOrg7EIHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61176C87FD2;
	Sat,  2 Aug 2025 23:52:32 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 02 Aug 2025 16:52:22 -0700
Subject: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
In-Reply-To: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754178751; l=3129;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=N2ba+scj44k7tcJAqXwLJ7NphQMBR1SHDfj9Nxl+Mbg=;
 b=kbvG78jNcooG74sFqFb4/lLzfhnc1f0DfQhpGjPLTwKPcnW4NGFi+6JfSsrQLAsF0YMwfjs1Q
 1aE1EogCFfnAj9hOGg02kU6OLt5/Wvh36abwuw6NGOzyt3P+WzGzhEq
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Add support for SO_MAX_PACING_RATE. It will limit the rate of each
individual TCP subflow to the specified rate.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/mptcp/sockopt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95bec90d341de9f9e136b9d2df9b8e13..a79dfeb54a3fe0d8c26a1836ae5dda9fd2fdddea 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -308,6 +308,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 
 		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
 		if (ret == 0) {
+			/* Record the option at the msk for subsequent subflows */
 			if (optname == SO_REUSEPORT)
 				sk->sk_reuseport = ssk->sk_reuseport;
 			else if (optname == SO_REUSEADDR)
@@ -340,6 +341,25 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 								optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
+	case SO_MAX_PACING_RATE: {
+		struct mptcp_subflow_context *subflow;
+
+		ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
+		if (ret < 0)
+			return ret;
+
+		lock_sock(sk);
+		sockopt_seq_inc(msk);
+
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+			sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
+		}
+
+		release_sock(sk);
+		break;
+	}
 	case SO_RCVLOWAT:
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
@@ -373,7 +393,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * explicitly the sk_protocol field
 	 *
 	 * SO_PEEK_OFF is unsupported, as it is for plain TCP
-	 * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
@@ -1532,6 +1551,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long max_pacing_rate;
 
 	if (ssk->sk_prot->keepalive) {
 		if (sock_flag(sk, SOCK_KEEPOPEN))
@@ -1579,6 +1599,15 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
+	/* Keep pacing settings in sync as well. */
+	max_pacing_rate = READ_ONCE(sk->sk_max_pacing_rate);
+
+	WRITE_ONCE(ssk->sk_max_pacing_rate, max_pacing_rate);
+	if (max_pacing_rate != ~0UL)
+		cmpxchg(&ssk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+	if (READ_ONCE(ssk->sk_pacing_rate) > max_pacing_rate)
+		WRITE_ONCE(ssk->sk_pacing_rate, max_pacing_rate);
+
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));

-- 
2.50.1


