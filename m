Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F252E1EE0
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166988; cv=none; b=d6pfG9CZbEWO/lq3Y/IRoHVWlEwdBIWaY/qje7d21PV8XN88DdN78hqu+JLzbSujfx25QIsfKmee/0w7iGy4rEDph96a6gmc5v6G8pPZ3GIU8ajv2g+H+Z5YS2vJqrZgYwHz831XNsYtyvsoeghZTSeRv2iBfH4kil3K1a2+zqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166988; c=relaxed/simple;
	bh=khzXK+RT4O/JkYtQapWpAsOTRoTeQok7NfxNGRdjh88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QV4d6BoUMNEi01pL2iY3lPpVPGKUpuzO0KHUWRjGOyFm11ry2MydqZpUX2ngMe7sUdytmZsWBWgsbguniMZ+J8eRPIDRUrmrjhH8QQXRCYWGJCMgF4lsqFcfKgsR3p49T00tdQIzXRAI7W0qCYXhjBO2X2e4rliEtet+tLNhywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvTg3NL0; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvTg3NL0"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so96115eec.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166982; x=1792771782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cc7YSDc3eSY84RvGkP1u25SOzoU2mcnmfFMji09UuHc=;
        b=QvTg3NL0ERMaDxTsNEvwumXb3yzRvU2miYImiQzZ84scRL4zeG9KJ1S1N9pwaYmyfv
         sgCfyVsklPpOuOrd3GtblzAapSi2TV2RhOoAN7TFlXOhvWaoj7ZNxDyR9xwieZ57dvBZ
         mFLdQUm2m9dBqH0s2rxAz37kgzpVO9WU99Q1wx2d1U84GnVg1j/g6n6VmBhS69pQs6ei
         Ofx+L6o1iu2dBbeOx1lczysfkZBFllcrQ8eRdl62Cqvv7d2TtJggWhprEO4Srnti2das
         TjOxq99hnkQLng0+wDhEtAZpQfmZZD1FhgJIgZmRsRi8sjTqOZxKyXSGRwe+tF9JBZRQ
         Gr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166982; x=1792771782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cc7YSDc3eSY84RvGkP1u25SOzoU2mcnmfFMji09UuHc=;
        b=AllyzW3pOVFyaRrdYCxdvbXbanPS4TZLzoNXPEpPTaYQv2gG9s7bmfkeasZTSMl/FM
         xspGImgkgo/B6STdk1yW2bEo8A5Sx74Srnw7Bx1sR4b9OyHZUb0fzpxpgbRVvsmg1z6R
         o4fljW8UtJswVcHIznwdJB5tbxeqE/PYSQkBIMj/YWcbCoOxEuhjaM5tG21+XUl9nmJW
         ZToN1EBCarTx7wAcLq97aNPImxnBeI4+4Z8JQ5xWIdW36+xBNbDNhe5vzC1i6sbHvRSD
         NByhbFElOvYo8u5AZjUdE8iiyzGOe5On8+xKrdfv2qh5k4x6pWUx9oGVwti684nfbOyD
         9nfw==
X-Gm-Message-State: AFq9FYJ+Q8TcDTUo+XxGgQY5fDcYPqJ2s6+IlM3mrSBlDU0UDoTDc7ce
	LIpAYrXebOPgWaKRneFP0k+ll9JF176U2sImtmBaCYxkXi9Yr0CtgoiivkJEHw==
