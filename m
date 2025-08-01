Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAE1917D0
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042194; cv=none; b=sG/ltqzACyVmZP9O9OzdSnEkgFaPRdPtiIZiuAuYF8/QytNKlyKS29jJvgzRoi5gVIVAYaWOdXeDqNI4xkYSfw6FnCfNxZDJgeQ30Ag+j3ap/2zZAYEYWg2P8J2+OqSvdYYTqJ5x6ocdHXxJk+U3HzR0tN0Y9g3ijvCVLpo8JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042194; c=relaxed/simple;
	bh=1Il9YA4Sx5mm4W1U4gzN+97eAHty9rUM985z2d920T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0UGolYSmwsjP58ORQ+myPkeZm6JXWccsUOBrwRJ/5ZKJ2oRHUdUi56aIGhazg0Fl2pEir3+blHpIOP/ahLXtk8Hc7RVZVQ5UkK7pDtt3F71r1rV16Bwkt49pRkQzLrd5fHv+IJIVP81jWh29qL6TyhyBLdI/pVATpP8n+cemtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID2ISegx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID2ISegx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C94DC4CEF4;
	Fri,  1 Aug 2025 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754042193;
	bh=1Il9YA4Sx5mm4W1U4gzN+97eAHty9rUM985z2d920T0=;
	h=From:To:Cc:Subject:Date:From;
	b=ID2ISegxY1GyEGNajmfgu957+npDP+ETIj2dq+K/8OqeI75KVnU8jf92cAj6UWf6e
	 6PaAPU02bMhmGWbWzzbRJjsrHbPjrkFoZSS71j+onGOdj8LmKWzVTMUHEQoo1ozzvr
	 2p4bkbva893S2r/W4FmhESOOzAddUd6D7ez8L5t1ZTYRFqBk1NIwkNVfbqcjGMmZfs
	 M693vVmInQzclqnjr3wWrO/2vrAPBhtIBT1AbnbgTjLrhZ+IyAyk2S8ETNqkQnk5Es
	 RmUJAEh7E/BqJ8AGkYKRhkU1C9HC/KCZeJnlxcSeuh5PHgW5I1C9g7caP79Fx4dLhY
	 e/bO8Pf+Q9wtw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: implement IPV6_TCLASS socket option support
Date: Fri,  1 Aug 2025 17:56:25 +0800
Message-ID: <7979be7e1b82de6ba2eeb8dbda37e1e443636862.1754042175.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds full support for the IPV6_TCLASS socket option in MPTCP,
ensuring consistent traffic class handling across all subflows.

Key changes:
1. setsockopt(IPV6_TCLASS):
   - First sets the traffic class value on the main MPTCP socket
   - Propagates the new value to all existing subflows
   - Uses lock synchronization to ensure atomic updates

2. getsockopt(IPV6_TCLASS):
   - Returns the current traffic class value stored in the main socket's
     inet6_sk structure

This implementation mirrors the existing IPv4 TOS handling (IP_TOS) and
ensures QoS settings are consistently applied to all underlying TCP
connections in the MPTCP session.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..f5213c4fa8e4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -384,6 +384,33 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
+					  sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet6_sk(sk)->tclass);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		inet6_sk(ssk)->tclass = val;
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+
+	return 0;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -426,6 +453,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval, optlen);
 	}
 
 	return ret;
@@ -1475,6 +1504,9 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_TCLASS:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_sk(sk)->tclass);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

