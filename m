Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367212C83
	for <mptcp@lists.linux.dev>; Tue,  9 Nov 2021 14:55:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id v11so75390383edc.9
        for <mptcp@lists.linux.dev>; Tue, 09 Nov 2021 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lEHjIaIheLNYQvnpEpKIS3RrfQwVwNg7wjfxiHe3bTc=;
        b=yIz1XuAEeJOE/OT4zNTp3LEflWUyqCf+q8G6kmfzh1Wi4PUSMLgMaqD98HeaIdbh0x
         ohWQySkU9BqdNwMN7AKHf7rZyOpgVugf63tQGpeSZZio684iJ3AqEaVCVRvMO9fx7+Ry
         RliMGkxWE2U/mgcJuYsk3x+v/uVW4prHVVF9DWdNYGRL5yIuMq3dUWvkTerswRk8s51f
         kAxBHDmpxkcGrx1a/dcSsSrlVpCF21zGZ138qwEHvFI6iK5OM9FJEI4wiVsMyDXdMG8F
         jpXwy/XcNJFx0djqWpRKR32p4gh/fX3Y169OWFx77uo1+1WsItdPrggNRyuEWlW2H7CU
         iAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lEHjIaIheLNYQvnpEpKIS3RrfQwVwNg7wjfxiHe3bTc=;
        b=dOKsyXanPOFrqwbdiU2KgC5qIN9suPg8TId2Sl6VCxkKSmpohrdiwwwAAdawE1zjvm
         q68x7x3+/5q6egDY5kVSotf5KmT7SPuJzTFKjoOSO656RQ0XIFmjhrocYBP70N9SYsDy
         p5ChzgjqX0mKoL56qcIW6Fpgs3YcLSxYWib3UIG9IEVu8mOjlBKft+dHb5tNGQhVhRo/
         uAAdANKA3Y/oQ+QevaiwpYEl2rPLH6hOKiiQL+EN1Vn55GnOcbZcNh10F0NBHRM5MtqF
         hg6uadzINC957fxB9MfkTLVN6VzI9BnM7cy9gTJri9pq7dtKlafTTu3ZzWPblkAbTyWZ
         8rnQ==
X-Gm-Message-State: AOAM533uRISiz+qBBh/mVDLM9kqUxasXCccnCAEoQlb5koPgUtQMWPC+
	7T8iRoHmoViCqYzPU7tIg385Cg==
X-Google-Smtp-Source: ABdhPJz44TOZRNbxNjLIPH6KH9KOpxkSgyhyyeamxTPjrIQsZwStwEyjkwWjIOZkBUeoJFaDqMssqw==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr10482166ejc.234.1636469733249;
        Tue, 09 Nov 2021 06:55:33 -0800 (PST)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id n16sm11203934edv.79.2021.11.09.06.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 06:55:33 -0800 (PST)
Message-ID: <bd8a8d70-337b-e196-dbb8-c434030e15d0@tessares.net>
Date: Tue, 9 Nov 2021 15:55:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH 1/3] mptcp: never allow the PM to close a listener
 subflow
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1636107361.git.pabeni@redhat.com>
 <f9e8db7159b3e0db8dc5b642abdfa9019ada435b.1636107361.git.pabeni@redhat.com>
 <340eb5be-4fa9-5cd3-1224-3e37e4d538ae@tessares.net>
 <baf882f708dc67063449424e2319a0c74a1b86b5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <baf882f708dc67063449424e2319a0c74a1b86b5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2021 15:38, Paolo Abeni wrote:
> On Mon, 2021-11-08 at 17:56 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 05/11/2021 11:49, Paolo Abeni wrote:
>>> Currently, when deleting an endpoint the netlink PM treverses
>>> all the local MPTCP sockets, regardless of their status.
>>>
>>> If an MPTCP listener socket is bound to the IP matching the
>>> delete endpoint, the listener TCP socket will be closed.
>>> That is unexpected, the PM should only affect data subflows.
>>>
>>> Fix the issue explicitly skipping MPTCP socket in TCP_LISTEN
>>> status.
>>
>> Good catch!
>>
>> Should we add a "Fixes" tag and have this backported in stable versions?
> 
> We need this patch to be in the same series of the following two - or
> at least to enter the tree before the others. I did not had the Fixes
> tag to allow this patch to target the -net-next tree as the following
> ones.

Can we not add the Fixes tag and send it to net-next?
Or we already send this one to -net while net-next is closed?

> BTW I'm working to add self-tests here (mptcp_connect based [!!!]). It

I thought only Florian was allowed to modify mptcp_connect! :-O

> looks like tha a good disconnect() implementation should use FASTCLOSE
> to shutdown the MPTCP-level connection, so I'm going to add the tx part
> of it, too.

Good idea, thank you!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
