Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC62F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:23:32 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id r9so62238759ejj.3
        for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3rbU3TU2UsE81lcy1t10UxNnZ+BCf1YEkUTJCsWmck=;
        b=IeWfuvIUB3sKDNDoolxLd3UczYXaOymmzWYSkwR+w5jYx2qWnT2I3cSFT7foAfzzX1
         9XfA0BQjwVrqNbvzt0jO+ubgiVAFRbEjZ502eX3zxwojyd65tVqHTjBkOspu196srnf1
         FhLbRiZQCxZI3YbYqS1Z6lXyrqvzquggmSTMRlNXqRCO1Krh93+RcsEcZp3dcKZq9el9
         W8gFsFLpwsQPK5TEZQUS7cY5rr7GyQ9hD+Aj3+OAlaRSQyqesOrLa9jdQo9w8nl6g943
         hUiBVwt9yPgQHnbKT+DUhwpsox5ZjMdmoRekB6WaZsA38jJNyHT77jIhgtfAbVnuuYNj
         dcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3rbU3TU2UsE81lcy1t10UxNnZ+BCf1YEkUTJCsWmck=;
        b=ahxzBXNGpmyru9NTrefxat293knTiUOdJHQHbIuzx4PcxlfkqABJX66ptb27MtmfzN
         DZGWZrQ/TJb1wS/5nCjKQr5HqrYJnu4XpJxyUNPhg19/lp4EdMvy7JRKl4UZH4iBWcXv
         fCov/H6Ffiix1LqTEzRwjMyHG2nnznRQOuUODu6TCce2bBaF/D8N1koFcIpBqbPcuHsz
         Y1ek13cvu9TItxbKwTdFcIGW57433jrPSiOqKi9THGzRmdrxZ6wKh+Sbqgzablv5m1gy
         J50fgEVpqfa15NVCue4E3AXnqicCIq4nICUz/lAXlYpXfq64ElOcao9OfJjoUft183Wn
         9rfQ==
X-Gm-Message-State: AOAM533Iv1khLMNTqs3fFi5nI0Vds4pdbESZcob9css9Mk4JjycVx2ha
	GRFeJBGFL+rOOEbUBxTQRJCPBA==
X-Google-Smtp-Source: ABdhPJzoK2nY8MQBLLiBPXP5O83IKICYPvHNGRLC1SJewAPMDV64iR0M0Kh5BOu0feoh+8utWtcMNw==
X-Received: by 2002:a17:906:497:: with SMTP id f23mr30720842eja.198.1618993411293;
        Wed, 21 Apr 2021 01:23:31 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d3ed:a403:6ab5:b55f])
        by smtp.gmail.com with ESMTPSA id g20sm2213078edu.91.2021.04.21.01.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 01:23:31 -0700 (PDT)
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com
References: <8f1cc82d-a4a1-ef5e-0430-8e3632e378d0@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: using TOKEN_MAX_RETRIES instead of magic number
Message-ID: <23678d46-1c6f-268a-a8a9-c63c3d4e5677@tessares.net>
Date: Wed, 21 Apr 2021 10:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8f1cc82d-a4a1-ef5e-0430-8e3632e378d0@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Jianguo,

Thank you for the patch!

On 21/04/2021 09:36, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> We have macro TOKEN_MAX_RETRIES for the number of token generate retries,
> so using TOKEN_MAX_RETRIES in subflow_check_req().
> 
> Fixes: 535fb8152f31 ("mptcp: token: move retry to caller")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/protocol.h | 2 ++
>  net/mptcp/subflow.c  | 2 +-
>  net/mptcp/token.c    | 1 -
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index abd8e31..88f1e2b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -14,6 +14,8 @@
> 
>  #define MPTCP_SUPPORTED_VERSION	1
> 
> +#define TOKEN_MAX_RETRIES	4

Now that this is "exposed" in a header file, probably best to rename it
to add "MPTCP_" suffix like (most of) the others here.

Also maybe best to declare it around where the token related functions
are declared, no? In other words, just before mptcp_token_init().

Or after the other "#define" we have here but it looks strange to put
this at before them.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
