Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464114;
	b=tfK66uSgfg0k+8PnFk+MXoCQhS8riY9pdN441Re4+pL6mppM41/kea9Xrb2jaFuq9ihn
	 FQUQDmBaGoG7701YgrnFzhpm9gHg1BiQooPSKk+/cCo6paYV8kkVop7BhuyS+vCc8mNmU
	 pNy6Faqcz0PcgGVInXwbqonyc0Qpjek8T21hGkjeVAUTnkVBhxr1YrXM/02NCG69rIgB+
	 uIFmE7DdGqGxCGKOW7UA/hcVNpRP04t+q2tlRHmppwzW/5j97zs0Jk97041IutyDAbr+g
	 +rLin2rhVkzIUqmgSKps/47cmL+Np4i/FEkHINZpbhu0UNoXBMW/9lm1Wf/9bmlLUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
	b=ktiHcrE12RYCtHu9TgvX7N/zR9ZeNsAR5C7epQNEs2ksxM3P2iNIbu71YJeC32IlY3A9
	 wwT+NZ5QvJ/BB3Q+oisJhQtJbPDSwJqdgmhvdieBtgIe98OqLeC9HsGZBCqJYpIm2T3Z6
	 vdj0bTWjTLcYyWJZQCnOnp18LcI45jsNg+/wtH8xhgXNnIcuksu+UebIUnt1+H6nYa9pG
	 vTb9z2boO9YWBhhSmxLlpgk8w4TZ94rW1grn6/XeLA8elQLstHP96BHpx/uUzp3I7jZT0
	 1JrjksEENLhjOXqiXJPrFTE5Kfplj9of5LDjsNTKF+9iRBVBg5eLQDCFL+j5SUrrH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j4TN8Kwc;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94727606A885
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 06:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94727606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j4TN8Kwc
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdba239d0easo3914776a12.3
        for <mptcp@lists.linux.dev>; Wed, 11 Nov 2026 22:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794464113; x=1795068913; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=j4TN8KwcwwzqrsxvEJzDgRwPybVAaUnBRKZz2lH0S/XJYm9GK/22HULB+8Ig65pd4R
         ZN6YzzUAguSmm3yLFkUk0PSMLt3t1Gz8NeAXG09tjOb7GvDck3c1X5PjarYG/r4pyqIc
         k6b1lMRBxkEEFhm6JO0TNjeUhZjeIZn6iKa1PBnx/Zlm+cdd3Y/gKBhQ0wWhfj4BdLou
         ehlgr7ZWOugndjrW5oxMF49uAsge30piI8pYw1rgeIhng/xlY0ZcgHICp+E+VCSxFYcA
         k2atoC+VFq4OjHNJm9H8noq4NhUoMB1gb31sq87Y7OpXgC6T7ek0XXQOf0IK4X/OUpHy
         HhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464113; x=1795068913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=wp8ZveG5NrQcp9cZQ6f/+jRX7VNO+r8MmSbhctoxFoQl2wYh6pMKfwCXDwtKeErHBv
         hZAoQI2iVqD0Ynb1tHGf/Q4qa1O/zcF5caoh4NF/vloDmrARPMkWJnv8N9wt+WVjBAN4
         ZT7U3iZT8AZ6suJhx/P+DiogaIRTvI9gV/2CDPFQSinR2x5fKNX7p8LsEz76d9eHHCcO
         gxjhbnPxsMjrDumkdbidI/61Ob4KFMe15ITIcXYFuovoOM+rtmi9ByXyYl/Z4a/h1W7Y
         ewaWIx6K683SHDbs9cSqRzBG7nst7ArswjtXdkt1DHYVOhqaFscCgcsbMHTmPKeFgpH8
         Z68Q==
X-Forwarded-Encrypted: i=1; AL+hErE6zDHICAhY/pq7hsWY/rCLb4QvhfVHSjsH68yffnX3+Z6k2UnHzj5WVXkqBoVH7eBjc3Zo0A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+fdg+x7rAbTcx0eVCWKOPT3ChQxcrD2BcG0EttyPZypTZbJjze
	kxXqE+BB++hI8QWL3nY1NblBaKS0zuUDtcmsDPSrsWquWwZJOx946i50XKmRgMER8WnwXANqldk
	jBVL6MA==
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:3ae:c243:313b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2245:b0:3b0:ab34:afc8
 with SMTP id 98e67ed59e1d1-3b182e94123mr4304859a91.20.1794464112721; Wed, 11
 Nov 2026 22:15:12 -0800 (PST)
Date: Thu, 12 Nov 2026 06:15:12 +0000
In-Reply-To: <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <cover.1794325665.git.x-professor@outlook.com> <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
Message-ID: <avVX-3s3AYwtxQe7@google.com>
Subject: Re: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@kernel.org" <edumazet@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>, 
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org" <geliang@kernel.org>, 
	"ycheng@google.com" <ycheng@google.com>, "weiwan@google.com" <weiwan@google.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 15:47:58 +0000, Yingjie Wang wrote:
> tcp_fastopen_active_should_disable() calculates the active-disable
> interval as multiplier * tfo_bh_timeout * HZ. Since all operands are
> 32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay
> even on 64-bit kernels and re-enable active Fast Open too soon.
> 
> For example, with HZ=1000, a timeout of 6912213 seconds and the maximum

No one wants to configure 80 days blackhole timeout.

Please apply a sane limit in proc_tfo_blackhole_detect_timeout().

---
pw-bot: cr


> multiplier of 64 should produce 442381632000 jiffies, but the current
> calculation truncates it to 512 jiffies.
> 
> This issue was found using a static analysis tool. A loopback reproducer
> induced 12 Fast Open blackholes and waited 1.2 seconds before opening
> another connection. The unpatched kernel retried active Fast Open, while
> the patched kernel kept Fast Open disabled and used a regular TCP
> handshake. The reproducer required neither kernel modifications nor
> fault injection.
> 
> Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding
> it to the saved timestamp. This preserves the existing exponential
> backoff for representable intervals and prevents large values from
> wrapping into short timeouts.
> 
> Fixes: cf1ef3f0719b ("net/tcp_fastopen: Disable active side TFO in certain scenarios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  net/ipv4/tcp_fastopen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 7f7eb3cc1c04..aeefd605414f 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  	unsigned long timeout;
>  	int tfo_da_times;
>  	int multiplier;
> +	u64 delay;
>  
>  	if (!tfo_bh_timeout)
>  		return false;
> @@ -626,10 +627,11 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  
>  	/* Limit timeout to max: 2^6 * initial timeout */
>  	multiplier = 1 << min(tfo_da_times - 1, 6);
> +	delay = (u64)multiplier * tfo_bh_timeout * HZ;
>  
>  	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */
>  	timeout = READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +
> -		  multiplier * tfo_bh_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);
>  	if (time_before(jiffies, timeout))
>  		return true;
>  
> -- 
> 2.43.0
> 
