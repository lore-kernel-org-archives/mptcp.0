Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5651E04BA
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397459; cv=none; b=kQx+ZJbFnggULpYmnY2LwmKo9GKYJ6GdlTN44j+ceNk3J0cdTQYqecAmS5TuzLyEsIH+Y5B5MEFzxgtvR9OEQ/uQiIsvJKYoYSTQnYZDO3hQJTP5+o5flO9GPLcjyXcng6w7FcPjqdkpo95zSI4DiaR3PF868IiqZw2fUNJJ2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397459; c=relaxed/simple;
	bh=zKtUCt25YjoDv+04wKiWsHZV00fYPj0fllZjhy818UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErWjSd3D80cDclsWYWTikXtMNR9EBcWE+/zLZSfv4ytWPlhpCNsW6plCB3MPgCj6k5TpBYx245gp3aJmYihUVMHd38k13XqEYNbUb3zQ3U4RmN6Dlduun3AYyBCOhFmtzgMPb3VSD2PPXcFcBrGOpb80xu4iW6/fZpH7/tpNo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0VXrXRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0VXrXRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728397456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYK7CEZOb6pQqYQKx8SlAXXKDlf7UPUGtZ9GnhryBQU=;
	b=X0VXrXRT1NR9M2BcciqZXwkq9T9Lb8lYo20Mgv+gPpfaFVoh01U1jb+WcBLaP4zlST9qlT
	YL1/3BQrmgjZVDYixoVrwP6msMXskbYfD7B4ie2sCPhv61U3vw3sCWwbmAVAb0Z+jrCZX8
	6XHm762lktEOhWq1bViB8LYnbvYD//o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-UEbUffhDNKy6eJ-j1eZqbA-1; Tue, 08 Oct 2024 10:24:14 -0400
X-MC-Unique: UEbUffhDNKy6eJ-j1eZqbA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d2e66cf9fso319312f8f.1
        for <mptcp@lists.linux.dev>; Tue, 08 Oct 2024 07:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397453; x=1729002253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYK7CEZOb6pQqYQKx8SlAXXKDlf7UPUGtZ9GnhryBQU=;
        b=l4B7/HEtKGa0BufhVLFSk+3+zQpeKqpajqploQLS7cnvJdl5OwJK7yeppcPSC+MC+u
         WifQJU0V0GX6e9jZpJc/U/GT78AwidfCxHg/KrkNSvpSrXBkwW0I/+jVQubdvEjdSGNH
         5n6nvlPWfJooHZR2/0sOByQ20TSDpvqMOxKtvH8C2OwRmtL1F+bboCbHel2uYhcRjD5y
         DWaxAD2QOi9bjl5pMXAb9RrcTJnv62ZXzI4p5NCgFAALG6el9Ch+bPuc0B3+cAI80/wZ
         2sGPzoEMlpaQLD+zZOnLOdteMfIHpSzoT9pWyoxBuhmTwG3fW4QK+zDNqEjBV7JBoxIs
         4WGQ==
X-Gm-Message-State: AOJu0Yy0P2idglDiPHhTGtdO8vBTspZFti6MEYQWhZ47oAU6HsmJFv92
	Lq/u+c3ISR8VyrAVj2mVCSR46NDp+oA9Fd9IOHJsyL1pEqN5Vt6EolcH5PdAaiM7XmqRRidRBuf
	5FgYyJ4AIvT2Bj06vhwF3IktduahLCo3EUJeYQ8Uq//i/izMLqqQ4t7SJ6ej7Rsc=
X-Received: by 2002:adf:f603:0:b0:37c:d567:7c8c with SMTP id ffacd0b85a97d-37d0e7781c5mr7046490f8f.30.1728397453402;
        Tue, 08 Oct 2024 07:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnZgQuJCX0qF994Fzpfqc2q8UovoYQlFR5+20EeNxyZTXN3fJXY2DPN55tXnNGUL/mpzGXwA==
X-Received: by 2002:adf:f603:0:b0:37c:d567:7c8c with SMTP id ffacd0b85a97d-37d0e7781c5mr7046474f8f.30.1728397453004;
        Tue, 08 Oct 2024 07:24:13 -0700 (PDT)
Received: from [192.168.88.248] (146-241-37-211.dyn.eolo.it. [146.241.37.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a541sm8237681f8f.34.2024.10.08.07.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:24:12 -0700 (PDT)
Message-ID: <fe5476b8-b763-4088-86ce-b4ce7c4983b6@redhat.com>
Date: Tue, 8 Oct 2024 16:24:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
 <20241007-mpc-hs-port-v2-1-0c9e7827bd0f@kernel.org>
 <5e4bcf88-58cb-4691-9c60-3fb0a9acbd48@redhat.com>
 <9ffd0d59-fe64-4155-b421-1de96edf77eb@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9ffd0d59-fe64-4155-b421-1de96edf77eb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 11:29, Matthieu Baerts wrote:
>> On 10/7/24 20:22, Matthieu Baerts (NGI0) wrote:
>> Side note: Jakub still strongly prefers not exceeding the 80 chars per
>> column. A couple of comments and the above line are now above such
>> threshold.
> 
> Mmh, I think we mostly followed the default 100 chars max per line in
> our code. We don't abuse it though: we use more than 80 to improve the
> readability, e.g. when the opening parenthesis is "too close" to the end
> of the line, when each line needs a comment next to, most multilines
> comments are under 80 chars, etc. In other words, if we want to enforce
> the max of 80 chars per line, we might uniform that, but I don't think
> that's worth it. Or do you think we should?

My take is that we should avoid adding more lines exceeding 80 chars, 
when possible.

> 
> In this patch, only the comments are above 80 chars, but they are
> aligned with the ones just above and below. I can still reduce them I see:
> 
>    /* Prohibited MPC attempted towards a port-based signal endp */
>    /* Prohibited MPC towards a port-based signal endp */
> 
>    /* subflow is a listener managed by the in-kernel PM */
>    /* a listener managed by the kernel PM? */
> 
> No hurry, I guess we can send this patch later on.

I would opt for the multi-line comment.

/P

