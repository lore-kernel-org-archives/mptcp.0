Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019240;
	b=l2E5rp+XY0DIzniEjysIsXUZLPFg/mH2F6UUff5TCLs9QakBBfTDda4aDIwUgHvfb+vs
	 8IxjfaUJtXkf6X3/X6YpuQFbGiFy2oR/AIJUeWZ/yDjw2b8s0ZUBRN8HHdPPbZ+FqlSmT
	 12s83t5HJQXSvqW5PLvn2o6wCaSc6P8ouqigaN+YkVQ+5OuVO9ibi+VhpMMGSIqboiUgC
	 n62d0IfSMeNWImqYasHUMCF1AMsnuf7qszu6P6iAwIdb0yj21aJs5t34DSlFieYBV0UCh
	 jkDyooYeP2BV0IzMWuei64mUObGvp9fRF4xFckp/FK+78BjwJKhn9tHf+XTqOONZxwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4/Q1njHMfIpbXDt94CuhZMJcpDU2tZZHWJFRlFTKIz0=;
	b=qBkMrtxZ/sZvCrt1e1D9wDRyfuq0XMT3O743nblE0orpn7RLsWHslLyjBRPF+POOahi/
	 RDyBdSt+iF2MOEkvnFmYyJQ5d0V4CDim1KLqMBxsuPZuLBDfIXepyJ+FPSQwUmM0ABhst
	 5cDI9UzS6SA89kXeeh5uib8cwow0fjuwgAJtXPZsKDq0RAtj9ULsA4WNxycwDeGWE2Pi3
	 Z1FlZMuCfz67jbfe3pXNORmgm3mOzUaZTvfGGWfKdRakU2LNVO3ZOXiHxhSfbRpgxnH2z
	 vB/0/5MsuwXYV/jxN5XrzMoB38nsXho0jDnjxkuNsNaxKZd4ddkmKewbTMhnvPLiVjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcUj9BtS;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55273606A31D
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55273606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcUj9BtS
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so5338153eec.1
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019238; x=1793624038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/Q1njHMfIpbXDt94CuhZMJcpDU2tZZHWJFRlFTKIz0=;
        b=ZcUj9BtSwkxGVjX+tYRX2b6f2S5gp7fj87ME1Opbs8/qkfq2jhnldEVx2Wu0ZV6IGG
         VFOesqgB6DE5U/8KQbbM7tpHP5mFUegYNgspWcgSu0PfWjfPwfxEah0nyxttbU/eHIy/
         /Q0FIFVvEczUZWW2x/eu+g4E8Emj2scxWoMWasR6gMyjLLazfCkaReuWtZY9hncdc+h/
         trpgZYY9ZqgcCQv3rtqoEIr0W6OYr/xWGtphaFLW5YRmrwRzf2n4JfnJd7AbKnj3Jt1k
         TGpbwvbjtdLexVRigedgDB90rwxs4E/hQwRcrnYoc5Xnyr8+2de6fPjTgtQGBySWeYR/
         Gt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019238; x=1793624038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/Q1njHMfIpbXDt94CuhZMJcpDU2tZZHWJFRlFTKIz0=;
        b=ZZomfCU+HgduIl6u9c+6dXUDZCZJUbPRT8Oxc9QKTauvPeQhZX4ox3ezqA1igDqLV0
         0LP/mD3lw7/ZoMHk4AntUfCDcN+G7klydTwuUkVl1i6z87IP/pF4g4w+0H4qCVop1QRl
         1Xgwm3D3Qmm+Atmco3Mu6nkpgv7NqJLGBNAOg/b2Vt5fX07jss73JLi+jq3FuY5njY7y
         DdTwW0h9bKfIz3/lwpX4deIJooIhJfi+vvgzwH8OBmW626g3p2SqjkJR7FohYBh+bbuC
         Wnu25VTUxX2PIQPb7Tg5+dBoqxx1xWoz4RkgNX8mdrCYHVxRY9wNtI8YeoNa+tQ2VYtt
         gkUQ==
X-Gm-Message-State: AFq9FYK0gyQwO4O/yYvKUdX7/zGu1MY+qXnk3k+8xT3P1MwnJjZhj7wn
	hl6tV4zB0h4EfJVHuyw56GcVBZiBAvBbmKC1j3vz7G/5/yEyRLp1gS3XH+YKQQ==
