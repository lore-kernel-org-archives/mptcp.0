Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BA70
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 18:35:38 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id b17so20586904ede.0
        for <mptcp@lists.linux.dev>; Thu, 20 May 2021 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rGIUE/MYVVOhd1V/Kk6GDBiTPeviUsRX5NUfyYo4Lw=;
        b=RsM0YFw65bentRI676ihuvoFZ3+zrv/uN+Yykovvkox0U+anjeh9SGIWqa9M1PnIgp
         6Gzezuc0vKmGldDz+XJxae07/Wb9WIy6y8oAxSKUeBVnWl3B+OH92XuWQJ6Mk4JnhE4j
         t/fALGfTjyqeDt7OP8T1g/TDKzTOGobZ8li1x8yelbUV1jxXUcp61fWkHFvjLwuzodqK
         z79wHZBAKTWRPE9iht2hh8nXAUcRNw5AkppGbYMFoax2pSqgWN4z9FLH2HbwfdGCjhZi
         M/TJQ8DNXOAsFG+1J5HDnQPlHo1UAaRDB+/fSlfcl65Q5A0bc/8/0dZYvK+prLHriz2l
         cXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rGIUE/MYVVOhd1V/Kk6GDBiTPeviUsRX5NUfyYo4Lw=;
        b=Lxr5wlYV7e3yS8WKLa5VRbyqKfOmQ7Y1HWvRfeTIyJHljDhq7AG1RO04j802hddGd0
         SKHO9aarPYYmGdXyH7nJqb4iF+eMYdcArkS9i0qAysIzvN0DtkaTVoDbUrTiQH3748zc
         EVI/MjLlt0PxHT31BJgyQmXBM5COwdsXphi78qrLSS7JQQaeTfQchgF32TpWrtCmhf5T
         7nNojfT1D5mqsV3192gQyhhYLyiXJHtE+eGOLeuWF/uyqv0+KolnCvCgLOF7ikluwRgQ
         FN4WPNdakgD8DhOhOF9sjTqcljNLoGmCJFG0pTKuffDLdKMro5Mi981ILoMNjuT1EmMx
         TXSg==
X-Gm-Message-State: AOAM5311ilhNDJ0CniqK9zaIDq2GluyVW0znxGy1GX7R9nd0ohb9uK80
	FRN52JcPDtIv45GDFSiynqU6+A==
X-Google-Smtp-Source: ABdhPJyv7UixgPOBbPk46lvf3OXbSnJKo+mCFxgmY2UmYjJyTF4cE4ClTimMdme38js54F2Jt+pOZQ==
X-Received: by 2002:a05:6402:42cc:: with SMTP id i12mr6654458edc.272.1621535737113;
        Thu, 20 May 2021 11:35:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c9db:d048:1d4c:cd82])
        by smtp.gmail.com with ESMTPSA id o21sm1832601ejh.57.2021.05.20.11.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 11:35:36 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: avoid error message on infinite mapping
To: Paolo Abeni <pabeni@redhat.com>
References: <3254d58a6dabd03533816388bd6dcb04f8078e6a.1621358167.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <85349f95-c351-b1b0-ae64-27cc7e7ec8be@tessares.net>
Date: Thu, 20 May 2021 20:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3254d58a6dabd03533816388bd6dcb04f8078e6a.1621358167.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 18/05/2021 19:16, Paolo Abeni wrote:
> Another left-over. Avoid flooding dmesg with useless text,
> we already have a MIB for that event.
> 
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

- f3d3cf12ada2: mptcp: avoid error message on infinite mapping
- Results: f7c7d5a50852..bffd86183cb5

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210520T183513
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210520T183513

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
