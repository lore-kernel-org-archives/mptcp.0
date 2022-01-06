Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C22C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 10:08:41 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id j21so7444866edt.9
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 02:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ObYZXNg7bCl45NaDWyvkDmyn2uzPLnpfKlOsqWX4Yls=;
        b=IDwnwS6PIgVGpWEtSXD/Z6uftAtrz78CYuQjHYgS25cG9pg8uLpyQ3Cy0lxtIVDC4S
         BRPCHTceqQGmiuP6ayMB3eAt2FAuDOjY+KCEvdEZuz+RN3Tboa8MfRYePvdyL8KHhkEJ
         ToXCm4RxFWG+7brJ3jbhpQX3wBUjwrWj1aNd7BnCHfOF67ox+clQ8B3ATWdyUqjbsg5/
         EZUh8cBxLyCOAKOXiQn5P4cfHUGZAKPsEK0FHCEyl1tZPAq6y99TI1RZ8cd1ROL5oHdo
         diAdYkIoDBOJKWvkqFFAS5wFjy489wbPtrAKykcI2aiM6paj1qJNCldf/R8DbQULqPTy
         Iaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ObYZXNg7bCl45NaDWyvkDmyn2uzPLnpfKlOsqWX4Yls=;
        b=0pc4o+dvifvRfOyApoobkGvHKj9K/u6k2nOkat7YzO1kQgm4luYehezgR7+/NO+LSy
         cdoQpwnfoB3K55hK+2mIK/ktoQHfkovSAia2gRcLgo/+7MEhQ/K8BlVr5VH3URKfAr89
         itswThfP18z+ZdufF0aExjJV3t86y0AOmHv8/JZq7++34pWQuKM3aZJX/B0l+yetr7/4
         ZlX0BrZ3NFfVWcW5OixqdIKSBxvAD0o5wKZob8q8cwMUNo/fwG7/2GVG7NupASeGxcyF
         jej38weXLZ5y+S4gCv+wQFxvVosqUQp6HOoG2IX4onhXPKMz03H9HW7vVJYO7BsTD1g0
         Y4zQ==
X-Gm-Message-State: AOAM531kFiC6iakqPC6lGCxinHoMDtiRjboCioHtm0okufHX4MMlKUQe
	RmUqSv+LRb77FOnZ3tCMKanT355jx1yNFYQu5ow=
X-Google-Smtp-Source: ABdhPJzSqtYdx+/T+aUQGNQPm5vWM4mTuXtZcQLDJxwDqbalKvvaZIDtHsEejtDX94iuFmdPHLEwcw==
X-Received: by 2002:a17:907:1117:: with SMTP id qu23mr46916733ejb.404.1641463720239;
        Thu, 06 Jan 2022 02:08:40 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f806:b935:3199:df74? ([2a02:578:8593:1200:f806:b935:3199:df74])
        by smtp.gmail.com with ESMTPSA id gb10sm378934ejc.49.2022.01.06.02.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 02:08:40 -0800 (PST)
Message-ID: <a67a1f81-1c5c-addc-945c-381b9f10ed85@tessares.net>
Date: Thu, 6 Jan 2022 11:08:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Upstreaming to net-next
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
 <20220106021759.GA3858@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220106021759.GA3858@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/01/2022 03:17, Geliang Tang wrote:
> On Wed, Jan 05, 2022 at 05:54:12PM -0800, Mat Martineau wrote:
>>
>> As Matthieu noted in today's meeting, we need to figure out what goes
>> upstream to netdev this week:
>>
>> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
>>
>>> Patches to send to netdev:
>>>    - net:
>>>        - probably best to send:
>>>            - mptcp: fix opt size when sending DSS + MP_FAIL
>>>            - mptcp: fix a DSS option writing error → but we might need
>>> to change
>>>        - But if they are accepted after the last PR from Net maintainer
>>> to Linus would delay stuff.
>>
>> I noticed that Jakub sent a "Networking for 5.16-final" pull request to
>> Linus today, so the 5.16 ship has sailed.
>>
>>>        - So if we don't want to rush to look at the tests, we can also
>>> send to net-next for the future -net (to be check which tree is merged
>>> in which one first?
>>
>> The next pull requests from Jakub to Linus will be from net-next, so that's
>> the fastest route to Linus' tree for fixes that will be added to the stable
>> tree.
>>
>>
>>>
>>>    - net-next:
>>>        - patches from Paolo could go there, fixing issues, see GH
>>> issues/250:
>>>            - *@Paolo*: OK for you?
>>>
>>>        - + checksum fixes probably
>>>
>>>        - best to skip MP_FAIL series for now as we don't have a stable
>>> selftest yet
>>>
>>>        - and no need to send Mat's series as it is linked to new
>>> features in the Netlink PM part, not ready yet
>>
>> Here are the commits that look ready (commit ids from
>> export/20220105T054758):
>>
>> Paolo:
>>
>> 9f6720406819 mptcp: keep snd_una updated for fallback socket
>> 95bc19b21e00 mptcp: implement fastclose xmit path
> 
> Hi Mat,
> 
> There's a squash-to patch for this commit in the ML, ([mptcp-next,
> v8,1/8] Squash to "mptcp: implement fastclose xmit path"). It works
> on my test and looks good to me.
> 
> Could we squash it to "mptcp: implement fastclose xmit path", then
> send them together to net-next if this squash-to patch looks good
> to you too? Or could we send this commit to net-next in the next
> turn next week?

Yes sorry, I forgot to write that in my notes but the idea is to first
apply the Squash-to patch once it has been reviewed by Mat and then send
Paolo's series.

But to have more validation done, I think it would be good if today I
apply the 3 first patches of the series I sent yesterday: Squash-to
patch + 2 fixes. These 3 patches would go in our next batch of patches
to netdev. We can still fix them with squash-to patch later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
