Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EB2DF13F
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315312; cv=none; b=s7D9719zmdjQyKJBwj+O44JFYaaekhT4hQ0/2mj4qlO1VEAjnaPCSIP6ozgryPck4BqhO4McPQ/pcU2Kh86qp31kD64ZnV7dhlPr8Evc2hhby5yckRQiss17frarJsqzi0F1L2FuQHnexTVEjJpjDB1UT0hlbb5XXUK6jcDf5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315312; c=relaxed/simple;
	bh=YI8ozqDgb3NIdUN1pg9fQLUEu4SXal3mfjKD2RtsGqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZURYi24OvxB5WDdgJtqrz2t3cDaC0+xW7UiMTbco/Urzr7y6K9AVTi9rDl2UXiJcmxGH86XUo5vneVd/1I4NQd33MgumxcOT/JgUj/NmOyCWBnLBV6wtlb5EgfAKkDfow5pqfhX7My3movVKqHcKltaX66tb31J4AEQzxP7rthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmHunJKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmHunJKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785315309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTkWsWHZQgP84MOUU4X5p3u4PZSzj8iXPIPsuq4Krr4=;
	b=CmHunJKcbv5J1lv6Mza4IUvzCXPKiZni2TpPrwbIsRY9n6xnnZiw9CmRySU1cYLF+W16iU
	GwBCeDiAliM9i0ziFQGBk6/rWguec28fO5BOX2LbYe9fYKiPbv3sF37xoU35lCwT+5EibJ
	k+cc+54/HxzkKEtx7TARXa3rbwr7BR0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-XeqX9h6yMtG36siq-ji4bg-1; Wed, 29 Jul 2026 04:55:08 -0400
X-MC-Unique: XeqX9h6yMtG36siq-ji4bg-1
X-Mimecast-MFC-AGG-ID: XeqX9h6yMtG36siq-ji4bg_1785315307
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8580ed9eso639796f8f.0
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 01:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785315307; x=1785920107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTkWsWHZQgP84MOUU4X5p3u4PZSzj8iXPIPsuq4Krr4=;
        b=el3IGWDmxsGBGay31n2pSaVio/TNPAdyV1gybsLJVjCQx7uoMQD/MT5Ud2eF5XZxx3
         NtkO/D6Dnzdc43Wk2RVRxvN7nl522xJ2ta7//rhe46vRomu5jp8OrF4K5LYk7c7DclTc
         2fh0a0nuMFzEjB8Gj9KdF2jO3CTJnv2ANhJEkPQh5qMP5bl0SwhN/YYiXPHDSDQZqvwd
         urhJWb1+KFv80PF2oaJgpQP6YGfm9CaV7Elw3Fy61XkfIHFhP7/V1HuTyked1Ve+QYYy
         CNNDNRQyfUenk6Nh78Uu2mSKL5vkEuc6yTbnel0YDp59S7lJJXNOC5Dza/VzAmxWt2d1
         BT+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro5x0V4flEN7asn1E2qn+qJh9VrND5jeLzwBftePmyI8RccluqANmM3YhSc2Vn+QY4cYplpXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvKHRex9zIBCxXfxqgx3xY/hduB526tn5QNWXUtuctgxTZKfP6
	0HfeBPRKpp5quU6t2ZFQIHbpGCI5y5gB4A9YOj9xFr29ZotA4U8fSxubP9u9bF/C58Q/GmljCV1
	kNZxt2BKRwAnGsvgcin9AcOT/znxUwVkA78pHeBwKctf3al849mtpJy1HZjjlXeBa
