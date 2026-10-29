Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256348;
	b=Hd48mt577qy4pw1yEEcVu04AlswHdyoNywwFqjHBh1bhDgz68g68+T6K3vrjrh/TXAr5
	 DPMh5tun/8Mv0CBNrITLtaKwWLijMGuCJNWwCNshj92oJuDlZcY8aUY+781Ozt2eS2PwO
	 a8/p/vc/BzclEzAQEqtNsLMKEryG01ZFeFeNU84Y44gi4Ehs2I8SSZf4FUs7X+8cFQMjf
	 Ynqd2rO6qBAU8RwK06Dve0u7HDN4C84nrUO976DRiYoAGxzftGX/16fz0VofET/y3Z6p9
	 u5rGh4tPxnixxUbbsMUxNcuVcjT///5dUTxbgtK0S24EW4b1lkvJ5rJhozFC4J2XTWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7PL87XUQ4G+5QOOQ/bdzXhoGzC0EKcuiuqHTLJ+UPQ=;
	b=oJ7FcxHKZpa1b/QQrRgYxnOovh9pkAt9OQQ6mfcWOoLurhiCb7WKiEj1nlN6VJ8NtI6q
	 LVGbdioORx0VeXpdvv71D7OvkgOsR4UAm5/DF2TX/wtNqzS8e53O4uzv12F0alsGYwFLn
	 SH3BYC6r6rt4YHeIuSSaIflKO9swMerlPdbAHQ/OUuL8B1KGl7MACR1zSUIrL7H4A/PAR
	 Ug9/DFiPnpDlwpNBGGq59kJ7h5kv6+sae1hjt9oFFaot2CEkQ0Y/x0Oqjr0J34ZYNkjKV
	 KgBun/feCSUIujG/0VYLkeQN28DliZkYmfPRH54GyEs9eut1BONuP2CDN3DEXvGnYCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpB2S54T;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4144606A31E
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4144606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpB2S54T
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e946155442so14060825ad.3
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793256347; x=1793861147; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7PL87XUQ4G+5QOOQ/bdzXhoGzC0EKcuiuqHTLJ+UPQ=;
        b=RpB2S54TbfuKkxIp0iTkMunOWNJe6fBRLZiQ65QgCMAZ/axR5SbYXk3v0pS68HpxMB
         TqK6tskmDSk6Td1AS4F9U5BZnvd5FAWyHTxNef2WjRnHbkMvjzahu3tlvrnMXgAgwhp9
         VSS8V0WGyL4TIo9EDk9Ah9P2pS49kcsnCR06kdlTqXvWtjeFWt3FDV5lW1Lwi5E2+A+l
         S5HhYKiuCPxETsxZ5B7qewPvzkP3HT4GfUjIyLTPJ7J+yiqfbuvlZzotvEZjmAtOf2U5
         8ho6A+ZvcSGf8tEJvCt891FQAubuFvXjl1rBIWlLLczRRQkySlFxrMD00qzVDcbTUMBv
         WxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793256347; x=1793861147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7PL87XUQ4G+5QOOQ/bdzXhoGzC0EKcuiuqHTLJ+UPQ=;
        b=R+K0uDy9WLurqK+sD1S5jCZzy9nItj2n2zxYsNiFvKLNtsIKrlS42k1zXcsDiJnFki
         ic7k/3pZxUmbYnNRUWoQBw3b9yB0nf6RNkQ34yG4UtWUPV/7vtqvCVNA6C9V1D7O7KP1
         8yzFOA8g+3e+azRvsc0UrE6KvuERs7QkOa3qatBnoWH+QXUEGb5UCpLQIE4rFAGGQRif
         rK6mLV4Iu62tK4T1cy/KXnGeHayzIy2+5FdliZl4pv/cYxxnC7xTMT4bMqrPaxGLkBaJ
         ZBd/oTKv5dMq2WhGjtWWRUOu1uFi/sf+2PaK+70O/ryKxoFPjlEbZ5UE3GuT631Wbxho
         b8zw==
X-Forwarded-Encrypted: i=1; AKwUvBxXaQcGHteLBBiWMk1LlEw3URp7lp2s+vVtRMt3m9CxBxEp3ihZhGQ98MEZhts+3HdnxyJprw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKsWzbc7/bK7qe+tNhBe38W2mqr4MBrIJQbOF55MxxJ43J6I2BA
	3KdXPiCovYkm+7GN+oRwh78wZs4Lau2Nddr/oGeOFR1pkHBNiLrivRQk
