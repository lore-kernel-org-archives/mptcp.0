Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D0503BEE
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064937; cv=none; b=fsx6JvYLQp3lI3ybhB28Jw8U/j7d0CavlFiad10OlheBuPA4ipEoHu6wy3VDqMQoBh/RjjQ1kV6zejSSFKjykhiXQzcktdg+yZmdaPFtLnD7XvaHisd/iGcVRGu6qvD/QEcXBC9rYG2YMKj6ESTTDHSPxwyRDyNP+y9s2FMqq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064937; c=relaxed/simple;
	bh=bGlAx0jBuWvjEXGsd3aAAAKuXufC9cfKhr2m7lU5c4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QWJEUock6pNkiHr6TYm6c6NMnSaKHXhxMsh35FQlSX12KIpYbg0O7Cdo+w8LL30CTGXKYQAXwA6iu5M9LzQ0oDqfM1Y/1/VF36EP+hZZgecU0sKUV8Q+oG2GbQne0irpi/RB1uUJikagaQ8uZ5mgrROppbl4mo82HS8McLsBg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABSwAef3; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABSwAef3"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-833e671ee9fso3793481a34.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792064935; x=1792669735; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+VS7SPXOaRdbsDgWBKP834mtG5wyojXaDQSdJ6FqNeA=;
        b=ABSwAef3ayUXLgQu5R+1NUf86v0YXKWPiOIWexaY9Qr1ojQ2cEE1PGAzCnFXVxzcMu
         UnJrbYbimiU/r5/oapEsR4HcoipJ8VYkRjAviwRCN/33o1BZVZ72wCh8PbuefsXzWEd5
         KKRWCARwMoQBB6hWp8Gw/Gzltt9ECOESce15VwGHXR/eMLy/nz8BiZvHML/NwJGkm6Sf
         mgAb3bac64xSj3rINsaDkGQXrWaDL6RxFHImpDBCP8chW+RSNgTHsMFrbU7QdzC8rE7K
         c4BVtml+QXCOwKzj5nEv/OUBtWazpm/+/5SYmRYOGQ1QQRzBK99tX74L2SD3gdNO/H5y
         o5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064935; x=1792669735;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+VS7SPXOaRdbsDgWBKP834mtG5wyojXaDQSdJ6FqNeA=;
        b=Ae5tCgc3LAeCS+zY6JJhnr3+MXmgbAm62UEEbLuVcc0udcKBEP/Ho2xbLGiyzGDXbt
         AEWSLjet3u/v5sNcbUI9K8rYOq/suvZp+NYc1YEpE7RgEb04CA1/ph2HaXVTAPirpn94
         WuFeL4Qyx3+3gVCqLqpnUf2cihPwxbDNxlpYELv/cR9vLVuk0SudEeeILQx5OyxCvQng
         ablNGjgvqL8z+5Q3r7hAXeQCmClLf8MMeakfg3PqOVI4hv9BTaQ1WqKDyd5fizOwY3nc
         UJ2oYymD5ci5rRZsQo+rjOeAHIruwmGfmQh5cemDRbBLWK2oQk4hSu3qO4pSAwP9UhK5
         pUEg==
X-Gm-Message-State: AFq9FYIpN3o++xx6TNE+svQXHOgNf29gBjVnr3gkhMSRbKbk7PRAGzxd
	S8FQagSeLaOCa0GdvSgIPst11QCaIfKADTbqQ70dQJnV0Vh8B6CpyDyVXFPE
X-Gm-Gg: AYBFou2fyN+r7s1VPgkScwCceVGYtHM+mhCSa6XI7FS8Pd4Y8RrsSt0mdUEHGrRqFVc
	oYKNklaLncI7+oqnmx9/1hGSA6X8IlXfXTm/tm9U6f+YBwrwyhdiIbvfULHSS577dXWD4LiN1Oh
	lmWSZrZTZylQx8kw4JT9t276pwAIl2ZzxGC/vaIbqKa9pso9J20CzfuKF5FSJuHj0iF5l8B0s7y
	losaEd180I4j+Gt16i3ZSvEPA7DWDepXhwTOKeGDK/b7M4wZQaX7/sFC0sqMnq58nQQXNooO38z
	RKxyTC1A6MnCrVxeTbCvEog7SU1gro/TIN5BCV+6S6D8XPRqLn0eYJMPPc2YL21U4Jn9BJ7psfD
	bfUr1TUUYC3ZWZczRMZPD2B4R+xm8F6UktgyFlQRgflZ8W/sfhZ+EN7fZ1hYyZPo1KIorgck8oI
	NoG0mYe1+VVrFZjpcbjVrXoyuJosgG83vwOLAZEs7FXs2btY3bZ5bTrZSwzAsUJ3pB5o3XtE7RI
	G54GUC0+L3J8Q==
X-Received: by 2002:a05:6808:3501:b0:4c4:a240:9c3a with SMTP id 5614622812f47-50c42171c42mr18187844b6e.4.1792064935196;
        Thu, 15 Oct 2026 04:48:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.124.148.106])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-53212386a0csm2180243b6e.13.2026.10.15.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:48:54 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792060837.git.tanggeliang@kylinos.cn>
References: <cover.1792060837.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] add distinct lockdep class for MPTCP
 sockets
Message-ID: <6bedfc41-bf24-f391-47de-b2bdac43c2dc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:48:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

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
et-next/actions/runs/38724382972

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e7a2821a1e=
ae
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186364


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
