Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3442CA6
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 13:23:45 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l25so56686343eda.11
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q3ISuUT0mUQ7GI920UlFVJAJuWIep5OCoeR5mZNyq5Q=;
        b=kAZgTbhzxoi12xrcIf9WtENyuxiSJ9mMtN5jwlotaA0vAoUiCFKHSyVTCIJNBzXsH9
         G5ZTccl0MwmHcuEELJMMDn+QTvWxq1JPMAN9YdOO7boVPld8BO4XgDqGMyrmWM9fEiS+
         LubXusRQn9GYk9m47UHGp0xaS+Eaj2BnvfcTKwLQjzpxFyKl9V5FGQ84OYjntv6u2Svg
         acYl5i76l5QQm7hmtPfXZblqUCVFo5br8+ltMqu1d6Q2XeWqqMyp76m3x4SkAOqA5p8Y
         ZXTl/DqtGj0c+IBES9VBuSlOtW26QHFUNapiAAdoeUyVeNkiPtHyiCTOfSLbp6FEBOE6
         o75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q3ISuUT0mUQ7GI920UlFVJAJuWIep5OCoeR5mZNyq5Q=;
        b=okXyAr89LxphTuMExdnsB9VnFuXMIRw7D0XF7ww7MVgY3Y9Aeriviy/n++IjXrWeOh
         OrKfdToXSqcQ7MsNlGeDPgesf+9zHYP7TwoGeEpj2crYt63mQPA4CXxWH1FF2OhDAr8J
         yycUFzzT2u7lmoeHlNE/0uQ/okQb1SObHXDzcNrl+BPtDstfAbsNX68OsTzIF/mIcWoy
         bjFJDBFkpsxOHC7V5ZU3HYKvLi4/kdJM2cN5oNV9zbqOGhMXDq3ksZ1QIC3R+MZbfBEF
         L+DiKlwof1zBwVnGaQE1xYyrTaBjefuk6KN9WKXNzkUkG/RQa6E6ObjiyX7Ow4K52uw0
         8CKA==
X-Gm-Message-State: AOAM53142JljNtrDxWt1vYHpRadA8t4XsRnrSRwbQUE9NK/xDp8ZK7Ct
	T0g1dVjgRkQgpcTSKZG3g0BLrw==
X-Google-Smtp-Source: ABdhPJwLle1KaPiAZIWzW8fNwkPNTOva36fqZcFuhl8DJdFS1FeWq5nFyeGtdcPkQRCAFJHuXWyIiw==
X-Received: by 2002:a17:907:3c16:: with SMTP id gh22mr52164494ejc.344.1638883423521;
        Tue, 07 Dec 2021 05:23:43 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id hc10sm8595160ejc.99.2021.12.07.05.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 05:23:43 -0800 (PST)
Message-ID: <5c1ddc21-77a0-3492-6afc-e7c33df6568b@tessares.net>
Date: Tue, 7 Dec 2021 14:23:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <00000000000040972505d24e88e3@google.com>
 <20211205192700.25396-1-fw@strlen.de>
 <61ea8986-10c2-1d4f-6c35-2c910dbdcf89@tessares.net>
 <38c041f7-29d9-e61d-d5bf-6523785ce12@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <38c041f7-29d9-e61d-d5bf-6523785ce12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 06/12/2021 19:47, Mat Martineau wrote:
> On Mon, 6 Dec 2021, Matthieu Baerts wrote:
> 
>> Hi Florian,
>>
>> (without netdev and syzbot ML)
>>
>> On 05/12/2021 20:27, Florian Westphal wrote:
>>> TCP_ULP setsockopt cannot be used for mptcp because its already
>>> used internally to plumb subflow (tcp) sockets to the mptcp layer.
>>>
>>> syzbot managed to trigger a crash for mptcp connections that are
>>> in fallback mode:
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
>>> CPU: 1 PID: 1083 Comm: syz-executor.3 Not tainted
>>> 5.16.0-rc2-syzkaller #0
>>> RIP: 0010:tls_build_proto net/tls/tls_main.c:776 [inline]
>>> [..]
>>>  __tcp_set_ulp net/ipv4/tcp_ulp.c:139 [inline]
>>>  tcp_set_ulp+0x428/0x4c0 net/ipv4/tcp_ulp.c:160
>>>  do_tcp_setsockopt+0x455/0x37c0 net/ipv4/tcp.c:3391
>>>  mptcp_setsockopt+0x1b47/0x2400 net/mptcp/sockopt.c:638
>>>
>>> Remove support for TCP_ULP setsockopt.
>>
>> Good catch!
>> Indeed, it doesn't make sense to support TCP_ULP.
>>
>>> Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>
>> I guess we need a Fixes tag here:
>>
>> Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
>>
> 
> Thanks Florian.
> 
> Matthieu, could you apply this to the export branch with your suggested
> Fixes tag?
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Sure, just did:

- 13dc812544f7: mptcp: remove tcp ulp setsockopt support

- Results: 5fd3630ba52a..4be3d8d5b45c

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211207T132312

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
