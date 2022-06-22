Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B31843
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 21:13:17 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id u12so36875039eja.8
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=X9sYjy41G4cU3YWYoRwmKcxsbJfciE3WGCjIoA/Ny5A=;
        b=RUUiWJyGwm1lBGYm7EdRrip/uL4BPoPqYneSaadPvS9dQZXyQcvg3CFFWUAHgB8ed8
         ew7zLH2IJr0zKrFTXFDUYrQJ+/f60hrDPJmhlXp7YDVRQXC/fJsjw0RP3fp0QLbYL+P8
         e6L+u6GBHcLFz9kTej5RsYvTcMSKsRFgDhK10xp1LcV8d3ZAyssp2yQl8TxIYzjbcYVc
         CDM7k6NLv+O12Qkgsv5tmC3pLxz+3fqe7fObARqiP0DWCNaSuJqq9FzodV65oDey1m7h
         DXcBAu8040+ACUJg51fN57X+KvG/3Me5fAbGgI/QrV1jReF30mLf0VkuGTp789KgJRty
         dhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X9sYjy41G4cU3YWYoRwmKcxsbJfciE3WGCjIoA/Ny5A=;
        b=fQJsrEXZrnse6RwKLBdc7E2MwkzyFgpy2FPYUqGYmnJyO0dDQMfpNb8xXTaM7+tZWU
         BmCvvkW9/4teHHEDRRQUcFPxAxVDlAyhsESjOUUalA86QS9ep59Xm2w0hjQw9jrFPNLD
         5zWC2nkU0dlGYHAjlabUXBYGuE/0IsSaI/SxocMGKTICdiADzKKuX3NrOtBKO/5DqgBL
         Yah5u1oXJRhxGC2htuWBCuQ5YCwGgbtHfdBsX+gCffGIsXXSZEyYqH/cEK1VmuktuHye
         hXvQifxDJr/oloi9f8Dk88Z+EMTQXsRT00FDs6EqJhyuMlHLBERtHpDKBeh11SVn9Zgr
         3eqQ==
X-Gm-Message-State: AJIora//7MmqppGBMQCX3JMXbHZxbW734IRDyw9tuB4XbMcytXA3ECyY
	kx/Ya+ya6Xl6ry5plOPsUhcs0AtDBjGx6g==
X-Google-Smtp-Source: AGRyM1vA5kN0vMdrZ3xO4oqiQ6LWUnL/j19NRZCA9sKOxhsD2VJR6ivuIkNGw9xfxU0H/eth3+SpMw==
X-Received: by 2002:a17:907:16a5:b0:710:7e87:465a with SMTP id hc37-20020a17090716a500b007107e87465amr5036924ejc.137.1655932396109;
        Wed, 22 Jun 2022 14:13:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e063:12b5:8fdc:749e? ([2a02:578:8593:1200:e063:12b5:8fdc:749e])
        by smtp.gmail.com with ESMTPSA id dc1-20020a170906c7c100b007121295f08csm9781462ejb.219.2022.06.22.14.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:13:15 -0700 (PDT)
Message-ID: <e7d707c8-9b0c-1366-2245-e3157f82a76b@tessares.net>
Date: Wed, 22 Jun 2022 23:13:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: Initialize variables to
 quiet gcc 12 warnings
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 22/06/2022 02:18, Mat Martineau wrote:
> In a few MPTCP selftest tools, gcc 12 complains that the 'sock' variable
> might be used uninitialized. This is a false positive because the only
> code path that could lead to uninitialized access is where getaddrinfo()
> fails, but the local xgetaddrinfo() wrapper exits if such a failure
> occurs.
> 
> Initialize the 'sock' variable anyway to allow the tools to build with
> gcc 12.

Thank you for the patch and the review!

I just applied this patch in our tree (feat. for net-next but maybe it
could go in 'fix for -net' with a 'Fixes' tag, no?) with Paolo's ACK:

New patches for t/upstream:
- 5a3689ec11a3: selftests: mptcp: Initialize variables to quiet gcc 12
warnings
- Results: 8346c4604d29..cbb1cc653035 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220622T211129
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
