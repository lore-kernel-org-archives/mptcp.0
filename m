Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637ED2F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 13:22:40 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id ch26so4947727edb.12
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=taEOoNwu9QdW7Uvi5uXPwuwx9LXo69jma0mtcPMn1UA=;
        b=3LjzXtgjGZ9zsew9LWv5hzS0emdyhX4UqPMZoWUIv5p36cR802WBTobZuap5xKW7ae
         wx20D99FD2bhOWQ1DgaPW3+LonOTqT2XbIk3e/4PWmllx4J0NgYU996HbOv1YbQ0x11M
         ga8CgIG8cx2FxfmI1kAW/Adlm3eO5Ulyt3elQeqkfPaqkoFAvd/s5EGI9NpaPmjNEVdP
         Nab8HJwxzn9Hu6xeXLk0UzdGLQ7WdUIon+2Xdbg2r1UgU53F2SyOLroxphMcTNW1tovg
         rAZimIXIk07T7dw/XR5oUONaoGhH6dlD6exhCX1Ug+SFg5lycNK4IeNAagMdmi0usOqt
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=taEOoNwu9QdW7Uvi5uXPwuwx9LXo69jma0mtcPMn1UA=;
        b=DW8Bc6T1SHeosmfSTB/dvipeNub52k+EoIP1/G7crtyOuaZ7/2RE4C9o+Ew8hlWpqV
         Fy1xbN7QtEeC0E3Y9uIBIH/42iJl0qQ/8JwYT+jLvmOxI7VrCGolRxtJPnnbQETfYJ3H
         PF9w6Zg6CZzuqqOEnRayo5KAZRKsoXEDBXJDTECs1+tJUAf4RvYF3SZCWxtJQ7D1v/Pd
         rOS/dKclMK2zMiY+xCnRYmSBt9m7t23sMSSh8ugAJ+SN3eYLRWuJZ+qFG4VdZ4OgaUu5
         wTRWFLCthrT/1tCRwLBL8KX2LQehIzFlBWVijE2jlxTsKLFPOpfbs5WS3jdMDb1B0TjH
         hSIg==
X-Gm-Message-State: AOAM531YpiDidPGgI8ZIsqel6ZZWQMaJPekfG5PQmmj72GbM2non/B15
	fhD7kgwMoOn9brA6g0sKvnSUApqP0mrXuA==
X-Google-Smtp-Source: ABdhPJyGe3cCSReWxhWPdJ7tgxtfAoHu0Owbzhotl27i7ugQMJ3LF71QekNy4gMGqQrS6gq+YTD1mw==
X-Received: by 2002:a05:6402:368f:: with SMTP id ej15mr2557171edb.84.1644412958439;
        Wed, 09 Feb 2022 05:22:38 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:67e2:9861:88d7:accc? ([2a02:578:8593:1200:67e2:9861:88d7:accc])
        by smtp.gmail.com with ESMTPSA id pj9sm4113340ejb.124.2022.02.09.05.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:22:38 -0800 (PST)
Message-ID: <6b68c023-67b2-e574-cbc3-39363d8463f0@tessares.net>
Date: Wed, 9 Feb 2022 14:22:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v3 0/4] mptcp: fix races in add_addr handling
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1644399915.git.pabeni@redhat.com>
 <617b4fa8-320b-2e88-ee68-0a25e842ee21@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <617b4fa8-320b-2e88-ee68-0a25e842ee21@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2022 10:59, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 09/02/2022 10:47, Paolo Abeni wrote:
>> the patches 1 && 2 fix actual races, even if the race addressed by
>> 2/4 is not exposed by the self-tests, afaics.
>>
>> patch 3 introduces some mibs to detect critical scenarios we can't
>> fix without major rework
>>
>> patch 4 updates the self-test to be graceful in above cases.
> 
> Thank you for the new version!
> 
> I suggest to apply it now to have more feedback from the CIs. We can
> always end Squash-to patches later if needed.

Just applied in our tree (fixes for -net) with my RvB tags (+ Closes,
Reported/Tested and Fixes on the patch 4/4),
s/AddAddrDropped/AddAddrDrop/ for the MIB item without two small issues
reported by CheckPatch ("(foo*)" should be "(foo *)"):

- 83013c9c30e5: mptcp: fix race in overlapping signal events
- 6a9d5a9d5ec0: mptcp: fix race in incoming ADD_ADDR option processing
- 31a634cf1d69: mptcp: add mibs counter for ignored incoming options
- be58c0804397: selftests: mptcp: more robust signal race test
- 94af849fb4a6: tg: fix wrong merge resolution
- Results: 3484d41ff4f2..be63b701c373

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220209T132143
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
