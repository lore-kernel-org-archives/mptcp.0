Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308491;
	b=Ad06TdnozKyKShw9BmOBKEYT8dIxKNUSLr0tl8G+iVxoYUwPytzcOhagGq+BQe+Q3jDL
	 z7iGcJN/w7GN2LsGoLq2BZUw9NOrD34EpD8Mgu45/tMl5bBCr6FSnWYAKFl52estsAIO/
	 UoTuKM1AegTu19otGxWf/eyUdC87CVb0xoQUZCh/FHMxRdZZfOX/gIzAGAqdo6E/N+aHy
	 v34PtQXbg8jtY1i64HvO4FH3hPUQkz9Iu5yR0c4uPZ/6PMg9pytlMYci9acX99TvhQ8wX
	 3IhcIJjXIPBCiodcRJfFOgK16Cznv4C5KWksJpgcoZf7Mpb61zh9Z6JhFZWyIvBzaUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m/m7ms5f+CeSzGneNyOtF/exugNyvdFI4i9fdzJMBaE=;
	b=MudGNxo+6zxVDrK08sI6Z1ViNvrujJ+ywlfi43U52JPyadPna2MyCJ/JVbHlVJOYmDKC
	 cOU7wbQJaMSAHI7qSInYgVaXjYjOigrwxqG3uW8iFJUPhrmfuZCeW3RRgwqr8aXIuSxai
	 bw2bAiw6e2GHF9cdCmIYRWUbUm5OIsntvv32atLnB5t2OAxfKY5Xe31PThK9odR+wy4lX
	 MdFkRiGizLLjPIGTRKloWUA/g9hNcUjh2gyyRfvIdjLe7FJIURIZoExIX9/vvbpJlRgkW
	 WQfTm+Awp0+OwUCcGGTjinqfeaiyHEhY8CumYsPHrfNnkeTKUr2S8zoD7rT2JEE490Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oMIadUSK;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFF606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56BFF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oMIadUSK
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38190551625so4335609eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308489; x=1795913289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/m7ms5f+CeSzGneNyOtF/exugNyvdFI4i9fdzJMBaE=;
        b=oMIadUSK2N/MdD61ECG5/zwlfjW3x4qc93peibO2IpR+vMaifjmuzTLrL30yMr0r+W
         a4bqEhyJHpaeP4sjC+voPMxzbCxKQdfrBoey0ynmeofTkR871nkirA1thHEowSsg2Z7f
         j/hfUQzlI46yWnQcWL+7kgtjBPPi7oa3Tx0bkCEHSZd8hI8ccx05/h+ciJTbOWhW/s+F
         YZepZg82yYRqhqN4n+jySHJuMw/1q6RgkSpVpCsKDdb5NX9mmthD1cvIaIb+Ctau0QBv
         v6nGxGLCxzccFJNrPqr0NRMJtzfcf2CydEgnlzDmCspbIjfHR224UYt3zN4z1hTVCujp
         iU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308489; x=1795913289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/m7ms5f+CeSzGneNyOtF/exugNyvdFI4i9fdzJMBaE=;
        b=X7hvMgQJ717rKlZJMPprBlV7GUlkBC17k3tqHJzH7ihEpPpniSlCPQH+LL6W9BNDJm
         SLqBVXqfhqELmxMFrVaoIQvumGvghmT3kkFMylMV3zqQpnHAWkXg9JDKqXzepE7hgu/p
         OK3pgTu0Tunx1pfYivQHeErrcSNUz+U8TPu4W8OhtLOfTUKtvCGZmNRtsSy6tEZ+7Hs7
         5mx/w2N5FNEvIgfQ1XR/A8qRa0+F1UNiEJQPRcOvAN11Qg5awBl+HrRJK7c6wHshGJZy
         vjtTTAg4m3sWgbWAsNM6kloZzP9r4esKBGJRd94UyAfpRMlh7w8OzdeHiDcokcQMVTdE
         LdmA==
X-Gm-Message-State: APuU4Z8Z89RfOk/no6LK/ucxy+8NlKFrztpqNw8ZJ3XTH4tSht96HG7J
	CboNjTEYgwLXmUyAdtsKEMHFoypiIQr1MVVms3kTJn1A7dFpmb8o+otyvpG/9A==
