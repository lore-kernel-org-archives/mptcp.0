Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD12134AB
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384837; cv=none; b=CO3hYAkuDQhkEbH52xPJiS4oaPh21j5qu0GuVFD+Bp/s1d/TouJmz5GDgjj86F0TbJ3J7nZrH2Xlgl0zCfQoU9Dq+LFMcLkkN8qtVe+BMpDW4nqU/BsH9lT/uRlR9aJLAbFNSN7nTIixbYMkIE4cGGEKB0GpDV3Qgj1RyF7IZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384837; c=relaxed/simple;
	bh=oYD5ye+ngA/nO4KOXy1Lxrta+2C66xKgicBDo3y7hDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8SZp/TEXxNFd7/MTH0BQAUsyqQevrgMcO1/KPjVcyJUMddIMj38IT8NVWZ0A2DXzZl3IF0WiE4Lnqmrsgg/oGtO1RhaQfwOJYfmRIW0Aub8LJ3IuGlCEkmb/jCTdLxTqHu956FhuEgDtj/Jm/pmIB6lvV8oh9WuHBI3b+Je1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXX/mL6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXX/mL6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887E9C4CEDD;
	Mon, 24 Feb 2025 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384837;
	bh=oYD5ye+ngA/nO4KOXy1Lxrta+2C66xKgicBDo3y7hDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXX/mL6Xt1P4REdCAUqvDvHSU/IKgj67jaUiUvgyHhyt8lagQVfS+j737A/cxoA+f
	 IyP30xoZWp7vz2KEsfJS0kA+JsWYYagySI7oXuvXOkWhIbZBHcELPSgbbbD0WTdeNN
	 hIjIF0bsZEb+rr0oQrRAllytJHoBXnzFAEfYzikfTyExh+vu+Ua05OdpKj5tN0WMtI
	 ulchK+jgMmr+iuoSK/1m5xaV3iM16Ob/UP1A5NIokpWsa1+wjuWvvOPpSBZn53kLTL
	 pkDBP0Ld064R6ipH+fRB6DoHzSOmGAui0yPUmKfyV6ANqxr8q6R2aPKyoRa/SBpYRt
	 9UiGuYlKU7aKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/6] sock: add sock_kmemdup helper
Date: Mon, 24 Feb 2025 16:13:37 +0800
Message-ID: <0a3f7a31983f0587ace333f349f3e630c49d075d.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds the sock version of kmemdup() helper, named sock_kmemdup(),
to duplicate a memory block using the socket's option memory buffer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/sock.h |  1 +
 net/core/sock.c    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index edbb870e3f86..ffd757e7e329 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1793,6 +1793,7 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src, int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 0d385bf27b38..d09bd697c120 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2805,6 +2805,29 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
 }
 EXPORT_SYMBOL(sock_kmalloc);
 
+/*
+ * Duplicate a memory block using the socket's option memory buffer.
+ */
+void *sock_kmemdup(struct sock *sk, const void *src, int size, gfp_t priority)
+{
+	int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
+
+	if ((unsigned int)size <= optmem_max &&
+	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
+		void *mem;
+		/* First do the add, to avoid the race if kmalloc
+		 * might sleep.
+		 */
+		atomic_add(size, &sk->sk_omem_alloc);
+		mem = kmemdup(src, size, priority);
+		if (mem)
+			return mem;
+		atomic_sub(size, &sk->sk_omem_alloc);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(sock_kmemdup);
+
 /* Free an option memory block. Note, we actually want the inline
  * here as this allows gcc to detect the nullify and fold away the
  * condition entirely.
-- 
2.43.0

