Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8B372691
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829697; cv=none; b=HKtliZF3d0OwTjP2i4dHb0gKpUAwv8hDOdZEbgOBQGITNFhkIiagN/8ds5AEccRsgwZNEU/XwxsFGZuv0JtyZRYqsItngEFT4nKyzV4ZuSz5JXM0MyBby0nE7XxWXC2MOo6Ra9XEuoMbNhNS2L3Uc1+O87+kw+depoDd43U9hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829697; c=relaxed/simple;
	bh=VO/+CrpFXL1M315mT5t/tO4WacxM2qJtrUqDTWfYqt0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uB9qsrXPJ+0jqCotxShKEc+pihR9+/E2wWWeak/4vbC9UK71u3e1UX0ml5FG9UL+/SXMrOa3dXEoJAKZ/SglqR1/LI7CWFFLMeNYLvHm461kG7vmCqPVJaA99sU4G7bxXrU9yErYol0bY/28es4oI1GnJK5jYgIw741jJ5/XmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq5EOEG3; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq5EOEG3"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3514b90bb89so4076904eec.1
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791829695; x=1792434495; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w1cAVXTHpHJGGfYcPja/+Ny8N0hsI3aXp2x8hbMxpCo=;
        b=Eq5EOEG3slIKf32FmtQmufzraOJs7pbmdqQxiBVU41x7z03Wof8vlR5oBHrnxUQVaM
         dElx0RDyXIn/+DKFG2mM6NcR0w/i/70+BKi/9h4txSaEfqCixJfTNNfbtCafmcL3Rsje
         skfy8NGouz7C37BPu48uwoqzZl1za8fskvVwzGXvEaQ0rmvaKxfLGeQQS22QhU2f5qxJ
         vStFv2itP7wBzFwN5SxnYuJCpNpe0TmnW78omoyy9B3z7X0eepqr9jfMlZ7KkYhJ7fGN
         Y8/INwXShZ7JxZ5iWKK97n8NRpemdGxTwwJyrMjjzx3eu3U0PiZg5Rn2Ho1Egn2Gj7tJ
         mXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791829695; x=1792434495;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1cAVXTHpHJGGfYcPja/+Ny8N0hsI3aXp2x8hbMxpCo=;
        b=1FqUp9yMvTzvee93hLHHOxC8uD42Xy+J10cqwk08HrJga6yX2TSVNtuaRr425ZptOm
         tQKIpTIgrjV4KIIWxxIJiJWow5iyCO4T4oMvvYCkNt0tpRvlvx+g0xLh/EdLZ8hGjNl8
         PUlddxox14YGvq9jQ2icErQpEwr8Jyqwx07JvpSzvl7gPAB3TzlG65cUD/Z++C2zsGQx
         aOMrfGNmIZ0jRcbe5R7QZ2oyYec500Wxse073G2hNvziWLbwf+K79SEzGgPeyalwNkEO
         zMD5sQ99eh18CZJEzehb6M0PJuwkGbONTAkaIYCLHaIpL1FujzTNJ1FE9SJG0BzibA2E
         5Nxw==
X-Gm-Message-State: AFq9FYIePTIjCYteciKG9niTwXlVkgo/V2oG666tVyRjqJQL20i7BZjU
	+EWtz2DmVTUqDAWW2qVfXkPhT1WmrkFizyoq5wgpS0DLn4OcObu1vCUSKPhy
X-Gm-Gg: AYBFou2TSWtAKPSZUf1hEulpj/9ZFV2Ex1vH6N4GJCViNXd9Z1XpU8VDwtZdzZwCjt2
	bEYD7sOBD9vrEBmC8BdBVwqhKm6eXwjQiYRAHFSXOrm8qb0groq3fdcAdZgZCEcrvJ0tOrNjy7x
	z9/ZZIeK0wiWeEL3DJ+REPF3wDDTEPGyy4+fKykM+pOgEY7Bvx/n3fLw/IxSG73erdQekfEwEGr
	+H1unhnruYFenoOqe8xi3D5YTSdFgqXS1x9x2feRoHc0vj/yhqtvzbxWPDhz9COs8plUK6gpAiS
	L0opYV6mo9SBUzB5DjkepYt2ib1Q4k2X3VjH5TdJL6/ZiJpKHDlttT9/8dsIlPxMQ0vmjwGNHBE
	cU/33ATpLt+abWe6Kx2cYvRYvSm7/Md9rLQZ9P/jMKZF4CiCXbNxuCRtVKYR8gy7gP5qlewUtS9
	yn4qbNWGPP0+KmWupJD4E6v3Q9IP1wygN7gk3rqvK3eQ6B+Vrv26m2I/Il8vgCHMGmZ706Ho9Fc
	7L+chIwZkdnEgWrNV10Tjfk
X-Received: by 2002:a05:7300:4352:b0:351:73ad:bb2b with SMTP id 5a478bee46e88-3537dfc7693mr20980257eec.20.1791829695158;
        Mon, 12 Oct 2026 11:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm38565198eec.10.2026.10.12.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:28:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
Subject: Re: [RFC PATCH mptcp-next 0/3] mptcp: pm: kernel: retry subflows
 closed after an error
Message-ID: <0baeb310-54dd-53fe-1f3b-a08c474ec65e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:28:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

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
et-next/actions/runs/38285613995

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/85b2fa662d=
28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1184079


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
