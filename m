Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98963A0
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 17:34:42 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so3895552wms.0
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1xU3D7bdWJ8UrzLOwDwVbT0ePwRQ1+5TIY1p+z1RCg=;
        b=ony6MC3Iixz8SXAKw4p2LSjPDbpjq9pa6phMdNU2gXKsCCNO3trjcDxvX7Xhn/hwIl
         gLUh37WonbRaFnPOa74/wdqfOO8X/NnztHjG0oV8VuNk42oJhqIYhtkTKoJfXBaB6ues
         5NZNM5ofSEK87WEIhROtDJgyg/TlP9A6xqnwVCw6APKKLRR2LXnc/RCLLH1MMqryaI4q
         cFHxHE49F8tOkcRFCDK2kAmG0TyFekq2ZO2J+iXMFIQUGYHAp+Y6LOt338dx+flxv2n0
         UzFDnqp3UGdbqi7SP3L04OcNXlTLl8uBKUDtjyRPBz7OlFyxm3ahtmd0ljD/IYWKojVR
         MJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1xU3D7bdWJ8UrzLOwDwVbT0ePwRQ1+5TIY1p+z1RCg=;
        b=Z18saqmT1x0TT/T9I2qCq+oYU3FCDAxxd0DNCh5SPKOrP3f+OGNneI5OHzYYGVBQrb
         VIxwFyhe+dlOapcwmr+NkY53hgRjHqU6iqiPuDZFC8ms0qVCbcHkxb0XkSKJccxZS6uq
         XWoMJjG/v19mTJSylNkM/u1mzyQ7yNOlrOz1XxZsUGViFNxpTZ44/c2tTm+f0nAfj8UN
         ZIdHyVeco19h64IEfVKJPBE1SCx0fmD6QETuKzzRZP1SuyS3VknXkol25mMpZmox6DGo
         H60Es9DMAF44/kihhoIQyxyny1CyXs11XZf0ANNw3hjGl8wxZxf1BvUyKHxibT+7ozPU
         MwDA==
X-Gm-Message-State: ACrzQf39bvYv0C8sQzyRqIjq6aot4xQf5t1FA1c3GFR9O7zse5RCosnO
	zhqOWAdsFnaFVyG15lxz6IunxQ==
X-Google-Smtp-Source: AMsMyM5HUJJcRvSbzhumesVS02pndQ5H9Q4VTPwub1JFvY7VtfeEeN5V8E4+hSLKOWz3OYgglfN7NA==
X-Received: by 2002:a05:600c:5109:b0:3cf:5fd2:877f with SMTP id o9-20020a05600c510900b003cf5fd2877fmr20474977wms.156.1667496880822;
        Thu, 03 Nov 2022 10:34:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003b4a68645e9sm519256wmq.34.2022.11.03.10.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:34:40 -0700 (PDT)
Message-ID: <e0768153-ee97-f0f6-4b17-49ee02a4d3f0@tessares.net>
Date: Thu, 3 Nov 2022 18:34:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests Results
Content-Language: en-GB
To: Menglong Dong <imagedong@tencent.com>
References: <20221103110649.299284-5-imagedong@tencent.com>
 <20c04c0d-8110-535b-0ce9-65eca5bda725@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20c04c0d-8110-535b-0ce9-65eca5bda725@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Menglong,

Thank you for the v6!

It looks like the CI is not happy with it:

On 03/11/2022 14:21, MPTCP CI wrote:
> Hi Menglong,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal:
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/4909154062565376
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4909154062565376/summary/summary.txt
> 
> - KVM Validation: debug:
>   - Unstable: 1 failed test(s): selftest_diag 🔴:
>   - Task: https://cirrus-ci.com/task/6035053969408000
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6035053969408000/summary/summary.txt

As you can see:

----------------------------
(...)
# all listen sockets                                [  ok  ]
# after MPC handshake                               [  ok  ]
# ....chk remote_key                                [  ok  ]
# ....chk no fallback                               [  ok  ]
# chk 2 msk in use                                  [  ok  ]
# chk 0 msk in use after flush                      [  ok  ]
# check fallback                                    [  ok  ]
# many msk socket present                           [ fail ] timeout
while expecting 200 max 201 last 1
# chk many msk in use                               [ fail ] expected
200 found 0
# chk 0 msk in use after flush                      [  ok  ]
----------------------------

I guess one socket is still present after the 'check fallback': you
probably need to modify flush_pids() to wait for the processes to be
over, as suggested on a comment in your v5, no?

https://lore.kernel.org/all/b3f3c01e-4010-d5ce-970d-394711bcd0e1@tessares.net/

I don't think it is a good idea to wait for >= 200 except if it takes a
very long time to have the previous socket terminated. If it does, maybe
we should re-order the test or re-create the netns instead of re-using it.


About the patch 3/4, note that the SIGUSR1 is probably stopping the test
earlier than expected because the interrupt will cause some actions to
stop but still good to check for the 'quit' variable.


Also, one small detail for patch 4/4: can you add "...." at the
beginning of the new lines you print in the selftest, similar to
"....chk no fallback"?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
