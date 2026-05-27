Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D62287510
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842237; cv=none; b=oSzaZGlsYYUjkS2sihq7dBiUc7T4ZeEFPwmxXOaYssnYN3LCPePx7YVvtq8E7I7eucXcE8b4UWNUf2bkhh43UylhuuGTBp5ibDnmJb/gW5bpdEERHtthvQ+cQInZXpV4wcLLHIxQqAowXHh+Mm5+ePeaPxHfamtZo8ky6KHI8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842237; c=relaxed/simple;
	bh=k3f2/w/6n4kzZNFUrO0USgctX/qsE/dy2fDYIFfe+lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=UyrC4he2FM7qG95MC42ZjswZm9Rg/AW2CRBj05BV2guoGE/X4Z7RV+zGO7utRbHKRyD8BG63JCS2PludlqYmVHBjQkH7fnVCKyhsYyL2EIIAOd2eikV2XppDfdV6JNRy0uvqVTSuW5QBL/aoGS+ixNPII3D8H5FdVHg7rRs9TcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcC+TPIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcC+TPIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C00D1F000E9;
	Wed, 27 May 2026 00:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842231;
	bh=f2Y/RowbBlUCDuSm19D2DYVUO8jqG4cQyCl1YM3KRLY=;
	h=From:Date:Subject:To;
	b=UcC+TPIiKYAZC9YJx/BD7J7YuOv+wziMJI4t33PBhfq05moi8e7zpNAhEpNH+9B1F
	 TI0s4gm5v2pUifZfGWT8y0MmC4LxfoW9uxuyC4Z38mJSmRjCAooAzO137QH6rl1oMG
	 c5mLQicqH4DfbgfcDvIYRDHCEGjCLpACLyZSaaX9E4PrkB2vCgxmACytULatY1pDRr
	 hixc/NbVl0gXzAtIQ7oGjhfJzw8niE899xdcqjcpV3AFS+nnE0VD5d3tql25ToI2ft
	 xup74y2W72P24KIKULmwangr3hMyCZSCfSWj1K4aBI7RFXvOpVe6v/Luizb0AUlKWP
	 uvVF/cLWeFDug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 27 May 2026 10:37:02 +1000
Subject: [PATCH mptcp-net] mptcp: sockopt: check timestamping ret value
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywoCMQxFf2XI2kAtPtBfERedmo5R2oYmijDMv
 1ud5eE+zgxKjUnhPMzQ6M3KtXTYbgaI91AmQr51Bu/8we39EbNYFNQan1UMjTOphSxcJmxkSL1
 4GpNLfhegn0ijxJ+/4ALrtpDBdY30NT4o2k8Ay/IFmpLrY40AAAA=
X-Change-ID: 20260527-mptcp-sockopt-timestamping-ret-e2029bf0f24a
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 MPTCP Linux <mptcp@lists.linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k3f2/w/6n4kzZNFUrO0USgctX/qsE/dy2fDYIFfe+lA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFjy1kGC6P1CtDb/OS9tCGm+VmBF6jNJvd5QYV
 v2VmZg/1T+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahY8tQAKCRD2t4JPQmmg
 c4xXD/49kSKbcVNmdNpU+52gURjTJHXPDWmyBGCj0TxykVdanDAs3goY0mRay63cX7dgggc/lZq
 cvEoxV7eUrpysrJCoj6wbEfdbJX/VbFcE0FhEYD0aRwBYU2YXH7ZfdZk0ElkZMAG73cxgRH2sKY
 NsxIEGYBhbtnjCAuZgmIBmq3wyNEWq1xWfsi3cIy2FP6emMv82CUrslAQEqYQRWjn1IvZD3RQ2L
 IcgzZ9uKAekFp6uh/bl6+vwhgRDnk1PuD4oEm+PmmJwINz3qf6NH/D0w1eKcqWuXt6+WC5uujPo
 ZRz7iMloYo9V++Vrd200QdVcROc5kB4iD80oJJBtxGOZbKRb6Nt+iG9E/NCrw5JCgp5mPIViYSH
 tM3dmhcjJJCYCjrs/cxnpkJoewPDmWzIAR3yZ13brdjlZw3wPHLYtrwr3UHiW6wG18afBseJ5rb
 0ntM0Hk7/FtpzGVOau5Dr6p93+MOGJdIaIvgnf0V6AtFG397FQK3SibjUZcK29DyWJv2HNi0Zwt
 mzPbey6UOYMEDT6MMAOOLqVG7dlEYtRC6FqOtykb8yx2J745vmqInt0Q37jBiHo91ZHJsljat8J
 N1Hlol60T+SAz2596M0/zPXUtVMZMIRZuXx9zfA4OY5Z5tKUMKQcR95r4zUW0Krq9g4MgV+U+NY
 RrB5U8PRXSMVHag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sock_set_timestamping() can fail for different reasons. The returned
value should then be checked.

If sock_set_timestamping() fails for at least one subflow, the first
error is now reported to the userspace, similar to what is done with
other socket options.

Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Closes: https://lore.kernel.org/willemdebruijn.kernel.178a41a53d041@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..91aa57f1d0fd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -241,15 +241,19 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
 
 		lock_sock(ssk);
-		sock_set_timestamping(ssk, optname, timestamping);
+		err = sock_set_timestamping(ssk, optname, timestamping);
 		release_sock(ssk);
+
+		if (err < 0 && ret == 0)
+			ret = err;
 	}
 
 	release_sock(sk);
 
-	return 0;
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,

---
base-commit: 599cb099e01efc713c7c120654ebd9fb49ac2782
change-id: 20260527-mptcp-sockopt-timestamping-ret-e2029bf0f24a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

