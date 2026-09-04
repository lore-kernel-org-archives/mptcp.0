Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42A51C326
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547073; cv=none; b=NHJdynzEiGLKHBToqz2Gk0Q0yobQRSV2qYfMVlk0Rs0/qB3lzv8LGIlpaxLrFTTwPjAJeVnIU+3JAq1jFGZc8fzxYe2oLlpHJwE6n+eV2CKVzpVZjQRVZG7lvymaZ+tyWQroM5jugPX6JvBff+HDNOPf03QK9l83fWu2sQJiiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547073; c=relaxed/simple;
	bh=TQ4n1490RCKrkhHOTSyW5/HY8ZHvQ8HddSTX7aIfSag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgNyFwyiRFX8mKkzklwrCyTzmo9jO2KTq5SBCPbUwXA7vct1Dc+vpdRTjc9wbImMu5vhxbZgQGG8ptqittH4oajVDxCrobAbPRulg4UAkQRuUhFcB1T2GPZSwklqQYFOLn0DMr8qSRcIidTH/SdlzR+KJ8UWrBcomAC6WCy+iBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KAsLFcqM; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KAsLFcqM"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c65d654c23so563850e0c.3
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 11:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788547070; x=1789151870;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S2GxLwSx6EjqP7uQ/lfwQxaK/gh/FTk8wuqSuVhY/wc=;
        b=kw+ON2oV8EjGmCeGquylHEx6Rmj5xd9gcBGDoWxq/LEyPPzk6CPRuECs8d3zTaBILe
         O87Fc3AOG6ycBOIoq5/G/Ys8CsiSa0pZ4wxVxxYPMc4VSVCnkdEEujAmwk5SUEaeE7rP
         pJqDq0RxZZidQPUgOmbKM7UUVw7Ik/BBCEktgQXRjHunEU3EMpDI3PWWB+tD8uA1YOGz
         +OKxEx3vXKohFTIQQUEXcNImP/PTBvyqdz7KhBePA3VJzKCY5AGUEnEFDVoiw32Q+YkR
         a8qaxSBB/w/XSmFZstUTBi+r/ysxInHb22rfFQtMtplM+Y8RdYnSSzF1MFsNEBZy1Odq
         fGuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkkEp1Nh2bRalSpWzVAawltoTD+ZFKMf8hGiLF5YkX0Rpg3FUF6sH3Miji4Xu+9KkafoeXmw==@lists.linux.dev
X-Gm-Message-State: AFuF++nYZBHTkijaECq7/UBnGCQ+Izjqq7La+RTSywPUBa+JImSgGx5O
	0QYtbOy/csvnioLRMyqmSJ01MqcZJ4Bm/xzQBKL5YpvCEeF/yWE32hQ0cP3o9DRCApYRSCPvFVR
	o1JeIsVBJeh+JQ0gRrCAPR2WLkvPH21m1fndWP51d6zrEx3Ts2EWbZ8yjOval1z/0u+3eg0ETsB
	yXuRYZ0m/sXZuIgpdclLyaPhX5mQ20e+nRrrQWL1HGribMlt2qpEtyDxEaDkn2TGDHIHHiM3/Ae
	+VwOKuchchXi34=
X-Gm-Gg: AYBFou3wkp3kn6LvWpO7tTqqwa+vKhCFRvGhOh7sj11KRsIQRhf8xNy+UkCnhict38h
	fFDIzvSZdRWJraL/5qVXdpyNsGO6qhE4h95CUcoWfLvE1nRciRVsXq1iBiEUEBHAsGrPsH5lOUe
	7TNM/alWD6g6M6ecDTTDqL1j0/5KhqljeoM4DDrR2+lcGpk3ZEIB2q1io0DsjcGvxOuJ50raTn3
	EShFjzLy9utV6M/4aSrA2ssU8xNnPHlB2i1dBQmLFQkuXxMm0TnFesshVI+kkpN3SJmeB9L55xT
	I7m/nge7VG7h1NNZihWE6Pimn66ApPhqnDgTqB8+7i4ZnRgr/+P1GGnmh+MDXNIq18UVswFpExm
	rDG1h7na5rkt1l1coXab69yLpiI0YZAQZ+0ITRc6Rqla7uPwgCmqKY51f1r/nYxamFPrJ0Sp5fJ
	7yLI9DUQEHxwX3DR4W9IBOQLmms7S8xbLJL+b54bqr
X-Received: by 2002:a05:6123:2e9:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c7ed3c6dfamr3656204e0c.3.1788547069868;
        Fri, 04 Sep 2026 11:37:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec20f1desm1486535e0c.3.2026.09.04.11.37.49
        for <mptcp@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:37:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so2434575a91.1
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788547069; x=1789151869; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2GxLwSx6EjqP7uQ/lfwQxaK/gh/FTk8wuqSuVhY/wc=;
        b=KAsLFcqMKbbAI5HxMJSqvKmW7vreyb5EzT0HoLOerHV6LHzfgABzUl97QjK0uKeLoF
         n9OzupXUrrGV6DrBfSaQhQwbrPvxLo/+UVwoGOJNn6afi7KQBdL63OMSLUhRGN5jjVm5
         66h7TZQOV4PreYaGObFxdUkDUaR9YEeh0d5tQ=
X-Forwarded-Encrypted: i=1; AKwUvBw593Iry7Dba6Mn1SK8xrV3S8T4mgM825PkNuGGuOVdwA5zLNl5v9LZ9iCRdkj23UldXrKmFg==@lists.linux.dev
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr11035237a91.7.1788547068630;
        Fri, 04 Sep 2026 11:37:48 -0700 (PDT)
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr11035158a91.7.1788547068036;
        Fri, 04 Sep 2026 11:37:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae62a54f6sm5881444a91.1.2026.09.04.11.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:37:47 -0700 (PDT)
Message-ID: <5bd8deed-ea25-42ed-81b4-85afe8d3cf52@broadcom.com>
Date: Fri, 4 Sep 2026 11:37:42 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
 syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com
References: <20260903174016.689839-1-florian.fainelli@broadcom.com>
 <20260903-daily-reply-0002-re-tcp-syn-recv-sock-race-6.12@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260903-daily-reply-0002-re-tcp-syn-recv-sock-race-6.12@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/26 19:52, Sasha Levin wrote:
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Sadly this breaks the build in net/dccp...
> 
Yep my bad, sashiko pointed that out and I just submitted v2 of each 
patches.
-- 
Florian
