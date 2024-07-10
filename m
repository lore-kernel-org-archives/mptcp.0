Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8604A3F
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619177; cv=none; b=Wl4jioIooFsj9SUYVNh95JTTaCDdcY0jPdvrkdpfw+mKhCDUkFiNJorXSGMM86qSwQ+lz+RVKu2bsnXOqr2LSMAp2BN6wDsbZKL/WUs9h16tBZ+RJ4IhW9X8JchA1CH7ZaOGYUS4lKZl9cqBEShgtf64ypTESCRdY/dt/BPCJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619177; c=relaxed/simple;
	bh=MSC2csZy0yXAx/O598k2XnLt3VLnBrCTVIY25hbcWRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvIIkcambqNTJyE8gT6bJvLceXqSB6PlTcj64Qdk9QvRa3r+1GhZE1atzAP7Di7IiqbIwZJB0Bj12JWxgWoD8KYQ59O1tV3MuXr3km6yxKH+G0/iZ+nSP9SGNRfsqDknepEZ2dwhxVbxhmfUKFyYcYI6oppwXRALCF1uDWGPGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC9Jqcjp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC9Jqcjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C647C4AF07;
	Wed, 10 Jul 2024 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619177;
	bh=MSC2csZy0yXAx/O598k2XnLt3VLnBrCTVIY25hbcWRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nC9JqcjpDVLjdaom+j6OHm+RJIfJA7egWWyWyG/b32GigBcG4tRXIloCVvuSxCnrf
	 O2VeFWw9TioE+VQ0WPN8WB+dYianDeOaCrdKLcnC4dH8To6elfUHsdhDzFilNlLP9K
	 Pdy2bTosqt+MhhuIjzchyzIZB/1HCUaN15OsVirjcP7svdqFhtTmO3NtKODFqE3Ot4
	 1qV8P2/wJO7SIikhHHyo9dp/ik3K8RnauIoNRftcN55gokwq5K5YzLiwcHSijC0DBY
	 6JknodrE7rEkpJlYTB4rcH9Xyl6u3JclCqQ2DiZSP3kCifJkhADRRckNd+uiMpD8lg
	 PJDxXGJRNJkeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: add mptcp_snd_nxt helper
Date: Wed, 10 Jul 2024 21:46:09 +0800
Message-ID: <53b582fc24af3a387417fce90377b5529b225063.1720618186.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720618186.git.tanggeliang@kylinos.cn>
References: <cover.1720618186.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's better to get msk->snd_nxt with READ_ONCE() in get_subflow() of
the burst scheduler.

Similar to mptcp_wnd_end() helper, this patch defines a new helper
mptcp_snd_nxt(), and use it in mptcp_subflow_get_send().

It will be used in BPF burst scheduler too, so export it in protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac94225489f8..6f662e7d6ff9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,6 +55,11 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->wnd_end);
 }
 
+u64 mptcp_snd_nxt(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->snd_nxt);
+}
+
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1465,7 +1470,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - mptcp_snd_nxt(msk));
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst)
 		return ssk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19d60b6d5b45..26b010c88773 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -706,6 +706,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+u64 mptcp_snd_nxt(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct mptcp_subflow_context *
-- 
2.43.0

