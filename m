Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218256FA1
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 09:19:06 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fa08687246so1943219e87.1
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687771144; x=1690363144;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G06KmZ2IiN2WSv5AvyJkD2yZSyrWJoHbjqKDiZgLJes=;
        b=wUVgZzP/STESOTpRWQ2bchg4SIB6Ya0YIchXExpBsvU4UgFS3dcc2m4XezZEbIHoD3
         U3R7AuZGhOpwbU/LmglSV9CKLD+tsqsguOt/SXS1TP1tZVjziW032qx5mYJOpsDwfSKx
         cSWaeVIA5RGIpPGO4zUHbboD028RqXUY8+Z3CXk2kOukhx+E0e4q7Ao+XeUdYqsnzSJr
         za0sqzi053ceYGoEsZwk8bVSaZUpVhOOUYQrJ1QdRwVnDb0KObDEykN9Sqy7Y0WoMLnm
         coq0wX1h8weIGuV7FsSCkY9GaMBppJ4K9XUatP695NiqRrpZMeeR4saOW9SZgMYzG1lr
         3a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687771144; x=1690363144;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G06KmZ2IiN2WSv5AvyJkD2yZSyrWJoHbjqKDiZgLJes=;
        b=Ktl7IZtQTZZylJFrm3+cZOe795VQMABlp3Km6SiG9rXcMH4ZN04eSCUASb1vmBIkks
         QIqYGU8IW1HfOuUE0wO8efGK8IhDnv3pw0XzlQAlsHuGyHUyCIJYGbcuJh8UI5rgSqXd
         9kpcHZB2vcY6yqurm0wsy/XYPe5iCN+4go2zmOGzAn8o8ak+MzK98ZszkWH+BbAkAPVS
         uAr7almA5EcMOcocNHQjs32GX/vWPcjjBguEXUwvi0ePN0VuyXHoUfDluIn71ZYn5uGX
         L8zcICDCKtz9XunrCt2D0IfjOoospe6hYTQFPC7jTxKEcpMSRCvw8VIz9gU/dMeuk9fK
         99NQ==
X-Gm-Message-State: AC+VfDzdDZ1xLG04iR80e8RWwhB+YL5c2zzOB2ANZGYoXFgWGsnJMOnQ
	SN0vvgI2Kspz27orfuY/Imlmyt/7igiTDlp1zMvfRg==
X-Google-Smtp-Source: ACHHUZ4jiHiQxpsPvYvG3P4Fbv3W+aAgEokji/DhTPLdHmJcmXb1Ue+lE/7Rchm842eJjRJm0SUPQg==
X-Received: by 2002:a19:e046:0:b0:4f9:24b6:6695 with SMTP id g6-20020a19e046000000b004f924b66695mr9818047lfj.29.1687771144434;
        Mon, 26 Jun 2023 02:19:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b0031134bcdacdsm6777929wry.42.2023.06.26.02.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:19:04 -0700 (PDT)
Message-ID: <70d9b6ff-2889-b3f3-e609-ab35375cf7d7@tessares.net>
Date: Mon, 26 Jun 2023 11:19:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Squash to "selftests/bpf: Add bpf_red scheduler": Tests Results
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
 <539412bf-fcc5-a39e-4b95-d4f9895d9d7a@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <539412bf-fcc5-a39e-4b95-d4f9895d9d7a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 26/06/2023 05:07, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Script error! ❓:
>   - Task: https://cirrus-ci.com/task/6610932755857408

Please note that these errors are due to issues in net-next:

https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/

I just applied a fix in our tree. I also asked Patchew to re-apply the
patches on top of the latest export branch but I don't think if this
will work.


Please also note that the "Build Failure" email you also got is *not*
linked to these errors, they are likely linked to the modifications you did.

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5373236226

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
