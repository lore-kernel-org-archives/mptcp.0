Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CE30FF30
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517766; cv=none; b=pdyzysZA1sOMBnLZtG5iyP9Pfjrt2F4kL7zBG/LNQCCcK6quaxYYMHoygibFCLqYElccZq+2z41IKssEAPWdqCefMZW1jA8a8F/h6TRW14W0+jBS8CwLmDgnDGK4iK+v6s+9egtN+ty55U0C0lNcx071gW9vsCQXYBsmypJFAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517766; c=relaxed/simple;
	bh=JnhSd2jLP4X3eR3UTW97+LOiFbBUNUSEHSCyoIJ1NbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRTfyhvH/c94yfj3bOlx3Qg0/ZTOsVL46BBkYfYSXg0cZFC5Bprt501ScVvy+gl+zw/fUreOAy1CPP31Az9BZr/yu89AFMdQsVnifdpyuDTRmMWeIWq+UiKSpiduCLZ8y2A1pMhdf1bVVGzd59i7NWGZPoVa8vBn7vuAaGMh/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=l+wRFMVy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="l+wRFMVy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso778010a91.1
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786517764; x=1787122564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUpOfz+sm9tkkgAFwKxKf/LC6hjxRNWvUZB8avg2+jk=;
        b=l+wRFMVySuv3RkaFSntB5AMSpZJXX06XYD5ZYol5CX0NQuu6EcwEFUGLwBo1VF3/2R
         8NP00oGZZdcYKGf4f1OKSEjuSd7ff9Ia6j1O71BkeJVhPLMvCdB7aJ50i4O7e1EoEvrk
         bo8Vc3AU/RR+uWrlmWoXXGt6PMf/3948W/E5D7ayZgAlpNmZDmsOQ3Klqj6hMHpkKjXO
         en/KU0uH9+nw3z0TIspmQGdrJ7PyOrlJA1DCAsg8UOqxRR1ttltU2PkkdoC/VBcjcbxr
         tn9O9RFAirtLMwykSrQX9aplTAZWQVllJoXzSZuGSwXPqiw74ERellP+9flyBR8X6xBp
         Shog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517764; x=1787122564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUpOfz+sm9tkkgAFwKxKf/LC6hjxRNWvUZB8avg2+jk=;
        b=Fc/tPYeKtWWlMcWOJsTFDIe8XBTc1ASUN/hn1BR6Oj83K1FRpUZpr5siQTUIGCFHLu
         yuSobRPKddBjXCo/N1+Anl0jVfkRQVBC/pzyIEwELorCdAx3vxz4onlBOB3d5II/LXmb
         gpKT8eptGNSjjPpCMv0Fshv3ZVFwDqo5ONDHvqb81oRMxyNjZGNJM6BfmIfchK4vu8QQ
         nCudOAaW2qZQwEU8eij7GtaRniB7dRTcHwr4PRmIbrJrOWtb8ReN1PcGZjNF+Ur2TngH
         88f8VBbvpVzlFWOaRarQry7JSFRLOYx9XgdMXl9fJ0SNpj2olMziMwHDUU/8+Ho7AAE8
         AUbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyGY/h3jzsKV9NnZlLKk3gjKshJybvLx9kTT5/tZIF6UKH37zdzQZolaQn6C+oCC1d81V5vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/r5kXMH7rbn9izY8KBbeVob1pbkZIsCTU9hz7j3yp66RAJi7f
	mrtWJvIPyVuEaJPT2sbjvpyaiOKWdCTjRjBMd/xZmqBpgwwtxYS6WRESfEw7rD9OclzI
X-Gm-Gg: AR+sD12O/1tAgJck1LHKcrsoOU0ct0C99+Gq/1WQTnk9HQ69t31VIMJf6cUzvW6Q1Fo
	vg3F/WMQxl0kmsoOYGEdRZ7V+8tzYbYlK5PjRkhrrAZsXqHNStth75IIosyq68AJ5nr7UQZMQ6z
	3e7KwWAnjpi1AknLKTxKMh+Ou4bQtiJFO/7uJzk9yoGzoEE3sgx7pop6B3vhrHuXbhOXl6eY9Au
	T/mGV9a6vBQezQloFyRpNML9KfgbRVg5qT9+9NphN78iy2SYlPprWHmWnrj3g15/UsLvetahdUt
	on8Q+3gurcxW/mB4a6rqTQBUguUJmMI1HwsplHGWjUtUwuEDliXagB/Aju13LgIL3DggbPzCTk+
	OQoYXzFkmDenSHUNPl9Ch60JAj/NV9go2kLkwslr1Et4xs0P4PXn3FIX39Ta61IxHziGgG9Hwol
	5ab3d7A00cPm9/3pJdkTMiGzcGNVckrFq+DYClFBoKGBvRsc2i0ARY8GptzcWuMJ/X5PDPAg==
X-Received: by 2002:a17:90b:4c4a:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-39302bc9c67mr1076959a91.16.1786517764333;
        Tue, 11 Aug 2026 23:56:04 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8d00067sm2546980a91.12.2026.08.11.23.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:56:03 -0700 (PDT)
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
	kafai@fb.com,
	daniel@iogearbox.net,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Wed, 12 Aug 2026 14:55:45 +0800
Message-ID: <e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786497414.git.yuantan098@gmail.com>
References: <cover.1786497414.git.yuantan098@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone(). For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not take its own reference.

The original and cloned request can consequently drop the same msk
reference from subflow_req_destructor(), leaving one request with a
dangling pointer after the other is released.

Add an MPTCP clone helper on the TCP request migration path and let
cloned subflow requests grab their own msk reference when one is
present.  The clone's normal destructor balances this reference on both
successful migration and failed clone/insert paths.

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
 net/mptcp/subflow.c             | 11 +++++++++++
 3 files changed, 22 insertions(+)

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
index e1f20ff8fdb4..8f8e1229766d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req;
+
+	subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
-- 
2.43.0
