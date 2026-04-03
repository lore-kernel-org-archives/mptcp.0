Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAED37BE78;
	Fri,  3 Apr 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215795; cv=none; b=HoNG60D0vvlx8K2l0Z3tL9PO0tXlqyZYCpHiVousSVhTpoM0s1oEhCUr+B9BHGwsserCNAImegeeUIS1eDRsPaqYE+PXwkUhBlblLLl2h2F0T7M1RyfDQHhS87xkowKX3pBEj6vCvOKhObWvlVC5nj1NeR51nBTeBPaQ06sR8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215795; c=relaxed/simple;
	bh=VPuMCcSMn0fGFWGRYpAGvUyYaU9ngULkySrtJMxEQ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVtxdgb1bvHceJk/pc2b8GYqIo33hYRGBLIaYlnAyMN2vEnyolVA90bZWDURR72pO6pCpAn/95aMCLoE7yT4BI6EzmAeMF0H90015sLKmcNgBKTzSTWGhp6i59CZ6irqCw5YUitRGeVKboXrdICpN/imn4XSQz4Ambs/K9QMVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ4Yg+kV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ4Yg+kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50FC19423;
	Fri,  3 Apr 2026 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215794;
	bh=VPuMCcSMn0fGFWGRYpAGvUyYaU9ngULkySrtJMxEQ3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FQ4Yg+kVHjuAft1BIBzk/JrL3VR+FvEhtd7+E5N2mhI/KZMsDxgIt4WxYOQ2iFXoO
	 vTrwADIaR2Qw7Ww+dXJWIGkn3KsiSsy7i+17Js7YVy6WjXhNAFoiKZyeEOh5OQp+8N
	 ClX90mgoOT1bU1ck0VQ5LbYy+DeLNoimd8BpvxPTwE2vH06f3ee1Ml/qKTl9pQMG69
	 SeB2doUr6C3gThEmTgMXKrgjPReZYN0otqEtW+EUBjbxDDBYnRSGRkSLE6aXN52bDp
	 1ICv4i2e0M41oWPcsRRXcuwQcA0Lj9ZBJJibe2Sr0s2tWh+m+CYeu9rIsM7GbKDUS9
	 n4cvk7SG2GDkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:29:27 +0200
Subject: [PATCH net-next 1/5] mptcp: reduce 'overhead' from u16 to u8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-1-b0b33bea3fed@kernel.org>
References: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YCYDzaz5Nyw/pADvCjdf3hqBQ1LHqoworLozj+9TNkM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1kVcX/X8p/ZRz0m1KZLLK9krPwtEir6qy/ZN8C5M
 fMqT7dcRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET81zH8L9kZtd+I8+mj/709
 VZGN75QN1wqIFbdGrNbfulH3R+y92wz/Q1qv+gsdqT15/dEtzljfqn1Xw3ZpLHbLc43mWc2Yl5r
 FBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

The 'overhead' in struct mptcp_data_frag can safely use u8, as it
represents 'alignment + sizeof(mptcp_data_frag)'. With a maximum
alignment of 7('ALIGN(1, sizeof(long)) - 1'), the overhead is at most
47, well below U8_MAX and validated with BUILD_BUG_ON().

This patch also adds a field named 'unused' for further extensions.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 239fb9e75c7c..79315e575d07 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4616,6 +4616,12 @@ void __init mptcp_proto_init(void)
 	inet_register_protosw(&mptcp_protosw);
 
 	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, cb));
+
+	/* struct mptcp_data_frag: 'overhead' corresponds to the alignment
+	 * (ALIGN(1, sizeof(long)) - 1, so 8-1) + the struct's size
+	 */
+	BUILD_BUG_ON(ALIGN(1, sizeof(long)) - 1 + sizeof(struct mptcp_data_frag)
+		     > U8_MAX);
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..02031007100b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -263,7 +263,8 @@ struct mptcp_data_frag {
 	u64 data_seq;
 	u16 data_len;
 	u16 offset;
-	u16 overhead;
+	u8 overhead;
+	u8 __unused;
 	u16 already_sent;
 	struct page *page;
 };

-- 
2.53.0

