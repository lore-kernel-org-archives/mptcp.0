Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DE2C80
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 14:47:13 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id j2so29625676edj.8
        for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a1XeoTxbsD22NX1Iqf1VUQWmEc3RqUZk2pxQ4/VfQRw=;
        b=d4WjR1YqLtx5fOPwZ2svvdEA50thK2eqwmiccjNoqizCBEKkFz8qkwd4FTXewKcsvM
         Gf1HxCSZ2V4Hb8X9iymlv3NpXl3jKMEvZfLniBbDsyJefz9UlFvcevoIJ0gnEDzDzkMf
         Zc6W2DIZXtSJKTOrUAiL9qHb7Q3rn0SmVTtdxD9QPWBUmkT/xeWM4ta7Z9905yjCcJZM
         KmOS2X5Bq+uASp99Yd9vWAlFEI4DQayIOTL65H1wBjjR1hWp4Qj4uxCSLGHrB6F0qJwa
         iDCQwqs02R8E/pXksz9LRiMtmobn7dAroOyFxjD20kw9NgpRGzGXemIpwe+88JZ/i9Mb
         2rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a1XeoTxbsD22NX1Iqf1VUQWmEc3RqUZk2pxQ4/VfQRw=;
        b=igZbFuEsFLwlwUzBHT/qoPywgROg8i8P+oWSB5rqlTr1p9TwhhMX/f0fQ4GUZOI0Ii
         wZwD7OqIoOWG+/O9Csr8f7A4mbpKiE6GlT83qfDofYcGKJJQmjkkD7sI7aXMwyp/F2zs
         G5jK5yMC0V6CLP8pFgWuMpipB+erOld+bqgF80SQmFGhSnbfOwJtGYvI62DnytsExnjU
         CAFtwsOtMGzTBfD2SDpSxqoGevxW5m+UkH5o6no1BNX+yaSPP0DhrNwvWSdeKkE/tO7D
         YmiRAeiOil/eDJ0OPkpHaMi5f6iz88D2fsYkhVxMSlMkJpyoVLZ+QtORlkNeeoar5mbx
         9n0w==
X-Gm-Message-State: AOAM5306OGAslDTI8LsPLUB6GWTikJhCkxwZaVmaguKEBSiKWXpwibr0
	5IwqsR6VNhffIfk+nM6r8ynAEySc1g2l2Nvf
X-Google-Smtp-Source: ABdhPJwXDc4Ye8VLApSwm4JEvyEheyNEiwwfIjzW/0EWAQOm3AGsICZlTenlmwKZnDkZHAtjC6Rypg==
X-Received: by 2002:a05:6402:1395:: with SMTP id b21mr36284353edv.299.1642690032248;
        Thu, 20 Jan 2022 06:47:12 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i3sm1391923edb.13.2022.01.20.06.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:47:11 -0800 (PST)
Message-ID: <bed39974-49e9-c4fb-0d61-92f21c3cf633@tessares.net>
Date: Thu, 20 Jan 2022 15:47:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v2 00/10] set flags and selftests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1642320655.git.geliang.tang@suse.com>
 <c135c322-e71f-f525-ba83-ea53691e65f@linux.intel.com>
 <20220120102056.GA2930@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220120102056.GA2930@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/01/2022 11:20, Geliang Tang wrote:
> On Wed, Jan 19, 2022 at 05:01:53PM -0800, Mat Martineau wrote:
>> On Sun, 16 Jan 2022, Geliang Tang wrote:
>>
>>> v2:
>>> - use a mask of changed flags as Mat suggested.
>>> - squash patch 8 and patch 9 in v1 into one.
>>>
>>
>> v2 looks ready for the export branch, thanks Geliang.
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> Please add Paolo's Acked-by tag for the first three patches.

Thank you, I will add the Acked-by tag and also directly apply the 3
squash-to patches you sent, they are OK for me and fixing issues.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
