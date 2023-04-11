Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2115A5
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 12:46:21 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id dm2so20121452ejc.8
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681217179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWaTRf6C8YWdWPQrffxy6ZlIMtLUhDaV8mY6LY1gQgY=;
        b=DypWss9CZJkO5B5b1OUOCh/xUD01zAu9Ehet/SEmAQmYF8yQDZDx43eN621l/XLpTl
         R7jUoyef+zoEtkjD1V6JnXeSJ7fzimQfmOev6tk73qf4RdeAMB1fuyvFlsXtII3VDt1U
         LOPHfVowMYHrpzlfAEAVI7tpo3RaXKQVQOkdIt3PjUFK0JuNBdr+pltbcqAFAmSOZa5Z
         HTrLZ1x9019LbQpRzd/3C6UI2VrRHovGG+mcbaEtNY4z3Dgh1d0AbmWwXEW4wDUzdahd
         aG2VmK83sPmVJvoVaeN7inirfGngkbl7GPnlRFoJ4jLOPoas/XUMApdUsgjbfgaXw/uK
         g8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWaTRf6C8YWdWPQrffxy6ZlIMtLUhDaV8mY6LY1gQgY=;
        b=uoaebvxAocGKs/ZXMhfubEGChMG6mxE6yqSZsnFIfsO+lSlfTul3/aSbOnwSzQvggD
         GWxpzUlxxGSnm3keSYMwWLD1YsQu7Eooz2ezc+A6+Cr8R05f1V5vFmxodypU7D8zA3Ak
         qL6znn0UbaPbqYT93O04CJU82uoMIbnCDEIYg8HCcka/wxfxE6EsZeFwmyJ9Y8bMvbmE
         Vg9D1FP0y8KaDD9qOzFo9kjG3DSoJ61rmD5rHTQ0E1cx0nND8EvOC1oeEr+apJbv/sTG
         SCdjxYq9A5wd1Dt5hdkWmlFsTFjC/MokD93QyONCvpsiBbE/Zzl9ykRcULLCY1Q5iQDX
         wcpA==
X-Gm-Message-State: AAQBX9cS2IMZ4qQSfRyWmVMgclhLSUn4MpHnVD0UHlq0Rw6cuyf0RN+P
	3Seto1nWzmoCwpIAJ22W3Xg=
X-Google-Smtp-Source: AKy350arumFB0mJu7EyJDwqsMue34wX4DmWd+2t2TdPJaSNbLOAjr/rDXTk4LJjLzAXi1kfinbcSCA==
X-Received: by 2002:a17:906:9455:b0:94a:5911:b475 with SMTP id z21-20020a170906945500b0094a5911b475mr7593307ejx.52.1681217179336;
        Tue, 11 Apr 2023 05:46:19 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::26ef? ([2620:10d:c092:600::2:ddc3])
        by smtp.gmail.com with ESMTPSA id k23-20020a170906971700b0094a53055894sm3129519ejx.78.2023.04.11.05.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 05:46:19 -0700 (PDT)
Message-ID: <09f51486-5c27-6fd8-d3c5-0edadef30f81@gmail.com>
Date: Tue, 11 Apr 2023 13:39:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC] io_uring: Pass whole sqe to commands
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, davem@davemloft.net, dccp@vger.kernel.org,
 dsahern@kernel.org, edumazet@google.com, io-uring@vger.kernel.org,
 kuba@kernel.org, leit@fb.com, linux-kernel@vger.kernel.org,
 marcelo.leitner@gmail.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com
References: <20230406144330.1932798-1-leitao@debian.org>
 <20230406165705.3161734-1-leitao@debian.org>
 <ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com>
 <ZDVRGoDZo1tTbmZu@gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZDVRGoDZo1tTbmZu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/23 13:22, Breno Leitao wrote:
> On Fri, Apr 07, 2023 at 12:51:44PM -0600, Keith Busch wrote:
>>> @@ -63,14 +63,15 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
>>>   int io_uring_cmd_prep_async(struct io_kiocb *req)
>>>   {
>>>   	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>>> -	size_t cmd_size;
>>> +	size_t size = sizeof(struct io_uring_sqe);
>>>   
>>>   	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
>>>   	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
>>
>> One minor suggestion. The above is the only user of uring_cmd_pdu_size() now,
>> which is kind of a convoluted way to enfoce the offset of the 'cmd' field. It
>> may be more clear to replace these with:
> 
> I agree with you here. Basically it is a bug if the payload (pdu) size is
> is different than 16 for single SQE or != 80 for extended SQE.
> 
> So, basically it is checking for two things:
>     * the cmd offset is 48
>     * the io_uring_sqe struct is 64
> 
> Since this is a uapi, I am not confidence that they will change at all.
> I can replace the code with your suggestion.
> 
>> 	BUILD_BUG_ON(offsetof(struct io_uring_sqe, cmd) == 48);
> 
> It should be "offset(struct io_uring_sqe, cmd) != 48)", right?

Which is already checked, see io_uring_init()

-- 
Pavel Begunkov
