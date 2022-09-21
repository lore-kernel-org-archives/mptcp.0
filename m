Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5566E4
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663782219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8krP3PRO0znGOo2IHnpHvtmznSmb3tcG+cDPtuZ7vk=;
	b=dpoMYSNWYrFfnA8WeJioWDMacS8sI8lasHv9pn4Q3tbjdVj0B7zxr5lEWSd4OyvPNZUx53
	ML3HkVOCZijS1Z5qmufTb44546PjSKq8NJokpuUNs93RI48ehqbgQjK3iYxvogGr2+kgWh
	5KOr+PmsJ7T7FE5VOV5I1tZYeSbqPQ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-251-T3DaYWioPGmk8dsw3g6rPg-1; Wed, 21 Sep 2022 13:43:38 -0400
X-MC-Unique: T3DaYWioPGmk8dsw3g6rPg-1
Received: by mail-qv1-f70.google.com with SMTP id nl18-20020a056214369200b004ac52c4b0a4so4809888qvb.13
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 10:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Q8krP3PRO0znGOo2IHnpHvtmznSmb3tcG+cDPtuZ7vk=;
        b=tluPQzeIMBzfFGRCQIncr0ovJC73XKvrKgmUnfWr0xMhQMGlcRD/dRZXA0wguO3tfM
         pvzjEdqwA6Ox06Pev35a9xRQdAwU4cJMxTdDRj67epu7xjKr/ip/dgHj8+kwwSdn/1SG
         FlnWTmNi/iClVt/qspFBVa71DAKv9WNWrSlKJcD/mz2U9qb9lH+4r/StWKKYgTVCHDo1
         HxgaqPFxdKch6BJ/jE2uQh9mbI0yQHwgzYZHwIilqjHN5w5ThN9OFFLMoaL38RF1eHvI
         8KQ7CoUVqyIJ0nXXcXNv7N5g4zaAryXnDPUAJ5Yx4/H8+lFaZpRglsFibEY1kLiGSKxL
         vjAA==
X-Gm-Message-State: ACrzQf2Aj+q9AvSkkYJX75Hu+vamYN+bwh700o8j9OjUYYmZEFK7C+Ii
	wlkmqSDCUyyict0woK97tFcMjmDm6M0jaerTe+3kVxRsuujSQLVpfT/vTNEEMSyzeVM7C6jfw/y
	r0Jd1pbyr3hUigH0=
X-Received: by 2002:a05:6214:2a82:b0:4ac:a4b7:b688 with SMTP id jr2-20020a0562142a8200b004aca4b7b688mr24700427qvb.75.1663782217778;
        Wed, 21 Sep 2022 10:43:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lG/RkG+lpfq6f0lHbffwfJagIFKNqzHX/hYFMBYVpcbCKFGqCobVIKxgNfhgKR9+ZmrNE/A==
X-Received: by 2002:a05:6214:2a82:b0:4ac:a4b7:b688 with SMTP id jr2-20020a0562142a8200b004aca4b7b688mr24700420qvb.75.1663782217524;
        Wed, 21 Sep 2022 10:43:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id r21-20020a05620a299500b006cec4f513a0sm2350681qkp.114.2022.09.21.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:43:37 -0700 (PDT)
Message-ID: <944acdd357436317ac065e18581b4557737b6f1e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v1 5/5] mptcp: poll allow write call before
 actual connect
From: Paolo Abeni <pabeni@redhat.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 21 Sep 2022 19:43:34 +0200
In-Reply-To: <20220921152539.1851441-6-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
	 <20220921152539.1851441-6-benjamin.hesmans@tessares.net>
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

On Wed, 2022-09-21 at 17:25 +0200, Benjamin Hesmans wrote:
> If fastopen is used, poll must allow a first write that will trigger
> the SYN+data
> 
> Similar to what is done in tcp_poll().
> 
> Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
> ---
>  net/mptcp/protocol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aa6e13949b23..308a09b3c0b6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3733,10 +3733,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  {
>  	struct sock *sk = sock->sk;
>  	struct mptcp_sock *msk;
> +	struct socket *ssock;
>  	__poll_t mask = 0;
>  	int state;
>  
>  	msk = mptcp_sk(sk);
> +	ssock = __mptcp_nmpc_socket(msk);

The above is not safe. We need to own the msk socket lock to invoke
__mptcp_nmpc_socket(), and we really want to avoid acquiring such lock
here.

Instead you can copy the ssk 'defer_connect' into the msk at
mptcp_stream_connect() time...

> 
>  	sock_poll_wait(file, sock, wait);
>  
>  	state = inet_sk_state_load(sk);
> @@ -3751,6 +3753,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
>  		mask |= mptcp_check_readable(msk);
>  		mask |= mptcp_check_writeable(msk);
> +	} else if (ssock && state == TCP_SYN_SENT && inet_sk(ssock->sk)->defer_connect) {

... and check it here.

Cheers,

Paolo

