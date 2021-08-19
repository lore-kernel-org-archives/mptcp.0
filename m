Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119D6D24
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 14:56:41 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id qk33so13461264ejc.12
        for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Aolo5HOMotnMona3VvhCs1suT7LJfR+2s6jWLZJqfw=;
        b=suQiBHA8h19GULA7d26R+cUeQieDQb/7x9ZRu1NSQnxR6BPuqwPGgxMDhSFN0zjnAb
         ekT13PAVbviY3FljWTMMY6IJJUtZoBQLvN3q/uAjqJW1mRU6Nofo+aa0bny1Dh6isPZe
         hLIYBPjGjtqBfRAlERG3FLwDHCrEGySL97VYGmA/xw/R1HxE8iNuzaflGS7HxMNoFeoX
         2kHPOhfs+cEKsCFpJRahszVzfKutuaF6HgBU07tAkfXMGcEFjhAuhWtcahIk/PFPc6zd
         XnAAllTnO2Y3+xMIqlbKQhXOchTsg3zVS2wc7MyhmmhnudJ7uMsynv4PnWCgWHkxNiyb
         u/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Aolo5HOMotnMona3VvhCs1suT7LJfR+2s6jWLZJqfw=;
        b=ttHVp0TxDjvQgwsAkua84JoMt3XKwq38ILcbiAtJRX3FEXSpYTn6MEMXMPhVNfmP41
         T2THm5bxRBhfQUnrtn3+RwETYzOD1IhXFIdFASnLEaHi5vSrntQPKytXAazxxN1IvMo8
         hfRQzVWzKg5urfr3bMLU/2nHPJZdVJJegkuSaKfsMWlrXAEaHQwU6tQYg1BQwZRR1xRS
         e8piTRo4F7SdcEp4s3op9nV0bRlletmhTGzlSOaw0IHnNte6mIaXM1ShDeug4cTxjPs6
         KiopcFkTXo6ukOgrS3VbgwfAIvbQHbjd6HWDXiCrUxaSo+TIP2y1CZ0czBhM5FoFasT8
         lOGw==
X-Gm-Message-State: AOAM533n1l1Ms0H7QoFFVMQ5L9AJzFn9mtEfsDYwrpLSCPNGJsAReyhf
	sI1j9Ny0MxOrsZPHhiKZzeO5DdV8krv/vmKW
X-Google-Smtp-Source: ABdhPJw7KRnF/gHmDquZiW681GaPrfWHO42S5jfh1rghKEthSi5PbD0lMkq4n4Hg+EBfIXZDMXZEiw==
X-Received: by 2002:a17:906:2642:: with SMTP id i2mr16637468ejc.323.1629385000182;
        Thu, 19 Aug 2021 07:56:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.142.31])
        by smtp.gmail.com with ESMTPSA id o17sm1823036edc.58.2021.08.19.07.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 07:56:39 -0700 (PDT)
Subject: Re: [PATCH mptcp] selftest: wait before trasnmitting first data chunk
To: Florian Westphal <fw@strlen.de>
References: <20210819130040.30228-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <dda5fa72-be05-cca2-6839-343b56644ab9@tessares.net>
Date: Thu, 19 Aug 2021 16:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210819130040.30228-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian,

On 19/08/2021 15:00, Florian Westphal wrote:
> Squashto: selftests: mptcp: add mptcp getsockopt test cases
> 
> Mathieu reports spurious failure of the selftest:
>  mptcp_sockopt.c:362: do_getsockopt_tcp_info: Assertion `ti.ti[0].tcpi_bytes_received == r' failed.
>  mptcp_sockopt.c:330: do_getsockopt_mptcp_info: Assertion `s-&gt;mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt' failed.
> 
> This is because client and server are racing.
> The first getsockopt() for (MP)TCP_INFO might be called when some data
> was already received, but the mptcpi_rcv_nxt assertion relies on the
> initial call to fetch a 'start sequence number'.
> 
> Extend the pipe (that was used to unblock the 'connect process' when
> the server had bound a socket), it now tells when to connet and when
> to send the first chunk of data.
> 
> In addition, its remote chance, but possible, that tx is slower
> than expected so allow tcpinfo to wait a bit for more data to arrive.
> 
> After this, 20k invocations pass without failures.

Thank you for this patch! It looks good to me!

It is also passing multiple times without issues on my side with and
without a debug kernel!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
