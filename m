Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809428FA
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 11:05:30 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id k22so12507937wrd.6
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=etvA2qPpkiUKjzBgUinC7ZKyTnMSFsjF0FN79HyQoJs=;
        b=EmHANwnRLIHASR8t/r/LZWufxebOW2PSyYyneDgccb0HYZ1Jibak8ekDmk+66lnc+g
         4n1ccMqQruYXQfldvZci0/ksAQpGDykFMaQNbrM1+awUkE1wq6Cv8LvkChpXBfjLwCbV
         wYSXaLD5Tbb6SPNQQ2yOoMjZjab3QyDNI2HQ6PJJdpI2wSqL6CfWwhatWdmvBmzRMEAy
         bxnKlhHH0N1T3ZNhocvAGsBKkjf2ERnofVo2dMs3tITFvkZGGTlIIgNxE2z2EjMJffrF
         B36T8qBwtq3lDs3A7awqGqraFgme2X/SqqZ2XqDfPckiXfo/gGNKc5ZutPMl5uytqVhl
         UNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=etvA2qPpkiUKjzBgUinC7ZKyTnMSFsjF0FN79HyQoJs=;
        b=B4rmxiYm9ERv5DMVkpZVecu3q9pSAMT7p4fV5PUTdTTX0kLmOrmXE4kZaSVvVkuemb
         zwjwUAGBU7g3m11Tjow842hz/vwtgdokGfPHDmumo45kYfZ8Wm8ORnsHp3BORwaBVekU
         sllI6A3EuR2TXx3VqamBAjQoMYjOx+JezPeWDcVa8VpE/WayyELaaPPvrQRiV9Aruf9N
         GIKb8gvCnSW3J4r7lOw7zbjdgNL/fZlfh60Oqp8ynqIx5SElWsoxL3rUhrvY5GftZrQL
         XtLUMV6pKyTnOQ7KtoLvZXS/QIrRPuI52vsJr3+wMhC2WbuRjWSA+JTKIq8rBhDWNBiK
         bjig==
X-Gm-Message-State: AJIora8onlS4NupLQtJQTknEMzGHyRH1uKYFS4s8UDnJUh0vAbgKOmKe
	54hmdnHqOiN/B6mM/PaGXwq1Jtgck8Q2luP5
X-Google-Smtp-Source: AGRyM1usd9Azit8CuRUja0iYlRoyPil0iKh2mTmYP54PiSbi/sgyJnksGgqhowhI8bosHT7WuSN1VQ==
X-Received: by 2002:a5d:5088:0:b0:21b:a045:972f with SMTP id a8-20020a5d5088000000b0021ba045972fmr11609433wrt.95.1656327928479;
        Mon, 27 Jun 2022 04:05:28 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k19-20020a7bc413000000b003a02b135747sm12901617wmi.46.2022.06.27.04.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 04:05:28 -0700 (PDT)
Message-ID: <1657466d-5ebe-86a0-6fd1-6e034bf7e9fc@tessares.net>
Date: Mon, 27 Jun 2022 13:05:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mptcp: fix locking in mptcp_nl_cmd_sf_destroy(): Build Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
 <af5e75a6-e0ab-b7f8-f3c0-7444a81896ef@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <af5e75a6-e0ab-b7f8-f3c0-7444a81896ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 27/06/2022 12:06, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2568360433

Mmh, there was no error :-/

I will monitor that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
