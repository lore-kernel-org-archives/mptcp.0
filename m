Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBDD304
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 11:06:10 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99b9421aaebso273185166b.2
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690542369; x=1691147169;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gu7irLLDN8UUggZ1jhF6Wf7ZiUdP/vTL0V79W+yFLU4=;
        b=d3P/nSeS1jJ3YRG8di6ZIIxBsrjmvysWZKBHxEZl+P/7zPiVGL33MHScav/P2LCV/2
         CtWCN76IEoX9Kycrq+nAKsKk/4Gm4iGPdZv1zMz8JAlsmYQdrLUSmSJYgVpv6dgFEDMv
         qcedEr9CpV+SKg2qadlIskgqKTKkRlAGt2rLXZR5ARm9sooZI1J1fXz6MdJRKH0MOsXv
         xbFSzSXTxeQbVg05MyAZCbEX4c9YT9/uk6n2l8yD2Sty2Zhopg+ukkKGMMz9N80DY3mv
         YhcGqK0PzJ1lnZdV7dOzcydPtrlTyt3942vqJ932teBrrZsMpNSN/L8vJWzaqT3FFg9W
         REcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542369; x=1691147169;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu7irLLDN8UUggZ1jhF6Wf7ZiUdP/vTL0V79W+yFLU4=;
        b=klPBalxZY1wGq2XTZ5STQO6NQobGlPl+EUA0a9KRwd2Ns/DnNQI1bw6JviW38NTpP+
         hWSC/+91fg0cMEOmvdY/VH3Yki3EEmA8OlKLY3aVaeObBtSRvAT8BViXdLoab0D0g6/y
         oSHnClKQYT+9CpSrf9SzoV1bJErKgRa5pAK1+M3VcNR/vkT7BGf5qDwUmssRoBM2i0jk
         boXSzAy7dwWstmDZCz515CAGXqXBcOCJ4UUoi5plMzGnBAqNOR/iqI/3CJTyGU9PGEsb
         ennv2/5syEO0sC2ikiCQc8/8CS/My5HAqzNxeNcuQ4Zrudba0fQfPg7kMNL531bAlaS2
         X72w==
X-Gm-Message-State: ABy/qLY7eXJntA2XoGEVFMDHzI2gK2h6VIiOZAIRctnxwXP/gcHA/O7q
	QwWpoFxRHs6QLpvJBjQC+e63hpCu1xwwylb/p8AjDg==
X-Google-Smtp-Source: APBJJlG9bcuZW9ZSl5DiPCYSb3tQiTzmuCO2q+JbHDNrskcn3CphcFL5SYQm81LRypMsE+MxMqNbSA==
X-Received: by 2002:a17:906:11:b0:993:fe68:569c with SMTP id 17-20020a170906001100b00993fe68569cmr1622535eja.6.1690542368947;
        Fri, 28 Jul 2023 04:06:08 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b009934855d8f1sm1893691ejr.34.2023.07.28.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:06:08 -0700 (PDT)
Message-ID: <b088f630-035b-17b0-26ad-0f4e70530c2f@tessares.net>
Date: Fri, 28 Jul 2023 13:06:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-net] mptcp: avoid bogus reset on fallback close
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/07/2023 19:15, Paolo Abeni wrote:
> Since the blamed commit, the MPTCP protocol unconditionally sends
> TCP resets on all the subflows on disconnect().
> 
> That fits full-blown MPTCP sockets - to implement the fastclose
> mechanism - but causes unexpected corruption of the data stream,
> catched as sporadic self-tests failures.

Thank you for the fix! It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 12ee162a0d4d: mptcp: avoid bogus reset on fallback close
- Results: be9e061da26c..f8d0d9188a92 (export-net)
- Results: c4e88c45e27d..b5ba626e6a54 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230728T105820
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230728T105820

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
