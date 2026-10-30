Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337567;
	b=mGRJqvOGr46NbV6lbsZdxUXIA71e5OV9cQGUjtQiElzoTn43AEHsUScarBTAL+po4QbO
	 WJquqh9D/+0Ad6y3DVxTfczYT0dqMdQrHA3Uf6wQQ7BckFGZB9aWkogXwqIFgs04PH7Wq
	 i+xJ+VsexMA8yUkYlqG1eHjRSkEH5Y1Le0E4hk3De1k2kAEnxzjcQ2JzfbBkMH3g3Cp96
	 1LeYwuPaw7St/61u48by/6GbuQj7s0ihbShgkn52iLcl1otZXnDkZg41nx6VQkPbPDwLC
	 KJYCYKwqvfT23uGrP+h5OhJ8MT5+aTIOI/ONTeUQNiRYmG15gkRdSINfKIU2p+qpKVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=m0JddB2XFKmaNGsDl02sy2fbb3RVS2CAYkQXHyArpjQ=;
	b=Y4xod8xG3lI1Yt0E80awBjd+u6ad+v83TALKkYQLLoOXPtk8kWjdjvz9s4uakl4efRtA
	 gxG6/ItA7Fw0PTspPzArvUF3v761ClPRnd3Lxh4ty4dE/nTpiD/gPLWraX7ay2moswI32
	 iJ7reXkx+RCFyNVuEqYp+54gv9JDdVp46yzZgZMQ7C7nkzKYZYkdyJY8Ev2KAqc+3AvqB
	 k165Le7AXDn2IUs8SueHn19NewwDpiW4O/eq1SjItz2atY+QosR7x4XzMgIEei2ytf5Dk
	 ZjEoEkXNIDQ+IjaFE2eH6tVZaorm4Vo4Ob1YOZ6Mq/PjIZAeu1PwCL+fOH/UcYAuZlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKnRJEaX;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8137606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8137606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKnRJEaX
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df7f544919so200070eaf.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793337566; x=1793942366; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m0JddB2XFKmaNGsDl02sy2fbb3RVS2CAYkQXHyArpjQ=;
        b=bKnRJEaXrXgqPK7dmTc0HwZfcbza3Sovwf+z4WasSsDqbn5ZiWVyKioW5OyUov2OhI
         D54d/i2uH029PMcI9I7BzEL/2mamK8pyAUIpyCtEIYzYvi2BfBnhSVMxQXuDox2QxN1M
         DUG5YA9aosbeSkehDtvMoThYZSFQkQCKbXN2BpbfZYfJw2i7AG0vCXm/XwUflHzfFvjN
         vYpF4JUlspjASgGxwYctj/LPjIYqoV1ho4tP+clFEooBZeNudme6sGZCxo7sJmzYnabP
         23WZcUb+0c1XGwUnfjrb/r2bmNijN8O5zeyEXnXBoDynNyvp6kZ7+SS3HUSz+/3X2upT
         SF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793337566; x=1793942366;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0JddB2XFKmaNGsDl02sy2fbb3RVS2CAYkQXHyArpjQ=;
        b=rSHsGw0ymLWltMQ6RPj3FDMigHR5bfoFgppMyjDsroRgrOCXTSH/luro7pmNt32D7D
         jrsiOw8u0rAfb4h6okuTtHc537R6z9+H4YCtuip96BUamY/AovVP7NtyovnuBhwYYZaq
         NOkVnQpxUFCDuRs5uq3p/Yxtc3CBcUNKF/TEZKOsmTJsoJBcNXERuk8Z3KhX9ALpQs3T
         2Xwiil2FRCPXFSXEsa0qLwY+tJSzEamZW5DYIkoxe4A7zB9R6ZgYoEF9myYlHRQnRA23
         4sIzPNHZP5PqWTWM5FyXvPtsUh3bG25czB/WeIJ4tx9tiT0ReZv43zVHGOtct2ulA328
         qHiw==
X-Gm-Message-State: AFq9FYJtiG/wi7V+/Gj606XFsSCE8RN6xM4bF1IALq1OlU4F3t5jcPwm
	Yy2Bw6doMZiegoFQMYldg5c9IqzIfWat3cd6D4my9zHCINaWTccFTnxz6S8m
X-Gm-Gg: AYBFou10aiwqP1ShVLT1FjL0gAmv++lFK5XvHmCO/ilienjBaTo8vKBfe24Q+1Wg8+b
	Extryba+gH9MZvh1Y2q6Q9NYpUxEsQUYLMcFke8UukMaR7pKN3HYjgpDaXtXY8M8MBYsyRBdvH2
	tmGYOIZTxhu2H4LaRNEOJdYL3QhmpVA0wFRwpR21r+Csl91EMcHoKdoP2P0HGsSjE9nLIDIEfFj
	QSwvDYLTlqWEvLRXQl+5LJSODOKIl28EfRqWK5uun6YMIEr3psnzuRqyezxbXePFlE+o37Phjol
	pxWKpRgujQri6JmfVp5bc0yeD2c5IK1t35QROEDyoCIzDSfeY4aUCS1RpBbpekDwfuP2LATrKkA
	JcDnXBy3q8r6hRW8GClE8VQ3lkaL5SqW4w2THGnMxE2KooP/ZJHvPEhgQ9XMrzeVbsQ5PZBuC1U
	CCFJKy1qZK0T6QFzN4np0DWuXIrT/gH8e+86ycbVpZpKWB2wGtPpte+tmDZvwgpW9oP4x47WvTX
	xFRqiOHm0/ZI94TdNPVyyp6C8nApYTGyZHwXYZPWqUikrhmchvENFeuD7myNcvX+OIA3E9we6hA
	QzHPptuU3TEgTYsfZmSXDGRVleShWPwjYe81xXUDFuWu
X-Received: by 2002:a05:6820:5606:b0:6dd:5306:d1a1 with SMTP id 006d021491bc7-714f24216cbmr416830eaf.3.1793337565492;
        Thu, 29 Oct 2026 22:19:25 -0700 (PDT)
Received: from github.com ([64.236.133.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1242149a34.2.2026.10.29.22.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:19:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
Subject: Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a
 v4-mapped socket
Message-ID: <c79c44da-90d6-ec35-43dc-c40b14469e07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:19:23 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows(2) =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40998734891

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6006c2a705=
82
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196780


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
