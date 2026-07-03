Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813C30676C
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097861; cv=pass; b=rbQ3DFX4Nm6I5UTv62WftbdLS2P5gPag9CaBx/rbLD99lTZP+6ZBm04fnanbOOAXBFRUDaBrkc5pFmZW33eDUu0M65ChJwCpe1q2r+Suc00lVy7gqoYI4lxhDaBmBNDw0+sDb5289sbvx7AlVAbV9lpo1ggr/Gi3+gKtYTjBowc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097861; c=relaxed/simple;
	bh=XuqcazP8+8FDqXMByHdO7ztJJVq/eyaMt1v0Y89fTg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSXhkurM3GWFv0TGxocdgwHzcvNGZ/gQD9oCqbSU5eA+xxQMdmDbPc0hxwmgmlhBLPmZIEFj8H2JmiDbPzmHcu/mnipXbcyLMz5uSEb1MgRrHTnbBv41PrWSdh0mNJ6Wter7b+Ik17t0J3AYKCw4tTZEXodUiRj1W7ixFzqsnEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=LkIN4QSS reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="LkIN4QSS"
ARC-Seal: i=1; a=rsa-sha256; t=1783097849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LRNJFWeBFTCiQ5K5u2NqPG4avgzzFK4dR1iOD90FakSGj1QyzilDqaw9antGdgoN2vnJ61WzU4udBFp3UCYzUzLDIzGJtk+nXs9nfA7K1tlDG4XPBUXi9so7Hbi+JN5F2IGQkbWneEHu+UZl4dTmvXGpvnPt6XSXqK9ynsrjhJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T5NEEPyFFIc9t8KgWhQPC75QblX0ePkupywQO2Uenm8=; 
	b=U/pH5d807sAdTGF3s1cB7uHhjWliMsua46UMC9O0RvYQbUc8y7Ck4xSfgJYTRqiPfxRY+6gf/8XQrPOM+aJ+umD4FJ8aQoanCQir8PkI2GWyRuRHKBjcJm3ywgXrgbPdqWaz8cGOL0CvwWfnbvA8gv5vPK9QTHHIFqH4w5CdWzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097849;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=T5NEEPyFFIc9t8KgWhQPC75QblX0ePkupywQO2Uenm8=;
	b=LkIN4QSShe6K8E9cYFWcy0hi+CuwIAOlurmE3+BEFEiaPvLf+pgz18LTwm3jIQO2
	ibEjfBCijq5ZeEWIPfOK6OziUA5XW1bkFswaTsjUycyWCHDMdFPoQHDgZDMYhDF8ZW1
	lPeiWM9dEBYq3Hh4MMibH+3pLd6rz7SU9SSI7nck=
Received: by mx.zohomail.com with SMTPS id 1783097846010703.9697947227534;
	Fri, 3 Jul 2026 09:57:26 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 03 Jul 2026 22:27:09 +0530
Subject: [PATCH mptcp-next v2 1/5] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-1-87ae3c64dc7e@mpiricsoftware.com>
References: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_set_timeout() is exposed to BPF MPTCP packet schedulers as a kfunc
taking a generic "struct sock *". The verifier only checks that the
argument is a trusted struct sock; it cannot distinguish an MPTCP-level
socket (msk) from a subflow's TCP socket. A scheduler get_send() program
can therefore pass a subflow socket (e.g. msk->first, or the result of
bpf_mptcp_subflow_tcp_sock()), which mptcp_set_timeout() upcasts via
mptcp_sk() and iterates as msk->conn_list. On a subflow socket those
bytes are live TCP state, so the walk yields a wild mptcp_subflow_context
and the subsequent subflow->tcp_sock dereference faults (GPF / KASAN
user-memory-access).

Narrow the kfunc-facing type: register a bpf_mptcp_set_timeout() wrapper
taking "struct mptcp_sock *" instead of the raw mptcp_set_timeout()
symbol, so the verifier's BTF-id check rejects a non-msk socket at
program load time. A scheduler that passes its msk is unaffected. The
in-tree burst scheduler selftest is updated to the wrapper name in a
separate squash-to.

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782).

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0845061ddc65c..9355fb53e89d5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -301,6 +301,11 @@ bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow)
 	return false;
 }
 
+__bpf_kfunc static void bpf_mptcp_set_timeout(struct mptcp_sock *msk)
+{
+	mptcp_set_timeout((struct sock *)msk);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
@@ -319,7 +324,7 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
-BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)

-- 
2.34.1

