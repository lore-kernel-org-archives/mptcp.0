Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303768
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 15:05:44 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id y13so78162454edd.13
        for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wKbNkt5x9u9+mctgvzOAiCKfRCJQNloSQRUA2PoEtAc=;
        b=y/RRtoatXu8bYk8VM8gQTVT98fF5TINsGSiUMQU46nJhY2PsqKwfLJJrjhF7rgv7I7
         p8ABdhOTVuJI9Lk+/Nel/nRwFn8SE8Miz+IZBaIbN9bZ0Ttrf4+6YUh19mppZUYDu2f+
         V2KQS8FDS/KG8mC66ikA+vihH1UPDTMyGF7od1Tdv/wFU3z8uAQRmlP5u3NAzmAfPLcx
         hxk7DfoXDhwE8EoHNFj+sV+XJrDbfl76JFJ8ResMRaAbHG5INB8BxRik5i7cyzgRDwmT
         kimlrnSw6cUbSdbiimyR98ItuOA8HDMtDtelooptrDoYK62CTDfayDGGv/Z/MoqSVUi1
         giJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKbNkt5x9u9+mctgvzOAiCKfRCJQNloSQRUA2PoEtAc=;
        b=ToBf6lJj0TEHaaIrmjAhcb3NxdvqnwR1GEbwFN952zwyX3OSztx2tQm/XVy4W0DIBj
         Y/JN2uQTTOX0JKae7qGZyUThgvXAgzFCrDCyx2ZSUeH72329NvneaMypc4RpzWBDzPLB
         1wWsAmQbGyxNAlnWZIRlnrToYz9CEm/9faH4iEriOl48wau/dHxFJ8qE/SEVo/fNeao3
         kc48yNSn4rXd/zvZVxWANOFgWs2Q9bxx3YUhuJ8+ifry3cg8LKb66UdNP9xeSzaRl539
         Sgc9kmpp3usHVVeX5ap/+4bPfr5+9bVFt/kATXDfcPelzC1riV/p6Sk0CMiIEI8jzcdz
         jkPQ==
X-Gm-Message-State: AOAM532Aw+hB1NQvAQBYfcbw1o3F4yhNwLxfajEmSw8HeJPMp1+CBZso
	AGtTkQDBV/ggE1d7VNJdf6e+By2aJOICC8Q+sw0=
X-Google-Smtp-Source: ABdhPJyn/nBMnosCvjbDmuQ/DuAN/OUxa4nI/+jsT4Qf6f1Nft/1+ypX0rf2AVSFkyB7f+EbVFfm4Q==
X-Received: by 2002:a17:906:a041:: with SMTP id bg1mr40504926ejb.470.1637593533547;
        Mon, 22 Nov 2021 07:05:33 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id i10sm3988475ejw.48.2021.11.22.07.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 07:05:33 -0800 (PST)
Message-ID: <71f30adc-9f0a-b636-92e3-dffa8c155a72@tessares.net>
Date: Mon, 22 Nov 2021 16:05:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out are
 the same
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20211122112205.16752-1-fw@strlen.de>
 <20211122112205.16752-2-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211122112205.16752-2-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2021 12:22, Florian Westphal wrote:
> Check that getsockopt(IP_TOS) returns what setsockopt(IP_TOS) did set
> right before.

Thank you for adding the new selftest!

> +static void init_rng(void)

That's really a detail but this function in the other MPTCP selftests
always intrigued me. Do you mind me asking a few questions about it? :)

> +{
> +	int fd = open("/dev/urandom", O_RDONLY);
> +	unsigned int foo;
> +
> +	if (fd > 0) {

- Here, we do more if 'open()' succeeds or fails (0 is still a valid
fd). I guess it is unlikely to have 0 here because we don't close fd 0
elsewhere if I'm not mistaken.

- if open() "fails", 'foo' will be used later while undefined. Which is
fine in this context but static code analysers might complain.

> +		int ret = read(fd, &foo, sizeof(foo));
> +
> +		if (ret < 0)
> +			srand(fd + foo);

- Here we do this if 'read()' fails with an undefined 'foo'. Again it is
fine in this context but strange :)

> +		close(fd);

- should not happen: the 'fd' might not be closed if fd == 0.

> +	}
> +
> +	srand(foo);

The function looks strange but I don't see issue in this context.
Anyway, why did we not use the typical:

    srand(time(NULL))

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
