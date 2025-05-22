Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D55286881
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904156; cv=none; b=P20Ev/SMzy3hM6vSFye+qw13PTezaN0S5rm7goPxmy6CODh9ntaoHLHGKMInFVQqw8VmM0vyvNwXNHGawILgfLUquOp3ayn7tlKk2jtIgw5/EbjE4gtAYJEoNJuyDGCDfqAMQcPgajvMBks7hkkEDztWZ0P563KBurWxaCledVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904156; c=relaxed/simple;
	bh=4ASId0JH+VWWZL3IFUBP1dU99/1eNzfiw9x3qfiCG40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVT1/yVRLlmINuwvXxJfjoxJtL+kgsRN/AkmJq8dV3PKh3bD+OVBGUfApcVGGdv2nqY/ha5D3HvSw8YE1m1fNMtxkL2mEihHWAmRQ+3wDr21JyI4vHhpoeWWiXdRVJcN6tbyikJeM1Bn4cz8d0cprPD5HknE6E7wEaVMe5AgHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plt04XWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plt04XWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747904153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
	b=Plt04XWpD0bB8dXYd4QoNbQDF4AgWT6uIaeogpiXA9rEz52Hh5ep5OgQKVWcixMJ/+f/zW
	du/U3k/x5CODoR/41rwec+6SabIIeWnx/QMuATan/L+mZFg65/F4C33pizSenqVh7wewL8
	fFgU5gEOFQBoBZ8MMYY5JIZO146pjp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-pHP4hPh-MgiDnfEU9E1z-g-1; Thu, 22 May 2025 04:55:52 -0400
X-MC-Unique: pHP4hPh-MgiDnfEU9E1z-g-1
X-Mimecast-MFC-AGG-ID: pHP4hPh-MgiDnfEU9E1z-g_1747904151
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-441d438a9b7so40914895e9.1
        for <mptcp@lists.linux.dev>; Thu, 22 May 2025 01:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904151; x=1748508951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
        b=h/70rWUiOBotoVYBX4Ln1oVHRTvrZyQ1i/B8IL+1EuyUzzIO53sQD9QWdHmkQkoLTg
         Ot2M0HD4ttmgis01CN1CLvVuNw7d9ExkRh+xPAPjIQqZh+KHnz/8rJ1V1mRc0JHhe2dt
         qPasN2DOQxEXOc+5n9R8iA0+s2etF5ZnzJm1AfisqwAb1HnLHG3yutKEbSSNWVlwsf1O
         fQea6VfbIknsPqdA6PwPO4Ld20RsUPFo22+fxgkoID/5X7du8WvpjXRQytNnBb8y19lH
         g0iacAVvtDNmWraxS1IsXfEDHvd6hwHYvN0S3JJJtTewnrpwTW6/nMwxKntottc/lp2S
         U3ng==
X-Forwarded-Encrypted: i=1; AJvYcCWQcPgnQK/VNf+9fJ61jew1NSLwRmmKBLPdIfUvz4Z2+1D0cZk2H1L551CryqH7QO4Wc6aKFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3sRfrsZpBT/7jOSncmRtvEvHZVEegb621vC5GuLx05ZEGqUJ0
	gefP26yLg6SurvLc74+gY8nQsPeNlpW9NyEJHIgIgrq7zBT4YVpgb30hOkRX8L71Xkfmy4Uz4cO
	LZnLfhbsskW6zFkGlm6LoFFMtlpBeIzz7v8i1Dd0+B6vUzAs+mWmwaO/e
X-Gm-Gg: ASbGncuEw8ZoVtwai10VO9YLuC0zS8+8ZArmwqSvBoOIZ+288qnJ8H6w7hmmRsxb9Pi
	h00jhsEgMZtFP85fYBwHktIFqM8HZXuUUv7qp6hRped9MGd61cPipOk8kaiu1B9P8kdPz2pPDeS
	FEwAjyfnKtkp3YuQrlQ3OaM7wAKOoksLyNukwyWoqtE9zgtKnnKSxxa0Bs+ckf09T2FHlhKbHVM
	B+F9OYoZyhLi8PXKkzgMs4cIha3xTrj+bQ+IRg0MBPirAu1M/fp70I5GUeOHFi+cT8HR3Q2+7Q3
	xo1EXIZ+5BNPS2E+LBU=
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238625e9.13.1747904150751;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZWLfHYdYPfwzdbwFycNAp7aliAoZubbXRRwKwS5IPvqLZEKoM1L6RvMRd6G8MB4cd63apg==
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238455e9.13.1747904150355;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm99616195e9.19.2025.05.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:55:49 -0700 (PDT)
Message-ID: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion
 except for net/rds/.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Matthieu Baerts <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-5-kuniyu@amazon.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250517035120.55560-5-kuniyu@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y_RNPrd3KlXWEHbHW_OIicFHFugxX-ypu9VaG5rhDsg_1747904151
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> count the netns of kernel sockets."), TCP kernel socket has caused
> many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have
> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> 
>   __sock_create_kern(..., &sock);
>   sk_net_refcnt_upgrade(sock->sk);
> 
> Let's drop the conversion and use sock_create_kern() instead.
> 
> The changes for cifs, mptcp, nvme, and smc are straightforward.
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call __sock_create_kern() for others.
> 
> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> sockets.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

This LGTM, but is touching a few other subsystems, it would be great to
collect acks from the relevant maintainers: I'm adding a few CCs.

Direct link to the series:

https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 37a2ba38f10e..c7b4f5a7cca1 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
>  		socket = server->ssocket;
>  	} else {
>  		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
>  
> -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> -					IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> +				      IPPROTO_TCP, &server->ssocket);
>  		if (rc < 0) {
>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>  			return rc;
>  		}
>  
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);

AFAICS the above implicitly adds a missing net_passive_dec(net), which
in turns looks like a separate bugfix. What about adding a separate
patch introducing that line? Could be in the same series to simplify the
processing.

Thanks,

Paolo