X-Gm-Gg: AZFdTZdt/mHCpNoYnWIoTCSwj6GDwmxeYlWHq0rKQmugbelM25+vb47ac/ZhbcCcVDt
	VYxviCle0ceSB3wtcs/FPLR5+3aqyfb0oKb1mD2IZYMsxrgmqEXgprD1ot1e25vDBS0E9RGEDvW
	+OaHpQsntNx3Aq65UKclJM1oi68sJ00zINwXfXcpBLF69x8FlzYDJ+Pk3/nhfzoustWIDQJBfIf
	1DHNIizV1FWchbP3ixocsPY+HAd19Tqd6c5Fp4XdLaANTn/DrZIK+038IN/pCHHHkOq1ovfaGXz
	JI33+4yHt5SkPznCal+coxtsQyxnBgu/ICjSZ3RELtAj01k9bT9gAzprE37NnYV52db3w4Cus4o
	BJTirxzic/1KtA01syvIp961DNjEeyVll2qs27YT//YcPhwXFLyao0Q1b+zOPPy6taN3PJX8Y3S
	yv34bUP9C28nKSH7hyryFB+VkJLeu7EE1iq5jSycLEsKe9nMc86Pn09ktYm6zWD9+BYkf3jFLDd
	KkF8hCktP2EZ1dkVXXUecSe1BQlqZQkeG1L37r5vh8VnTDphXSfXFzIwufbIQh1QOUmBTbPNMU2
	5nAlK36xcwnO17SnqnuD/l+tmfn9bILeJUitB/C50FgWvZMMkW7xW6y2p7DfpEOQ76OesIxz1zH
	4ftv8CBa1YodokSr9xokRD6zBEAl4d4d87w8U7WzSkGY5vaHbKPjQsEDlPkhb3r5jinxZe+E5K1
	cLMDQjXEEDVeL7cyTg1bU=
X-Received: by 2002:a05:693c:895b:10b0:385:cf42:9b98 with SMTP id 5a478bee46e88-385cf429dcfmr7005562eec.34.1795308488884;
        Sat, 21 Nov 2026 16:48:08 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:08 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 5/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun, 22 Nov 2026 00:47:52 +0000
Message-Id: <20261122004754.2276802-6-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
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
a retransmission or keepalive timeout, whatever ICMP error was received
from the path before, the PM now creates a new one with the same
addresses. Its SYN retries, set like TCP_SYNCNT by the subflow-retries
limit, space out the attempts. This is a single connection attempt: an
ICMP error, or a local error when connecting, ends it, and it is not
retried again. It is also closed if the MPTCP socket is closed in the
meantime. This is only done while the connection is established and
another subflow can send data: otherwise the connection is closed after
the close timeout, as before. The re-created subflows not fully
established yet are closed when no other subflow can send data anymore,
when the connection is no longer established, e.g. after a DATA_FIN from
the peer, or when the MPTCP socket is shut down for writing or closed,
unless they got fully established in between. A closed one gets an
MPTCP_EVENT_SUB_CLOSED event while the MPTCP socket is established, like
a join that fails. Once it is established, it is handled like any other
subflow. Re-creating the initial subflow uses one of the additional
subflows allowed by the limits.

A subflow reset by the peer, or by anything on the path, is not
re-created: the path works, and re-creating it right away could loop. A
subflow that never got established is not re-created either: the PM
keeps trying the next endpoints, as before. A re-created subflow takes
the place of the closed one in the subflows limit: while it is
connecting, an endpoint not used yet is only tried if the limit allows
one more subflow, or if the new subflow cannot be created. Subflows
aborted locally, also by MPTCP, or using an address that has been
removed are not retried.

TCP only closes a subflow after a retransmission timeout set by
tcp_retries2, about 15 minutes by default. A subflow that only receives
data never gets an error: the application has to enable TCP keepalive on
the MPTCP socket, which MPTCP applies to all the subflows. Both are
documented in mptcp.rst. So is the case of a peer that only receives
data: it can still count the old subflow, and if its subflows limit is
then reached, it rejects the new one, which is not retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 Documentation/networking/mptcp.rst |  26 +++++
 net/mptcp/pm.c                     |  50 +++++++++
 net/mptcp/pm_kernel.c              | 160 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c               |  77 +++++++++++++-
 net/mptcp/protocol.h               |  51 +++++++++
 5 files changed, 363 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index b6753ffb9c9a..da978ef92726 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -73,6 +73,32 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
 addresses can be used. This can be configured with ``ip mptcp endpoint`` for
 example.
 
