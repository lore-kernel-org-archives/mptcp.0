Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F55616D8
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885724; cv=none; b=hlLLc1zoKXSt+osf5wuiBQOz4PMYTuGJ1vYE/7pWhR69Aj0xzGCzZKxDg4OeQ9VKDIiwlUGwWNcovXCZsc42EFDEw1iP+S9wMnNrK3kFsvm05Z5nPpKAK0tj0R7I4x3JLVM1Ox+lnQmBtfAkiUQKHMsX41pDuQ2xUNOGffdnRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885724; c=relaxed/simple;
	bh=buHe+dHpViIhjZSgRJhFlF3iok++xPheGcHCT1bybnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLVxRXRuHHF/f/pqkDTLzFH65TASAGuBmaIsEduHI3m/VLzcrlaEWD8K27fUpWFQZjGxDvrDyLNlm5I7/oQ4+l8f8PBRUVguLDT551Cupn6bLxA8AsbNh62WzW8QbKRVLhD4WFn6yh2rAW9K9zoPGNnF0kiYAxESa5UnbaMlXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ABjodhJM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ABjodhJM"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c9879395so3222273a12.1
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788885720; x=1789490520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUYnn1oHNOpQge4W9YnR/P/8wbNYpMb6KtSYqU5PhQ4=;
        b=ABjodhJMNEg+Bom9EUDIuYWte31pLGCNyZT0lMTodEgE3aMm1KrI6LEn98/f/erbb6
         6F1tmLlO66kKG5uCBPZ172o6D7gxjWDnsx2TaaRnCMU3Y+nhAp7ZqsEQpmLxxAlEIq1D
         Nzk4/krJPcrIYzCbnOBDWGoWWr+Nw/m0TXD2SYJ6FeKH3RNY2WmyqhA/lrCri4usyEi3
         xdEqVKCtsLpY8+7wHQ0hbzPq/nSh1YhXeJB6Zk/NDPsT94alrs2KMYQhk7KSipWw4C+t
         RuTdIZljqJuzvvqdssmAKwQNYfgyg9raGEXGlfmh51u0TVYhRcdIPMxIGTjdd9zZ9+4o
         BYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885720; x=1789490520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUYnn1oHNOpQge4W9YnR/P/8wbNYpMb6KtSYqU5PhQ4=;
        b=Ok3KvgJvCmJNUzlbpPBMj1eGK5RCvl7Tj9x8AhZLGoCF+XmKTfWLKyoBQdWiBrXXWU
         Nz+6OwZXftX7JMrfvT/MDv58me13M5D16HzuaKKlq0WLAamN8vr7zI4jZOL3QWveu45S
         l3MazpL004AP7JKKB/Kpz1LhBm67lEsbfiX2OZgtbOj4hjqVPIvS81yNHOzOTCpR0Olv
         M4g72fW4rsvsuYflZfb2lzyIZQOvamqIk9PFs8Dz2BiXt6a8tR61jSHf3lINwSop84os
         fzu9yjf0DDOhIKx71SXDDRG+rgohqY3XB3PvS3eLlyrurQojuPMXFH/Tv1s0Ja3LT7zq
         jJ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwP7d/hZ2oguDZ+FwjWbUQT9H7wvsH1WNy13SBfO9HPj6Hji8r3qYNeLcfTeTH+mWsr6rV92g==@lists.linux.dev
X-Gm-Message-State: AFuF++koWE72sgmOFMiqcOFRAqt48TlZWvHIAzJ4MVLgfEwox1VpQSHJ
	Pug61ftpN8cjHml0u0F8jGcxAa7FimdTRRoFDdnVhZdY2yuEpOpHOd+vNRMCVe2gvUFf
