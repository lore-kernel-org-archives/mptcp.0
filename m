Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3052F80
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 14:27:15 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso50489740otm.4
        for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZcLbYYkitcjWuFzCcWQcGe3S05bR2wnS05HymxiqAM=;
        b=X156JNyLhuXH1fEVz8Jf9dHynFNDemQePjn6eUTQlsq98p7PU+dl9C0UZkrYmJpmhQ
         pvNC/ZRO3UHDdYOJOYOiBd9zPQ215afuVQ/IaGBG6eSbvthsbqjMzdeOugZxPJsvpGge
         /itESKuS/GMjxEbRFWT1EM6qA0/sJ1AAe3S9jStuE6Rmg8ZYZ1OGFFvWeJDBx+eHEuKG
         3GB8RsCQel1jkoVXPbvwh3rgpYbOc5seYzBERHBlOzE8iL1c7KbMhVKtNTI2wTtn3/jT
         K7Nc8bLOPXOrsA2wEpUu6J431bFrOfH70HJfIoaKtfdcFW7RYdCc+Y5B6ODaAMhryvVc
         CWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZcLbYYkitcjWuFzCcWQcGe3S05bR2wnS05HymxiqAM=;
        b=FwGgi2qztzyKMkVE7ChTBmlDhQ4LL5JY2FKVEtV65/LdbaPEZy7fPXfaVoQpjeHYCG
         thI0dkN77Pf/nZ2P5G5wxl3tGlvWJ7nPZxKJf7go6yVt9sQukxtIo3J00Ll3C5SzPaVj
         +3sfkmQeDZr8OAtsPl5scHZJrNLSVfURjuDpI2GlHmy86m1ugowls3HbvSNn9pR6Wwc9
         jb+Dfopyoh66OQFPpelV1r1M8f4ds0I+J6KQc+1w+l6Q5nng7X8aoHb3OfDUE20dBB7G
         Cuae81TDRdUNZh5jigc8xVNWpXjkTSVQTwC2j9zmQiQzplQd4JHgOWyLJNEAnzOcChfg
         hC5A==
X-Gm-Message-State: AOAM530zAesumswOq/C+xkf2cFZ67+Zk7g5ZQowMxSklqxVEDDb7uEBi
	xX8SCr/7uGFA453igybz3Qk=
X-Google-Smtp-Source: ABdhPJwhwdV45wwCcqNT8v17C97Zz0EbqXiL4soYkFtD9uWQedyQeNK23ZelBL8iOkwFgXf2T0LyFg==
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3705527otk.151.1619792835280;
        Fri, 30 Apr 2021 07:27:15 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.33])
        by smtp.googlemail.com with ESMTPSA id p64sm818329oib.57.2021.04.30.07.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 07:27:15 -0700 (PDT)
Subject: Re: [PATCH iproute2] mptcp: make sure flag signal is set when add
 addr with port
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 David Ahern <dsahern@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Jianguo Wu <wujianguo106@163.com>, netdev@vger.kernel.org
References: <ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com>
 <6ec00dc5-de95-566d-f292-d43a3f5cf6cb@tessares.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0544c818-1537-7a7e-0a86-8d0c28aa4797@gmail.com>
Date: Fri, 30 Apr 2021 08:27:13 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6ec00dc5-de95-566d-f292-d43a3f5cf6cb@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 4/30/21 3:35 AM, Matthieu Baerts wrote:
> On 23/04/2021 12:24, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> When add address with port, it is mean to send an ADD_ADDR to remote,
>> so it must have flag signal set.
>>
>> Fixes: 42fbca91cd61 ("mptcp: add support for port based endpoint")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> I see on patchwork[1] that this patch is marked as "Accepted". But I
> cannot find it in 'main' branches from iproute2-next.git and
> iproute2.git repos.
> 
> Did I miss it somewhere?

no idea what happened

> 
> If it is not too late, here is a ACK from MPTCP team:
> 
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 

I'll add the Ack and apply.

