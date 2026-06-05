Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD4192F2;
	Fri,  5 Jun 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651373; cv=none; b=qljHlZn1HJ8GzZ2FyqUgxlAjuVr6ABusuhTQVorbZzdMlMOfCwGBlGDOgfDiKSIzygQ3MCpcMJwmUX6qfndm8lCPjwdyigDpQX2zd7jO/IPG5jAE/Q+QLGpyKdzSDnvvVb0Zq8rMRpnzwyXlFmHPQW8FC2gz9xtyGfzzA4qW/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651373; c=relaxed/simple;
	bh=4Uctxgb6BoEoKhru8pzRTcw6C3iRpoqsgEBUI6ABF/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZItMWfO+SL/x3jOK+uxoGPjQI4Vx8xf5zFVR391b+hQFm/IF48vb3R4m6y6eXY1H2eq+adzPav6/Oa9TRTETjYc7uCIIHr+Y9OYNQxzDCNMOtjjL5C0vbsfqE3BfGuKS22SEA0WfMrhLGWX/0xML8hQBemWALw4iEv7hZCnr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDqHf75M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDqHf75M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5163C1F00893;
	Fri,  5 Jun 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651372;
	bh=NSGArtDVDv5PrQjEIYuKqd8VfPup2LKpt3kPHmR5lVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XDqHf75Mw7vqaIcIfQ7lcTpD6KU57W890UFsH1n4tWrTUIo1e77RCtnZN3nycxGIl
	 wtXB6QHXmugnf1/wsHL9Vd7Yzv+8JKZo/p3r8yDgJZV4fareXqQAh+qblCw74YicNR
	 FvF7CdFZUIdCgWK+lZo1vl0JjlZW/aSefY4Qy7Ic9/djk39niZawqRcDiKOtprlbZj
	 UchYSmVeUlnNuql5FNoWaO0cCtlg/QKmvdOl44tM6Y9n0iGGkoY7nKAUQM3swWhZ7Y
	 naVo4t2wXqDIL6oWWN8nzWiPmtcvU60jAzLWJM3gqXRVSJQHC9KE9zY4KxFKoZvXrM
	 ahfx4kAPBVTBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:59 +1000
Subject: [PATCH net-next v2 15/15] mptcp: options: rst: drop unused skb
 parameter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-15-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4Uctxgb6BoEoKhru8pzRTcw6C3iRpoqsgEBUI6ABF/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUyf5M2A0nZs33iZDv1y2Dea0/dAyEWCYmO/
 3wBZD3SkBuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMgAKCRD2t4JPQmmg
 c3jSD/9vy09n5i1QnuDkXX/tIbxCragLYS4wh9/gGkQpcl5qWRAmQnHD5gOWgoJ9WnVpL7cJxAk
 GXqlHU+ig1/AXSoXxvcbGnb9v84zSdvWkpD5tudm8EZwNxy2MrWLt+ocZ2nt6xAknA7vzg/lKhP
 iVJeNp3FST1iNUU3d3u9xagjpmZGrigVauzhqZO+npoyWFQY28ZBNQA+BjCqV5ny5hQjhOzw9ZV
 kePdIOaQfgTQld8BpmDu2HNogY9TIx4ja+0HR7VKuJixlY+TIOO7fPBBr6pX2S3WztzHs52ekY+
 oQtyb8PkYqCITWJUAZctFq1uC7b5/5o8+DKKu56ozBCuaGU+EyTscAaN3lT8MR+JWpt1MsL+vWv
 9qvomnrUkaGi5ou9TC7+qljfrYFKzUC/AsbDA8IyJgsOttMyJB1tsKVNXibbnRpOPxcUPEWGh7u
 TfcNm6RvtlcN/i855NQeAzF+9Y4YGPqwMh9Sjgb4H/VfxV3CB5SOmmeTedfVbeWa6BL54jleJfu
 3A02nehcX+YslmwiJTI/jiiRzHjBW72T8nkRQK3Chue7oVkhtDM3XTIY9Mp/f7RKgTfc+T1X5QG
 3aep4XDNE+jt6zpNP+mOlh5sysFwsKerCRwSJ7RioZCBk6XcfKbFKVNeXD42eQiwAMy9/PnXCsD
 0mGh3oaEweRthZQ==
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
index 614a561c1f7f..dff3fd5d3b55 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -744,7 +744,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk, int *size,
 	return true;
 }
 
-static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
+static noinline bool mptcp_established_options_rst(struct sock *sk,
 						   int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
@@ -833,7 +833,7 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
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

