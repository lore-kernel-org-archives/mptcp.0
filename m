Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBD2F23
	for <mptcp@lists.linux.dev>; Wed,  2 Feb 2022 19:36:02 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id u18so680808edt.6
        for <mptcp@lists.linux.dev>; Wed, 02 Feb 2022 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=P7iTmrqBb4POfFAf7zDh7t3R3U3gnanupDqTnIms9e4=;
        b=cnXu36ddIiVFR9PVQNj1Kcng9pvJRyWxxI7x05uczr6YkDxjpihZ16G5JZjpcdrgDe
         xQPLNnu4olMpCMeiK16RD3IwKJ70kxOUsj/Q8PkaQK1nXyAlQjmBaN/4r3fr/pJKGq0g
         eo/hTnQ/IH1mGliKhybSPShneU1hDN0z20oknp60e3JRNOPr7UKDXlOEXb8PC8oLlIw4
         L7UgeaVtwDcV6RzutaN8WElQ7T8S2QXdTmxgRDyEDEXeCwZlJGH6RjTtYChw4vRiZtKG
         lni2JXDg7Bk/dkLq/UNPXxa2HJsOzRv8Pw5BKi01tXHWhXo+Ic7oVzljjGz9HgmCMZ08
         nbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P7iTmrqBb4POfFAf7zDh7t3R3U3gnanupDqTnIms9e4=;
        b=QZwvdszO+ho+QGQ1HgXJWn2CZw03vKBu0maRGoC1yUBvmq4I+ggSGxDdHJ79o8WBrQ
         LJvXKNzoVuzVfAwYzi3/EJ8OCkIHdGQFR5ps8dwMiw0i3zW05W4A/eqsqvItJNSpajiV
         Jao6841IEFPdgdj7lTWfNQaLlFWJMY6gqf4AD76RSgZmokIozfqqpI8xLP+I5h7Q8Wcl
         3C9CFBSp8QlscfFn2j9czk6D7ewLDu1/dwX8ULR4n9C992Ii7GuJV+N/9An0785W/jMB
         6EOfXRvSHYbFElI3cqfhduyv7XOXib3KafDAY9irKinu/3fLrZmANl3V9dv8/IEfXOiE
         F6KQ==
X-Gm-Message-State: AOAM5332nzIdrdzvjZNL5e+t0NCfvxTQoLCP3TfPl/kfeSf5nedTXlQd
	1iTAxfernLaQxWMgYX1Q1KcSOw==
X-Google-Smtp-Source: ABdhPJwn7ZPGZYzVAPInOqkkLYaK2Rn89sH8CJ+i1PwK0py1gG55Nfr3dcxHTR6bH56y3UfUO/WCvQ==
X-Received: by 2002:aa7:d650:: with SMTP id v16mr10420346edr.444.1643830560755;
        Wed, 02 Feb 2022 11:36:00 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:5db:f62e:497e:a0fe? ([2a02:578:8593:1200:5db:f62e:497e:a0fe])
        by smtp.gmail.com with ESMTPSA id l3sm15860970ejg.44.2022.02.02.11.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 11:36:00 -0800 (PST)
Message-ID: <9455130a-c843-debe-ef6b-354e2815c7dd@tessares.net>
Date: Wed, 2 Feb 2022 20:35:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix diag instability
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for looking at that!

On 02/02/2022 19:15, Paolo Abeni wrote:
> Increase the time waiting for mptcp sockets to get established,
> to cope with very slow running host, or high jitter caused by
> VMs.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> note: just to trigger the public CI, probably a better commit
> message needed

I was not able to reproduce the issue #248 on my side after 650+
attempts with a non debug kernel. I tried with that mode because the
public CI mostly have issues with this test without the debug.

But at the end, I managed to reproduce it with the debug kernel without
your patch. Trying your patch  in a loop on my side.

> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 2674ba20d524..baafd36c3e0e 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -87,9 +87,9 @@ chk_msk_nr 0 "no msk on netns creation"
>  echo "b" | \
>  	timeout ${timeout_test} \
>  		ip netns exec $ns \
> -			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
> +			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
>  				127.0.0.1 >/dev/null &
> -sleep 0.1
> +sleep 0.4

I guess the ideal solution is to wait for the connection to be
established -- e.g. by monitoring /proc/net/tcp* like we do in
mptcp_connect.sh -- before checking stats, no?
But probably enough like that?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
