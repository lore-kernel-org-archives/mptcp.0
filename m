Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D070
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 08:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620807602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xQthF08t0tsEzUZqn5EPerh1VYoI2ynd8DUroHIVPg=;
	b=b49idc95KU5mA1BGb04bAhrOGSHoaWLLwpcV8cvme0kCz+/0xYC2UFxuKCRRIqGHgSykRI
	HLiY50oC9a1H3CJroOI3nbHZvYCaz89r8IiLMI4wpd4iDN1TNuWrc0pjXeo7mYFgjPA79Y
	+bHw028ZtzCnzFdOrALJ1Gg+sm+r+AU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-cRiC20IrOtuP1EF8CktCbA-1; Wed, 12 May 2021 04:19:59 -0400
X-MC-Unique: cRiC20IrOtuP1EF8CktCbA-1
Received: by mail-wr1-f70.google.com with SMTP id 1-20020adf93810000b029010fd5ac4ed7so266642wrp.15
        for <mptcp@lists.linux.dev>; Wed, 12 May 2021 01:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0xQthF08t0tsEzUZqn5EPerh1VYoI2ynd8DUroHIVPg=;
        b=odeAj3Rw2A/OR6vcdC3aFRxbgV22fPTJCsLncU4YYuzYCWuL6+GWxyAjIvx4Nudf+z
         ef0zJNHYrzrib3aek3tsrgtaZg+opTOetPBqzGsvzbJ8DEmU9HQUia5XUyhT6f6KSbs/
         7I+kD70EiTH4wxFTmOngctzNDzhgJ11kyiVJ64D83r6Knx4vYiI3A/A2t1pqzciooF4P
         zGXfqLyqaUYceurLTs5kYrspu0v8xEJlmYa/JxThHH4D6+qTaUx96EdPTiaql2ynOhdQ
         UZ/6Q8BCGjeoHqXiUa1X0ZBeE8X0QZ7oIx2U+Uxd+qa6OHd/UyEuTC5eKaNc2cv0Y+7o
         f9bA==
X-Gm-Message-State: AOAM533OliaPyBCyxHyZacqTYdhNppAUd5rKaqcd3FEKifQUC+iDTZc8
	uTscF/fSQsrRDUiGvCRd28vFD8DkPzMOFhNjWD1fR6t6hrnq4xoqqIBAvzWVjcMsVo+o44mmrOs
	+WH5mdg4WVpATY4I=
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr43427544wrs.414.1620807598500;
        Wed, 12 May 2021 01:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCpzUP0cnEcInXGBouk3vtLAekHpIqOXcjPKz5+eI9hJl5fw+2yxpnZvHaeDgkK1I0YIoGtA==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr43427527wrs.414.1620807598314;
        Wed, 12 May 2021 01:19:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-107-239.dyn.eolo.it. [146.241.107.239])
        by smtp.gmail.com with ESMTPSA id t17sm28399458wrx.40.2021.05.12.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:19:57 -0700 (PDT)
Message-ID: <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Wed, 12 May 2021 10:19:56 +0200
In-Reply-To: <20210511133659.29982-2-fw@strlen.de>
References: <20210511133659.29982-1-fw@strlen.de>
	 <20210511133659.29982-2-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-05-11 at 15:36 +0200, Florian Westphal wrote:
> The setting is only relevant for the msk socket.
> While at it, also handle rcvlowat/rcvtimeo this way.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/protocol.c | 7 +++++++
>  net/mptcp/sockopt.c  | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 652e55a0c6e8..86e599eb4403 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/atomic.h>
>  #include <net/sock.h>
> +#include <net/busy_poll.h>
>  #include <net/inet_common.h>
>  #include <net/inet_hashtables.h>
>  #include <net/protocol.h>
> @@ -1982,6 +1983,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len, addr_len);
>  
> +	if (sk_can_busy_loop(sk) &&
> +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> +	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
> +		sk_busy_loop(sk, nonblock);

If I understand the code correctly, here we need a valid sk-
>sk_napi_id. That field is set by the TCP input path
in tcp_finish_connect()/tcp_v{4,6}_do_rcv()/tcp_child_process() for the
subflow ssk.

I think sk_napi_id is not currently available for the msk?!? 
Copying it from the subflow requires some care, as the msk could end-up 
busy polling on the 'wrong' napi instance ?!?

/P

