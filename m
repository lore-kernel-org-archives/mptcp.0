Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754200;
	b=wKNHIEPlvKzR8sr7o0CxIttW/LIih0C1pOWwiXaOcJUP8Rlyc3AuDughjc+QXJg0afyH
	 nG8kxhpa+9V7QP1c09hySfFkEY6n47Swq2zDmy3rzDoaeSyVS+w4Co2wd9HV11N5w1nyK
	 XkJ/uH/oB7T1xvwApbcEnUeJVHjve+cLw6VYQ0Z+52YgEqki0uotbmMTMAIOVCMMDyedn
	 1ur52bS2l/1hJq6gqfOr/oZTt1dtZzPkjmg2QIHgrFGmwQRCQfCNlY/FkX3mWjvz23zO2
	 x8wuRPUv+KRNcTkIafFeyL4ANBr68hDK3OdB4Ul3PyqPv2beE81/HchY5vrBa+8D1MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754200;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	b=nYOcA3tJQMjW5v2D49INCJwpN56IelRZSbIP309dDDUfUERTCCjVU4B0BiNohpaR2Z3Y
	 95fN5p17f8uvCPlwtYsp5MaQYeKmgUwB1jG0Kt0bq8bB7zy20cL5HYLgnaf5KJtL0b66M
	 EooWWWFVe+td0ZGmXGBtIen8ImzF+dwGtSEYDvQQIBzAlYNABjUVcKQvQagT+o5rrTCrt
	 cV0/Xqg6GJe7tmSm5xxgvCHcUWaNoDLIi6x0uOztaSSN41IDGEEQtDltHDw2iF5qUG8W+
	 Q60IHvMvJBY/t3PZzrrJvyI7Jxum3jn2tIm2/VBT9I5tL8w/WIyPrkaxOI6BbO5z7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kenswvdN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DA606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kenswvdN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C64A1F00893
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754200;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=kenswvdNt1lF8oQHsI9bdIp8ONRAz5oBc9eZqUBdy35LYVMJFjOZNR59wTp38vpGP
	 /nAUQiLz36EciVHPcuclags/7Ko/hmZ/gbyNKJthN/OkmnrjJm677Li/8nLrXxjEqJ
	 vZ8w7RAVIH9AagcFYzKo/U2o0iRJejKZTaM4x0zixlnzgPB+H9Go724ptt7ddmp0Xt
	 WkvDlHKb/1yIwRC8vXVeXTm3Bccbmkvm9MHYG+bTf0O+daD+AUPvShIdEA5UdI1Kih
	 abwUTR1UYRKfDDAk460VHcLs/LPYsn0o0Fg0Ci6pfI3NegL0VRPyVW2ZUdK/L+AaAa
	 y30udcE4zRMBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 4/7] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Fri, 27 Nov 2026 12:36:17 +0800
Message-ID: <f690c33e78c9d80085e66c08ebb7fdf71ab18cf1.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
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

SO_ZEROCOPY is currently rejected by MPTCP setsockopt with -EOPNOTSUPP,
even though the matching MSG_ZEROCOPY path in mptcp_sendmsg() is wired up.
As a result MSG_ZEROCOPY silently falls back to a copy on MPTCP sockets
because the opt-in flag is never set.

Expose SO_ZEROCOPY through the SOL_SOCKET setsockopt dispatcher. The new
mptcp_setsockopt_sol_socket_zerocopy() helper validates that val is 0 or 1
(matching standard TCP sk_setsockopt), flips SOCK_ZEROCOPY on the msk, and
propagates it to all subflows. sync_socket_options() also synchronizes the
flag to keep subflows consistent.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..3391f7a9d983 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -184,6 +184,31 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	return 0;
 }
 
+static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+	sockopt_seq_inc(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		sock_valbool_flag(ssk, SOCK_ZEROCOPY, val);
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval,
 					   unsigned int optlen)
@@ -212,6 +237,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -351,6 +378,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -396,7 +424,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
@@ -1682,6 +1709,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	}
 
 	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
+	sock_valbool_flag(ssk, SOCK_ZEROCOPY, sock_flag(sk, SOCK_ZEROCOPY));
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
-- 
2.55.0

