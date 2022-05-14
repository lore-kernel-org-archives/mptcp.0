Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83592577
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 17:26:29 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id g6so21645496ejw.1
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=mCxrGx7kkJqHm9rqEWWnIQxa68kqcEt7mt1tStdKC+4=;
        b=XSbvvqhiJCYU7w1KEjY32k4kV/bmJWaDnowmzaOBlYKohpVLhsWlObbmGjzcQ36mXB
         zK+azO5m7aycfKnfeo6sD97hOyPqgMrgTbX1GpkPNkmUhE9RzsnwTfWTIoXki3rWVWNQ
         kDsCuk6Tlyys00PCDZ2Wiz3z5T6yYNEqCJh9iNhuX8MwehQI06CX1oyW2XKUGn7V+PLg
         tY3nNB0TOCjbxgO5i5/wZOhInJMmLCRNjJDqm898RrOSl8wsC0z1Aug8lcA9EhZ67Dvo
         Ljdn3YPeREqppZh+1wCIPpdr5GGfxA8GiqxiMn8Sg5gR5B1c2JEcpEuxYHDiWpegdDxy
         OdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=mCxrGx7kkJqHm9rqEWWnIQxa68kqcEt7mt1tStdKC+4=;
        b=S4pw5NKL1gpwqFCumf7oQQHLKWL3beIaeLfToLaCN94c3VS7y1jJnPOpCsNTjXYrA4
         y8UJDDYIzeOg+arAC9mdmj59DwQVqTxC+9fmT1f4CI/BqDS60pRpwkMv+6K0id1ZE/MY
         GhLQwRIUS7R1AFFst9nKQgL3w0a81gl5fTWknKpoT2nI5sNodHEq549JARoMVRS4g1m/
         7mMI3tNGARnjw2g0JhZW9wdSM/bFEGPPE2kftSDLUGS/9FTlKUT0t1nBfb9vrs+B+8Pa
         O/j7oWKdzTGxrSzGTkmIalnCeMRKuq3DqjV06L85d5IeThvUeEjHyBIY7uLJrc4PYXPf
         21LA==
X-Gm-Message-State: AOAM533Cy69i5kOyaxMFshfZE5TKVRFGev2S1O+Df8JCm4/TjzzZVKX5
	f/JPDbh4mYzQI8LnfCDLoAXgOd2ijGZfz1le
X-Google-Smtp-Source: ABdhPJx9F3XWdFj7IHAgAh8r7qOFvRV2HodYnEAZwd05Ivn+x8Sm/cU0xGVuI7DMyuPE72xFlvE99Q==
X-Received: by 2002:a17:906:5d05:b0:6f6:6353:c325 with SMTP id g5-20020a1709065d0500b006f66353c325mr8902648ejt.749.1652549187946;
        Sat, 14 May 2022 10:26:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae9:144e:df38:3671? ([2a02:578:8593:1200:7ae9:144e:df38:3671])
        by smtp.gmail.com with ESMTPSA id hz20-20020a1709072cf400b006f3ef214e0fsm1878337ejc.117.2022.05.14.10.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 10:26:27 -0700 (PDT)
Message-ID: <349fa6a5-6e64-8bce-5592-6164941659b9@tessares.net>
Date: Sat, 14 May 2022 19:26:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 10/05/2022 18:25, Paolo Abeni wrote:
> The MPTCP code typecasts the checksum value to u16 and
> then convert it to big endian while storing the value into
> the MPTCP option.
> 
> As a result, the wire encoding for little endian host is
> wrong, and that causes interoperabilty interoperability
> issues with other implementation or host with different endianess.
> 
> Address the issue writing in the packet the unmodified __sum16 value.
> 
> MPTCP checksum is disabled by default, interoperating with systems
> with bad mptcp-level csum encodying should cause fallback to TCP.

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Mat's RvB tag:

- 5291df4774c1: mptcp: fix checksum byte order (with conflicts)
- Results: 128393ceec9b..35e8b300fc90 (export-net)

- 9a016e9bf5e7: conflict in
top-bases/t/DO-NOT-MERGE-git-markup-fixes-net-nex
- Results: 9634a3a2eced..5ebe27580643 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220514T172044
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220514T172044
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
