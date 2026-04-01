Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AC31715F
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073476; cv=none; b=KfO2vP99s6g+D9+0WMwWTBFCiWHWNx9WqtvJuWav3ORqAbb3V+nOeC00sZF6WyTcul/PAiH3cylCqc8DS+n34TtF7wE/I9rKKJby/xsTrBrpJd1mFKEl6pJ5MqthOjnUM9q2lj+RuOIO0aZZ1ZPTd2AbhzDrqoiH8XlbdJNCwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073476; c=relaxed/simple;
	bh=kpTrMtKgF8o1UMJlHyvDE2MKpPbROZcR3cPfCR5E+18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9AvLFaLXxgcHQAjF4P9puJgY8Z25YcVMmdrMAbDEj7kHryplo2DxSC/7zr+yvLyQdhf5RKvxYgk1KzoddOsFiVeZXAWTpMARUtdN3lV6ZA1fIJfWNr280+Acn1I/jwh9BMvUJ5V1KXbE6MEIuJz7GhsuGKr0RqrHXUgTBAUqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrePtTtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrePtTtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775073473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF+2fiGfnD3lwlMFV/H8KW+kJmhssCX/n1MUAdGk2WY=;
	b=NrePtTtJ3eH7srmBUhNOoubDGPzUWr9Hh2W/UKr2CnrV0oCwzEHTElCV6hhLJ3/s9Ox5ep
	y1whivhBDYBe+bideygukgXTFSoQU9H2XclNq1h0PYTsoRjTC6b60c6kDPr1uJ91w/Tq+c
	UUBn1CVywlhmcY+bUncQHbN//V1KNaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-j6QxUtxEPt-aQ7_Ynnumzg-1; Wed, 01 Apr 2026 15:57:51 -0400
X-MC-Unique: j6QxUtxEPt-aQ7_Ynnumzg-1
X-Mimecast-MFC-AGG-ID: j6QxUtxEPt-aQ7_Ynnumzg_1775073470
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fb142205so812405e9.1
        for <mptcp@lists.linux.dev>; Wed, 01 Apr 2026 12:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073470; x=1775678270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF+2fiGfnD3lwlMFV/H8KW+kJmhssCX/n1MUAdGk2WY=;
        b=rb6qjGDFa/1iDu2Oyvh7qnEGocykZkPLz9m3w0dZQJN+HQqFvMx+xDS+FVwGcUvo1Z
         xh1k7hwdpOKfy3E7t16w2LnCyJ7fdGKrg2g+b/DoIe/NDxzMZkbaWpl9XUErfcPjPr0q
         tgncaAC0TECDvOtyUOecne9AqLqNgnGXW8UfqcTgxcNx4nKLQxefQ3NKXR9uax9URCpg
         Fll+9HdlRBYcHns3v/nhpyMwwqZOa8RvVabV1NXy4VGPQ0ZBozFeZXhMRaSOSxDbRipK
         kTdAR8Neo5DtG5XFiR11bfjdFgDzRnOSY4Tnuk+fGpZnjXZxaSEGwRNn7RAyUHzeWnDp
         XvHw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVHJ1VFGewiS3McdfgqZxfS3X1RpkzZsMfej81lJkBnXFrVtTWf0y9BEIelyTZaVUiSiyAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOgUhvFgvKyZasvpPzyg/kMoGd4yXP9pGEf9yp3KANe4qo0jnE
	gKYnKb2vzpN5zopMTkPaBFEPcZgENRmFlZq+spob7T3mq70iVUO1uVewsP56d7tt5yWYY3YMT2J
	8G3MtTVt2uFi9ytxcaZjluqav+u81Hex9tOqOgQxM1mS6eqIMctIkRdtR+hwDAg4p
X-Gm-Gg: ATEYQzxX0ECm4YT0+7J+3BjlsezIyFwoaaoDDS5nmfKwrmsvSx1EZlGlq5xPv6w0aX0
	Brm1JFmkCvJ4wZhYJwCe8hQ/SJOGinz104kR6ix6+G9a7XXgjNCVxCLV+X8gRX+5ysr6AX0LR64
	mrh3RGF++NmJsbNa63+7oCHUFVgnTyeITPZQvuRzkfIiFYmw1PbBfreoU+V5Npu4BtJb20TfIWK
	TaljYhQXt+WtDTDLW526/J7bTm9sQX4qyHUpxDVQAhXmcEUb8HCWJjx1R/Ly+Avqjt7in7G+qfu
	g+Lobq+GHH5WdZWfleXsxM3tk48ZCgiwSEQTG7SyM4A0R5IgJSjA5gPcsxvpkqEvGXPeOM4SkOV
	ghWdDF0iqK2pq/bm9OFrxJe9RZQ9Kslz+ECTMaBlI4AzAJA3bwafmU0yZ1A==
X-Received: by 2002:a05:600c:1f93:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888b7130f3mr10589175e9.12.1775073470132;
        Wed, 01 Apr 2026 12:57:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1f93:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888b7130f3mr10588725e9.12.1775073469679;
        Wed, 01 Apr 2026 12:57:49 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm18956555e9.6.2026.04.01.12.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 12:57:49 -0700 (PDT)
Message-ID: <7d09f88d-052c-4932-bb25-3831b32e0f94@redhat.com>
Date: Wed, 1 Apr 2026 21:57:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next v11 05/15] mptcp: avoid sleeping in read_sock
 path under softirq
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
 <b7b6fd287877f7b2cb585c3b552ef0925da41858.1773911536.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b7b6fd287877f7b2cb585c3b552ef0925da41858.1773911536.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WD_H86mLGo8z71W5kfPlgq6CSqQ9_3mxcwamHgp1pOo_1775073470
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 11:08 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When mptcp_read_sock() is called from softirq context via TLS
> read_sock, lock_sock_fast() in mptcp_rcv_space_adjust() and
> mptcp_cleanup_rbuf() may trigger might_sleep() warnings or
> illegal sleeps, as softirq context cannot block.
> 
> Replace lock_sock_fast() with spin_trylock_bh() to make locking
> non-blocking and context-safe. Skip operations if the lock cannot
> be acquired.
> 
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5585f43cf879..e9e40dfab5ea 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -561,12 +561,11 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
>  
>  static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
>  {
> -	bool slow;
> -
> -	slow = lock_sock_fast(ssk);
> -	if (tcp_can_send_ack(ssk))
> +	if (!spin_trylock_bh(&ssk->sk_lock.slock))
> +		return;

I discussed this topic off-list with Geliang. Let me report the info
here, too, for future memory.

This does not look like the correct solution: we risk not sending out
the needed ack.

The exact, complete and decoded call trace leading to the problematic
lock could be helpful.

I *guess* a better solution would be detecting the critical scenario
from the mptcp/tls caller and in such a case queue the strp->work and do
not call into the tcp/mptcp code. The later strp worker invocation will
happen from process context and could acquire the subflow lock without
locking issues.

/P

