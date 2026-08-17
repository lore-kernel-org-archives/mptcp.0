Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3F399D0B
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952400; cv=none; b=mv0sqTdW+qP8d/GjZR8uFKAq+Nf/3NQFfktR8J3Z/9pze2acq/EeiFNKQnRbR+0u4UquPp5gYn38459BDx7lcUJeR8qypmX+KqK/TbrcTgDEz8hor9kPLE7Uj7EJrYwdKkVneCLnHhLuNzhTktBoljhGnBKbh0rhffZU8RxeTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952400; c=relaxed/simple;
	bh=jcmwjdUM7WG9ZdzkLMf1sWo2dQ1aZ5da9ZS5baH7TyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcJ6S8bK7AzsvBbQ4E+emryi+N1NcrtBEqKwxSArqwAQBVvHczDHwQ2v9G7EqvkQNx8ewFyZ/Fh3WDL/Xlbqd0wuTYFDT73luUGH0wmfo2S0u20tYADME+edk4tiYX8FeI40ct6sVwz1tpUr22Op6QduDxHe9KLhyfeF6RvYp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSF9rFqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSF9rFqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786952397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YYINMZaMwz9TwOMia1FOWgKYL9RI2aM//gka/4D9vg=;
	b=NSF9rFqzrnJ02owgVwlaNG/27wm0abrBdY3FxANnbux1PkABnH5ZFaSJN0J0UZ5sQbDpsE
	q9FGgs3uYiGZCdTj3KWkDEmgrg5NvCOdmH0TtQ9X9NUThgsV7gUA935vXxzVVfchPGU6Jg
	hrNQo71uDcagjcUPmGsY2Zduf44+StE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-QOrpzWbjNQSZmheiJcfMRA-1; Mon, 17 Aug 2026 03:39:55 -0400
X-MC-Unique: QOrpzWbjNQSZmheiJcfMRA-1
X-Mimecast-MFC-AGG-ID: QOrpzWbjNQSZmheiJcfMRA_1786952394
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso30816555e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 00:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786952394; x=1787557194;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YYINMZaMwz9TwOMia1FOWgKYL9RI2aM//gka/4D9vg=;
        b=c2nYGZnRlC1YLKu9lbqmmGJAKx60i5PlevEWzJfbGg7rwv1AqXtwbN1FNjJ/4QjBl4
         sW58K3qlkULW2ZwgDmbXScvrUXLL+ClALbQcTx/ascv31UQF2lB9ihATpQ0rBNzwFqJQ
         rCX39CvxuZ102rIzyr2qJvDg/ni+1HBXfFGaUniVdHoH+6JL480BrpYcUBdLcGyQ0IPO
         qsTB6WRfTrmnLaILAfBqgpF4ZPguIyp6cdoItovewUfI0Fj/f8eDVNGBl8jyAPDzHTHe
         PvRy+vOyGEM0XX2TdsNu7xrZnWg7dxyZRcSrKX5hwBo4lYFZWcb/fxSU7TS82RSpJJh+
         Sn2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqyU1NqrUZ6nMaHC4wP1O5k2q3UkAg+HwD/QNz6fDfltk426PTpjiBAFESFJpfyaG0R4q/vkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgns5FX4obfky7JM7hY7uKDt+Y1DrvAc73J4y8ssrAwm2T5IRR
	yWSVKwyvMBK2zvHC//MSv4oqDc1YvCk0bWtVhgzSLPMNA1ujNIGnQV5/VKbcPdgHne9ZzRCSVlc
	QD6cLFRMnxfL/1nQ3vQMv0zj6/n/069Pexm2u70kj8gUXcQ9yFKG2h0J2
X-Gm-Gg: AR+sD11sWc+DTvxpNHvzOESu9rLeImw4J0gdKGSfZY33CrzFROkR+7JSwBoO4pjPSKc
	uisbnU0zI22/0HlQrSw0OKne1ROwESr/Fu6KYjrLPkmRdU5Ey4LrTnsn2b4YzmYUrokcwbmYaif
	rJ3gN9MWn6GxJKlC52CKnuHLZVEcHcNnD6zMyMmFT+mio5WMNaR1wrwO3JiuuDQXhK1ivA+AkPI
	E5JjBp+NoMa5TiuxluMAEQLD2UfBtOeih0JwQ8fe+O91vw7XSIHnzWs/9tOCQb4PGQaWmuo+bQs
	7PzWZR7nSQ86mpX4H1qnL2wfRRPas9YKi68gS//HyQfo1tYUyWinZGKfTLM6N5bN9dDheCVd/GM
	1VfnrUkIVIoSOEy/0aUu81E1S9X0noKgupI+7j71gVHEr0kpcnXlOk2IgrbDtJQo5vNkrHkjzW2
	Y=
X-Received: by 2002:a05:600c:3495:b0:499:873b:471c with SMTP id 5b1f17b1804b1-4998794fafdmr389301465e9.6.1786952394440;
        Mon, 17 Aug 2026 00:39:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3495:b0:499:873b:471c with SMTP id 5b1f17b1804b1-4998794fafdmr389300975e9.6.1786952394045;
        Mon, 17 Aug 2026 00:39:54 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm278199865e9.13.2026.08.17.00.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 00:39:53 -0700 (PDT)
Message-ID: <d1a6a67f-41c0-4650-b62e-6a4476bab86b@redhat.com>
Date: Mon, 17 Aug 2026 09:39:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: txsnMU-b8sgpGTP0yQOBdCR7UIt6tcYF49gbyvL9xos_1786952394
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
> When iterating over each MPTCP connection after having manipulated MPTCP
> endpoints, there is no need to operate on closing (or not ready)
> connections.
> 
> We can then safely skip those.
> 
> Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
> fully_established state, but it is better to check the connection state,
> which is what mptcp_is_fully_established() is doing.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_kernel.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3..c185e53fe42b 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>  		struct sock *sk = (struct sock *)msk;
>  		struct mptcp_addr_info mpc_addr;
>  
> -		if (!READ_ONCE(msk->fully_established) ||
> +		if (!mptcp_is_fully_established(sk) ||
>  		    mptcp_pm_is_userspace(msk))
>  			goto next;

I'm a little double-minded here.

The add/removal operations are issued by the user space to update
subflows, as a consequence of endpoint addition/removal.

Possibly removing the subflow even for not fully established connections
could be the right thing to do, I'm not 110% sure either way. Possibly
worth to call this out with a comment?

Also the asymmetry with the user-space PM is a bit strange. I can't
recall why it was needed in the first place?!?

/P

