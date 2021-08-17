Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36922FB0
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 16:44:33 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id g21so18587677edw.4
        for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YE3xQf5LSkGYbpGWU2LM05zCI4Qr2hErU5WdHy2R3Nk=;
        b=e07caVYT6K9lQwG3r6eLIKcKw3OchPsBsDTqMY3ikdGcZ8YDgBAsNdlaMdNKV5mOC5
         B2kjPMjx4kTrAyIHn/inHgy3O+dMqm1i3cJSvYXPLLD/7hUItRgazA35ZVVSfGIYYwsl
         esmIwfdsjxwbXNaWcjCXpPbrs1JmBmgeNob4Yd3LPpXM74IyiNbboqzuPCwQMIKdMk80
         LXTXfAvXIk9YxjnDSOcfEpmZi3yb3eV+EcBKA+FJxqdy3eINep8n3wpAL/KMv/HVu21A
         7WJJo4KClDO4NcgD7O3gEM90Ikye/o2kJDYVBPPNfUXCmLbfy73icnX7ocyxvC1pGb/y
         doWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YE3xQf5LSkGYbpGWU2LM05zCI4Qr2hErU5WdHy2R3Nk=;
        b=eJdb03+9Gn6gewwjE8fYlAQi9J1fGNHgWUntwv9GakhdLqNyuGPj+ED/+hDZtl0rue
         whN8Lm/cxDnMVWFAzJ4zA/5o5jKf0jhAbYvnVj3+gLuBYKhmLPU5xuDNAbleUuNfm+xQ
         QyDhtRcswtfokPu8jhvZ8Kadk6I1UBQuLGQm3W93V3c1eiuCYji3LoQdJbgLDo10AMWO
         lUx2q6ugzzJwJ7HXJ1uEJjmvzjoDlUpEe7C4hfRIS7L1MQTM57qLvXwXJo+IrYjWwoT6
         XKB6hqCR/tgM3Bhx45Me+4EkiopXsAGKs6J+IEQz1XkvHxovhzHjY9mdh3hraZpPXc4X
         GkDQ==
X-Gm-Message-State: AOAM531hQn1G53g6YVKl2CZMinEnaXpbSWlm+1xvbahgm846l8fqvG2l
	ArMms2kF7CmpgLbC50sKcQK24RnaB5alNJtbJes=
X-Google-Smtp-Source: ABdhPJwdsR0shL/sJ5z2rz1GmTj4WQTuDkjT806PTDdpnNtRPB33eWYiLB8iOP/u5izoCoO4Qf6wEg==
X-Received: by 2002:a50:fc96:: with SMTP id f22mr5180690edq.367.1629218671551;
        Tue, 17 Aug 2021 09:44:31 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id lb12sm974852ejc.28.2021.08.17.09.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:44:31 -0700 (PDT)
Subject: Re: [PATCH mptcp-next v3] mptcp: full fully established support after
 ADD_ADDR
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20210817151838.3187999-1-matthieu.baerts@tessares.net>
 <708f39c-6066-f93b-f151-f6ed8a2ba0cb@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <4692bf57-70be-e6d2-e4e2-c187ed30fcf7@tessares.net>
Date: Tue, 17 Aug 2021 18:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <708f39c-6066-f93b-f151-f6ed8a2ba0cb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 17/08/2021 18:39, Mat Martineau wrote:
> On Tue, 17 Aug 2021, Matthieu Baerts wrote:
> 
>> If directly after an MP_CAPABLE 3WHS, the client receives an ADD_ADDR
>> with HMAC from the server, it is enough to switch to a "fully
>> established" mode because it has received more MPTCP options.
>>
>> It was then OK to enable the "fully_established" flag on the MPTCP
>> socket. Still, best to check if the ADD_ADDR looks valid by looking if
>> it contains an HMAC (no 'echo' bit). If an ADD_ADDR echo is received
>> while we are not in "fully established" mode, it is strange and then
>> we should not switch to this mode now.
>>
>> But that is not enough. On one hand, the path-manager has be notified
>> the state has changed. On the other hand, the "fully_established" flag
>> on the subflow socket should be turned on as well not to re-send the
>> MP_CAPABLE 3rd ACK content with the next ACK.
>>
>> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    - v2: reword the commit message not to mention "valid" content (Mat)
>>    - v3: squash the two patches together and update the commit message
>> (Mat)
> 
> Thanks for squashing! Still ok to tag:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (fix for net) with your RvB tag:

- 3c39f1cc7dcb: mptcp: full fully established support after ADD_ADDR
- Results: b2f0470e318c..0c5e0eca2d62

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210817T164404
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210817T164404

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
