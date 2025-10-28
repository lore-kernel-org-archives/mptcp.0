Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F930DEBF
	for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652055; cv=none; b=fNHFi2LXPerTzjlbnqlWZGYc5/A0eubS1Mr+VutWceE485/MKudn8tIjPeYhdonR2pNkBjGYkorIZ6onbaNX7WL5FRPONoEBF4Ng6Te5IDVTo0r+RLNZYX4KVWmxc6r1YGTPZ7Oedyyb/Pplgi2Tqt5LA62SUspYwgeJPpvhkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652055; c=relaxed/simple;
	bh=hTHSTmvO2gcuI9bvffQRykt0y1SGaZooIAbSqmRKxWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fy8ZQSmR3b9SqHjblJKfWmLgeYx9xMkzewV4rd9ymKasrpEEXinJJLIeL/MUUvNVJUeKp8L8P7oEeLyqePpoGenwv4xmIUMfGeWiT7asSAkhJf04vvrAs1iJLpxs9kHMSDm/LwNIhNvvI/6+9ClIsV7OYAav2nEqv1uTVREt+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AA9haMyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AA9haMyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761652052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
	b=AA9haMylBAidafCPCHDsWLUkv37h7NL1XI4lk7FudkS2N2t/nbQI/gG6K84hzbZDevzl7f
	m+p1S6uKR3lfPYFsP14GQY1bUbI0xhJdOy0dE5Zp8RAVyTRyTHSzoWteD2QZxW1CZEWVlW
	o6QudmcANfiRdMezzYtk4o7oAIWx3w0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-UEa5Lj9yOCG-IoLzJDS3rA-1; Tue, 28 Oct 2025 07:47:31 -0400
X-MC-Unique: UEa5Lj9yOCG-IoLzJDS3rA-1
X-Mimecast-MFC-AGG-ID: UEa5Lj9yOCG-IoLzJDS3rA_1761652050
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475ddd57999so27172315e9.1
        for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652050; x=1762256850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
        b=Jg91Yl5rxRkzW+3JVB7bmnFSt9hhJZij9h6ke+2XExP5wunr+ZkFI3adWeXB9mPAng
         9tc9mIZ131J3fKks1zoPF68P0i1NX1Mhkb2e3L3qymdYR0LMkV1EwvwoYG8IRUrcOquH
         ZeaRJUbeI2iUaNFIhLvIizwhU6Az+vEobp8d68PoVjMdE0PTS7sXbqSw9V28UW6YcMUR
         bsc74flNfdp2gBJfaVsO4UxeyyfmUUwy3y50JqDwlFlfldOxj53gIaaiz8wsruNd5mK+
         saJk3hOCSuXOUlBu5SFpgqDDtIWf2WkfBQClXztqNlu9GAUHiKTX/ELkvImuOljlEZZK
         Bc3g==
X-Forwarded-Encrypted: i=1; AJvYcCU38jBd44b75DBNHUogZVtodcJK4XTkyRKH9LpMR62lBOWugAwGHwyIHBJQHCGlPUqH8RvMLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydRcBzohGEnz6FQinjHMLwRbBpl+d6aR51bP8Zsiz2IQ+he5N4
	VdWzudqxMu/UndLJzugGmaQoYVn6ie7mPnAhFPkFyLIJOjYdg9K7fWTECQdcuAZwwlgKlWYkQ8w
	ql7yf6SRgEbvHuFONUL7EeeznoYEmbSzFVYv5QMi6rRpRbxhrDmqaLKHS
X-Gm-Gg: ASbGnctmC36n0XJqC/0Acll0FrCMiPzKHKcbDkXjJxbfWxGF7Xa3B1oRuWbhENPq0iA
	Mo6pSrzWihVj6k26f1hrq1Aw4V8nkNsK0pyMgBaHJWs/scRrBkVZgoOo7o5VHRnOEE0jesEmaJA
	P5V6HlvcjW1xtHZJBZLHXTbWRqb8sHqVpxPff14ubxMZqnLPl1YJNCp7+P+VcrIMYlvpZWiMCoo
	FOEFcCbLAVovFDQ6KwV+s16IN6k5M0R+kV9HoChkQudoEbQJhRxHdw8WB4eEV3n1xvH20ClEfSe
	daqZkHE2QTJsDiBGRqn0cxw3p8qCT3AbXJxYEG7oSU/uNbveQ+mhfd9aYWehdy9uxgsDcVpPwx/
	wlQipQEbYw/iatb2dO1/mwRckQJOlBBVVLk8Bdqhla59afio=
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366965e9.18.1761652049821;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYsmPrnr2n5dOG2TMddpHesTATKrRY3s7taqm1slxtVNIFUzWMD6kXpI/krQ6+LdMW9yh+6A==
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366375e9.18.1761652049184;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm194874245e9.3.2025.10.28.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:47:28 -0700 (PDT)
Message-ID: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
Date: Tue, 28 Oct 2025 12:47:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
From: Paolo Abeni <pabeni@redhat.com>
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
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L4eTKPmIc7B6q4Dqp_QLyDmmQK5uKl0EYd8horg334M_1761652050
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:30 PM, Paolo Abeni wrote:
> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>> When the server has MPTCP enabled but receives a non-MP-capable request
>> from a client, it calls mptcp_fallback_tcp_ops().
>>
>> Since non-MPTCP connections are allowed to use sockmap, which replaces
>> sk->sk_prot, using sk->sk_prot to determine the IP version in
>> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
>> incorrect ops to sk->sk_socket->ops.
> 
> I don't see how sockmap could modify the to-be-accepted socket sk_prot
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
> 
> Is this patch needed?

Matttbe explained off-list the details of how that could happen. I think
the commit message here must be more verbose to explain clearly the
whys, even to those non proficient in sockmap like me.

Thanks,

Paolo

