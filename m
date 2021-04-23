Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131502F83
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:04:17 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id r9so74075010ejj.3
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOE8zwYy5j7sWC6DfZVirq0Juw5ukZCq6oGff2g4xGQ=;
        b=nfc0Q6j1c7NIc3gCyAtsymkt5aOq9SFnKCLBO3jeVpmT/JxydwaUPV2i5StaEq+KJi
         TLamHKKBPuXjGv99a14b09Dd9b0EQUxtzJI2j9hfugJ4OfYIMDyue/UVppVOGahYNkf7
         UxL7PTFWUbiUJcpJKjPvFrbVTtB52w9q7p3gz/+79lFZmjb0cz1Ws4GObOeqNSJvWCLO
         IRN2miHmBSRfY1zHaxSfijFNPfbbehcnshat2JAuYnZbS40veMzZgsKTXFTt/2MHpiKu
         yJGvPjfPYBMdl9weP6VvYMVhCaiHrclJpmBYZAXxX43X9vgZqAG5VYmIU7QA4k8AzoKV
         ojrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOE8zwYy5j7sWC6DfZVirq0Juw5ukZCq6oGff2g4xGQ=;
        b=ls1KVugbDYpdvxm5wzsA7+6IuAa0q+acfiygWDOON2YmggKAjBbMW3E8SUHTwlb5lR
         kBlix8Qzekqhll4LYH9MCQrwR60xkUnuncYILJGkw6xykEN6/QaDqZDAOKIQaZIuNf8y
         +7bgo0Q/RgwP5ld2OtQHE+2q+2hKZ0EPkGKHWgHiDyGoBrbV/SaU1p05O9fqfPD6uH1K
         WX3T3gYiEJSnGA1Qg+4eogjWBm1zXNR4DpVu91W7wbgx6znl4cGiohn58pHftDVhfXoy
         qM1R7+NDonnp2zINWu9CZMi2CzOHqTwS3VTGazaq+rwVbfV2oTxGvgF0Ok9lbCOnVBRW
         IlxA==
X-Gm-Message-State: AOAM533at3+iAVKwJyKlmU7Okr9ODcrMlDKl7+/vxPq4e258KTOf2p4s
	lnKKVPfVBY8OS//cliX0O2KcMzPI4B/2/Q==
X-Google-Smtp-Source: ABdhPJxwWcSGnPlxe3wTaOZPIK3Vx6FLPbYjrGds6IV210fdQbYACT5AbI6TrpwzmbqYjtzQi7UaoQ==
X-Received: by 2002:a17:906:a155:: with SMTP id bu21mr4446479ejb.400.1619186656308;
        Fri, 23 Apr 2021 07:04:16 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d068:c16e:598a:1275])
        by smtp.gmail.com with ESMTPSA id hg19sm4052534ejc.24.2021.04.23.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:04:16 -0700 (PDT)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Geliang Tang <geliangtang@gmail.com>
Cc: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
 <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
 <CA+WQbwsPfUzejWRriaTR4t4wJctCXpS-T4Byf1LFG438MC5ZEw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <f805da0d-a32f-6518-e0f9-1309d4579218@tessares.net>
Date: Fri, 23 Apr 2021 16:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsPfUzejWRriaTR4t4wJctCXpS-T4Byf1LFG438MC5ZEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/04/2021 10:59, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年4月23日周五 下午4:21写道：
>> On 23/04/2021 09:41, Jianguo Wu wrote:
>>> I think this is better, we can't assume that all user-space tools works correctly.
>>
>> I was thinking a bit about that. With the proposed modifications, it
>> means that a server will have to send an ADD_ADDR if it wants to accept
>> subflows on another port. I guess there will be use-cases where we will
>> not want to send ADD_ADDR because we are in a controlled environment or
>> we don't want to announce a public ADD_ADDR+port on a specific network.
>>
>> Do we have to support that? Maybe safer to restrict actions for now and
>> allow that later if there are needs, no?
>>
>> In other words, I guess we should accept the proposed modifications.
>> Any other points of view? :)
> 
> I think the proposed modifications is not enough.
> 
> If the port is set with non-signal flag (like subflow), we should not only
> stop creating listening socket, but also stop appending this address.
> 
> Since our code can't deal with the ADD_SUBFLOW+port case (like
> "pm_nl_ctl add 10.0.0.1 flag subflow port 1000"). Local address's port will
> re-set as the main socket's port number in our code. So set port to a local
> address is useless, we should add the flag check to avoid this case.

Indeed, that seems to make sense!

Thanks for checking this!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
