Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F22F28
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 14:04:29 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id mg12so13988647ejc.5
        for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDNAdgD0Edhh45fOCQMvNC2I96YdXCg+pXySgblSamA=;
        b=f47y9ZdFT7GI7Y1bbAD8cTYps6owHIsMtV/joydh981n0w/eYC9AC5/OwnCl7ALOVj
         HFH5PpEIF6d+XMF/EeguyC4vUnRMOHcwif5snrMP8zE841FScYjknLwbGafhBSq9BZZo
         zturm/b1/N1rnGiooMuXCgXIFH29tNz7RYT7AQQctWUxBGC5M/tsOUtRjrl1VSHjPdW9
         iI2qbGXBkbQYPQCJccoYo29UfGFXbktGfbD0KCNUAlufZXM/vCh8a4bG2JZgyLpFb7yF
         Ddey4XPguqNYMTj1WC4QAosPwjrYUpUqXtF68YBTUuyz9D6wGxDWhguu+G+Ac5VZLjKV
         E8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDNAdgD0Edhh45fOCQMvNC2I96YdXCg+pXySgblSamA=;
        b=y0zF6Q9JONvGRx2sljv37fKfYZWcXcSQFfU4notqi0yU2SW19FJf8enoCPHKvvCDnj
         LTrLiyx+uGj4RBMGOq/GyUsXLo0dm8HSyfp2xy6fa+U2j+R+Ns7ZqMnEbBcNXyddBju0
         0FXI5MLrdIuWzxJNiP1B87Z0wFvejSiC4VGTF45HMBWbCC0kg2/GjPoV7aoEB+hEB/0M
         1FwofZgF5fFbIiPJo+opcfmRVESSFsTFS6LEJk5/kpSvDFyatSmVR+2ee8+mJaeZxIrG
         y8NvhheDPWaK1vZHsDb90YoUVS915Tygx6AzogxmAIHd/7cVy5n5FjuPxua8C+BAeXGU
         0uPw==
X-Gm-Message-State: AO0yUKWqSRbliV56PPO66O89xhiC2CYccRHqh4WeZ7DuNmXK/LoPwmw3
	DrcQrQKLlLPgYxPn/XE00UaC2JPAGRXL5STQ3cs=
X-Google-Smtp-Source: AK7set+F22UNJ6B8PGsrYTNWq+Co8w3f7eMkS9x6fmPe3z3ZPk0IAdfug8nr4jvZ/6E8ia9QYbGkJw==
X-Received: by 2002:a17:907:76ea:b0:878:8294:9179 with SMTP id kg10-20020a17090776ea00b0087882949179mr3937101ejc.54.1674828267452;
        Fri, 27 Jan 2023 06:04:27 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906c29900b0084d4b907ff8sm2289963ejz.120.2023.01.27.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 06:04:27 -0800 (PST)
Message-ID: <a3289d23-9740-c537-89dd-b847b0d72423@tessares.net>
Date: Fri, 27 Jan 2023 15:04:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 mptcp-next 09/15] mptcp: move first subflow allocation
 at mpc access time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1674767058.git.pabeni@redhat.com>
 <192ab619774a07e38780eb95f9a3ff8abaeaad77.1674767058.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <192ab619774a07e38780eb95f9a3ff8abaeaad77.1674767058.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/01/2023 22:05, Paolo Abeni wrote:
> In the long run this will simplify the mptcp code and will
> allow for more consistent behavior. Move the first subflow
> allocation out of the sock->init ops into the __mptcp_nmpc_socket()
> helper.
> 
> Since the first subflow creation can now happen after the first
> setsockopt() we additionally need to invoke mptcp_sockopt_sync()
> on it.

(...)

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8a9656248b0f..1fb4615fe586 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

(...)

> @@ -872,8 +874,10 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	}
>  
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock)
> +	if (IS_ERR(ssock)) {
> +		ret = PTR_ERR(ssock);
>  		goto out;
> +	}

Small detail: I guess for this function, we can also switch from:

  int ret = -EINVAL;

to

  int ret;

like you did in the setsockopt version.

I can do the modification when applying the patches.

>  	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
