Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1652FB3
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 15:57:42 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id r7so13995430edv.12
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZ7vuiiH72ecXGxKLxntlCmQ/Tqosa/+P1I2uLA8wsI=;
        b=BPfrPPmQWRP71kDVakDTlobMF2OdCkacTsVscYCAdj8WThnHaqpSNEvNcqD/dDaZL6
         eAKrcDsk37oPI2Vvc6EszHg0CCJJtliRuSA0vvYmMpuJ4Z5PG7vkaIGaEVvl8WWlCtgs
         6pQwoyWsww97nG47CX9OogHSlLyjf8Er2Mhg92bncr/9tV+4da1WMo9MHbciIvOusUVz
         zNGfu7YYHYYBFjTDoj7Hb+ngbk9Zr7pfngAnBBV8dvO8ZxQj1V9Zior+cK91QlGKsST2
         yLojzC0p4o9g0cMt2WPRZS/+/W83CRZCm92LOK5G7Z8LjRxLm1PlPWIn9oCEfemYcK2R
         8F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZ7vuiiH72ecXGxKLxntlCmQ/Tqosa/+P1I2uLA8wsI=;
        b=qOztNOcs7BOZbXLBbP5w6vceiME34UlP9LyYd6lsAdMZKUOSOIGUbFPBL6JrnVTb5a
         8xUtHEmJE/qUyuU7S8TFB0o0tn4arrgridfWKuTi1yZvjAxzXX0c3zDOTqvVPeSinhKJ
         /NoCbuM6WEzxXK7LqE1JoDt4JmCaI6f+yy3CrGpYRDZbe576/XfUO2xzSYI8n3Uuuv8A
         C1YIIvKqitbJDfgedt9I2bWoCHfw5h5dqT+rXUwdPVJ3XhnFwryufUb6l3TYoE6GkpFZ
         aEGsLz6yAoohu6Dyg7xRYwX15f79jxk9cGIgsjYVpBOWXzIwBjg745KbgveAUVFhmDSE
         wIsQ==
X-Gm-Message-State: AOAM533vsWmQnGHFDRWCkRFLDqcUoQhDdvu3ujnYe1zVk+p3DlFJ1tnk
	4oUN5sJKjnTArrF5G7/5T0Pbzg==
X-Google-Smtp-Source: ABdhPJwtgmthwyt/rSgMvXqizSGUGxyhN/otupuToiD+HXAPhyfQuGrMluj4iejatIm5b8ZZt9f2vg==
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr15424504eds.143.1624636660811;
        Fri, 25 Jun 2021 08:57:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:3f3:57d7:aba5:347d])
        by smtp.gmail.com with ESMTPSA id gx13sm2908150ejc.55.2021.06.25.08.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 08:57:40 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] mptcp: fix 'masking a bool' warning
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20210625115329.858684-1-matthieu.baerts@tessares.net>
 <dfc2322-22bb-9380-4c7a-9ff1b66b8431@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <bab06c28-74e1-b224-fd07-c1f281e6116c@tessares.net>
Date: Fri, 25 Jun 2021 17:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dfc2322-22bb-9380-4c7a-9ff1b66b8431@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 25/06/2021 17:43, Mat Martineau wrote:
> 
> On Fri, 25 Jun 2021, Matthieu Baerts wrote:
> 
>> Dan Carpenter reported an issue introduced in
>> commit fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf") where a new
>> boolean (ack_pending) is masked with 0x9.
>>
>> This is not the intention to ignore values by using a boolean. This
>> variable should have a 'bool' type but we should keep the 'u8' to allow
>            ^^^^^^
>         "should not" ??

Good catch!

>> this comparison.
>>
>> Fixes: fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf")
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Thanks for catching this Dan!
> 
> I'll send to netdev today. Meanwhile, for the mptcp tree:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you, just applied in our tree (fix for net-next) without the typo
and with your RvB tag:

- 320bd34a848a: mptcp: fix 'masking a bool' warning

- Results: a12d33111689..28e592bb887e


Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210625T155645

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210625T155645

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