+When TCP gives up on an established subflow created by this host, after a
+retransmission or keepalive timeout, the in-kernel path manager creates it
+again, with the ``subflow-retries`` limit as its number of SYN retries, like
+``TCP_SYNCNT``: 127 by default, about 4 hours, and 0 to not re-create it. This
+is done for the additional subflows, and for the initial one on the client side:
+the new subflow then takes one of the additional subflows allowed by the
+``subflows`` limit. It keeps this place while it is being created again: an
+endpoint not used yet is only tried if the ``subflows`` limit allows one more
+subflow, or if the new one cannot be created. The initial one is not created
+again if the peer does not accept joins to its initial address. This is a single
+connection attempt: an ICMP error, or a local error when connecting, ends it,
+and it is not created again. This is only done while the connection is
+established and another subflow can send data: otherwise the connection is
+closed after ``close_timeout``, as before, and the subflows being re-created are
+closed too, as they are once the connection is no longer established, e.g. after
+a DATA_FIN from the peer. A subflow reset by the peer, or by anything on the
+path, is not created again either. TCP only gives up on a subflow after a
+retransmission timeout set by ``tcp_retries2``, about 15 minutes by default:
+shorter outages are handled by TCP itself. A subflow that only receives data
+does not notice that its path stopped working: the application should then
+enable TCP keepalive on the MPTCP socket (``SO_KEEPALIVE``, ``TCP_KEEPIDLE``,
+``TCP_KEEPINTVL`` and ``TCP_KEEPCNT``), which MPTCP applies to all its subflows.
+The peer must also have room for the new subflow: if it only receives data, it
+can still count the old one, and if this reached its ``subflows`` limit, it
+rejects the new one, which is not created again.
+
 Packet Scheduler
 ----------------
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..2772b97303bf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -694,6 +694,37 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
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
+	struct sock *sk = (struct sock *)msk;
+
+	if (!mptcp_pm_is_kernel(msk) || mptcp_pm_kernel_retry(msk, retry))
+		return;
+
+	/* Not re-created, e.g. a local error when connecting: its slot is free
+	 * again, try the next endpoints, like mptcp_pm_subflow_check_next().
+	 */
+	spin_lock_bh(&msk->pm.lock);
+	if (mptcp_is_fully_established(sk) &&
+	    mptcp_pm_nl_check_work_pending(msk))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -762,6 +793,24 @@ static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
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
@@ -794,6 +843,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			mptcp_pm_rm_no_retry(subflow, rm_type, rm_id);
 			if ((1 << inet_sk_state_load(ssk)) &
 			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
 				continue;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index f9ec8dc26b34..ef53043baca2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1586,6 +1586,166 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+/* TCP gave up on the path: after a retransmission, keepalive or user
+ * timeout, sk_err is ETIMEDOUT, or the last soft error, e.g. an ICMP error
+ * from the path, see tcp_write_err(). The other errors on an established
+ * subflow are not path failures: a reset, from the peer or from anything on
+ * the path (ECONNRESET, or EPIPE in CLOSE_WAIT, see tcp_reset()), a local
+ * abort (ECONNABORTED), or an MPTCP protocol error (EBADMSG).
+ */
+static bool mptcp_pm_retry_path_error(int err)
+{
+	switch (err) {
+	case ECONNRESET:
+	case EPIPE:
+	case ECONNABORTED:
+	case EBADMSG:
+		return false;
+	}
+
+	return true;
+}
+
+static bool mptcp_pm_retry_other_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_can_send(subflow))
+			return true;
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
+	/* Only while another subflow can send data: without one, the
+	 * connection is closed after the close timeout, as before, see
+	 * __mptcp_close_ssk().
+	 */
+	if (!mptcp_pm_retry_other_subflow(msk))
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
+	/* The slot of an additional subflow is released when it is closed: keep
+	 * it for the new one, a join from the peer could take it before.
+	 */
+	retry->keep_slot = subflow->request_join;
+	if (retry->keep_slot) {
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.extra_subflows++;
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed:
+ * true if a new subflow has been created
+ */
+bool mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool allowed;
+	u8 limit;
+
+	spin_lock_bh(&msk->pm.lock);
+	limit = mptcp_pm_get_limit_extra_subflows(msk);
+	if (retry->keep_slot) {
+		/* the limit can have been lowered in the meantime */
+		allowed = msk->pm.extra_subflows <= limit;
+		if (!allowed)
+			__mptcp_pm_close_subflow(msk);
+	} else {
+		/* the initial subflow takes one of the additional subflows */
+		allowed = msk->pm.extra_subflows < limit;
+		if (allowed)
+			msk->pm.extra_subflows++;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* on error, the slot is released, see __mptcp_subflow_connect() */
+	if (!allowed ||
+	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
+		return false;
+
+	/* the new subflow is the last one */
+	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
+				  node);
+	/* from 1 to MAX_TCP_SYNCNT, see mptcp_pm_kernel_retry_check() */
+	tcp_sock_set_syncnt(mptcp_subflow_tcp_sock(subflow),
+			    retry->syn_retries);
+	subflow->retry = true;
+	return true;
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a264a23c53d6..dc8a3357b8c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -736,6 +736,10 @@ static void mptcp_check_data_fin(struct sock *sk)
 		if (!__mptcp_check_fallback(msk))
 			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
+
+		/* not always called from the worker, which closes them */
+		if (mptcp_retry_subflows_stale(msk))
+			mptcp_schedule_work(sk);
 	}
 }
 
