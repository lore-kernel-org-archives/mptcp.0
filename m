Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B43F9F54
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173723; cv=none; b=PIwCKLY9zeNtePmDo3yvESg5x3gDuhCBW95QpEvVuqczC6KGoKSRoi2ZJu9+4Xpgt2sgsQGv7GFS0z8IaguzHH/KA+Thlv/mrEAPd6EAnQMMpiUucM8Xo/8n6eghDSFuaroCQrjzHCcffmbA4BGCW5+o22V9c7WdPZRCl0SqlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173723; c=relaxed/simple;
	bh=k5L9T9HuspKLeaPcV4E6F4xntMBi1FakBcE91U1GjXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tobjdh1dPmlkJFKAiG/G9gjB/HDd8C27ZBJtM81E2ijwujmtAedeaSH98rIePOVpxBWzHtpVONvjhfspvRypwmmeCjd06h62ltx2PgiGcPbdV/IMbW+0SGxTD8siZ5kCS/G995ojXyHF9/WvA8Zg4Uj3DNI7ACNC0blf+WEFkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GT6z0Nt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT6z0Nt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778173720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g8BZOUIqwFMf5MczCTWS57/QZes3BdStmRaQBqy/OM=;
	b=GT6z0Nt/2SrkXA2FL7PpDkBWL6fviklKZm/vCGCGZdah3FZYaJ5ZzLr6Y919H673UOzUn+
	d4gvs1KInL9EYo8bAjUdi4IMJyVQ8hgUlkhbCqlHcUoWz913FM8VCH5hseU/M8JdnT+zwh
	itBPt0YqaL77PxiSchTt57AMIdJDpLA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-X5n2ZkLVOGqzqiSOvAoyag-1; Thu, 07 May 2026 13:08:38 -0400
X-MC-Unique: X5n2ZkLVOGqzqiSOvAoyag-1
X-Mimecast-MFC-AGG-ID: X5n2ZkLVOGqzqiSOvAoyag_1778173717
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso7756285e9.0
        for <mptcp@lists.linux.dev>; Thu, 07 May 2026 10:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173717; x=1778778517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g8BZOUIqwFMf5MczCTWS57/QZes3BdStmRaQBqy/OM=;
        b=OJIKkDHStakk+315YOqJsGXqGtsfxRwwu4SevWnou1cCwk4L/H/+AkarsGwBeEuFGK
         VQntKRbqXcXEbKQiLg/pOdhxPv6J+54GczQ/ALtRNjPWpIu0iM5HleO1hCyrPajQxG0e
         oJYnAaOWQIa/iJAAIozHnkEo25IJTtkIcJ/Ru1bkR4SiNLVBw2ZH2awdTM1U8CkA89Mt
         641ykb5nceVZMTg16DGeTrgJOW+P4eHNhJmVQvn9iHRtz7rLUiYVRaPqyg9qCBclvuum
         I5bPl+2ine3b4NTsMXNXVJ8yU+5OKleulCOluz1sXIc0PXSN0YFrWlEAs3/nv1DBjXK5
         jyhA==
X-Forwarded-Encrypted: i=1; AFNElJ80ONaSc2+FiDF1f5jc5BXyvN8dXTwwUCgfdhYWXhjWKbdy2G2MNhZIP7prVB+h7e8duppZ9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6hdTwOFtWQFvmRsKj44+ahmzJJRWdMg94GbUoSu4pR5W6LA3Y
	GHja4nOULhplqfu//lT+ssiXXO1wtmL8XL+d7XdDZuaqKWL40WM6h7keYXMtZsKfbq8N3NjU3g5
	zah/2XjCkvt2MO4jArdwROQ1RCVses5hHkT52bs9phjmlqAZyYbzXQ5gx
X-Gm-Gg: AeBDieuD4WeVUi5q/XHh4paYT8KWaRSDmTiBOE/j/r0jcG4aCgzDCXIsapHoy1A9hbP
	zU4lMisxUA35x6Ek2PAFTPq6Lobft8PWwMqBlTcN4OnyWFOJsJ9LP5Lg68oovcT7aVTfGP6A1ul
	GjuBhy44Tm40NgeF93iVMa1nH08cZ1DRjpNMC701OJiWCOLIMtU2EeqIMQFt4yzhGFX/UAaTrY3
	oaYfv+pdVwfqLUP1MWyp9gzjRmtT6h+r8/covtlcUlNZV26c1ekTry/o0+eA2pfqi6zXW4dV1qn
	QSC5LCfZELTeWZ4WXF6R7V5DK7txPzAAer6q4oeGNxjhDU18pA1ITuRENZnG98X0o49NCeZWTop
	guN9JaZaTmMYOY3/7bGUxFadsN6pPywqCUSVTiRDOP9bWrCaSLS2TJ/Y=
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr149911085e9.17.1778173716959;
        Thu, 07 May 2026 10:08:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr149910515e9.17.1778173716440;
        Thu, 07 May 2026 10:08:36 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45417bb92ebsm329213f8f.37.2026.05.07.10.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 10:08:35 -0700 (PDT)
Message-ID: <b04ca1cb-6247-4a6d-9c86-d86648a7a4e0@redhat.com>
Date: Thu, 7 May 2026 19:08:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: serialize subflow->closing with RX path
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, matttbe@kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7daClDhtpcxxfzuwAuBUAAPut0sxzjYkk93YEDl4Yic_1778173717
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 9:28 AM, Kalpan Jani wrote:
> There is a race between mptcp_data_ready() (RX path) and
> mptcp_close_ssk() (teardown path) when accessing subflow->closing.
> 
> Currently, mptcp_data_ready() checks subflow->closing before acquiring
> mptcp_data_lock(), while mptcp_close_ssk() may concurrently set
> subflow->closing and 

Are you sure this race can really happen? both the relevant part of 
__mptcp_close_ssk() and mptcp_data_ready() run under the ssk socket
lock.

> @@ -2653,9 +2673,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>  
> -	/* Remove any reference from the backlog to this ssk; backlog skbs consume
> +	/* Remove any reference from the backlog to this ssk.
> +	 * Serialize cleanup with RX-side enqueue using mptcp_data_lock().
> +	 * Backlog skbs consume
>  	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
>  	 */
> +	mptcp_data_lock(sk);
>  	list_for_each_entry(skb, &msk->backlog_list, list) {
>  		if (skb->sk != ssk)
>  			continue;

The real problem is here: the backlog is currently traversed without the
data lock (wrong: the mptcp_data_lock() protects backlog updates), while
the ssk is still possibly open, unlocked and can keep receiving packets
and adding them to the BL.

A better solution would be something alike the following patch (completely
untested):
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff23f..68d97926cb81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2550,6 +2550,21 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	/* Remove any reference from the backlog to this ssk; backlog skbs consume
+	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
+	 */
+	if (flags & MPTCP_CF_PUSH) {
+		mptcp_data_lock(sk);
+		list_for_each_entry(skb, &msk->backlog_list, list) {
+			if (skb->sk != ssk)
+				continue;
+
+			atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
+			skb->sk = NULL;
+		}
+		mptcp_data_unlock(sk);
+	}
+
 	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
 	 * could be negative at this point, but will be reach zero soon - when
 	 * the data allocated using such fragment will be freed.
@@ -2653,17 +2668,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
-	/* Remove any reference from the backlog to this ssk; backlog skbs consume
-	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
-	 */
-	list_for_each_entry(skb, &msk->backlog_list, list) {
-		if (skb->sk != ssk)
-			continue;
-
-		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
-		skb->sk = NULL;
-	}
-
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */

