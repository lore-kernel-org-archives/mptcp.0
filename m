Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2E4772A5
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258829; cv=none; b=KG2tFNVAtws3+1z5l8dMviEiMEV9zKYQB88ZXvwh3MoZEh4eK4+lyWNqpjwtcv81GnLNydKTCYyjaI6JxSC/WW96yrjVNEj0Ay2dnyfOj9vvOI5Ug1K+7YrKrCcHf4g19fmbfayEWAAITIXmoZ0v6DqVXVqCGxsfWQd1gL7im2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258829; c=relaxed/simple;
	bh=vOIMW1U9fUy9WNBWnSKTTeuAvqM4SIyRn7lhsRt/YDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFQkV5JDNk/oi2mQg8fd+P5MXYfVOE+YbeXySUwvCOK9Ma8017TDN/ARvDrbiEZ8nVQeeXey4O0f0zWNpRBE0ratYmFvWBJNB8I4Rhz7Q5o+x3lbNJgGPxt1Gd5OJP0maZm+kaPjn556QDPRTIgpMK+qIwPqBtgkzhg7pOTPB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=EKOxrcwi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="EKOxrcwi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1228365a12.0
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788258827; x=1788863627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28E3gzKw1BC+V11wZJETp2y9T2uBlRNahPrPaDZe6E0=;
        b=EKOxrcwiOate9yYwrYZDQPBXyB16le7xgDvQbSo7gz/+JS7HO0RnkZUeF1xG0/8k6D
         WPr+8VOnKwRbmmmqYnrvBJNzt9QFnra/qUt9dRRyKQSEo/aoZu6OnBCCa9pIRoWXSRUe
         K0Qw60jszsRSz9TuPw2cJEuKKWSDoGI18mr0VOKWegGt7UYHT5QvD1Cg4ei6Z2thFG81
         T+c6E81QVlc5AjS5HVQBHTf+HWJAyPsZIH7qvKCRQtBWNwuo7Ciai0x0uH5ugI9z+nVa
         arsje2B0x+6sv0HGBMSi7eN/J+HI7wALsG8zzMISg3Ba7EQQIJsvk3auP1+0Un2DYfmH
         3UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258827; x=1788863627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=28E3gzKw1BC+V11wZJETp2y9T2uBlRNahPrPaDZe6E0=;
        b=iF29u8u6hk8YCXJcrpQwIu/dDHv47kEW85RaQoGbigZvPUdNkHIyqtVMDXAKeQz2bs
         1geQo0GB5B51/LwqdbV5778mUdjCCYsPM6h8/Uev06eewKGC1GnVLfthCubUYp1gFADD
         0eJ1N4k0J1e5xFiOXaRKUYBVxn5bVqH9TmsGXa10fRB6MUotGheG5HvMqW0bfbGBxlgg
         WZqD1Bc2K2iA742moR1uEeZcqwwmMkjs/AYgGPiAVQp+CzornDUA9eeA2UrXCq4UuVIp
         eBxXL3mtMVYxu5gskqHMSmDqkfvJjiqV5yxOgtMtqeNVWc3xFbUqOcnFTgbMZE1XkEja
         o7KA==
X-Forwarded-Encrypted: i=1; AKwUvBx8kASVGygV6Ip4NLGeOC2N9GtA8RtVxdXWwn2nCH11czvF/NLa6qjsPev54/ueLhCVdYOLLg==@lists.linux.dev
X-Gm-Message-State: AFuF++lSnAaL5STyoaFlCXjhSKJJD8y6FlnR44Hfl210GHJv6TYMNWOL
	qgOvbjUZaYsTUxjAIWJZRlNN4cJYLmvOZfMCO5vyEjaFfzHhEHYU6mdhJ1JFzG5Ev/p+
X-Gm-Gg: AYBFou1ci7ktb9MSWwvw438G32y2DHuNbn0/IPBhSM6MgvGJPijvaWbTF+3JvR8HiQx
	r0wsmECz7//8zmjrGyICMociwn2CliEEow8DGLh3fwhKvOlSDHTWUAFG+EYBtAhuDNcqOiRA4bX
	uxDj0+uLWROFbOjAIxwEr8FtR4Wm3UFF/WDLD3da2iZl7yhz+Yk8Z/oO7keJEq8zvMVWPYuPrkO
	/VZme1G559WvLiQLuzYkQC0sP1aJrZb8MBK2fVlNMloU3d64KtuAPEiIXWip6A3iqVcqDGsCth/
	ujgGMH7RwqFT1Br6qMh4CqxFdFTVCnt1xhs0JrIOfhq0ZFFvDiEGhO7Qc9SvZL6JyoU6JOtrd4s
	alv4CbUvPGuQG9WvNn2+h4Gi5Vrid0X/OZj3cmlXzJ+SKI8nTTtp8kjCAG24MleWZcU31Gd8knG
	2msO7nmHnOVEh0Webf0UB25+OnzQDXZPOGzg65U48Ca3z5v2oX7u3S59g/lAYb+RPk30qAo1s=
X-Received: by 2002:a17:90b:1b08:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-3990f8907c5mr2621194a91.14.1788258827484;
        Tue, 01 Sep 2026 03:33:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm6126574a91.1.2026.09.01.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:33:47 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
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
Subject: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Tue,  1 Sep 2026 18:33:22 +0800
Message-ID: <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
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
reference, leaving one request with a dangling pointer.  This manifests
as a KASAN slab-use-after-free in subflow_req_destructor().

A non-NULL subflow_req->msk means that the request owns one reference.
The third ACK can concurrently transfer the original request reference
to the child and release it, so taking an unconditional hold on the
copied pointer is unsafe.

MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current
inet_reqsk_clone() callers run in an RCU read-side critical section.
Read the pointer from the original request, acquire a reference only if
it is still live, then re-read the original request to verify that it
still owns the same msk.  If either check fails, clear the clone pointer;
otherwise its normal destructor balances the new reference.  Mark the
ownership-transfer store with WRITE_ONCE() to match the lockless reads.

Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership.  Both
patches carry the same Fixes tag and are required for stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Reported-by: David Lee <david.lee@trailofbits.com>
Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/mptcp.h             |  7 +++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5796..0a02ac1ed22d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +311,11 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
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
index 8e386899ceb9..e08d1036ad78 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,37 @@ static void subflow_req_destructor(struct request_sock *req)
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
+		struct sock *msk_sk = (struct sock *)msk;
+
+		if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
+			msk = NULL;
+		} else if (READ_ONCE(subflow_req->msk) != msk) {
+			sock_put(msk_sk);
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
@@ -919,7 +950,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			/* move the msk reference ownership to the subflow */
-			subflow_req->msk = NULL;
+			WRITE_ONCE(subflow_req->msk, NULL);
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-- 
2.34.1

