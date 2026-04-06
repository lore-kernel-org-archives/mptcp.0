Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA422D97A6
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477721; cv=none; b=tJbhfoCQH39YOmHYt+03WaVRD5dUu/w+M6re27eJn34C1cpDDCdWrfFRAz1Bg7S+QRM70Gdl6f8NQ0350Leld/G/9raEmgLP6aqZUbp8GwBRgSQ209H3RBnSLhI3Qh8tRZnM3GEtcGdEXpx6ExN0TYlA0jMtcC/VRxQt9ivTrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477721; c=relaxed/simple;
	bh=dKGJxqh384fnQkLCcfH00LDfgz9aDMOGbvbJFxrEfVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=J9PkWq4sSOVEFloujS78WxisWItTh0IGrhWZ1n1cuVvgVRAlLk/IectMhs32I9HhRZVJWM3uVHZDlDU1U1vOtFrbuY2uJ4xM0zmghuERRaJ7SUGZmW412qLvUgNkER/6d362ky5q0le8zJIKkIKlGwWGIoodhxnIITdEQeI8/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3nv+E4x; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3nv+E4x"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d65f4073bfso244028185a.3
        for <mptcp@lists.linux.dev>; Mon, 06 Apr 2026 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775477719; x=1776082519; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Goqu3CzywjHJcO7Yafw6AX8EU+1kcnZ7Uru991vMyJA=;
        b=I3nv+E4xlVJ+KtBdodaKpU2u2FFieqCnJgeD4/0QDgyNNTOjtBE2qjE9DMel1vGk0H
         3kMUmOqXUaFWj4rjPGkNlgnEolaydVrRr4JEFMlQlzQTXR2EvNedpamqsHXDZmRzp3lK
         3OMaezQSdvCcQWqRqLjo3EzRZp5WBNKj4OWcHNGRe4hzjsXXm5XxkOMFaVndosT+jOuY
         Vr/HXQo/rexwbS7DlPxbsvwBzWGjXfcGIueP23U36f/XDoyb8EdC9YYOdQsCjNMRBSGn
         WWYyANVCi3sLM6gvQKXdsdx8f2PFrA0QdF91sxQf65ncoI8LMvfVcTSpQSgQxcTXBuzt
         in5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775477719; x=1776082519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Goqu3CzywjHJcO7Yafw6AX8EU+1kcnZ7Uru991vMyJA=;
        b=d3uugB9STDqdkH5qVemTVaS0wtfhQ7TEcjkCbWpEWa8ZVYDQwcgodwfTj4kKt+qQaD
         zb7aRhCyLXdLaHSQd/B6IW58hmwCUnHNCo3gZSzMWzVOA/Bzla9Q71zaXLx1M7wGO2XY
         dDGLQFCxWiJM/cX+w2DXE7eyh3Pdee6D8tcaFBx/57LhtEjr0SxfuaT3tON2KBUYoexN
         mBkf0PGMcu+ujv9fdsLNZK9M+ffYNrORkLRl4rC3exp3zVNhepISWIY8oui4o0GOLxeP
         APn0fVgmf3KJpnZovFIeYVXBIl+5o/kRp5G//MS8pcjaoEYafBR59/3bXuNgeghM8UZX
         I0UQ==
X-Gm-Message-State: AOJu0YzA+5Qe8yx4eSeoryvjoT/xkxMna5NyrYka2/H6XyHPpKLpitPG
	WBim4iMeZX70OXn3o1Ujf5GKn1jf0Rm4HPj+bCtTME4HbjM3cVRr7oGpqbfj
X-Gm-Gg: AeBDiestRPlXMtgD5mFli+XNcJD/VXZIDFD/BgKuxl975iVRbNKujGY3P1oLKwsraKD
	KZhUXOg7KQdukbE9NXk/pnLmfXOL+7K065KxxGp/kgFdWPQtqtO+jya9YGAnziGsTdazjG7hRbv
	3HPVH6of/Ngd9ysFaWezsfDI+8oHCfGRQbTbe0kHlLzpxifsEHQcyw/vVI1FtBLp2W3ak8505Q9
	8D2rz/7ou323gcCaqYdJ0hnj5/IZ1EaOUVQJ1Jy3aVNY/zLn1ehBhgHgsrAFwAPPUk0JDQf4wHc
	mErpUVtJvDr/NTveLmRHlzk8hAkL8+I+gzDUA1jWpIEuKvw8J0KYQV3Ot8n7QszfNM632xRtYh6
	IrgA0qdbrnvKNaGNyxTVkPbazTBMDhGgpphc62aFFZ5E/AnesoIEoahaR1LEwGf48uGpaTwUs7x
	rc+tGl7griHz4JZJDqzuJki0ZnI8liwTPWrsnjjGBKJopt4bwDgw==
X-Received: by 2002:a05:620a:bc5:b0:8cf:c1c2:910 with SMTP id af79cd13be357-8d41957521cmr1896798685a.21.1775477718977;
        Mon, 06 Apr 2026 05:15:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a806b2b2sm1053324985a.25.2026.04.06.05.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 05:15:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
References: <20260405154816.4774-1-devnexen@gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where
 appropriate
Message-ID: <2aa620a6-faf8-8eac-e81f-8fd63be188f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2026 12:15:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/240292=
30954

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f63bbce96cab
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1077452


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