X-Gm-Gg: AYBFou24lVNJelZvI61BBMl9gG7BH4IRr7FxmikwAWHI6aT/cH2Gu6DZQi6fZyOR+yW
	F/DGsA/cCRCEUiCuXAxdtn9F88DQ1kwPxgH/21gzy+0OLGaCjqrlmVsdIJAUfM//VrSmx6AE0qt
	lZFBK/Q7EwhibH1JvAl/2wHbbZ+ROkDtdhSaH6TUAkBQTQ7GmIdaIBXH0sUkKKpDSsnEzSAnZmq
	j9iSgGcNolPuDeSKX/xfNoqdqRlfqnA+hKfNYJ17Pjff7R+XYlM58i527kedrDYGjzvK4XRH7LQ
	2fj5aWYRF94PntAtYgdzCkLm4O6Du2UQtyckNfVw+cXfjoPACYd3psujyikatUqta4RhJN+Ieot
	mrZxu1BcfPk0U2IwLO3biQ+MnOqFITm1n/IWAQvSNTPhb5+QcOOQtihHUgvEtTSwxmqdmDHxIz9
	+JEr9DpTrEuO6OBnBishdzgR4NvHt3/Sy4+cfKr30f51rKQdSNBHDJy1L+2o6c8gS3gDVTRoSAT
	3qZKxVms3E4BqxM1vuMSwyHOdhAILcNlzpU6tDVVsHRSnNbpbDa6k74JyO4MseMRm+DGRd0s60z
	32TMTVPqcT6T9xMYcXcjhKSHBR9cqM0xucvtflkMKlg=
X-Received: by 2002:a05:693c:810e:b0:359:861:7cbd with SMTP id 5a478bee46e88-361a195b7efmr304935eec.10.1792166981925;
        Fri, 16 Oct 2026 09:09:41 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:41 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 5/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Fri, 16 Oct 2026 16:09:24 +0000
Message-Id: <20261016160926.1155262-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the in-kernel PM, a subflow closed after an error, e.g. a timeout
when a path silently drops packets, is never re-created, even once the
path works again. For example, with a main link and a backup link,
connections move to the backup after an outage but never come back.

When TCP closes a subflow created by this side after an error, the PM
now creates a new one with the same addresses. Its SYN retransmissions,
set by the subflow-retries limit, space out the attempts. If this new
subflow cannot connect, it is not retried again, and it is closed if
the MPTCP socket is closed in the meantime. Once it is established, it
is handled like any other subflow. Re-creating the initial subflow uses
one of the additional subflows allowed by the limits.

