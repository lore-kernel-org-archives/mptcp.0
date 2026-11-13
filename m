Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599696;
	b=kg9pBiZQX04sLc9balYRSlrscLEF1QVNZT00T/yvavYV1nLXICqKQL4RYJghRyYrpR2c
	 n4uQKxl/TruidTK4PlaB00qdiOFhe6ssRIBveaCAsVTKkeAWoY1wBKWDLGsyKcg1lJmhU
	 TAFwVas87RWSmALMeJW54x/OkHH1TE/JjbDkJtUdmgBwLQY7/bhy4pLXHhT9qcko0mEe6
	 x223v765bXx5LL2hK3r71O3pANep1Cb3vfZODlgUEwpcZfhFWtlG6h0P1TVuMv8hM+3sZ
	 SS5vgtE0g7LNoxo8nzlSrA0mm7TRKaJcUdRUzhLFH6ahRCrlpu7BSre+hCWU+qpYUwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599696;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aQibswpO8WW2LKhoV6ATHchq0rYOGobJeP1nIzxnlag=;
	b=HUnCPea6Hv3/ri6Rj3XO8kfUYx6juJ8eLnB53ZobwkF9LQi9fS0yB189ICjejDq3cdui
	 rHKpjYRB7/be/sH95Ehn46fZQkwzM2kMwOe32DWWJnD0lENRCyL8tc60T4xTF/oEqAIY1
	 386yL3AeKF7VyrYkiUInPER9it6QmS5zMAPAcXLrCILWjtEO76uqkQl7bnwdvFM0X3Ogr
	 5K3Yy1psJ2M4Hsl3fSr55cEHXLFfUxcb15MJNd1b3Vp5K/5q+oRbEqXYsipNnhCfVUgZD
	 dC2uOu2qnNlQAAuDrjh5S3PGIPURi002cwZq8AG1paOaOGc1nlqGBo/5Ri+k6WwNkTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQd1mKhv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B760A381A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQd1mKhv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BD91F000C6;
	Fri, 13 Nov 2026 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599696;
	bh=aQibswpO8WW2LKhoV6ATHchq0rYOGobJeP1nIzxnlag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gQd1mKhvw1GKaoEK7zdXWS3F2Lz1ajv5rTmhClavWrnJvAPgO5o/gDti1MkBD9Fha
	 nQ9VnU/ZAKVyfYoAzj0vVHc2EyRRNqiwFFKY0bh/4pN3z8aA0HEmkR3IZkypz2oevy
	 A0ihcicyZHnjcVDp+qhhu2V2jdqsauIoxYROXZbcqyH8tD90hERK/POfRWtcQ5PdY7
	 V9NuIOI4/P8RDGwG42YlTizJ8Rqh8st6JCmAyLR0bf047dlRG8MJAQvoeUTWuwHUXF
	 rn8QqPL9hSt6YLU6+T/c9CG+z3g4RBl8RY6MzqPtyGn59Jwl1UECXkW79kZLciMuBf
	 T2ofhlSo3vFzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:07 +0100
Subject: [PATCH mptcp-net 29/34] mptcp: don't charge a shared page twice at
 accept()
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mptcp-cmason-fixes-v1-29-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eYeiRS4brNkKxqTuSg5JfeOJF+43Io2WIr6z/uJjj+o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz2fs2BV+8VZB7/+WVnicrvh+9PFSyJdniSqVVnJ/
 +4vuFub31HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRwM2MDKdNY/dyv3lsYa/m
 f/H9OpmiK2XKX5TW/+97/t62kdth81+GvyJVq27mP7z54V1p0I3VE/8/WXGke+6HI0rc4jxNU2+
 t+MIJAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

accept() of an MPTCP connection that has already received data can leak
one page of memory cgroup charge, and the leaked charges can get the
server OOM killed.

At accept(), __inet_accept() charges the MPTCP socket (msk) for the
memory that it holds, rounded up to whole pages, and
mptcp_graft_subflows() does the same for each subflow. A page is
uncharged only once, when the socket that holds it releases it, so
rounding up each socket on its own is only correct while each page
belongs to one socket. But for each skb that the msk takes over from a
subflow, it borrows skb->truesize bytes from the pages that the subflow
reserved, so the two can share a page:

    reserved by the subflow      4096 bytes  1 page
      now held by the msk         896 bytes  charged for 1 page
      still held by the subflow  3200 bytes  charged for 1 page

The fix used here is to keep a running sum of what the msk and its
subflows hold, and to let the new mptcp_charge_subflow() charge each
subflow only for the pages that it adds to the rounded-up sum.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
an MPTCP server in a memory cgroup, the first byte of the client
arriving before accept(). Without this patch, 4096 bytes stayed charged
to the memory cgroup for each connection, after its end:

  SNAP label=after-1000 rounds=1000 sockets_left_in_srv=0 [...] c_sock=4096000 [...]
  SNAP label=after-5000 rounds=5000 sockets_left_in_srv=0 [...] c_sock=20480000 [...]

With a memory limit, the original version of this patch reported that
the server was killed by the OOM killer after about 14,400 connections.

Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0758b048316e..dd441e5aa435 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4465,10 +4465,26 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	return err;
 }
 
+/* The msk and its subflows share pages: charge their rounded-up sum */
+static int mptcp_charge_subflow(struct sock *sk, struct sock *ssk, int mem)
+{
+	int new_mem = mem + ssk->sk_forward_alloc +
+		      atomic_read(&ssk->sk_rmem_alloc);
+	int amt = sk_mem_pages(new_mem) - sk_mem_pages(mem);
+	gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+	mem_cgroup_sk_inherit(sk, ssk);
+	if (amt > 0)
+		mem_cgroup_sk_charge(ssk, amt, gfp);
+	kmem_cache_charge(ssk, gfp);
+	return new_mem;
+}
+
 static void mptcp_graft_subflows(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	int mem;
 
 	if (mem_cgroup_sockets_enabled) {
 		LIST_HEAD(join_list);
@@ -4486,6 +4502,9 @@ static void mptcp_graft_subflows(struct sock *sk)
 		__mptcp_flush_join_list(sk, &join_list);
 	}
 
+	/* What __inet_accept() just charged for the msk, before rounding up. */
+	mem = sk->sk_forward_alloc + atomic_read(&sk->sk_rmem_alloc);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -4501,7 +4520,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);
-		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+		mem = mptcp_charge_subflow(sk, ssk, mem);
 
 unlock:
 		release_sock(ssk);

-- 
2.55.0

