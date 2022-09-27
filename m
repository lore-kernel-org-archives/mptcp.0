Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D846B4
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664301879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErdV3eUtR0iCW9ntWJ5TFNzH2PEpeVDDGXE1ifeJ6ew=;
	b=gKFk2yjvmbbeT7JbDvS6vN//809zRriTLOZkgF2Kapf/E+Yek5B+fTDg2H2p6dLxkadv8x
	RzONsZs6NNiFFBFImj/wLiEk8sKx1UTZF6A8mK+eLsUbTmdwcFT4+fJD7O/kNDaEUA8dhh
	xJ2Bkh7hOlQ+YNv/jwA9Hf2ukeVos1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-5yYUSULlP_yY4jYd2yHWcQ-1; Tue, 27 Sep 2022 14:04:37 -0400
X-MC-Unique: 5yYUSULlP_yY4jYd2yHWcQ-1
Received: by mail-wm1-f72.google.com with SMTP id ay21-20020a05600c1e1500b003b45fd14b53so888449wmb.1
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 11:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ErdV3eUtR0iCW9ntWJ5TFNzH2PEpeVDDGXE1ifeJ6ew=;
        b=OWAjaFtP+3LuDPNLUqNI6gYjwIXJqHav2nowa/qdi+AnKCMBOkKlhl/JUeqPnWqVfC
         grxou+ecAL7s7cIy9mYKBI+dAenVJFt/1WLpIS4u3uFREA4zm3swdo97DKpokiAaHwFt
         Bv3bDRRkle2Ga+5n9UX8+L+7ee+qboA+mEIfTxnd9BXby4Bd4XjKj+VrlIFBBFeDhJqh
         IzyS7JT7fXwa/7nnhlu+rFSI7xBLpE5OaS5zcvBPkZvAOz9skwteUIr6UgWs6WCY11Uc
         K8yV6yZ0vOa3Sv96X7hSdv0FoEdLrBT6O+NjQbDirtlFmTfhkq7GxQplOs9x1NyZJ2nA
         UjQw==
X-Gm-Message-State: ACrzQf19xLfSkqOOIgUmBBPHttcCgojEs0TW3kzg0aQDIjHNesWm+hQf
	ymvqrp+JOwWW/8NDqRNkiFWSR/uNviPjLRgVb4LnO5b2/iVAzq+OAR/F63uwzPPv2dzptq7kPJs
	Dk8MDF1Coa2STexk=
X-Received: by 2002:a5d:60c6:0:b0:22a:d6ec:63ac with SMTP id x6-20020a5d60c6000000b0022ad6ec63acmr17316722wrt.309.1664301876266;
        Tue, 27 Sep 2022 11:04:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45BBEBi+6vnkEZnEsTcq8chpiOp7VPIu6tarERq6AEeDg92yYm1Cn2Y4MggBFlvulFp9cFWQ==
X-Received: by 2002:a5d:60c6:0:b0:22a:d6ec:63ac with SMTP id x6-20020a5d60c6000000b0022ad6ec63acmr17316709wrt.309.1664301876024;
        Tue, 27 Sep 2022 11:04:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b003b435c41103sm17514494wmb.0.2022.09.27.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:04:35 -0700 (PDT)
Message-ID: <f348f260d1c2c988fd96e5079b18e9468ff8cb3b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: sockopt: make
 'tcp_fastopen_connect' generic
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 27 Sep 2022 20:04:34 +0200
In-Reply-To: <20220927150306.1552795-2-matthieu.baerts@tessares.net>
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
	 <20220927150306.1552795-2-matthieu.baerts@tessares.net>
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

On Tue, 2022-09-27 at 17:03 +0200, Matthieu Baerts wrote:
> There are other socket options that need to act only on the first
> subflow, e.g. all TCP_FASTOPEN* socket options.
> 
> This is similar to the getsockopt version.
> 
> In the next commit, this new mptcp_setsockopt_first_sf_only() helper is
> used by other another option.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/sockopt.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index c7cb68c725b2..8d3b09d75c3a 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -769,17 +769,17 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
>  	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
>  }
>  
> -static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
> -						     unsigned int optlen)
> +static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
> +					  sockptr_t optval, unsigned int optlen)
>  {
>  	struct socket *sock;
>  
> -	/* Limit to first subflow */
> +	/* Limit to first subflow, before the connection establishment */
>  	sock = __mptcp_nmpc_socket(msk);
>  	if (!sock)
>  		return -EINVAL;

Crazy idea: if we add another int argument e.g. 'default_reval', we can
use this helper even for mptcp_setsockopt_sol_tcp_defer()
(default_retval == 0, while here default_reval == -EINVAL) ;)

Not a big deal, I'm fine even this way.

Thanks!

Paolo

