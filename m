Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D034168
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 09:29:37 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id dp20so7417002ejc.7
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T9g1KngiAoaFh8Tq/T5PK/ZImxAJp2PRyiZIl2m0jfs=;
        b=ZnNDPcjQmYLrzbTqCubdp9sXqz+LyYbbETqppx/LqkUdNLh6GHCEyFeNMsNoQxBDfg
         BxeUAEtzDa65fGihdQ3CIS6Y1nTzBzf3rasGs/WsZYcIWI31qVimk0ERW/R5+deii7u/
         soz/YI939/O4ZBw/ubfxCp4pzHn540eNw7Y66rKojXIyeOBdxnzvmw8+8ft19gWwPhvM
         blyHm+ZMkdBPZWNOOQyxyeAbaAexrOXiJSktbT9mTOLLY84Ut8B2dOM4YFr3yRTmyglx
         MQGZ/RcPXXKiXgaUF+vy4AbsdgC43bHq/LwmDs54rfjmgPtvaoXLt8TAOnCxEAi16vVC
         J7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T9g1KngiAoaFh8Tq/T5PK/ZImxAJp2PRyiZIl2m0jfs=;
        b=LBEIArN2jbxjLuKlhiNbWN50XoMwaPupb5UzxB4dG2VdK2it89z3JkZCY7fR+ljJ0c
         MALJtr7fcwjN74ZHvHEP0WGLj+93rErk3dQqMUCgWcEjTzdUi/ED5Le+/qTags55fBHV
         ZpuDoG7OgZsgTl0xY5Dm9g9vQb6LwfUEn2G/cAw1RYSQe36eCmfJNTk2o7kNtJq9KPy2
         Wr20tOqU1yXfqxjLgiLOUTddoxc8tBE+fz8KxcVvBorOCkXDcL8YZ5SQg9BEP8ReMT/M
         XSvkq70IMPKFXPdedcKpDxo3cFZpGrxoDkEGNIi1cQWeXUlo0CCvjcIUAbliC7ga+xEa
         Pwvw==
X-Gm-Message-State: AOAM53147VeI8K0mci1Bbn5pBZmq20ZodUOuglb5Wm0uT20YhR6RWGdT
	QXKTVOhGdO4WYwE/gfjPlP/AIJ1flUsl+zb0HWE=
X-Google-Smtp-Source: ABdhPJxUTSbC8brhvLnV0f/N5yS1DmO3oaItQ9JfH6BRp9xZvEe2qfykA5UJtTG7tlD0gfCZv65Rkg==
X-Received: by 2002:a17:906:7302:: with SMTP id di2mr42107571ejc.409.1626946176179;
        Thu, 22 Jul 2021 02:29:36 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id k14sm12053841edq.79.2021.07.22.02.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:29:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliangtang@gmail.com>
References: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
 <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 testcase for active-back"
Message-ID: <5669e803-5f28-c100-082a-1e5b0ee049e7@tessares.net>
Date: Thu, 22 Jul 2021 11:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 22/07/2021 10:55, Matthieu Baerts wrote:
> On 21/07/2021 10:56, Geliang Tang wrote:
>> Drop the debug logs and make the output aligned:

(...)

>> @@ -878,7 +877,7 @@ chk_link_usage()
>>  	local tx_rate=$((tx_link * 100 / $tx_total))
>>  	local tolerance=5
>>  
>> -	printf "%-39s %s" " " "link usage "
>> +	printf "%-39s %s" " " "link usage        "
> 
> Do you mind if I change this when applying the patch to avoid plenty of
> spaces?

Thank you for the patch! Just applied with this additional small
modification.

- bef6bd8eb873: "squashed" in "selftests: mptcp: add testcase for
active-back"
- 8135e0128562: "Signed-off-by" + "Co-developed-by"
- 85c4567fba08: selftests: mptcp join: avoid multiple spaces
- Results: 3a1215522891..1180d21b724d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210722T092910
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210722T092910

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
