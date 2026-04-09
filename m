Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442F86329
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767937; cv=none; b=XNv24csoB6Ytzo2kKy90JhVmg+qvXqy8tfKvz3/VqENrwBQ+EaRCzXh5O3FedzqV1L7VO2Cmas0i1SFP9fI8muCkMkkNmQkQC+SGbDPQL8giOMuSfRbQv/yBYUczKbOgwod9izayqdyVFcWGLkjZebfzrdbse8ZR3J2TtN7Y9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767937; c=relaxed/simple;
	bh=0wHmk6A4DRGr56r/kPjXDjlut04j2hg65yYWe+lbaFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebZnH14Azv6zCcEypZpkjLg7RX/4StB9jANztPDXEKyglm6Y4G7YFfXHys2xCE295kFxHXAbAI7yCIhOu4g34GJMnhcImPOqHlgmUfAEiII6qWK+QBRNgy9Z62QrvNWHsZfKV0DEEBWX7hBEndjmABibY6WrmrM7erEtHAQf/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loJKg2nv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loJKg2nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D538C2BC87;
	Thu,  9 Apr 2026 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767937;
	bh=0wHmk6A4DRGr56r/kPjXDjlut04j2hg65yYWe+lbaFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loJKg2nvy+x/PFXvZxr3MoXYEjquX31kvrGAocNyRFHEWGfNJxRTpdeOh2S6eu6K4
	 BpVek3/KcVxkvPsgB/j8F7TlUnr+Ka6D58BPVo33lbPk+NpmGTcJ2Jg2ELKyUCZDVz
	 jcNX9/9VXQfrBCMMou54NKuX2K9sPH4Z+niQ8c7rVhsb+M6WtFN/Gtz8hlCcJd2M3I
	 gkTjoZVs8pMTXoXAz6iC91a8FhEDz4OCbI77iZ6zKz3dU29BVHDnwEQH5TZX2+e9Hb
	 iDsA0z5xMyxwwQamCmY0itDiXXELRLyokFhXrl4LQB6fB2m7AeyBRV/CtlxZUQx7gR
	 NboDUvgEgfJMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:46 +0200
Subject: [PATCH mptcp-next 06/16] mptcp: pm: retrans ADD_ADDR: return early
 if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-6-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0wHmk6A4DRGr56r/kPjXDjlut04j2hg65yYWe+lbaFw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCBZ/dlpb2PiUIWPFl5WbXHe5T9vZK5i+edYF2wkq8
 /dzKR6P7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIfg4jwwWTR45S8UkWl6Nb
 noqxCH38oZx1pyFL6O/LH/fnrjt4/CsjQ/OyvZ5citx/9TNuGZsl73ngWPlwd7g1k2KQcNKeRIe
 1bAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e954dc46e6bc..beb06213585a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -307,6 +307,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

