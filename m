Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFEEC4
	for <mptcp@lists.linux.dev>; Wed, 25 May 2022 12:50:14 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id d22so3212927edj.4
        for <mptcp@lists.linux.dev>; Wed, 25 May 2022 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u27c4+MAtr4957DdCi/W76U+MTxmUmdTJPcJgTY5UTk=;
        b=aznQV9mVTpNhq3fFa6aGL3hyugIhLP+vI5xO1/e0S281AWqJDAWa7mmS29pVe/mXEV
         PGK869qlEB9gzhVa2aTw1Knp+IIbJNnlfDjgcUQaCQQpoPgV/Oq/OzCgJYChsEOnGo88
         +YtOMYq0EUf/IjJ5WpRJTDLI0EirJp72yhxcEfShIRi3R0/0HjpX9lCX6NCtFW8sYF7S
         +BNGSh4HuXZ3VRBiIu+HGtcMhxM+XrdtBFTgErA29IzcBWGTraNbB9cm53hMknHJcREt
         DVmPOGkXM8At9Zur479O8pvgY49jNSEYbIz5qUtxDN4AEvNT0m6E24J1xDtCB+p+uWSq
         NuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u27c4+MAtr4957DdCi/W76U+MTxmUmdTJPcJgTY5UTk=;
        b=FO9lqiN7pP6HI4JQW4SaP4SEbLlDvP0CLeBBK7K7JKpuNVeCfXOuZYRS3q4CHaWucu
         pTozNhqG+FMuEVDoC7n11T5Z/nytvzFYJM4vvvwvIt0TdxZBeHADSJIVlL7A+Wc7SDhp
         s1niW9fXNQtZ2/wmeNyrMhAYUDRw7E8rYugDGxg3BgvloRodKkGoKOWSZm/7/EPp0Vzk
         EeSx1JH17Np/8WnFjSOAe3p1RvofOZ4+g9RSILpiGsIh8olU6PqUKm7z2obpyvyQynfU
         nYzGeJHMFJ6qolQMmeVu3iB/nzSW3v3Nb+NGZ6OwLiezci6HxNWv9eEaqWRAOLDEPDK9
         Pl8g==
X-Gm-Message-State: AOAM531/RbE6+74xKpm6HQ1BnxHUf01aIK+1waKy1w6qU+8FaMqr3XI8
	0UQRAruhzRx6TX/GwkV+HJ0H5Q==
X-Google-Smtp-Source: ABdhPJypnth1vypu9Rzch+m9eE7OQlClYAB1f8BVQE8dygwpS8pfkKKKj5ScRmQ6JvelQmsq+eIqGw==
X-Received: by 2002:a05:6402:43c4:b0:41d:9403:8dca with SMTP id p4-20020a05640243c400b0041d94038dcamr33456591edc.184.1653483012403;
        Wed, 25 May 2022 05:50:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2c21:b442:2fc3:f06f? ([2a02:578:8593:1200:2c21:b442:2fc3:f06f])
        by smtp.gmail.com with ESMTPSA id bf15-20020a0564021a4f00b0042a9fcd7c73sm10786001edb.46.2022.05.25.05.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 05:50:12 -0700 (PDT)
Message-ID: <7ca5a59a-c1a4-92ae-1d93-59ff73a487ce@tessares.net>
Date: Wed, 25 May 2022 14:50:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mptcp: Do TCP fallback on early DSS checksum failure
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 stable@vger.kernel.org, sashal@kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220524181041.19543-1-mathew.j.martineau@linux.intel.com>
 <Yo3gG9H8Sw/w7baR@kroah.com>
 <0648dc99-7465-871c-90a1-8a69f60d893c@tessares.net>
 <Yo4gPPQ1GVzblG8B@kroah.com>
 <be79c0fc-25b2-98ad-2e66-4ecfc6a64deb@tessares.net>
 <Yo4k0e7VFCRVpsRG@kroah.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <Yo4k0e7VFCRVpsRG@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/05/2022 14:45, Greg KH wrote:
