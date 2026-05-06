Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF2407595
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086571; cv=none; b=AoZeLzS/Jw4ymhkXo97XZe+C0jfQkNz+ORcfwpU6Ki4WZO4a1CASj8kca11rEuUKWuMjjyU+Gz69E78HiONdVq+TMgPN4h3gvJPRqZLDVXc5xpm1dxYzx6d5qSI6jwo2RAyo3GwZAKFDPUKPbYm8jzTEKvLU8SeNaPgBLkqGkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086571; c=relaxed/simple;
	bh=EqNU8Yrd0TXiupxHPwzxKotS3UioELwzqEx0ic4rLgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2ChT1/6r+g2QvLAko93mc4fyiohgW9Ge0SYVQFdMPFmCcd83uNgNTAF4sUvU7Fb+90aW2JhWjppUxnDoIfF4P3XK0fOZp1AXSlFRQO+mlUdH5A6i9DSxH3q0Yqzg6kDk77Gej+hijQ74OG0FjYiY+bPRwOsmaSBZFtpHrjBnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOEKt/Ke; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOEKt/Ke"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so83844885e9.0
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086568; x=1778691368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzDki06gKQpjz5uZEWAJE/Td9F8aqZ6hehFHrs+9QQs=;
        b=nOEKt/Ke7RoWV4VdZoFU5iVa+wd+cxneb5AepoV/SnL/MQYFBuBxLRFa0XhYfWfVfa
         xGJ7rE0zFDQXkdJv6OXHQemF2+yfY3JsHKXWWwjbSITAdZJpeLWVt6H47bJKr81PpVRW
         zmQsypO0zYxbcGhiXFecZr+dkokYo4ZRHXYfNYmjia+P8XBpixZXjO7rcQ9tWGfd90Wo
         ci5FM/+jG8lv/6cuNITaISPW03e4MK9G88k5XRtjj74uDXugl+re/ZlZguFlWGcvLQo2
         1Yt9/EORupPf7QI6+vMSdjcYPo+iOw47N37JxH6O1mkeL13ITp2ZKaKld2mBo160i8eu
         50fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086568; x=1778691368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzDki06gKQpjz5uZEWAJE/Td9F8aqZ6hehFHrs+9QQs=;
        b=X1f0SzRlzxwRjN7DIDiR1jJ58g002AsSsoGF4KZXB04rZ1psdHZ+wGBR7EHo3s6j4+
         QMSAdaDJzJSQkcZIJNaDgzzRF0mJdC+qSGLisv4J8aBktwe+vFw+BxLMIzPSx6bnPdVk
         cPhEw0B2tHG0Qr86QfWThw+IdettKKdmUcd2Lt0B17K0P0jCn3M6mqrzNlf0RU6l/OJB
         GvhEH14YZQBtmlgMQYE8E8HqC2MZWtmzk5svXnQxsAuApjZYQykoSahp7bRsQV9T0oD7
         yNMf2DqQXS+rm5y2vzYCeDiOGX1n4OiqmiyFXD5ET2baECUm/0PiRsMUvsVHRB/6fwrJ
         qORA==
X-Gm-Message-State: AOJu0YwweuUB36mmwcHj535QMFJZswfKt9+iLtOcVqP2x3x8c6xyxm4r
	aXTkc12PM5690aywP+HmG9qgWGidrHDHb/wkmcpz7Zo9ocZWZK0Sv7OMOJmmM0aPs7g=
X-Gm-Gg: AeBDieu82KKQROpnJ9E7V/vWS41YfqeMCfJDhf/pDUXBUG6P48xtgIy6MsB/P9NEW1q
	PYmrFfxmlDA4OpiYXtdDOwdxgb6T+l61CvVLrWfmYE50IDd9FrpcQsl5G0FH+1unU2iPM29kjLH
	2pk+F0yu47U9Y7MqcofqjKX25SV/pycNZlxyP9wb7V04/aWStcVwH6s7UBsNtZj9KIzSHSH4qj0
	BQ5qNx7O6zhraNb2/ziOfuYogW1gbrAHxI9W3SmnsYUhWt4fpaeKgd8XT++fO4Z464lk9oijz32
	vZy15QkwnTTLUtw5IIjEeRFyf5Hn585ZnyfH4t8hjd/eRxC9/kH1Qj0lEXHyNY4MqV6zW7n5ipY
	KJ5td8GlahlqztUBwbjtLMbNHaC9FbBuR2upbNe/Pt9Io4vzjBXeoZypUvpTuRkJXHg8/rR5i8O
	XYSdkkwxEFxfoOjrpp859GY7+ykFDW9bUEUgVkQWStLlAEZXafgAMvCyjUkWjwWZYHvdQJcM19f
	3XJ4MjucnXE5DXm5t+O4g==
X-Received: by 2002:a05:600c:3e8d:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48e51f40b12mr79389955e9.22.1778086567804;
        Wed, 06 May 2026 09:56:07 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:07 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Wed,  6 May 2026 17:55:55 +0100
Message-ID: <2b6d945e90f64cb8b18cf866faf8f1a66683152b.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
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

mptcp_recv_error() retries the splice on the pull side: if
sock_queue_err_skb() previously failed under rmem pressure, the skb
stays on the subflow queue, and the next recvmsg(MSG_ERRQUEUE) splices
it once the parent's queue has been drained.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 74 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0db50e3715c3..203ee37f57e0 100644
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
@@ -815,21 +816,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
+			skb_queue_head(&ssk->sk_error_queue, skb);
+			break;
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
@@ -839,6 +871,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
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
@@ -2286,6 +2323,31 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	int ret;
+
+	/* Drain the parent first: a previous splice may have failed under
+	 * rmem pressure and the skb stayed on a subflow. Freeing space here
+	 * lets the splice below succeed; sock_queue_err_skb() then re-asserts
+	 * EPOLLERR so userspace knows to drain again on the next poll.
+	 */
+	ret = inet_recv_error(sk, msg, len);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!skb_queue_empty_lockless(&ssk->sk_error_queue))
+			__mptcp_subflow_splice_errqueue(sk, ssk);
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2357,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4340,7 +4401,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

