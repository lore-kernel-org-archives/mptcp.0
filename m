Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557698;
	b=jHfUCNfzoMSZMQ7a+2XKjfhPSVZoSAf+E1i9/92kdC/45CduRmZdtLvvcRWCwqNWXi86
	 uv2IhHH85Yzz3s6FDmPlZoPsODJsJjcKH8SYvQXAAJd7XHo+jK8B8twqy0JzGVjpZZ62F
	 j7synGmZmlaV+nPFIOVE6mLE8qODRV4tVLOc+rh8mmynJ/z9F4agieC2wo2ijXb0UULDN
	 OT52Zp4f4uNVu3B5jSrf8TvkbG6rERetGuA0C3tf3s77qk/k//QJDXvGfy/ll3dZdiw4Q
	 5tapEy2neqiKhL/AgFF7tV6jFOJVeCV6ISfep6PhSrVGT+5LlGwsLUGwDT47z+38vlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557698;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tqIiU8oA3Ea6GzOf3YO9Deukk0xTiDwg/VILq8hG/NQ=;
	b=DZiR4y7RtkKf7BuYCqnmjt9GM8RDO0tZZM5lMMJ/4B5lhZCKdmHbRb6Km1dunyzBTFYH
	 qPsbRtHakuFRUpnDAhm/6iW0TM1zayHDm1+DtaiYbwT9BFZPLM4V01H/PV1cAIDk9aphr
	 GLuYuZs8q4tlkGR39OPmPP6LmEQqeF3NGHrLxrhEuge2BFbz2DuV1KrILq7v5Hxmc+sci
	 /qgjg2v5gY0f3+evs9fa1Zx0hcXXzuPBGxG/EcBSON2z2hSpNGFL/YOcwu/XS5EyCTBJu
	 FLQXsTzZECJUOwKZ7EK3YMC7GBXvsImAJWH8VchdmSdPi18Ci1zZw0Eq+hiZ3bQbDXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3X1fbfL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895B606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3X1fbfL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3281F000C0;
	Tue, 24 Nov 2026 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557698;
	bh=tqIiU8oA3Ea6GzOf3YO9Deukk0xTiDwg/VILq8hG/NQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D3X1fbfLsIBGw7lHnxOBg4BjcTrXVh4zuP7BppHhNGTndFR2ZhIHG3z57zLwF5+Fw
	 ZQ8faAc00MEQ5XL40eCukMOdQf9u5JWDylNHsVqIykyWRTX5dqC7f9VCd7IojNaBFO
	 WEJk27WMF/bECXNPO6HvdOcgHebfgFu0QtSM+cgjmaSM+XhCN7nIdzt5qeWYOUsLVx
	 P88WL+VLoyklo3Q7LsEqHP/zbVrPmhkx16eeX+5jkU0nk46P6qT8pugq/TKxOPZPuk
	 07hL/ad2cky4IkIqAnQByxY8FOAm9lRcdOSQ33hzop/rDqtCBDVg5pF/cZeusjIbCm
	 AVU5O04dYYokA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:50 +0100
Subject: [PATCH mptcp-net v3 33/50] mptcp: don't charge a shared page twice
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-33-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3M+uO3msi9DlDnR0ux8zXB1gpWarWZ39JrK6SLoroH8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOLktOk494b0935zNYYqxDXubskFQ6uc683XVtmynn
 x56lq7UUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJG7kYwMH/L/d7SpT82afuFL
 3J83ky6xXM16bqtjYvOr/c9kuWd74hkZ5on/0hZZ2xLxWlv1h9Tle+sbPd6tKrOdoy2j8P/csaJ
 6fgA=
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
Note (Clashiko on v2): the backlog can still be charged twice here: this
is fixed by the next patch.
---
 net/mptcp/protocol.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8cb585da0b3..504fe4a9954f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4664,10 +4664,26 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
@@ -4685,6 +4701,9 @@ static void mptcp_graft_subflows(struct sock *sk)
 		__mptcp_flush_join_list(sk, &join_list);
 	}
 
+	/* What __inet_accept() just charged for the msk, before rounding up. */
+	mem = sk->sk_forward_alloc + atomic_read(&sk->sk_rmem_alloc);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -4700,7 +4719,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);
-		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+		mem = mptcp_charge_subflow(sk, ssk, mem);
 
 unlock:
 		release_sock(ssk);

-- 
2.55.0

