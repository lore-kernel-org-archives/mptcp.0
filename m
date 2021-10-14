Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADD2C80
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 18:20:16 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id t16so27684239eds.9
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Dx7lo8NS1XI+yBCgaADdj79HkAlwyjhmhTU42NvxSrg=;
        b=ROci52+7Vs+257AyMGpk1psblUJpSEML8/aTcdSYzF72iRp9VXCj8Te6SPDN/1znvh
         dsR34S7Q6+Qxwow7Cx5VzxOMGhRPzjkGVC2CnQy1AZtww9+arGIo52LYXNvXLQWY1d+m
         57GmKUXc3FFfZL63xWQCwUctqzRqNg66vlkfPf0nd749PyJ0M+kDSzhA2QuxJBoPRwXA
         dy5OYLh68EIwH0ycQdgbUaQj4Kyd8yxVLMB2zzYAWuP+7R5P6n9KyIKI+NVyren291hF
         ofkhSKgk48WuRKLPFudejlGqJvv96w58p2TgNTa93lkdsBJtCMIHXdCry/+aVCIoZ3wh
         NcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Dx7lo8NS1XI+yBCgaADdj79HkAlwyjhmhTU42NvxSrg=;
        b=6V46qLqDwM9C/66Ud5tjFnNj5SNK9I+ZLqyOUXdxx+CINbR/f/ND/Q2sfOY0U8I+IV
         /EhXlvXQVmbc25nv5zQy5bFL9+h1wAj5F3KTLURIm4prpOY346sDAH2whwsrQjP0Wkgx
         C8nEk10u3NAjeS0xQ0c0OxXysWoWoKBq0HAHUErNqXqQ+elamMyl0WPtpZqvCX+BT1b0
         coO06+ANG2jU20AeSMmr8OciyLPOOo7DG6MmR567bqZNjKYS3aANQShSyi8uCiVPejGq
         0KpfYwHTLPLcJYqUxj9dqlSuZmOlrhf4x12GaKAxqPf6xEPWZzXsD7BE3Ofbw+5+qRhv
         Aj5w==
X-Gm-Message-State: AOAM532SvMytZa5TnWQsoR3FBsTSZR0uSJ5iC6xmzHcGJ5i1BeFQJmS4
	ZjFwkGJRsuUe1BcjjhU4D6zVwQTginR9bQ==
X-Google-Smtp-Source: ABdhPJw6v//NV70bL/7Fsr/SyeevrbkiD+n2c9sjBFPzUfme7S1wLwqVHYuP8KKr7cA7Ld6Sp9m3lg==
X-Received: by 2002:aa7:cb10:: with SMTP id s16mr11397202edt.311.1634235614629;
        Thu, 14 Oct 2021 11:20:14 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id z18sm2445113ejl.67.2021.10.14.11.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:20:14 -0700 (PDT)
Message-ID: <b26740d0-b49e-007c-1c9d-e980eb3ea12f@tessares.net>
Date: Thu, 14 Oct 2021 20:20:10 +0200
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
References: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/10/2021 02:06, Mat Martineau wrote:
> This function is only used within pm_netlink.c now.

Thank you for your patch!

Now in our tree (for net-next) with the Fixes tag and my RvB one:

- 7f101302f759: mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static

- Results: 944d8c159e22..ca8552485b9e

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211014T181928

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211014T181928

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
