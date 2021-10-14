Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AE2C81
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 12:01:15 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id d3so23158229edp.3
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2v8rhrqbQ/sAwbZgxYxBE0gTrlqNxbrAuOhVrLRiIro=;
        b=N2r6DONP/OaBWw3jyXzPDQKfYhSjMjf5my85G57PhsE7CwR9pOH+e97RpkXE61iGmD
         0dfc97LL5hRtnZMupg85VkLIsVFpRiWKCh3FFrjbWORvrfp6vcBRYegfu1oZJmtIRQNG
         AfeNOpxnX3arcE6/3ergwMcd9twpmDG4BaHZqgZM3vUgY7iPR2szTJh3K8WWbNAaLyJn
         m8ZnvGAN+7NYZp5IXD2ZuKS8ntgclwPyXupMxJysP85bl8Gra3vV3HsshWjwU3yrhX9R
         AHmxcZKd9fPXlw1FhaMorwsQDC4MFsipz4uhCrvdclf2YZLvzaXolnYhIb7K3Fyh6LP1
         Hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2v8rhrqbQ/sAwbZgxYxBE0gTrlqNxbrAuOhVrLRiIro=;
        b=L4ymbT3B5FExsTITPifntwPoQl4ZxAUzkPO7+T9TjcDrd+SNeBgOrIx3aEVP+62My+
         oSUzUgdsmvsZiYNTLWMxSS2yIHZ1SkN+txadXdDobuvp9QKCpv3o8K5aOdE4M6rC00CW
         r0yeamUHYbHInjy3C3LJM6Lwg8NTixF0T4dNuHDX6/KFZYIBpyJV0cU3f77tfS7Y65hk
         GFQKvaTMSlwMjD1dQKbghiJad7eE+Kx30+ddFDaJ2vOGqcg7AF67bs7I3hcA6XmaBtEZ
         GjykmfwxZZly4fI9WJd05Icq2zf6GoM/GDprIGqha7xhCClns82DNmpz9WPEySl4TKWM
         AQCw==
X-Gm-Message-State: AOAM531sFIRZmFbGPfQoVRQjTg+pYPDrQ150eL+TCkpEVD9iU8Um8jvx
	fyyHSePKZyci8iLTe1iDiGgUVA==
X-Google-Smtp-Source: ABdhPJxslydKtM5HSYirwbTtAMfZFNgA5wD8ODnjPs3SFC1YIebBilJF2KD8dlcfvFnozNjRjVsNvg==
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr3283514ejo.283.1634212868878;
        Thu, 14 Oct 2021 05:01:08 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id v13sm2370395edl.69.2021.10.14.05.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:01:08 -0700 (PDT)
Message-ID: <9a5aa1d0-a6f9-8eb4-e919-86856f2f03f5@tessares.net>
Date: Thu, 14 Oct 2021 14:01:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack()
 static
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
 <4dd88f75-1671-69d1-fc85-ef7c18391273@tessares.net>
 <d40a139-9f3b-974d-31f-faa28099c527@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d40a139-9f3b-974d-31f-faa28099c527@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/10/2021 17:04, Mat Martineau wrote:
> On Thu, 7 Oct 2021, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 07/10/2021 02:06, Mat Martineau wrote:
>>> This function is only used within pm_netlink.c now.
>>
>> Good catch, thank you for the patch!
>>
>> Do you think we need a "Fixes" tag? It looks like it has never been used
>> outside pm_netlink.c.
>>
>> But maybe we don't want a "Fixes" tag because we don't want such patch
>> to be backported to stable? Or maybe we want to minimise the differences
>> by backporting "not risky" patches and ease future backports?
>>
> 
> I hadn't included the Fixes tag for these reasons :)
> 
> I think it's better to leave it off, as it's such a minor thing.

From what I got from "stable" maintainers, it looks like we should add
the "Fixes" tag when something is fixed -- i.e. for all patches except
for new features and related refactoring patches -- and they take the
decision if backporting a patch would make sense for them or not.

Do you mind if I add the "Fixes" tag and put the commit in the "net"
section?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
