Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B173
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 12:51:02 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id oz7so8234823ejc.2
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3a2NHy+M3szyumRFwwuL3EZC/LpuDkPdX+AztTPVHI0=;
        b=wY4gBEDuL0DrBlZ37wGHltyUYk9zX6CB4ePFv/lqHcAq4HJkPYKIx9ZkcJrT3MWKbM
         JeUToYjvCjOsa9pqk7YXRSJHUiWCDO/GuVmbuYtaYBFa9Mbo4Zwo4Obrb2Rks/jq2Y9i
         dVqMUU8XkIj7eLT5HC5tm6eVQc1nWxFs4F6Z/udyl+lxdRx9/itaBduS02K1LIJkdCvF
         AyzfBi/EmkdDGdthc1awMU747CcJxQuX6+hfxCZtslqIK1srqudHH4+OwLZjDtlIldJR
         qwdRbW5KPGjc1B2xNBTWU1V1J7za0gugMq88li4UW9h85Hh3jeZMmJCR7TZ1ia7aJv4L
         PiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3a2NHy+M3szyumRFwwuL3EZC/LpuDkPdX+AztTPVHI0=;
        b=rVn8Kd3XOgoEvCSAqvYxk6dQsuBOSZq1jH3NnV+qB5SBP5Oo657ocV+VUKmwrn+ePW
         c6P6kAiumvPCbvmp53N1Syx+5d3AEeziXNmUgl99kQIn3yDGsktiR56z/ldnvl80i7UU
         M+kht4V3X4FOvz3QTY1m1oDwUkd7LX0th2D7R5rO4blDAENV5kTCkJw5Zrry4u9RsbjJ
         M08oOePwH53ijIb5J+Et/vYh+2WNdOH5Ns2DgTnTP6AMp4/n9gKO483eKMJPMbp9xGy3
         gQVx1OCnF7ks2qIRFSvgZJjYp64zaP6rRyZ5li1hHzdN/AHpNKWrIaKGyg9ZQ62TzLMz
         TnbQ==
X-Gm-Message-State: AOAM531pZbme/wuwvifeMKQ3PSP10tyK9pgXGE94qgdAqIeQ2zIyBLLh
	/N4zlutzorShBcNFNsfoJ67n+9DVTQCChGEmMB0=
X-Google-Smtp-Source: ABdhPJzMIxg12xVTCN5l0icjSbXL9beHwyS/dAeb0DQf2Hvrc+xcI5cVis1a2PLrGP7tQLcX8qUZ2A==
X-Received: by 2002:a17:906:a2da:: with SMTP id by26mr44129177ejb.232.1626958260411;
        Thu, 22 Jul 2021 05:51:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id l10sm931578edr.33.2021.07.22.05.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 05:51:00 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
 <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
 <CA+WQbwt1_O9btFtCLo+hw2JpeaX3EXtMR8scVrDW+YPtCAmgpQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 testcase for active-back"
Message-ID: <b2accdd2-367e-47df-fc20-6c44a03b4c5a@tessares.net>
Date: Thu, 22 Jul 2021 14:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwt1_O9btFtCLo+hw2JpeaX3EXtMR8scVrDW+YPtCAmgpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 22/07/2021 11:28, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年7月22日周四 下午4:55写道：
>> 05 backup flow used, bidi, link failure:
>>      syn        [ ok ]
>>      synack     [ ok ]
>>      ack        [ ok ]
>>      add        [ ok ]
>>      echo       [ ok ]
>>      stale      [ ok ]
>>      link usage [ ok ]
>> 06 (...)
>>
> 
> I think the original display is much better than one item per line. Since
> it put the related items in one line, and do the different tests in each
> line. I think that's more clearer than one item per line. Do you agree?

If everything was on one line, ideally with one global result at the
end, that would be fine for me. But here, when you have a long list of
tests with multiple '[ ok ]' on the same line but in different columns,
it is "hard" to spot the errors I think.

Here you can see the output when it fails:

https://api.cirrus-ci.com/v1/artifact/task/5542024628666368/tap_result/selftest_mptcp_join.tap

There are three columns and I think it is not "direct" to spot where is
the error.

If you have: plenty of "[ ok ]" with nothing after, it is easy to spot a
"[FAIL]", especially if something more is written on the right of it I
think.

An alternative would be to have one global "[ OK ]", e.g.

  03 backup subflow unused, link failure:  [ OK ]
  04 backup flow used, multi links fail:   [FAIL]
       syn        [ ok ]
       synack     [ ok ]
       ack        [ ok ]
       add        [ ok ]
       echo       [FAIL] # extra info
       stale      [ ok ]
       link usage [ ok ]
  05 backup flow used, bidi, link failure: [ OK ]

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
