Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792845579;
	b=aoGeG4NuptBjVQi7jGN+J38QxKqOEWFkL3NsWNZrMNRxE8+ifS9kS8CrWlWc07ExQY1z
	 rmFUyNSLFmmFq/wEeHttHdo90aWEghuItoxh6tB6tGxvH/ImjcUz6WISducP0EqBMJRwM
	 j+lFkewz+AzP4cO87yA3afYoZUIXSOqfg5zjnndVUmm9tPoGeB+0T/BNmdfoD7t2h0LEk
	 UbslkXNRP/XE42pRxYOVJiu6kPO3rlbbOKGGKbpMbDqYaUIVD6kxHBFF/1rX12AcN6OSl
	 82SBU28bvEekD+5owJhaCayhZEi1KMS3jtz8JPMGYXAxkPhJ3chFUCyuPvXOwhR3KtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792845579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=N1aWT4wo6uXwCvg/R46NUcWUD5bDv/xOSVpKOS5IJe8=;
	b=4sprmrd6EEUHCmJkRiHVeXMnyIqQgFbKUGy+B6rLxAq4KneusXvgszmlSZtu6GjZet22
	 JGF4HgfwnqSJG3dVx1yW9DJgGHe0JTr1BrY7uf4OOXwREYNh31prjRTAYPzCncUQaVfX7
	 5RavcxZy7lxJSNU8+KafmdTYZmusui12UnCxgK/urVK5ozYn3ZzlFIJUQ6T7LPYsXEtLp
	 2t6iz0dGrUVIv/GW0KsbQioqDxR8TBnZsebUTC9MbuA6Aj38VSX/UAyD8+YWmYWa7B1U0
	 1Osicu6xuGK6G9SWktpjwJbxZdq5VfleptciLHtIOwmBqtRtsZgL35NK9xecBUROoBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imC5RUmC;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1A606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 12:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imC5RUmC
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2823634eec.1
        for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792845578; x=1793450378; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N1aWT4wo6uXwCvg/R46NUcWUD5bDv/xOSVpKOS5IJe8=;
        b=imC5RUmCSURvZT1ZRK385ZxmhClq1xlX0tXEuf9+dzgCWsMQFXXQFUEF3IcFrA/yXK
         yVOT62ZnbhEebsqOoDxeC7C3QIY7qjPO+Vzlgvr4btTp+6s74AHMzl6j0nN4OIlYcyz2
         rRyJ1c/V6uWV3qJSts5z7D5w/1hdtzXy/aWaRgu2/ZrP3f2HMou8KNc6D7KB54bEiYqF
         YoI/pFx4+uY/Asfm1fNvYSYtQJ3BrFaKRfLuwTQnEZovu8QfAwh3U7rxbRj1lICZ2Ttz
         ANfYGgT6LDe7w3V7CYz+aakt3fSVa3xQ2YdVRJ2+37WlpUkpWuXJx8Lxf8RBHyrbM28e
         umLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792845578; x=1793450378;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1aWT4wo6uXwCvg/R46NUcWUD5bDv/xOSVpKOS5IJe8=;
        b=MShvO25hoK105mOWqYmjP1vFG9M3yqSZ6Rn7gBx1bc4Wwpbk5IZ8wmYXhNM1q3vfy4
         Tu0UpEL0NvdAzL2J2gOn5E9+/JhO8EuMMlrETwFk1c0Ihlb+nz+HRC43nw/RkZLhJwP7
         QC9NPsyjxqvJ2MYXTQB4h+VCMWQ0tHpO/kVvJaeW7zg7J2OVPYHwP1hayjd/uOWfHYFQ
         A3RylR39NbkIS03aTPpGbWMXb4ybYDJddH5GR9h2Q2I5XxCU3F0+UuJ0THhcYD68VCvW
         OaC7C2+8EGdgDYQBMD8pBiP3Vz0nyR7ng8Bbd9Pp/FRbQ5i/0Pv3jZsMgfjGeV4YnmSP
         pWSg==
X-Gm-Message-State: AFq9FYJhmDjkNCH3PakNFXggrbXYQIDH2MvvjNYKmUk6XnjppsLT+lq/
	aoYUCViQjZJwoH/N8MI3jv3m3sJxo5eItPPtSQ+BFWEEKaQkoFT1jPw=
X-Gm-Gg: AYBFou35KMVfM7VwrwVoVnXBPepLnIhHO/hZmXNwr/s6SY3gM2rqfDCEbk9CTUZAugZ
	UlngSvJFRnzujGyqQ+OSUEC/HkMQwlDRCTl4z9grkPh18PbxNXXrVThVDF9GpVTTtlWyQkyVDve
	/SOw4VgDQGO/ArhazZWhryQoGAYbdsNNBf8jlIPP516O2FC34xRw/ETPeAlYzGtn0gG5qQBNSqG
	u4T1S7apJJwoxcpNr6Q5YdOWS3AJgEFBBJ6mgg28jCQny+7LgJPoYWJ68nDXg9qhqt8NvuQbvsc
	BdApI5JoAjqjwewaKnIwrvmqO1tjkt257KjAxjH/T1mX5n4rOI9y67+AvgyQqk1Bo19xWWTZhMo
	Tr7YiEx7nfb0Gd6WyfRCaj3t9A3PlseLUA/Fj8bYaNzAa8rcOFULCgKjOBQ2GEHOJBnq4zLWQIb
	Fv01pjSEbseQpKNagWVlhbC2wSLyp5ryr2m0/s+qmw0o7XKdQQaOr805jenHPSoFN7uhfzPX84x
	05pTlkuK5Zil0ICHkPgu+OtdZZ3A4nQimPJt+PggHgL1uML3UOofQELBmsNLFog6E8IMg==
X-Received: by 2002:a05:7301:e110:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-369e8614733mr2886973eec.23.1792845578435;
        Sat, 24 Oct 2026 05:39:38 -0700 (PDT)
Received: from github.com ([172.182.192.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d95e91sm8431200eec.15.2026.10.24.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:39:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v8 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <5ff10b69-8481-e7ca-cebc-7afb1e55541b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:39:37 +0000
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

Hi Abdul,

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
et-next/actions/runs/40090437207

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1da845cc73=
92
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1192635


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
