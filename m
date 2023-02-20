Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4E6D39
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:26:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id cy6so1330894edb.5
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 08:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUUWhUXwKUahjI0Kz4Ny2RsFdMUjBLyp1pGCmthgrsg=;
        b=ZdqS6zdGaFTgvarlP23+rFTbRvScxXqdNe9RceTgmC6gSo9fSLWF2d/KPDANMyfzIG
         A+FqUsdTWseBm4313eSCMQRNK1TzPKprfhyWFanw0kUjssOcy2laE9DwB3V+ssNeMB+7
         lBlJ6BW2gpTYrDApfZ2eqDpDJ/JBSJMR26qs/FFqVHDPV50gmuJ2npr1NaYQoJnRM8bK
         mS6oWPk5dJ56fJAy/NS+RlAWP7pZUwumcoBA+NZ/z8+DbuUjnCCOy3Axvi3L6X1dO4jV
         C0xByug08hjqXoLXkl5+6yiZKThsCrCdPAdEXdhcBpVO/x3T0G1ksTBy4rHAkKxDw7dS
         iiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUUWhUXwKUahjI0Kz4Ny2RsFdMUjBLyp1pGCmthgrsg=;
        b=UVz40QXg1ACc3KMuYLLsCd5xbK57VOomBUj/ZmonORi0NyPEr0NuSEjDlIhRGumEdL
         gi+s8nseDq6I8gOWx7TjsyH/KBZQ9w1xS8rF7GhNMY2nqy0D49E7LLAcbdqFw1T7Fywc
         SxDKHk3b9uL9H26uWv2D61TK3FwZuUjwLUr3pzerXDgEudw6B20brun9nr4sH0fyH0FA
         8imKXobzxwfPL1DesCB+J5PdUyw7hvXspzZ4YJxrvLSIi6LMp0rStNKKUP/H2IxX47Bu
         0vBmW1jcXwUzgELUvnW80ZmzO2kK2x3odWNkyLddjRnRlTLBuricvBYKONeF5fD4yl2U
         Y9EQ==
X-Gm-Message-State: AO0yUKUMFYBg4cgZ/eMxkcEdyP+SjwmznIWGMDjONNdds3ZsSQzFrT4D
	WbQ5O98GKHjEiGwQcb7bUuunmA==
X-Google-Smtp-Source: AK7set8ywdEVGu0hcRWOMoIPqYcc1qTIxZu+S8MOpp1lnIpxstcN7DYf9xRAgcTu84OTw9JGERFQqg==
X-Received: by 2002:a17:907:2095:b0:8b1:949a:28da with SMTP id pv21-20020a170907209500b008b1949a28damr10562220ejb.42.1676910363840;
        Mon, 20 Feb 2023 08:26:03 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id lf19-20020a170906ae5300b008da6a37de1bsm635475ejb.10.2023.02.20.08.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 08:26:03 -0800 (PST)
Message-ID: <7f6f4cf7-b643-544c-1fab-a19a4d6ea75f@tessares.net>
Date: Mon, 20 Feb 2023 17:26:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket
 initialization
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
 <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
 <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/02/2023 17:09, Paolo Abeni wrote:
> On Mon, 2023-02-20 at 16:01 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 20/02/2023 15:27, Paolo Abeni wrote:
>>> Since the squash-to commit, msk->first is set even for unaccepted
>>> sockets: mptcp_mp_fail_no_response() can take action and reset
>>> the subflow even when msk->first is still in the accept queue,
>>> after that incoming reset already closed such socket.
>>>
>>> That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
>>> - on already closed sockets, which is illegal.
>>
>> Should we not add a WARN_ON() there for our CI (and syzkaller) to catch
>> that earlier?
> 
> If you mean as a non upstreamable patch touching tcp_done(), that could
> be useful.

Yes, a non upstreamable patch, similar to:

  mptcp: use kmalloc on kasan build

> I think it's better not touching the upstream code enforcing such
> constraint (either tcp or mptcp one) because it should be an "obvious"
> one.

Indeed but it is just to warn once before having real issues :)
But it makes sense not to upstream this.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
