Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7D70
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 16:03:02 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id n20so9262343edv.8
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9PdhNd344AH6MsppDng+jE/SQusS5VCA8Fw1y+9uCUU=;
        b=hmA0IVM3vfvFctUlorIjyvs4fb9LTZg+9zhD40Og/+q6aCcWX45x7nNQdLsbSKvy37
         53np8knAyOZagOsa6DFQVpSj8OxXWy5n0Rwxozeywn7upxT+iodxGpq2OKA06nHQCtxZ
         6r6pY23vIQpmfOffKmeP+irhMzfj0yN408hA9Un1QNRmvd4VE10LvGLtCNkQYK1nZG69
         +dm5w7dk50V8XxmcsjEsoCSRkrBN+rsuv00vs60su6PObV4Fm6FDqRNgYzbeBHC8XS3k
         1jqCg3705FRG2u5vwht2blRPzGHVRG9nijvxCQdVkxRSGpwMJuq+d8tXXkEJSTOcP2PI
         vz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PdhNd344AH6MsppDng+jE/SQusS5VCA8Fw1y+9uCUU=;
        b=rk1QEZHlUwLtem0Iof1XcdQ+RHA8CEmjH/BOuvDXw258bbzJHXQeY/cmKfLWSu50cL
         JFEUFgWnfbv5GoElNkRIjbROHy5+1tXv0ec377DzxYBy3CU4qaEhK5PUCwbklqE/ZEJM
         ATHwXsMaed5E3OlgtHTkxqfoXCnDOKixtGb+5NwPrOcR1OiJMMmsMAyViTwuKiQqYPOj
         Uu5cbg52SGdMnmUiJp+ZOkMu1jBceqLOyeVOR2axnoVcny7qRioTxp/WM4fNHfeVeQBy
         6UD+UccVbOI18QpRnTv2Z9aG1LbNZOoctWsvpyyIE5U7CUKplC+wQ2CeQgOaqyvFQz0L
         PU4A==
X-Gm-Message-State: AOAM5309P/U2gUN71bDo+i2ayM/4tG/2qtKeo53xZajiNACG2GJaavMT
	0n3jEaximxV5BNfAs3aid5F+lg==
X-Google-Smtp-Source: ABdhPJzQpXherrwSWU5W1glVTopLfXrV1N+QSd25II7ZwMmCAhIctaCf5jpao1oaJXCiIcK/dKptJw==
X-Received: by 2002:aa7:dbc8:: with SMTP id v8mr4755269edt.242.1624550581073;
        Thu, 24 Jun 2021 09:03:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4243:be2b:bb35:da12])
        by smtp.gmail.com with ESMTPSA id w1sm2203653edr.62.2021.06.24.09.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 09:03:00 -0700 (PDT)
Subject: Re: [RFC PATCH] tcp: consistently disable header prediction for mptcp
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
References: <982d258452274d2b165b07883307c01a44dbf7f7.1623434219.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <4bce8c64-514e-6bb3-8fab-f4dfda14cf67@tessares.net>
Date: Thu, 24 Jun 2021 18:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <982d258452274d2b165b07883307c01a44dbf7f7.1623434219.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/06/2021 19:57, Paolo Abeni wrote:
> The MPTCP receive path is hooked only into the TCP slow-path.
> The DSS presence allows plain MPTCP traffic to hit that
> consistently.
> 
> Since commit e1ff9e82e2ea ("net: mptcp: improve fallback to TCP"),
> when and MPTCP socket falls back to TCP, we can the receive
> fast path, and delay or stop triggering the event notification.
> 
> Address the issue explicitly disabling the header prediction
> for MPTCP sockets.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/200
> Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch!

I just applied it in our tree so we have some tests and we can easily
work on top of it while it is going to be discussed upstream when you
are going to send it.

New patches:

- c33c021a9394: tcp: consistently disable header prediction for mptcp

- Results: 07b006118fa3..1f935a2c8db1

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210624T160212

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210624T160212

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
