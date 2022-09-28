Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A8EA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664358397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIVj/asuPk0WEQF9Dn7EjKcTTVyAMWfsFW2Rvl5Ongw=;
	b=RLpD7Y+AOaxAQZodZ42W9jRJyZUDSnsK4uGjJvGBMhoHqdgIXXv/9tL3SesaBK1HryHlT4
	xldLTj88DCnpiZI56VWIGqqoV9uN6rQBGu7U34ydlxcrDFqGoxboXTmHrKIeoVw92ILe4E
	HX6jGzDCIlsIAfclTn+HBoehHNJ3MYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-yZRu5P08MsO-f4q4dvQ2AA-1; Wed, 28 Sep 2022 05:46:36 -0400
X-MC-Unique: yZRu5P08MsO-f4q4dvQ2AA-1
Received: by mail-wm1-f71.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so427806wma.0
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UIVj/asuPk0WEQF9Dn7EjKcTTVyAMWfsFW2Rvl5Ongw=;
        b=N4/EoKkZY4grzZaAI/2lSbiEyYdvz+BFvz48UckPXPoKcDc2firFXk7oYL8YFKnWHw
         e2hVRUmt8W97KSwHDLMpDHGZkZH7suGoCD2mq1IJXQ2KaZydVqwzmJLTKrV2ux/nqIci
         P41RoBlQISMNDIst5LvctbQbHWsyU0Z9trUd9HPuLZg5Ihy4LqYQ9SXS4cfpXDEsDrwG
         GGF++KvpyeTVCc/z1A3AlxbC6+AcfYJo08sxO9Y34KuyEAqBgbQVyweGfAqlCWsRS+WG
         j4+EQ0Ei5VvNja1NX9PyHON+j98bYYYj+DcOVYJzzugMv69IOyar/dzGpRYKIVbMOIzj
         A5RA==
X-Gm-Message-State: ACrzQf2ib3s5HU5iDCRA1G18huF60m1kbEnjwZUuw46iOgSoqz3Abz2c
	gB+Qin+qXQ0uWGrQEQvsSab0sLAxxrt8skMWNH33Kg5HaB1yLtLHlx3rDjFg1xvhw20255C348g
	YrDdbe7gEqikNeec=
X-Received: by 2002:a5d:49c8:0:b0:22a:35a1:1755 with SMTP id t8-20020a5d49c8000000b0022a35a11755mr18944001wrs.180.1664358395597;
        Wed, 28 Sep 2022 02:46:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69z69pweJHp3hLvCge/nl8Mi2Fey0Kbr4Pqph5MVZmURRXdah34ma0E9bMnhhGiwPmP6BTXg==
X-Received: by 2002:a5d:49c8:0:b0:22a:35a1:1755 with SMTP id t8-20020a5d49c8000000b0022a35a11755mr18943991wrs.180.1664358395358;
        Wed, 28 Sep 2022 02:46:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003b476cabf1csm1616717wms.26.2022.09.28.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:46:34 -0700 (PDT)
Message-ID: <96ec8c7534425d2693aaa6b03cd7272adc4e6438.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: use new helper for
 TCP_DEFER_ACCEPT
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Wed, 28 Sep 2022 11:46:34 +0200
In-Reply-To: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
References: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
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

On Wed, 2022-09-28 at 11:18 +0200, Matthieu Baerts wrote:
> mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
> mptcp_setsockopt_first_sf_only() except for the returned code in case of
> error.
> 
> Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
> when used with "plain" TCP sockets.
> 
> The specific function for TCP_DEFER_ACCEPT can be replaced by the new
> mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
> stay compatible with TCP. A bit of cleanup.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>

You can/should drop the above tag ;)

> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/sockopt.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1857281a0dd5..f85e9bbfe86f 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -758,18 +758,6 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>  	return -EOPNOTSUPP;
>  }
>  
> -static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
> -					  unsigned int optlen)
> -{
> -	struct socket *listener;
> -
> -	listener = __mptcp_nmpc_socket(msk);
> -	if (!listener)
> -		return 0; /* TCP_DEFER_ACCEPT does not fail */
> -
> -	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
> -}
> -
>  static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
>  					  sockptr_t optval, unsigned int optlen)
>  {
> @@ -810,7 +798,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  	case TCP_NODELAY:
>  		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
>  	case TCP_DEFER_ACCEPT:
> -		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
> +		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
> +		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
> +		return 0;
>  	case TCP_FASTOPEN_CONNECT:
>  	case TCP_FASTOPEN_NO_COOKIE:
>  		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
> 
> base-commit: 6711fbb5e6c8541f84685542127455c18145d559

Nice! LGTM!

Acked-by: Paolo Abeni <pabeni@redhat.com>

