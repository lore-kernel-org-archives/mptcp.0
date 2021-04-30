Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730612F9A
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 14:50:42 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id u3so26973342eja.12
        for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gUJ9FjOlvILDnVEQgM4Qbo77GgjrqL2BnpZ7tigxVZ0=;
        b=02NjxWl1uAiB2g4T571RZEMwkOCQKfYKrRqNaBtjlhHE6I1FnZPZmD9I6THnLBpmyr
         oFobaPK6IC31wBg397dTT5Ps8uQ/pIJswFwPerWhFxR78+lqNliPcbVUeISUAul+mNUV
         rlHWVkT5LhSlzRZEt1SMSxNhkvWpbBHUrUxzMm5wHHNRH+036dRiG6Fd7UCE6hTPCV7H
         97FQWd0ubsOoEI7lx1FuTfOUA7KnWarxKTgy8mEBjWzIXHQ8wKI+gOsW9EOemeLfkMuu
         0FPukCpSFeWamv/ydodo66xIXiksXqDGyBaBcZ4yDlKrZdJh94yU7QIUb42fVJLhW1Rq
         XMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUJ9FjOlvILDnVEQgM4Qbo77GgjrqL2BnpZ7tigxVZ0=;
        b=Lht9r1Hmdl6736TGSY0flAQMlHS1kwAIax2xosdrhcmrH8ZgG950ZCx/fXKU1/0dIT
         ZBRBqeCcw38kI6wKvbMBgXTPE4mQ8fu7RUoFxsukYZ8YEsqVhmNUQpwdRwGGv0GJSWpE
         9PBz2LGbH7xcwgEnn/ybBTYvkp8mvuLEu5Zmcut56IdyX8rWVsmBtwzsBCKOGNQ6raD9
         4spHkXP/VjkwP+ZDbMLSu3GCLhVZqo5tBxlxBotJnyRn1Q35nky4BOhrO7MZ59DUOdr8
         i6J93lSpJrEEnjYoN/Mqj+TL5DWiigbRyJg9bn6yKk04/k21oxhSZjwUQzkWusy6TF0f
         fzEQ==
X-Gm-Message-State: AOAM530mEuXZVkTUNTRvjHjYpE6BcNvMCtK69gSJpN9gXZyycE4HD1GO
	vGk+Fxd12TcyXw7s1Q6xCMQ4peX+GLyTqZb16IM=
X-Google-Smtp-Source: ABdhPJw819dLYiycp1o390l//8YnEK3p7mcejJzC1czwPpI4E/6+E93csILPyOhmQCj5HOuukod1Fw==
X-Received: by 2002:a17:906:f41:: with SMTP id h1mr4872178ejj.399.1619794240719;
        Fri, 30 Apr 2021 07:50:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b92a:fcbd:82a0:9dba])
        by smtp.gmail.com with ESMTPSA id w19sm1348926edd.52.2021.04.30.07.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 07:50:40 -0700 (PDT)
Subject: Re: [PATCH iproute2] mptcp: make sure flag signal is set when add
 addr with port
To: David Ahern <dsahern@gmail.com>, David Ahern <dsahern@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Jianguo Wu <wujianguo106@163.com>, netdev@vger.kernel.org
References: <ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com>
 <6ec00dc5-de95-566d-f292-d43a3f5cf6cb@tessares.net>
 <0544c818-1537-7a7e-0a86-8d0c28aa4797@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <0005ef27-7304-152b-58e8-b5e0cc87b492@tessares.net>
Date: Fri, 30 Apr 2021 16:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0544c818-1537-7a7e-0a86-8d0c28aa4797@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 30/04/2021 16:27, David Ahern wrote:
> On 4/30/21 3:35 AM, Matthieu Baerts wrote:
>> On 23/04/2021 12:24, Jianguo Wu wrote:
>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>
>>> When add address with port, it is mean to send an ADD_ADDR to remote,
>>> so it must have flag signal set.
>>>
>>> Fixes: 42fbca91cd61 ("mptcp: add support for port based endpoint")
>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> I see on patchwork[1] that this patch is marked as "Accepted". But I
>> cannot find it in 'main' branches from iproute2-next.git and
>> iproute2.git repos.
>>
>> Did I miss it somewhere?
> 
> no idea what happened
> 
>>
>> If it is not too late, here is a ACK from MPTCP team:
>>
>> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
> 
> I'll add the Ack and apply.

Thank you for your help!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
