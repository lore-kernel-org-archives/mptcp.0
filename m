Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C770
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 14:57:27 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id h24so27225057ejy.2
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stt06LN99QsLOOyg/h5W5Fx43+OrjpwiZKyL7R1N8ts=;
        b=AjNJ4XjVwuWcOaDuxQn5xZo9G40hr1VSAKGcrwoH/BOT7uBBygp50HUjnPIaxIICEE
         Z3LGefLO1z/FG+98V2jaxxMobGLJXaBGTsbW8J/dMiOB9l1MA6sM+yS6QNB44TNXAO2W
         3VFR+P3Mt4/EXoAtsjW93mmoZqsrRG5u9hAx7JSS+itnp2dT8i5NKQFFsN4aQjzt471W
         7Biz1fkWJ6riFw/8Ki+Oz3PHXEsZafjX+qh2Rhwjn6qw9HsF2vo68U2Iu27aNkaABhRa
         gEoNvarKnLLbe3cYH2gFnZk+GqR8+8aNGj1gviqMkwqrHfux+4ywarez0/U2LuVbypIr
         jo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stt06LN99QsLOOyg/h5W5Fx43+OrjpwiZKyL7R1N8ts=;
        b=jOpnWOuPu+JYmdL4TWfZlZF0QtdDsQr1vw72ndaBKY8D+CjFTkIXbpBk9dPX9nwC9e
         NqTEyZNe1w2D/kttsjCJhmesvohU0JIxNFiZ8tQpy3boUxkKZ6gV+KIJUxvl8bTXepMf
         YsoPfp3zmRNmZH8JkP1mYpMRXIh0RkQFm0LP1wNFt25iaF78JdnWJKY87gGJpSzJomYQ
         Y5v1d57SFovVLWMNkLFajkVmmk7Uz+uKapXiHMnztbtuD0CuOP971BUejYf+SvGAWRgn
         HpGMeN0MnjHT6umq3lTzG7PKlAKvmiMd00mdbdWz1kUzrwiq0lUkp3mbuN4x5+ZsT9yM
         MkCg==
X-Gm-Message-State: AOAM533vVN+Hnx6Q5DN10ialpfaWM622ZzijZL29svYIt6OSDaBiISOt
	lA6m4+sJy7sQ0hzfZVhYixfN0P7Diyj5nPqy
X-Google-Smtp-Source: ABdhPJylHsB1fD7N9PrYen1PWpalHXoRXBOgeIr7BaafJOFRLoVbySTUr5QtMbmjWFBm9STsAnYu/g==
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr18181616ejj.478.1623077846314;
        Mon, 07 Jun 2021 07:57:26 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b57e:3c04:9ae7:cda2])
        by smtp.gmail.com with ESMTPSA id c19sm7740950edw.10.2021.06.07.07.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 07:57:25 -0700 (PDT)
Subject: Re: [PATCH] Squash-to: "mptcp: wake-up readers only for in sequence
 data"
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <8c07c4b90aac3f1d3bdd64c5ba8f5c83372005a1.1623074917.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <7d6fdeb1-6155-6481-70f8-ab1115317c5d@tessares.net>
Date: Mon, 7 Jun 2021 16:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8c07c4b90aac3f1d3bdd64c5ba8f5c83372005a1.1623074917.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 07/06/2021 16:08, Paolo Abeni wrote:
> We need to flip the DATA_READY bit under the mptcp_data_lock()
> (or before acquiring it, as the old code did), or the BH could
> end-up flipping the bit after that the user-space already
> flushed the just-appended data.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch!

@Mat: I hope you don't mind if I already apply it to fix issues/201 and
apply other patches!

- b2427404975d: "squashed" in "mptcp: wake-up readers only for in
sequence data"
- Results: 3c5535f65726..e5d80c7af352

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T145646
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T145646

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
