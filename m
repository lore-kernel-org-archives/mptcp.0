Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BC22EE4
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577422; cv=none; b=JwcBpwyq56zk3uBK/PS+Pp/YJ6X9EBC7rZQ8Cg0/yVwgc1qNiHM0OShSQZMYB7uZOPBd1bCPwVcqWiuL8TmOWWRx1fKelyNhiU3RjZ5Xn1xnhex06U0F9BzZJ/d4eNdDJNEtdUHWWAhHhsRYUoi1O/gn+rdsa1Pwco7kfTTj0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577422; c=relaxed/simple;
	bh=MGKPW1coI7Z3QH7W+Y7LUNMIzX8a1dh6h0jgLZoKwFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHwAK6U7b/TkStpZa4fg7VQ2Y1e1imJHwclEWDurH2RbQhK2yfD4Y08b3CiXLtCX00KXQgr/AH2H721ACYLlzHD0XmMDRlSRlWvx6xQKjAVsICILfgBD/+uvGxZWFS03m6z1SIethBZWhcfyPSNlRAxGsJlFkx4qeKpaul30BtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9hQvVWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9hQvVWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2EFC4CEE5;
	Mon, 10 Mar 2025 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741577422;
	bh=MGKPW1coI7Z3QH7W+Y7LUNMIzX8a1dh6h0jgLZoKwFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9hQvVWp5+FzYgGBsjzzF1gAKW5/FUBlTuFY2R8Pi88B8ZM4ePSE4P922aqN1xoFo
	 OEQjDpC8xEtuCcB/uH/zGd6gonXeENq5BcAvp+ljV+NEKewNEJYkaM4wjD40qYnQtY
	 f5684phKg1LjX8gHd7qK6S5TxjVq8L9dIC8rvKp5IIwUulmrcQEFrIt8Uy/woaKzo7
	 ab314ygBTBeVpubW0F9w/GjrToPY0OhyyVwlhnB+U8OL0ZnifLvHuQAgfX4H2UiUKb
	 RPdRmy4I2h+o0aRLcS2tF7tQAhFKQj3iOqmziEmTvsm7PjHHyARMXiYCiMab/5IULy
	 YCwTii+pIityw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] bpf: Customize mptcp's own sock lock
Date: Mon, 10 Mar 2025 11:30:10 +0800
Message-ID: <cd9867878907b588f3525dc45380955f9fa43e76.1741577149.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741577149.git.tanggeliang@kylinos.cn>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to customize mptcp's own sock lock and release functions,
sk_lock_sock() and sk_release_sock() function pointers are added to
struct sock, and these pointers are called in BPF Cgroup getsockopt
and setsockopt.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/sock.h   |  2 ++
 kernel/bpf/cgroup.c  |  8 ++++----
 net/mptcp/protocol.c | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..4341c58e351e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -540,6 +540,8 @@ struct sock {
 	int			(*sk_backlog_rcv)(struct sock *sk,
 						  struct sk_buff *skb);
 	void                    (*sk_destruct)(struct sock *sk);
+	void                    (*sk_lock_sock)(struct sock *sk);
+	void                    (*sk_release_sock)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..a105e9e5b9c8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1843,10 +1843,10 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		goto out;
 	}
 
-	lock_sock(sk);
+	sk->sk_lock_sock ? sk->sk_lock_sock(sk) : lock_sock(sk);
 	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_SETSOCKOPT,
 				    &ctx, bpf_prog_run, 0, NULL);
-	release_sock(sk);
+	sk->sk_release_sock ? sk->sk_release_sock(sk) : release_sock(sk);
 
 	if (ret)
 		goto out;
@@ -1952,10 +1952,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		}
 	}
 
-	lock_sock(sk);
+	sk->sk_lock_sock ? sk->sk_lock_sock(sk) : lock_sock(sk);
 	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_GETSOCKOPT,
 				    &ctx, bpf_prog_run, retval, NULL);
-	release_sock(sk);
+	sk->sk_release_sock ? sk->sk_release_sock(sk) : release_sock(sk);
 
 	if (ret < 0)
 		goto out;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d98e48ce8cd8..29c3ee2fb4cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2712,6 +2712,18 @@ static void mptcp_worker(struct work_struct *work)
 	sock_put(sk);
 }
 
+static void mptcp_sk_lock_sock(struct sock *sk)
+{
+	lock_sock(sk);
+	mptcp_set_bpf_iter_task(mptcp_sk(sk));
+}
+
+static void mptcp_sk_release_sock(struct sock *sk)
+{
+	mptcp_clear_bpf_iter_task(mptcp_sk(sk));
+	release_sock(sk);
+}
+
 static void __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2741,6 +2753,9 @@ static void __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
+
+	sk->sk_lock_sock = mptcp_sk_lock_sock;
+	sk->sk_release_sock = mptcp_sk_release_sock;
 }
 
 static void mptcp_ca_reset(struct sock *sk)
-- 
2.43.0

