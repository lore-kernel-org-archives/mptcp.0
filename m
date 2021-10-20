Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612A2C8B
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 10:39:57 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id t16so24460148eds.9
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WCJZym9y4FK+QUh2CXRIxeIgGfyJlAn0lbQYeJmJ3dY=;
        b=oeL5VwVECTCZnsv6oGsa48Lj+vsIOqT4Kgi+LlLjbH7J5F+9+pytqMJfAZecaIe18E
         ndSu02/OwtYNumdbQ6YjV/xg+jdTwdJVxMBtR29JOHGxayi1KPgr6S587G/dhHkZsGEB
         5dIMhfywcfVCOscjTs4tGSNLnnBae066nu1gqMqWeO7LUku1M+tMaPvUvSYzc6W+IrEy
         +4rVTzGWE1o5yRP/VbrxVIXwH6jQZAgG80Cr+ARJivRJtsxj7st0rIW9Dr0YTK811DFR
         RD7s7mnm2j6z/ScGvUWSkWgOmvfxnwyaSoUgQXT4+ZJPOAUAV6trHW4FRbwHroSHwOVt
         PSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WCJZym9y4FK+QUh2CXRIxeIgGfyJlAn0lbQYeJmJ3dY=;
        b=vnW0AM57wE5yC+d72xcz8XDfumJBVX6/8nVcs1GbFQ8z0pcm4BAouGswy/e+3Xy+XZ
         t9avP072i4TVGS1cFEvFUsdGEIAIxx6kNu+WP/kvZCKWbEeJNK2JjBNXq79ifuYIPlA7
         IKYEtilFY3GbfMeM367ZBvrpEQsQsEkp+SdTACPNNpJj5Qh9d4y0ADnDWY1dyP+hxN+c
         voaKoJ9E8Dx3lOkYoTfjNHq9YeM7M8gxOpMckLVbR8XjBfsn7w/or5lkoijSGkOEdO4F
         pouueEJH5VVwplL6y4FKFxfx7LN02jWCqTdu0Ql726eC0vvS8CnGc6ZIgDCzzT1sdULb
         Rhvg==
X-Gm-Message-State: AOAM53289D7Ww5OCmxGl1nzXyFHOqpUheH0BBsEZMRkMiL1L6t+KrDBk
	xgCOHKLM4PKkz22DvpBilXdGhA==
X-Google-Smtp-Source: ABdhPJwxoO3gbZe6dAesiZy4e+6t99O6Y0yDhoTDaZA01phffx/ar8Dl++fLXvR/MhxT0wuWW/yrqw==
X-Received: by 2002:a17:906:fc0a:: with SMTP id ov10mr41019866ejb.536.1634726395737;
        Wed, 20 Oct 2021 03:39:55 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id w3sm1005451edj.63.2021.10.20.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 03:39:55 -0700 (PDT)
Message-ID: <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
Date: Wed, 20 Oct 2021 12:39:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliangtang@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide, Geliang,

On 19/10/2021 10:29, Davide Caratti wrote:
> On Mon, Oct 18, 2021 at 11:03:13PM -0400, Geliang Tang wrote:
>> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年10月18日周一 下午8:50写道：
>>>
>>> On Mon, 18 Oct 2021, Geliang Tang wrote:
>>>
>  
>> Hi Davide,
>>
>> Could you please share your test script to me? I'll try to use it to
>> write a new selttest.
> 
> I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
> bit in the TCP header, I promised myself to change it to corrupt the DSS option.
> The problem with this approach is, we can't assume that the DSS option has a fixed
> offset from the IP header. So, the test might start corrupting other options that
> are not MPTCP.

If we corrupt any data in TCP Options or data and update the TCP
Checksum, that's enough to corrupt the DSS. For example, we could flip
the last bit of the TCP payload (if tcp.len > 0). Would it be possible
to do this by adapting your script?

For mptcp.org, I told someone to use netfilterqueue + scapy. He had some
issues but also shared a working version:

https://github.com/multipath-tcp/mptcp/issues/420#issuecomment-825771587

I guess we cannot depend on Python and Scapy for selftests. I don't know
if we can also easily depend on eBPF either :)
And using simple solutions like "tc netem corrupt" will be detectable by
TCP csum.

So maybe your way is better if we can corrupt anything, e.g. using a
fixed offset like 120 or the last bit (if it is not an ACK). WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
