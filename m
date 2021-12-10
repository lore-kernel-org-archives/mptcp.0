Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28A173
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 15:36:10 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id x10so13823084edd.5
        for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pSCdhRVaqsk4roNXcaGq1tqrFLad6hYGJmVQo7mh3wk=;
        b=mI8edDprSwsq2jpSeyuaE6JSmyj3g1pjk0vZiJPadBc5WWxuQPFP9e1rdsE9RIPiDQ
         TwzsYHpXhKKosyFiULwj9z6TxNXOcPhCK4gWlrsOMtST5uRaz/V2e7WTiRbLp1DdM/XE
         TReTkWXd/MH4X51GVoP7TeN/T+I3LcPtTLNm10vrRlgA4Bc2ZhW01/Wjr5GXVO4SZoqy
         7LdcU0SBoQxP3shsQrGxiupDHbPiUTGmH+fDEP7r5ClvHFa8jDw45eZvwmeP5ldwj8RY
         b+AyAXjGb2mcFUyvcXWENLBxQUwDEgS/pSIuiEf/fsRqaLgBwxJHCsisa8Ge6hvkFYEY
         XNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pSCdhRVaqsk4roNXcaGq1tqrFLad6hYGJmVQo7mh3wk=;
        b=WzzdAPIB+LxYU04AuW9Nujlw9eLCLt2T4i7cQG2sWm2r3cc1fdTzciTIvDsE+Clr+8
         Gj6wv8wIRl88q7zGD1l4+iTeyqwn/0YyvQ0r7wLGmqdRNxO6VTSQoyYwOE2+oECGXTwu
         0gLd/V+Z3X/sR+MkH+okF/hXAalJ2LvshoKr82S9O94FpmICna4G7rKxodBQwV6O/Hou
         qxkGwkl/trw8/IwV5VpT/nMbPwQ9H/Nxp9a0/91cUNBOBRmoNvMUqTJJYp6eDHfxsxuy
         Cag8JQ2u37/1gYj8+tQ1+cqxmFA7VW40hrV0ayG6rQmGQudNpy/inWCKqFIKBFkuqB8x
         F+aA==
X-Gm-Message-State: AOAM532NK8t5yRXa2SXD6Dv/d3jtPFl1KyIGnjZMfwPKOQf/3fUmFNjp
	elAiBVgPYpDRcYLwN6A66l3SYw==
X-Google-Smtp-Source: ABdhPJygZ3W8i16qoncudmp3FcQlV8i4KEF4s5cLPBM/iVDjAfBLgx9x1LTfPyT8pVUWLm67SwHTAw==
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr24774352ejc.290.1639150568293;
        Fri, 10 Dec 2021 07:36:08 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id ar4sm1588523ejc.52.2021.12.10.07.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 07:36:07 -0800 (PST)
Message-ID: <b6c19c9c-de6c-225c-5899-789dfd8e7ae8@tessares.net>
Date: Fri, 10 Dec 2021 16:36:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] selftests: mptcp: remove duplicate include in mptcp_inq.c
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: cgel.zte@gmail.com, mathew.j.martineau@linux.intel.com,
 davem@davemloft.net, shuah@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
 ZealRobot <zealci@zte.com.cn>
References: <20211210071424.425773-1-ye.guojin@zte.com.cn>
 <ab84ca1f-0f43-d50c-c272-81f64ee31ce8@tessares.net>
 <20211210065437.27c8fe23@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211210065644.192f5159@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211210065644.192f5159@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 10/12/2021 15:56, Jakub Kicinski wrote:
> On Fri, 10 Dec 2021 06:54:37 -0800 Jakub Kicinski wrote:
>> On Fri, 10 Dec 2021 10:58:27 +0100 Matthieu Baerts wrote:
>>> Hi Ye,
>>>
>>> On 10/12/2021 08:14, cgel.zte@gmail.com wrote:  
>>>> From: Ye Guojin <ye.guojin@zte.com.cn>
>>>>
>>>> 'sys/ioctl.h' included in 'mptcp_inq.c' is duplicated.    
>>>
>>> Good catch, the modification looks good to me:
>>>
>>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>
>>>
>>> This patch is for "net-next" tree as it fixes an issue introduced by a
>>> patch only in this tree:
>>>
>>> Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
>>>
>>> Regarding the commit message, please next time include the Fixes tag and
>>> mention for which tree it is for in the FAQ [1], e.g. [PATCH net-next].
>>>
>>>
>>> @David/Jakub: do you prefer a v2 with these modifications or is it fine
>>> to apply this small patch directly in net-next tree?  
>>
>> v1 is fine. Let me apply it right away and do the edits before I forget
>> they are needed..

Thank you!

> Actually, I take that back, let's hear from Mat, he may want to take
> the patch via his tree.

We "rebase" our tree on top of net-next every night. I think for such
small patches with no behaviour change and sent directly to netdev ML,
it is probably best to apply them directly. I can check with Mat if it
is an issue if you prefer.

I would have applied it in our MPTCP tree if we were sending PR, not to
bother you for such patches but I guess it is best not to have us
sending this patch a second time later :)

BTW, if you prefer us sending PR over batches of patches, please tell us!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
