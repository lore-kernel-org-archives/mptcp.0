Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466247;
	b=YwnxRUEck07+UDVwY3V0sLN9ojVCbIXG6d1U6bjMnOnqgELKnTLw+e5GjzYIskaHMjkC
	 Irk4QBrLgtMGYQLyfl2fmA+xxqk4wc+cY1N+JH0F6+1UZJDR5lc2oTbQ43qszwPutxAdq
	 ugEDkkxs/MDRaLpqHIgkwhznD2iORvUKSxRZ59us07DFIR4vc0AH9oldyiqG/lKSKwH8H
	 yvMZUM/iYs7hhXQhYbZ4iB6jCxcGF7wpqE4H0vpWO7/Ej2uveeHfu3MJu7vgX/Fa39yuM
	 JTY6IagoInoxS49k8pMGDbe94lxqOrBpb04UQpITCnMC+fGJR0oDbTn4+dByZUPAPOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y0WTyN9WIuqgoqFym113vOFdyCW8b2lsI6NQt3+i19U=;
	b=KhewPVarZMBOAM1vWJnqcsAP4ne5RZ2XqH/raldM76By6DDv8e3IxEl9dPr9N9s4jCIT
	 n6XbksWZxyDS7sqBLxDE6IFMqg5VrW6uvsAlmckcL4D+tXpPVkgsKZpr8Tv141QglmEhE
	 GWNZQp92uy1O6Z4mN/V21qOuMswI+E3CAxojjBxH3yqZHu4Ompmm4ZeH1Op2SXJVjc3xp
	 IqPD3dveLHQX/SqzazY9BJiBsJUxPxYilGAbJMtAkpAFUeyvDN9EMDmZXJce2SBTU77An
	 u5Hp+qXVGWgZgrswR4YezsYLhWf30xnJiUFwDJKQAPDONMqTuvWG7Ql8Ig2AA62oFVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iELpie62;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91D606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D91D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iELpie62
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so3869186eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466246; x=1793071046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0WTyN9WIuqgoqFym113vOFdyCW8b2lsI6NQt3+i19U=;
        b=iELpie62h6P9m4yz8AFwwnZCQp6BeY7yOiMx88IVYHZp0PrYjccnp1qzvymoaCupO8
         KD5Uw2QItK9Exy1ECklAv5JuJMiIgOYHcsGjhXMyTnV6btucUWjI+NXF28dscPXkGSpf
         YtyG0oaLrjqTItp65hlwXuyuHD6d3KzpRc3ZNdS6XOQxdM7MpNdi5lrkac9gQbRmjV/q
         hliBgd6Z9edyQFCxM+lRtq8jEviJoEJYpx7xLR0Ao7nZxfomHSkX9AJv4i9eXtHBUZDF
         WzhsIkp1lDgIvHd6LcS9bgBG+k9RscsG5Qq+I4j7FYqNgZEY1PGbkcbZ8Snv04Y20eaL
         8d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466246; x=1793071046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0WTyN9WIuqgoqFym113vOFdyCW8b2lsI6NQt3+i19U=;
        b=nEnB6/bESTFTIuzJUZk1vuaJR2p0QXtj6r3ixn/A9Knpylro69u+RKy15tEOdCpd2t
         fqP3c6ZTyQb/hOoVeWYlW3GT3JRpwDsY52k5puSF3NfWy0PZ6bI5hMe10TOLPtMRon+i
         3tse1/VEnLNeZYS/HWBY/upveUiIsfjQ3kMW4YNcZCXdnJcGYvhvbHFdYM1PGzwFh7J7
         jcuBd1zQa2RKixZ3r3gGHSTKtx/Up/lQ0z9QygV9jScJvce5IHNZioOa7FnFCJlsvCDH
         xO4gG3iCum3QembLqgyzyuoC25qdLN/v/+tQOG0XrWVVUepM/JeG4dJkbQUw2Oaf09nJ
         vydw==
X-Gm-Message-State: AFq9FYJIl/6R89oPjoi9YMvASN6uLWKQqSRYS4nbyw+nFCuB4j9jjEYW
	ns3H6+HUbEikr1kKQiOtfs4T5Xl0QpoJVPeMRj7c4tHKEl0cSaIUZALN07l/xg==
