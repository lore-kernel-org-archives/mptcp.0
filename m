Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A033624
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 11:12:07 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z19so12716160edx.9
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ag+8VtqnWeYU/Ux7K5glTIzpqi2C6P3sp2mRS5Xq4NY=;
        b=WRuoafZJ+/lzrj05bLjdYLuX8PtkOk0pxpCBAHELVURvlq940+Ici2YxpO2Z5irxOP
         Vs7esDhKCzlWm6VMWdnif8sqPpOqMM7HyOMv2ZfPrL/hqZX6okVDayh38xVVgUJB+SRD
         DdbXDu0mbqyjZcbIjQFICimBvOtGH39nXlJW3m8NSyigxfIfqAGns7pWQsp3P2HZxmWJ
         W1f5bh07y23xRAjdVvFaagT5MtcuGR9NEsIvFrenMj8y4X+4KAtJsfOk1OO5qLPa5M9o
         jH3JeDZIxAvKkRXBL7ty+VidGqH1mTCDPJFnf+CkSHndZ6gJKWwJHAHxKjzYaQChTJE9
         qEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ag+8VtqnWeYU/Ux7K5glTIzpqi2C6P3sp2mRS5Xq4NY=;
        b=nPannhOhbvV5hJcoH/47r2Jjc8MpHyczecetyp98gQtXc+k/YoWMXgVo8v2nZOpvMJ
         vftFNa+ijgGBfldgy6q842N0276oSSoG071+AMGuPWBl+f3WaRyuoc+uFx19WjKmXtmc
         ZjsMWqN74C2876kUGdbmt9qLjTN1W7KsWbGNTkFRNpWr2Zdz8kifI9Mm55QlAM977ZVy
         xOAxDtttxffDadSfZJ+qCs1do1ww6k+1H802r1zkGKtZ579KNrW/eTSWTOBrfxSTzxhJ
         GqeZgimFY5cg0qWmOtPcLsAGVu06XHrgXNrogF27iuQyrpTSPwivaJi9qcAUZ70CAkL9
         JT4Q==
X-Gm-Message-State: AOAM531iA1Ipcc3MRtlFUVuuaVTs+Tfa8a0ZlrJbv+GDYCR3A3nwKfVO
	E8vSWZJyBmB2Z3hN41bmhrg6vA==
X-Google-Smtp-Source: ABdhPJyB0SujaZy43ook7CFCaNHa1FpWZn6MUA6xGSjiBw6qLy1HEkOTVXXBMvI66bYgCgRs9R6cAQ==
X-Received: by 2002:a05:6402:1394:b0:427:e7a5:b8d0 with SMTP id b20-20020a056402139400b00427e7a5b8d0mr3196465edv.9.1652526725970;
        Sat, 14 May 2022 04:12:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e0ff:1350:df1:12f? ([2a02:578:8593:1200:e0ff:1350:df1:12f])
        by smtp.gmail.com with ESMTPSA id s3-20020a50d483000000b0042617ba63d6sm2092650edi.96.2022.05.14.04.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 04:12:05 -0700 (PDT)
Message-ID: <8a68cc98-2b14-a972-77e4-7e7f040d54d4@tessares.net>
Date: Sat, 14 May 2022 13:12:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: test
 bpf_skc_to_mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 10/05/2022 06:23, Geliang Tang wrote:
> Drop bpf_mptcp_helpers.h, squash into bpf_tcp_helpers.h (Andrii)

Just applied (with some delay, sorry) in our tree:

- fea9321e0256: "squashed" in "selftests/bpf: test bpf_skc_to_mptcp_sock"
- fce3bccb2cda: conflict in
t/selftests-bpf-verify-token-of-struct-mptcp_sock
- 9dcaed2c0d9e: conflict in
t/selftests-bpf-verify-ca_name-of-struct-mptcp_sock
- bc1ecc2ce851: conflict in
t/selftests-bpf-verify-first-of-struct-mptcp_sock
- e25640bd2a45: conflict in t/mptcp-add-struct-mptcp_sched_ops
- 5f43144bcb9b: conflict in t/mptcp-add-sched-in-mptcp_sock

ChangeLog have been updated soon.

I'm syncing with the v4 Mat sent yesterday, I will update the "export"
branch just after.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