X-Gm-Gg: AYBFou3jP5kB3skT5SNC4QGz97J9b+zovnl1r8hq0xTEFQOzVa9cVGkikKhQFZSfNmo
	yfKMt42hn/iuBRhyd1LphqcHxXIHRelTqMdnMbmIbN50PdfF16pmmz92EMlGfp+n96u7Q+Od6cD
	ZaNQi4H6QHInqUvN1hC1Bo5Z4j/CREsvrzQfLT4MvlEQGeSHmm2WKRkPGx8Tu5cYo7hJYR5EOT+
	BTF8bmYUehQblhu6CB89uLfnqq5wOTdV+td7o81SufrgbPy5M3Xa0bd5JdFMBoKDU569bVcjxGz
	N95jkUtKcenQcG0Ld04WmXn6b4gwGIQ3spyp/UoPzAyypbQQwqN+1c119afPHj0e37RrfMwmS/N
	O/LdSOGXfJlVEXMVK9rG0Chl7Kdy6Edoib9VdMOKLOzGx4mFKuLomb7VGI3VrSu6Ki/Kj0H9BwK
	k91jT9tN6o1PSiBfz3ZVnh84IRE1rwjj1UHCOgRVPP7A8lxvHwh21X8cMYRar+LzZU4rmjS8p+7
	+QL0kq4+mCNz5y4+wbCH8uf8nQiX7xbAbzIbu5x/oDakixgGoXs/hjkbI3F4241CPl9JvvHQwiX
	U0I3yBITSe4fptNnQnJpzieNJw4Be13m+PKn8E+HlG1bY9QJTO8l9f4DqUxq2vRJc/MzfnOfpeL
	9ral/QguEFD3ZeBh7TeQ11OHi
X-Received: by 2002:a05:693c:69db:b0:369:8d31:a902 with SMTP id 5a478bee46e88-369e836af38mr10478284eec.2.1793019237742;
        Mon, 26 Oct 2026 05:53:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm18377923eec.7.2026.10.26.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:53:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v11 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Mon, 26 Oct 2026 12:53:43 +0000
Message-Id: <20261026125345.3019372-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
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
meantime. This is only done while another subflow can send data:
otherwise the connection is closed after the close timeout, as before.
The re-created subflows not established yet are closed when no other
subflow can send data anymore, or when the MPTCP socket is shut down or
closed. Once it is established, it is handled like any other subflow.
Re-creating the initial subflow uses one of the additional subflows
allowed by the limits.

__mptcp_close_ssk() now always cleans the references to the closed
subflow in the MPTCP backlog, not only with MPTCP_CF_PUSH: a re-created
subflow closed with the MPTCP socket can get established in between.
The other paths without MPTCP_CF_PUSH have already purged the backlog.

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
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v11:
     - re-create a subflow only while another subflow can send data: the
       close timeout is then handled as before, no more re-arming nor
       stopping it (sashiko.dev)
     - close the re-created subflows not established yet from the worker,
       or when the msk is shut down or closed, never while iterating on
       the subflows: mptcp_close_ssk() only schedules the worker
       (sashiko.dev)
     - also close them once the msk is no longer established, whatever
       their TCP state, also when a DATA_FIN is handled outside the worker
       (sashiko.dev)
     - SUB_CLOSED event for them while the msk is established, like
       mptcp_close_ssk(): they can have been joined already
     - another subflow in CLOSE_WAIT, being closed, does not count as one
       that can send data
    v10:
     - keep the connection when the close timeout expires if a
       re-created subflow connected in the meantime: an active join
       does not stop the timer, mptcp_finish_join() returns early for
       it (sashiko.dev)
     - close the re-created subflows still connecting once the msk is
       no longer established, after a DATA_FIN or a shutdown(), when
       no other subflow is left: they cannot join anymore, and would
       keep the msk around (sashiko.dev)
    v9:
     - every timeout is retried, whatever ICMP error TCP reports for it,
       the last one received, see tcp_write_err(): resets, local aborts
       and MPTCP protocol errors are excluded instead of listing the
       timeout errors, so IPv4 and IPv6 behave the same (netdev Sashiko)
     - mptcp.rst: 0 does not re-create the subflows (netdev Sashiko)
     - the re-created subflows closed with the msk get no SUB_CLOSED
       event, like the other subflows closed with it
     - if no other subflow can send data, the close timeout still applies:
       creating the new subflow no longer keeps the connection open for
       the whole SYN retries
     - doc and commit message: a single connection attempt, ended by an
       ICMP error or a local connect error
     - __mptcp_close_ssk() always cleans the msk backlog of the closed
       subflow: a re-created subflow closed with the msk can have been
       established in between, with data in the backlog (netdev Sashiko).
       It is still closed without MPTCP_CF_PUSH, which would re-send all
       the pending data
     - tcp_sock_set_syncnt(), without the ssk lock
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

 Documentation/networking/mptcp.rst |  18 ++++
 net/mptcp/pm.c                     |  39 ++++++++
 net/mptcp/pm_kernel.c              | 141 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c               |  68 +++++++++++++-
 net/mptcp/protocol.h               |  41 +++++++++
 5 files changed, 304 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index b6753ffb9c9a..72a91aeed9c6 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -73,6 +73,24 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
 addresses can be used. This can be configured with ``ip mptcp endpoint`` for
 example.
 
