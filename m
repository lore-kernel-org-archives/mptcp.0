Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFE7F4
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 08:31:48 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id v2so15417145edc.7
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rCEvcpN7Y07e/EvxQzt+h2y6ju7QUeP6vg8wDHg7EQc=;
        b=j7Z/b0mJvdXY5W8IMxcHsbD4tKyVb5PlYJ4w1IYd8NbNmz1C+Sbi0mpvHZ2og5jjuh
         HZHiPfhAR8GpEJkqlTlWGu9whBdWgCFxGapkikf0n/c2XBUxgs0MyArZc9CoAfHHGi1k
         TW7eXZF8RDputk5JcNyeKbIzUCMd5JJZaHG/wW28MVhv5UXz/DtxG7j4Yu3NT1nvbm5u
         0qja/8nukOysljocppEZN/a8eBuOYUvi6CRc5N2qCUliaDKN/4RujJppq1gLYGCodl7b
         typ5wi+NcZd6ogAZDKci1YPjzODXPoWx5m/rE+jbYz+c5xaNV0jrr2/a035IuW000URM
         DJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rCEvcpN7Y07e/EvxQzt+h2y6ju7QUeP6vg8wDHg7EQc=;
        b=FtgyneooILIwAmU//gHNaYtmAqeL+Hva9JjIsTN6qHcVhILFIySiNhyc0GgVHCQAGK
         4G0+HIpLG/4Vazf70Bn9rji8pFNSbTyc0iMJZaVsq+bJuGYl0kuvuLsDhQ/XTf0c9r8b
         R2gf4noh85+bZul4qn4KATm0U17h5foZtXh57PaOqnvtJfoXm8z2+S4y7zE7yD7ujykL
         ORc/7+oPGZzahFfhPi/jRjU4hhlcytNSPxJXpUGJLWRDy/Qth8zbFzMy5W+A6nyCX2AR
         OMdoa6/6alvZBORNwh1Rc5NuMYNN/uUW77WBNoqk6DoUYobfzgGMhChNYBwzFP6cPGnM
         yL/g==
X-Gm-Message-State: ACrzQf0VotQ5i/z7AM3PRNAHFYHUxCDAo6ik1Bk07CAYpnlFJ1xiQrls
	kGtuD2/2KYdk5ZKK1/cD2HLaKQ==
X-Google-Smtp-Source: AMsMyM71BOw3AsyOacfVbxmUjYDAnUEqgxyXrCFgKxsjU1XNXm6BcHwlAfA1v+NGurDI5WnoTzFmyA==
X-Received: by 2002:aa7:cf89:0:b0:457:3dff:8a4 with SMTP id z9-20020aa7cf89000000b004573dff08a4mr16132708edx.175.1664353906494;
        Wed, 28 Sep 2022 01:31:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6518:6c3b:2826:5305? ([2a02:578:8593:1200:6518:6c3b:2826:5305])
        by smtp.gmail.com with ESMTPSA id v8-20020a056402174800b0044bfdbd8a33sm2846272edx.88.2022.09.28.01.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:31:46 -0700 (PDT)
Message-ID: <4b492955-36b3-e38b-cb75-7f32114923cb@tessares.net>
Date: Wed, 28 Sep 2022 10:31:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next 0/2] mptcp: add TCP_FASTOPEN_NO_COOKIE support
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 27/09/2022 17:03, Matthieu Baerts wrote:
> This series adds TCP_FASTOPEN_NO_COOKIE socket option support.
> 
> The first patch refactors a bit a function introduced by Benjamin to support
> TCP_FASTOPEN_CONNECT: the function is now generic.
> 
> Adding the support of the new socket option is easy after because the only
> action needed is to forward the request to the first subflow.
> 
> This has been validated using Packetdrill:
> 
>   https://github.com/multipath-tcp/packetdrill/pull/91

Thank you for your reviews!

Now in our tree (feat. for net-next) with Mat's RvB (I didn't add
Paolo's ACK yet but please tell me if I can/should):

New patches for t/upstream:
- ce72cdadf047: mptcp: sockopt: make 'tcp_fastopen_connect' generic
- 5d745bd13d21: mptcp: add TCP_FASTOPEN_NO_COOKIE support
- Results: 5391f0d311f6..6711fbb5e6c8 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220928T081959


Cheers,
Matt

> 
> Matthieu Baerts (2):
>   mptcp: sockopt: make 'tcp_fastopen_connect' generic
>   mptcp: add TCP_FASTOPEN_NO_COOKIE support
> 
>  net/mptcp/sockopt.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 095ffd740bdb5564bfe678e5cddf5d1d7c6b7462

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
