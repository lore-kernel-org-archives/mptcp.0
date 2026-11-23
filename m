Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397242;
	b=ieNmDXSRnyKZc8LD2G3XHNZUuITKkXOBaSFzHsvKnbVjwuyBc3h+Z5CrZaOSt8ErlQSV
	 07Z3HuabozBwAXjPcoF97mcCr7ggs0eAgqeUeGs8RC9dUjRuu9VlJXJbreGorROvlFsaw
	 iAKYWmkpT85biwV7FMB1BFGap8MYakWKPIKxV2JeAsAYms/GEcM2J8ACVgvGs5IPTJh9N
	 ToGgMzo8gG1KsHc6qJaoNGzGht9TyF9LCEUg3NUiTMHPO34dJwNVAal6QdL40P1aqFi6B
	 AnQw5glhgY5NClOPl4Lq64yyPnX+zTl89nRb/n6EEt1iKVIeoj9j4KzjoBwTmOFHMbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397242;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	b=T/YHPv/aePx+JZ/nDiKdZHsp+bT3ODaX8rRbEb3w7slZUcpNtl8ST0+KMajA8POdRjeq
	 pCwb6IJVPOOkRGRiGaxwpSuXQcpBA0JfVzv3aJyilTDwU8I0YavG5nJCCmQtmBx2gYwad
	 g+k7ZycMZUC218odyVYNqf/j7+CL3pYae9ZfjShQjnLhIGC4uFGrYUjx5aPhCWJng3Whv
	 wPJdQAbiUiZq+ErTmzjl4Nf5PzPSVr1bsU0iI+WhIBUi7z7eFRmUl1oZbz186tarbHfKL
	 bJ5oiGF7wYyOXWt/TPIeYm/U3lkFe3URGqduj8Mf5mLS054mdyjOwGHMQ4IBR+yDb2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjbGSmHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF9606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjbGSmHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2B41F000D0
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397242;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=cjbGSmHf85WJHU9PPegkd3Bma6JhgXAtX85tBoA6uCIkhx1v0iHSiLWIDR6RGSbd8
	 klvRXvL1qMu/7WTuQ6mx/xHCxw3cp/Lg1jrKBojTiM0C0Fuk1av7yIgZ8pDevAUMdr
	 1DFsvlwd6FEX/KW2S5nQhDt9VzFUXC9fEP46Aa1XZlbZuXx0DZjkItQGMGMro3ysWf
	 MRC1IzMywyxFB4Ft3OcYl84KtqvDJN8lClFVdyi5yTA9lxndazmuLGuRbFAznUcCaB
	 PfdW+BZhrSG0bJFyv4ul2w+//SA+8Q7fLPyGKP9mxBl+B2H+p4OcVa9IZEGlQv5OGR
	 sa0LBq0EWrMbg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 2/4] mptcp: add missing memory barriers for rcv_data_fin_seq
Date: Mon, 23 Nov 2026 09:27:12 +0800
Message-ID: <da8ae9e6c48df602b08475d151a87841ad632400.1795396910.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795396910.git.tanggeliang@kylinos.cn>
References: <cover.1795396910.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_update_rcv_data_fin() writes rcv_data_fin_seq before setting
rcv_data_fin, but there is no write barrier to ensure the ordering
is visible to concurrent readers.

mptcp_pending_data_fin() checks rcv_data_fin and then reads
rcv_data_fin_seq, but has no read barrier. On weakly-ordered
architectures, the reader could observe rcv_data_fin == 1 with a
stale (or zero) rcv_data_fin_seq, causing mptcp_check_data_fin()
to either process the DATA_FIN prematurely or skip it entirely.

Add smp_wmb() in mptcp_update_rcv_data_fin() between the two writes
and a matching smp_rmb() in mptcp_pending_data_fin() between the
two reads.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6365e180d9a0..2b04f083585c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1192,6 +1192,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
 		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5ade9c25d0fb..ac7ee8deedc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -567,8 +567,10 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+		u64 rcv_data_fin_seq;
 
+		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
+		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
-- 
2.55.0

