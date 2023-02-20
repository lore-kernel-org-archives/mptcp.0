Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED463BB
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 14:05:35 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id x10so4312848edd.13
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1da5Mmv+lVSfrDW97v/PmXpj1+WQtwPjTFXxSLpd/34=;
        b=se3yYivU8Wj9KOD395YXTgnPGXWvPJ2XBJ8xZqL4l5FGChAbWe/eOBWPBJUnLWZ4Wj
         AKH843jtB5lBexZ5OlakrT4pUQwFYn8wZhp4u/8nSDp3A8tXQOYLT6riYyYb9icWJZcU
         kffNGrXvm4+wM2yRY4Ky9pkbp6kWA4f9yLhWgjFkG0A+m0JMT133xQw2vwU9UVj5Gcaa
         5gC7BXNbSgnTTiZ3XfwWy6hgQumtsjjdKE+DRrFg0Fm9l7o5dIZFMKXOZ0vlnjvkpSbz
         m36oqp2jjI+fhNDrRqXr4xQejG/Re4+UYkJVmxbiY3UOd7cScBg5OC06xYIS9ixlJLcW
         Uchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1da5Mmv+lVSfrDW97v/PmXpj1+WQtwPjTFXxSLpd/34=;
        b=HSdaRf3vLgY9Ucx3rDRXbJlg031+4zWh51x7D5ZXBOhru7kcK1OB411XLAK2chbgTQ
         rxOUNC9IYTuRwC7kwCxb6Ds7l9OS0IzQYM5Cmoa+fC6ohTXbo1lUlZ/HJhK53OSGXlhv
         5UtNj96PQX/1nDkRkFmPu+HZJBCLqaUO8/k8ijI6ZFuMEIFXd96WXVvM/gicX30I6wdR
         KuNo54Hav+tsFd5umfAYapSvTWiJJ6m6aHhHPiRTHCmIckYqk5NTfnt6yY1QrmAMRAJX
         IvaCgeXZMwpb/5qHAf75f/um2d2ERmTtWnRa02a6/4E82TBLh9IBkfaapA/5FlXtfI1A
         Cc3A==
X-Gm-Message-State: AO0yUKUlsw8c6MVQkF5JaBJ3CRZ7cAjCW/V5IYa9JPJ4x5sehYDPPAo1
	i9cUm5S8i5kMZ2De4x1yuvkxc8oCssO1JPgD
X-Google-Smtp-Source: AK7set+uPytvG0MhkHxb4zJnPApMlqhIv69pSsu4PV2fe3DCY9L1+PRqHv+1ws8bbNF4i/wGop0ugg==
X-Received: by 2002:a05:6402:138e:b0:4ac:d34b:c2aa with SMTP id b14-20020a056402138e00b004acd34bc2aamr2052420edv.10.1676901933528;
        Mon, 20 Feb 2023 06:05:33 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k25-20020a50c099000000b004ad7c42a17esm770821edf.25.2023.02.20.06.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:05:33 -0800 (PST)
Message-ID: <4cef3e6b-ad2b-0757-098d-14f09692f68e@tessares.net>
Date: Mon, 20 Feb 2023 15:05:32 +0100
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
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <531ceec4b5af0abe463e80a19d98752ed1074aad.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your reply.

On 20/02/2023 12:51, Paolo Abeni wrote:
> On Mon, 2023-02-20 at 12:14 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 17/02/2023 18:58, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 09/02/2023 19:48, Paolo Abeni wrote:
>>>> As reported by Christoph, the mptcp listener shutdown path is prone
>>>> to an UaF issue.
>>>
>>> Again, thank you for the two patches!
>>>
>>> Now in our tree (fixes for -net) with my RvB tag.
>>>
>>> I had a few conflicts when applying them on -net (and later when
>>> propagating them to our tree, see below), I hope that's OK but don't
>>> hesitate to double check if you have the opportunity :)
>>
>> I probably didn't resolve the conflicts properly (or maybe some
>> adaptations are needed on -net) because this introduce some regressions
>> on export-net (not on net-next):
>>
>> Any idea what could cause that?
>>
>> https://github.com/multipath-tcp/mptcp_net-next/issues/361
> 
> I *think* it's not a conflict resolution issue; patch 1/2 here
> functionally depends on ("mptcp: refactor passive socket
> initialization") which let msk take a reference on unaccepted MPC
> subflows, so that incoming reset will not free such subflow via
> inet_child_forget().
> 
> I *think* the easier solution is moving this patches on export-next
> after ("mptcp: refactor passive socket initialization"), mentioned
> explicitly the functional dependency
Indeed, it makes sense. I just did that.

I removed the Fixes tags and mentioned it was linked to the refactor of
the passive socket initialization: is it OK? :)



Revert from -net side:

New patches for t/upstream-net:
- 1403082cb4f9: Revert "mptcp: use the workqueue to destroy unaccepted
sockets"
- a68e4d2c86ab: Revert "mptcp: fix UaF in listener shutdown"
- Results: 67a9b5dd9647..1231bdd38564 (export-net)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230220T125607



Re-adding in net-next side *before*:

   mptcp: avoid unneeded __mptcp_nmpc_socket() usage

New patches for t/upstream:
- b1eb4bc7fd93: conflict in t/mptcp-drop-legacy-code
- (9842f24e0af3: mptcp: fix wrong merge resolution)
- bcf869e80661: mptcp: use the workqueue to destroy unaccepted sockets
(net-next)
- (f1af1e12dde5: mptcp: add missing fix discussed on the ML)
- be46758055b5: conflict in
t/mptcp-use-the-workqueue-to-destroy-unaccepted-sockets-net-next
- cd7f29d04aa1: mptcp: fix UaF in listener shutdown (net-next)
- Results: 6d5a19a2f0c5..07db02c0176e (export) => empty, as expected!

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230220T135733

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
