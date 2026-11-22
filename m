Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349256;
	b=fFC2ycEs6xLHED4fy3o0SQt2UhBcKRWFBC9yOGsIotu26gBae7no7x6RLiTIhrNj4Oga
	 YWXEnzmM+6gHn+8hl0qQoFBdZlnPbt+y+zgr2iTp4pB9UqGUhR83LNQE819uJ8QloIqBI
	 xpCl/dzkL0ijhG9r/0l/1lPkpDN8HiuosZ0Urd9uMBEpoNto12/Na9EYn2DTfigNjAAlW
	 z8UDILeKVu1OvXDW7/op4Scz93CALFyrgSjc5XjpaqE/+Kib3A1My+Y/k7aMeMhnllag8
	 71zarH9JAVfoPbptRa23wpSaV0VRcjNByehT2IwMeW/4i5A7rzbTB1qKxSLvIOXGt1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349256;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	b=oOetAyMZrnX7ZEANqReP0mXJPYZ748OtW4WndBupR+/qDzUA0WxZ0KmM9naCwpWooOJa
	 HEDJ8BxoxNrHbtNDyMU8BctEvtLKrtbIkXKs41c4zE1mXS3nrB/haY79Ht/OLw8DWc30o
	 PbUOsMFaJtGFBbH1nHeZP7ig3g9lI2A67QGILk+pggE6E4JK+0tXxcadQDhDqt94p48Fh
	 K5sCZx/2Iv6hgncAthLH2Xwaxe6Rvklqctjr5sfHUaF6OZg9nGznPvZnOgJTdmk9chyQP
	 B41DlURmAgJcTeq7XwdH53k0iQXu0PgvvCB5/Tr7atd+yZKt/m3sUnK3P4DIFKtaagQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFxxVaz0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6A606A32C
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFxxVaz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A871F000C0
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349255;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=oFxxVaz0gW01vnm2gIEAWh0N1fQCqRswFl6hAPLsD/k80Zsb6iNyadFxeODpArwth
	 uxHTumi5cyk/GBgQN8RibMiM1P+sfjwCQdvDkPZSKFsyf0KBTQmhv6t4M1FlmFcnX7
	 +lHhkcz0hA8HsmEmwKbx7JSBHK8lI6p13mE4vxOCPNT9PpfLyihgoQbyNV5E8psfCA
	 79mb/LRvEMYq3wTB1FebWQtZ57FRnpewlLRVEe1mN4E6iRHCDwOW3dr9l+kAEpSv/j
	 7bddXfPE1QCFs0QUXzRWOuzYRJ6i3R7KznHRvRzXTPxOS51WoJeF9nB7OXT9QXFluj
	 SfOGTkEI0S9Rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/4] mptcp: handle ack_seq advancing past rcv_data_fin_seq
Date: Sun, 22 Nov 2026 20:07:26 +0800
Message-ID: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795348666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
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

Change mptcp_pending_data_fin() to check if ack_seq >= rcv_data_fin_seq
instead of ack_seq == rcv_data_fin_seq. This handles the case where
out-of-order segments in the OFO queue advance ack_seq past
rcv_data_fin_seq before mptcp_pending_data_fin() runs.

With the strict equality check, if ack_seq advances past rcv_data_fin_seq
due to OFO processing, the DATA_FIN would never be processed. In
ESTABLISHED state, this causes read() to never return EOF since
RCV_SHUTDOWN is not set. In FIN_WAIT1 or TCP_FIN_WAIT2, the connection
hangs until the close timer expires.

The new check using !before64(ack_seq, rcv_data_fin_seq) ensures DATA_FIN
is processed even when ack_seq has moved past it.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d05..5ade9c25d0fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -569,7 +569,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
+		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
-- 
2.55.0

