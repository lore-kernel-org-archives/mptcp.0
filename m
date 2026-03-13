Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE43275B18
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366201; cv=none; b=NTrU4DrNJ9AgZ8a47EXdGcVIY6WX+80zNWRrNTaOGp4eMNPvOvnY1fpTgi9eIyipJAl3CslfBM8j9gOvCFnfv4sxD2OQasItRrZ6TGgEjX0tltclgLZybP+u8fOkFuPTTRKZzYXpgSjAR7kmq0jDOW3zdlKWRTcY3tu7VQq1CwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366201; c=relaxed/simple;
	bh=xHPSVUzH2+0VMZ4mXonK0ay71tTFip9oeZ33YQSRYtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw07YIwWVQU8OqyLRr4UPNGNjDzjPlsUziQoBfh93O1DO5H48i7k7R1VZBGslJ0KZVF4sncM9tqLnRZFswyVYmgZhwLuVu9odP++PmsRPfVvWcPZhfkwH50aZmmA+1J0Ge/YGQvEISiQjosrsvECJzzgXnBE0SPJ8TOGd4oTnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9KHqMNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9KHqMNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404F6C116C6;
	Fri, 13 Mar 2026 01:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366200;
	bh=xHPSVUzH2+0VMZ4mXonK0ay71tTFip9oeZ33YQSRYtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9KHqMNQ66kDYEYukMRLiTizjaKboBWqul3iQckRCv5OELRw42bGnC/CEtZWVMqdn
	 EHGRusYwlF8GiuCRNOuCnp+NJzVNgw/oi9PZnqZyM1gWPsq1LYpMV/17Ww62D7TwvE
	 j93mUx4QiBAM8/GBp8b/asRQwUUPexoS82H0kbn0MSpxIqoZzglRHppV9p9X5Fry3e
	 mYq3IKDfFi6JvZwHuA3xuRKdatIBISsUBuoRB2Z5dTUzhCrbQCOEnRQ216gYMnVV0b
	 MPHYpVtMui/dBkqrD3ff/ptdNfbq1tH+Z1pbiGzgPfDLFN6cT8/tSB7UvbLcV6JUcA
	 IFWcJjiOeRaIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v9 04/10] mptcp: update mptcp_check_readable
Date: Fri, 13 Mar 2026 09:42:46 +0800
Message-ID: <3a0a823d6656c19c78feac59943055a01a2d4d01.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
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
index b5676b37f8f4..c0109338648a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3242,9 +3242,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4306,7 +4308,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.53.0

