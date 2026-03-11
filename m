Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B43B634F
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215805; cv=none; b=NjWbcU5OPRd3MtQA8NOgNTt59eRBjftHhpiLq51wg12+oO8b/jNq4sODCnhenwVYGIkMac8x0GFMA4cbYTswkBEr3mVZneRhV82eCpSETZeL/MryI7M4cG4u0KqL3J2WqyAoU3kkWwGmF286x9hBaQMxi/GzhCSJpQQwmWo7gV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215805; c=relaxed/simple;
	bh=9YrqMac2RvVbcQMvhIkvAs6CdxSyWCSfXy/rvRlKfmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfvabFWXNXqHQsPsfmdyi+dxuhbFYVw8iLRWcZ9jWg1Z6U9jqo4ldLSnZpTkEcIANfDMJ5Ywe/2mqZhQq63D/n3U7YYqSZcWljCR052rXpMcbToOUD4mDOqrXkrkEK/rtzjzj4MbH+LEmKazvalo3bB+BoPGVO8IsTSBB5yjnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIO2le/7; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIO2le/7"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4042905015cso5412406fac.0
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215797; x=1773820597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=eIO2le/7V5bWSqzd/C/vSMwqdSzFlh8DVf3dAWtcd+bD2jM/4a3yEFUmH8ZucYunGc
         RZked24bUGCWA/XeUhyk+l9Y2+p6irY0kX12ANau+Pqtpzr6WXxzkJOSizOguoaDJe3q
         Mag+rpsLg1arX+B9ZJt7KVfaZGgRORDTE3QG9OnO2NFlpBzd+z9yyZMsVMAwxTi79ZAc
         iwk/fX6YzwVJROLCLN/mwBkJJPAOBbJ/CKw/4gEJBIIBL554gpgHmiE/pM2WvmH0UYP+
         NBuobQzQjSkm8K8VFmCLRl5eF4xHLvKyPMGITKv95Vfs/imgWYThvfGqzlhEbh/pGk6a
         RAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215797; x=1773820597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=bcOM0XieUr4KbjATBaSmtVqP40xJtZWuS9cNRg6XmpbIZVsEOeCESHXI+s+bR9qItN
         sE6RgunHvMWVomhWacFvhAcMn0o4+R0KFgsEvr2hpuSxougSQjQbZ51lwTTkrXs2Aizu
         j43OMFJ6QPWg8qF2SY4o5UeFCCmOi20aVxLpqQfj5TK8UDmdgq5BNVKejO8V9CNOu0qC
         9+CYdkdvOAMOBCuqFj+IvO61OvN1KobZRK7RCHFSWOBRDpWRnb9URMS8rp5RmnbFKC2U
         EXRJRoETCpLqentXU5Hrs0mKO/aMX15Jt1JmHDr9XPKgf6OX23enxVPRgdUGTkG/XNhw
         47YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjXWYzPo53Jxy4QaSFhUyKgQCzT/kk/bphaYcoN+avLkNJT9YocCyiAmmFAUmiNxsdumo7sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRVeWXpdnsSPaagVePHXqZqoh7f+V2im+8JVwLguqfykLhiSLd
	rONknms0K3Je3NoyEKAjL88xqJXrRQPUrAtwNW/4IR9pmMEStgUCPsqZ
X-Gm-Gg: ATEYQzwOKk5Pq7qrfdhjDe7/cBB2Bjwa4EYuwD+pgy02QKJzivpsyIqZ5v15rW1m969
	l96AP3meunPVYww7vnNMu7baT5stnafNTO12JmffJ4rnSh+AiQ2C99wOtHeBO3RhHvma+3TNk3k
	BQIFJZl166nCnmNYNB7SLA2OyHywDL4jXU+te6wfjFUwFYRyh8YzZA67oAxpIuoEzFvNnJ0zLUk
	X9TVZY2lnHtkTqty0uhqkt+SuCwin2nVkWWbw9HBZP2dnWMsHk5X+XDQwTdrlsZVv0shtOOEB5/
	Dgbt5msHOoElsCFtsW1pdoxy9wyVUBCUmtDMavuPuqGjRG07JB0HaotbSBiIsqxmh9Y9rSPd9QL
	hRKCQxp4GJSASSgT8oQv9pdEcDbcaXJSmPyiprJQsxfDbQQXNzju0XTWqUAY4AiwzVIrpJZuHGe
	ySw9fPCKm80h24TgwI0XLQ+QdMGDYwOdY4R7cnCh/Xo3eynhJOrtkvqv8hhMgrUEabTb9YTtETd
	WNq8n7hp6kWidbkDXJMSG8WCinK33S9gQd7NSl/S+bczwvN
X-Received: by 2002:a05:6870:2e04:b0:409:7cfc:7392 with SMTP id 586e51a60fabf-4177c96b888mr1211062fac.42.1773215796875;
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 5/7] mptcp: refresh tcp rcv_wnd snapshot when syncing receive windows
Date: Wed, 11 Mar 2026 01:55:58 -0600
Message-Id: <20260311075600.948413-6-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP rewrites the TCP shadow receive window on subflows when shared
receive-window state changes.

Once tp->rcv_wnd carries paired snapshot semantics, those subflow shadow
updates have to refresh the snapshot too. Convert the MPTCP window-sync
write sites to use the helper and keep the aggregate receive-space
arithmetic using the explicit rwnd-availability helper.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 12 ++++++++----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 43df4293f58b..6e6aa084cbfa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1073,9 +1073,12 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 		return;
 
 	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
-	 * resync.
+	 * resync. Keep the TCP shadow window in its advertised u32 domain
+	 * and refresh the advertise-time scaling snapshot while doing so.
 	 */
-	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_set_rcv_wnd(tp, min_t(u64, (u64)tp->rcv_wnd +
+				  (mptcp_rcv_wnd - subflow->rcv_wnd_sent),
+				  U32_MAX));
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
@@ -1334,11 +1337,12 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
 		new_win = tp->rcv_wnd;
 
 		/* Make sure we do not exceed the maximum possible
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..4ea95c9c0c7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,11 +408,19 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
 }
 
+/* MPTCP exposes window space from the mptcp-level receive queue, so it tracks
+ * a separate backlog counter from the subflow backlog embedded in struct sock.
+ */
+static inline int mptcp_rwnd_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) -
+	       READ_ONCE(mptcp_sk(sk)->backlog_len) -
+	       tcp_rmem_used(sk);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
-				    sk_rmem_alloc_get(sk));
+	return mptcp_win_from_space(sk, mptcp_rwnd_avail(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.34.1

