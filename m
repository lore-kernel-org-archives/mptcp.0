Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF97A
	for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 20:19:07 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id b11so5666692eju.10
        for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2dNNm+2Z7DDTrnInVJhwVhx6QVDRUW2xps/sEbVOHiU=;
        b=Dwui2oCyaMCi3tSvwOpjfJZZGOdnlgOydmP1frvpBNLn1BUL+tcGUAax1agMvlcYsy
         WUnVjcydaCNS2c83Y/M8M9fEQ0Dt/vN+P73bxohbthMchvleQX+gARGjXCQ0DPshKc+1
         1Idou1dB1cCjuH6ciMb6E3eETHHFU+dp/zFOGgSIcpU4SyTmIgdke91A1zteEP58u+EU
         jE7frmfd6Tu97whiyPZAF5l0z0/mMCor34Z30cn9bluePt2Yiz8BhkLugKMvuB/qvprN
         4v2y+6A/Li1tt9gc6GiTGggYzrjXs/Q7nANLT4zKc+MRApKm6fGZil+sGy4AWIkw5cKt
         1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2dNNm+2Z7DDTrnInVJhwVhx6QVDRUW2xps/sEbVOHiU=;
        b=FUCX9WoPXp4vdpWkBYdnkrSpU1B7OanA4XHjbnX60r/IZSOv9qZXDNZc8e8L2sZiNq
         xqRhQX5lujeRSK2sKJGMX37QErzGEkru9whWI+XQn3OdSdcA6vSq+6a15hnGHPfEn+lg
         dNci80YliceCQn34Eo0ZnkqY3wRN+GfIB1qKwJ24FaSNqyJiqn1O36GJlrf/TIffl9AH
         +24IRfb8OaKZ9qWAhp25sf1zZEncMIM9CoO6Vx344wcZsQkFq/nwUCgoDzptr6KJ65Vn
         YPHQ06ktxbyJDcd4mb3EfFXBjfbTbHl5unYDNn9+dmo89EmsETYGSWMBKL4cIX4bS6Ag
         0ITg==
X-Gm-Message-State: AJIora/LNf8Al0qE7kJoPJoKRtSsL4rUqp9boy2q96HxZyWX4Bj2bOT2
	VRgyK9pxaYz3lbjqhfNuK7HmFA==
X-Google-Smtp-Source: AGRyM1sN+yMDd9eMlY/wC+lb+z5dP2YfafkBCnRXR4CiepxY34tTWOLWn1G0hHHRtHX0158SS/jnSQ==
X-Received: by 2002:a17:906:9bdd:b0:72b:3cab:eade with SMTP id de29-20020a1709069bdd00b0072b3cabeademr7647876ejc.58.1657484345371;
        Sun, 10 Jul 2022 13:19:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8f5b:bf6f:385:d647? ([2a02:578:8593:1200:8f5b:bf6f:385:d647])
        by smtp.gmail.com with ESMTPSA id f8-20020a50fc88000000b0043a8286a18csm3230479edq.30.2022.07.10.13.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 13:19:04 -0700 (PDT)
Message-ID: <428689f2-ad91-e1b4-64c5-c1c4802e2cbe@tessares.net>
Date: Sun, 10 Jul 2022 22:19:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield'
 warnings
Content-Language: en-GB
To: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
 <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yonghong,

Thank you for the review!

On 10/07/2022 18:59, Yonghong Song wrote:> On 7/10/22 1:35 AM, Matthieu
Baerts wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 81b19669efba..2ac424641cc3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
>>   };
>>     struct bpf_loop_inline_state {
>> -    int initialized:1; /* set to true upon first entry */
>> -    int fit_for_inline:1; /* true if callback function is the same
>> -                   * at each call and flags are always zero
>> -                   */
>> +    bool initialized; /* set to true upon first entry */
>> +    bool fit_for_inline; /* true if callback function is the same
>> +                  * at each call and flags are always zero
>> +                  */
> 
> I think changing 'int' to 'unsigned' is a better alternative for
> potentially adding more bitfields in the future. This is also a pattern
> for many other kernel data structures.

There was room, I was not sure if it would be OK but I saw 'bool' were
often used in structures from this bpf_verifier.h file.

I can of course switch to an unsigned one. I would have picked 'u8' when
looking at the structures around but any preferences from you?
'unsigned', 'unsigned int', 'u8', 'u32'?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
