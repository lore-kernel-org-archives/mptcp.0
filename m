Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971D33F582
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890854; cv=none; b=W/emUjYh5GuE2G5AjMiSD8rgimm6igFhFf+UpJP/qLJUdoU2VERHgPNF76fxBNU1HZyJjJZ0RhXAhWiKtBz0sT6kUAvNwizvRdDgCKe1jo3r28J4d24ALOlTIWTbT4X4fYpsNo2BVXUCOZv4vcwvVjtUGPrX2ciQOfAw096NmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890854; c=relaxed/simple;
	bh=y4Hi+B/oPNnwyj2kymAAUR35f8vMo9o3TVl7jTlMcUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJZhlaXBn7RqQRF+iDku6U+RmIEz1Ad8P85cJQ6IygkqS4h/R/10Sc4wZ9SlnJKZWuSWGMViTTYvHUATAF/O33ngYZznNZI9s4CBc/NkggbKCof+gu2cwjX8HzeZH28plknfq/wCU2/mihmkbDfwS2PmcxDOT6AR2eVFipGYeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHT4GaIO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHT4GaIO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4904127c32cso35191045e9.2
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890851; x=1780495651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tBv7uNxGxBOrtzkZW/MXuikDFXopXk6ognc/bf7eJ8=;
        b=bHT4GaIOJWkv9eHDqq3/AMMUxg7OPq6LvNjtzfGebk0uVxsHMAwPDk5hPvJbIvPDQ2
         kLYDzqX0SwFt3XCTHviagz5aQ3/DzqFeOBi7m89bUYW4/lCdjbM6K1BmkQ6fziQJw15n
         zhx5bp6k4nSCOYlNT4eiR4f9BH5JHJAFzNzw/IkEFTC37rZAMfmZwU+xliGFb/7jsiHZ
         qo7i25J2N7OCBBDMoBHWkZfm5NkIz79QCGQlWISCsJy6wud3vI379uJQwA6wWujA78nJ
         dib63amhXDdREPPw9SHpgR6zJLOZNKc+mDUJlb4vYnoptdsbX4AyC28LepqmZrwQEAJL
         +3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890851; x=1780495651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tBv7uNxGxBOrtzkZW/MXuikDFXopXk6ognc/bf7eJ8=;
        b=N7MRI3C1UP4+0oLwRrcbbVpNwJ+ogCnt01M+IhRYmciUFxyj9wr24hMEtRMf0ikkqz
         rQNyOvpougICTbDD2YZl1DIlWt87xBhqzQUdLACHB0wc2F+f/jPvZp9bYKkrd60GBZV6
         96S0/YW3MO+w7qBaIPh6ICaySPPF+QZHW9u2eRkpCKL/hzPotnD3aNHH1KtYSudXx/GT
         I+P/oYkDRnwjr0+igX+X1DVGhnwHATTZhQcjDInFL1/pm70jXHSCfn3R3ITuXVDGcLTF
         2aQlGRcotBYGHCsO5caAVUfR0ic7zHQ9iooQf3L6kVxqFjOrugvJyfWEntH3UUvgRg7/
         YnHw==
X-Gm-Message-State: AOJu0YyRGgNG1PIOf/F0fxcV19qb3vSMnzK36jg0hVTUYoVJcq2/KaiU
	5eBpxzoKvMnpNNpZd+UIhBkiupJEdjucwOxwWEIhE49Jmsx1Db1cjtR7ociEh2aV
X-Gm-Gg: Acq92OGiC1ALUx4f8iACOhdFaDkfmVShB51999XDy/BDGztWCvWb6HanMJYHhpklAbc
	cw0MI3xvYd7O3HG8ventpQnCpZOhxwBt5l6QmJkMKRI9GNuYRjxn2Q7Uc+fdFWOUB4bkK2B50Iw
	H99/TYXKfDdJcl1uyescQC75dyD5wHpFM5SvaN/uYfMFgJj0FHmxQVHcfN6ffKbVeoegMnvjUus
	LD8VcbIwLdLp/X4k/VyLLONswFKl+772WhGRmCJdJHGgpWd84gkFbxmwq0QkIpj8malQkUJboeh
	zohssNipHpKmiaWXdA3/0Cn6263t5Gkr6iEbiNoUTJCOh0Fs3qoZX2tZWqKkCYDcSLuGNV7nhoK
	8I4x9ghU6ngMCVWCo2p7PP8Z1zLwG8PirA55dg1rFMuAkXxDYilBHEWtk3hLTpLtjPrHSG86p7C
	7A22ZiWpGmIhOyDlvgvcy2NWwnqFlSIFJmOrrMdwAFKVB5MTxYoXPJz8UT5V6DeHcCkvb0CVcY8
	13VlVdDSVs=
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-4905cd8d33emr235242445e9.15.1779890850474;
        Wed, 27 May 2026 07:07:30 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6c7433sm19579085e9.8.2026.05.27.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:07:30 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v8 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Wed, 27 May 2026 15:07:17 +0100
Message-ID: <512d13271d40a72b1e0007cf595cbf3bee6dd4b7.1779890764.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779890764.git.devnexen@gmail.com>
References: <cover.1779890764.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps and MSG_ZEROCOPY completion
notifications through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING / ZEROCOPY / LOCAL
events forward to the parent because they are tied to user-handed data,
not to a specific path; subflow-level ICMP errors are dropped because
the legacy RECVERR ABI cannot meaningfully convey their per-subflow peer
identity to single-path-aware userspace. Such events will be carried by
a future MPTCP_RECERR channel.

When sock_queue_err_skb() fails on the parent under rmem pressure
(sk_rmem_alloc + truesize >= sk_rcvbuf), the splice drops the offending
skb, matching the behaviour of ip_icmp_error() / ipv6_icmp_error() on a
full err queue. Userspace expecting MSG_ZEROCOPY completion
notifications must size SO_RCVBUF accordingly. The MSG_ERRQUEUE branch
of mptcp_recvmsg() forwards to inet_recv_error() directly, and poll()
advertises EPOLLERR purely on the parent's sk_err / sk_error_queue,
matching tcp_poll().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 47 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d67728d4233..28403fbdc994 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -829,21 +830,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	u8 origin = SKB_EXT_ERR(skb)->ee.ee_origin;
+
+	return origin == SO_EE_ORIGIN_TIMESTAMPING ||
+		origin == SO_EE_ORIGIN_ZEROCOPY ||
+		origin == SO_EE_ORIGIN_LOCAL;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		if (!mptcp_errqueue_skb_forwardable(skb)) {
+			kfree_skb(skb);  /* path-specific (ICMP) — belongs in MPTCP_RECERR */
+			continue;
+		}
+		if (sock_queue_err_skb(sk, skb)) {
+			kfree_skb(skb);
+			continue;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
+	bool report;
 	int err;
 
+	report = __mptcp_subflow_splice_errqueue(sk, ssk);
+
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
 	 */
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+		goto out;
 
 	err = sock_error(ssk);
 	if (!err)
-		return false;
-
+		goto out;
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly
@@ -853,6 +885,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = true;
+
+out:
+	if (!report)
+		return false;
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2313,7 +2350,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4363,7 +4399,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