X-Gm-Gg: AR+sD10R3TABDXxw/TtzZD6QBNhLPxodMwsTObnkDhroQNiZGndknR83Gq77th2oYBn
	4R9HJj9VAtRY9AmtbJ2GVwUojSlmz1V0yb21yob7jvKzgeBINhn8EfraeB+y3QwG+A7cP87zvnC
	B8XthQg6E2xbmDcscCLUi3C3Hn9RcFnd6TvmBoIwmC5omqf2+yKhMjBv7J+O7QngKtCBU9rHRFL
	pbIOJPx+ayqhi0lbw9UUZym6tFYqUruegsVL1JnXrXRC7wKzlUHVtjIYdbVeYxf5gBC4WY23Y4j
	ib+fqNOORgk79JjSDX80b9IUBzTIBuxppdn2iNEHJzz3w6ByMTkBA4/B01BIA1IKDHTBqaFU/b9
	yx2mbkhU3IQ5Aa/lZW9vQL3ZAgew9DicjVtga79/k9AqMzq3sD3Ej4OxfSB5sn5nl1S1ekUY8zS
	S46Q==
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-496c6590745mr62026555e9.18.1785315306823;
        Wed, 29 Jul 2026 01:55:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-496c6590745mr62026225e9.18.1785315306326;
        Wed, 29 Jul 2026 01:55:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bff4784sm347354375e9.4.2026.07.29.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 01:55:05 -0700 (PDT)
Message-ID: <4fade36e-9dd5-4c53-8cb3-e07c66b387b5@redhat.com>
Date: Wed, 29 Jul 2026 10:55:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 6/6] mptcp: defer sk_data_ready to the worker
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
 <5ab5630bc288d5af26ecacfcf29c7fe35f1fd670.1785150300.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5ab5630bc288d5af26ecacfcf29c7fe35f1fd670.1785150300.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OAYas4oxvaovJQDznri0HDej0_B6GEGtFF3c2gsK3o0_1785315307
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 1:29 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When MPTCP carries TLS, the data path runs under mptcp_data_lock().
> Reaching sk->sk_data_ready(sk) synchronously ends up at
> tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(), which
> calls mptcp_data_lock() on the same sk and recurses on sk_lock.slock.

Is mptcp_move_skbs() really needed in mptcp_recv_skb()? Anyway it looks 
like that is not the only constraint: AFAICS, before the mptcp_recv_skb() 
calls, the TLS code would call __mptcp_read_sock() which in turns calls  
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() that requires holding 
the msk socket lock in process context, while the mptcp/TLS caller is in 
BH scope.

> Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a
> new MPTCP_WORK_DATA_READY bit, re-using the existing
> mptcp_schedule_work()/mptcp_cancel_work() infrastructure. The wakeup
> bit is consumed after the SOCK_DEAD && TCP_CLOSE destroy branch, so a
> socket that reaches the destroy path drops the pending wakeup rather
> than running it post-free.

I think that unconditionally adding the work latency for non-TLS application 
is a no-go.

Instead I *think* that the constraints in __mptcp_read_sock() could be relaxed
with something alike the following (completely untested):
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..b09e267f5d46 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2986,6 +2986,15 @@ static void mptcp_do_fastclose(struct sock *sk)
 	}
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_cleanup_rbuf(msk, msk->read_copied);
+	mptcp_rcv_space_adjust(msk, msk->read_copied);
+	msk->read_copied = 0;
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
@@ -3026,6 +3035,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		__mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -4381,9 +4393,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = MPTCP_SKB_CB(skb)->offset;
 		if (offset < skb->len) {
@@ -4395,10 +4404,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	return NULL;
 }
 
-/*
- * Note:
- *	- It is assumed that the socket was locked by the caller.
- */
+/* Can be invoked in BH scope */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
 {
@@ -4441,11 +4447,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
+	/* The backlog flushing is only needed when some data is actually
+	 * moved and will take place in the workers's release callback.
+	 */
 	if (copied > 0) {
 		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		msk->read_copied = copied;
+		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+		mptcp_schedule_work(sk);
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a2d40cd7b13..89902a98d383 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -115,6 +115,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
+#define MPTCP_WORK_READ_COMPLETE 4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -305,6 +306,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;

