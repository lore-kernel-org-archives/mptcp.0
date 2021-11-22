Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740C68
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 15:52:24 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id r11so78978026edd.9
        for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 07:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Kp8oMfJ8apxIIFx9tS+DjGVCh/q97joeCFf09g6POdo=;
        b=SnnB2wZTeEUa5qVuFEEVxZtDKFI9BdLs5qrwDf5G/isQhdAx0qlNHBdUiMpND1nO1t
         x0dlHjpOPQgyuutB6v2edwMJsd6nRJp1n7LSPRz0uRfEn1rRGXS3cAgwNZ1SuJyA4cAE
         wQg19T2Xlxs3QAs7keIaXHL0G87C3AE9M6TawALbHCy8sg9qQ3gZTMx4TnF7XK4hTCfT
         yQLOjZdFYNN2ljde3Gkq20pFh51Z6zWHz36jqxPPiMst3Y6hdAbxjMUUFF4XpuIqDh5M
         7Brw/n+HxLcLjgo477FR8RkYa9215/gs/5LW/AOf3fM6pgJIxTF71F4SqelVxDniYeaD
         T3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Kp8oMfJ8apxIIFx9tS+DjGVCh/q97joeCFf09g6POdo=;
        b=HpANHRb7as3ByZp0rNy+KnCXK8DuBDL3GDWW4PucG2Xb1hIrjkopjELe1fMdHN0XIM
         lOw8vQUhkct20t22c0AGRm2pqPnOx+fBskz1qX1axG+Jh0Xv+v5dexB2rH3fjwNXWtfk
         j9ZLUfuuP3M/LlZ72KfunXvt4G9hMhkO81k6SmBsqVJ0X+ovFwDHLoyDSxEFVKI/HwrA
         PI/YflrQI9b8MkW0vhxpKwSJ+7kX8QOi8Q2ORvpklBieUkRHwo7hYOLuU7xE7jl42EIa
         iVfOqyCn3wrf/doRd1MAxonFZG6djazqQ5KgFxhm7oUi0a2DDnbgbJFfjX/yLL7gjghm
         Oneg==
X-Gm-Message-State: AOAM531QGWXAKbqFeSfq6BMZqA5o9LR4+HmSh+KSYKCwPAgjdTKRSfjS
	56aAn9BsnHZWjjnie/11XQaYQA==
X-Google-Smtp-Source: ABdhPJx0P6Sj4B3g6Y1ac3tc++x+LXFa0mgQ7xVltEarNMik9j0ryLXxxSg5A7xqLl7cqQL6PcmXwA==
X-Received: by 2002:a17:906:1e0a:: with SMTP id g10mr41065734ejj.190.1637596342257;
        Mon, 22 Nov 2021 07:52:22 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id s3sm3874992ejm.49.2021.11.22.07.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 07:52:21 -0800 (PST)
Message-ID: <7f24c515-6b41-e58a-6aba-c9f597c07cd1@tessares.net>
Date: Mon, 22 Nov 2021 16:52:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out
 are the same
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20211122152651.28466-1-fw@strlen.de>
 <20211122152651.28466-2-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211122152651.28466-2-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 22/11/2021 16:26, Florian Westphal wrote:
> Check that getsockopt(IP_TOS) returns what setsockopt(IP_TOS) did set
> right before.
> 
> Also check that socklen_t == 0 and -1 input values match those
> of normal tcp sockets.

Thank you for these additional tests!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

> +	tos_in = rand() & 0xfc;
> +	r = setsockopt(fd, SOL_IP, IP_TOS, &tos_in, sizeof(tos_out));
> +	if (r != 0)
> +		die_perror("setsockopt IP_TOS");

Funny, knowing this was coming from you, when I read "die_perror()" I
blocked and asked myself: but why did he pick German words for the
function name? But no, "(p)error" is not a German word, only "die"...
oh ok...

> +static void init_rng(void)
> +{
> +	int fd = open("/dev/urandom", O_RDONLY);
> +
> +	if (fd >= 0) {
> +		unsigned int foo;
> +
> +		/* can't fail */
> +		(void)read(fd, &foo, sizeof(foo));
> +
> +		close(fd);
> +		srand(foo);
> +	} else {
> +		srand(time(NULL));
> +	}
> +}

Do you think we need to modify the other ones in MPTCP selftests?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