X-Gm-Gg: AYBFou3BKjhW16MauJnbT5MdrKX8leotS368y+nzwwMdIcGbGzIpOWQJX3GmLkvLutB
	A27beN7v2MXrSV3mcvmNamKmlJ8p9yKljCW5LYjhhSZRRzxraGYqbuPQLiM0u4IEp2Asr4bS/VP
	wnBLjbACJdEXAJXGhmnme1kmP7StmKjqSbBPlXOMB43kGx6OnHr8uEWuIMS5w5F8lIWjm7/V5l+
	ktfrQx8/gkZ7t189gYtUvq5FviJqqPMci62zUaq75uFZtUd3I6w8g0siy8hzycECn9dSf4hL4Jw
	/q2UH3sOGAWDG4ZtimIXyDDt2jbdaL8ozAkMI/9nrtRkOLhksjTSwP9ou9htOs9Bb/ouUEqoAzD
	hbmNDYMcePf/HhjzjNN9aTudhWUf1zfBbFnH34H+HkBraphZpY+S8tI1yNI2l8fxQErFn2EMl9P
	S7oIUYNSblHo6vorjwigvbZs+HMLtjvuVUU0CSdV+ZAcDrp0k4LZQ6/kmce9mJfm8/Oi/BaXhjl
	uxhcgkgA89I7FQK3wvm0ewX4uh9iygibK93do4f7N9DP3l2UbWQu6wiOsJxcE3XYOMGgxMKJ8kz
	LFWDHKwJCZIRR6GDGGZFbyYVrg7NGgHLSTttJWzwMB0=
X-Received: by 2002:a05:7300:7a9e:b0:361:1dd6:531b with SMTP id 5a478bee46e88-361a2052bebmr12209584eec.26.1792466245966;
        Mon, 19 Oct 2026 20:17:25 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:25 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Tue, 20 Oct 2026 03:17:09 +0000
Message-Id: <20261020031711.1896660-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the in-kernel PM, a subflow closed after an error, e.g. a timeout
when a path silently drops packets, is never re-created, even once the
path works again. For example, with a main link and a backup link,
connections move to the backup after an outage but never come back.

When TCP gives up on an established subflow created by this side, after
a retransmission or keepalive timeout, the PM now creates a new one with
the same addresses. Its SYN
retries, set like TCP_SYNCNT by the subflow-retries limit, space out the
attempts. If this new subflow cannot connect, it is not retried again,
and it is closed if the MPTCP socket is closed in the meantime. Once it
is established, it is handled like any other subflow. Re-creating the
initial subflow uses one of the additional subflows allowed by the
limits.

A subflow reset by the peer, or by anything on the path, is not
re-created: the path works, and re-creating it right away could loop.
A subflow that never got established is not re-created either: the PM
keeps trying the next endpoints, as before. Subflows aborted locally,
also by MPTCP, or using an address that has been removed are not
retried.

TCP only closes a subflow after tcp_retries2 retransmissions, about 15
minutes by default. A subflow that only receives data never gets an
error: the application has to enable TCP keepalive on the MPTCP socket,
which MPTCP applies to all the subflows. Both are documented in
mptcp.rst.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v7:
     - only after a path error, a retransmission or keepalive timeout: a
       reset from the peer or the path could make it loop (netdev
       Sashiko)
     - retry and no_retry are bools under the msk socket lock, in the
       padding after close_event_done, not bits next to the reset ones
       (netdev Sashiko)
     - mark all the subflows using a removed address, whatever their
       state (netdev Sashiko)
     - doc: tcp_retries2, and keepalive for a subflow that only receives
       data (Abdul Wasey's tests)
     - not retried after a reset by MPTCP itself, even with an old sk_err
       left by IP_RECVERR (netdev Sashiko)
     - close the re-created subflows still connecting without
       MPTCP_CF_PUSH: they never carried data (netdev Sashiko)
    v6 (netdev Sashiko):
     - only re-create subflows that were established: the PM still tries the
       next endpoints when one never gets established
     - only once TCP closed the subflow, to read its reset flags safely
     - removed addresses, also the remote ones and the local ID 0: the dead
       subflows are marked in mptcp_pm_rm_addr_or_subflow(), instead of
       looking up the endpoint
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

 Documentation/networking/mptcp.rst |  11 +++
 net/mptcp/pm.c                     |  39 ++++++++++
 net/mptcp/pm_kernel.c              | 118 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c               |  27 +++++++
 net/mptcp/protocol.h               |  19 +++++
 5 files changed, 214 insertions(+)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index b6753ffb9c9a..0f07d4a29b6b 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -73,6 +73,17 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
 addresses can be used. This can be configured with ``ip mptcp endpoint`` for
 example.
 
+When TCP gives up on an established subflow initiated by the in-kernel path
+manager, after a retransmission or keepalive timeout, the path manager creates
+it again, with the ``subflow-retries`` limit as its number of SYN retries, like
+``TCP_SYNCNT``. A subflow reset by the peer, or by anything on the path, is not
+created again. TCP only gives up on a subflow after ``tcp_retries2``
+retransmissions, about 15 minutes by default: shorter outages are handled by
+TCP itself. A subflow that only receives data does not notice that its path
+stopped working: the application should then enable TCP keepalive on the
+MPTCP socket (``SO_KEEPALIVE``, ``TCP_KEEPIDLE``, ``TCP_KEEPINTVL`` and
+``TCP_KEEPCNT``), which MPTCP applies to all its subflows.
+
 Packet Scheduler
 ----------------
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..2bb08be95cd1 100644
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
@@ -762,6 +782,24 @@ static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 
+/* A subflow using a removed address must not be re-created, whatever its
+ * state, e.g. closed by TCP but not collected yet, see
+ * mptcp_pm_kernel_retry_check().
+ */
+static void mptcp_pm_rm_no_retry(struct mptcp_subflow_context *subflow,
+				 enum linux_mptcp_mib_field rm_type, u8 rm_id)
+{
+	u8 id;
+
+	if (rm_type == MPTCP_MIB_RMADDR)
+		id = READ_ONCE(subflow->remote_id);
+	else
+		id = subflow_get_local_id(subflow);
+
+	if (id == rm_id)
+		subflow->no_retry = true;
+}
+
 static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 					const struct mptcp_rm_list *rm_list,
 					enum linux_mptcp_mib_field rm_type)
