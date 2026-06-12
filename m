Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E83D75BC
	for <mptcp@lists.linux.dev>; Fri, 12 Jun 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249219; cv=pass; b=DLSJL+K8TxAxOZYn1dgA4NFC6d5jUGpqw1cJMI1s4eoCr5gN3SR3iyo5K0Nkq3qZ8a+kuejDOtI4P871TsocdHwrGZg/MXDAzf71Q0VzqYMA78/LpERvUhtiTv+P/hapt6TdeUky/4N1Z9jAJtw4Cu4I6LhjCfgB1fFN6EmKZ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249219; c=relaxed/simple;
	bh=IEesS/sQrr1myuvbbtBRDv4pVhaHVSnCkYns0U66VOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLLTci4MAIX9ujrFb4ivuJNcnFVNVeV2t1Th2sdG9v6qjG+mlu5mUdzwlH+MrlewnJ9Ca59wqKrkEdnq30cq40uNdQphniCfwNEYAuVQvJWqch9/1gWIdtUAxgpBNHd1X4hNQv6rML2I1kKDjSxa+ukqP4zHslXptuZDYsrdN+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=tzWRBhJR reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="tzWRBhJR"
ARC-Seal: i=1; a=rsa-sha256; t=1781249213; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FYIQvq9fGpUy944McJNSQuRbtAhS6LfwIUeEE/xzCz3b4JdxS8jNWxDe+YE/AkAEsPaJVV6o3PjJMdNaB5ChxyDpLOqI9NQcPx+LV5JEqkIJY+yi8ccOT7T3VNcD2rzmqjUzIi7coIiAf679GcBq8ThFBkqL15Kzj0COIlj2jxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781249213; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z2WBeKNcGM0bbLT1X0FMBWVf+Ku6Dky3a8b2K5wIV2A=; 
	b=BZitOrTGiSoD1zpf6qiiXSuw77zAJ6U5lCdPX2j8repiZ4odUOp2H/46T96znyIvQiqtlMvqPGqKVILC1ZJ8q5+swDiu5J6bbR2QJpJfN5VRKVmHdT0XWiXC/RBlPvt17Gyq4H8L0PaURJ5dWzUiUY77SxBmQRZLywYdrvXJxmU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781249213;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z2WBeKNcGM0bbLT1X0FMBWVf+Ku6Dky3a8b2K5wIV2A=;
	b=tzWRBhJRD5N1iBU67rmElQGaVcXVAIwBZSq8WxPc0X6SK3STm2OGT4suUHJiu+5S
	Vm3maY+8IkeVNUHLYRvmOz22KPJfwbpNsv8QIeyO5Yc5iFelucCKJkw76wUYBOrixnM
	QmeL7VsYecoVVRk4tbHIhch24n/To+WY/leVbhTI=
Received: by mx.zohomail.com with SMTPS id 178124921175738.76880767523619;
	Fri, 12 Jun 2026 00:26:51 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next] mptcp: bpf: fix NULL derefs in bpf_mptcp_sock_from_subflow()
Date: Fri, 12 Jun 2026 12:56:43 +0530
Message-ID: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs via
bpf_skc_to_mptcp_sock() on an arbitrary socket, without the socket lock
held. It assumes sk_is_mptcp(sk) implies a valid subflow context whose
->conn points to a parent mptcp_sock. That invariant does not hold in
two lifecycle windows:

- Fallback: subflow_ulp_fallback() clears icsk_ulp_data before clearing
  tcp_sk(sk)->is_mptcp, so a concurrent reader can observe is_mptcp == 1
  with a NULL context, dereferencing NULL via mptcp_subflow_ctx(sk)->conn.

- Init: subflow_ulp_init() sets is_mptcp = 1 while ctx->conn is still
  NULL. As mptcp_sk() is a container_of() on a non-zero offset member,
  mptcp_sk(NULL) yields a non-NULL bogus pointer that passes the verifier
  NULL check (RET_PTR_TO_BTF_ID_OR_NULL); on CONFIG_DEBUG_NET the
  mptcp_sk() WARN_ON dereferences it directly.

Load the context once and reject a NULL context or NULL ->conn before
casting.

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/bpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 08bb037f0951..f40905fbe7d4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,8 +193,13 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
-		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+	struct mptcp_subflow_context *ctx;
+
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
+		ctx = mptcp_subflow_ctx(sk);
+		if (ctx && ctx->conn)
+			return mptcp_sk(ctx->conn);
+	}
 
 	return NULL;
 }
-- 
2.43.0

