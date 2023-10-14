Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1518648
	for <mptcp@lists.linux.dev>; Sat, 14 Oct 2023 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tessares.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tessares.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares.net header.i=@tessares.net header.b="eTrUm+xj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9bdf5829000so193242966b.0
        for <mptcp@lists.linux.dev>; Sat, 14 Oct 2023 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1697303666; x=1697908466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mdwD2CVtFzo77MZnKx9E8DLybLfBkO8C5FN64IyBcc=;
        b=eTrUm+xjf0jeKD+LRT4FHAn8QM1cQubbFeOECwJViVZik1v4eM5NOay1bRMI7CCWi3
         5K8HuSILeXGhWG1943jZJYfM+7onPbyPcd0ka3DPs/NnOoDKZ4Hmknmj9I5QiYE0FEer
         sAXDHQcRjjwvi1LuvRIf1XF+OIjasGfKVouT3KP+SFKw0yy7t6295zs7qtzpjj/48LVV
         1rK6agPqHSD767qn/mCgEyJhSpY5K/ZVkYuQ+jmjXZ3BQFNJaovXocRs7xgdDto1l1Qa
         iftghGk4nsDU3EDkLPO1bBv0XHs4bt3KTTGgLck9NdXhGtT2c4UNh6QoY+nBGwokw0CB
         abng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697303666; x=1697908466;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mdwD2CVtFzo77MZnKx9E8DLybLfBkO8C5FN64IyBcc=;
        b=lGmO2fKZj0wIwDVmnu5TwCdhuyoX607zmqB1o7IYWAAMrvMLzNYs/aIAOdVcQ9eCIY
         laz5bJab39Zmx9Kb4q19DvN2rsmNlI0hZx7hygTZk4iTFrKLFTsSH8szEd9w+jA04gJr
         5uZnSDbVqzFhFCwcMF4OC9fcyxw19dyK24/szh1Btav0Ibsj4YSm4zmpwwNi8rEI2Gzj
         R/MD4Wottk2Jhhya5LJdqjvhmM1njzBhfdMIdHv7Wk1Slg4ij7+cuU3Z+0k7yC1HPVSy
         5ICPbPIQ7A2oD16Ubdy4DBZmqbv9eSDS7ZsLFhawWEjxtm8ooiCnqSeYgHRplVIu8O+v
         T5IA==
X-Gm-Message-State: AOJu0Ywr9dfGA1MO1lFoVI2JknGAl4N+W6YX03nAMkBFYl8WOWGKQ/dS
	GHT8rVpBl78pdLNtVJ5kHG8D9Q==
X-Google-Smtp-Source: AGHT+IEji88RKEtlR2QwEyXvEgH7fMzDhTLuCHOlo+M+rwsjdl4v7wH6QSf9t1rbbbhl89uuEpJIDQ==
X-Received: by 2002:a17:906:cc0d:b0:9a5:874a:9745 with SMTP id ml13-20020a170906cc0d00b009a5874a9745mr24862686ejb.26.1697303665910;
        Sat, 14 Oct 2023 10:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([194.110.115.72])
        by smtp.gmail.com with ESMTPSA id rh9-20020a17090720e900b009ae54585aebsm1155915ejb.89.2023.10.14.10.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 10:14:25 -0700 (PDT)
Date: Sat, 14 Oct 2023 19:14:25 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Message-ID: <d437d5f7-1a13-461b-8563-4314b9d777f5@tessares.net>
In-Reply-To: <41268eba89466b176262dc6113528af49f051c41.1697301801.git.geliang.tang@suse.com>
References: <41268eba89466b176262dc6113528af49f051c41.1697301801.git.geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: update
 userspace pm test helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d437d5f7-1a13-461b-8563-4314b9d777f5@tessares.net>

Hi Geliang,

14 Oct 2023 18:42:28 Geliang Tang <geliang.tang@suse.com>:

> Fix userspace pm errors reported by CI:
>
> [11:10:11.889] # 112 userspace pm add & remove address
> [11:10:29.692] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:30.294] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 synack=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [ ok ]
> [11:10:30.686] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ack=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:31.263] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:31.653] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:33.644] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_info subflows=
=3D1:1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [ ok ]
> [11:10:35.761] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subflows_total 2:2=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:36.762] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_info add_addr_=
signal=3D1:1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:44.932] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:45.321] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rmsf=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [ ok ]
> [11:10:45.325] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Info: invert
> [11:10:46.405] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_info subflows=
=3D0:0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [ ok ]
> [11:10:48.048] #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subflows_total 1:1=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [fail] got subflows 0:0 expected 1:1
> [11:10:48.052] # Server ns stats
> [11:10:48.310] # TcpPassiveOpens=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0.0
> [11:10:48.315] # TcpInSegs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 118=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.0

Thank you for looking at that!

Do you mind explaining why it is fixing the issue and/or why it was not OK =
before please?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 01480663c102..4803ba1ab42d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3316,7 +3316,7 @@ userspace_pm_rm_addr()
> =C2=A0=C2=A0=C2=A0 tk=3D$(mptcp_lib_evts_get_info token "$evts")
>
> =C2=A0=C2=A0=C2=A0 ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
> -=C2=A0=C2=A0 wait_rm_addr $1 1
> +=C2=A0=C2=A0 wait_rm_addr $1

From what I understand, this will skip the wait: the number of RM_ADDR will=
 always be different than an empty string.

The second argument represents the number of RM_ADDR before sending the com=
mand.

Should it not be 0 issue of 1?

Or better:

=C2=A0 local cnt

=C2=A0 (...)

=C2=A0 cnt=3D$(rm_addr_count ${1})
=C2=A0 ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
=C2=A0 wait_rm_addr $1 "${cnt}"

No?

> }
>
> # $1: ns ; $2: addr ; $3: id
> @@ -3352,7 +3352,7 @@ userspace_pm_rm_sf()
>
> =C2=A0=C2=A0=C2=A0 ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rip $da rport $dp token $tk
> -=C2=A0=C2=A0 wait_rm_sf $1 1
> +=C2=A0=C2=A0 wait_rm_sf $1

Same here, you need to pass a second argument to the function otherwise it =
does nothing. So same as suggested above but with "rm_sf_count" instead.

But I don't know if this will fix the issue.

Cheers,
Matt


> }
>
> userspace_tests()
> --
> 2.35.3

--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
