Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651220E3
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 11:27:11 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id qw12so14853719ejc.2
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ociTFyvqpFzCLaD+4HpFu9IeLB4UqT33UYgPWeey0Ec=;
        b=dSJ/bai6PYMcir7VRe5D+5dK9boLEpdTstOPsyj6g/NbhMzQF0XPNikh8MJlrLLVY7
         7z5S99xW3uvS6+dKwaEijLKscFX02p9pdRoCOCVUoctfljiBUTUOGyDilPhSnm7ygsUz
         ATrTpNYaxol15PAD2aPiTXw9P1i9sxQ7yZ3/77eAdMpIH8EsnjATYkb9oB4S+i8m9bf/
         LQgnbslASm2D1j8s44Ldano1U1/Aq49EU+9pLR3Bl9L60jzV0FNrcQZLY8yLNBzHPJRo
         gLR5VlyVyroRk803mcCXni5mHA5fizSjj3R+bVFlegE6Kgd1kEXCVu0+w2WeHvckTVRd
         FimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ociTFyvqpFzCLaD+4HpFu9IeLB4UqT33UYgPWeey0Ec=;
        b=Yciu1YXktbFscHSbdBFFIRfN+IsS4gtXbBDHBPPd+pKxyxOe70Dpzo648o+ju8Ydn0
         M0umsLzaLKCdMbInh0GyrZm3GxPF2odWH8lo2lrPPXtcsuPCZ6n3Nwp+pIl7KUCdekCA
         6/KQpuQgXwLKlbWunVbBFEFEqF75/mVGN5cU4A+6SuJ31QJrTHD7sRa1bDHWP+DFswmu
         f6VEV83H3SJmmlpC6s56d/XlWrCP6+WqtMTqVASKVeb3rp79L5EUpVNGVsuNYHIWSwhB
         3N86clxDzzd8kH+6wIQw6JOcrfKs1BcHOYjgtDw/+D+3Lbhgj3cyOk6XTM0igRoFQNaG
         KHWQ==
X-Gm-Message-State: AO0yUKWn7ab46Ce19kZDrbV7CTZgpd/C7qERJiShmVilTOzY83kvAMpQ
	DepjJHQQnAnD/U+dX1ypdN/xFA==
X-Google-Smtp-Source: AK7set9NQXwUVKnoYwau8/6iULESpQSzrkcQrm+HZuYfpFNXDJT37I4Cd16Py26GGSOrkfme51VrMg==
X-Received: by 2002:a17:906:1112:b0:87b:d3f3:dcf3 with SMTP id h18-20020a170906111200b0087bd3f3dcf3mr11223803eja.35.1675078029866;
        Mon, 30 Jan 2023 03:27:09 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id rs14-20020a170907036e00b0084c6ec69a9dsm6597682ejb.124.2023.01.30.03.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:27:09 -0800 (PST)
Message-ID: <72d28ef7-5672-8400-1d9f-5ea40c0db424@tessares.net>
Date: Mon, 30 Jan 2023 12:27:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 mptcp-next 00/15] mptcp: refactor first subflow init
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1674767058.git.pabeni@redhat.com>
 <39af32d0-67ac-dddb-3482-db9229db2e4f@tessares.net>
In-Reply-To: <39af32d0-67ac-dddb-3482-db9229db2e4f@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/01/2023 15:04, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 26/01/2023 22:05, Paolo Abeni wrote:
>> This is the needed refactor for the selinux fixes, as discussed on
>> the ML.
> 
> Thank you for the new version!
> 
>> Compared to v2 this revision introduces 2 additional patches:
>> 1/15, just another cleanup found while addressing the recent bugs
> 
> I guess this patch 1/15 is for net-next, like the rest except patches
> 2-3/15 for -net and 14-15/15 for "features for other trees", OK with
> that? :)

I did the split as mentioned above:

New patches for t/upstream-net:
- 77065cb9b06b: mptcp: fix locking for setsockopt corner-case
- 25370fede8b4: mptcp: fix locking for in-kernel listener creation
- Results: 6b2c6f9b9f58..345e6b079d31 (export-net)
- Results: a9e99450a0dc..2cc9fbc57e9e (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230130T104511

I did the modifications I mentioned before (open-coding, remove ret init
value + remove 'dot' at the end of commit titles)

New patches for t/upstream:
- 9e41e2ef1150: mptcp: use mptcp_schedule_work() instead of open-coding it
- 758223f115f3: mptcp: refactor passive socket initialization
- 679568236f20: mptcp: drop unneeded argument
- ccd4c33a46be: mptcp: drop legacy code
- 38bb4d9bf952: mptcp: avoid unneeded __mptcp_nmpc_socket() usage
- e89bb1c2776b: mptcp: move fastopen subflow check inside
mptcp_sendmsg_fastopen()
- ad01f840f0eb: mptcp: move first subflow allocation at mpc access time
- 12c5495dcbf4: conflict in t/mptcp-add-sched-in-mptcp_sock
- 3b92b0c170fd: mptcp: do not keep around the first subflow after disconnect
- ef7a57b6d68f: mptcp: fastclose msk when cleaning unaccepted sockets
- bce2ac546916: inet: factor out locked section of inet_accept() in a
new helper
- 7b01909e43c4: mptcp: refactor mptcp_stream_accept()
- Results: 2cc9fbc57e9e..9ce16c0a6116 (export)

And also the two last patches at the beginning of the "features for
other trees" section (without warnings reported by CheckPatch)

New patches for t/upstream:
- e10d02bc0bdd: security, lsm: Introduce security_mptcp_add_subflow()
- aaf4f8c54ca8: selinux: Implement mptcp_add_subflow hook
- Results: 9ce16c0a6116..638a12c9ada6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230130T112422

I also just merge the modification in packetdrill:

https://github.com/multipath-tcp/packetdrill/pull/113

(and branched the 6.2 version)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
