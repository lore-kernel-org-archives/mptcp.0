Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870364;
	b=B3h8ECtAnkOb37RnO4mE5L7RFrkII1ZhoF7lW5iDKS3zG4MSF6JaTgmKiWTyNEu3EVUP
	 GrVFtGSntSHCGs/5VrpybAnk8nPtfuK/WEGjvRmyOpx+0SqL5gRlHfb3Dl8967nkDjqW1
	 Nz7dfmYChwYnYXY6e8psYclou9gqw7K3yxmTIUvTX7mH+aZsHRtc1e8du+UIL0YIh4q1A
	 lwTp7EjHyUg9tVBM3mJtcWEf4chQ+dLq4H/Izsnk0YYomnUVLFgebjlsfdNQ360jzc+iv
	 MOyJ29+votaCw8/v3Nl0uS02F1REjQlTyKFFOd0hho1NK5tpdj4qmi/jkbMAOT0fkXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+1bUuETZhuGuotXrQFC7vVEwK6wl12zrg9sjS68gw/E=;
	b=d2oL9trHfGuNbO45fUxCCiS82rUBoR+ymqmf41ncNphtvlkW5by7zggTHlfLP5UAxwZ+
	 8IKq6VAwXqAb4y/MpuS7MD1b1wSFZQUuWvzrs62mxJ1Xc+657oaAA/hHLfBqo4BJwtQiB
	 wKBKyOleL/xJKF1xAbIkvf4Gs0urDhf+RnYI5mOdeYk1G/5j4Bc1g6Yh36CEB8jeqeazY
	 8CHUidl4KVYSXxXuPqtMgl3DX5BAnMPx479X1FmfFxhCP6uPMj06tyufncSaMgpRG7zZl
	 FFPyjcDX42L6mmJDj6MNXVWVkJnxv4jnYlIywCkJPa33jMW4MQW/9zfxszq87gTRkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJccxKiK;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC0606A883
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95CC0606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJccxKiK
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3a74ee77fso377726a91.0
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870363; x=1795475163; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1bUuETZhuGuotXrQFC7vVEwK6wl12zrg9sjS68gw/E=;
        b=CJccxKiKJ27WkRmFrfXmLxSC+BZCKRzHyNBrPg704V6JklkXsON9eYF58f7bGce84b
         8ZTKLoa9Mxk/ObtiL9Lzl+uBbWaviOdpijK1nwEZXbeVgwZ6k8ekSycTpO17eqEcOWL7
         jAdTQZ4rmn6bklMVP4JLhapvWDqnmasvTSeNvT7gEeErBzahBDOnkmpvQiWWCmb8BKQ1
         dTS6umDl8myl8+PwY4eMlkVof6UGzFfDZaYQK+TtT/W3xJNw8Vl7ccZRTazO10kXsWqA
         NvxKTrCTPosVwKdRDT5SpqDGJH2pAVZJeHsD/UMLrdPDERFa89obBmoUzpNze24iwpfd
         +O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870363; x=1795475163;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1bUuETZhuGuotXrQFC7vVEwK6wl12zrg9sjS68gw/E=;
        b=k0QoXG5nMg46VgK3vsYgNWj5fwX4JlGjXkaaxpnzFms2hjcig4TYMuf40aF+x/57dV
         q6cKyxhuFRL176+983tRm4Ls/hqyeceDQGGJOwm4otmC4aXb5IkU2XCSo+fQaJim8+Hp
         5yB/f+4jQP6GhIrj9QSYklv2PLptbF9jDMpNIY0nHf3wJn37+0RMp1BwsXD8uQFMXbAB
         Q2AqLrajnstrcRyywF6JvdLRvfckdHPAvyhV04lnneJvFlYMxi2JrPMjlqnkRZZqCoOg
         eywWA2AKiDVuIBNhJB770y/bXJbyVOo85iKkKWGW10phXkW26hSrV1bcuqU0CTM0/VUD
         16MQ==
X-Forwarded-Encrypted: i=1; AL+hErHMb3PkZmG2aaPPXkimq1Xe+ADFj78TsagbuuEBiHbDzfnwGPfWZPSWkTX2Ib9Rxub02VBEhQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uRrkuB/4+qUaGFVl/XfgoOpI6+bjl47bb9KiW12blvAX6HBf2
	tHPsrtfi+iq5PB02qp7Cs5sS6DdqflgopOuJ0CF89c0q3MHtE+oZNKQEBSNvUMjbG5/FgtDWWbI
	8Vl4Qug==
X-Received: from pjpf15.prod.google.com ([2002:a17:90a:9b0f:b0:3ae:c243:313b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528c:b0:3ac:8897:7baa
 with SMTP id 98e67ed59e1d1-3b1b0a5030emr9587501a91.40.1794870362595; Mon, 16
 Nov 2026 15:06:02 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:30 +0000
In-Reply-To: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261116230555.2305867-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/7] tcp: Batch memory accounting in tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Once tcp_collapse_one() calls sock_rfree(), skb->truesize is
reclaimed to sk->sk_forward_alloc by sk_mem_uncharge().

However, sk_mem_uncharge() rounds down sk->sk_forward_alloc
immediately once it reaches 4K since commit 4890b686f408 ("net:
keep sk->sk_forward_alloc as small as possible").

This unnecessarily reclaims memory for newly allocated skbs,
and the following skb_set_owner_r() for them underflows
sk->sk_forward_alloc without sk_forced_mem_schedule().

Let's cache the delta during tcp_collapse() and batch accounting
at the end.

Then, we no longer need sk_forced_mem_schedule(), and instead
DEBUG_NET_WARN_ON_ONCE() is added to catch a future issue.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_input.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ca4cdb93373d..713dcabd88b4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5822,6 +5822,24 @@ static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
 }
 
+static int tcp_collapse_uncharge(struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor != sock_rfree);
+
+	skb->sk = NULL;
+	skb->destructor = NULL;
+
+	return skb->truesize;
+}
+
+static int tcp_collapse_charge(struct sk_buff *skb, struct sock *sk)
+{
+	skb->sk = sk;
+	skb->destructor = sock_rfree;
+
+	return -skb->truesize;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5857,6 +5875,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	int remainder, nskbs;
 	struct sk_buff *nskb;
 	u8 scaling_ratio;
+	int released = 0;
 	u32 sub_end;
 
 	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
@@ -5874,6 +5893,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+			released += tcp_collapse_uncharge(skb);
 			skb = tcp_collapse_one(sk, skb, list, root);
 			goto restart;
 		}
@@ -5959,11 +5979,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
-		/* nskb is charged before the skbs it replaces are freed.
-		 * Make sure sk->sk_forward_alloc can not become negative.
-		 */
-		sk_forced_mem_schedule(sk, nskb->truesize);
-		skb_set_owner_r(nskb, sk);
+
+		released += tcp_collapse_charge(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
 		/* Copy data, releasing collapsed skbs. */
@@ -5987,6 +6004,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				start += size;
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+				released += tcp_collapse_uncharge(skb);
 				skb = tcp_collapse_one(sk, skb, list, root);
 			}
 		}
@@ -5998,6 +6016,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		tcp_rbtree_insert(root, skb);
 
 	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
+
+	if (released) {
+		DEBUG_NET_WARN_ON_ONCE(released < 0);
+		atomic_sub(released, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, released);
+	}
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.0.679.gc527c65306-goog

