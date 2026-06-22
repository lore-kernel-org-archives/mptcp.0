Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99F2D8DB5;
	Mon, 22 Jun 2026 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125135; cv=none; b=mDLf8GD06tvpsjbtw6DFNfZ3tEoC5mcMipQPNjwmu5WXpVITOV6Uw96Q8okIYMWG9RDNUs5eXK8QQetQT94/L48AUU2v4GjyXq3g4v7hHgtkEec4tG7PnhetTo0mA7chgvsF76bMYyw6RdE0EwSxLGgutxD77trmGgcde3xx7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125135; c=relaxed/simple;
	bh=8k7S1qfboZqmvpZVsqXkg/GjIOlb4FxWgv/vzSg8CwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6vZYJ0S8tWB0YSeqEtGaTdS3FJPFYFYBBJSskUQfVY4LZlCg/gnpnNgDXpKWZqFdoFJiYaNskN1IS+XYGNAASX+BN295MB4oRAgtFtsiheYHUoUrspL6Sxn8rfv5jx03I0c1JshhKpEVP5u+n5oaY3bW++753ei28vMi8cIHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojBEFTuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojBEFTuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AD61F00A3A;
	Mon, 22 Jun 2026 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125133;
	bh=+oXU5BQE83lpg+FNcsdULE1a0aNl+zX11pMLBsZsNw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojBEFTuCs0C8luxJ9zMTqGVG2OrkYkQtD5cmR4G1ZS+PfPL/Sy1zLqpCGm5jrxbtP
	 KVjehGuS/OID4dA3zcrgt+qtcJ3A81nyxewSZCUPB4nF3YsD37/JqMqyNj7iwKHYbY
	 AM1Q/66iaUAf/+ZfC5vmkmb/sW/MjcwTrguMeqymMvQPdMGaGjCCZ8mo5lRg0nmhau
	 YZQD7G7iRpvUPcUxcInoBJ+IMBpChyL2bti19q8xddG4J1CalttOCyz8Me/cMs1BhT
	 S7DLdbIxFAXr46sc+69WIB6cjKMiIqKp4BajjrBWsQfj5wv4hT1TWJ3ZlArJqP1O66
	 q1G75BAu0pV4w==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Gang Yan <yangang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC net-next 14/17] mptcp: update mptcp_check_readable helper
Date: Mon, 22 Jun 2026 18:43:34 +0800
Message-ID: <981719194baddbe01429181a35456042d84d20c6.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
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
index 169bd468f212..4951b1dd013b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3410,9 +3410,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4476,7 +4478,8 @@ __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

