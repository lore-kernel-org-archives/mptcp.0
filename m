Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312370;
	b=FTXCjON/G4Puf2TJ2pl07JS0ee7gUs2JBsGC1RcfWHWoGCibP3at4oMeSfEkDm7sPkpD
	 zjiOSG9svgLNGUKb8IRt6QHDJZR62pgCf8m0z4qMiKjJrmjoP/7elZrtKlSrQJw8Vtmwr
	 FE9j8p9/Ods46PHTO/QCWSrQzpaD7E1Th+j4M4VJ1OWekggX8KQ7mruUdqIMt/vZB6zjR
	 Oxznv50IskVlpTU3T85wbGeSNdFhw66BLm1saWSHz77bY5+V4Opj9n+vzbQD9Tna+0qCj
	 wN5pCBkUMb6WfOaMlXQsBPq8rqUzu4MveD2l5EUwoqUsnCvyTdVWkv0mzWhWkX7XGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=uWkl38cEsjca5p5sKhmOllQhO1+XF69pwmXQcxf/lwE=;
	b=41hNoC0iLQKhZNRDKSctcf2bdGypezr7/GtU0pYK8sC+Jb8lRJwG6SIwWHSUOKsCTyY7
	 3dd0i+PX4BbiLRKthJR1eA/wOw6ulV7VZm2pPm/mvDvkTJ4H+KEvfBXz2PVjQCrQVrryE
	 9RMNtZEYa5eE89PrhoE6OjYnSaTzlr+IUvjsUTaz+cirq3JETy3ehLM5b+RMM4HiVqAtB
	 pUtKJE9jVkSwGWEYZPGkv4LGZCPpnR4SGWu/SEu4FDjwJdgWlTXrJqbNyURcGFUfIZcBk
	 cCRoNXjENDOrigMiY48KymyT0kvOUjSAGhpAEVuRSjHX2QsYfQ/16LBpu+yTMkIo4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ugPvA/B0";
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4398606A31C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 12:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4398606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugPvA/B0
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b305e10ac7so19309097b3.0
        for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312368; x=1794917168; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uWkl38cEsjca5p5sKhmOllQhO1+XF69pwmXQcxf/lwE=;
        b=ugPvA/B0vf7Cu+Fi/TRgIGF9y9ItX+rczqwe1drDBM1AutO/aGF1exRQ4srliIYStP
         XiSjHKdP8koRsK28kUKiuxg5eQ84PcxkXpv3mzS5VaLyDytU8cWUZT7d33ImRSB6NrKE
         KLRtpKSItWUTo0DH07SNbMMGhPFwtto+b52Q0QBAk21Yn+Wu/acHp88OmkktqrNBbSxM
         h1Wh9xe3oDE0nUGxQ/AI3rXh4/jymAXp0Fv53ZcaiuX6D054xICKbxsqraWMsFzhRS+j
         JCjoFUCgUcTNgegRyP5ZkavnnjRUMYz3bk+0hMVtNBGbQ5zkLVI7bMMxZ6TwY5Wf2SLD
         qAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312368; x=1794917168;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWkl38cEsjca5p5sKhmOllQhO1+XF69pwmXQcxf/lwE=;
        b=HQFnlpOukkHzNoftQWqM8uAJMGSEV9q9NHV5XJXo0TM8V4PdXykDX/wG8W1GPku7pm
         GdXCCtYkcTWmd0C+Rt51Cidlpax4ZJxYe1HU70HngxPGlRK9wA5sOwI0tgndGC6vcmkI
         0UH934RVz57aVHKAllccmTHYRDORpEgjeHqtD+l4khyVkkPls8XCuOISPdCvJy1uH9MX
         ba7halG0V850+LRfpbFuadOZQn87EZfmyrze9jQ+4gKpa4pcwBEPioW5hpY5ndVPBRT7
         r3J6Q0DmF5g2cFp4wZMYtN6fEDlK1iDFnGQf5IxHjX+X38crrzZ9oHhux+Z3hHdv1wpK
         jVyA==
X-Gm-Message-State: APuU4Z/qA6G2RuMl0TRq7FJ+Fn4yhJ+Ulfr5xgwdooVraCEj9mgrCG8Q
	NMKoChu/Sg9jbJd/uy1+iIoaxVquupMniMYQ/AqvX387NHciQ7VSXr5BchYf
X-Gm-Gg: AYBFou1ANI87YMK+fkfZeYMgB3VaNVdYjhI9V2+gy4juPmFsJl/QJpuLG+YWxDveNUY
	kyyzvHbhSHnTo/jX2X6d6GvDKk0yGccau29OKqVQAeJ1RHHMrJq9iiGfKgvAnyjE3D4lBtvMH8u
	G/LsqlDhUxIBc//c1bqgs3nBPSyfe+G4LbVj852Omu9a8/E6rtB0NSez/4H4nFp5dAyfQuQDitb
	I8YHRc9Lg6VrI/erEnjEzM/fxBm9XrjUZLYXbltHuYSOqZHBZ7XrAcGuBPrgY3oOZwP1mtc60By
	6kdUMR0YH4VPmic8ET+6naruupaHUIe6K/DWODgLL0iCpl+h/pUV0JUGmFhcAxcQ7u9mUmkj6Cs
	uQVq+B8ylr4WWOKwxywVlUCgG20+BQ/xrqPjt7iLrTIcNRRm6/jnEGbfdoXnyKiP6hduiGnPtz/
	gUNxttK+oG+YGCai5llpBV2fhKbLzC9d0PvHmNEot5IkBe0B/aHoLj1wiLDW84xKK8T39ghQaPn
	xU0aphDzZ9ER4sRuAKi8EE65HPz75iV1LpdkPWnPAYxmlRQ9DYP7iw4Z+2dM0OcLXQhMG49+mls
	xj0hpuEXLv9Ea3jjZPoXNMSgzoamXN66owGHvfqr/rQ=
X-Received: by 2002:a05:690c:c142:b0:8a8:6fac:1525 with SMTP id 00721157ae682-8b392b7e93dmr15532597b3.46.1794312368279;
        Tue, 10 Nov 2026 04:06:08 -0800 (PST)
Received: from github.com ([134.138.53.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bf79sm17715987b3.2.2026.11.10.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:06:07 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v25 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <e12926d2-2420-e92b-1f69-17ed1b051790@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:06:07 +0000
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
et-next/actions/runs/42799457969

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2aedf58162=
f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1207103


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