+When TCP gives up on an established subflow created by this host, after a
+retransmission or keepalive timeout, the in-kernel path manager creates it
+again, with the ``subflow-retries`` limit as its number of SYN retries, like
+``TCP_SYNCNT``: 127 by default, about 4 hours, and 0 to not re-create it. This
+is done for the additional subflows, and for the initial one on the client side:
+the new subflow then takes one of the additional subflows allowed by the
+``subflows`` limit. This is a single connection attempt: an ICMP error, or a
+local error when connecting, ends it, and it is not created again. This is only
+done while another subflow can send data: otherwise the connection is closed
+after ``close_timeout``, as before, and the subflows being re-created are closed
+too. A subflow reset by the peer, or by anything on the path, is not created
+again either. TCP only gives up on a subflow after ``tcp_retries2``
+retransmissions, about 15 minutes by default: shorter outages are handled by TCP
+itself. A subflow that only receives data does not notice that its path stopped
+working: the application should then enable TCP keepalive on the MPTCP socket
+(``SO_KEEPALIVE``, ``TCP_KEEPIDLE``, ``TCP_KEEPINTVL`` and ``TCP_KEEPCNT``),
+which MPTCP applies to all its subflows.
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
index 7fb4c7874340..8c54edb1d5f7 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1610,6 +1610,147 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+/* TCP gave up on the path: after a retransmission, keepalive or user
+ * timeout, sk_err is ETIMEDOUT, or the last ICMP error received from the
+ * path, see tcp_write_err(). The other errors on an established subflow
+ * are not path failures: a reset, from the peer or from anything on the
+ * path (ECONNRESET, or EPIPE in CLOSE_WAIT, see tcp_reset()), a local
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
+/* Another subflow can send data, and is not being closed, e.g. in CLOSE_WAIT */
+static bool mptcp_pm_retry_other_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (__mptcp_subflow_active(subflow) &&
+		    inet_sk_state_load(ssk) == TCP_ESTABLISHED)
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
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed */
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
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
+	/* from 1 to MAX_TCP_SYNCNT, see mptcp_pm_kernel_retry_check() */
+	tcp_sock_set_syncnt(mptcp_subflow_tcp_sock(subflow),
+			    retry->syn_retries);
+	subflow->retry = true;
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..9a32c908ea98 100644
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
 
@@ -2697,8 +2701,11 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
-	if (flags & MPTCP_CF_PUSH)
-		mptcp_cleanup_ssk_backlog(sk, ssk);
+	/* also without MPTCP_CF_PUSH: a re-created subflow closed with the msk
+	 * can have been established in between, see
+	 * mptcp_close_retry_subflows()
+	 */
+	mptcp_cleanup_ssk_backlog(sk, ssk);
 
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
@@ -2788,6 +2795,39 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 }
 
+/* Re-created subflows not established yet are useless once the msk is
+ * closed or shut down, or no other subflow can send data, see
+ * mptcp_retry_subflows_stale(). Not called while iterating on the subflows.
+ */
+static void mptcp_close_retry_subflows(struct sock *sk)
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
+		/* like mptcp_close_ssk(): it can have joined already */
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    !subflow->close_event_done) {
+			subflow->close_event_done = true;
+			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
+				    GFP_KERNEL);
+		}
+
+		/* Checked without the ssk lock: it can have been established
+		 * in between. __mptcp_close_ssk() cleans its data in the msk
+		 * backlog, and the MPTCP retransmissions cover what it sent.
+		 * No need to push the pending data again.
+		 */
+		mptcp_pm_subflow_check_next(msk, subflow);
+		__mptcp_close_ssk(sk, ssk, subflow, 0);
+	}
+}
+
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
@@ -2806,6 +2846,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2823,6 +2869,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2834,7 +2882,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
@@ -3185,6 +3236,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
+	if (mptcp_retry_subflows_stale(msk))
+		mptcp_close_retry_subflows(sk);
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 
@@ -3516,6 +3570,9 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
+	/* before __mptcp_wr_shutdown() disconnects them */
+	mptcp_close_retry_subflows(sk);
+
 	if (mptcp_data_avail(msk) || timeout < 0 ||
 	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
@@ -4140,7 +4197,12 @@ static void mptcp_shutdown(struct sock *sk, int how)
 {
 	pr_debug("sk=%p, how=%d\n", sk, how);
 
-	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
+	if (!(how & SEND_SHUTDOWN))
+		return;
+
+	/* before the state change and __mptcp_wr_shutdown(), as on close */
+	mptcp_close_retry_subflows(sk);
+	if (mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4aa4aedb2ba7..245d3d24ae2e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -610,6 +610,8 @@ struct mptcp_subflow_context {
 	bool	close_event_done;   /* has done the post-closed part,
 				     * protected by msk socket lock
 				     */
+	bool	retry;		    /* re-created after an error, msk lock */
+	bool	no_retry;	    /* uses a removed address, msk lock */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u32	local_nonce;
@@ -919,6 +921,28 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
 }
 
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
+		    __mptcp_subflow_active(subflow))
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
@@ -1139,6 +1163,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
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
@@ -1260,6 +1296,11 @@ void __init mptcp_pm_userspace_register(void);
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

