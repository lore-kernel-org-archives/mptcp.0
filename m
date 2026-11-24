Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557682;
	b=EvSGIHK/zgs9U/Be0vDJS4dkJ+6fAcJSaoCYxxSa3zrRr5WlGtwFZf2vFSPC8lk0uuwt
	 fOCH6KcJtpaYYQ8xeWS8au9bMMVFv6meQQM9QS5QUmioLoUToytFxlJryutWemjZRBLvj
	 +nxH+qm3C2ZXLBm8MJAqHzBNNqpKFw74Y20xB67vbmHavaLA9RCnHPztl8BgN7AQK+Ncm
	 z6l4KA7QIuIBSdhLz/TtXUA2EDAkKZXI8TiTW67rfh/zG7HOoqOkfAxKW/DlUCSWn+n5c
	 XMIW/U2Uv0DekXT+O7w9cVY7+6gXZEFY9O8ER1+w4FymcabfgpQ4u8Q6jnbSl3SExtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557682;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=e9JXBbhIbo8LlQy6Rs1KEK8liXyNWPi7ANv5yEPdfVo=;
	b=3XjU8gkv0K6t21pTS1JM07WUVAfnbD0C2YI75FRZIxN0O4m5DHeUyvMtTyL0Ks5kz8vb
	 2kka0rlJLA5sGjdufAxv91l3+DWe1/zcedK0QBuKoS1RQHOqCqcYxXHehD92a1yuq7Dgl
	 Ho5aMpZjE4OAO3VAmBF1wu414oz/t5F7Xo06e/FJ01oVRpbB1478HYHQq3gnEC4aWfYhc
	 BZvPdbnibWRSffNIfzfpd05+2cfMViwtN3ccEgWa9TOTiPCN4NqNWJa3kXFlvCvEyLkEt
	 8D0zSkGcevDKikb0ilV+F9HvkGvFbbO/+QQme+598h6mSMCsOMM6DA0t5WA6FGDLMhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d51V5aAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94C606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d51V5aAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C4A1F000D3;
	Tue, 24 Nov 2026 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557682;
	bh=e9JXBbhIbo8LlQy6Rs1KEK8liXyNWPi7ANv5yEPdfVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d51V5aAdm4WrY4VAFpQkrLmC4B6R7GgvPn2P/f+I/xVntXelnKuXAZG7GBONhEKgh
	 wEAFF1+QS69rNsd5PlY/1brmbiyq0hGHVykR8tUk5LvStVuuYeB6hvYFa5NBawVxP9
	 58DkEvUu64EhveJIm1BJOiPcn1DdZwembu/0OjJV5ft/faXQuew+XLn0GVGqmZgDDr
	 q1XlX6ZTLdU1dQRNJRUKgRt+9qgPYmnRlb0lyan7I6DLgPfTIF05DQxypcS8qaC1Z9
	 on50nruuj7M/zUc6cP4ysXJOmYGajU8XStz9GGUqxbDYnRliGwLrIj+4UGTu3xjm25
	 9N18BHwcFlroQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:37 +0100
Subject: [PATCH mptcp-net v3 20/50] mptcp: don't inherit fastopening from a
 listener
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-20-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Do50zQzc5z/BiN0ccFcAYRcFzymPHXMl0/+Lw91A+jE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOJmj/B0cOl44+dWf77KuMq5M3/DeNmtK1vOMza6Jr
 AWfJDd3lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOTqEoZ/FkuT1TYz9ia9bhHf
 pvXMQPzlaYX8M0kvaxa+Fdp3rfnTM4b/hVKOT4MiXb+nT1oY17x267SIL/Z7E+Z7tNQXn1wd4pr
 MAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A new msk is a copy of its listener, made without the listener's lock:
if the application calls sendmsg() with MSG_FASTOPEN on the listener at
the same time, the new msk can inherit msk->fastopening, only set during
tcp_sendmsg_fastopen(). mptcp_disconnect() then fails on this socket:
connect(AF_UNSPEC) returns EBUSY.

Clear this flag when creating a new msk.

This issue has been found by an AI code review agent, while reviewing
"mptcp: fastopen: keep listeners and connections": before this other
fix, these new sockets were mostly reset with the listener. It has been
confirmed with a Packetdrill test, and a debug delay added in
mptcp_sendmsg_fastopen(), during which the handshake completes. Without
this patch, connect(AF_UNSPEC) on the accepted socket failed:

  runtime error in connect call: Expected result 0 but got -1 with errno 16 (Device or resource busy)

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: msg: the new title of the previous patch
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d529cfb582a5..b1072123397f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4005,6 +4005,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
+	msk->fastopening = 0;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);

-- 
2.55.0

