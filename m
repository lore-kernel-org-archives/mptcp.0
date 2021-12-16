Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0077173
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 17:08:19 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id y12so88509048eda.12
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=gsdPF1Pzvy3Tb7SNuQ56wScZivyYrWKTwBMHhh1eEt0=;
        b=L7exMZlq0QZ/1eYeOg1Vu2UaDEHV9YTvdx3qAiNhsf26dh5V4Z204VEScqc32qAZPV
         Q5ZKKk4TSx/YHm/iaQAMjSlOqRbg0HxjxvL24GZTyk1X2qc7HMmFJxzABEFs4eoWnHId
         SeOe3k1PVrWBTDECOBivzDISUTVxluFXE8uKjdPBiykI60q9tLIy6HhbeQgwIviiny1S
         0ipa3VnmQqmwPXB+0wA2ljYN8AkzVZ1N7XxhbtdLCkgbXh/nec2Zs8K2gSG/ex2czFHP
         aXlEi0i7olDsb6LllHJB7gsJbDbMDGUvM9GkN8351Wq3uEyRdcLMplVyZ3RJnbS5nOtV
         4u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=gsdPF1Pzvy3Tb7SNuQ56wScZivyYrWKTwBMHhh1eEt0=;
        b=AnZA1OiDvOD3LpZemoYJ7o6/9XUC/DRHmEPHUk/xvbCR0WxZdAJGrizE1Jdu30T8Zm
         jhZb4avFU7DFggjWjQqEuYHLIG8PDDre5hpeva5po1m9ckwfyjNLu7bC3VCCtzA1lzZf
         bc2uyRFQvMd23kKNwt9nSNui6SwBT6Kdwwh+oXCvenXP97YNIcAVoe2VFOoeUtaMhG7X
         fah8N+mIsa0+gHjIgr6xWfwT/qzDHp+cvjgAu/Jdsd7B63UDh8V7QOIBVBX4JkgfpODl
         0yTH9lG4taYvB+F/3CGpX6jo6/8z54397NU0ilG2sOeKjSzgKlyUeA6/fN4CP/ReZ/Go
         KUCg==
X-Gm-Message-State: AOAM531bHo3w+8QZdhJWEr3mVgJOXW/I34n9X2v9miz9rsBgeyTjKekt
	ei8vCQSYWIr8WwqxVwJq1a6bjQxXboQjaQ==
X-Google-Smtp-Source: ABdhPJy7a3UIgbTJvd2NdUtarZTHAMB5N0dVJm8OjfSGQfjYzsNctm2O9sVxh61NornfmsiyxX6Acw==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr21262496ede.57.1639674497665;
        Thu, 16 Dec 2021 09:08:17 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f27sm1978675ejj.193.2021.12.16.09.08.17
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:08:17 -0800 (PST)
Message-ID: <ab427692-a324-ac9b-653b-ae2ee80fd3c6@tessares.net>
Date: Thu, 16 Dec 2021 18:08:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [Weekly meetings] MoM - 16th of December 2021
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <a3b3916c-2a87-aa07-50d9-ab5b34266a1a@tessares.net>
In-Reply-To: <a3b3916c-2a87-aa07-50d9-ab5b34266a1a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/12/2021 18:05, Matthieu Baerts wrote:
> Hello everyone,
> 
> Last Thursday, we just had our 177th meeting with Mat, Ossama, Kishen
> (Intel), Paolo, Davide, Florian (Red Hat), Poorva (?) and myself
> (Tessares).

(...)

> Next meeting:
>     - /!\ We *skip* the two next ones: 23/12 and 30/12
>     - /!\ Next one on *Wednesday* as the 6/1 is a day off in some
> countries (hint: where pineapple is forbidden)
>     - Next one on Wednesday, the 5th of January.
>     - Usual UTC time: 16:00 UTC (8am PST, 5pm CET, 12am CST)
>     - Still open to everyone!
>     - https://annuel2.framapad.org/p/mptcp_upstreaming_20220105
> 
> 
> 
> Feel free to comment on these points and propose new ones for the next
> meeting!
> 
> Talk to you on Thursday,

But next year!

Talk to you in 2022! (or before on IRC/ML :) )

Merry Xmas and Happy New Year,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
