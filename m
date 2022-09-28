Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918AA51
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664355681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zRujAuWlWXvb/8N22q0vfCqARHPux76y6G+bRHtG4I=;
	b=DY2OG9rbNelrkHFB3BumtLY0Ze5Ep/fyDMB7tk+DuuQGpt3fwfsCyrZ5oXeM57swQZT1ze
	ln3RXG4bwhtNkMxPBoaYXVVWzvLSvTkr4B4ybpYDz2/snww/7jt7taEu8l9HemICXS5ifZ
	MTI5eYqJuv26NfOvdtyG6qZWEQtlR/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-xcwIl0ZmOoS6fvPGJBdqEA-1; Wed, 28 Sep 2022 05:01:20 -0400
X-MC-Unique: xcwIl0ZmOoS6fvPGJBdqEA-1
Received: by mail-wr1-f69.google.com with SMTP id s5-20020adfa285000000b0022ad5c2771cso2793603wra.18
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4zRujAuWlWXvb/8N22q0vfCqARHPux76y6G+bRHtG4I=;
        b=7AwiNznxlRcgh+ZbnW1iNNSonH+MlJAu9ilFhajekA9H8DNj6eL6qcP/3M5IFWPWxz
         PLm6sxGELhe7Z9MwLVRfnqxfVhIISq6zvQ9+ZVUEXCcihF4QCZzfTdxmYiIz5bxBuaEL
         cK4NM82+CVJLjwUNa5yx1/3jKB7+LC/YjSR43gelwJp3p2b9K8+0VLMpj2RlCg4aKFal
         Vp99rYKyZslqOvX00gpEWHa2vdk0yFEFKrCLuH81SYhFPdE3rLtAgTtY6aCtFkPupHml
         irLJMgi0CuEBy8wfcob8R4KsFoRpW6+kwalEeRG0dGxncIiu/z+ENSFbt6Hd/0lFnmzc
         poGQ==
X-Gm-Message-State: ACrzQf0xpTKuFs3gCb9luYn4u51XWVq7QxlJKXEOtg4UL3ZGD98WC+DP
	/aIkdA8wy32IrSgT4SkhN1dG51DFeLVgtxtXfIOCHTTpIRBMwfcbrs2GFXPFCtXegDwZXxGd9Ba
	kcsMO0nnj3tdG8Rk=
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr5949862wmj.24.1664355678746;
        Wed, 28 Sep 2022 02:01:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZZH/0yNxgxW56KBuYXJMZocMLsyKESUz0zvK4HHhzFGKL9+ekWpiz3hjGbZ40JDf1F9ZF/A==
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr5949825wmj.24.1664355678255;
        Wed, 28 Sep 2022 02:01:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c218b00b003b47ff307e1sm1131686wme.31.2022.09.28.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:01:17 -0700 (PDT)
Message-ID: <c074b37149bbad50ece1b0f0b6e380106b5a0e38.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 1/7] mptcp: introduce MSG_FASTOPEN
 flag.
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Date: Wed, 28 Sep 2022 11:01:16 +0200
In-Reply-To: <20220927225341.14165-2-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-2-dmytro@shytyi.net>
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
Content-Transfer-Encoding: 8bit

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> In the following patches we will analyse the MSG_FASTOPEN flag
> in the mptcp_sendmsg() and invoke the MPTFO.
> 
> Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  include/net/mptcp.h  |  9 +++++++++
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp.c       | 20 ++++++++++++++++----
>  net/mptcp/protocol.c | 19 +++++++++++--------
>  4 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index c25939b2af68..ccf2b42837a1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -150,6 +150,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>  			 struct mptcp_out_options *opts);
>  
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags);
> +struct sock *mptcp_subflow_conn_sock(struct sock *sk);
>  
>  /* move the skb extension owership, with the assumption that 'to' is
>   * newly allocated
> @@ -286,6 +288,13 @@ static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
>  
>  static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { }
>  static inline void mptcp_seq_show(struct seq_file *seq) { }
> +static inline int mptcp_stream_connect(struct socket *sock,
> +				       struct sockaddr *uaddr,
> +				       int addr_len,
> +				       int flags)
> +{
> +
> +}
>  
>  static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  						const struct sock *sk_listener,
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4f71cc15ff8e..e53d26d74dec 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1757,6 +1757,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
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
> index 5237a3f08c94..daa611671d9a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1162,8 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>  	}
>  }
>  
> -int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
> -			 size_t size, struct ubuf_info *uarg)
> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			 int *copied, size_t size,
> +			 struct ubuf_info *uarg)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct inet_sock *inet = inet_sk(sk);
> @@ -1196,8 +1197,19 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
>  		}
>  	}
>  	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
> -				    msg->msg_namelen, flags, 1);
> +	if (!sk_is_mptcp(sk)) {
> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
> +					    msg->msg_namelen, flags, 1);
> +	} else {
> +		struct sock *parent = mptcp_subflow_conn_sock(sk);
> +
> +		release_sock(sk);
> +		release_sock(parent);
> +		err = mptcp_stream_connect(sk->sk_socket, uaddr,
> +					   msg->msg_namelen, msg->msg_flags);
> +		lock_sock(parent);
> +		lock_sock(sk);
> +	}
>  	/* fastopen_req could already be freed in __inet_stream_connect
>  	 * if the connection times out or gets rst
>  	 */

I'm sorry it looks like I was not clear enough in my previous replies. 

I really think we should avoid this chunk. I thought it only served for
updating the msk socket status, but now I see it is also needed to
properly allocate the token and update the MIBs, right? Does it serve
any other roles?

Anyway I still think you can avoid the above chunck, factoring out the
relevant slice of mptcp_stream_connect() in an helper:

static void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk)
{
	struct mptcp_subflow_context *subflow;

	mptcp_token_destroy(msk);
        subflow = mptcp_subflow_ctx(ssk);
#ifdef CONFIG_TCP_MD5SIG
        /* no MPTCP if MD5SIG is enabled on this socket or we may run out of
         * TCP option space.
         */
        if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
                mptcp_subflow_early_fallback(msk, subflow);
#endif
        if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
                MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
                mptcp_subflow_early_fallback(msk, subflow);
        }
        if (likely(!__mptcp_check_fallback(msk)))
                MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVE);
}

and call the above in mptcp_sendmsg():

	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
			       msg->msg_flags & MSG_FASTOPEN))) {
		struct sock *ssk = ssock->sk;
                int copied_syn = 0;

                lock_sock(ssk);
		if (msg->msg_flags & MSG_FASTOPEN && sk->sk_state == TCP_CLOSE)
			__mptcp_pre_connect(msk, ssk);
		
Likely this patch should be split in 2 separate ones: the new patch
will just create the helper and use it in mptcp_stream_connect.	


Cheers,

Paolo