@@ -794,6 +832,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			mptcp_pm_rm_no_retry(subflow, rm_type, rm_id);
 			if ((1 << inet_sk_state_load(ssk)) &
 			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
 				continue;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0379e1495cf4..4ee65aba1f13 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1610,6 +1610,124 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+/* TCP gave up on the path: a retransmission or keepalive timeout, possibly
+ * reported with an ICMP error received from the path.
+ */
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
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	/* Only once TCP closed it: the acquire in inet_sk_state_load() makes
+	 * sure sk_err and the resetting flag checked below are the ones of
+	 * this close.
+	 */
+	if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		return false;
+
+	err = READ_ONCE(ssk->sk_err);
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
+	/* Only a path that worked is tried again. If a subflow never got
+	 * established, the PM moves on to the next endpoints instead, and a
+	 * re-created subflow that cannot connect is not retried again: its SYN
+	 * retransmissions already spaced out the tries.
+	 */
+	if (!READ_ONCE(subflow->fully_established))
+		return false;
+
+	/* its address has been removed, see mptcp_pm_rm_addr_or_subflow() */
+	if (subflow->no_retry)
+		return false;
+
+	/* Only when the path stopped working. A reset, from the peer or from
+	 * anything on the path, means the path works: re-creating the subflow
+	 * right away could loop. Not after a reset by MPTCP itself either, with
+	 * mptcp_subflow_reset(), whatever sk_err says.
+	 */
+	if (!mptcp_pm_retry_path_error(err) || subflow->resetting)
+		return false;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return false;
+
+	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
+	retry->remote.id = READ_ONCE(subflow->remote_id);
+	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+		return false;
+
+	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
+	retry->local.addr.port = 0;
+	retry->local.addr.id = subflow_get_local_id(subflow);
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
+	subflow->retry = true;
+	release_sock(ssk);
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..5cee1ed788ca 100644
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
@@ -3494,6 +3499,26 @@ static void mptcp_check_listen_stop(struct sock *sk)
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
+		if (!subflow->retry || inet_sk_state_load(ssk) != TCP_SYN_SENT)
+			continue;
+
+		/* it never carried data: nothing to push or re-inject */
+		mptcp_pm_subflow_check_next(msk, subflow);
+		__mptcp_close_ssk(sk, ssk, subflow, 0);
+	}
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -3520,6 +3545,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_wr_shutdown(sk);
 	}
 
+	mptcp_close_retry_subflows(sk);
+
 	sk_stream_wait_close(sk, timeout);
 
 cleanup:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6d571328aca9..7e33ead76ee6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,8 @@ struct mptcp_subflow_context {
 	bool	close_event_done;   /* has done the post-closed part,
 				     * protected by msk socket lock
 				     */
+	bool	retry;		    /* re-created after an error, msk lock */
+	bool	no_retry;	    /* uses a removed address, msk lock */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u32	local_nonce;
@@ -1137,6 +1139,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
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
@@ -1258,6 +1272,11 @@ void __init mptcp_pm_userspace_register(void);
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