X-Gm-Gg: AYBFou3Q4F7nJ9J6gb+qI6eLtejp0V6ThwSbObwhamdIGV5UGez6WfN92bfdWWpeGXF
	KW1LAtASzJYdsCmNGyiIvUzQQpXSpoNvByemyYalsuNn3EGaaYzpc9jN4wtMO3hY9vMwIB0VJYm
	wKPGYzcLxvYC8wSAqLCHM+2O6xakyz7sEQE+5uAp76kpmoZLLYbIJG2w9dAlmKhRJcT0Bo4QLni
	YpBbbPh5RBW0xeS5wHvYjRwtAObeu34WpJUYmxeXuy9iKk6UQNTLNW30PzKxq8dFP+XSKEwTx5I
	dzvnePL8bnlq1VD1MRcvX6Ir+my92ZaprGfFBvLqkdpAEXUGYGcmSJ1iLrhH0XgL2qypKUsKMnR
	3lOcS/gclGz+5NYSICJlIMTrAZagIW+o1z8y3d/LXwHK9sANiLB3huMjGcvQTjRmOb7ZSNdRQPz
	VHxqqY/mdNge+ejPIHS/aW84NBPv5qYbqeDcEBqg2K6hVUs5Z3RjRUjPDYId7U17zF3r+psIWDD
	vDUeYie
X-Received: by 2002:a05:6a21:3997:b0:3d3:b00a:7082 with SMTP id adf61e73a8af0-3da3a26d313mr50047786637.28.1788885720179;
        Tue, 08 Sep 2026 09:42:00 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45542bd2asm5685043a12.12.2026.09.08.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:59 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	geliang@kernel.org
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v6 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Wed,  9 Sep 2026 00:41:24 +0800
Message-ID: <da05a249ecea46165598366fd2a8d0d53c66e14a.1788800732.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788800732.git.caoruide123@gmail.com>
References: <cover.1788800732.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not own a reference.

The original and cloned requests can consequently drop the same msk
reference, leaving one request with a dangling pointer.  This manifests as
a KASAN slab-use-after-free in subflow_req_destructor().

A non-NULL subflow_req->msk means that the request owns one reference. The
third ACK can concurrently transfer the original request reference to the
child and release it, so taking an unconditional hold on the copied pointer
is unsafe.

MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current inet_reqsk_clone()
callers run in an RCU read-side critical section. Document and
lockdep-check that calling-context requirement.  Read the pointer from the
original request and acquire a reference only if it is still live.  Use
refcount_inc_not_zero_acquire() so the subsequent ownership validation
cannot be reordered before the try-get, then re-read the original request
to verify that it still owns the same msk. If either check fails, clear the
clone pointer; otherwise its normal destructor balances the new reference.
Mark the ownership-transfer store with WRITE_ONCE() to match the lockless
reads.

Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership.  Both
patches carry the same Fixes tag and are required for stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Reported-by: David Lee <david.lee@trailofbits.com>
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/mptcp.h             |  9 +++++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 35 ++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5796..2ac4a937384f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,9 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+/* Caller must hold an RCU read-side lock. */
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +312,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+/* Caller must hold an RCU read-side lock. */
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
+					     struct request_sock *new_req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee2..896f472dcba2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -21,6 +21,7 @@
 #include <net/xfrm.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
+#include <net/mptcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -961,6 +962,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 	}
 
+	if (rsk_is_mptcp(req))
+		mptcp_subflow_reqsk_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..cb0354985858 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,39 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_sock *msk;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "MPTCP reqsk clone called without RCU");
+
+	/* A non-NULL ->msk means the request owns one reference.  The clone
+	 * copied only the pointer, while the original request can concurrently
+	 * transfer its reference to the child.  Acquire a reference for the
+	 * clone, then verify that the original request still owns the same msk.
+	 * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone callers run in
+	 * an RCU read-side critical section, keeping the memory stable here.
+	 */
+	msk = READ_ONCE(subflow_req->msk);
+	if (msk) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt)) {
+			msk = NULL;
+		} else if (READ_ONCE(subflow_req->msk) != msk) {
+			sock_put(sk);
+			msk = NULL;
+		}
+	}
+
+	new_subflow_req->msk = msk;
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
@@ -919,7 +952,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			/* move the msk reference ownership to the subflow */
-			subflow_req->msk = NULL;
+			WRITE_ONCE(subflow_req->msk, NULL);
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-- 
2.34.1
