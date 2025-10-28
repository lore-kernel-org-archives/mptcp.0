Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F83090D5
	for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651039; cv=none; b=d+wM1vdgJE/Pon6qQEyx9F3isq65Oux9npSpfRuP77RgSiP5Mxw14sYM9fdJy+Nhlqqjb7MRI984BlX1p5SH4y+7A719ovDT6h/3FuXykALmjAv4v1iBAFw8rLy7ZDGWAQtNWwcRSx5/NVvEgxXWEuwThqYfdbloa/5Hdic8kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651039; c=relaxed/simple;
	bh=uLz1nCOc13P72Z9cLqgJATuBA1im88R9TxqI9YQCXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co7yjDbkaH/D/qqgDeyclaM3H4g6jdjYtqVnWIJo+rUHcxwDYKFvT7LuRNlFoY5GZP0Q9Om6mcH1RMvtG6HJ02Ese4J5FbU5Jre2zT7wbJn2++UN2/89jetw6VKX2wAvgoLlwDPtsXPecNq9tYUao/k6GKOKX8Mf960XDtaRk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5gZQ4j0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5gZQ4j0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761651034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
	b=A5gZQ4j0xLIsGcgO2HUNkY0U3Ui72riAn6/pLfsfJd7vhw4IgnyBoh2JVae9HT6iOgOwoJ
	uVgnFuqWFL97Ame9GmTrOYjQ87bSePLcY3PN9MgPT014WDkm7JiVKr7Uh4Lx3s00auQPUV
	rOJPnxtTyj+5Q5dRTbHvP5VcPmJ8v5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-QjIuMpjOPg-3vbeXOybHZg-1; Tue, 28 Oct 2025 07:30:33 -0400
X-MC-Unique: QjIuMpjOPg-3vbeXOybHZg-1
X-Mimecast-MFC-AGG-ID: QjIuMpjOPg-3vbeXOybHZg_1761651032
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475ddd57999so27021055e9.1
        for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 04:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651032; x=1762255832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
        b=vm/k7PllfRi0H6WBneq1mSMd7sU3v6vwiq3g0ZOKbQI9eZxfdSy/TA/rV9ZvOjeHwZ
         LPQDp6bKGHv8E4tvu3lwtX05pdhAW9Z/l/zK20K3P9RzgyvbFNPDBhsHZPRzb/QuhIwn
         dmz7BW7l1WUTbbiQrbJFfwgpsnUXUVG4EaZf3lOhKyvvdTpI388igtxGkTCTBNrHY8ec
         PRLbnxtsbmVgyr+r4I0mCxOrpc/SgnyDDMGWy4PjvBcKNVBBWdTkWnj5QSOf/XdSQtO7
         bHTLklE4mhqv7PO+mXUYc8DSYux//KlACzIgZmXaRiY20jJ+84a56W+OERnGw2K+vv4n
         R2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUpa9m9yjN711zzny4k1+1CUHC0qgQeKLH9MLADr1Z9zbx0zKcsC0qZjfZw/caOgofSmoHyZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzx+zM2QP0divIaYzSdk/Dw05l7obkSz258wvbBTVTI+oxj3rGr
	NWzXNrK1OySRasXPWOknTPzDUckoPlXMCpObI3kzopzJfsKpRpLWT9AaJ9vy7h92RdyVcVUNU4f
	k8c7GZbR0HoTG3UreRyxEWv3aAPl2JmqgDLoD6A5cFwozEXjHM9dn+RG2XtBkFOwx
X-Gm-Gg: ASbGncvUqr4Sb5DWxMWHziv/zxaFJnumdkVpHmr/2hdBfEVOazW9Io5W5qnMf3DVYGt
	SAQGzuuX7K+Hceeg0ab6089GfMlw3GWIKQQypMJEJTq2taU9TZwLzL1bR5Cao7UqQCyW5R/2uHn
	NSVm2nv4/TNBJ7Zbt+B4PLWjQ1fYqYc9RZI0Bth+jvltljZevx1tzywC4+EMeIg8esYeL8YhDPM
	qEDQY44VSyKdDUwQ8rdTsRHgyRlDdunbG3o4i1sI79AWFvSdAgdnKTKiYnPNEyyoh3NwisSrxf1
	9Sl6sPeS1ijlaaS2XC+96KfGMUY2yjDJngRIqW21qWFW4WojZyEEKoKw155jyuPquLNJLAtPGvI
	wd/qUzMy42beVXxnednxI6GdUXSRyV3d4JIxIlxbx/lXzgBs=
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034665e9.35.1761651031637;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UoWkDkAxEnPYbIqlYF36LNiS1od7f4r/oylsQ8lGjLYMkIaaEI5SdiPojR2VWZlNQPGbIA==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034235e9.35.1761651031148;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm187152685e9.16.2025.10.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:30 -0700 (PDT)
Message-ID: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Date: Tue, 28 Oct 2025 12:30:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-2-jiayuan.chen@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 585nG1yvVFPUvInGDOTkQMhwARhp56k4dm4ykASci4g_1761651032
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
> 
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.

I don't see how sockmap could modify the to-be-accepted socket sk_prot
before mptcp_fallback_tcp_ops(), as such call happens before the fd is
installed, and AFAICS sockmap can only fetch sockets via fds.

Is this patch needed?

/P

