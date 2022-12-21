Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF862569
	for <mptcp@lists.linux.dev>; Wed, 21 Dec 2022 14:07:27 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso1617690wms.4
        for <mptcp@lists.linux.dev>; Wed, 21 Dec 2022 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t08dbMxxgYNxikwsmaCXURwrFgFs/Yro0lqU7t6BVVk=;
        b=HmfBNUV++op9CEnS/XUvF2QSM70kwXSIMtH0KDevE1OTGqYFb6N25bg0XEQ51HWXgM
         HC+T0jLlQ2pqMM6RsYEdmfTULZ+4nt/PBlhAAaqwpz6aXr1Ti95NI6SjMaxZwc++EW6D
         HEF0HQ139w+Fbi2ACd5VsdMmzQLiuw/Z92pstOWE5C1iPcxsWvkxoHGk38rJVQmwE4/O
         fB511QOB/wxhVe/BT3ImckZmJM7ouh/yCrS7yK2IkBT6UcdsB8NsiBh0J93iUyfm5Wm1
         C1JpW4P8IHkglVR70FnZ8m6TBwAh/0wv+UMpo/6F2INVjQJI281K2TQD7e34vt9EcWVR
         M6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t08dbMxxgYNxikwsmaCXURwrFgFs/Yro0lqU7t6BVVk=;
        b=Slxu9fRijXsfzzg6H8gSDsMtn7l+3oKc5nAMUhIBKVQQ4chjZAeG0Zq19PTZey84SN
         O2ERa5gocEJm01KZ1kawApbJLzX27zZ/+0CrbOKIe9ukUXIf7wvQ5kUvG9XQr2KEv5np
         9xCVjqZvQR4m4aKlB38W1TEOR66Qw6PZpH5Sflfdj4MGjLPYFINJEotMT024SLrfMW6U
         RF/N4iczrNyqUtdt4jJ5Kb1FJE6FhMhbUEqMNj2lCoSHA4MjK00DVp4wL0vAu8chQaoj
         t6eaz8y2N2IVtwR7mM7uZaDoVRNHu3K7HpIrtvqCtp6s8MZ5Cc01QbKGdVTnGYZ909mt
         DHxQ==
X-Gm-Message-State: AFqh2ko81PYdm55s5TUWqxHzzricR3XA03IajnNBci6VguHl3Klm/oWx
	KEYSRCwPFzyDpFdPVpcKS0nDoQ==
X-Google-Smtp-Source: AMrXdXvZkQmVrT0W42/s0rvpIONZf+uUN51GpTW6Jsr1iZgrupERNOzoPBvOJ/WsXXJEPb+LFIHPfQ==
X-Received: by 2002:a05:600c:4e90:b0:3cf:894f:964b with SMTP id f16-20020a05600c4e9000b003cf894f964bmr1533103wmq.16.1671631645512;
        Wed, 21 Dec 2022 06:07:25 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c6df:cbae:132:5f5b? ([2a02:578:8593:1200:c6df:cbae:132:5f5b])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003cfa3a12660sm7273174wmq.1.2022.12.21.06.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 06:07:25 -0800 (PST)
Message-ID: <20b3d783-b490-1db6-78d1-e84b2edb60a1@tessares.net>
Date: Wed, 21 Dec 2022 15:07:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-next v25 0/5] BPF redundant scheduler, part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 15/12/2022 13:32, Geliang Tang wrote:
> Implements the redundant BPF MPTCP scheduler, which sends all packets
> redundantly on all available subflows.

Thank you for the hard work with the patches and the reviews!

I just applied them in our tree in 2 different places as requested by
Geliang. I also integrated the Squash-to patch sent by Geliang and added
Mat's RvB tag.

New patches for t/upstream:
- 324b3cbe75ae: mptcp: add scheduler wrappers
- 2e6f3e6c3604: mptcp: use get_send wrapper
- 52f8f6af934c: mptcp: use get_retrans wrapper
- Results: 6c58a377c113..4254b6598308 (export)

- 61c95bbb18c7: selftests/bpf: Add bpf_red scheduler
- 46cf70243ce8: selftests/bpf: Add bpf_red test
- Results: 4254b6598308..224f92634d88 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221221T140648

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
