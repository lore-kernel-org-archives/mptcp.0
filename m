Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090313118B
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251728; cv=none; b=WGYGkwS7L6vvYSAVAYKemloAFkboIIGq99r2H/o9L9xNQ1IeYi6bdAW1tZe6VuBdd4d9vP+XhqCSSNWqzBveHoGUkwQeQ2CsFTzmmfC+XDfQEsgX7tWFWojqQ7Pq98P7mUoSXwxUBKSpsfmDMSGJc+xMOyN9uQ86/Bouj4gAplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251728; c=relaxed/simple;
	bh=jcXwS2oy1b5KgnHbACkt16bekkVdb/JefnpwJM9wsns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grA6vb+y8UHadh31gs/gZ3+19kYZFGuV4DR6k6gmOXTQ7FzSHlzq+ktvRmgvcND5qLUM3W2EknE8G3iwZfKpFwdmss2vQQgQz7fxdNZFB6JME+9z55XF1PpRcmKAHT6y+Vuip/jgEQtt67f0YKNssazrgoP9EYRMidAE0RY3xqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB7rwUIg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB7rwUIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92346C32783;
	Thu,  9 May 2024 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715251727;
	bh=jcXwS2oy1b5KgnHbACkt16bekkVdb/JefnpwJM9wsns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB7rwUIgto9fG7Z97mUMmAuOS+UvIvotTHMy27AaKB4lXfqWpNc7BamsrgY239pDU
	 PbSo5USAsKGP4cwBsJctp2QO7DGCFMgnombIDmzZuFRJO1pewYKFIoT3bTBS7oKx6e
	 L5gtgjDSih1GcnR8pEr5agoz6qrGAe9wgWFERBUIWJiJz0GAdv9vCHSvz97wi5+drO
	 lv4Lth5C5p/qoku1mKSydYgLWSyOzGawAdu3duqPEdtV3sx8+2uCYKxQ3GXgy8WOWk
	 V1YMy6XJ3AcwKF7Rpt5KdT1Ook4HHhkqOQQWzix6g9HK3qOCXpxsEYF9JwR9NfWHuB
	 5RbXOWIJdQKLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 May 2024 12:48:22 +0200
Subject: [PATCH mptcp-net v2 2/2] mptcp: fix full TCP keep-alive support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-mptcp-tcp-keepalive-sockopts-v2-2-5f97067847a2@kernel.org>
References: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
In-Reply-To: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5698; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jcXwS2oy1b5KgnHbACkt16bekkVdb/JefnpwJM9wsns=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPKoLa8K8EQq2DbWCxwv8DExILF90yYggmRxRC
 V0BIFQc7omJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjyqCwAKCRD2t4JPQmmg
 c03pD/422HfG3Aa9Sh4/e2Cbrl3WaSIoS1IQSQfQo2Ge4yn1iM9vyt/hdhtZcYzpjQZpM7OQ9zj
 9V/Ag0mRd8eMBC8e5owUVbSS9hW2EbBx3zbREIwqymV0Tz57G18Uz6AU6lk5McV3i7TAUnOMAID
 St90z0MJ9YRND9xANRdnWY4nBtSnG3YQTLSgAXpWqaZ1m0UEPLl/rT5DovCkkltaOCKMBzXKplW
 tIrpqodS7LRH2HzwZMxu4GMoxtUd39DvDKR79yMJPMVnUXZR6ZlTPFhJImq4uMHDF3+6ICcYlWW
 TRSwHCjFl3MR8FayAXVaiPzlLR6+zNaPeRuSpcX3C226Udqh7mjUNe3XneaDtBqeRTGz2V8+kmo
 NkngRecTLG2xAV/Qd4PQrPs2wXSOQqrtH5nP2wjLOR739FyT2Mk/5m6rZdHVwZZiUjsFYOtb3Sh
 v9/HP/wJJ8A/uC2u0OZ+ofuzcNsMLbdjVq+MzawIi+r3VQzScqeO3AUIcpCaJ7RiPz3VO457CX5
 gr4jiO0sPXXSag4+53anD53FbI4YC+Tt7ULt+NAgSMBNr/Ohuwz6tYSQYplXISHcD+v0mIwXGEz
 CZsA0+ytjtR0d/kyRRxOJvL4UlZwIR4YzVYO1Ku28CtZovYWr5IcgkIuH5wQuF3Rh/XW7OEEmgH
 ryJH+vnRQMFVqgg==
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
or the default one is simply returned. All of this is very similar to
other TCP_* socket options supported by MPTCP.

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
Notes:
 - v1 -> v2: Addressing Paolo's comments (thanks!)
   - Store all keepalive_* variables as 'int' in the struct mptcp_sock.
   - Set these var (+ sync) only if there were no errors on the subflows.
   - Return the first error in case of multiple and different ones.
   - *Not* changed: getsockopt() part, so not looking at the 1st subflow.
---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c09357e04f23..b5fb26ece2b8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -310,6 +310,9 @@ struct mptcp_sock {
 			free_first:1,
 			rcvspace_init:1;
 	u32		notsent_lowat;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d9f0d36e24ad..8cc30c9007b0 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -622,6 +622,31 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				      int (*set_val)(struct sock *, int),
+				      int *msk_val, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	int err = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
+
+		lock_sock(ssk);
+		ret = set_val(ssk, val);
+		err = err ? : ret;
+		release_sock(ssk);
+	}
+
+	if (!err) {
+		*msk_val = val;
+		sockopt_seq_inc(msk);
+	}
+
+	return err;
+}
+
 static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -818,6 +843,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
+						 &msk->keepalive_cnt,
+						 val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1332,6 +1373,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1352,6 +1395,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
@@ -1467,6 +1522,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

