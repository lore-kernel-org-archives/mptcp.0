Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B11CBA08
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005474; cv=none; b=t6QnW3FWkcWFADbsIkSO7iEaYgyVueJfXXRgFy4+SXRRf2GAZQx5wT0XhAc2PN3kX68WuGs2rzTgzkiW8V26U61rjLj4gVs1U9bdxMwxSjc6xAId3mO6zgc3xoVcyToq4aJ6zNyW8sQXYGUsLfCCHteRjKyYFQ08K6yY47eKxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005474; c=relaxed/simple;
	bh=1NgR5EJsQDbYxbvXDx5neOXQnjP+asJQwQXchDLZOvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FanFnch1liUhcPAgOXVi40jsM9TM1PyjVcsdrkSAww/KTPIw6VVBH7z+IouFKkp0FkquYgMz3wiLapn6D1Iqn7SYCK/Dva6ftbmYappbTbhr/vhSdfhmOIn11+/+cpAH/UT76CqhugP3qLiHsnR/mDvQ0+sMD03RRZdskhvfh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMK70dcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMK70dcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A2C4CEC6;
	Tue, 15 Oct 2024 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005474;
	bh=1NgR5EJsQDbYxbvXDx5neOXQnjP+asJQwQXchDLZOvc=;
	h=From:To:Cc:Subject:Date:From;
	b=gMK70dcVUYrrQ++LfCiFSB0wpg3qSq5hbjfD9tT4kYLkEBBqTitcGoLAnFZj4jcJD
	 QmMCTitQpOHclK+qR7Iv1YilBhXBP0ftiO5oVne17VpoKioz8Gjf9/gT65bZ7j25ey
	 fgYgtAPWjcjpC6GumYJ4gNb93sJydxUwxJkAeZdx577kCwObyNOzuIJCvzaFF1hF+a
	 mPf4m+BvQumIpGFhReaKEDCVIuCncZGCS7BrPzJbEjza96Qr0DP9nA51jCnXl8CPqp
	 vMudCYdcFkwrr/BSuatUVrswntnZrOZunnR26gSs6lgiis9xMgn/jL0sFXgsoX/2BI
	 8KzSlz4b3H/6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] Squash to "add mptcp_subflow bpf_iter" v9
Date: Tue, 15 Oct 2024 17:17:38 +0200
Message-ID: <20241015151737.4111686-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5059; i=matttbe@kernel.org; h=from:subject; bh=1NgR5EJsQDbYxbvXDx5neOXQnjP+asJQwQXchDLZOvc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnDoeRATk11aoK2fn2PacrJ1EH7t/A2eot5kJLd 236Xu621bqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZw6HkQAKCRD2t4JPQmmg c8rREADIJjIPlAXNv/BZ1kd8DAA6Ca1EpdpQiAJYEDko3mJNd8katJnBzwtht7eESx7YvkYWx93 x5VJUKeW0spiwjhFDNB1q0KT3bJjecT4DbSg/olm3WoipHMt3pTCFmmq6bbORqZ4GUdL3TBxwyt 9fM0E6m52gWOFNOFRBm05+Ucp3/DLWpYZXFsbzL0x4e032r4fSIldrx1pye/fmRZalA8h1AwquW LdCtrzHawPYng6qq6q0VFvrYVGSA6Wk//PpO5WLNRcUj6nYCIehSrhWn45n3Fgu5Mttsa6SLZq6 AIIpTgPZgbVDDDtTsTaFi1K0IeTsimfV5GYj6/YblMqddbZslW4joXk9G1CPse5SU+413U6dJ7K NQi0jHWygm+cYG8/8yujDp9yglmDgjmvI/qUKYCZUn/1O4TUtrGzbm1CtgjxBRQOJP41qawrJHw fTD1jBrlaM6/CIPNv4mGA+sZZ8aBXnECMtf9YhwCUOWDU0vnVRgyWzEwqBuS8SzAjVtQzo7Vzlf cyLmEYyr9stoOYThqhj/cBB3cvs2/MLSgv2czAY4isI74TcivqbmOEuGi/ryhrvjPZeF8W9RlJ1 LT5dugc/YvGXZUhBAdM5KakbjaLJvl4UQ+0T002o93zv6KSOIWKVtTG1nbkAAEyjVbCHUr/CALX u6rz7NV/6VkxgZg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The CI reported these issues with this series:

  net/mptcp/bpf.c:215:42: warning: symbol 'bpf_mptcp_subflow_ctx' was not declared. Should it be static?
  net/mptcp/bpf.c:221:25: warning: symbol 'bpf_mptcp_subflow_tcp_sock' was not declared. Should it be static?
  net/mptcp/bpf.c:227:17: warning: symbol 'bpf_iter_mptcp_subflow_new' was not declared. Should it be static?
  net/mptcp/bpf.c:242:42: warning: symbol 'bpf_iter_mptcp_subflow_next' was not declared. Should it be static?
  net/mptcp/bpf.c:254:18: warning: symbol 'bpf_iter_mptcp_subflow_destroy' was not declared. Should it be static?
  net/mptcp/bpf.c:258:31: warning: symbol 'bpf_mptcp_sock_acquire' was not declared. Should it be static?
  net/mptcp/bpf.c:267:18: warning: symbol 'bpf_mptcp_sock_release' was not declared. Should it be static?

On my side, adding static seems to be enough to fix them locally.

While at it, I also removed the export of two previous kfunc: it looks
like it is not needed to export them in protocol.h, no? If it is, then I
guess all these new kfunc should be exported too.

Tested with:

  touch net/mptcp/bpf.c
  make C=1 net/mptcp/bpf.o

@Geliang: if the CI is happy with these modifications, can you include
them in your future v10 please?

Cc: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Based-on: <cover.1728466623.git.tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 23 +++++++++++++----------
 net/mptcp/protocol.h |  3 ---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9b87eee13955..dfdad3eaedfd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -212,20 +212,21 @@ struct bpf_iter_mptcp_subflow_kern {
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc struct mptcp_subflow_context *
+__bpf_kfunc static struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
 	return mptcp_subflow_ctx(sk);
 }
 
-__bpf_kfunc struct sock *
+__bpf_kfunc static struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
 	return mptcp_subflow_tcp_sock(subflow);
 }
 
-__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-					   struct mptcp_sock *msk)
+__bpf_kfunc static int
+bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+			   struct mptcp_sock *msk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
 
@@ -239,7 +240,7 @@ __bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 	return 0;
 }
 
-__bpf_kfunc struct mptcp_subflow_context *
+__bpf_kfunc static struct mptcp_subflow_context *
 bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
@@ -251,11 +252,13 @@ bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
 	return list_entry(kit->pos, struct mptcp_subflow_context, node);
 }
 
-__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+__bpf_kfunc static void
+bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
-__bpf_kfunc struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
+__bpf_kfunc static struct mptcp_sock *
+bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
@@ -264,14 +267,14 @@ __bpf_kfunc struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 	return NULL;
 }
 
-__bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
+__bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
 }
 
-__bpf_kfunc struct mptcp_subflow_context *
+__bpf_kfunc static struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
 	if (pos >= MPTCP_SUBFLOWS_MAX)
@@ -279,7 +282,7 @@ bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int p
 	return data->contexts[pos];
 }
 
-__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
+__bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b963e68451b1..7848a1989d17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,9 +722,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.45.2