X-Gm-Gg: AYBFou3KhVOIW72bSQVMFhEKPJ33CNwldsrS/xefcKOeqlbkkDy465lcjh1C8Cv+ueT
	SwMlMGeoV39u3YAizxhkkL6vsq2jKnb40kJbICWFCWc/Ys50sBIWnLERch6pH0lSpWAutLmCVBa
	PYqM9mAVd3QM3q4Gg6/+KFCU9i3vQPSdwyRVhn7TiWtHW0BULHQz/EdR5KsXOX0TNxfBlJXPnox
	sIv54kE/BI6jMEGKJyomadbL1D83BqKL5qK5u+yfcs1QQhDymEaz2K4palbuUiTD8P65cb/UTLc
	bsucwIsya1DH//df6sAMj3sYNqzTOw3RrYcYCEGsjJRMCxRUZh8OezlAz5LRpRHwK3OvVW8Msc+
	ua24LutjRw+v6h1qoJC3rgJQf8MBJ6qH/i0xfMiS3CuFkDR5GF6xQ3EHT6Fh+qLlaWqMAOUzSyn
	XiUNaajZPx6BLsJ6zIGb46dZ5QGFW314dcFtnDthnIh2oK3arocHWmImWFjkLFhT8zLGAMoNF9z
	DKsr4pGLJvYC817z8lMy+W4rFGG4ULBjVOMw799E9BIf9KBJ4oss39mHNL/Dvl4gVfOc4/DC4fq
	/SayyATu3mUfZOJ0zio3RJ0e
X-Received: by 2002:a17:903:1acf:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2eb00487143mr44591215ad.10.1793256347032;
        Wed, 28 Oct 2026 23:45:47 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eafcdb52e6sm18943695ad.74.2026.10.28.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:45:46 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	mptcp@lists.linux.dev,
	edumazet@kernel.org,
	gang.yan@linux.dev,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH mptcp-net v3] mptcp: protect listener backlog reads in diagnostics
Date: Thu, 29 Oct 2026 14:45:40 +0800
Message-Id: <pm-mptcp-objects-candidate-0066-v6-36c93fb39222b9c59043@gmail.com>
X-Mailer: git-send-email 2.34.1
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

mptcp_diag_get_info() reports the accept queue of a listening MPTCP
socket by reading msk->first. The token based dump and the exact token
query only hold a reference on the MPTCP socket, which pins neither the
first subflow nor the listener hash bucket, and __mptcp_close_ssk()
drops the last reference on the first subflow before clearing
msk->first.

An application can disconnect a connected MPTCP socket with AF_UNSPEC,
which removes the token but retains the first subflow, listen on it
again and close it. A dump that obtained the MPTCP socket before the
disconnect then reads the backlog of a freed TCP listener:

  Token diagnostic                 Application
  mptcp_token_iter_next()
    retain MPTCP socket
                                   connect(AF_UNSPEC)
                                     remove token, retain first
                                   listen()
                                     reuse first
  mptcp_diag_get_info()
    observe TCP_LISTEN
    lsk = msk->first
                                   close()
                                     mptcp_destroy()
                                       __mptcp_close_ssk()
                                         release first
    read lsk->sk_ack_backlog

