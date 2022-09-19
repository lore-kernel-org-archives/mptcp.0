Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2133FF
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663584486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMEHXaD0BaYkpN0W8usDI6NbymNqyw5U0OeO28RwLKs=;
	b=OqIL0z/wuxTp7/q7Joe+7Q9If8dfjfrWpUqZ3W9+bCFxIE5f6xaME0hr96rdBgFEbgpvdV
	97/UZFG3VwukMIT4Hp1//r3pqvgTFo70wObCi46JQvc/OMvGwwOQXR5BEyyYyHEmKGfVlp
	3bSskk/H4DYyFeY7JE8dL77pehS0S+8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-pNsD5BwVPcmqSMF3vkRS0g-1; Mon, 19 Sep 2022 06:48:05 -0400
X-MC-Unique: pNsD5BwVPcmqSMF3vkRS0g-1
Received: by mail-qv1-f70.google.com with SMTP id dw19-20020a0562140a1300b004a8eee124b4so19235351qvb.21
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=cMEHXaD0BaYkpN0W8usDI6NbymNqyw5U0OeO28RwLKs=;
        b=oyeMSZAXWYMutx1aJQiiRcjB6rgCSdSUpvBf4tHjJsSpMNH8Z66INk6aMIK36liCEA
         axiGKf6wOUzSMeGA5K/czH2tmR62J1BJ5HFGvIivw0TDnb/wKtVeq6TYMWlPbmUMb35P
         U7yl/hhI23Sn6Gd1GauVK0l5WbdBQdNf/DzEojb+TPONfEKxLgnYLB4i927gQ6Qm21f+
         1D23f9q7Fvav592GusOzST/WhpfAwnX/HLZrX4HCGJ1sRT2gHc62HSyKqrcplC4+o88b
         zLJsahOS2s1Qs7SxIoU3xCAPYZT9dq3eh3Vu/4FMgWyd8HQBDUgaRcYUkWvMHEMdMARh
         UISw==
X-Gm-Message-State: ACrzQf3W9UX10ch1jgJOMRY71jVcmXw/6M8375zwZJo1ZKSzIDxmJjGZ
	ywpdIPcvGXartW2gpECXcJCTybSO5josWu8fKn4EqqgFeKAv/TmfHDaAEyeMQstszv4QzMwmYJT
	b+MPmJDFQZaAnQI4=
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id d9-20020ac85d89000000b0035bb58a2bcbmr14572951qtx.273.1663584484359;
        Mon, 19 Sep 2022 03:48:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7pX5R/aNuj6o6ASdI6iLBm7qVK66eQWS2l2GnnpnlvLCJYWq4GhQuTM7FbqieVJEDTP9lfEw==
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id d9-20020ac85d89000000b0035bb58a2bcbmr14572939qtx.273.1663584484093;
        Mon, 19 Sep 2022 03:48:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006aedb35d8a1sm13051698qkp.74.2022.09.19.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:48:03 -0700 (PDT)
Message-ID: <5f15c4fa1e263faa553940bf9fcf57b566fa2dea.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 06/11] add mptcp_setsockopt_fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:48:01 +0200
In-Reply-To: <20220917222853.2406-7-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-7-dmytro@shytyi.net>
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

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Add set MPTFO socket option for MPTCP.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 28 ++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/sockopt.c  |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 50b5c3376672..436e773d798a 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -63,3 +63,31 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	ret = -EFAULT;
>  	return ret;
>  }
> +
> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> +				      unsigned int optlen)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
> +	int val;
> +	int ret;
> +
> +	ret = 0;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	lock_sock(sk);
> +
> +	if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
> +	    TCPF_LISTEN))) {

The above can fit a single line:

	if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {

Otherwise this patch LGTM.


Cheers,

Paolo

