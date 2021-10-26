Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0B2CA8
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 10:33:15 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id g10so11838907edj.1
        for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OUxES1KARLuMLYnhC1yg9KtFZlrVaEf7sEdNrsgIwGY=;
        b=f8/G8oRZMWoeLfBhTkyt8Iwr2lvNLUNI0Mmbz84BnLiHpHd/cr6zhz0qTjcXpC5sby
         0wxi0N4dSXJxpaoT0P89lBYt7Bwd2sn/kHE9xCTxTzx1mMGvGXo4pOfN+v2T3LDPrD5I
         wrCastE1BqOqjEIvHbmPYH/I0QvnN6jhdby3syYdZhFLEBYcukWxRqMjBpe7TP2Wo70w
         Mppk2Yty7JoS4m7JmuSaRw0JkNvCDoQH15xR9pyPMIL3/HieXViFDEJ+AWgTefXuPDT7
         LUfuCdqoxdPlamEtvXeHSXOQdV6vSpvWQxs0guv9C1Gu7An78z6UREDlDzNtzfcDRBHZ
         l2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUxES1KARLuMLYnhC1yg9KtFZlrVaEf7sEdNrsgIwGY=;
        b=KhuedNN6zgiaIogXtGbYSALiqyTRbDE5MSsaVmll1ySODyKaYkAa5hPmpcBtkgDGrn
         GPHmurQFliFjBzw/NsdiSPGRae35AGKySqvRjiZfi/zn6tXki/ddcpLe/XtCtTIKg+Q6
         CUPRg9aPMUV0iHBtynTw43O0QJpTRYQn4BkC19ApTi7UhUMmcmpeExmNshTSTm/oNrAj
         SV3AVdBJYeBvTF75DGExezYCBZsCDZ+JkFsQ1Nrq2ILQmcY1ADNRUI5NpgzGC4nTiK5C
         0Q2XD4/U5pZzV9MIBnhKoGDMnEF6KJDUHKdP4VPAVbf/nz/deVAAqbCnTkigC+s/MgMX
         pmew==
X-Gm-Message-State: AOAM532q2YGg+1S7msg7ofUy7cETsoFYESvAPVvrk+hw5TPhKUPJDY4y
	P6A54WOLxvNmAx83yUADE4sripba6EWQk/Rvi7A=
X-Google-Smtp-Source: ABdhPJxN8mqmvYBzm9tpjcgKnU8WTXTU8oAOGNq+UVtmFwFRze4xSJ8cyqoNOF8BfNHdbxRFexlGXQ==
X-Received: by 2002:a17:906:a217:: with SMTP id r23mr19321982ejy.548.1635244393856;
        Tue, 26 Oct 2021 03:33:13 -0700 (PDT)
Received: from [10.120.18.78] ([84.17.46.24])
        by smtp.gmail.com with ESMTPSA id q2sm9030867eje.118.2021.10.26.03.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 03:33:13 -0700 (PDT)
Message-ID: <385babc2-96fb-441a-fae3-bb6a186a1b4f@tessares.net>
Date: Tue, 26 Oct 2021 12:33:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp net-next] Support for SOL_IP for MPTCP setsockopt
Content-Language: en-GB
To: Poorva Sonparote <psonparo@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
References: <51fa50ca9158e5b72a8f41ba9fcd1e449638dbc5.1635194315.git.psonparo@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <51fa50ca9158e5b72a8f41ba9fcd1e449638dbc5.1635194315.git.psonparo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Poorva,

In addition to Mat's review, here is a few notes from my side.

On 25/10/2021 23:01, Poorva Sonparote wrote:
> This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)

Small detail: in the subject, you mention 'SOL_IP'. Maybe clearer to set
'IP_TOS' like here because you don't add support for all SOL_IP options, no?

> https://github.com/multipath-tcp/mptcp_net-next/issues/220
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
> 
> Signed-off-by: Poorva Sonparote <psonparo@redhat.com>

Small detail for your next version: there should be no blank lines
between tags. In other words, we should have this without blank lines in
betweeen:

  Closes: (...)
  Signed-off-by: (...)


While at it, it is always nice to add some useful info in the commit
message:

- the reason: not always obvious when looking at the diff. Here it is
maybe clear but still good to give a short recap on what SOL_IP is.

- what you are doing: always useful for the reviewer to check if you did
what you said you wanted to do, e.g. here you accept a first SOL_IP
option, you set the same value to each subflow, you export a function
from ipv4 stack (for a dedicated commit as Mat said), etc..

- particularities: e.g. it seems you don't check if the subflows are in
v4 when you go through the list of subflows to set something v4 specific
(it is v4 specific, no?). Always good to mention that in the commit
message if it is OK to do that (and a comment in the code).

- Any other info that can be useful for other devs and reviewers, e.g.
how you tested it, if you had an interesting issue during the dev,
possible alternatives, etc.

Do not hesitate to look at other commit messages for inspiration ;-)

> ---
> 
> Notes:
>     - This patch addresses previous suggestions.
>     - The TOS value is now being set successfully for subflows
>       created after setsockopt().

Is it enough to cover this only in packetdrill and not in selftests? I
think it is but just raising the point just in case ;-)

(...)

> +static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
> +				   sockptr_t optval, unsigned int optlen)
> +{
> +	switch (optname) {
> +	case IP_TOS:
> +		return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);

detail: please avoid double spaces after "return"

> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    sockptr_t optval, unsigned int optlen)
>  {
> @@ -637,6 +674,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
>  	if (ssk)
>  		return tcp_setsockopt(ssk, level, optname, optval, optlen);
>  
> +	if (level == SOL_IP)
> +		return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);

Maybe clearer to use mptcp_setsockopt_v4() for the name to imitate the
_v6 version below:

> +
>  	if (level == SOL_IPV6)
>  		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
