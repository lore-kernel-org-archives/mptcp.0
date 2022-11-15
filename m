Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03850AD5B
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 15:29:17 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id l14so24887143wrw.2
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYTQ2ZlVNmzNfCUqv+rErRwERQkehZg6hbr3oIp3J0I=;
        b=rD3bVy6AKOd+OXoZ35aqG8V06AjhrCHbpAhAQ66PyXXjgOEcNB4H6NdK+7JTOijNBK
         SknnbISlcpRthd4BwPc8go5NywRgl4OYQ/LbxDI/OQ2q/BKOI0FaOFZWq5ZjgdKHbJiU
         P4LYGcx+Smwk3ULTl7sVcFFFF1KTnfHiyMxkhJRmmWInt55pgCuv4+Pw02p+ocVtjJO2
         z2WbKpOJigroA5y5I5kQqhlG58NRMQvo1YjKa/8ppuKW1dUBDGODTPi5XlaItl0xpOk8
         h3ToxQ4jWIcC7rRqPA7OJH85ofgbYubKvENtg7JlCA7ugi/3eS6p9BfDBAE0l/MF7/kW
         u92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYTQ2ZlVNmzNfCUqv+rErRwERQkehZg6hbr3oIp3J0I=;
        b=AQGORM/Cwh1ce8MQEjqJyh71Lcbl1hIbwrYQ0jMlpaupSXlsYUZKMN/ic8l7r12YnT
         4m7GHikFMW87GeL02n9+Q3e3uf1EV5JXEHjK33qpTRU3DNdr0prValNj9fiK2rA504ur
         FKqC8fjIqoZ06RPSY5UrAdhD0tC7fU9/WkDwXJd9dXg1tvWVQ6ungZIaT+OQ1OkD4Mgq
         XdzUrDk9Oyg6FWAo/PGFtWs555y41EJ+0bzH8+Ql7YbcgRlZw3c7dRFfJ8Lmyz3qkWIx
         dBeXV7+J+3f1z4gbTr38SuVeE1On0l84qvhph4MDBpWo3LAwFRrH8jvtLdzcZt3sYqiL
         Ee0g==
X-Gm-Message-State: ANoB5pkgOkHVaCe3D2RW1lItfQL+Hkun2hDdhaC1hnJ7QtS8yeD27rpY
	lCP0NWGjWWHR+nYQFBGzH++S2A==
X-Google-Smtp-Source: AA0mqf4ncXBjW/Bk5ogVv8HnUkBVsElEV/ulgypllTYcF7QrlPMB3cqS/FDV8U1bnAG/8RtiI4Yb8g==
X-Received: by 2002:a05:6000:1146:b0:236:6aa1:5f13 with SMTP id d6-20020a056000114600b002366aa15f13mr11219120wrx.305.1668526155831;
        Tue, 15 Nov 2022 07:29:15 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:765b:95ed:f124:a78a? ([2a02:578:8593:1200:765b:95ed:f124:a78a])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm20840267wmi.25.2022.11.15.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:29:15 -0800 (PST)
Message-ID: <3f360267-5490-06b6-fbec-55bd0866e53c@tessares.net>
Date: Tue, 15 Nov 2022 16:29:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
 <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
 <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
 <f79c0855-7458-1e63-49fc-10b3168911b3@tessares.net>
 <d50628e44e6e6f8a6bc3e7150b027193cc3f45c5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d50628e44e6e6f8a6bc3e7150b027193cc3f45c5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 15/11/2022 16:22, Paolo Abeni wrote:
> On Mon, 2022-11-14 at 18:11 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 14/11/2022 18:08, Paolo Abeni wrote:
>>> On Mon, 2022-11-14 at 17:58 +0100, Matthieu Baerts wrote:
>>>> Hello,
>>>>
>>>> On 14/11/2022 17:45, Matthieu Baerts wrote:
>>>>> Just some small quick fixes about "issues" I saw when I applied the patches last
>>>>> week. Nothing important: function names, place in the .h and small checkpatch
>>>>> splats.
>>>>
>>>> An additional thing to do is to update the commit message of the first
>>>> patch of the "TFO listener" series which is currently:
>>>>
>>>>   mptcp: introduce MSG_FASTOPEN flag
>>>>
>>>>   In the following patches we will analyse the MSG_FASTOPEN flag
>>>>   in the mptcp_sendmsg() and invoke the MPTFO.
>>>>
>>>> Maybe by:
>>>>
>>>>   mptcp: add MSG_FASTOPEN sendmsg flag support
>>>>
>>>>   Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") from
>>>>   Paolo Abeni, all the infrastructure is now in place to support this
>>>>   flag.
>>>>
>>>>   The remaining action to do is to allow it and treat it as a fastopen
>>>>   message to be able to access this:
>>>>
>>>>     sendto(sockfd, ..., ..., MSG_FASTOPEN, ..., ...);
>>>>
>>>> What do you think?
>>>
>>> Possibly something a little less verbose? Alike:
>>>
>>> """
>>> mptcp: add MSG_FASTOPEN sendmsg flag support
>>>
>>> Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") all the
>>> infrastructure is now in place to support the MSG_FASTOPEN flag, we
>>> just need to call into the fastopen path in mptcp_sendmsg()
>>> """
>>
>> I know you would prefer a version without your name :-)
>>
>> Sure, it is good to me!
>>
>> Is it OK for you if I do the modifications and apply the 5 other small
>> patches? (no hurry :) )
> 
> [browsers!]

We told you not to use IE6 anymore...

> Sure, please go ahead. I have a couple of additional
> fastopen follow-ups pending...

Thanks! I can apply now not to block you :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
