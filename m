Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A547F2E8
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710438; cv=none; b=W8xOyeN86OKhDEsdafagnlJh/IVykMS4voDTyxJFzPnc/8NNwvMz/PMGVPJ+UyMzfYMRgitHti03dG/birB3HAYwl+EWeDHPtjt+WUy9EFMQz/Dgb86l4EFqvLV3WfqaS5Jp4fDynQ1ibyUrqsnGR7xZqMbo/B57SwFl4xAVnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710438; c=relaxed/simple;
	bh=cpgpeNsCoIMBsVhaUVo+UBuNeZNByVKz+9s/tGIi/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Endx7C8Xtrh1BebwLtWYwh5R0fGY4Oopy6Z3fTwXBgnNvIOYqYheKqEi5RvIhx5i/8c5HXRbIJ45YDDWu+mEM93ATovkC85QvOsONCNR/oi8Ep/rz2Uy/WQ+vh9B3cSXkxg4cHZ2hnIKFQVScsY/OreTA4zuHubzPSF6WbLtfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK6/rmE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK6/rmE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784710435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nhFsg6OZZ5V1qjOBDxxYz+AL9dW3XiGyn94pnMgP4E=;
	b=MK6/rmE24hT7Sji7TVYIAp1PTQ6g4ARWrxQoi8+rL4y7nXOuXpELJHiNIIlqg5F2t0cC6C
	DWQniPXBUhBMBSF+aoP/W3ifF2YnfV9dzuD7gy0IXi6fkIOPiH+rBqfNQitbrbmPq5r42U
	WVYx6N6ygex0HxPzrOWUQiMKujuatSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-1rm0cBjtPOu6SwH3KJj3OA-1; Wed, 22 Jul 2026 04:53:54 -0400
X-MC-Unique: 1rm0cBjtPOu6SwH3KJj3OA-1
X-Mimecast-MFC-AGG-ID: 1rm0cBjtPOu6SwH3KJj3OA_1784710433
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so39056755e9.1
        for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 01:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710433; x=1785315233;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nhFsg6OZZ5V1qjOBDxxYz+AL9dW3XiGyn94pnMgP4E=;
        b=XdUyU3gZmE4Y0z0TekdYP1aWy4Gdb6ddiPh2d8DpVn7M6ccfm+GpXOf+Y1at5fFtJm
         /yWe5JT+UjMiiSEEtBwRVmOAPcCrptdQGZlHvBHl+SI8pjhI1OfQPIkHsbrqRQnEeflI
         FJ8qdetqc9RuUHzhTgUiIrdeMdfmig7/NUwNXYQXWQ/yiNi9GTDv8q6AZmtNwDmLoY7h
         6ElmnWDzD7XMaLhMxaSeDZW0iDVvV4Zempe/AqCrU0siZHE+enqnkfIv3AG8vx+i5vpl
         CKG9XivHH9VsGyeI+rjlh9IL5LvNCNzssF0SKVu8AFSlgOADlhcwbZi07Peyr9O77ykA
         hapA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/rcpovZiw3gM7wNHbHHH0/jFEwOPcy7TrI48tBmBZEeON1Jxd4LRaG0XzQEjS5SkYh/oswg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyicKr6OreuFfVBX8kkXdOH2PJX8nmqDu8JyNuVHl8foVILGRrR
	JavQ+C/c1eYB9O6/RFzxmygFnA2P63k4d5iHb3VQKaCzOHKtoA+dww6xL0dzjctPhN6KIuZqpC0
	LG1RLabod+4bIZwFr8PpOUPtUsE2/2FfN/55M18Dv1/5dgVQTXWsT/Atj
X-Gm-Gg: AR+sD101z7ybU48+9Bpde6GGI+3c+N2A9ZV6ohZ09xHXCWWbiy0t5uI/7LPRHEXBphz
	KGGq38T6ecK7y8VfTGdtfTxQ73hV51mZn2qyr/6eL3rO6sZJalitMuSUXQkFYUx+fzZWbA63k+6
	+6h1Kgu9YUe1wxhGwe4Y6zPza1O0LYmQobm9FMQ6v1FblKQ/y7oUxZQseCsZzlqD+6bv9eGRZhq
	yOhzKSNoOlkRzxhizOvsPuFoYGWAbc7T3NnaE0/Hs0JzWAiG95d50Y6B1VAxg/ys1V6ckAXtpPh
	MBVTF42Hguk9c6PR7I9hEbGaJ6eya0A42m7MTsREmxV1m+tneneOFiCFMu/ErGigYQbFPbJqO1b
	7YD6ymRyO3+TDUN5Af0i3tdoiuI5xWRm50Z+OJjEa7Y1VAMgwBc5XhvG5C3hD2mX8yI08mKwHVm
	TxCQ==
X-Received: by 2002:a05:600c:3b1b:b0:493:ece1:86b9 with SMTP id 5b1f17b1804b1-4954a3d649fmr259413325e9.8.1784710432676;
        Wed, 22 Jul 2026 01:53:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1b:b0:493:ece1:86b9 with SMTP id 5b1f17b1804b1-4954a3d649fmr259412965e9.8.1784710432234;
        Wed, 22 Jul 2026 01:53:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm101914865e9.8.2026.07.22.01.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 01:53:51 -0700 (PDT)
Message-ID: <7414ed23-7e9d-42a6-8e7f-9ed579830a01@redhat.com>
Date: Wed, 22 Jul 2026 10:53:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev,
 matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
References: <20260525194828.1137119-1-shardul.b@mpiricsoftware.com>
 <cd1fd42a-5a45-6d8c-051a-fc1be8e613c7@gmail.com>
 <470388a78561b920c51697c162e3f7f210d9cc1e.camel@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <470388a78561b920c51697c162e3f7f210d9cc1e.camel@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H0Vz7BoA_57NtqrCyDUFKl2ZF2nTwQM28rMYpCc-uOg_1784710433
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 8:33 PM, Shardul Bankar wrote:
> Gentle ping on v3. It refines the v2 check that tripped the
> regressions, scoping it to just the divide-by-zero close-path case. CI
> on v3 was green except for a single Unstable flag (packetdrill_dss on
> the debug config) a flaky test unrelated to this change (it passed on
> normal).
> 
> Does v3 look acceptable as-is, or is there anything else you'd like
> adjusted?

I'm sorry for the latency. netdev PW backlog is killing me.

I fear this patch may introduce another race: if a ssk with
!__tcp_can_send() status reaches mptcp_sendmsg_frag(), `mss_now` could
be zero and we can hit a divide by zero in tcp_xmit_size_goal(). I think
syzkaller hit such race in the past.

Re-reading the patch changelog it's not clear to me the exact timing of
the race this patch should address: if __mptcp_close_ssk() leaves ssk in
a !__tcp_can_send() status, mptcp_subflow_get_send() should not pick
such subflow for transmission, as the latter explicitly gates subflow
selection with the same condition[1].

Is the repro using a BPF scheduler? Can you describe exactly the
sequence of events leading to the error? The decoded call trace will
help, but will not suffice in case of another process racing on the
relevant ssk - I think it's the latter case, due to [1].

I still think that refining the approach in v2 would be better. Did you
trace why self-tests were failing? I can't find a reply in that old thread.

Thanks,

Paolo

