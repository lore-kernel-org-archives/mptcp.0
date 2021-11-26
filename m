Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41A72
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 17:06:32 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id y13so41351555edd.13
        for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rl8hbcMgcTvjVhbDa+J0Q0u82SlDpxg3HXjolxZEJHk=;
        b=pZuKswT3r7r9kQ304dLgQ0Xeaqc32MTmy/QBCP3AxnG+1i6UZD/N8/ZB9nTO7Kpibl
         dXBV/BrboEnKzYOISIzN31Y9txBflhcHDydz0gRWn/B2k5EDelYwDaG6fgpH1SSlETk6
         v4tHaDGm9GAqfCFRMwAJrYKs0xPHi1KwZiffq4uNPWMp595e2ut3WUPmun3O6m+QPso7
         L/b6UN0zpvcgPSWMVdgs+/1gjaGW3RLV3MhCUcIBXjjEHVZL99sY7DmIm7As14RlnX58
         lQwutwJzmq4ZHaRE4jP4J5YuAm3DfIOpRPmrYKziQppipzA/ef9KaKUTCzqCleo4tua8
         sqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rl8hbcMgcTvjVhbDa+J0Q0u82SlDpxg3HXjolxZEJHk=;
        b=HCMrPyKJCDH4F8znPEaI8XwP/quTgYruL0TpWtTJ9qczodhKC/UhOCaEIVHGRFvA7A
         +LLaxu/VGh1FUOAQh223mmnTeA0cHjtbe+eVa3fNHhEAzmf+HaWQZYVumj5yARzxjFrO
         eXefPYzZGkELGSlgWjVYVcdKEX3qIX3ThUD4Kob7ehbN8n/V0tdE160umfZ7s82zRsUc
         Ezo/gjRkYFddFG3gd0QZ5q1eEREMK9sItBIIYo2LhLouXRD/hq1Aeg1O7tjz/gk1UDUv
         VZz0vkyu5O54ihue6XiXql0RyHMZtGZXjJqavPFIK8rKjpjwJsH0DLPAlaFDb4cSpYiz
         N/PQ==
X-Gm-Message-State: AOAM5320Tp7ZpIfvoSK7EsNauq4EFKuuIU770rmEWKwxjWbB+79dM+Aj
	X9il3zIWTsNXbckOsb+dCQzMk1+WetKNsye/ENE=
X-Google-Smtp-Source: ABdhPJxGPMakVqu1TV9fdYYQR7cBz9CCCkvfcPDeW/f6KbGcCVKNeamDYrwdptsxRKvfjowb/apliA==
X-Received: by 2002:a17:907:1c81:: with SMTP id nb1mr40064228ejc.9.1637946390630;
        Fri, 26 Nov 2021 09:06:30 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id aq14sm3417375ejc.23.2021.11.26.09.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:06:30 -0800 (PST)
Message-ID: <5b578aca-8788-2962-a98e-33f45635c97b@tessares.net>
Date: Fri, 26 Nov 2021 18:06:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH iproute2-next] mptcp: add support for changing the backup
 flag
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
References: <c63ef7fb7a391f88af7ded03c1e0cb21e38472f0.1637918976.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c63ef7fb7a391f88af7ded03c1e0cb21e38472f0.1637918976.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 26/11/2021 10:38, Davide Caratti wrote:
> allow setting / clearing the 'backup' bit on existing endpoints.

Thank you for the patch!

Do you mind adding a bit more context in the commit message here? e.g.
the kernel support "MPTCP_PM_CMD_SET_FLAGS" since v5.x, so let's add the
support here for userspace (...) before, we were able to mark an
endpoint as backup but not to change this backup attribute later (...)

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/158

Ideally, we would need a new packetdrill test to close this ticket but
maybe you already have one?

Also, because this commit will not be applied in our "export" branch, it
will not close the ticket automatically. Maybe you can use 'Link:' tag
instead when sending it upstream?

(...)

> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 22335b6129ae..6e7f8269a4f8 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8

(...)

> @@ -118,7 +132,7 @@ the endpoint will be announced as a backup address, if this is a
>  .BR signal
>  endpoint, or the subflow will be created as a backup one if this is a
>  .BR subflow
> -endpoint
> +endpoint.

Small detail: best to avoid this modification as this will conflict with
Paolo's patch he sent a few hours ago to netdev.

For the rest, it looks good to me, thank you!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
