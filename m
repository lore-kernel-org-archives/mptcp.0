Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752312FB1
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 07:29:43 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id b25so38504442eju.5
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pMkNooRNqtDdw4qUaAg7v0b86Z6I4/D12IQMMp/vdlY=;
        b=EPKQ6Z5KtlPiuqHBLVkDkzKIX3fBbGxGpqVSRPLuzWtD3bqrQPSKd1e1kdXPpDp3pA
         9F3YoPuIn+LUJQaSraYWgjBGSeqaFbkETQFLx4P+Hrw6SPvRp7ixuqwAVqz/KvnfFXT8
         X0AesuUwI66iSDEmYeakhlN4PGHcPOd/I9I3MpuAsZ1xkPcViNSpl3kVMF8aPNbx5bpZ
         v8pgwDmeJX5YDTklA6/2Zc+EFm9f1EdpYieimZxW/hJ0uRtFZuyG8H3MQ8OmfnVscHjv
         fJvWRxybxcair33rNRSX/g/DKN9JtT2nq3m3uxKsUCIjkSBLW996WK9Qk7m+fbps9TtO
         xyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pMkNooRNqtDdw4qUaAg7v0b86Z6I4/D12IQMMp/vdlY=;
        b=JW7klx0PZkuPHiSxj+LDckUREZoGG+zYSPLc93u+eKnG8RNpYTvVOMv0jbQt9iTeyH
         leer16CIFxTm4uEopmQ6eFAN9V/nwvp06eIZsYRbDYzS/kWMyK4b4TAaKuetfNyTWtA6
         NC0OGp74m67Dh/gqXsENiJvK2gr9Lq3Zf0xdp3PQa2Hbx+tfYUSbITSOljHaAmHyA3gU
         XL+F8h9mADE98JX+3+r539HZdexyf0RvZgikNg1IMCpu2kd+Eet69a4j1x0u48heI/dP
         YoZ66wpYPhpuAI1IBnF63K3ZSIXshwANUkNLdwZbL6TTPhAeERHLjgLxKO0snFRGKG01
         XjYg==
X-Gm-Message-State: AOAM5306e0mRFFZlARm0/TGiNzssAI6A2w2quYU6gOLwEbtVf7ITWIcj
	dZej6Do6uH7UHoUJ7pgVH4OboyclmEo0yYUb
X-Google-Smtp-Source: ABdhPJxN2RqvA1eqliVX49UQBsNcu+JkYRu8Xr9L4+BYHwCGBz8HiZIejm68jsUak2PLbIZKJr3ZJQ==
X-Received: by 2002:a17:906:fb04:: with SMTP id lz4mr42832377ejb.66.1620890981629;
        Thu, 13 May 2021 00:29:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8928:ef6b:4f39:1fcb])
        by smtp.gmail.com with ESMTPSA id v18sm1088109ejg.63.2021.05.13.00.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:29:41 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add sk parameter for
 mptcp_parse_option"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <9fc0ac14-28e2-f284-9052-f0bf1dfb7552@tessares.net>
Date: Thu, 13 May 2021 09:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/05/2021 03:12, Geliang Tang wrote:
> Keep mptcp_parse_option unchanged.
> 
> Please update the commit log too:
> 
> '''
> mptcp: add sk parameter for mptcp_get_options
> 
> This patch added a new parameter name sk in mptcp_get_options().
> '''
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the patch!

Now in our tree:

- 079024ea2393: "squashed" in "mptcp: add sk parameter for
mptcp_parse_option"
- 31116dbd2a19: tg:msg: remove mptcp_parse_option
- Results: 0ebe24033a1a..bcf6675a2d3f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210513T072854
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210513T072854

Cheers,
Mat
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
