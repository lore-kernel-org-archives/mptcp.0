Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A2173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642413525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFkjQ0wbKZ91QFZWKrTfdLys1t0YfgbLu4D8i0oiF8=;
	b=JQFMQCb1z/0q4tWQMVFZzvs3nKwuR6dgCD3tI4EznHGLTKrxTpUaIfnMSx+yYxpy/0qGeZ
	9LcHkkBo4dEBc1Q5wePI0OR3R6zybnJ88paX1heCvv9KGrD8XgxqX+zYqqXpMEzaOJ7PuO
	vEge06iDF3T5Ur3eAD47LZetxXI8HvI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-1QoYEpPFNRy4Dg37ind2nA-1; Mon, 17 Jan 2022 04:58:44 -0500
X-MC-Unique: 1QoYEpPFNRy4Dg37ind2nA-1
Received: by mail-qv1-f71.google.com with SMTP id gc11-20020a056214230b00b004178c9ca8d2so15078613qvb.7
        for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 01:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AoFkjQ0wbKZ91QFZWKrTfdLys1t0YfgbLu4D8i0oiF8=;
        b=aq0wMI/9BxGfYg3zJi3FPOnChPpk23nQPfUf20CFLWf2iDK80QxbccHvzcVExQeCtD
         El1Zm0fnf/JDx+OMXEYaDjfW/FeJfFsyvqUO0UZsNLMx4FZmWJEfXM6OPIs0jEcdUaSt
         1KB1ifETFzYRfiRVZtL9TrwFllbkFBIV6S25EFzOsHkWw25+bgSRbzLm8/IO/vnPfXuB
         2syyRKXaJRcW5+QMmjjVF9A3GJ2wmMPduorb1UQwDekKnZ+1g8Rs0TmMxz/vE5qGVTda
         eaBtCSUGPftHLvofBH37sm7xTl1vAICFywHeOAb754we19sf4aiWandTVjST2TlG36PF
         ecCA==
X-Gm-Message-State: AOAM533uamIf4ZUgiUnu+fohpic2lKd1Nix1HJyxIWequIxX+GyN3rmL
	HuVz/CqOmU2KTL48ER+O15VY9GPCdEKKcX7VuSVzKNYpAUGBj/79cJRnOeNix7DhDHh2CbMgpee
	Kpzw7YggvVmbP/WM=
X-Received: by 2002:a05:622a:113:: with SMTP id u19mr9752755qtw.475.1642413523694;
        Mon, 17 Jan 2022 01:58:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNQS4YjusUQAPFOeRKNz0XPKUBUtx3ukY7RbW3Q0orXGke2V8UIJ8MX3HmNq2fDfoGKtC9Mw==
X-Received: by 2002:a05:622a:113:: with SMTP id u19mr9752749qtw.475.1642413523372;
        Mon, 17 Jan 2022 01:58:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id bp42sm8728504qtb.61.2022.01.17.01.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:58:42 -0800 (PST)
Message-ID: <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 17 Jan 2022 10:58:40 +0100
In-Reply-To: <20220116001259.203319-1-dmytro@shytyi.net>
References: <20220116001259.203319-1-dmytro@shytyi.net>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
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

Hello,

On Sun, 2022-01-16 at 00:12 +0000, Dmytro SHYTYI wrote:
> This set of patches will bring "Fast Open" Option support to MPTCP.
> The aim of Fast Open Mechanism is to eliminate one round trip
> time from a TCP conversation by allowing data to be included as
> part of the SYN segment that initiates the connection.
> 
> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
> 
> [PATCH v2] includes "client-server" partial support for :
> 1. MPTCP cookie request from client.
> 2. MPTCP cookie offering from server.
> 3. MPTCP SYN+DATA+COOKIE from client.
> 4. subsequent write + read on the opened socket.
> 
> This patch is Work In Progress and an early draft shared due community
> request.

It looks like this is more far from an RFC status than I thought.

There are a number of tasks to be completed for that:
- do not comment out existing working code, expecially TCP one.
- split the patch in several small one, clearly documenting in the
individual commit message what each patch is doing and why.
  A possible skeleton could be:
  * create the needed hooks in the TCP code, providing a dummy
    implementation. Each hook will need a solid justification, 
    and they should not affect the TCP critical path.
    The number of added hooks should be as low as possible.
    You should try to use the existing hooking whenever it should be
    possible.
    No patch should touch the TCP code after the hooks are created.
    Side note: I'm unsure if any additional hooks are really needed.
  * add the real MPTCP impl, possibly with separate patches for
    the client and the server side
  * add self-tests
- avoid introducing white-space only changes.

There are a bunch of specific inline notes below, which are still very
important.
> 
> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
> ---
>  include/linux/tcp.h             |  7 ++++
>  net/ipv4/inet_connection_sock.c |  3 +-
>  net/ipv4/tcp_fastopen.c         | 42 +++++++++++++++++++----
>  net/ipv4/tcp_input.c            | 16 +++++----
>  net/mptcp/protocol.c            | 59 ++++++++++++++++++++++++++++++---
>  net/mptcp/sockopt.c             | 40 ++++++++++++++++++++++
>  net/mptcp/subflow.c             | 14 ++++++++
>  7 files changed, 162 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 48d8a363319e..d7092234d442 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_buff *skb)
>  /* TCP Fast Open */
>  #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
>  #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
> +
> +#if IS_ENABLED(CONFIG_MPTCP)
> +#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by MPTCP impl. */
> +#else
>  #define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
> +#endif

You really need to document this kind of changes in the code, possibly
referring to the RFC bits requiring it. 

> +
> +
>  
>  /* TCP Fast Open Cookie as stored in memory */
>  struct tcp_fastopen_cookie {
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index f7fea3a7c5e6..4b4159c0258d 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -501,7 +501,8 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>  	req = reqsk_queue_remove(queue, sk);
>  	newsk = req->sk;
>  
> -	if (sk->sk_protocol == IPPROTO_TCP &&
> +	if ((sk->sk_protocol == IPPROTO_TCP ||
> +	     sk->sk_protocol == IPPROTO_MPTCP) &&
>  	    tcp_rsk(req)->tfo_listener) {
>  		spin_lock_bh(&queue->fastopenq.lock);
>  		if (tcp_rsk(req)->tfo_listener) {

This chunk is really not needed. mptcp invokes inet_csk_accept(),
passing the initial subflow as the first argument. That socket is
really a TCP one.

Cheers,

Paolo