@@ -2639,6 +2643,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
+#define MPTCP_CF_RETRY		BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2697,6 +2702,26 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 * subflow close.
 	 */
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+
+	/* a re-created subflow, see mptcp_close_retry_subflows(): the ssk lock
+	 * defers the 4th ACK, so it cannot get fully established meanwhile
+	 */
+	if (flags & MPTCP_CF_RETRY) {
+		if (READ_ONCE(subflow->fully_established)) {
+			release_sock(ssk);
+			return;
+		}
+
+		/* like mptcp_close_ssk(): it can have joined already */
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    !subflow->close_event_done) {
+			subflow->close_event_done = true;
+			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
+				    GFP_KERNEL);
+		}
+		mptcp_pm_subflow_check_next(msk, subflow);
+	}
+
 	subflow->closing = 1;
 
 	if (flags & MPTCP_CF_PUSH)
@@ -2790,6 +2815,34 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 }
 
+/* Re-created subflows not established yet are useless once the msk is
+ * closed or shut down for writing, or no other subflow can send data, see
+ * mptcp_retry_subflows_stale(). Not called while iterating on the subflows.
+ */
+static void mptcp_close_retry_subflows(struct sock *sk, bool stale)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!subflow->retry || READ_ONCE(subflow->fully_established))
+			continue;
+
+		/* another one got established in the meantime */
+		if (stale && !mptcp_retry_subflows_stale(msk))
+			break;
+
+		/* Checked again under the ssk lock: it is kept if it got fully
+		 * established in between. Otherwise, it has no data in the msk
+		 * backlog, and the MPTCP retransmissions cover what it sent. No
+		 * need to push the pending data again.
+		 */
+		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_RETRY);
+	}
+}
+
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
@@ -2808,6 +2861,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
 
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
+
+	/* the caller can iterate on the subflows: the worker closes the
+	 * re-created ones
+	 */
+	if (mptcp_retry_subflows_stale(mptcp_sk(sk)))
+		mptcp_schedule_work(sk);
 }
 
 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
@@ -2825,6 +2884,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2836,7 +2897,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
@@ -3188,6 +3252,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
+	if (mptcp_retry_subflows_stale(msk))
+		mptcp_close_retry_subflows(sk, true);
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 
@@ -3519,6 +3586,9 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
+	/* before __mptcp_wr_shutdown() disconnects them */
+	mptcp_close_retry_subflows(sk, false);
+
 	if (mptcp_data_avail(msk) || timeout < 0 ||
 	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
@@ -4143,7 +4213,12 @@ static void mptcp_shutdown(struct sock *sk, int how)
 {
 	pr_debug("sk=%p, how=%d\n", sk, how);
 
-	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
+	if (!(how & SEND_SHUTDOWN))
+		return;
+
+	/* before the state change and __mptcp_wr_shutdown(), as on close */
+	mptcp_close_retry_subflows(sk, false);
+	if (mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 805d9cccb4d6..4a16707ca368 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -612,6 +612,8 @@ struct mptcp_subflow_context {
 	bool	close_event_done;   /* has done the post-closed part,
 				     * protected by msk socket lock
 				     */
+	bool	retry;		    /* re-created after an error, msk lock */
+	bool	no_retry;	    /* uses a removed address, msk lock */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u32	local_nonce;
@@ -933,6 +935,37 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
 }
 
+/* Can send data, and is not being closed, e.g. in CLOSE_WAIT */
+static inline bool mptcp_subflow_can_send(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return __mptcp_subflow_active(subflow) &&
+	       inet_sk_state_load(ssk) == TCP_ESTABLISHED;
+}
+
+/* Re-created subflows not established yet, while no other subflow can send
+ * data, or once the msk is no longer established: they cannot join anymore,
+ * see mptcp_finish_join(), or must not keep the connection open.
+ */
+static inline bool mptcp_retry_subflows_stale(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool retry = false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    mptcp_subflow_can_send(subflow))
+			return false;
+
+		retry |= subflow->retry &&
+			 !READ_ONCE(subflow->fully_established);
+	}
+
+	return retry;
+}
+
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
@@ -1153,6 +1186,19 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+
+struct mptcp_pm_retry {
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			syn_retries;
+	bool			keep_slot;
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
@@ -1274,6 +1320,11 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry);
+bool mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
-- 
2.25.1

