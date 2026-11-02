Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637919;
	b=PxxHbtmBbet+8gE8VV0dIk9xqR/Ria0sJ4rohkHROG/BTvrSJVvoxHwUDRut9zC1SPOV
	 MwlZB9nvBSjdjI7iGC/epaTyc7HkFCWpzSqan3drAXTzOugOiVmKQtKfMRkXvBVFn9uc7
	 X4qfHN/En7h+NGXePuugQjwbA4XK9ESlguGi+G3M93fWK2WiGHRcu1DYUCGxCPu/ktPO9
	 lls0bf6UIn8c/Py4ZNoZ4dh1xk56F93n+Gns+ujdUSe2jTnXlmQpXtf0S8AqF89DR03pz
	 5hR/FU4viYsAlW5bUZRLqsjYwak88mzot2XZCBpLXLB6MnDKfC5xAWrdmBX0vc3Oalg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637919;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T/sOVNzi5Dfoa2OxIv/A39rx3iPvBk+pen4rP9vKfWU=;
	b=JuoWA106bkyFxN7ZnVhWL8eUu3dM0cFgZvmjmK2JGoN0RaksAKW7lPoGOxV8UrOS+9hF
	 DsS3en7Mcte7bmk9Oztxh6W8eRO0XXruakzSWLg/G0m9DslH/FFMxaq5qTQ8ZC/AFyk5E
	 ffS0EOgD24XukDg/LfFzDm0+0ITZZxLbO9GT/7j9q72fBSvZcrflqGKPvjeA9Zrio0rni
	 wYfjnJZmG79yM2UbLl/jcD5mu23zfp2e5qhPzzHrE7IWDoNtaJMzy+NG95HKGXVCQe5cN
	 +REFAvfOQa3s+iLOcNCHQxc41MCnXjV+bhzxIfnCL3ZB4lc0LtSdcsK83Tp16sSvpHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWi4pziV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7360A8841
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWi4pziV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A851F00A17;
	Mon,  2 Nov 2026 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637918;
	bh=T/sOVNzi5Dfoa2OxIv/A39rx3iPvBk+pen4rP9vKfWU=;
	h=From:Date:Subject:To:Cc;
	b=UWi4pziVLtXe/LXPT8Xci4UNGkV8u7u7aFVUKXHTijzmEzzCW2rl8Fc9OiWyoGnHc
	 Sp5xy2Hq4IW6UED+yGciPQ5/390ovM9nBm33LtnwTARHI/548qCHOyGXYmmo2k/Kxj
	 QMKCU0k7nJBztfFVmPAAxgFjS7zAf5MZF2G39ckNXVPGRRzLhvrTIrVGyjkq/5po9h
	 avmWkoZ+gyZbUPAuoGJKzNik+BgAf0ZFKLcCkUu56IUvWb73zAhhBICFhNg2TSHuW8
	 /TdWcuOq5sEAkCPWSwjqf+L/m2CJgVR6kHBdfyPPnhG9aKay3kM8LZ1RKR4oKQSO5f
	 NkCT74NcZllaQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Nov 2026 17:45:10 +0100
Subject: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
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
Message-Id: <20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTaw1jnBVxEv1jbVKNaQRhmMv
 bvVXf4czrdAJWWqcOoWUPpw5Vdp4XYdxNtUroScWoPv/ehc7/EpFgWDZHxkZCNFJUMuiQRdPAw
 pHNOwHwM0QZQyz3/9DNux0Gxw2bb6DneK9uNhXb8bcGmEiwAAAA==
X-Change-ID: 20261102-mptcp-bpf-kf-iter-ret-indep-1c54db7d436b
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Sc5BfbdoKeLv5hK/JLVZK73WTZN7aPD/+PWJB07bBcg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJe7JNlPN1hO9894PDVexuP9vxMV/BJ+ORx17qzPaV9+
 8V1rUX7OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbybzPD/6KU2t7Djm+nrqpv
 1p/DJPeOfaHQ6+ZmMU/r1ZsrVu3b/oHhf9CFb2ePu2SxhC9okm5+9/XIZ4Hts+foVJnKx6fYTVV
 awwUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since commit d09c2aa3109f ("bpf: Track borrowed iterator results by
default"), the verifier ties a struct pointer returned by an iterator's
next kfunc to the current element by default: it is invalidated by the
following "next" call, and by "destroy".

That breaks the MPTCP BPF schedulers tests, keeping a subflow after
advancing the iterator: bpf_rr keeps the first subflow, and bpf_burst
keeps the "best" ones to use them after the loop. Both are now rejected
at load time:

  R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_
  (...)
  # test_rr:FAIL:open_and_load: rr unexpected error: -13

The returned subflow is not tied to the iterator position: next only
walks msk->conn_list, destroy is empty, and no per-element protection
is dropped. In fact, the subflow is still valid thanks to the held msk
lock. Then declare it with KF_ITER_RET_INDEPENDENT.

Link: https://lore.kernel.org/20261024100647.2579244-2-xyx2021@mail.ustc.edu.cn
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 53111d7a9eee..74648ca1e99b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -298,7 +298,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next,
+	     KF_ITER_NEXT | KF_RET_NULL | KF_ITER_RET_INDEPENDENT)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(bpf_mptcp_iter_kfunc_ids)
 

---
base-commit: 2a3ce18c1f6d771195394b1d564947524ce774ad
change-id: 20261102-mptcp-bpf-kf-iter-ret-indep-1c54db7d436b

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

