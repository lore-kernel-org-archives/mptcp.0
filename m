Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5239E6F5
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837375; cv=none; b=aJkhMp2JoIza2D8C0j6ys3QVogIRz6CASCzSk9KJK5b5Bptu7Dny9j+oDtloBJYSWGigKWgrQbxSYuzvvyXtHCz0JcwApAUyrgSP7lpqqzcTadnPy7wLGx5tLBZY0HauCD94lisVOo0jKbhCKFa2xuf/5/ulW/X6y+2S3H3mU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837375; c=relaxed/simple;
	bh=EJW0McLidpAbK2JqMzoozdF4HoVhOnVldnVPympxscY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9I4hme1k9IBq4NaFmJ3YIpcuFGQH5a7uUcHnI/ODo07d24nfo05yL+IiSXjq0dc2HTFNwwLIttsmVtOQdnQCm7ApNLxDz6Pl+kCIRbJWRo1tqUYg+hNInAo7ybiCpKlq0STGFQuu1UUABZiA7xZABPRfqu9WTHmfhpkZKoA8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hstnVwzY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hstnVwzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778837373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DN0rKJ2cTmPoFJmyqt57O6PVvUhP+mEpQQvT3hmXN0k=;
	b=hstnVwzY/DgMuQphH718iJLTCPYBvjt7azwBucXK+jczUAol1qwDGnXOpgX2z3/mhjj88T
	R9ZQQ95Sn66bq244vqwxNJuEamuDe/FT6/8nDJleRfb4CzVqCGDARCCM2K0E35wCihNWjY
	MFl2kpXrYgemaSBZ/9LRJ87CLytKke4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-qNzd4XRpPK6qOyFUcfVOCQ-1; Fri, 15 May 2026 05:29:32 -0400
X-MC-Unique: qNzd4XRpPK6qOyFUcfVOCQ-1
X-Mimecast-MFC-AGG-ID: qNzd4XRpPK6qOyFUcfVOCQ_1778837371
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso77623615e9.0
        for <mptcp@lists.linux.dev>; Fri, 15 May 2026 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837371; x=1779442171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DN0rKJ2cTmPoFJmyqt57O6PVvUhP+mEpQQvT3hmXN0k=;
        b=EF59IMn8NyasRLvcJfnLxRERqSU4TxSiM7auFck4T/NLogrviwZ953ztiNHFXGk9VW
         hj1e9zrBNiyvOWoQEVUpHinorcoHrH9TEH2B1dZZRQKgi4STmoZINssC9+l4Xq8ZPN2P
         ABunQwl+xAa1bz2MfRrX+dgFt2p0jRNF0yGPKJWjrt0vPsMoI+LtB5W3NBwcE6Ocqa+l
         td7Dhrl3JP7TGbK9W0QM6kQLu+df54b9i4pKj4s83uv/9+TZAROIl10E2UUUQvhkig6H
         jGjpPrJt9AVpnzYzca9o/5OHGSjgWbgGagk8grZJB9JsYf8b0J11fp4sxeXbH1BVdDcW
         zUtw==
X-Gm-Message-State: AOJu0Yyw06OgZYm5IvoEoiIXbqhLvP3pijqR203bdKNeBXIIWjrR+Yrf
	aoBvquuiP0koJFFS1S9d+ZijSTAy0Acwad++zuiKeyXhu4NX3dxD8OcTP6CWH45jOdw6BVduwh2
	ppabXzMAIOMyBfJGRW58LuvhES/MuESvGupyqdrvh1KQIV+DGtt+NbNsR7gk8x8Ekks9PltVCCX
	g7TbT7OITz7HaVCTbPtBAeVwxGihGzXF2XTsFxyg==
X-Gm-Gg: Acq92OHv5U7ZtjA8NuyiXKopH+CYpTo5uHoOkeQLGFRqPNR+/eeJOehPq4bLWH5e0tA
	3u91ZLTQYrKCnBjpYQvoME86JZb+BFkrKCcrqTYLB1FKZCR8za5pLfbFweNBEiuVb1zT6GfKten
	WiYoYMr2WS5jlquZXY4h3sN1/1Chr6no7+PhN2Ppkvd1Bjwns5kIIkaHw9M4F11BVtjnoXQ1a4r
	dXozNLfMNcwPayzTZzEkvJHhCK0WwRvpcGTZQTyEbOz1jZP3qymR1DZ5tRO0KW8cvVALHwpkw47
	4hIxE6yBxwLSVkWi3U+PSlY96iybkH65SwsWgJGdwjEM82eCp+FFui1LcKRLXfjaVhuno//y+ED
	+KUjvELx2fFTfjNd9GSP5PxLf/HRetwRe5JBSCaARoYJCwb4ut2nAqlxzVHWvyQJPHRQ5
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48fe60e13d1mr43066315e9.3.1778837370897;
        Fri, 15 May 2026 02:29:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48fe60e13d1mr43065945e9.3.1778837370408;
        Fri, 15 May 2026 02:29:30 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab671sm46833865e9.1.2026.05.15.02.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:29:29 -0700 (PDT)
Message-ID: <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
Date: Fri, 15 May 2026 11:29:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1778835009.git.pabeni@redhat.com>
In-Reply-To: <cover.1778835009.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 20YLsITSwskCeP0LLVV_vfrZCuMqJQ65NmATrbuP6bI_1778837371
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 11:07 AM, Paolo Abeni wrote:
> This an attempt to fix the data transfer stall reported by Geliang and
> Gang more carefully enforcing memory constraints at the MPTCP level.
> 
> This iteration presents a significant change WRT the previous one,
> avoiding entirely the collapse attempt on memory pressure. Note that
> this choice represent a trade off: collapsing allow much faster transfer
> (to be more accurate: order of magnitude less slow) under some extreme
> conditions, but makes transfer slower and much more CPU intensive for
> less unlikely conditions.
> 
> As a consequence of the above the `mptcp_data.multi_chunk_sendfile`
> test-case needs a 240 seconds timeout to complete successfully:
> 
> TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
> 
> The solution performing data collapsing would need similar long timeout
> for the multiproc tests cases: mutliproc_even, mutliproc_readers,
> mutliproc_writers, mutliproc_sendpage_even, mutliproc_sendpage_readers,
> mutliproc_sendpage_writers.
> 
> Patch 1 is new in v6, and is actually a fix for an old issue (targeting
> net), included here just for my convenience.
> 
> Patch 2 and 3 makes the admission check much more strict for incoming
> packets exceeding the memory limits, with some exception for fallback
> sockets.
> Patch 4 makes implement OoO queue pruning for MPTCP and patch 5
> addresses an edge scenario that could still lead to transfer stall
> under memory pressure.
> Finally patch 6 and 7 improve the MPTCP-level retransmission schema to
> make recovery from memory pressure/after MPTCP-level drop significanly
> faster.

@Geliang, @Gang: could you please have a spin at this iteration? Note
that you must increase the timeout for the
mptcp_data.multi_chunk_sendfile test-case, as mentioned above.

Side note: with the "collapse" code this revision also omitted a related
few refactor patches, that I still plan to upstream later, since the
effect is a nice cleanup and reducing differences VS plain TCP.

/P

