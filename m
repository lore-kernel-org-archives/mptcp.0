Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200246AF
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:37:37 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id cy6so45731edb.5
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf+FrfNVK1RXpxhKLruw4BtIT6MaYe7v3Gj4OR/8sP4=;
        b=C5hRi2tl+9L+yXEuqrL8qV4yYFHvg401eiKXCMBQZZC9l/ZBEfs6rXDx6ZVmJhMtM7
         hMolzrdwupgmG08SutLoGRa5KswES5xmHjkTqvLDmDC9PAJL96M3/c0ezbbw+gizFUO9
         5C0BtKGw5XVNbNsnd3hjyf9eofhHInU+u3MqRAN3o7lYgo36M4CNtlqwVHlborXYV6k8
         BF89h1jUyZJiJcBecogI2nCx+EwB5SrT86kNN5IMIBizTgQCNJl6prq2FLuzqpG+REb2
         4odu0AUDdYMQ+Xc544xec3eY6hgMawQKWW4eD8yC5XydSSLA+Kn8gZGleoFHkWF1EA4s
         hv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf+FrfNVK1RXpxhKLruw4BtIT6MaYe7v3Gj4OR/8sP4=;
        b=TV8QqyTTTbQ39/mAyOcNXEYG0xb5kVIFa+gR09M1ahxG1XJuf6nDe8sn0ZDNWqL/NM
         26xVSROM0MLIGWYc4KnawvRV/AjJWomd3VjG9UM794Q2r7mMRbOH4L70mMfG8Ku026lr
         PUBsF1kC1NVwfqHrL+Z/4o1f6sR508NtySh3t2wmM7cCCTYgXGfLh5B7hJeJ8++ck1NI
         jfFp70I6wGG0rZY5hN87tjff0RgDNKUwtYCnxwXZo0MTcC4d0iZsU0Ex+MarO/KJU6yL
         aR43Z3vfxNuOonLnPXc6/vDyytT8DCxjt20ePjMDkGVCI/0F/ULcCkM+2wdASOpl7EBe
         Kxcg==
X-Gm-Message-State: AO0yUKVVN/INF1IH3rKjNp4AUpFZOtiw1aVvWemRjaeJhsJK9/c1ALyQ
	PkiIBzbKCosyM8krRUcqNPdjJg==
X-Google-Smtp-Source: AK7set+KBrGbzcSgcOIDVIoxY9LI9R1st+YrGmGF0ZfXWmG9pdannaFLquTHWqDxu2hMQOU84/8ddA==
X-Received: by 2002:a17:906:e285:b0:8b1:15ab:f4cd with SMTP id gg5-20020a170906e28500b008b115abf4cdmr9606110ejb.53.1676903855945;
        Mon, 20 Feb 2023 06:37:35 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id u23-20020a50d517000000b004acdf09027esm1102955edi.4.2023.02.20.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:37:35 -0800 (PST)
Message-ID: <25431862-52d4-0868-a60a-719c079b662f@tessares.net>
Date: Mon, 20 Feb 2023 15:37:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
 <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
 <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
 <531ceec4b5af0abe463e80a19d98752ed1074aad.camel@redhat.com>
 <4cef3e6b-ad2b-0757-098d-14f09692f68e@tessares.net>
 <a00e24a4f9cc571980c0f8aee6c4f9aa68ed0cdc.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a00e24a4f9cc571980c0f8aee6c4f9aa68ed0cdc.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2023 15:30, Paolo Abeni wrote:
> On Mon, 2023-02-20 at 15:05 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> Thank you for your reply.
>>
>> On 20/02/2023 12:51, Paolo Abeni wrote:
>>> On Mon, 2023-02-20 at 12:14 +0100, Matthieu Baerts wrote:
>>>> Hi Paolo,
>>>>
>>>> On 17/02/2023 18:58, Matthieu Baerts wrote:
>>>>> Hi Paolo,
>>>>>
>>>>> On 09/02/2023 19:48, Paolo Abeni wrote:
>>>>>> As reported by Christoph, the mptcp listener shutdown path is prone
>>>>>> to an UaF issue.
>>>>>
>>>>> Again, thank you for the two patches!
>>>>>
>>>>> Now in our tree (fixes for -net) with my RvB tag.
>>>>>
>>>>> I had a few conflicts when applying them on -net (and later when
>>>>> propagating them to our tree, see below), I hope that's OK but don't
>>>>> hesitate to double check if you have the opportunity :)
>>>>
>>>> I probably didn't resolve the conflicts properly (or maybe some
>>>> adaptations are needed on -net) because this introduce some regressions
>>>> on export-net (not on net-next):
>>>>
>>>> Any idea what could cause that?
>>>>
>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/361
>>>
>>> I *think* it's not a conflict resolution issue; patch 1/2 here
>>> functionally depends on ("mptcp: refactor passive socket
>>> initialization") which let msk take a reference on unaccepted MPC
>>> subflows, so that incoming reset will not free such subflow via
>>> inet_child_forget().
>>>
>>> I *think* the easier solution is moving this patches on export-next
>>> after ("mptcp: refactor passive socket initialization"), mentioned
>>> explicitly the functional dependency
>> Indeed, it makes sense. I just did that.
>>
>> I removed the Fixes tags and mentioned it was linked to the refactor of
>> the passive socket initialization: is it OK? :)
> 
> I *think* we want to preserve the Fixes tag, to help stable team. We
> can send fix to net-next in case like this. 

It is not clear to me if this bug is visible without the patches that
are currently in our export branch. If yes, we can keep the Fixes but we
need to mark that it depends on the refactor not to confuse the stable team.

@Christoph: do you mind checking if you can reproduce the two issues
#346 and #347 on net or net-next? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
