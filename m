Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B1386C3E;
	Sat, 26 Sep 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436655; cv=none; b=Zr02NIRVkYT6fOm0/wnB2PBnBe4xNozrjmIOa5dx7HVBpeZvu9gz+EAVZgU1n4U+T8xVbyQkdQoz2S1vuUNh9pzRsy5pkeW7lgYPQF6+uLWC9NJ1+BRAwNqm1zh2USSqAiUyNPkZTEO/b3QBiAtSQeBkf9IXu5w40/XWFiUXHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436655; c=relaxed/simple;
	bh=qha52vBJjcCyclbZxDNMrg06VZm/eryaQRlKah9D8GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+bshSV5W3/3GpyHhGHvq0W8izaytbAzupv6GfhNJc5DEVEsKo/NzAoMwIaUWDesFE0u06rgmusgJoIOg7BS2pHtFGD8oT6jV4HEBK4EA9vwhON6RejverQjyXCJw/xdIpJOTv2zEwsf/+/Q9oJUl9yA5g5Hc615dO6RPWe98zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ID3MIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6ID3MIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531001F00893;
	Sat, 26 Sep 2026 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436654;
	bh=9wwbNo/A7r2bOTwfYEfMAYsDChwd6ivdQ/O4Qm4cbsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i6ID3MIj6F4XhgejoFQOXMbCOF3L5MnBusSDc6zfIEBjGZS0vzo3hJ7yBm7Eruutb
	 dI4p483fxuIFVWJjH6zN6MOxiRIxpr7ib13FVqFoXtrFcB3WH/oXm09AMzvJDZzfvN
	 4sl98NcGzasal29wb1xS6qYHCCjFTDy7vT3ehIbAquWTjrlwt3FMVheJhboLC8YXpC
	 X2IMmw3w39P7ccJi4txAY9R9H0Iisoopmh+QjyaRKFZVnbXwMbrJfhqVWLgS63jvte
	 YPeTpbWwoCJ2BFlterBqIb1IpFTlBt1KsbY+odoLRSqlaYJyrP3TG295PaYtJCnJcN
	 KfvcVoCAXY7gA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 26 Sep 2026 17:30:35 +0200
Subject: [PATCH net-next 2/5] mptcp: split FASTCLOSE key from rcvr_key
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-net-next-mptcp-misc-feat-7-4-v1-2-67af4ab37406@kernel.org>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
In-Reply-To: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9DwC0hOI9qsIM1pGI1z+aqCB24lkJOs4U9ywZkuffMM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK2P1WpPZXEYxazWrB68oJVkl4/DnwKKbOyZo/cY6J3w
 OrApN5fHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5tZrhv4+6ZaXj/1nThFc/
 53doaItt/BK8eY9TfuKlZu71nMU7ZzH8D2kU+XcsVf52yIQZ747KVi18e7l4yeoJKX+zN6qvOrT
 2Hx8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Quanye Yang <quanyeyang@proton.me>

MP_CAPABLE and MP_FASTCLOSE both stored their key in rcvr_key. Give
FASTCLOSE a dedicated fc_recv_key overlapped with rcvr_key in a union.

This helps shrink struct mptcp_options_received.

Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 6 +++---
 net/mptcp/protocol.h | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5a3a..c2f4d7bd080c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -374,10 +374,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			break;
 
 		ptr += 2;
-		mp_opt->rcvr_key = get_unaligned_be64(ptr);
+		mp_opt->fc_recv_key = get_unaligned_be64(ptr);
 		ptr += 8;
 		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
-		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
+		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->fc_recv_key);
 		break;
 
 	case MPTCPOPT_RST:
@@ -1258,7 +1258,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
+		    READ_ONCE(msk->local_key) == mp_opt.fc_recv_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd9957d334b6..6b9bffc5992b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -146,7 +146,10 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 
 struct mptcp_options_received {
 	u64	sndr_key;
-	u64	rcvr_key;
+	union {
+		u64	rcvr_key;
+		u64	fc_recv_key;
+	};
 	u64	data_ack;
 	u64	data_seq;
 	u32	subflow_seq;

-- 
2.55.0

