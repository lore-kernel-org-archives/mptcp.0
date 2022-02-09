Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D02F24
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 11:46:24 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id m4so6443560ejb.9
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RJxxgCE2aqdd6gWtHov29nk2mGmmxADemLITpDwyEXo=;
        b=JLwQhzN+5BnzEJwVPf6c9P/QYtNeWEFa2+VTK6xTaMhr6EUcu738IE/i/3Ws1J4TqZ
         2Z8tn+r/xdEvP6/lfEcfXiHHYGMhxC39g2I9PIoQPrVlDQNdu6jZlfcmGUAnyw6gHHVa
         d1MjtD35fcW7h9tmBwEq0UOwQ7YshjHKFsuuBioeWKNStIY/5CHLyX7ZmzECkwOHhWWA
         NOW2GiiGEISUxmIqXBZBNU3f7p255FCDNzHAQlszdZzjUMImKaZntR1HqmQGFk07Qyqn
         rJAzavdDpBlZMgwouEtGLNVrQKRSLGxqHIImbmQfdiW8Tsi6blLhCDd2RpAGpj60yNWQ
         VJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RJxxgCE2aqdd6gWtHov29nk2mGmmxADemLITpDwyEXo=;
        b=sw6zVIh6N5f0sgyZaEv29iKYOYeswAWCQP8+bpMgN+EQnTlhmdeGv0MMKAr2yQkGTf
         f2mO8xPsEoWCLph77hYjOIzRa6hIh3ci3FU6m7AXP9UdQEy+/dxEDJJd52pPd73gJA3f
         h6MgE+sNaNczpkJVa9dXhRMwZXd67cFXLbRP0COn46MI8YHRZX35jPTTKyO2SSbtuVeJ
         AQGZaWzu0fYq90fnIhnSJ+5g94BC/lbwaGAVFMD8keyLY9McPFL7MnUXZ8rEqCIGuzxK
         jDAFdbkI3gMBtKrMo07ZxyEog9Cyu1/NazfwDEQat6YmLaKs0Dgvyvm99nbnP9k+aKld
         TBGQ==
X-Gm-Message-State: AOAM531kEfYcYJcrGgVfDEyJGpvmAfkFycCcBKRBAPvaf2IPcaVeFm4q
	fpjVdKZLUOSU9LkS3aEre8pssA==
X-Google-Smtp-Source: ABdhPJyUG7JF4vIjWbtwM61sRUckBdIAexJ5pZgyjJ/Q2NluvItihUU+/Bl4T77DO6DpwaC+aNfLYA==
X-Received: by 2002:a17:907:7e9d:: with SMTP id qb29mr1610433ejc.571.1644407182418;
        Wed, 09 Feb 2022 03:46:22 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:7367:f707:bfa2:c077? ([2a02:578:8593:1200:7367:f707:bfa2:c077])
        by smtp.gmail.com with ESMTPSA id eo14sm4819601edb.46.2022.02.09.03.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 03:46:22 -0800 (PST)
Message-ID: <29287b52-88fa-fa12-fc57-33107b069edf@tessares.net>
Date: Wed, 9 Feb 2022 12:46:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 0/2] fix mptcp bpf selftest error
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <cover.1644300192.git.geliang.tang@suse.com>
 <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
 <20220209031001.GA3406@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220209031001.GA3406@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 04:10, Geliang Tang wrote:
> On Tue, Feb 08, 2022 at 04:21:04PM -0800, Mat Martineau wrote:
>> On Tue, 8 Feb 2022, Geliang Tang wrote:
>>
>>> Fix the mptcp bpf selftest build break.
>>>
>>> Geliang Tang (2):
>>>  Squash to "bpf:selftests: add MPTCP test base"
>>>  mptcp: add SNDTIMEO setsockopt support
>>>
>>> net/mptcp/sockopt.c                            | 2 ++
>>> tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
>>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> -- 
>>> 2.34.1
>>
>> These look good for the export branch.
>>
>> We did talk about SO_SNDTIMEO about a year ago:
>> https://lore.kernel.org/mptcp/5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com/
>>
>> But Paolo's concern there no longer applies, because the socket option
>> changes since then will apply the sndtimeo value to the msk instead of the
>> first subflow.
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
> 
> Hi Matt,
> 
> When you merge the squash-to patch, could you please help me to rename the
> subject of the original patch from
> 	"bpf:selftests: add MPTCP test base"
> to
> 	"bpf: selftests: add MPTCP test base"
> I think it seems a little strange that there is no space after the colon.
> And the subject of another patch "bpf:selftests: add bpf_mptcp_sock()
> verifier tests" needs to be renamed too.

I think it should even be:

  selftests: bpf: (...)

I can do the modifications.

> In addition, I want to know why these four BPF patches have stayed on the
> export branch for so long. Are there any functions that have not been
> completed yet? I wonder if I can help.

BPF maintainers also wanted a support in BTF [1]. Nicolas -- who worked
on these patches up to the v3 when he was doing an internship at
Tessares -- wanted to prepare a v4 addressing this comment but he was
busy with his uni work.

If you have the opportunity to address comments from [1], that would be
great!

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp.thefacebook.com/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
