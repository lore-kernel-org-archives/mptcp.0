Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336862;
	b=WonxmFNf8HAsVY8zCs/CZ8MFRyCZVcf86uf36bsvq0HLXoALUQCFtwL9GB3m6SWniFIV
	 O/3I8Eq71xw9rsXBXHl7xTCf5EmiFJqUqe1K1i6bt4wOAbttECirjZnqpWYiSSOr7L53t
	 EZm4Owkvz8ElJ+sXlBMXEr3QLVcl8JRyzA0xN0d2IhIxOvYNv7ZovyYEgOAi6qrRMb6sS
	 5wdgEg9T7YctFD2s9343P2z/t5xHJFyLeAHymeottcB9ccjWB4ZXR5rdYmTOyvE/vn0NP
	 BBvbvt2+/7oq606lYKKnNPF8/4bjwg4vRoZ5hvQt43l+x+pqsh87SE/bslkMj6YiN4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+0+Q1Wn5ZkOJjk1DObUihLoQRiZ7BLC/vng+yUAHMt4=;
	b=qZvcf/3FzUCYZTON1HPViDgRZByvr6SrxxhPzplKm/h5+6CM/TPFJlmOV5ZbSY2JkORf
	 Qt2+Mvg7CVpePCgpaOCZMfOMbugl17bArJC2HTZgxrcnjc7OUDRkxsByQtlqVbzumCvRQ
	 oSm7vG4VR4EBVVdoMTuk0VuBxeNpjmy+13LLSf7l9nS7ukA3aXWt8OzylGEGFC9u5jRLr
	 HYYLcqeVH0QleLPK6HSiv3VSp7vYkkIQk6G+bpFE0yIBicwadqdcKf9VuTw/U48KCcK4N
	 Qm1ENziIAJCBZsYgEvPWtV4A4z/R+51bYKZaA7kD6srZtLWfBck0yY/9ZwwJtmdH3mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoEnsDC5;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92D606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E92D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoEnsDC5
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2761c69fbso788432c88.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336860; x=1793941660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0+Q1Wn5ZkOJjk1DObUihLoQRiZ7BLC/vng+yUAHMt4=;
        b=VoEnsDC5rJa6VUSyHz7wIRV8MO3OjeETEs77m1QOaU9x7P0OkcINRDjiAgMl4CFEH5
         ZEaU83JR24XPkSo9MWEYavsCK9S002tHtVU2uFYUBw384/tx4FuJnEMJX7l7A/rfsoHm
         9CSpe1HavffhSFWntWOsLdpsFic/hE2cLlGXW39ca74wls2lzFnsJdFwyFk3lOGHjMsN
         2kIacgGVxWvNFuo7hN4MjnJElBjnYGLezKVPNy+hdkYWbzB18n/op0/2cH5YIDpDuB45
         IowqVo0ig7Im+vPiLX0ewBSg/QyeCK6+w86GhDQqfkTFu9ll2Yq/bZ6dm8cSCunhCTpr
         VJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336860; x=1793941660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0+Q1Wn5ZkOJjk1DObUihLoQRiZ7BLC/vng+yUAHMt4=;
        b=F1jH4R4A49NdqH7V/0b0j0Unal5katW+mlaMOBAMXlBhKwL8zy3g64BJWe8lQxxnAP
         TelWzbuIaQIoEBGi/5inwUh9TK5A5IF8n8OunvOcyDAjbVllDdJKR+60fdYM0XYwiE1x
         QhwLbBlmwCC8Ej8jLscQ0WcvzhpnYBIclsPFH3t3opxnYMVx08Bcu4ic7GTD+m6qef/+
         PnH+GbaRJeWygJ0bZ9/yOTcgRYo1rt/kRZ32Yw4OdclJt8r+Adn15LBwyJBs5ZyFr/5S
         KYH1J0b46TR4zkEQrtnneS0bwfJb14ebPwC1ypnl/R68GWW4ZNXKaf/Ge/WaGIy0aVtP
         at9g==
X-Gm-Message-State: AFq9FYL2ZsL62lJ66jwudI/4wYhkLX9QW0+51RmnZoeu0PR/OzN8pzLS
	zXfL19o4JUatFv5J0r9qzqpzYX7xbWux5DKPtN+sa0ox7SXoCC1ETKep2rM9TA==
X-Gm-Gg: AYBFou0uXwvzmjmhEYt32VYbOYtZMJTtOXPkB5N7PuHnlPLyQKfcNU32PoTHsVU93dP
	3oejUpQZAnIHm5pOtqr5X/Ob4h/1uuFciqhH0187mhB24lJwwlnoIt5ZjPslrl8bQlFsQrRJnZY
	y0hWCdGvCjGBi5VmZBrDErGZxUWgY2D4n/jTLuUCQByk31RH198xbSniHBNL+RXF6CrEHiChekd
	G9+KATV/on58SwUIvCXtj3YbhTRdQj9WGYWJM3CPfZvPI5vd6oRoF7xMWzKN4sd7a771vNLH3qY
	TVnfDKrZi+76OSZEcghfUgBbTQkvOAdbNNhL9zuULaZgLAakYh4R1QlV/GLfUAgblJVkS7/8JpB
	ElRKU6WG+B3aGB2AQUad/KQET8Lrp2DipfgBM7e7wz63PnDS5XV2ix7cfxt3fYcFLzaZcHdyNar
	bLuD8RSn7g/n9/FInYbU2thxDy4CPgFa019RcR7529dz+0ESU8PxgY6A2+lw61yIFMhTeNJ+BfJ
	d18JluVI/3Wug3oL3z1xiOtpl3kGzAi1o00z3uy5cCJMak0bKmCcHxTUHEN41Ksb/8dRwoXXG7s
	UOqpGTFhSGfmSIY6XImAXa9awIgJ3TbFtOWDybASrzxfMm+kC2BRip67a+PS2gqtBv/f0/VTLbL
	KyFtDzmTwG4hCi2OxBYxzQTp2YDE2Fm4oW0lMgF+DdNg4Zd+m54N+ybYe2ms/E6jRZLaDXHSuFA
	==
