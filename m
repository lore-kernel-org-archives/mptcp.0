Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD2176ACD;
	Wed, 12 Jun 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196957; cv=none; b=U41LYUcbbO/XQLlD776+T5f/sREztFPVZ8Vp+h0bYnKqLYigwKr90RhOk8/48imLIbYo4++/VSUbsPZ0yGAihyLHFREe1KeK8MldOkg+Yn7sbdsQHThf81uUfTwfihx4QIPpOfQI9sQNx+x4xj+Nw2UotE5NIX3u6wjRvSkGjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196957; c=relaxed/simple;
	bh=REY5zuJhiLNMFNk9tBBW49SkL3KrfOF+XxtOA4yuC0o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BKtlj/SXASFkfy6cpS2FSSMzM/hRyucbYwFJjU/6CAUKsjh9+obrRcIsVoiTOpTUqR2b7SElUp+rtsDMND38XUf+CKIHPz7VhGNp9XSA2RwuGuDDReceDhXutqB9HeYaIb8CfVrVHmIDJXuVm1If9jonKC0HU6oxDaj52rjvXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BN87tnpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BN87tnpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75716C4AF4D;
	Wed, 12 Jun 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196957;
	bh=REY5zuJhiLNMFNk9tBBW49SkL3KrfOF+XxtOA4yuC0o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=BN87tnpBXOfRXx0I0lrGmD9vAq52rDkz1c5SSBIEhi8lNEV2V6nwBiHWWRK90GtjH
	 CyqSRl/OQ/ZisST2qKw1RB+EbpVYLdeT7/ikdlF9zsZHCz7DW0pY6UfLW7eL/HhPSM
	 hw4IofP9oUzt5mNlr0P4rqgKX9QFkwo4bKiVG75U=
Subject: Patch "mptcp: fix full TCP keep-alive support" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:55:42 +0200
In-Reply-To: <20240529095817.3370953-8-matttbe@kernel.org>
Message-ID: <2024061242-urology-tadpole-c503@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: fix full TCP keep-alive support

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-full-tcp-keep-alive-support.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-47625-greg=kroah.com@vger.kernel.org Wed May 29 11:58:44 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 May 2024 11:58:21 +0200
Subject: mptcp: fix full TCP keep-alive support
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240529095817.3370953-8-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit bd11dc4fb969ec148e50cd87f88a78246dbc4d0b upstream.

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
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240514011335.176158-3-martineau@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ conflicts in the same context, because commit 29b5e5ef8739 ("mptcp:
  implement TCP_NOTSENT_LOWAT support") is not in this version ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.h |    3 ++
 net/mptcp/sockopt.c  |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -303,6 +303,9 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,6 +621,31 @@ static int mptcp_setsockopt_sol_tcp_cong
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
@@ -803,6 +828,22 @@ static int mptcp_setsockopt_sol_tcp(stru
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
@@ -1303,6 +1344,8 @@ static int mptcp_put_int_option(struct m
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1321,6 +1364,18 @@ static int mptcp_getsockopt_sol_tcp(stru
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
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
@@ -1430,6 +1485,9 @@ static void sync_socket_options(struct m
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-fix-full-tcp-keep-alive-support.patch
queue-6.6/mptcp-cleanup-sol_tcp-handling.patch
queue-6.6/mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
