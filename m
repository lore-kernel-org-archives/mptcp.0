Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752156;
	b=IDTxUk0PKky2n246eDwVE0XtUR0aE6bGvvdGGNMOZHwi5cbUuVtR6/3OghcMDBH4yQkO
	 oHojtZEj/fUZumdY+j+KZOzzYm6ow3HxUYrlNT/5na/ODFOl1hDOTojkzp3rWvaEPiQ+5
	 0gg7PJL48W705WS2iQvMWDdOtRIvMmjNefx3GY4jcTIyaxOAONhex33/8W2rpF9CCbfm5
	 jXJ94l4d7DegNj6hFUzbC1FdYG1LXpgJHFlncRfKrIhBEi7Pq6W/+sPr60JFc/b5ELOFn
	 jy3ttFSzdcchhWqnxprpfbhoC36numpEls8o2HPdhNfXB2EMt9c9/RSwDsiyrCdcW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
	b=5XU/Bi8jrQ6RBfuUGSUlCJGx3PRgf3wSeFyekDxxpeeRIDfOdSFC9u8uEi16c8E6inky
	 n8BOoUbb1JHPj2UE/8H7mTOsFLYJd3jengW5fsPJnt6RCbbzDMLWqpJVcg4zwxt1de+J+
	 BB+ATE+EGFvMCy+uLXPZlAVRUJzzqx74IInCJf1lChwl+ecRQ0i4sG0tX6ThWJMDXCZ1w
	 w5ubFXe6pgGb6U0KXp/VutINLgCvVHoRQIbQ9WaBAgzBbvviXS6+oo/BIBuh+lsEGMpZo
	 BjPRoDrq94Uq91XISXgJ+5kQUP8ZslNCYcri4+sg0JUj5zGlPR/f+JDpEOCuWXDpmqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSr2UEZR;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BC606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 00:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSr2UEZR
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab938dc83so65162a12.3
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752155; x=1794356955; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=hSr2UEZRQcPd4J5iVe2TbyK5O1FxnT3s4Oeq6HvPcXGwHIGNnn2jrS8auq7ySEk1y5
         lVhyzqmY60DI488ycN7q0jPBpW2Jtqop9piN0o+exsWnD8KEv2E3E8v9R98M+DKly12x
         xks8bE/HrMcB4m2Y1K4ZML7XRe+q/E7tf2MUg0TH1NWbYeMPU8mTrLhpz5OmukAfXMcF
         CD9fONvgb1H7EtwxMQzIzJZYFBweRXif0GF8n2a8eC88kmNgkcGAjm4x5GdnTfwHBli0
         TTggmnsB4R1flePjuMDrxYWuI83T0nyMdGfIZccwbDBXAouIAH/XWWEm1gdxrO7Oj8XP
         dj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752155; x=1794356955;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=hFqT9pUo4Z42knUmh+uK4f4QXbq5KIMDbOy2R8ncrh05xM59G/vbi7tg1Bmm7Ykd9u
         cqZ0D4a2YC4vmTv3agwpvBEwP7O0I/+ez3/BjMgqZbjyZe1m7Fb/AsHIY7xQCPJTXAFW
         6ur/AkL/l5y/3ucCpe+Xmlc7YaGClkTyfLXvVFeMIuzpR/dmGkbGZTVu3q8OZfsF+pg8
         V0XOF7PIHOi/2GckVkALs4zVSFgdW69a6kY9ki+A3BEQe4B9XIP7t24v0tccQquNDJaA
         XI6X4qR7YNEVGby/n/tjB90ZpH6MXAZSXYiBH9tV1lpkEJTgs8pjZmtlgOtWbhjoZhUR
         9hlg==
X-Forwarded-Encrypted: i=1; AKwUvBwEei4Yo/dZn8z4qrcEVOPFA7O0Kt1WFUdocbI07ocQYlzCEqiZnGC1HT3ZS8MwK+RaR+fnLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8UJgtydwlsm5osAwdWg6ZQVbSDSfc1HQXXuliNaUG9TPysdPMT
	/W1v2q7TSZfxr/XErduUiK2ao3mnAzvGA8vSlIQqlGWlwulaReZrm39B
X-Gm-Gg: AYBFou3ovVzOJq3nzcY2jJvmzpr/Bub/BOEIdKTQoLPAKstThJHMeRdjHKt/doOuGng
	3TO0g8tZO39oG7bOizFGOGuzCOjdxDqeu6jRUxsLNwB3xCeJC6hoxNA0ybh1SCzd096TUYVpNzC
	zZSuS/j2z9rj7jNAnoxyYXesgSLMfeoQpCWyJwdzqr/g+w/Qcz6yAu3mKOLzhpBBZIzRTQ/qKMo
	bUfVR5ZHhF5KxtzpUm30BpVcXyiUMQQThWHhTfSMGyzAEc7uOwsezOwRKlWQigfIDjJOxQ39jd7
	OrIpvghZQ2jUJy4SUoU4gTtD4OkizXMnPOLfIlWWy5GXZVW7iQzjbpWzV+Zv7bChL3W4eUr5pJw
	GJPfEyJfUOrDReqIYw5t5SAeQkq4NnxBNt80h4f54Yw1CnunKgDZ17SeTxRCs5UKNyeTD/KRTmD
	X6MfqypOMYSCx1UDxw38imSgLnR1IryBLU9tAWoQlKpN8GymxN5VzVdfs4W8aUcMyIKMj77BGGD
	+iKQ1IEpccQsOYQOpHSWEMHw6gBw8qHRdV1gTrNrDNd/oJdUfLapMuMeeGXgZia072eZDP04Wee
	yFShEpBa1o0hS1sQa7kJH0YdqFkzF6CrEXEyOjaO92y8cZo7xoNJHUHQltUDqemW4AzdMlZmhMp
	jLYOXItA5xljG1eS/M1/MaLtM/UCR+BNDhA==
X-Received: by 2002:a17:90b:588d:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae8970ef58mr11861580a91.14.1793752155221;
        Tue, 03 Nov 2026 16:29:15 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm6514115a91.2.2026.11.03.16.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:13 +0000
Message-Id: <DMM02JFDLH2N.3UXPNYN6KZ5JK@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP
 listener
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187870.488855.7800063583184291863@kernel.org>
References: <20261102072112.4160195-7-alexei.starovoitov@gmail.com> <179374187870.488855.7800063583184291863@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
>> +		goto no_progs;
>
> This only checks sk_state at insert time. Can a socket that was inserted
> while ESTABLISHED still become a listener that carries the psock's
> sk_data_ready?

Yes. It's an old bug, not from this patch.
This hunk is for a socket that listens when it's added to the map.
For a socket that listens later the patch fixes the children only.

>> +	if (!is_insidevar(prot, tcp_bpf_prots))
>> +		return;
>
> The callback reset only happens when the copied sk_prot is a tcp_bpf
> proto. Can a child copy the restored sk_prot together with a stale psock
> sk_data_ready?

The window is there, but it's tiny and it's not from this patch.
Without the patch every child of such a listener gets the callbacks.
