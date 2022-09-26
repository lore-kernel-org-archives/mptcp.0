Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4982F21
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664203638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R35PZeP1QCkn6E11mFtWEpSFnnUHX146zvQNeeNrKY4=;
	b=jF/Bdk1o+MSJdBK94LjoWMTnfeY2LLpJA1HOFgAJ2W0xpvAFiENTRUUa2MLD2GZfk5WXW1
	MeP6wiENRRUT0Zwr3tg1CG+Tym+bcRkxut5LPro32ncO2eIdAMjK5gry2sLh12ageoxtuw
	1xUsbpnhcf0bmfNSve4Fua1WjZtx0SE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-kdnuemFIOnWsAqR1Ihft0w-1; Mon, 26 Sep 2022 10:47:17 -0400
X-MC-Unique: kdnuemFIOnWsAqR1Ihft0w-1
Received: by mail-qk1-f200.google.com with SMTP id w10-20020a05620a444a00b006ce9917ea1fso5104963qkp.16
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 07:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=R35PZeP1QCkn6E11mFtWEpSFnnUHX146zvQNeeNrKY4=;
        b=GHKvdSTToaIp1/1c5uc3L0ZND01EsvYK+ox9cLBFyToh8pof+atNLTFhcLMvQi9rEQ
         orfAsFFJJBoJWJXO4m0IrQt50GMljK+sk4zH3Ga/yf9bhDXKMRxm0fAkGvFlp4gVTawA
         dZCfBNVYDppAo0XCrGi712TOnzXNWzRjrZ3rmw5yIY+Ps3hR1zbITE3eMf5zvrNLRLuq
         wdTsEfPz1uvpQkUNramiZnebh3+vZBNOnQBxzRlqBZD9I/3DV9Y3AyEtqGjURyLP5QZz
         Wzs/88saTW0RL7Wb0hAnS2iSI/JG16c6klHFgm5I9EceDLCqDOm/rom+SsCq0kvYbTns
         ahYQ==
X-Gm-Message-State: ACrzQf3c8+3AH06JkgG+Sm3rdQw+cIbOZ8eZ8Y7ccX1odWbDpJU1DVMe
	pT7gapgWx5AFB8gpgx1XTRr9q7pfo/Jcru2g5qsCn7uFlcTZIM38yw8jddLDocY/XUJed2/kXnJ
	Z7bftxAzWPnPNofI=
X-Received: by 2002:a05:6214:27e5:b0:4ac:c227:2111 with SMTP id jt5-20020a05621427e500b004acc2272111mr17096681qvb.127.1664203636814;
        Mon, 26 Sep 2022 07:47:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4JsKnkOTv/n5lzlplMpKBhtjalzKFypZi6J/EEHlQjONdHZjbBIk3jAn8G0FyOO53taf27aQ==
X-Received: by 2002:a05:6214:27e5:b0:4ac:c227:2111 with SMTP id jt5-20020a05621427e500b004acc2272111mr17096667qvb.127.1664203636524;
        Mon, 26 Sep 2022 07:47:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-96.dyn.eolo.it. [146.241.97.96])
        by smtp.gmail.com with ESMTPSA id g25-20020ac84819000000b0035cd2dc1b08sm11087386qtq.14.2022.09.26.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:47:16 -0700 (PDT)
Message-ID: <3b85c5f3ceac73bfc397c783910ef0bc5532fb69.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v11 4/4] mptcp: reuse
 tcp_sendmsg_fastopen()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Date: Mon, 26 Sep 2022 16:46:59 +0200
In-Reply-To: <20220925232601.25252-5-dmytro@shytyi.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
	 <20220925232601.25252-5-dmytro@shytyi.net>
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

Hello,

On Mon, 2022-09-26 at 01:26 +0200, Dmytro Shytyi wrote:
> In the following patches we will reuse modified tcp_sendmsg_fastopen().
> We call it from mptcp_sendmsg().
> 
> Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp.c       |  6 +++---
>  net/mptcp/protocol.c | 25 +++++++++++++++++++++++--
>  3 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 27e8d378c70a..97cb014ddcab 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1755,6 +1755,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
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
> index a22c8044de17..daa611671d9a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1162,9 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
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
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fb08e1f458c0..dd2414fdcf04 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1679,9 +1679,30 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	long timeo;
>  
>  	/* we don't support FASTOPEN yet */
> -	if (msg->msg_flags & MSG_FASTOPEN)
> -		return -EOPNOTSUPP;
> +	if (msg->msg_flags & MSG_FASTOPEN) {
> +		struct socket *ssock;
> +		struct sock *ssk;
>  
> +		lock_sock(sk);
> +
> +		ssock = __mptcp_nmpc_socket(msk);
> +		ssk = ssock->sk;
> +
> +		lock_sock(ssk);
> +
> +		if (ssock) {
> +			int copied_syn_fastopen = 0;
> +
> +			ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn_fastopen, len, NULL);
> +			copied += copied_syn_fastopen;
> +			if (ret) {
> +				release_sock(ssk);
> +				goto do_error;
> +			}
> +		}
> +		release_sock(ssock->sk);
> +		release_sock(sk);
> +	}
>  	/* silently ignore everything else */
>  	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;

the above/previous patches duplicate quit a bit of code. Instead the
following should be enough (replacing patches 2, 3, 4 here):
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c99eb4ce948e..c50e8f85bb11 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,17 +1673,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
-	/* we don't support FASTOPEN yet */
-	if (msg->msg_flags & MSG_FASTOPEN)
-		return -EOPNOTSUPP;
-
 	/* silently ignore everything else */
-	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
 	lock_sock(sk);
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect ||
+		     msg->msg_flags & MSG_FASTOPEN)) {
 		struct sock *ssk = ssock->sk;
 		int copied_syn = 0;
 


