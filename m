Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0852102
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 13:06:29 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id r11so35922758edd.5
        for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679922388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBRzSjF1ItIhFkB/xfzfFNBgliDQkj3K2tL0x/5xLLA=;
        b=JwHQ5CYDRZgnqIABG/vIRSL/jAk6QRm9Ebi1hd8dh6gsxeEtqS4/fNF3/nuK7dv2N2
         C++uIegHeA6s3eTPmJ8a8MzVHXjS7rfZeROG9dxb5N8U3M+dqTP+gQKVbqEIYn4wAI5y
         uIHv78JsTM90s+XP8FAz7yyYcmJjIBps8CdNdpfWzBY4VUFnuc8vGX6F8OlG0gMaCSAK
         mAeBcIRaXARtMzmwonZhHcGSqauZhRaBZdDFuzsUV8cIBrgqzNToy8KhOz54/YZtyKev
         FXlT3YWbKnVP34us4nth/s6kuNa762qNOJv2WXyoOqLsTL8PdTecUgCqJxlUs+pC6wek
         MzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBRzSjF1ItIhFkB/xfzfFNBgliDQkj3K2tL0x/5xLLA=;
        b=m2MQjHcmel5wdZR0LYT/bTzrGf6nNZUnbcjlw2B98lUV8ciKoeGT8FkFXxpONZIQ0S
         Rb8XFWrUHHIpQGxtSA8Y/zE90zad8bO4JO28fFDnBEjHBqMdcFKgePGeLn6j8iaIAWXp
         E5DY2CZ3ivqOEXb5S7b7/LYnK6lCd8JDdzAAeBrAyJKAG8CrHWE/+oRUdmFL3nxZ97vG
         qDsr396qn2KFwl4THkn21HpbaJIJtPQEZZUKwVjkrgDXR21EjbV0rMp7aQjOBNSgOtOa
         qjqnPU5xGYXQKCRn3qDzQZX/uEiBqnA/6PUVWKT1Tqa0KAtkOhMsyBpnjLzV87+7ufv9
         rtkQ==
X-Gm-Message-State: AAQBX9cOqwNQVNpUHF9xwxNwlBubtpOqB+RH2xjM4d7L5V/97cuw1cXJ
	nWUAPxYKsRVlMn1nE/kRmsurJA==
X-Google-Smtp-Source: AKy350aubl4IeRos5yxV+0Tm1DFsUgWeynjATke5ZllIc+r07irJ1p6DoXT2tO0X3ANifJBSe5VRxA==
X-Received: by 2002:a17:907:9626:b0:8a9:e031:c4ae with SMTP id gb38-20020a170907962600b008a9e031c4aemr14908672ejc.2.1679922387777;
        Mon, 27 Mar 2023 06:06:27 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm14066107ejq.3.2023.03.27.06.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:06:27 -0700 (PDT)
Message-ID: <bf7546ab-6c76-05b0-4539-f4aa854ffae9@tessares.net>
Date: Mon, 27 Mar 2023 15:06:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] checkpatch: allow Closes tags with links
Content-Language: en-GB
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet
 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
 <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2f96048b-c580-625f-6fc7-06237292efe3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 25/03/2023 07:25, Thorsten Leemhuis wrote:
> On 24.03.23 19:52, Matthieu Baerts wrote:
>> As a follow-up of the previous patch modifying the documentation to
>> allow using the "Closes:" tag, checkpatch.pl is updated accordingly.
>>
>> checkpatch.pl now mentions the "Closes:" tag between brackets to express
>> the fact it should be used only if it makes sense.
>>
>> While at it, checkpatch.pl will not complain if the "Closes" tag is used
>> with a "long" line, similar to what is done with the "Link" tag.
>>
>> [...]
>>  
>> -# check if Reported-by: is followed by a Link:
>> +# check if Reported-by: is followed by a Link: (or Closes:) tag
> 
> Small detail: why the parenthesis here? Why no simply "check if
> Reported-by: is followed by a either Link: or Closes: tag". Same below...
> 
>>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>>  				if (!defined $lines[$linenr]) {
>>  					WARN("BAD_REPORTED_BY_LINK",
>> -					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>> -				} elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
>> +					     "Reported-by: should be immediately followed by Link: (or Closes:) to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> 
> ...here, where users actually get to see this and might wonder why it's
> written like that, without getting any answer.

I tried to explain that in the cover-letter but maybe I should add an
additional comment in the code: checkpatch.pl now mentions the "Closes:"
tag between parenthesis to express the fact it should be used only if it
makes sense. I didn't find any other short ways to express that but I'm
open to suggestions.

Now as discussed on patch 1/2, if the "Closes:" tag can be used with any
public link, we should definitively remove the parenthesis here and
probably below (see "Check for odd tags before a URI/URL") as well.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
