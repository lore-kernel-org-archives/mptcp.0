Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAB6E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 07:59:52 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id j3so22300983edp.11
        for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FQ53gL8bvKobT1jqAjYY491Dv/F+tkloXkRyxmtH5Iw=;
        b=rVBceuVM8NqHV0ID1XWaohSjOYOx95JTGIJCCgECO+5fkRu/B4ARwpNQIq7Mbx09oW
         ehwPjexzXYuZegVGnB6sOlag7A6htGKGcGv27kBL2x9R+bmSUW32YN+Ku7HAogS3bNJ0
         O9QilActFL8zHsw03EGyXLCBlgs5FlO15a4TQRPWkDN63wTH4gjZtShhxk95pUxQUydk
         yxxXbus4KtZWxRekM+lWJRUJ0Yoc3rReUmzKrWDy24+2Nbju6u67tcWe7clnU+K32UZS
         VExRqoKn08zJ/anONUgq6kIfOMmTVOV/LuT2/4aPHSa9QF1qMVK5r3dwdqEZKFx9Aij5
         qncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FQ53gL8bvKobT1jqAjYY491Dv/F+tkloXkRyxmtH5Iw=;
        b=HE4hGLPWnLpdR4vMMd5Azt76YhaSSnuw8iVxnspLYDwvT9G5zoCIT59LAt4iP6HAHp
         Rxi0QnbL8XfWvFQNpGaCRqnn4jj+eMAXr/waeg3i3LvgqRY5QBc140x7hGpURpriUzwT
         Sdg9qhpx2WKIIlZ0QyAwHFRsNWk4+BGnFo6NSAIzBsj3uLoRS9wez9cOWmpW/o9wa07B
         nFslp8MlPfd2kA4G+uU34zHBNxbPt5e5gqa2l6IfvsasuudXrwo9prU/5KPtqtpe6Irs
         rUIHYdYMpe+2p0gEPp/uEoA1PSclCSJW6eCLZ3V0wmDvyKzU+vBiX7SaKTckFtvS/+DN
         Mqqw==
X-Gm-Message-State: AOAM530iTTuv6Bm1/E/Gg/fB9D9GKPCVi6EEhw0ycN2x3je/rJBnKtXM
	NQP/cBmEGkLPO2QV6Qdyvq/xEQ==
X-Google-Smtp-Source: ABdhPJyQoBSX2lRplraA8Y2Xke9+hbL9TBybGngOsSDp/+tZxyBmWCFvcl4dZyqJbAWPAfO92Gj/EA==
X-Received: by 2002:aa7:cd64:: with SMTP id ca4mr3287880edb.334.1616486390813;
        Tue, 23 Mar 2021 00:59:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5b6b:b53e:da10:3507])
        by smtp.gmail.com with ESMTPSA id gz20sm10965711ejc.25.2021.03.23.00.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:59:50 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
 <20210322162132.2471823-3-matthieu.baerts@tessares.net>
 <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
 <CA+WQbwt0XaT5EfTi9LR8ZDroNk=74cHA5Yf7_RgKarHGtNWBUw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "mptcp: drop
 MPTCP_ADDR_IPVERSION_4/6"
Message-ID: <946858fc-f303-52a3-65c0-1f9c76316703@tessares.net>
Date: Tue, 23 Mar 2021 08:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwt0XaT5EfTi9LR8ZDroNk=74cHA5Yf7_RgKarHGtNWBUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

Thank you for the reviews!

On 23/03/2021 04:06, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your patches.
> 
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年3月23日周二 上午5:56写道：
>>
>>
>> On Mon, 22 Mar 2021, Matthieu Baerts wrote:
>>
>>> Fix issues reported by sparse because we are doing non explicit casting
>>> from __be16 to integer.
>>>
>>>   net/mptcp/options.c:604:24: warning: restricted __be16 degrades to integer
>>>   net/mptcp/options.c:605:24: warning: restricted __be16 degrades to integer
>>>
>>> Before the mentioned commit, we were using port in u16 given in argument
>>> of add_addr_generate_hmac function, everything was OK.
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>> net/mptcp/options.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> I think the subject line is incorrect on this one (it applies cleanly to
>> "mptcp: unify add_addr(6)_generate_hmac" instead)

Oh yes sorry, I picked the wrong commit, thank you for noticing that :)

>> , but other than that all
>> three patches look good to squash. Thanks!
>>
>> Mat
>>
>>
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 071b446aa2c9..d9e5f864d774 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>> static u64 add_addr_generate_hmac(u64 key1, u64 key2,
>>>                                  struct mptcp_addr_info *addr)
>>> {
>>> +     u16 port = be16_to_cpu(addr->port);
> 
> I prefer to use ntohs/htons instead of be16_to_cpu/cpu_to_be16 in these
> three patches to keep the consistency of the port number converting.
> 
> WDYT?

No you are right, I don't know why I didn't use ntohs/htons, I think I 
was focused on the compiler issue forgetting the network env :)

I hope you don't mind if I apply the modifications (code and commit 
messages) directly without sending a v2. Then I would be able to unblock 
the CI to have new versions of the export branch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
