Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766B23CE
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 13:38:34 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id z14so16001401wrn.7
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uy8ZqfpuMCcX2C2XRxM5OkkNy5wWWiYGQKSQSwZ7SJ0=;
        b=m1isWJg345uzbxMxmcE7MqDbbMfJL6SjoqAb/bJyczsLRIjkyIkAoHgPbEkthzDQvB
         YBfC1OIeqKskG2Cm/6U3fzA/5o0znL6n0k7isiVioob1xPpJaZRU3RuW8W5C9TfD0d6x
         xaar2/oywtfkRkopWEFeDw3fmn/2MZvF1n+EQ6qlQw5uJwPdk5vfZPd7vWyFI3hMjmRb
         1F5yixm+w7IvcZWpVUmsdnfjn+wLfGHUIQNEBJROJE86nbXVbRNOfr9X+EQvuWborAc8
         aXrpRyxaave7j+rGOgipdmFgK1XI+c81XPBe17yyVV6J5jJK6fwoi/u3wCxnOnV0TliH
         K+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy8ZqfpuMCcX2C2XRxM5OkkNy5wWWiYGQKSQSwZ7SJ0=;
        b=JN2D8pgdfYm2TxasmIN2GOwyNUKpvpbnbl0+0Okjfzn6HBLcaxrfZjJ3m7TR7Ut804
         aWoAWdUvmXeYWX/Uum8kpTviqmj+H43C1ccxz6oudJNWx73g4ZPduxqYY5CmGUWUswPP
         g1gHzJZhm4/nqtm9exiPWQbzR7UQ/tPmIwqAfjloB5Nx1+jWdS8uc+bbZtedKJFwJcUz
         3n4fPp96zovnDQ8OfjK5Z9zxJJDDRW2gOYkwwl62GKE5lnfSl4lAd6XUqhKG5t4m8jkN
         x43TKcg7m6qapLzb6p6l+mTw3nfP/sVYhQx1elhYiV+OaCOK/B4zFDfnbMDvvu18n4D/
         q67A==
X-Gm-Message-State: ACrzQf0CjmYGALgSbZ+w/teLtaoCx26lHeR7VzfQKMctSilOujub8kjY
	c9H16qDY+tBfCW2gUGhDhabGohf0IXw1Rg==
X-Google-Smtp-Source: AMsMyM49B4Q89y+CObnhIWsxNtkFd3LjcyfMd/wjX+pSZmP/syeQ1e9yGSX5DDzakxCBmjzHnO0cqg==
X-Received: by 2002:adf:e196:0:b0:236:740f:f234 with SMTP id az22-20020adfe196000000b00236740ff234mr8211193wrb.518.1667223512812;
        Mon, 31 Oct 2022 06:38:32 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00228d52b935asm7202918wrq.71.2022.10.31.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 06:38:32 -0700 (PDT)
Message-ID: <aaad626e-a646-f2a7-fb8b-158b459b73ea@tessares.net>
Date: Mon, 31 Oct 2022 14:38:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net 1/4] selftests: mptcp: run mptcp_sockopt from a
 new netns
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
 <20221019161940.3178393-2-matthieu.baerts@tessares.net>
 <CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 23/10/2022 11:28, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年10月20日周四 00:20写道：
>>
>> Not running it from a new netns causes issues if some MPTCP settings are
>> modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
>> addresses are available and added to the MPTCP path-manager, etc.
>>
>> In these cases, the created connection will not behave as expected, e.g.
>> unable to create an MPTCP socket, more than one subflow is seen, etc.
>>
>> A new "sandbox" net namespace is now created and used to run
>> mptcp_sockopt from this controlled environment.
>>
>> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>> index 0879da915014..80d36f7cfee8 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>> @@ -35,8 +35,9 @@ init()
>>
>>         ns1="ns1-$rndh"
>>         ns2="ns2-$rndh"
>> +       ns_sbox="ns_sbox-$rndh"
> 
> Hi Matt, how about clearly defining ns_sbox (as well as ns1, ns2) as a
> global variable at the beginning of this file, and then assign values
> here, as the same as in mptcp_connect.sh and mptcp_join.sh?

Thank you for the idea, it would be clearer.

@Mat: Because this patch is for -net, would it not be better to do that
in an additional patch for net-next? Patch 2/4 is also for net-next and
depends on patch 1/4.

Or maybe it is OK to do that in -net because it is in the selftests? I
would prefer to split but I'm fine to do that if we prefer.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
