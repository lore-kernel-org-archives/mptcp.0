Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1693A5428
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580869; cv=none; b=ShSiUZMdmErTiWM1lCtOTCPnA7QdvTpsQVxsNxNdA/C2qQvi2L+t0pJlZQD18vNipG3nRIgbZCmK0vhCp35Uu9UUjIoMPx8gHN4aFieNAJtP8bjUjRmrMHN8gIyU+YpeSpPqb1AJMhOnWwq/bNZnIy+9owWSKUten8HRk74IqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580869; c=relaxed/simple;
	bh=4sNJz1UXrfS3cwXFcuxEZLzgh5XNWzJ45n3uN8QRbaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iBIZn99wE0tGx86zpPW3DU5vd6IfukquFOkWjwzHthnlVtMkOMd7d+q21Z4IsmQuN3pBp+wgorHAusCUt8Kjy+Lg6A67DN/n3OL/KLjoNxq2O67huwGVwMZCsxS6hYX49GaCYQQ7Y1SZNtf3pTlzYUB+WykP8jYBL/QgrD7sgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8NvOfzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8NvOfzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46856C2BCB3;
	Thu, 30 Apr 2026 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580868;
	bh=4sNJz1UXrfS3cwXFcuxEZLzgh5XNWzJ45n3uN8QRbaE=;
	h=From:Date:Subject:To:Cc:From;
	b=A8NvOfzXrzdPFteewgGC7OND+osFjr2ZzbrsRc/8ebecav2wikpOecFLOjzjbbjYy
	 8n+o7iTeXp/yOMhk7GvdaDNblYsQWsgbU6Lnv4iywiOtvGwq0/4wUIMMGaIOuamSm8
	 nhyONKJeTQKBSKcSUfmu9mtHWcgaQqWJ1rgNaE+UzFsm5r9o3fdkHjXMXV0RSO/5BE
	 1UWOHAy5m/8OEh9C5QM2WAzeWLhyq2ByiZczAzYNbZ5LSXRdQhgFgS53lkBgh8Nkxv
	 hhO9zJYjerbSGqWZOmx+V5/ARccphAsU3g5IC3jKXuy0rhuEChpgDeSmgNefxpo3H/
	 dFHtOXNCnW/xA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 30 Apr 2026 22:27:33 +0200
Subject: [PATCH mptcp-net] mptcp: bpf: fix type confusion in
 bpf_mptcp_sock_from_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MwQrCQAxEf6XkbCCuYsFfEQ9NmmoUt8tmFUvpv
 7tab/OYmTeDazZ1ODYzZH2Z2xgrbDcNyLWLF0XrK0OgcKD9jvCRiiTkNPyTj3LHMiXFtmNlaok
 4CNR/yjrY++c+wTqOWuC8Vv7km0r5umFZPnuaoNSIAAAA
X-Change-ID: 20260430-mptcp-bpf-mptcp-sock-type-7abeb0700b2c
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4sNJz1UXrfS3cwXFcuxEZLzgh5XNWzJ45n3uN8QRbaE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/73au2KmpEha24vk1zf7V7x/Ut8/4vN9g/8kDhv1H6
 ifsLUxJ7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIqzAjw9HwEL55G3ft5yvZ
 O0tV5srcQ9oXr7AerrdZY/9g6nIRy0iG/zVLL6RkX2ZyvlD94fgagfsbhc+mrXhQmFd6M54zQP3
 KZQ4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
IPPROTO_TCP, but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

In this case, it would NOT be valid to call sk_is_mptcp() which will
assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
tcp_sk(sk)->is_mptcp.

This is similar to the modification done on TCP side [1], by Kuniyuki.

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Link: https://lore.kernel.org/20260430184405.1227386-1-kuniyu@google.com [1]
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index aeec9a3b8b05..08bb037f0951 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,7 +193,7 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;

---
base-commit: fb282c0c802d7e4444bc49867d71e3313315a0f9
change-id: 20260430-mptcp-bpf-mptcp-sock-type-7abeb0700b2c

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