The report below was decoded with scripts/decode_stacktrace.sh against
the 7.2.0-rc5 based test kernel that produced it, with the line numbers
mapped to this tree; only the relevant frames are kept:

  BUG: KASAN: slab-use-after-free in mptcp_diag_get_info (net/mptcp/mptcp_diag.c:209)
  Read of size 4 at addr ffff888111763818 by task python3/499

  Call Trace:
   mptcp_diag_get_info (net/mptcp/mptcp_diag.c:209)
   inet_sk_diag_fill (net/ipv4/inet_diag.c:330)
   mptcp_diag_dump (net/mptcp/mptcp_diag.c:23 net/mptcp/mptcp_diag.c:177)
   __inet_diag_dump (net/ipv4/inet_diag.c:823)
   netlink_dump (net/netlink/af_netlink.c:2355)

  Allocated by task 497:
   sk_alloc (net/core/sock.c:2337)
   inet_create (net/ipv4/af_inet.c:333)
   __sock_create (net/socket.c:1679)
   mptcp_subflow_create_socket (net/mptcp/subflow.c:1836)
   __mptcp_nmpc_sk (net/mptcp/protocol.c:111 net/mptcp/protocol.c:143)
   mptcp_setsockopt (net/mptcp/sockopt.c:313 net/mptcp/sockopt.c:916)

  Freed by task 0:
   slab_free_after_rcu_debug (mm/slub.c:6571)
   rcu_core (kernel/rcu/tree.c:2919)

  Second to last potentially related work creation:
   __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3287)
   sk_destruct (net/core/sock.c:2446)
   __sk_free (net/core/sock.c:2459)
   sk_free (net/core/sock.c:2470)
   __mptcp_close_ssk (include/net/sock.h:2024 net/mptcp/protocol.c:2723)
   mptcp_destroy_common (net/mptcp/protocol.c:3581)
   mptcp_destroy (net/mptcp/protocol.c:3817)
   __mptcp_destroy_sock (net/mptcp/protocol.c:3423)
   __mptcp_close (net/mptcp/protocol.c:3525)
   mptcp_close (net/mptcp/protocol.c:3540)
   inet_release (net/ipv4/af_inet.c:442)

The first subflow is a TCP socket: TCP listeners carry SOCK_RCU_FREE
and tcp_prot/tcpv6_prot sockets live in SLAB_TYPESAFE_BY_RCU caches, so
reading the two backlog counters under rcu_read_lock() is safe, and a
stale value is acceptable for diagnostics. mptcp_diag_dump_listeners()
already runs the formatter inside an RCU read-side section; only the
token dump and mptcp_diag_dump_one() reach it without one. Take
rcu_read_lock() around the msk->first snapshot and the backlog reads.

That alone does not cover the token dump: __mptcp_close_ssk() clears
msk->first only after dropping its reference on the first subflow, so a
dump that enters its read-side section once the grace period has ended
can still load the pointer to the freed listener. Clear msk->first
before dropping the reference, as mptcp_sk_clone_init() already does on
its error path.

Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
Changes in v3:
- Clear msk->first in __mptcp_close_ssk() before dropping the reference on
  the first subflow: the RCU read-side section only protects a pointer that
  is cleared before the subflow can be released (Sashiko review).
- Rebase on the export-net branch of mptcp_net-next and remap the decoded
  line numbers to it; send to the MPTCP list only, as Gang Yan and Matthieu
  Baerts suggested.

Changes in v2:
- Take rcu_read_lock() around the first subflow reads instead of the MPTCP
  data lock plus an owner check, as suggested by Eric Dumazet; this avoids
  the new msk slock -> listener hash lock nesting and keeps ss reporting the
  accept queue while the socket is owned.
- Decode the stack trace with scripts/decode_stacktrace.sh, map the line
  numbers to this tree and keep only the relevant frames.

Link to v1: https://lore.kernel.org/r/pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com
Link to v2: https://lore.kernel.org/r/pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com

 net/mptcp/mptcp_diag.c | 5 ++++-
 net/mptcp/protocol.c   | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0ee..28a42eee6651 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -200,8 +200,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 
 	if (inet_sk_state_load(sk) == TCP_LISTEN) {
-		struct sock *lsk = READ_ONCE(msk->first);
+		struct sock *lsk;
 
+		rcu_read_lock();
+		lsk = READ_ONCE(msk->first);
 		if (lsk) {
 			/* override with settings from tcp listener,
 			 * so Send-Q will show accept queue.
@@ -209,6 +211,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 			r->idiag_rqueue = READ_ONCE(lsk->sk_ack_backlog);
 			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
 		}
+		rcu_read_unlock();
 	}
 
 	if (!info)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4335eb8f9f2d..efc6d4db5bbc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2720,11 +2720,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
-	sock_put(ssk);
-
+	/* the diag code reads msk->first under RCU only: clear it before
+	 * dropping the reference that keeps the subflow alive
+	 */
 	if (ssk == msk->first)
 		WRITE_ONCE(msk->first, NULL);
 
+	sock_put(ssk);
+
 out:
 	__mptcp_sync_sndbuf(sk);
 	if (need_push)
-- 
2.43.0

