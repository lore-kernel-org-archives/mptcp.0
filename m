Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235523BC
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 10:16:17 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id w9so87633046edc.3
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680257776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLyeL0ieC0af03HsrJcBtZcl6Qcrr61FaS5vG8SSolU=;
        b=n7VgHm1iogUci/YDlLwqbiCQxOh0NTv+S+qLJr9YmfYegjQWmoHTp0Cklpblqu5bsJ
         iaGtyYJwJwKuULk5G/jHZB7UgH1yEM2IrW9H5dQjSUwWnbvuAHA/kFU3q2NS5lPpzqRa
         YVmS8BLqjrTpztRer9bqdMiB35T4WfhCrR/o8wi0Lk7b4c+q7aPRgmpZQ5YYJkje8+Ev
         GlmyLmlrq65oTOn6ecRqiyzSQXlnwgiAVeCpy4yeEpvLO5iWElYQqyq+v54qBcF67eBP
         D5U8sCdHoyM9THhL3t5k6uu9kAidFR1UbuMVrrsfGZP7T8hXIayuCJMC4LRxGnCc6m1j
         V7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLyeL0ieC0af03HsrJcBtZcl6Qcrr61FaS5vG8SSolU=;
        b=1yvCa0rwd89XPsN95Ap3gQ5gKgjf68SKZhQGqFAap459QXMEz1um187JEwmQFcRE+J
         8KsNyT+Ao9sE9XBJTErBKSTBguBt1j6uPskkp27dMcds+kNlO9SI7iX6XnCDjI7lQnGH
         HqnCavE5S919aAp1fGvWZxypShoZCmu9GDZhCEJGKohRG7EbIuQ53GabkoD39khOKN6R
         sScix0Xr2i6IeiHZDx1LeDnUgkdcvNI9uh2VYkJLZkhIVBt+rvVj9gfN4JCK9skhbI7Q
         GzHa2A81MwF1bQZ3aex8n+nEY7mAGFEnYkAEUdfCy0rGEr70LIQUg453TQk4wwcD/abf
         zbRA==
X-Gm-Message-State: AAQBX9eNTKAB4u1Mwo4+I2kPERzm0CcDfPmtPpqMU87F0DUAvgSTJ8HX
	TdDyI6wkaPJ+U5/6InLYP34cPg==
X-Google-Smtp-Source: AKy350YAcljW2beX0LP4ISmGtSCex+RPEa9az+T1vDHR7XPjPdnVyvT8Ksk0/Xf2hk7fPOwqHBpGIg==
X-Received: by 2002:a17:906:44b:b0:931:624b:680c with SMTP id e11-20020a170906044b00b00931624b680cmr26590099eja.29.1680257775893;
        Fri, 31 Mar 2023 03:16:15 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b0093f0fbebfc2sm817144eje.144.2023.03.31.03.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:16:15 -0700 (PDT)
Message-ID: <2370614d-6d9a-9f35-63a3-cfdcca2dd0c2@tessares.net>
Date: Fri, 31 Mar 2023 12:16:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] checkpatch: check for misuse of the link tags
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
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
 <c2d5cc07-ec95-eb64-0cef-42f8378ea054@leemhuis.info>
 <ac473b8f-e7c1-edf9-9d9c-f1fd726e1e17@tessares.net>
 <d5c9d3fa-7f73-1179-8055-b31568ae2228@leemhuis.info>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d5c9d3fa-7f73-1179-8055-b31568ae2228@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 31/03/2023 12:09, Thorsten Leemhuis wrote:
> 
> 
> On 31.03.23 11:44, Matthieu Baerts wrote:
>> Hi Thorsten,
>>
>> On 31/03/2023 10:57, Thorsten Leemhuis wrote:
>>> On 30.03.23 20:13, Matthieu Baerts wrote:
>>>> "Link:" and "Closes:" tags have to be used with public URLs.
>>>>
>>>> It is difficult to make sure the link is public but at least we can
>>>> verify the tag is followed by 'http(s):'.
>>>>
>>>> With that, we avoid such a tag that is not allowed [1]:
>>>>
>>>>   Closes: <number>
>>>>
>>>> Link: https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/ [1]
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> [...]
>>>> +# Check for misuse of the link tags
>>>> +		if ($in_commit_log &&
>>>> +		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
>>>> +			my $tag = $1;
>>>> +			my $value = $2;
>>>> +			if ($tag =~ /^$link_tags_search$/ && $value !~ /^https?:/) {
>>>> +				WARN("COMMIT_LOG_WRONG_LINK",
>>>> +				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
>>>> +			}
>>>> +		}
>>>> +
>>>
>>> I must be missing something here, but it looks to me like this is
>>> checked twice now. See this line in patch2 (which is changed there, but
>>> the check itself remains):
>>>
>>>> } elsif ($rawlines[$linenr] !~ m{^link:\s*https?://}i) {
>>
>> If I'm not mistaken, we had the following checks:
>>
>> - after Reported-by, there is a link tag (Link:|Closes:)
>>
>> - (link tags can take more than 75 chars)
>> - tags followed by "http(s)://" are restricted to link ones
>>
>> Then not: link tags (Link:|Closes:) are followed by "http(s):".
> 
> Not in general, afaics -- and ensuring that is likely wise, so thx for
> this. But for Link: and Closes: tags after a Reported-by it is already
> checked, that's what I meant (and didn't communicate well, sorry). It's
> just a detail, but might be wise to do this in patch 4:
> 
> - } elsif ($rawlines[$linenr] !~ m{^$link_tags_search\s*https?://}i) {
> + } elsif ($rawlines[$linenr] !~ m{^$link_tags_search}i) {
> 
> (that's a line changed in patch2)

OK thank you. Sorry I didn't get that. Indeed, it should be enough to
just check for the tags, not for the "http(s)://" part.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
