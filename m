Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AA379C50
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384469; cv=none; b=sBSv2y574Pir4+yEkNedf8Ytu4dUkkM6NJS79CqKsqZKV7PbB1Bu8lFiralkoIl6GOP6OLWFuStnyNQpXRyNWtnqPheaODn2PhKzdQVlLL+Eo+KBbi1NTLrJ5uq5QH0jcTGcBojbfMe74M6WA1K/GroD720dMz8i3YTv+69Rgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384469; c=relaxed/simple;
	bh=ft0WEWNIdW31FWrc1lchrAnjPrs14GB6aGdIP8xdEsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHf/fFmBXqRcDZ4Ae/vTqhdXyrrAmIjGaIlzu7jzDjPaCg8fAcuD4+5YuQLRj2mv4xgW8Rqa9UkrkbDKPk9A9bVR4DU2HPMwamASPWeV4rY8Bk5zr1LxCzno2juKu60K3iFPOmo7hfN9b4wp01OEBjFSrOA8/Nwt//jkmvsNEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ9b/QC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ9b/QC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65E1F0089A;
	Tue,  2 Jun 2026 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780384465;
	bh=12wvPrAScmoLfwLdgMAryQhKqug1sq16l/U3InAGepg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VQ9b/QC92VUOjaqZPbAah+AFxiG3sMad5bzmDMCiUajtnLDxP5kHd3AkIbn/sb5R+
	 CG5+gEsrdw3dSiKCxC/ldPUF6ftX18VtkEvdBFKy9y9C6CxS5ixo/wNpUm5Eg75Pqk
	 ipN21TkuS7/y5Si9sOzK3nHwCjlnU+4rWWbHZqU4SrMoS3hVG3v8F2nlQR/0lPf5A4
	 rKH0graiOXqAEYtPqyDBCMlCWD8YrtzgIKrSEbb3rDa49F8P3/y0lcSv2JYnS38WSO
	 hW9/g2sRNUUb9AxGO5HsTljIVj3xqTmO2MxzLiDxVrjyRm7IhxSiNaDBySO31gfCZM
	 7F9PDzTJxG7vA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 17:12:38 +1000
Subject: [PATCH mptcp-net 2/2] mptcp: options: rst: drop unused skb
 parameter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mptcp-add-addr-always-drop-subopt-v1-2-4cb4b5f446c2@kernel.org>
References: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
In-Reply-To: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ft0WEWNIdW31FWrc1lchrAnjPrs14GB6aGdIP8xdEsw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHoLN2NdY+q5/WgyySNww7+ExSI0kERA8Q22/Q
 Bd8XnpyzfWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah6CzQAKCRD2t4JPQmmg
 c/PdD/4gd4flMIChKzuA/gEeBh7cy9+MASJq8po2y7PcxbVp5ZHQefUvB62F0By4BMiZwgL3kx2
 7g8uZBV8EhcYsTNRTZszXqVY8uekFvZi5HLIaj9LzPLVsvYlm7Km9pLAlMV4uQvNFMg1Ekc5m5p
 zi7kj6JpfZvd/0JgzpuRsGXhYUJg7diGoKgUjyHAEQz0N9tTxNFwNR0qweMACcoKDZwHW1nwYgQ
 sGqTd1iF80L8SmCTe2nXD714FZvm2y2eYNXIsHoMvlVAoqSKJXrcsiIdlvL+hrFlkY88NDWO7lB
 zjrgladLeedRP6OO26IdlNBcm+z8ExnJtpyIJRezn/ONfmknPyF5Ifbt5qiKOZUuP55b8sy3lZn
 Dc+CDAFgG7+0C2rZ8ev0scb+C5jRtHxpHl1h0qWyy25tuWNwUs7OqRY1je1DrG1U93Hmn25fuSj
 A4MFqB9dvuz4Hv8+3KIFgQQwQwzoScGW7OYK3QqRBJLHhbto5KbxL+AxION/OpPQ+8qdyKIat7T
 7VKidCR4BwS67uWAZkU9rckNC7LwZERrhc7YypF0xhx5X76kqYIBlfJLzBLqjuYF5+cBj6c/+jJ
 LjliPEBn/GlZFvV61MGBDhhT4aooPtxPNWnPZ39HxwvK1QSeQj3rh6WdRLgVHururyLHWaheel7
 ToWD1tL3nZA7opw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It was passed since its introduction in commit dc87efdb1a5c ("mptcp: add
mptcp reset option support"), but never used.

Simply removes it.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b0f6a60f8560..d4cbff9e1b9b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -745,7 +745,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk, int *size,
 	return true;
 }
 
-static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
+static noinline bool mptcp_established_options_rst(struct sock *sk,
 						   int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
@@ -834,7 +834,7 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			remaining -= opt_size;
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
-		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+		if (mptcp_established_options_rst(sk, &opt_size, remaining, opts)) {
 			total_size += opt_size;
 			remaining -= opt_size;
 		}

-- 
2.53.0

