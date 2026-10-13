Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C43E3DAB
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874622; cv=none; b=rYXtTnCuhfJ6GvWE/sfYozYNEt9jA2cG/fBzuYWnw9MfeVACw04WMUdsU/0Cz6nWlNiJXxfwwRlaK7+gqD8K7Qs5q5y8jvGQCr7cmg0i5wxzEi65qO7806RbzgrOsbTLJ0GD0lv4Yi2XWWOtktWTglu17zmpjhw2kIJrx7fDqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874622; c=relaxed/simple;
	bh=bB8bP+EBqk8d9SED9t5R1zN+D1RMC9NlD44qwYK010c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWgT24mS7lD9ZObdwf6FTxfTPVXI74Chl6bMIEt5koi3l1GsjaGF8KMHf/GnKdO+pb8gfFwwKdnOgrKmIAz5QlKCTS10zl6sZPbII1Qmh7nzx9MFFqpFtlBJrA/Dp9Nnyk6WHxXuVdcVP1Wb+KP7GsjoaE6iQonV6vk09DlU824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB+PQt7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB+PQt7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B01F000FF;
	Tue, 13 Oct 2026 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874621;
	bh=7ooodC8wv2x51L7HgDdeMIWMCxUmSM+hFhx5pOc5UGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aB+PQt7FTKMxN5dYImED7zTggaUbu9jj8QmSOwWjizN88qFnOZwPdcnx8z9ln9itn
	 JGaH847LKf54SWV5kPc/pBdty4DhbXK4RoeFBjzg01ZhfSDvjPHAT2FkB/f0QnF40X
	 VzuPYFgZk7OcnbeoxWnMY/0mkz6fbMsOHTb7ZRcs0AU0xEx8J9dKLmoNRISB9R3sOQ
	 ljY/Brl5FejyRK048aOgDr2QPz+8NAen7BA/pgG58J+J8QOdfpxEZYuN1MsuP5jrYO
	 gGvM2C2D8szws+CxH2b1hd46RaR23pzDXbTspDjcoygDl/9LCnExgHTtdKqcQ4lJWa
	 1iUZcpJmvbGgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH mptcp-next 2/2] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Tue, 13 Oct 2026 14:56:47 +0800
Message-ID: <c6ccff66d3a0673b7edf6f6374be079877bd63e0.1791873760.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791873760.git.tanggeliang@kylinos.cn>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the new msk_is_mptcp() helper to replace the open-coded check for
sk_type and sk_protocol in bpf_iter_mptcp_subflow_new(). This makes
the code cleaner and consistent with other MPTCP socket type checks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 82b0ad25f700..53111d7a9eee 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -250,14 +250,7 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
 		     __alignof__(struct bpf_iter_mptcp_subflow));
 
-	if (unlikely(!sk || !sk_fullsock(sk))) {
-		kit->msk = NULL;
-		kit->pos = NULL;
-		return -EINVAL;
-	}
-
-	if (sk->sk_type != SOCK_STREAM ||
-	    sk->sk_protocol != IPPROTO_MPTCP) {
+	if (unlikely(!sk || !sk_fullsock(sk) || !msk_is_mptcp(sk))) {
 		kit->msk = NULL;
 		kit->pos = NULL;
 		return -EINVAL;
-- 
2.55.0

