Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709213;
	b=zIqJiOteCeWpfKIoFVkWi6Q4sn1baIXLZY0//WYIZZgUkMpn+PHENwuj5RCBVsMS0Jze
	 OVLOY9j+tC0Dkc9Lf2auwJpBI30AL4ZOqdrIQTewLjvPMniuw/3M98Cpq2GOQ1F1YhJW8
	 FzccLcmSDmZh2aYXjKKZFrJJHwCk2N+G9jmwGa2UtFPY0y2/OaGk2vgxWGk0LH3V2PAf5
	 ds754BiBWTirGl0hA6Hw5KzDTiidoxZ2gUy+s+k8zgVnPptbI1YJ39g7ryEU30OqiSIuc
	 TqRGHZFIyPb0qvCB+ZlW4rSUCPBgCCurvtTHPoQuCO85dw8ViA/2ZoUh87UgpIUxczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=0lK1ZvxZYqVmCwiIzWUGooGlT5AzX6d0/TqjwVUaftI=;
	b=dm8R7n0K6TyN52tajQDSkUEM2fOKIv3KSrECtZXMdAVpwD6f/G+S1YO0PT/hfePHLy7P
	 J1W1CxxKsHR76XAj9oT43J4qoVoJtf/RoQ+qvg+NlA0Xq2znH0EpXzyg3V2zkovE56p46
	 QaEewjFKADM83PdGhWzUO3YeLTSuQiMX2QtcRAIMe6jDnJxceTMpTXQE5hFH20ZLnyI0s
	 xsMuAxtKWVLZeADWuXR+PXT4lZQnE2OU/WaneJ4lr6pBSHQVWOikKCr0CZUmufwzJIKur
	 lfZrr9bLhbu+knYnQDSzJ3YT3yo+dPRsG+9BU+rCAmgZBUKi+EMRHI2kc1t9AzRCwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbuafRxv;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380E606A337
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 12:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1380E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbuafRxv
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so32565425ad.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793709212; x=1794314012; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0lK1ZvxZYqVmCwiIzWUGooGlT5AzX6d0/TqjwVUaftI=;
        b=GbuafRxvxspbwSIGC/m02yZmHA0elOjtODz5SvUjCj8LOhaY4ioGUQxRtqs3Zx0O9K
         6pLLQ1GGXjoR31r2YgF638X+pxhZEiVF8SMFjkqZyoJEpOGac76C43uaRA+fV6rVqm7V
         9nsTtP2mkHVGa/YZ/+aUBoygyn/C47tlYgXEpMPZ0CiwaL4pmELEGklC/saJ9OWP17Yy
         mrKlfOfDKh4aD1g69ZJ0cIfakoWP6kFSGNGkwl88ENkrUlsV8y+AkJ7GmQ20SyYXBFEi
         rYXpYT7nBnRprVEoKmRuAdB91hBbEfJJaYmAmLgmnshZmotEtUb+LVNsx8MQKKFdIxsb
         o7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709212; x=1794314012;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lK1ZvxZYqVmCwiIzWUGooGlT5AzX6d0/TqjwVUaftI=;
        b=0K8U0x7e0A0xwz2J5TFZZfK5KoiNQZnT8nIyCDFCZGCNv9Jf0nWyYDSwg/TdKOsaG6
         RXoqozfIbuj/zcfV0p0rKyy48QX2eRpsnMQXWX1E6fHrF5DJBNc+/yBvxzEUT7eW9fbf
         vbBPNOdVR8LUzBMnx2aXh+pxMFO/wpKqZOJ92vNsvffZyyxSOWzO5KFBOaB4m7F7OdWm
         Cgi+R/F2tAh8qWOWb6YLTr0GYcy3ZczG/mRghwa8y0/7JGwpPzVhrwedJN+HVxhtFetC
         IHYKgAqKdFfUB1KC1lNZssch/m0wmg8tV5jTLBIO70r0e/2lg8FstlVhYLuxPMNlR6KF
         p2EA==
X-Gm-Message-State: APuU4Z/9/TraQ+xqSKRqcsZzu74MFQ3RHx1R5eWVpku3BF0uJk5nKIpG
	npDC9SqjTg/ji+Eq6RTLBsrdUzNrhCTNIcE/MBF91QBPyjXEKE5h1+HKz/a1goc=
X-Gm-Gg: AYBFou1trhjfFPtzw/GRxxCDmdF86Spg6HulQ29jxC+OYYu9ahq1UmbfsMoiZ2OWw85
	neXMhzT0pAJVqHiV3MH6F+E6AO46k0R/JwByeG+b1LIXvk7apbk+IagKy4BGDFLrBTPqKMxlOY+
	ymHLO6MKydloaj15w7KYRgAOBy34L+Lz41MzlaQAVKaRMieWbYNg4MvM/dz5plJg4o8XDLDpa6Q
	1wkCEU6tpzSHQo9wy7Zfv6fcDPw2+C1LH37xcOaiKxtFiuS2g2fUCBV/c+UXv1EPS0oqVn7ujLX
	4aOIJW3QrBgG8NBxMFmavckbcN6uB+UE2uGMGy0wrzcG92z/oqnjqDHXdLdLh17K9kmSCohD3m9
	GU2KsMUxiEhS6OxpUk+M4+RDon1gnwrBgeJQS6PQBq5oX5fw9sCZt5qM+o5sJc+Fq46AW8u5/GI
	tOXMCGkAjZwkTSgOJ7iYGfKVvvBgDE/c9uwm36xV6S+30tLMVOcoxvzSQaDz+o8HYEU9HcAP4JM
	oakW8WVXh2XD8v0S8tE78eTJKbzUwUVfB35hpr0ByMJsJ7lHbT2Zk8P68eASfeKCerZQPu4R8+6
	U5iertCqvZBIqF8Q91eyvbjpf6/6InuQkbWtWAgRMqM=
X-Received: by 2002:a17:903:37c7:b0:2e9:6972:54d7 with SMTP id d9443c01a7336-2eb364e19ddmr116325785ad.52.1793709212224;
        Tue, 03 Nov 2026 04:33:32 -0800 (PST)
Received: from github.com ([52.234.40.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f62asm41167185ad.22.2026.11.03.04.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:33:31 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
Subject: Re: [PATCH net v3] tcp: prevent cross-family skb processing after
 disconnect
Message-ID: <5d0e528a-8364-3591-a97c-2ffb5d6a5f07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 12:33:30 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/41624308450

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e83ee2ab78=
33
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1200179


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