X-Received: by 2002:a05:701b:428f:10b0:19b:98bc:326f with SMTP id a92af1059eb24-1ac5aa5d85bmr1959005c88.18.1793336860018;
        Thu, 29 Oct 2026 22:07:40 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:39 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Fri, 30 Oct 2026 05:07:25 +0000
Message-Id: <20261030050727.3534304-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
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
The re-created subflows not fully established yet are closed when no
other subflow can send data anymore, or when the MPTCP socket is shut
down for writing or closed, unless they got fully established in
between. A closed one gets an MPTCP_EVENT_SUB_CLOSED event, like a join
that fails, also when the MPTCP socket is closed. Once it is
established, it is handled like any other subflow. Re-creating the
initial subflow uses one of the additional subflows allowed by the
limits.

A subflow reset by the peer, or by anything on the path, is not
re-created: the path works, and re-creating it right away could loop. A
subflow that never got established is not re-created either: the PM
keeps trying the next endpoints, as before. A re-created subflow takes
the place of the closed one in the subflows limit: while it is
connecting, an endpoint not used yet is only tried if the limit allows
one more subflow. Subflows aborted locally, also by MPTCP, or using an
address that has been removed are not retried.

TCP only closes a subflow after tcp_retries2 retransmissions, about 15
minutes by default. A subflow that only receives data never gets an
error: the application has to enable TCP keepalive on the MPTCP socket,
which MPTCP applies to all the subflows. Both are documented in
mptcp.rst.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v13:
     - close again all the re-created subflows not fully established
       when no other subflow can send data, not only the ones still
       connecting: a joined one waiting for the 4th ACK could keep the
       connection open forever (sashiko.dev)
     - __mptcp_close_ssk() checks fully_established again under the ssk
       lock, and keeps a subflow that got fully established in between
       (netdev Sashiko on v11)
     - say that a re-created subflow keeps its place in the subflows
       limit, before an endpoint not used yet (netdev Sashiko on v12)
     - __mptcp_close_ssk() cleans the msk backlog only with
       MPTCP_CF_PUSH again: a re-created subflow it closes is not fully
       established, so it has no data there
     - say that only a shutdown for writing closes them, and that they
       get a SUB_CLOSED event
    v12:
     - when no other subflow can send data, only close the re-created
       subflows still connecting: a joined one is fully established
       soon, and stop once one got established (netdev Sashiko)
     - a subflow in CLOSE_WAIT does not keep the re-created ones open
       either: one helper for both checks (netdev Sashiko)
     - mptcp.rst: the initial subflow is not re-created if the peer
       does not accept joins to its initial address (netdev Sashiko)
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

 Documentation/networking/mptcp.rst |  21 +++++
 net/mptcp/pm.c                     |  39 ++++++++
 net/mptcp/pm_kernel.c              | 137 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c               |  77 +++++++++++++++-
 net/mptcp/protocol.h               |  50 +++++++++++
 5 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index b6753ffb9c9a..0d8fac8813a9 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -73,6 +73,27 @@ To be able to use multiple IP addresses on a host to create multiple *subflows*
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
+subflow. The initial one is not created again if the peer does not accept joins
+to its initial address. This is a single connection attempt: an ICMP error, or a
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
index 7fb4c7874340..f06b24a9cd53 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1610,6 +1610,143 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
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
index 02a4f479d9d8..cb1350ba1a41 100644
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
 
@@ -2637,6 +2641,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
+#define MPTCP_CF_RETRY		BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2695,6 +2700,26 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2788,6 +2813,34 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2806,6 +2859,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2823,6 +2882,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2834,7 +2895,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
@@ -3185,6 +3249,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
+	if (mptcp_retry_subflows_stale(msk))
+		mptcp_close_retry_subflows(sk, true);
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 
@@ -3516,6 +3583,9 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
+	/* before __mptcp_wr_shutdown() disconnects them */
+	mptcp_close_retry_subflows(sk, false);
+
 	if (mptcp_data_avail(msk) || timeout < 0 ||
 	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
@@ -4140,7 +4210,12 @@ static void mptcp_shutdown(struct sock *sk, int how)
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
index 4aa4aedb2ba7..f160e9ac7892 100644
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
@@ -919,6 +921,37 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
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
@@ -1139,6 +1172,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
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
@@ -1260,6 +1305,11 @@ void __init mptcp_pm_userspace_register(void);
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