> On Wed, May 25, 2022 at 02:36:10PM +0200, Matthieu Baerts wrote:
>> On 25/05/2022 14:25, Greg KH wrote:
>>> On Wed, May 25, 2022 at 12:32:04PM +0200, Matthieu Baerts wrote:
>>>> Hi Greg, Mat,
>>>>
>>>> On 25/05/2022 09:51, Greg KH wrote:
>>>>> On Tue, May 24, 2022 at 11:10:41AM -0700, Mat Martineau wrote:
>>>>>> [ Upstream commit ae66fb2ba6c3dcaf8b9612b65aa949a1a4bed150 ]
>>>>>>
>>>>>> RFC 8684 section 3.7 describes several opportunities for a MPTCP
>>>>>> connection to "fall back" to regular TCP early in the connection
>>>>>> process, before it has been confirmed that MPTCP options can be
>>>>>> successfully propagated on all SYN, SYN/ACK, and data packets. If a peer
>>>>>> acknowledges the first received data packet with a regular TCP header
>>>>>> (no MPTCP options), fallback is allowed.
>>>>>>
>>>>>> If the recipient of that first data packet finds a MPTCP DSS checksum
>>>>>> error, this provides an opportunity to fail gracefully with a TCP
>>>>>> fallback rather than resetting the connection (as might happen if a
>>>>>> checksum failure were detected later).
>>>>>>
>>>>>> This commit modifies the checksum failure code to attempt fallback on
>>>>>> the initial subflow of a MPTCP connection, only if it's a failure in the
>>>>>> first data mapping. In cases where the peer initiates the connection,
>>>>>> requests checksums, is the first to send data, and the peer is sending
>>>>>> incorrect checksums (see
>>>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allows
>>>>>> the connection to proceed as TCP rather than reset.
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org> # 5.17.x
>>>>>> Cc: <stable@vger.kernel.org> # 5.15.x
>>>>>> Fixes: dd8bcd1768ff ("mptcp: validate the data checksum")
>>>>>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>>>>> Signed-off-by: David S. Miller <davem@davemloft.net>
>>>>>> [mathew.j.martineau: backport: Resolved bitfield conflict in protocol.h]
>>>>>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>>>>> ---
>>>>>>
>>>>>> This patch is already in 5.17.10-rc1 and 5.15.42-rc1, but involves a
>>>>>> context dependency on upstream commit 4cf86ae84c71 which I have
>>>>>> requested to be dropped from the stable queues.
>>>>>>
>>>>>> I'm posting this backport without the protocol.h conflict to
>>>>>> (hopefully?) make it easier for the stable maintainers to drop
>>>>>> 4cf86ae84c71.
>>>>>>
>>>>>> For context see https://lore.kernel.org/stable/fa953ec-288f-7715-c6fb-47a222e85270@linux.intel.com/
>>>>>
>>>>> THanks, will take this after this round of releases.
>>>>
>>>> It might already be too late but is it possible to have this patch
>>>> ("mptcp: Do TCP fallback on early DSS checksum failure") and "mptcp: fix
>>>> checksum byte order" in the same stable release?
>>>>
>>>> Note that "mptcp: fix checksum byte order" patch has been recently
>>>> queued by Sasha at the same time as "mptcp: Do TCP fallback on early DSS
>>>> checksum failure".
>>>>
>>>> A bit of context: "mptcp: fix checksum byte order" fixes an important
>>>> encoding issue but it also breaks the interoperability with previous
>>>> Linux versions not having this patch.
>>>>
>>>> The patch from Mat ("mptcp: Do TCP fallback on early DSS checksum
>>>> failure") improves the situation when there is this interoperability
>>>> issue with a previous Linux versions not implementing the RFC properly.
>>>> The improvement is there to make the MPTCP connections falling back to
>>>> TCP instead of resetting them: at least there is a connection.
>>>>
>>>> In other words, that would be really nice to have these two commits
>>>> backported together. If it is easier, it looks best to me to delay the
>>>> main fix ("mptcp: fix checksum byte order") than having the two patches
>>>> in different stable versions. But I understand it was not clear and
>>>> maybe too late to do these modifications.
>>>>
>>>> Anyway, thank you for your work maintaining these stable versions! :)
>>>
>>> I have already done a release with the first change in it, sorry, but
>>> have queued this up now.  Given that this is fixing a problem with that
>>> commit, I'll go do a release right now for 5.17 and 5.15.
>>
>> I'm sorry for the troubles this is causing you but thank you for doing that!
>>
>> Please note that on the bright side, the DSS Checksum feature is
>> disabled by default so hopefully, this interoperability issue should not
>> affect too many people. It is hard to quantify but I guess there is no
>> need to rush if you prefer to wait before doing this release.
> 
> No worries, it was easy to do a new release, now done!

Wow, our first MPTCP-only stable release! :-)

Again thank you!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
