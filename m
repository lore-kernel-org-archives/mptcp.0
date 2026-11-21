Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254180;
	b=lFD5PTDCBKLP6knBJ+I9fUpO+B6bGD+gUf4hrWixvaixcPJGVE5pN3BSBCkwQBpcye+z
	 mU6ELUYMUHGpmIG1I9y9TNlkcyb7zZQEn7cbQVXdw0lvCpVHF8XIOsirU7qtZCap/lQfh
	 ossKnzg0suO2A04xEUzN2UHLuXCoTAOrE7yZGdu0LfuVO0PydDZ6r2N1w5kNV/UlP3OGE
	 NMtUJ7cj32bSXMz/ip7tq0vmnXVfRV5w18pEsA3N6PF9HBAQn+TBX4+lLMIiL2zkvxHwk
	 S494ODP4YUUCHmZZMWibQGW6COpI5NklEqkTEbi0+J7EiVWvuvVzKr//Chi68X2/AaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254180;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7/HssDqYXm1u1Wsa6uTcQ5R6aXEkIN38D1UHL5H30uc=;
	b=ye7Swu1Zs8ch0SeDspaHHECE6U1wpbrMQHHQ6DL5VW2/1T593PvvMesP70vKr4bkFBx0
	 I48lXW+NfY0MDyicrv8SewurTuYBjUgbXk58CKRD9ihX7ZGehG9Wz7+ATcZ6bSZmdKu3D
	 /hoFVQIMFRp40fW4QwK4ppuZq5Js9Bq/0jAAS9kS/w878NVRAH7E4sGr3ZhUMCc8jxTOI
	 yRC4QCbW9LTjKAs47WX420zGebukIUOWsw53QMD6u04jdmo/NYmtWyGdzlJmnJBj6rYk7
	 dODAgEb+tmgrZ1xHUNJIMREWdJ6sg8SEmRPcYW1Ato3ULScp6E9hvME6kkzUV8oEowQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fB7nx8sO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA902606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fB7nx8sO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC381F000D2;
	Sat, 21 Nov 2026 09:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254180;
	bh=7/HssDqYXm1u1Wsa6uTcQ5R6aXEkIN38D1UHL5H30uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fB7nx8sOFFkbiUzSFFRnzFImG+fFhYse/JX/24JaXLiiK8nH9MH+sP/7TGagZgmd+
	 zZn+8L18hEmKYzts89JxnUZIgOfGDvkVgBeaEuP3+ehKtIxchmOwtuVR2j8V/BHHJF
	 wEMHRZZDkkYzNebD8VDxUOgPQ7H7oZJeRlyg4Iaqsej633BC3bR/bsJEEPQymYR3VE
	 ZNS0JgNKJmaRVztnhu6I0dnf4X0TmYF/9YWbN6b7cG/oIvrv5w07KMUyY0XaIPek0n
	 WXPi7ilPAuCaYaiz/TKv6tPDQ6CqGpvJA+E8F/A270OSrT/vuWkjBaObFo1n/wbeBz
	 bwdIqJSJ5R7Gg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:45 +0100
Subject: [PATCH mptcp-net v2 47/62] mptcp: don't charge a shared page twice
 at accept()
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-47-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h52eSB0F+fnjFpvY/1FtzqfP4n1qIZI8hKG4iYA7i2w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ03PYmG5O/PbMq8Glp/k02yRv45c3Hpy/vDva22dzB
 J9PrfyDjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkkTWT4yTj9V5jhhxXPVotE
 xh25dmLmhxN99vKnxM6vddUXfSyzppeR4WtOlCLXvw2ljXyfshwufr6/TzZdw5LnMIuN+/cXWU6
 /WAA=
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
index adae675227df..8749ba146363 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4636,10 +4636,26 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
@@ -4657,6 +4673,9 @@ static void mptcp_graft_subflows(struct sock *sk)
 		__mptcp_flush_join_list(sk, &join_list);
 	}
 
+	/* What __inet_accept() just charged for the msk, before rounding up. */
+	mem = sk->sk_forward_alloc + atomic_read(&sk->sk_rmem_alloc);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -4672,7 +4691,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);
-		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+		mem = mptcp_charge_subflow(sk, ssk, mem);
 
 unlock:
 		release_sock(ssk);

-- 
2.55.0

