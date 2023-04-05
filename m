Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BF2C9A
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 13:45:36 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id i9so36278341wrp.3
        for <mptcp@lists.linux.dev>; Wed, 05 Apr 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680702334;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYAM7DjJWyENJQLBwVjX/MBbgkuzu69Qr/P5hOVvVRs=;
        b=FRigls0aF17qw2RGg4hyxeLYe8GA/22Gwom2okIxkcc7mTCTIkTcu7sbS1U7sQfT3H
         /hzZcKKIS7bFHW1QkUJ8GnKLnZsSCaWR1gjdUNC9BD/MEgi192Nj6UBCvi77tuEVqbWb
         EWgEW2genUgWVBji6flPyAnCCh31uZpaozt+lfH7tzEWqPbt5Muv+ljwZwH2+Nd3lXuz
         oIM8l60SRA23AzX9FdjghlUn+9wUgPQZDOYHvc+YNEPaNuCLnChXSWg1Jh9H4zVX9rNS
         Ao/MJo6eB35mYlqEmRn006Kq6UjWr3IU6HiFFO07W28oMybhzo827qqj8RP9pd4tRRJE
         amEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702334;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYAM7DjJWyENJQLBwVjX/MBbgkuzu69Qr/P5hOVvVRs=;
        b=jGPyICGfhbzrPNT8H4WTB3AmsA4zaxDUNsScduAwnJKZV16JX9+FFfHeyU2fRjEjgD
         aQczsRc3U/g53L88x5CYIhjse2JPgxEeHMz8epCCplPXtoV/ppnZhf2svooGUYoFKHlV
         u0+/iRgUjAgk/lYlzqJGtd5Hty6NqzOpRw4IhQIsxTpf5gYM8YVeHlWg8Eu60h1XK3FL
         7B/ydeKAj/++V94lUoKrP+IcI8I0WEEfaQtwD0H6rOvy6eldWqCxrlESSCwLuw4SA3uW
         LS0hYyqgjtXlrb5sWgpM/kvpx+dbdkxM3zZaweAboaEscssBBx08ULKPIPZ3CbfzwrHF
         NiZQ==
X-Gm-Message-State: AAQBX9e8gWcyILBaaC+fXeySkPEORHGlN1omfMjKdSt6v6ec3lhj0MPT
	BLtG1q959KAqNbhz6SZyKsQl0w==
X-Google-Smtp-Source: AKy350bonY8oo+1frjbGmcu5ZLut6nx388TQnqPfP6KRuGASotEmAUvoKnyEqVzHZUBJ6T9MKoGYEA==
X-Received: by 2002:adf:f0c4:0:b0:2ce:aa2f:55ff with SMTP id x4-20020adff0c4000000b002ceaa2f55ffmr3954148wro.1.1680702334284;
        Wed, 05 Apr 2023 06:45:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f67e:9347:5b88:82e5? ([2a02:578:8593:1200:f67e:9347:5b88:82e5])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b002de9a0b0a20sm15007842wrx.113.2023.04.05.06.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:45:33 -0700 (PDT)
Message-ID: <31bf5bec-6c85-287d-0a84-d528b1b5ea8b@tessares.net>
Date: Wed, 5 Apr 2023 15:45:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net] selftests: mptcp: userspace pm: uniform verify
 events
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
 <ba55d265f400227a15331e9cf26112de111a3e74.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ba55d265f400227a15331e9cf26112de111a3e74.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/04/2023 15:59, Paolo Abeni wrote:
> On Tue, 2023-03-28 at 19:05 +0200, Matthieu Baerts wrote:
>> Simply adding a "sleep" before checking something is usually not a good
>> idea because the time that has been picked can not be enough or too
>> much. The best is to wait for events with a timeout.
>>
>> In this selftest, 'sleep 0.5' is used more than 40 times. It is always
>> used before calling a 'verify_*' function except for this
>> verify_listener_events which has been added later.
>>
>> At the end, using all these 'sleep 0.5' seems to work: the slow CIs
>> don't complain so far. Also because it doesn't take too much time, we
>> can just add two more 'sleep 0.5' to uniform what is done before calling
>> a 'verify_*' function. For the same reasons, we can also delay a bigger
>> refactoring to replace all these 'sleep 0.5' by functions waiting for
>> events instead of waiting for a fix time and hope for the best.

(...)

> LGTM!
> 
> (no need for a forma acked-by tag imho here due to the already present
> tag)

Thank you for this review!

Now in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- 8ce0e99c6ffe: selftests: mptcp: userspace pm: uniform verify events
- Results: 522e529cc873..43c38b337813 (export-net)
- Results: 8fbf51a0d18f..16abaebe8405 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230405T134336
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230405T134336

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
