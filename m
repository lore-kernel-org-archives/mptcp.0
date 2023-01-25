Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40E6FA1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 17:47:43 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id m15so14360268wms.4
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCVahJvhOO3sSmI/jEP7jpd6jkBlxi0YNFpeHF6U3J0=;
        b=LFp6sbv5TnLDnaFzbM6MLmbks87xewZqwx43OAVGezHyzzoIP49z5WJU1Y5/Qpdo63
         S8xsx+T9x7u1+bCuS7uSiX+fjBCnrvXcSLl7wZeog/18u5njP8AnoGS+RSVG9ONKldpW
         /gO6RmI3cwIx8wKsiWZKOgqm4jYM9ep0VXLQQhxNxbcSamff0APUWCT5qSPGtEgXW1WI
         SC6oYSOQX7CIGv8uYmyV+8pRJZqfz6FiqU9yhT9izTG2Rp1EisXnzXjMUY+BjX2Fjqdv
         Fod+jnmiC/Xtv52GiSlMGzzQKGLGMYtiZRI1pMudKYDDanLE1VhjZAHiVmoaPei9atm4
         rjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCVahJvhOO3sSmI/jEP7jpd6jkBlxi0YNFpeHF6U3J0=;
        b=DFZewAn8nGPW3GztQAo/pREcTLExNE1w6RuqyC72BfZR4ZFfBKqh9U9kTQs/SVNZSO
         Dj+Py42AcffDsco5iDxg+yAZWBHovjEOpKExt0U9qpmCBvDfdeTdbiv2r227r+GGdD+1
         H9bDpw4Vzkba9MGuAI0jtb1xiwVe9d/MJUTF+jEWPre2I4iM7zZbNsj1uYbaTnSK0sya
         vr9dkXJoU/ihiXOaT+o5TwjdKoO4wlgGbvYjirZvnAgLakN6qV8jf3OlsKRE7UCfJoJQ
         xAFYRZCfPMIEPhbLpc6/lkE1X6T3MygyocQMVx1UpAr166tx74cITF8lJw+fz5GvS/7A
         cYJA==
X-Gm-Message-State: AO0yUKU/Q16VFCOJo0bEcM2RMGMy/ve3U/iwpcSpF0KMomN03wuv6aNK
	Uv+aNZIGRazRTL93h90P3As5fw==
X-Google-Smtp-Source: AK7set9O/jyLZ8HhFvh61Ti2u2PRZfbWXx2JzQRZ0j3MJpc9ziLj9zgvs53GvRdk5XZoXSXiGaDJjg==
X-Received: by 2002:a05:600c:3595:b0:3dc:1054:3acd with SMTP id p21-20020a05600c359500b003dc10543acdmr6821878wmq.17.1674668861983;
        Wed, 25 Jan 2023 09:47:41 -0800 (PST)
Received: from [192.168.3.222] (213.211.137.183.static.edpnet.net. [213.211.137.183])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c329000b003d35acb0fd7sm2412641wmp.34.2023.01.25.09.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:47:41 -0800 (PST)
Message-ID: <38400e17-af98-5114-ebdf-71736dc8d3b5@tessares.net>
Date: Wed, 25 Jan 2023 18:47:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2 10/13] mptcp: fastclose msk when cleaning
 unaccepted sockets
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1673940640.git.pabeni@redhat.com>
 <394c4a5a2cb8764519aa732fc27dad59fa2ba71c.1673940640.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <394c4a5a2cb8764519aa732fc27dad59fa2ba71c.1673940640.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2023 08:36, Paolo Abeni wrote:
> When cleaning up unaccepted mptcp socket still laying inside
> the listener queue at listener close time, such sockets will
> go through a regular close, waiting for a timeout before
> shutting down the subflows.
> 
> There is no need to keep the kernel resources in use for
> such a possibly long time: short-circuit to fast-close.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  net/mptcp/subflow.c  | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b867e3eec5b9..f742d558a1b8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2977,10 +2977,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
>  		goto cleanup;
>  	}
>  
> -	if (mptcp_check_readable(msk)) {
> -		/* the msk has read data, do the MPTCP equivalent of TCP reset */
> +	if (mptcp_check_readable(msk) || timeout < 0) {
> +		/* If the msk has read data, or the caller explicitly ask it,
> +		 * do the MPTCP equivalent of TCP reset, aka MTCP fastclose

(small typo here: s/MTCP/MPTCP/ -- I can fix it when applying the patch)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
