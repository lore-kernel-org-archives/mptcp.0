Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27D2C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:19:56 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so6057217wmd.5
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UDjVSM4aDFGybm29yIra1PvYbtIZLDOhviCgm2bXM4M=;
        b=Z6RQ1/tH7o/eLO2ftV/l1sNRJNFzbXZhRqZJcNaPB4D7LvlB8cFCkjSHJTa9N6P5SR
         UEEC9ogSMa+JYJT3BW2EHW3zayoyvaCYi0m+/tfaJ4ZaKeGG9omfOlErI5gorjwgmliE
         Ezk83+6I/pSCOWIavbNx8HcF/iuNlo3jm9hMc+eoTSRs1Bi3r/EQ/UG5ZtywsK1gnklJ
         kTWF3RJQfNrxFSeuwe5QZ5vAVAvfIzZhx3nXvHc0Oys8MbA0aYvztO9iJspjckj9aAmv
         7pm4KbSbbnNmqTR1U2Fp3OkfV4lR9GyImHE4t96czztI35qwooWBRrhxzseN3NwVuhwn
         BKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UDjVSM4aDFGybm29yIra1PvYbtIZLDOhviCgm2bXM4M=;
        b=6BQShYqzO1I5x2zAMH9p6MAV9wpgI+Ux9KYgIF46fHg4AqAl/beSNIQ7dGEc0J4BKV
         OLF0cgTJXwKHURECwWeAN5nX8/Sdo6dUGw3dLWGtnL3FjAcPvvVBPHAM9Pr6yuM9yLgm
         mMh+VTzGmElx68zaPYnpwrRnQlGUqr7YUTgsW18hkxPKIq2V+9qgN9tNpRY5TKZUsVM+
         gZXlJnMVbZtcjIvsRGGmM+m+JdfPszHFms141Q/PPJUFcQYjaHRO+eF3M0Ppid//xHhn
         DEXMD4hj6QRXkADcAsge8CM8fx2w8EWP7suMhQzP039mKUASlCSYWBMqxm8JTbPb4j44
         UhBQ==
X-Gm-Message-State: AOAM530v+QmKP3wWmFcDRfGMDVZwgPE5/jeJQhUy+fKrqEAIyr1zNuEA
	xx3xrkVlx5F0zYD0SQKnsQnstQ==
X-Google-Smtp-Source: ABdhPJxvKhPy7cHVlN5bAWFwzE9aim5n53Fay8AD6lvlws7ERjsDgSkYbDYmr0TGera9FIcYWlXyKg==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr16850660wmr.4.1643390394409;
        Fri, 28 Jan 2022 09:19:54 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id z1sm2322887wma.20.2022.01.28.09.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:19:53 -0800 (PST)
Message-ID: <084040ae-1b2c-39c9-fa01-73733e27bd17@tessares.net>
Date: Fri, 28 Jan 2022 18:19:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-net v3] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220128003746.2732527-1-kishen.maloor@intel.com>
 <ba1702d-2951-132b-7fda-4ed1045dcd@linux.intel.com>
 <CA+WQbwvVGsbkdZc9wNkC5DB2YLFnBqzv5hw3nDR_NTBZkqC5vg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwvVGsbkdZc9wNkC5DB2YLFnBqzv5hw3nDR_NTBZkqC5vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kishen, Mat, Geliang,

On 28/01/2022 09:18, Geliang Tang wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2022年1月28日周五 10:09写道：
>>
>> On Thu, 27 Jan 2022, Kishen Maloor wrote:
>>
>>> This change updates mptcp_pm_nl_create_listen_socket() to create
>>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>>
>>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> 
> Acked-by: Geliang Tang <geliang.tang@suse.com>
> 
>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 8 ++++++--
>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>
>> Looks good for the export branch:
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for having extracted the patch and the reviews!

Now in our tree (fix for -net) with Mat's RvB and Geliang's ACK tags:

- df2b5c816e23: mptcp: netlink: process IPv6 addrs in creating listening
sockets
- Results: fa314fbb2be0..e3f80698163c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T171819
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
