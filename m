Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999D72
	for <mptcp@lists.linux.dev>; Sun, 19 Sep 2021 07:06:42 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id q3so47634076edt.5
        for <mptcp@lists.linux.dev>; Sun, 19 Sep 2021 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YK9Fu/ftHFDUXYWloMdkPkiZpj2M26Dqhv2LhnrHnTk=;
        b=zf5634dIiZ4UDpViH+k6zROvz1e+KLbiHsvVIk0WbajFcUdcoEV3G/yBrM2lpw+yGN
         5Y0/GvbKPdTqlQDniS3bYnnB4i3cmHqB5t99Jvsic9vs765NijDRxMvr01RUlj29l/kF
         xSRy79aQkneWhUApZuunObmYdpxTg9864Ta+U6PuB9nSAucNDh+FKMG2EbTV72QTjI3m
         XflOyR3Szf9oR7udtxJ6lrdSPtpOQK509A89e/vZn/H3SLdU+ubS+HAV1i9Kz1IabPcE
         rhBYlu2Yd02G6tG2waOkY9fUbqoAgQPL492R79dXZeZUvxL7Tc6hRvlLsmGD+wOMdnpB
         pg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YK9Fu/ftHFDUXYWloMdkPkiZpj2M26Dqhv2LhnrHnTk=;
        b=yHtPhEMfcthUSiDVerX51gVQ3JvfvRd8M3yrUUbdy+9FMrULNdJgDFNHbE10a3Ih+H
         8J1HKP8HMurNNOavMVwVFiISxlSbSL+bXBzwriuvDmaDUuSz2go98I4x6eY3tRWt4L6p
         fUJy/RiJ/I5LWZxocL7y+HGZsPk2GF4rBXmcWAljSuhsK5qsJZyo14HB5fZG0MogmAfa
         ywN8HcCcqx1Pl7V7JM4cEvKLZfybrCA7YN23vPqc+Ze7a2/8D2ocHrSc1QsQ2MKpncZK
         x/YKInFuNdarhgn3SuGfNlubw5PXMB8tqXD7KYJIYc0Ps4IHj13fDlSm+ex2/6RBK11o
         58dQ==
X-Gm-Message-State: AOAM533IbG4soQOgS7FCe3lHSjcysXJjBiEEzZy4c859d2QSl2Fw4ZzF
	DjWtvK14AOkW5CH1XEAs2xwg6BwitAe1QUFpoqM=
X-Google-Smtp-Source: ABdhPJxVlp9RG/3TxXoypZCeP15Iu5Jc0qhtG5dYVERcjCpP8tVlP2vf7cA200VHzih/rSdpwBFRew==
X-Received: by 2002:a05:6402:906:: with SMTP id g6mr22168123edz.19.1632035201184;
        Sun, 19 Sep 2021 00:06:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id k12sm4530479ejk.63.2021.09.19.00.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 00:06:40 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: don't return sockets in
 foreign netns"
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <20210918080539.2051616-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <968e27b5-1316-e2b2-53a3-13938202a36f@tessares.net>
Date: Sun, 19 Sep 2021 09:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210918080539.2051616-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian,

On 18/09/2021 10:05, Matthieu Baerts wrote:
> Add missing doc for the new 'net' parameter.
> 
> 'make W=1' returned this warning:
> 
>   net/mptcp/token.c:242: warning: Function parameter or member 'net' not described in 'mptcp_token_get_sock'

Thank you for the review! Now in our tree:

- 91017a33fdaf: "squashed" in "mptcp: don't return sockets in foreign netns"
- Without co-dev tags for just that
- Results: 9362f2920995..3d2c77807730

Builds are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210919T070621

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
