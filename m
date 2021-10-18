Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771B72
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:31:17 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id w14so70300420edv.11
        for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=1zikJ67AffK4SYsZW9OboFhYXV1A4alMFFJ+ADpbFWg=;
        b=KaSYHYMgjFcByCKjDs5VCySNTF+wQf+pa55x1ilTWYEWMn0T9l2oSTwZH1GzzobsLI
         FyTxveR6pVqWCvS9GToCkMSOMhEMlMn2HzMvhXesUfGauXQJNsosUkWGPOlpin3RH8gS
         E3A2tcCMHyk/jR6fvCytnBrkAtAw1KQOq/ImYtv/TZfqqPgt7B93vAzf4Ef++P0pAQa7
         1hlDkUXGnVw5lbe8D0wBTXkiMb3jdile2MZC6pJJKbKAZBRn7rCrcxoX5D9VvopheSUb
         jMJYasAB+/MpyjcIhV701P+47/o4mOjkmhtoTnjf/yffBFYRX6LZxFUzFXvZGP/s+n07
         ZH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=1zikJ67AffK4SYsZW9OboFhYXV1A4alMFFJ+ADpbFWg=;
        b=Mv/46onDJP2doD9U7xRT/TLuqN/HMar9HTAmnB8JM4y+yAHlR2TfGjzHuxHYO8rgLE
         0Zh+iHDcCuE1hzfdwgeph2RIwDCu/s6Y6uAaM68B1TAACnniFDFIx81XDSCoHU4p/rU6
         ss8CZWCrGPDqbTQ6A3g341c1aszf4Oq+TghQU/Txe6//mK4y6011Bg4fSs7IZMq10Eld
         D3cJwh0Ow1XVb+0iqkGXtXGsz8QY7Hcd6+l5JOpNslvElVI7m447EX66Di/9x3x+URvN
         Z6fyFC2dAd/BRZRJ0XSVsGXjSw7hByxzhar/0BQkrLnrkrjPOCqo47e5scNEMECu/pVu
         YWKQ==
X-Gm-Message-State: AOAM533tpQC5Y7k3MoOI43Z4Drh0j509jaSFVjs6FKXIrend1jsRX0Sk
	MQBmAYYDA8c++G3z15CLmyLywg==
X-Google-Smtp-Source: ABdhPJxi46f/SYj75Yt3Yy/2kDF39As10dAkLdcZClZbh3H1iEZR56oj+GzQvw9OKPF/w9eXY4PesQ==
X-Received: by 2002:a17:906:c005:: with SMTP id e5mr28616751ejz.480.1634560259333;
        Mon, 18 Oct 2021 05:30:59 -0700 (PDT)
Received: from [10.120.18.87] ([84.17.46.26])
        by smtp.gmail.com with ESMTPSA id g7sm857795edk.13.2021.10.18.05.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:30:59 -0700 (PDT)
Message-ID: <9ae482b2-90e1-8e4c-7b98-9de3072bd242@tessares.net>
Date: Mon, 18 Oct 2021 14:30:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
 <1fe3d619-370f-d5bb-6d6f-af6890f9fc43@tessares.net>
In-Reply-To: <1fe3d619-370f-d5bb-6d6f-af6890f9fc43@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2021 12:24, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> 
> On 16/10/2021 02:12, Mat Martineau wrote:
>> On Fri, 15 Oct 2021, Paolo Abeni wrote:
>>
>>> Currently the simult_flows.sh self-tests are not very
>>> stables, expecially when running on slow VM.
>>>
>>> The tests mesures runtime for transfers on multiple subflows
>>> and check that the time is nearby the theoretical maximum.
>>>
>>> The current test infra introduces a bit of jitter in test
>>> runtime, due to multiple explicit delays. Additionally the
>>> runtime is measured by the shell script wrapper. On slow
>>> VM, the script overhead is measurable and subject to relevant
>>> jitter.
>>>
>>> One solution to make the test more stable would be adding more
>>> slack to the expected time; that could possibly hide reall
>>> regressions. Instead move the measurement inside the command
>>> doint the transfer, and drop most unneeded sleep.
> 
> Thank you for looking at that!
> 
> It is indeed more stable: with a debug kernel and a "slow host", the
> test fails almost all the time. Now I got 3 failures in X attempts, not
> bad! (and I stopped after the last failure)

And X=18 here ;-)

And for a maybe better output for the tests results from my previous email:

https://paste.centos.org/view/d75b3836

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
