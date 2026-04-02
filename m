Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C032765C4
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116084; cv=none; b=XUDr3OIX+00DH1CnJmTRUwHAAh5twZL2WM/hmQcsS6++dUuuDym6Z7w6Fw4tPLQWvKuvJ9QoCqjGHGA8gS7uQF1DLLHKSCK7L+5bFJAsC1MAMSVyusq6UT79Ikhb6MHTVaiQylSRW1RRva7rLeKK1T92wIA82AViEZ5ObnhWIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116084; c=relaxed/simple;
	bh=2xZp9/IYGEFRhh10+V43/rCgkiNtKTgKgP6vogiIakU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juOlaPw4PonksvIzVhaTCdfEjNiUn3/ZXNBbT5UlxONM2KBwe1tGKwdFqcGMZWD4JdZxKFifIA9GQ4NqctN/bnmHuNi7IRWrSpz4zGTlj9Mds/NyYSJbvcxVWxgv5grsmkby1y0p7EuPPPPKe4lyfnL9DkIB7MGmhucU4ohK1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1SWKt18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1SWKt18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0916AC2BC9E;
	Thu,  2 Apr 2026 07:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116084;
	bh=2xZp9/IYGEFRhh10+V43/rCgkiNtKTgKgP6vogiIakU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1SWKt18JvdYRXI1FEju7DN5OPUrO7Bk9TtPZG0q0zmokm8gXahuTThJJ8pdCVpfH
	 Dox7LKnBgFIU4jxRHec4ZCn0mjvK62KbqHj6vbxKVfisDu22WrOOBh3K7A+OTxUJde
	 kiLHgsKfO5lhkl/QooHAViTD87W1PsLsWo0FIQdtXZWqhAZbbAkZOCSyTaWmlbeUhT
	 4SuCyU0315y6DAKkrSaGbWb0i0H8rpgELkKpt67FwpGCJZARK9oo1wM7biyyI89EIG
	 iDnuwsCIyZ5UkN57rDIyCvsWeav7wUybFV/O92+8v4jn//PrnQG/whhH2uPfx2/BZ+
	 rSrKZk7pba/Ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v12 04/15] mptcp: update mptcp_check_readable
Date: Thu,  2 Apr 2026 15:47:39 +0800
Message-ID: <16ec7f5220b1accf1047893498196abaae7d0e4c.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This patch makes mptcp_check_readable() aligned with TCP, and renames it to
mptcp_stream_is_readable(). It will be used in the case of KTLS, because
'prot' will be modified, tls_sw_sock_is_readable() is expected to be called
from prot->sock_is_readable().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3630a230be53..975c54f36f7a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3322,9 +3322,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct sock *sk)
+static bool mptcp_stream_is_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (mptcp_epollin_ready(sk))
+		return true;
+	return sk_is_readable(sk);
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4386,7 +4388,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.51.0