Subflows refused by the peer, reset by the peer with an MP_RST without
the transient flag (RFC 8684 section 3.6), aborted locally, or whose
endpoint has been removed are not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v5 (Matthieu):
     - split in 4 patches
     - reverse xmas tree in mptcp_pm_kernel_retry_check()
     - "in-kernel" in the subject, like the other in-kernel PM patches
     - close the re-created subflows still connecting when the socket is
       closed (Matthieu: closing the socket during a retry)
    v4 (Matthieu):
     - netlink limit, on by default, instead of the sysctl
     - one new subflow per failure, its SYN retries set from the limit: no
       socket reuse, no attempts counter, no 60s check
     - no MIB counter
     - not retried if the endpoint was removed, instead of the pm.c change
     - called through pm.c
     - new bit in the subflow context, no new hole
     - commit message: MP_RST, not any RST (Sashiko)
    v3 (Sashiko):
     - no retry after MP_RST without the T flag, local abort or EBADMSG
     - no retry on a removed endpoint or address
     - use only request_bkup for the backup flag
    v2:
     - use the subflow sockets, no list or timer
     - code moved to pm_kernel.c

 net/mptcp/pm.c        |  20 +++++++
 net/mptcp/pm_kernel.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c  |  23 ++++++++
 net/mptcp/protocol.h  |  18 +++++++
 4 files changed, 180 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..1bea4012d7f1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -694,6 +694,26 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+/* Called with the msk socket lock held, before closing a subflow: true if
+ * it has to be re-created once closed, see mptcp_pm_subflow_retry().
+ */
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry)
+{
+	if (!mptcp_pm_is_kernel(msk))
+		return false;
+
+	return mptcp_pm_kernel_retry_check(msk, subflow, retry);
+}
+
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry)
+{
+	if (mptcp_pm_is_kernel(msk))
+		mptcp_pm_kernel_retry(msk, retry);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index f4e23deda140..f49224377ade 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1613,6 +1613,125 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+static bool mptcp_pm_retry_path_error(int err)
+{
+	switch (err) {
+	case ETIMEDOUT:
+	case EHOSTUNREACH:
+	case ENETUNREACH:
+	case EHOSTDOWN:
+	case ENETDOWN:
+		return true;
+	}
+
+	return false;
+}
+
+/* Called with the msk socket lock held, before the subflow is closed */
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	bool established = READ_ONCE(subflow->fully_established);
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	struct sock *sk = (struct sock *)msk;
+	int err = READ_ONCE(ssk->sk_err);
+	bool endp_found;
+	u8 id;
+
+	retry->syn_retries = mptcp_pm_get_limit_subflow_retries(msk);
+	if (!retry->syn_retries || !err || sk->sk_state != TCP_ESTABLISHED ||
+	    __mptcp_check_fallback(msk))
+		return false;
+
+	/* mptcp_close_ssk() will not handle it again, e.g. the initial
+	 * subflow, kept in the list once closed
+	 */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
+		return false;
+
+	/* A single attempt: its SYN retransmissions space out the tries */
+	if (subflow->retry && !established)
+		return false;
+
+	/* The peer asked not to use this path again (MP_RST without the T
+	 * flag), the subflow has been aborted locally, or it hit an MPTCP
+	 * protocol error.
+	 */
+	if ((subflow->reset_seen && !subflow->reset_transient) ||
+	    err == ECONNABORTED || err == EBADMSG)
+		return false;
+
+	/* A subflow that never got established is retried only after network
+	 * errors: if the peer rejected it, trying again will not help.
+	 */
+	if (!established && !mptcp_pm_retry_path_error(err))
+		return false;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return false;
+
+	/* not if its endpoint has been removed */
+	id = subflow_get_local_id(subflow);
+	if (id) {
+		rcu_read_lock();
+		endp_found = !!__lookup_addr_by_id(pernet, id);
+		rcu_read_unlock();
+		if (!endp_found)
+			return false;
+	}
+
+	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
+	retry->remote.id = READ_ONCE(subflow->remote_id);
+	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+		return false;
+
+	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
+	retry->local.addr.port = 0;
+	retry->local.addr.id = id;
+	retry->local.flags = subflow->request_bkup ?
+			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
+	retry->local.ifindex = ssk->sk_bound_dev_if;
+
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed */
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct sock *ssk;
+	bool allowed;
+
+	spin_lock_bh(&msk->pm.lock);
+	allowed = msk->pm.extra_subflows <
+		  mptcp_pm_get_limit_extra_subflows(msk);
+	if (allowed)
+		msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (!allowed ||
+	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
+		return;
+
+	/* the new subflow is the last one */
+	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
+				  node);
+	ssk = mptcp_subflow_tcp_sock(subflow);
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, retry->syn_retries);
+	subflow->retry = 1;
+	release_sock(ssk);
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..354b80156bce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2816,6 +2816,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2827,7 +2829,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
@@ -3494,6 +3499,22 @@ static void mptcp_check_listen_stop(struct sock *sk)
 	release_sock(ssk);
 }
 
+/* Re-created subflows still connecting are useless once the msk is closed,
+ * and their SYN retransmissions could keep them around for a long time.
+ */
+static void mptcp_close_retry_subflows(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (subflow->retry && inet_sk_state_load(ssk) == TCP_SYN_SENT)
+			mptcp_close_ssk(sk, ssk, subflow);
+	}
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -3520,6 +3541,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_wr_shutdown(sk);
 	}
 
+	mptcp_close_retry_subflows(sk);
+
 	sk_stream_wait_close(sk, timeout);
 
 cleanup:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6d571328aca9..b82de84d7543 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -621,6 +621,7 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u8	retry:1;	    /* re-created after an error */
 	u8	stale_count;	    /* Protected by the msk socket lock */
 	u8	stale;		    /* Protected by the msk socket lock,
 				     * if set the subflow is unable to snd/rcv
@@ -1137,6 +1138,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+
+struct mptcp_pm_retry {
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			syn_retries;
+};
+
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry);
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
@@ -1258,6 +1271,11 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry);
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
-- 
2.25.1

