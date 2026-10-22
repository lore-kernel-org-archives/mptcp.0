Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681906;
	b=pcmWfwuJ+u/XoCrSG6kvF1NgRgmXeZFxKll6/r5vLGe6kYuGhjCgsUXNuoOgV8HMKGKX
	 mUWz5n4X6UkKwtzbbqSPxqfjZii+3QhT05oLNDgdQ77wKOKPNhYk8Yar/ktVyyxwIQxjV
	 y4TLlIfugFNOqo8OTUwLADlQ+Ku/+M4Lfh5uGsKEqyRekS1vvcpY00h7xVbvUr/oEEsPD
	 oJf3Rrgn5lcpHu5eq1O9fMVxFv+IYD1pzpFQb2uw5h9pjxSaIVH7Tn0WCFwfbfrurPkK7
	 bvAz63fJk6cNWUGhblM95om1clKrL5S0SvgjOfYR62dRyfZsbY2FDk3BpKxxNPFr7TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yYbZNFG2Y4pfDECjgkStL8T+JiyAXajrP0vU/OTsOoA=;
	b=rmdDuTAMriF/j8MqB0CvpK4spl5DhnJPth96dr06zhG9wCbjpH3NolJvEDTmDUFkdc3g
	 lC+aIVdV44RPhWmzu4i4a9zTFsl7rgLBTnkiBfsfXwqEBI7LpKsYSi+E1LxVRefAbfLfE
	 M6lQrUQla2SXlebi2GNHBwXtrb9qdmkJWRQ8o8wF4z9Dv9ZWj6CpIk2InLswOatN+mnNx
	 at5HYcFqDkYlPiGaeET4pSLrWQCMRc4kq/aroVVTn9iMTICAVtWxhRwX2vvhUa/OW/m3c
	 L0Yr0zRHrJOhUlIdOua75AZN78lDnKO37kceC50s7Bo0DfkwoZdEkOku6bePjpXQgeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srt6f9Oo;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB660A6F66
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCB660A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srt6f9Oo
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3341394eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681905; x=1793286705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYbZNFG2Y4pfDECjgkStL8T+JiyAXajrP0vU/OTsOoA=;
        b=srt6f9OouBRq8Osi08ukc2XWDkYeS4ePgqxBDHixfSVS7KNWYR6K30Q7pGX8dHw2VB
         c00RCMeaPJEJWjmnUbm9OwyS2ZCpJA8JVkiOT4QJUoLzqMsgiLTtLKvN3Qj44yzI8Smq
         DXb/EASzkv0xGSmTqjNECK52UPUtmF85Uuiif5+OmSV225NEx/cUH46Y87DcqjUL1U7a
         xExhj8ZI1JVN0zMOoYXIxxTD5JUwD7SBWlg9ai7acz56aD5zmznHlT2qwc6qkrutEKjo
         e3keaDumZ5ZAGVJ6u3caE+dI5kgvogfE6G+1XVf3es9oQTpHL2gw4QUClEYVSU56UkAi
         g9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681905; x=1793286705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYbZNFG2Y4pfDECjgkStL8T+JiyAXajrP0vU/OTsOoA=;
        b=FxPCcDlvSwrfcLxs/AUlYCdvVQQAgnx26AV39PS2vi19d5o2ds1pe2Gnt+O/ohYRw6
         dqHlHGNnATTSe7ReckmnyxhdU/Kj7kzKDr9UY3zYYtGURC9ZA5Z8eGjUsZwgNxRyEnp3
         obVl9SvrYrldio37yCuycxWSvvs/7gdbYdj1mDaHxo401ONZ87dy5t4MXzrbNYliIeV/
         TL3iS+jB0/z7lfTgkO0rDX2xh9Wk5ift42hbe7/Js6ygGCfQ6q6Eh3JNizISDOu5X4l4
         4wf5YQ1CstX+i9zag5ebWPbdeLKwAG9GrqRywKSvzBEBMhATmYgT0SYUpyI0ytxpyM2+
         CNrQ==
X-Gm-Message-State: AFq9FYLbTryGA8xtq5+01nZLnf4fILGvpVKLwtkSwUJ7KMg8I4sGb+2N
	NUMBg7hZnhkWlFmZg4c0q8EDPlEtqxTt8Alj189as4FjT9pTCuFZR4SImIpNtg==
