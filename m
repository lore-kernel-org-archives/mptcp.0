Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9464B
	for <mptcp@lists.linux.dev>; Sun, 30 Jul 2023 05:25:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so38837525e9.3
        for <mptcp@lists.linux.dev>; Sat, 29 Jul 2023 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690694740; x=1691299540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXNK/EQar0frRk6SYW9ezkHLXX0HftC5+siXcD1RFk8=;
        b=dNhPFVYLXtj4+5Z8REfsBhkEREhe0/6WVVlciARg5TMGUqutKrdA12thyYACyexq8F
         hqbvYQhdKVljJPgzaUJi9NF5P3RYuF3FDUhHcP/yBMdMYMszuaIK4jMnhgiasfyIFuCU
         IdBvp5jGbU7xU5FmOtinWgqPZi9uAkTVM2QL3XXHScfppPEQxlXLRBGmmFG/DNfBKQ1h
         ghe2grcitv0/S6mdm9Mhvu+CiwKDXg3dotqNsX+zycM+OB7viYQlU6x71QKfMKJi36S/
         quE0uG+0NcBHfi634z9L0iA6vaUF0/hzz9GNf+/bSuxZfdHxFU2JckTnh0ZBl+YFqMp4
         pB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690694740; x=1691299540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXNK/EQar0frRk6SYW9ezkHLXX0HftC5+siXcD1RFk8=;
        b=jCo9nuZu1fnNOsFpfquKc5/pZ8MSBGpwzNibxtFv11LXhnqDk2l58jdqwNbyJKBUk5
         3FLgZyy/LIJ7VA6YabdcSiyksrOabvftThMuw1EAgND4D5xitkOwxG9nNUzPv3wKJx1+
         rvQyBvbPF1Ale96rABGxUJml2LNTzxVWx8IVq9lQPrUJbVzfuKMbhI36hOCHTHnpceoK
         wzhwYB7mA1JGKGydF/j+auUiWQ6/L9FSEWIB6BppKF3PFsUG1tTabXwGxKpN6roAHVUs
         XB5yruJ0qrTGs7ru986TKeOKh5HMsrZlUqKh2/BBCzboXCwH3v3Xv3nyyv6eRw2RY1Ej
         gD/A==
X-Gm-Message-State: ABy/qLZSZ9v7AXpXl5sWmKrAgbj3dBlqSi1tsk9MKPFiEsclm6gfbTH0
	zpVv94x/QrLK7GjwhtsJRv6XdcRUUocYBh0sfoA=
X-Google-Smtp-Source: APBJJlFMBXmQGj/kdkjrHSDQA/sfffNqZNBlVIZjckehbAfkjJv442/Gvg5c66dLv4eq2xecGBz+gw==
X-Received: by 2002:a05:600c:2241:b0:3fb:b5cb:1130 with SMTP id a1-20020a05600c224100b003fbb5cb1130mr5240067wmm.34.1690694740340;
        Sat, 29 Jul 2023 22:25:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:63a2:72a8:825e:46a? ([2a02:578:8593:1200:63a2:72a8:825e:46a])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c114f00b003fbb5506e54sm7909532wmz.29.2023.07.29.22.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 22:25:39 -0700 (PDT)
Message-ID: <3286321e-ca7e-949e-ad0b-8f5afc63c009@tessares.net>
Date: Sun, 30 Jul 2023 07:25:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: pm_nl_ctl: always
 look for errors"
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
 <a473db82-70fa-7c50-478d-095b197f577c@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a473db82-70fa-7c50-478d-095b197f577c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 28/07/2023 20:24, Mat Martineau wrote:
> On Fri, 28 Jul 2023, Matthieu Baerts wrote:
> 
>> mptcp_join.sh selftest tries to add a bad endpoint on purpose ("ID
>> change is prevented") so it is normal to see this error:
>>
>>   114 implicit EP
>>         creation                            [ ok ]
>>         mptcp_info subflows=1:1             [ ok ]
>>         mptcp_info add_addr=1:1             [ ok ]
>>   netlink error -22 (Invalid argument)
>>   ./pm_nl_ctl: bailing out due to netlink error[s]
>>         ID change is prevented              [ ok ]
>>         modif is allowed                    [ ok ]
>>
>> We can mute the output because we expect an error.
>>
>> We also need to edit the commit message to mention mptcp_join.sh
>> selftest also need to be modified, not just pm_netlink.sh.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    to be squashed in "selftests: mptcp: pm_nl_ctl: always look for
>> errors"
>>
> 
> Also fine with me to squash this one, thanks for tidying up the
> confusing output.

Thank you for the quick reviews!

Now in our tree:

New patches for t/upstream:
- c59d81165162: "squashed" in "selftests: mptcp: join: colored results"
- 005f14102f2f: "squashed" in "selftests: mptcp: pm_nl_ctl: always look
for errors"
- Results: dac913f8eca8..ba5729b64e7a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230730T052252

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
