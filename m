Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E007462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663684631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSnTMY5hs7siGJexDhfutae2txs2uAybXsmWH5JELKI=;
	b=U2qALmvEA4YzSZuxLqjtl+DJTdazi93KTmUZzMzLF/NVl9FdGecypgEJlVsbQYxfLtR+71
	W+04dGNjGID22XE9Tm6gsY1dv5b/iRnSiRTl0FXKbt60/0eYTgddtCJbInlx0s4Mo6Txr8
	sk/VFQv719tzPNTWQq9m0RfWIQUi1Gw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-YiHTTc8tOAOpjXZ0nKY8xQ-1; Tue, 20 Sep 2022 10:37:01 -0400
X-MC-Unique: YiHTTc8tOAOpjXZ0nKY8xQ-1
Received: by mail-wr1-f69.google.com with SMTP id q17-20020adfab11000000b0022a44f0c5d9so1239215wrc.2
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 07:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=BSnTMY5hs7siGJexDhfutae2txs2uAybXsmWH5JELKI=;
        b=UX4EqM3xr4hPiIMwgzl52bosUztMrEe0J6c8dz4xZCM8eiy2WNaziwvAQ2q4FDfQEu
         n84lI5XIFtrY4MVvWDdRH2MjZxqz2+qY/vtUfycWh4/FXMlCswQL6jnvpoy991oz941V
         RhPoF7TVzBNJOKkCSLA7EHKo834Rr/sRCQe/tlw9oIh1LLTpHPfTOfh6PJ0bsf9FVLoi
         /E/9JZ4EIdQjaWOMK0PcLiEfk/f7YZrkFGAObnMziY6+JVhYTZoxS1u9ZMwxqwOVS5pP
         RBLlABVwISxObIJur4hrWl45jVqktiOXJWgPwH6DzGfPgV0dSF/7qGDbr16E8MaOfTZ3
         fANA==
X-Gm-Message-State: ACrzQf1O1sKKiYuEyL66nvQBxwk/XS4l0cQlWDSeBPr+C/cJpO3F7Mr/
	P4oUleNlvHckhyoUUqiWOc/B0LUyhHYisW4ZKiHlW1m2GotqhG9YEFwCjt0ggOUmYJj+Kc+a5QZ
	e1EN5TC3Jj13J2hE=
X-Received: by 2002:a05:600c:1f16:b0:3b4:f20e:6463 with SMTP id bd22-20020a05600c1f1600b003b4f20e6463mr2182448wmb.56.1663684619613;
        Tue, 20 Sep 2022 07:36:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pqmimFg4Xn0szdepF/sKeXh8yLqlWRocslSfTXw1Mg/V3RlmxMk2CB69EcUCrH0BhgEJT2Q==
X-Received: by 2002:a05:600c:1f16:b0:3b4:f20e:6463 with SMTP id bd22-20020a05600c1f1600b003b4f20e6463mr2182436wmb.56.1663684619357;
        Tue, 20 Sep 2022 07:36:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b003b47b80cec3sm203750wmq.42.2022.09.20.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:36:58 -0700 (PDT)
Message-ID: <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v8 3/7] reuse tcp_sendmsg_fastopen()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 20 Sep 2022 16:36:57 +0200
In-Reply-To: <20220920125243.2880-4-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
	 <20220920125243.2880-4-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
> In the following patches we will reuse modified tcp_sendmsg_fastopen().
> We call it from mptcp_sendmsg().
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp.c       | 18 +++++++++++++-----
>  net/mptcp/protocol.c | 11 +++++++++--
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 735e957f7f4b..a7d49e42470a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1754,6 +1754,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>  			      struct request_sock *req,
>  			      struct tcp_fastopen_cookie *foc,
>  			      const struct dst_entry *dst);
> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			 int *copied, size_t size,
> +			 struct ubuf_info *uarg);
>  void tcp_fastopen_init_key_once(struct net *net);
>  bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
>  			     struct tcp_fastopen_cookie *cookie);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 9251c99d3cfd..d10a3cdae220 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -280,6 +280,9 @@
>  #include <asm/ioctls.h>
>  #include <net/busy_poll.h>
>  
> +#include <net/mptcp.h>
> +#include "../mptcp/protocol.h"
> +
>  /* Track pending CMSGs. */
>  enum {
>  	TCP_CMSG_INQ = 1,
> @@ -1162,9 +1165,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>  	}
>  }
>  
> -static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> -				int *copied, size_t size,
> -				struct ubuf_info *uarg)
> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			 int *copied, size_t size,
> +			 struct ubuf_info *uarg)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct inet_sock *inet = inet_sk(sk);
> @@ -1197,8 +1200,13 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  		}
>  	}
>  	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
> -				    msg->msg_namelen, flags, 1);
> +	if (!sk_is_mptcp(sk))
> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
> +					    msg->msg_namelen, flags, 1);
> +	else
> +		err = mptcp_stream_connect(sk->sk_socket, uaddr,
> +					   msg->msg_namelen, msg->msg_flags);


I guess the goal of the above change is let mptcp_stream_connect()
update the msk socket status, is that correct?

However there are a few problems with lock: you must acquite the
subflow socket lock before calling tcp_sendmsg_fastopen() - or will see
subflow state corruption - but that in turn will cause a deadlock as 
 mptcp_stream_connect() acquires the msk socket lock and then the
subflow socket lock.

I think it's better leave the tcp_sendmsg_fastopen() body unchanged...

> +
>  	/* fastopen_req could already be freed in __inet_stream_connect
>  	 * if the connection times out or gets rst
>  	 */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 470045793181..8cf307e4e59c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1673,9 +1673,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	long timeo;
>  
>  	/* we don't support FASTOPEN yet */
> -	if (msg->msg_flags & MSG_FASTOPEN)
> -		return -EOPNOTSUPP;
> +	if (msg->msg_flags & MSG_FASTOPEN) {
> +		struct socket *ssock = __mptcp_nmpc_socket(msk);

... acquire the subflow socket lock here...

>  
> +		if (ssock) {
> +			int copied_syn_fastopen = 0;
> +
> +			ret = tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen, len, NULL);
> +			copied += copied_syn_fastopen;
> +		}

... and additionally handle the sock state update here. Possibly you
can encapsulate all the fastopen code in a new function - say
__mptcp_sendmsg_fastopen(), as it will be called under the msk socket
lock.


Side note: you should enter the fastopen branch even when 
inet_sk(ssock->sk)->defer_connect is set

Cheers,

Paolo