X-Gm-Gg: AYBFou0chmsbZ7J7IhCZdT1wRE9h9iUwQ+Cf2oA7ypGQamD1GZKX1+4xmOVlb3ahJKN
	Juest6YkbiyQf1CCbreGiQHCDJDIVVnK4PCa4xkF8znqe6IpGk3zMwRIrjighaUDYVPSAVN1728
	/oQ+5mEt69cQRittfc+nIGZe86Nf7U+y5NTksA1A+UzZmbAR+AazjBRzPZaHhI1kTBV0x5SQ+Up
	7zclvfWmAUCdevUsTSX9U0zjtSHKmb1OGOUSm2bZgeSmkniCRfdn/C1eYDMzyKhj4OwnNlUbuYw
	7j6B0/25qnbS6uJ3E5MFFNPngNillnVinbx28M4XL4AxmZ7F0JkYBhGpvkYrgZPf7DnJ5z7muhd
	lz6A1AzO8HUYGIP6kc2fD9BrCEfpmyZxNOsQMhMYdRdqVdYX3GiYMKW3BAfEaMUHs1Uorw2NKEB
	wq3fMWGiRj/0W7vOVATSy2lFASMQcytpPYvHkZ48VL96OXZuamDjrIpnLpemv8ubTmSGm0z4yhY
	frjxa6myvLgMYL0iaXCpTyz/1h6qWfEf6FhLYZwRq5RJ30IdZOsHnAtfOjiUTJhfIoVtvGZXHVF
	eeqlOfu+hqa4IbkPSWG1dliAiAi6HcNJmBXQIuMYZV9X0iW9GhblRE5UvFSxZtFlfsyTirFEPne
	tPgwH5S1D9kT30fIQ9xMffmhx
X-Received: by 2002:a05:7300:c00b:20b0:35c:ba31:6fef with SMTP id 5a478bee46e88-3674f21af3amr8416833eec.36.1792681904376;
        Thu, 22 Oct 2026 08:11:44 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:43 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Thu, 22 Oct 2026 15:11:28 +0000
Message-Id: <20261022151130.2285198-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
    v8:
     - mptcp.rst gives the default, 127, about 4 hours
     - close the re-created subflows still connecting before
       __mptcp_wr_shutdown() disconnects them, and also the already
       disconnected ones, e.g. after shutdown(SHUT_WR) (sashiko.dev)
     - mptcp.rst: the initial subflow on the client side, the subflows
       limit, and only one attempt (netdev Sashiko)
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

 Documentation/networking/mptcp.rst |  14 ++++
 net/mptcp/pm.c                     |  39 ++++++++++
 net/mptcp/pm_kernel.c              | 118 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c               |  36 +++++++++
 net/mptcp/protocol.h               |  19 +++++
 5 files changed, 226 insertions(+)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index b6753ffb9c9a..62f2e6dd8584 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -73,6 +73,20 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
 addresses can be used. This can be configured with ``ip mptcp endpoint`` for
 example.
 
+When TCP gives up on an established subflow created by this host, after a
+retransmission or keepalive timeout, the in-kernel path manager creates it
+again, with the ``subflow-retries`` limit as its number of SYN retries, like
+``TCP_SYNCNT``: 127 by default, about 4 hours. This is done for the additional
+subflows, and for the initial one on the client side: the new subflow then takes
+one of the additional subflows allowed by the ``subflows`` limit. If it cannot
+connect, it is not created again. A subflow reset by the peer, or by anything on
+the path, is not created again either. TCP only gives up on a subflow after
+``tcp_retries2`` retransmissions, about 15 minutes by default: shorter outages
+are handled by TCP itself. A subflow that only receives data does not notice
+that its path stopped working: the application should then enable TCP keepalive
+on the MPTCP socket (``SO_KEEPALIVE``, ``TCP_KEEPIDLE``, ``TCP_KEEPINTVL`` and
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
index 67bf421d117b..23e8af94b1a4 100644
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
index 60cbd91be632..272bf2beac53 100644
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
@@ -3494,6 +3499,34 @@ static void mptcp_check_listen_stop(struct sock *sk)
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
+		int state;
+
+		if (!subflow->retry || READ_ONCE(subflow->fully_established))
+			continue;
+
+		/* still connecting, or already disconnected by
+		 * mptcp_subflow_shutdown(), e.g. after shutdown(SHUT_WR)
+		 */
+		state = inet_sk_state_load(ssk);
+		if (state != TCP_SYN_SENT && state != TCP_CLOSE)
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
@@ -3509,6 +3542,9 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
+	/* before __mptcp_wr_shutdown() disconnects them */
+	mptcp_close_retry_subflows(sk);
+
 	if (mptcp_data_avail(msk) || timeout < 0 ||
 	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
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

