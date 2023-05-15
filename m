Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9BD2F3
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 15:46:56 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9659443fb56so2031836466b.2
        for <mptcp@lists.linux.dev>; Mon, 15 May 2023 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684165615; x=1686757615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiZFyVT9Ti3WjrUpXfg9wiw3EjDs9sJH6PQhnTZhp6A=;
        b=mSqn4RasNkTB6WkVIEmkepPqObt1xDfGzwgAnEj+u66f7418rkBf4+SbAK44nMAoxA
         qC8TlRN1JqNGqevI4GKPi2PHxzyOBltyWcQ0JMEJ1/6mBz5SUBd7XTDaE8JV+bOxspcP
         wh9ZdR1pFcQazn8ul9LJSxwOSJEVfgUU3b7H/Qg2dT3On1faHmpG7GYA+T84kT/ma/lu
         dbk50URi/dYI5tzAP9CkWtZ8WNI8AVt2IF5IlDBMs3ZqxngO2S4Qy/6+ctS9jfzP0OSn
         bO0bEC7Wgpms0IF5etccWUdpNRpyjIOewOS2sXBEry7jKvThuDBuPz+Tosh07kjaGQQm
         re9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165615; x=1686757615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiZFyVT9Ti3WjrUpXfg9wiw3EjDs9sJH6PQhnTZhp6A=;
        b=Jsk+Fdwqaive1Z242PQeIKtfPH7AHr/8Am0diZ52Z5IUwk3xcZo3rMuCl8IZkoFVpS
         0Xpg6elegTpYj33SOIhdHYPyeJiUt+ByF59mnO/4tbgfUt9QmKZGg34qxmoy4Z5OXvtr
         8gijmD74zmH3yMnbzskr/UwM+l+ktBcGwJq7KDBEzkF96lOZCb7kdIhGFT//lNEanMc3
         MQHBT/7fnS9w3ZYjRkLYdG3qzVROcO7kgUPhuMUEOR6/Tb4SnS11E4q9Po2UmfQhd7B5
         Ims2J9KGhQKUZu1Gjl7cVLfOrZS/LUj+pYFXu9HWJybUFuMeIVKtc1pVBsHpEKq5ckD/
         zuPQ==
X-Gm-Message-State: AC+VfDwMkceVaMKasNVT/Bwb7QuskEXi0BcmktlO29enrj9CUXPV9Owu
	+GGcKFqCZhwtQ4nPP/KNtvLnXg==
X-Google-Smtp-Source: ACHHUZ4BvR/7nnc6VAX3/d6l5VuI6tunnF/2X2YQwrBR9z6Ez8zfs5lJb/jaaKX4s2kyZRgnKBB5pQ==
X-Received: by 2002:a17:907:98d:b0:94e:cf72:8147 with SMTP id bf13-20020a170907098d00b0094ecf728147mr32662799ejc.48.1684165614668;
        Mon, 15 May 2023 08:46:54 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b0096637a19dccsm9713297ejb.210.2023.05.15.08.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:46:54 -0700 (PDT)
Message-ID: <3ec2e3f8-9a38-1d71-8546-5d464b7c82e9@tessares.net>
Date: Mon, 15 May 2023 17:46:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
 <5ba7d292-7128-fc9c-aa13-96c938bb881a@kernel.org>
 <4c81894956d1ce7fda70200f8de50b3420e5c7e5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4c81894956d1ce7fda70200f8de50b3420e5c7e5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/05/2023 10:16, Paolo Abeni wrote:
> On Fri, 2023-05-12 at 12:24 -0700, Mat Martineau wrote:
>> On Fri, 5 May 2023, Paolo Abeni wrote:
>>
>>> Ondrej reported a functional issue WRT timeout handling on connect
>>> with a nice reproducer.
>>>
>>> The problem is that the current mptcp connect waits for both the
>>> MPTCP socket level timeout, and the first subflow socket timeout.
>>> The latter is not influenced/touched by the exposed setsockopt().
>>>
>>> Overall the above makes the SO_SNDTIMEO a no-op on connect.
>>>
>>> Since mptcp_connect is invoked via inet_stream_connect and the
>>> latter properly handle the MPTCP level timeout, we can address the
>>> issue making the nested subflow level connect always unblocking.
>>>
>>> This also allow simplifying a bit the code, dropping an ugly hack
>>> to handle the fastopen and custom proto_ops connect.
>>>
>>> The issues predates the blamed commit below, but the current resolution
>>> requires the infrastructure introduced there.
>>>
>>> Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> Note: there is needed follow-up correctly propagating the SYN_SENT
>>> -> CLOSE state transition from the first subflow to the msk socket in
>>> case of connect error, but that is somewhat independed/pre-existent.
>>>
>>> Sending out early for testing.
>>
>> Hi Paolo -
>>
>> Patch LGTM, and appreciate the cleanup of msk->connect_flags:
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>
>> I think it would be good to also add a selftest in net-next to check the 
>> connect timeout (set to a very short time), but that doesn't need to block 
>> this -net change.
> 
> Agreed. Perhaps a pktdrill script would could be simpler option?!?

Good idea, that seems more appropriated, especially with the timeout part.

Just to avoid deadlocks: is there someone working on that? :)

But as Mat said, this is not blocking, I can apply the patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
