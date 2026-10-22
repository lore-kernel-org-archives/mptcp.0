Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672400;
	b=29k2TWE6uWCUrpuyaxkYOTb+sgz8/RC6U+3hAckDHpJDy2md6wjz+hta0L7I05P/7EA0
	 G6aK6Mv3pUQsHFnmH6YOYq7jUy4D8ThOko5pJDZZvEYoIJKzqZIzYZ/u/Shs1aar2e2Eq
	 mlF0cpKzoRve5BT2QxQQayr1mZHTGtR6F97nvc/C/ElumUx26v7q/zH4jyEdW/T1KZYPZ
	 ux8eGtDd7vpTHhjz5pw9j4FUNn4yZS6lhmr5Ul6M8MLCFgY/ViVDYATGTj2o0HavpqGld
	 NBFzg0sMR+OCVhRnIMVGonTqHXLfevw2baTwfQ3KONYXzq4VxRSq4aYvsJ0bAy1CFGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Pn+37wtqwJ44p31u+eICwRO6Qpm0kmPKnDVDCIwM5+c=;
	b=ahMvbhyX2nr8j+kM9J10cRfUPZ3MWuX7WOEqKsK0uknxMfubZvwAFpCxJpxNcX8pkhok
	 Q6bA+TE3AMrUsNVWZkm8l3QU2dC/7h0IqCgYd/E/t2u4/WXDpIsFNAzV0RgeU60QREQX4
	 9CyRZ1UFyMAo6AH27Nr/WxvySOrD524ENADRmk7gDqqUD5RvuuxiAORRTwt664Z2BE2gv
	 4jmwubE6xZczKneQLLdh2QpkoOhm3xDQkMF9BlEdX1iCS4fOrspu60iJr4fHb2fi/HNe5
	 RuMiqJ7uYrVa93IX5OZntCPko+1yimcMi3ngZVD4CGXmQPo4kD7G/FxSk6u7qSVah/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sWLboVct;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C3606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 12:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7C3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sWLboVct
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a04338c1so15510846d6.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792672398; x=1793277198; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pn+37wtqwJ44p31u+eICwRO6Qpm0kmPKnDVDCIwM5+c=;
        b=sWLboVctRYMsIRyGkehz4nKSXNpy9JbtOgxKAkuJiAZ09v8JeRWR5gH+PX6JeWMpCt
         P0NFDC+lkWE8Ps9Msc6Ewhan785j7Z/8gKnNEFDLLZ8aCZcOv03mpnAUSfAdecjoMBpl
         5D21hSRLyqlJkqn8Gj+ihGdCWR+G92gPOOSseBOhTByfPxFziFdGN2uLvpXQmAgcca+L
         WpxihYLkOndnFzKAAoExD4h9lRPv5YSmfHZByyYPAUMG9PEfDX/Kt4m8IZUSWwvS9ra+
         l0v1EC1yvzL2iUziG9iEZBcVX1sMjNk6rf4IMEih1kKLGbozBpYp/v7P468VkfmJqgPA
         z+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672398; x=1793277198;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pn+37wtqwJ44p31u+eICwRO6Qpm0kmPKnDVDCIwM5+c=;
        b=WjbzncoUduTBmYVIOX2ZFVUJbLECbqbQUsxutg4VTn55MR7F2gMa/8836CnYBTviLU
         TZtHDlNzgRbp/3hrS8ch5ZsbUv9B/tfjkJxitXqORqkVKX9nUYC9TM9qrdEyzXnurczb
         dm59JlJQjZPNWSn875Ygsp6/mJ54Goe6PgVOcPd6Gv6aQl1BjKYIsc9x8zwisVCQIIeY
         dhim7uvr1GK5Lps+mGpnx9IOjXRP4+bpR3YXl9F6aQIfqS7pV6SV9PaCyE3X8JdprjOI
         QzpvkvpasJEfXq65XJi5YbGbGGp21+YpX41AUGqGf51hliOQdsvG+JUoVbQweJHfZUaS
         pJtg==
X-Gm-Message-State: AFq9FYKM+VHdA8Cq2RUIJ5xMgog87eipuDoLGn9w5EnZ3MNL809f/KaX
	/gCVWDQ63JCPdQZLzzJ4rwN5yFUhB2f/+ePEP/DGVbq9OvUCDVCBb7M=
X-Gm-Gg: AYBFou0meBvX8/YFXXQqjwINEqM6HcarhB1J5W+L7qux0N73qiaR+0uauvshViKAzqR
	5mBgUfoQowcA+PE/690cRbTO82F8ZW3KJPu7D1U9n1pcHSfNE7BJFAnpXajr8n6U7AMhHfoAFXB
	comnBjPB4S2gPdP9Gvq6XcxaNdRTY9EEwvy5YwU0kk9e14N4+ORhyDUwXy9qVCagHIFFOtEPBRh
	YeayaaxTgLUw3t3xHzc5Kmfwx6KzFHWpOEzKmH7rKaYXachy+cb7s+JOX3GrHDOruv/khhsVvBQ
	GskdvRyJWXzAGuOTVIz4LXznarjN7ppfbwEHhH6GyTTO/40oJKjcTymcX7jKhAxCiDXqMcGr+HI
	+M/TZl1xrpYH92TM9An9HJON50ljZI4OG3ep1gfsv4655jZ203/40HZpTh5MlVpg/SE9+JbptJ4
	668OQTm0RUiD1hqe7XZhoNv3g819YaEElEuwdPmTkVANz9AQrRnaGxsi2F8AjaJspXiLEAGN/1R
	JGxYGvJwPascDXSZ9TykjKaR9XPPCiMbSqs1GOVnvTPFvpEAzCy3T6lM5iJTiwWCMv4
X-Received: by 2002:ad4:5aaf:0:b0:91b:8aad:79da with SMTP id 6a1803df08f44-91c12ed7f74mr83410286d6.28.1792672398338;
        Thu, 22 Oct 2026 05:33:18 -0700 (PDT)
Received: from github.com ([20.231.101.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a47a0fsm48515616d6.2.2026.10.22.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:33:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org>
References:
 <20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: kernel: c-flag: mark as used
 only when it is
Message-ID: <a70b4bf4-ecb5-eaf3-4cf4-02329cbc7b80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:33:17 +0000
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

Hi Matthieu,

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
et-next/actions/runs/39768741688

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/22c6d04fc1=
69
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1191223


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
