Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F41360
	for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670862933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEmjeViia6Y+FF9hj4X3RLcUVvyl6VgfGJtxrP1baMg=;
	b=iF3fJUgXB6fh9i6/f9fgbMQlQAisUBBOBTbJbDGCAlzSG/8Ewrx+pDVrJgna993io2LrxI
	RB1YKSZW4AgGC00qrcT2FuZ8HUvKgR1x9K0W2wB9XtAFI1ulqN5F2jowtwKe0ovrLBrfq0
	RliiV8jcvb1epD1ysMWJS6d3FMijLOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-6XOEfqyBP-ypmQ_KDsBxyA-1; Mon, 12 Dec 2022 11:35:31 -0500
X-MC-Unique: 6XOEfqyBP-ypmQ_KDsBxyA-1
Received: by mail-wr1-f70.google.com with SMTP id m24-20020adfa3d8000000b00242168ce9d1so2378750wrb.15
        for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 08:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEmjeViia6Y+FF9hj4X3RLcUVvyl6VgfGJtxrP1baMg=;
        b=eDpwCpTVa0kt7IWIE3cn0rMEoAjCoQ7jnuC5EqiyqiR2HWPGosIV0gw6coQDJ1iVNy
         xNTVEgTBYTkNYoa7X5mi6Vd9B+Xs3sLOZZoGkwi8AsYnTmKo0u5oxlXzIKADeiAUS89s
         TywrVWcQu51ot8JuqdiewjS3nDHOQnfdn5wz4wA5RuPftkjOyo0BXgBRC2Pb42erJH/M
         DZ8nEs9V2QyD9l5l0IWG8uX/J+Bg64U+trt10t58go1ItxCX16NYnZb0zZ3RKmCK1wQs
         x8faLytJV40hBfGWNLuvMhRqZDosOhkoATvcePsodDEPb1bNiv/Ef324+4h2VTvYSLtC
         l9Eg==
X-Gm-Message-State: ANoB5pnmIUahcy/sfW74d360PuZhAJiGTixrxUc2R4wKsagGhRB4sJa5
	oZPOb3zaoPA1PtxEOoz2+LhL9EgAAw4KFnEu7navb/dMcml3kKJRWlS0nyNYlMCocOZFFMpU00x
	MuRGanjY0ZFJ7Qas=
X-Received: by 2002:a05:600c:43c9:b0:3d1:f0b4:8827 with SMTP id f9-20020a05600c43c900b003d1f0b48827mr13422166wmn.25.1670862930633;
        Mon, 12 Dec 2022 08:35:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf57Yu1oXXSlo9/Tg5lWsGwyk2hyrT/WrPgWel35wAuRACo6g+g0XCGOsVFe5caP8DvLeb85iA==
X-Received: by 2002:a05:600c:43c9:b0:3d1:f0b4:8827 with SMTP id f9-20020a05600c43c900b003d1f0b48827mr13422155wmn.25.1670862930421;
        Mon, 12 Dec 2022 08:35:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c70191f267sm10751009wmq.39.2022.12.12.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:35:29 -0800 (PST)
Message-ID: <d6bcf7e63c35d5769fd6496ae6d23a283e36a678.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp
 socket in use
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 12 Dec 2022 17:35:28 +0100
In-Reply-To: <20221208024543.113633-3-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
	 <20221208024543.113633-3-imagedong@tencent.com>
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

On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> Therefore, we can get the count of used mptcp socket from
> /proc/net/protocols:
> 
> & cat /proc/net/protocols
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v8:
> - remove the MPTCP_INUSE flag and do the statistics according to the
>   creation and destruction of the token
> 
> v6:
> - introduce the 'MPTCP_INUSE' flag and check if msk is in use by it
> 
> v5:
> - rebase to solve merge conflict
> 
> v4:
> - rename MPTCP_DESTROIED to MPTCP_DESTROYED
> 
> v2:
> - decrease the statistics for listening mptcp socket inuse with
>   mptcp_listen_inuse_dec()
> - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
>   called on the msk. For fallback case, we need to decrease the
> ---
>  net/mptcp/protocol.c | 16 +++++++++++++++-
>  net/mptcp/token.c    |  7 +++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ffdccf26af99..775454a9d49b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3005,6 +3005,16 @@ void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
>  	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
>  }
>  
> +static void mptcp_listen_inuse_dec(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct socket *ssock;
> +
> +	ssock = __mptcp_nmpc_socket(msk);
> +	if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)

Here I think you can check directly: sk->sk_state == TCP_LISTEN, which
should be both simpler and safer, since this should be called under the
(m)sk socket lock.

It would be nice adding a comment describing why the state check is
needed, e.g.

	/* Listener sockets do not have a valid token, but we need to
	 * account them, too.
	 */

Other then that, LGTM.

Cheers,

Paolo

