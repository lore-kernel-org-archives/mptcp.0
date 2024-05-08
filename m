Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D87351A
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161504; cv=none; b=Uv/LgsCrRL3A2lBT02yvE17Vgi1xmdeTds7LEK+QnbX/I8tyxWSE+k+s1kKVGj/WvxISEAncAkwgDwdKa9DbbLOfeQheD35iRC9vvLGSr27TifZsNYtOtRG4oazCLEldb4iQIa69z6BOHiQoT8QcYw5VrbBPjCagZwv4igK5hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161504; c=relaxed/simple;
	bh=ksreAEGnNzmeG5OiE7Gg3UuxKoGvCfS88QXSdCs8nUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkm3kkau6RLYk/VmWQIMVmzwUshRru5Ye7k2nA6CaVs29at2Hy1IF20kEdj7xbhdwhUrCLaz/te/3Kq3SaymsDKxI/UeQmFeQ90YfeEcbbYYNKtKzrlkYtVtiXfLrOPP/u4RMYU2QpdmKqkQDnDtwUG8gA3Eh6yPN+wExB6RnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyAtcwXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyAtcwXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A82C113CC;
	Wed,  8 May 2024 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161503;
	bh=ksreAEGnNzmeG5OiE7Gg3UuxKoGvCfS88QXSdCs8nUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RyAtcwXHifqP1LSRMNA7OYvryX57ybWn3kcp9BnXlPF/fYdQk5EcGTGW2PsLDyxj9
	 AudpDDWIa3R2JK0+P7yuWu0f88HuBZRARmj2yJwRBDP+D6dB/vzloMkrkK8fRqpuUs
	 tk5/CqXs3MgGNstZcBiW0h5VMZW4FclvIzI2Vd2PzOb6HlaFCqgj1YB27pCMjiudgO
	 diQh7P4EX7hIMKDLfzNnKyEZ/WyN/P2FGKrKSsRk0mxG4Q9fcC3wAN3CO5p1j7cYaZ
	 FnFI1DG0MLCCjgeayfd4nuI4FtyRzcrm+c39jqwL+XcDeJCZjVa8oYwssj3XD+mbtK
	 ittusZ3muN4uQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 May 2024 11:44:56 +0200
Subject: [PATCH mptcp-net 2/2] mptcp: fix full TCP keep-alive support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-mptcp-tcp-keepalive-sockopts-v1-2-fdf7e03e14c4@kernel.org>
References: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
In-Reply-To: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5282; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ksreAEGnNzmeG5OiE7Gg3UuxKoGvCfS88QXSdCs8nUM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmO0mcWWAplU0j0AVjvV/D9o/T4nl1unmjCATLR
 Y0Jwgk5XiyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjtJnAAKCRD2t4JPQmmg
 c3YzEACak72BmUz4acHumxeb63ShsDAxkEoiKU8PXXhbTwKM3bemBFSN5PKRN0h73pEQaJdr3zS
 LEPb9kvI6sjdD5IHpMzNskHprH4+/dPn1ey73iAeUidazh5tLCe7GYnhf1EgMPqWwl4QP2Vwdh7
 d5q6M0uv18R6kvQjHA6C3pAgXkE+UXLoWMM7ix5KnH0uzk+/WJZD8Ok3o0i271yH8x2SkuUKHeQ
 XKLZXVrgg2X41hCjKD7mgZ+kkMLBfkiVqW+i+aB9POQOrXPbolxiMd9g3A12ra95kGD2QO3tpsI
 lk9TUa0BM0+gaVYjgeA6BT3raL+O1SdicjkNv1RpkmaMq73DrJ91EfJmmcYSD6J3pqq83VQCcCK
 E9iBYM6ZZB6WMItW4CiVYxN3jT0/bW4fT+YKhaxnNCWr4ywgb8NWg/k2wC9Zo0BqP7VhYh3Lebl
 mrmc4Gj4clYDLU8wGM4J8eBmSIHzB3Ckkm85SdPwqzD+lO8qqRlTLmtwpeTuyiQ1WKrZ6ORZjDC
 lWEOWXqH+IiIM5Ck9vd55qm151LZQ8Bq4ZRNOeujPvkBa4GdlHfAB6OSFYHWkXHte52YI4Ftsxa
 TQLHWshdjyN3tPwgWurSZsAjftkDYIxihy7l0SXs7UnUKFuoiiS2++mTRfhrNHca6AE478fGqEf
 A4Usz6mq1NzFBNA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SO_KEEPALIVE support has been added a while ago, as part of a series
"adding SOL_SOCKET" support. To have a full control of this keep-alive
feature, it is important to also support TCP_KEEP* socket options at the
SOL_TCP level.

Supporting them on the setsockopt() part is easy, it is just a matter of
remembering each value in the MPTCP sock structure, and calling
tcp_sock_set_keep*() helpers on each subflow. If the value is not
modified (0), calling these helpers will not do anything. For the
getsockopt() part, the corresponding value from the MPTCP sock structure
or the default one is simply returned.

It looks important for kernels supporting SO_KEEPALIVE, to also support
TCP_KEEP* options as well: some apps seem to (wrongly) consider that if
the former is supported, the latter ones will be supported as well. But
also, not having this simple and isolated change is preventing MPTCP
support in some apps, and libraries like GoLang [1]. This is why this
patch is seen as a fix.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/383
Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Link: https://github.com/golang/go/issues/56539 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c09357e04f23..8c7ab1d50c75 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -309,6 +309,9 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	u8		keepalive_cnt;
+	unsigned int	keepalive_idle;
+	unsigned int	keepalive_intvl;
 	u32		notsent_lowat;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d9f0d36e24ad..794d8b63024a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -622,6 +622,30 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				      int (*set_val)(struct sock *, int),
+				      unsigned int *msk_val, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	int ret = 0;
+
+	if (val < 1 || val > max)
+		return -EINVAL;
+
+	*msk_val = val;
+	sockopt_seq_inc(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		ret |= set_val(ssk, val);
+		release_sock(ssk);
+	}
+
+	return ret;
+}
+
 static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -818,6 +842,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_NODELAY:
 		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
 		break;
+	case TCP_KEEPIDLE:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						 &tcp_sock_set_keepidle_locked,
+						 &msk->keepalive_idle, val);
+		break;
+	case TCP_KEEPINTVL:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						 &tcp_sock_set_keepintvl,
+						 &msk->keepalive_intvl, val);
+		break;
+	case TCP_KEEPCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						 &tcp_sock_set_keepcnt,
+						 (unsigned int *)&msk->keepalive_cnt,
+						 val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1332,6 +1372,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1352,6 +1394,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
 	case TCP_NOTSENT_LOWAT:
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
+	case TCP_KEEPIDLE:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_idle ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
+	case TCP_KEEPINTVL:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_intvl ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
+	case TCP_KEEPCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_cnt ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
 	}
 	return -EOPNOTSUPP;
 }
@@ -1467,6 +1521,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));

-- 
2.43.0

