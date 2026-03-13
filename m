Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C012264C7
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375196; cv=none; b=iSpGBMWow57OMfq5ocPaoDNSAuwc8iJY9zXESaz3qKwsHYQxd+wM571cSNgvOF1yKrLldlM36xlDRgDYXkCXdnzT7C+v4wpsm0If1FF/qgK4n980nxFF/XJBPy2wyYDicw8LN5o/+VSlzx4L3lLqK/9XA0KWtgsGt1WDmnxCsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375196; c=relaxed/simple;
	bh=F6pEaYtSEL1gE+MhT6Dp29hC7bG/DqXUJeekugLWabA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNDZw0av03fjnVnZP6LESoQfs8IBmenKMc1r2VBr5S/DsPQ0Fkl1Ms0WgmR2a0TdpqcyL1uP5lZKpO6XYzn0LeOCM5OMFpdWS1jTLEQDg6g0CyyP6xERjdSqsTWjlKZoTdoJA1AXdpK1lbPg4HmraSLTFB6ZiUalTDWuKcTT2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et42VoZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et42VoZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9015C19424;
	Fri, 13 Mar 2026 04:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375195;
	bh=F6pEaYtSEL1gE+MhT6Dp29hC7bG/DqXUJeekugLWabA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et42VoZ4tyI0Yv6nhEZ3/7tTqN0Yqg6xWfsuBFXnOUFJIdPkV2shgLJ57jpqXGOvO
	 k2V6RScvscTa+ZJlNclGDYFFhCr04ShS5yxQIqXGM3A2HJin/b2oUiKfexxGqZA4Hk
	 rdeSNwrOmqZPQOSq4PlC358BNqY505bOulzwbbLX6wMHLmqEZ/hiJwIrOtjtU/PzBN
	 NwTj5+z91mXgpQtQ+5NIvrYELcdZK6zPYA6S8ceYa+VBy0apJeWFGuwknBS+3JQB5s
	 7x2tmWuwhfUFcUQC3OF0BQjA0wYFZc2urueua0Ql5Y9cjtddqP9SuxJc63Qbk1gQzO
	 LoraHfhrA7sFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 3/7] mptcp: add sock_set_reuseaddr
Date: Fri, 13 Mar 2026 12:12:47 +0800
Message-ID: <253dbac0e981aefb100d7aacd533e04865090afb.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a dedicated MPTCP helper, sock_set_reuseaddr, which
sets the address reuse flag on the first subflow socket of an MPTCP
connection, and it will be applied to the target side in the 'NVMe over
MPTCP' implementation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 60cbf29448b0..63b64b7699e3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -246,6 +246,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -339,6 +341,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return hto
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 692111941808..bb923c4fabd1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3818,6 +3818,22 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
 
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	ssk->sk_reuse = SK_CAN_REUSE;
+	sk->sk_reuse = ssk->sk_reuse;
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

