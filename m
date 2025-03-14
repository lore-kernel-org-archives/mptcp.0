Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D31EF389
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944486; cv=none; b=Tj+X8PQIEab/SAY8NTooGRIDLuiPBLNqbdLHNVKEoCF50uGxXXT+u03Upm6lR+H3hwG8YiQvp3dZjs3qK4kTZIaMeSULqODop7ZBYn6rAjXWz3VBolJJVZD7nm27hoKG05sB84IQNlKkdUWmLMCnuJwFGLCwSOA+pUMWro+1a9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944486; c=relaxed/simple;
	bh=vsPV74bHjFFKgF9PSNyIa/k5Nno6ObGS6QrL0HdfSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhsQ/GxkEiyV8hgqoSMUVG5n+CWACD9m8IGiA92EFi6/RTicDsAzr1gyeCyaOuOK08RApEcpRt6zF9mFxtwq214N+M6wuy4/sqA/cIrEs89nyMxoG1M6NFYDvtJGNyVUNvRL85iGtLJuEploCmSFzQ65IxXant8rO/SB4p8MT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDTI15so; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDTI15so"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
	b=UDTI15so5dozoP1F0OKZpgAeOuICAhE4Bglhn/d1eOyJ4MvuBxzQAlS5YBiOwT4kbUcdLd
	UeEDJQcsy8Mr9jH2EUZ6ZmcvFVb7Ue0gBNpupN9OuCVqLoXRkdz/Ou8JI4hQ1Zmdjk+yqi
	Bmeg1IqpzvWUWJoyoR0I3ntQHjb4sNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ruf0VpRRNB63XOVoL8OoEQ-1; Fri, 14 Mar 2025 05:27:59 -0400
X-MC-Unique: ruf0VpRRNB63XOVoL8OoEQ-1
X-Mimecast-MFC-AGG-ID: ruf0VpRRNB63XOVoL8OoEQ_1741944478
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d01024089so14136715e9.1
        for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944478; x=1742549278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
        b=JsEaV+L0+n7lAHfMY3mDLweiUloMY5pEzgb6H5UkV2VrX9Uco4Rjy0nvxAp9O4T2+T
         Tsc64oMVs+K12fvtQ39aVVu+2xzCJD6ampT9drjgW4r13ebeO1SuVaH4weOjFK87udiw
         /uPgg2c8xOfsxOB9iLwqUGC3K8Mga8e5z8Plk85635zB2CAvjTAAmp96f4stkuVeqzzr
         tTyChQldZOMffH3IXb8dvBvitpu7yHqdAxiyuH6qm+abiJpyvzcyuQQx76kMnYjVw1AC
         tT+2b6Fc1cPG+YyT6o/HMBdD6CY8q9WSjqXHX2I2qnQBKHGf3zP+tD9Br7F7FKo4mhOF
         hzBA==
X-Forwarded-Encrypted: i=1; AJvYcCVvGF/prAdQCp19bLAuQyJ6XjSPv0ZvRqP10Vgyh4Rq1WQq3oHb2nkZk2Mo8Fh54FwXjjFuAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2kWED4qArj27Cs1G9tf5MgNYadoyoEU3/fgu5aZSzVfAgCHE/
	euoPFOiod5ia7Wh1Xe4YCnSnwDSmVWD8Mf/DFDUW8RdtJUPmHCEjF+WJ8WTbw5tiZgsQgYaGBY5
	xr2WVCnpx6lZhC2Aw7YJmVJX+4KP+FLS0FfQGjvuy3NJDvHUu8Xht
X-Gm-Gg: ASbGncuHsNx9Tp7u5FQePeD2i6cSRnnMTpp/L59mvhy7Xmd9G6cyC9yhZbqRDtLGJlr
	yDIc292YtfTJM9/WlkTXAE0roRdVb7/DocvBLit1zeeYXA3oNh9xbdi3Yck6Ckx6mmhaH9T7b4Q
	Y95i8rcwplhPk5+T+dnbMFMaNwrbwIFufnVa3RGgx33By9IPsIbEdvT5kd7a5DbisM0/fEoE+Ju
	888GH99yo3o6/aaSPflItGzdnWz460Afrc1awmm/g6/4xx0p3GZEasued5GLo4NQn4joN37DK7E
	Pwu7MajEkGeUhheOSoJ0zfllmVFrlACj9xkyV+G59/d/wg==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439404f8f.4.1741944478425;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZopK7VodYGavJXVWlDpju0bgDr38GUC5squ/pcPs+slUfrLvt93Hpt7yU6EFnjFbYLAnfw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439386f8f.4.1741944478015;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-24-221.dyn.eolo.it. [146.241.24.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm11754075e9.16.2025.03.14.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:27:57 -0700 (PDT)
Message-ID: <0a205f79-b0b5-4cd6-b237-3c61b61bc806@redhat.com>
Date: Fri, 14 Mar 2025 10:27:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GzhL0V0Ah7MoM1JK1soKxbpO6wl0lOB5ROoOrM1Uo_c_1741944478
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 9:35 AM, Matthieu Baerts (NGI0) wrote:
> After the recent merge between net-next and net, I got some conflicts on
> my side because the merge resolution was different from Stephen's one
> [1] I applied on my side in the MPTCP tree.
> 
> It looks like the code that is now in net-next is using the old way to
> retrieve the local and remote addresses. This patch is now using the new
> way, like what was in Stephen's email [1].
> 
> Also, in get_interface_info(), there were no conflicts in this area,
> because that was new code from 'net', but a small adaptation was needed
> there as well to get the remote address.
> 
> Fixes: 941defcea7e1 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Link: https://lore.kernel.org/20250311115758.17a1d414@canb.auug.org.au [1]
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 7a1026a073681d159202015fc6945e91368863fe..79f07e0510ecc14d3bc2716e14f49f9381bb919f 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -15,18 +15,18 @@ no_sleep=False
>  def _test_v4(cfg) -> None:
>      cfg.require_ipver("4")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> +    cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
>  
>  def _test_v6(cfg) -> None:
>      cfg.require_ipver("6")
>  
> -    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
> -    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
> +    cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
>  
>  def _test_tcp(cfg) -> None:
>      cfg.require_cmd("socat", remote=True)
> @@ -120,7 +120,7 @@ def get_interface_info(cfg) -> None:
>      global remote_ifname
>      global no_sleep
>  
> -    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
> +    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
>      remote_ifname = remote_info.rstrip('\n')
>      if remote_ifname == "":
>          raise KsftFailEx('Can not get remote interface')

Thanks for the very quick turnaround!

It really solves the mess I did.

Exceptionally applying (well) before the 24h grace period to keep the
tree sane.

Thanks!

Paolo

