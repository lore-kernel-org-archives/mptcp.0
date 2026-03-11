Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31473C345B
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220397; cv=none; b=evc+cNyYl/u9py+GCkqDxYjbpzcdYapFIJJFLgu/DBkGr1CqNnRL/IS+Cm+kZEYijUdiYolx8FLzwbcJHkDO4VD0K3KT2qihx/6hObd8jH8dgD+B5nJzhgg5pb42pnJLQYqpEtOTCCmjymRc9cG8BBkDHJ2QsysEyi70HF97hVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220397; c=relaxed/simple;
	bh=bKCYpeht8izprNFG/uEYHCiPPQkHPi6VCEiDACqrD+s=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fL9o+X4ulLjvEzY19cWdW596h50RMxbrHxgQ193V5kR0ZZKpN70uHr3hC6HgWETkSZQq0VUZp0td+ivmv7reVfCjqk8s3YWoavAhnk4Esdc/0B66CDWEAtKqo7hylYYTI4PVACBa9hjYRn32HT34In1wYWKUPMbdQ63IqPPAlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKc81sDz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKc81sDz"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509164dce91so29383911cf.1
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773220388; x=1773825188; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUeRI6TSeVjcGdnFlJhgoIvr+pOHKbdnQUxeT2PI3wo=;
        b=TKc81sDzG2U7g3SMADDfcp5aMfTiVEVswCcWf6mcbO94QHJto6lv5HzxCKNN9oBXMY
         DE+zgv7hrJDwHFYCcfMAF4BrhJQoUs7po6zLObBkZBHOGLc7scksPwhOkx6BF71hAgzh
         BhlNtOIRG/CXjU51F/ZO0UPw5Y2FvsYa2Qjz//4rp4pl8GZ5VBKvaleV6OPug9tIBPg9
         MjEfFXMKZFd0acugMatMxAsnxUMo8iIeFIuBbgXvbhviva0wJrEqwcy+5AeNZ1w01TIe
         acn/PWPvGVuIUo+YxZ3GTE3ZwHbwrIAHKd0xgZ3RQWcJ51DMfgqvRSUq0x76XRinUgOR
         ZS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220388; x=1773825188;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUeRI6TSeVjcGdnFlJhgoIvr+pOHKbdnQUxeT2PI3wo=;
        b=th3n9aPG1zDnzUnrI5WWsGOftVKVJzzRtywuuOvwCrSvGkSgYKlNUGGn3nVk1M1UeL
         z71TtiFNDvnBuebdXVUxtkrZhNG3y8y3mXg22IruZFgezFZrs03AEgOAHqoPHcbYAtjN
         6uHQIV5vCAfe9AyYI3KRiVzmD34Sc36C8d8O3btnfsAn5UYxjk59jzxUAPbDeuHb0WUx
         UuZk7EFNODYsP1+be3TxbYE7oAGALeDzm3TvpsUaAv97DSse2BwRPsuw5+3Z544/acoG
         bS8y7h+2VoD/veLnynEILltNxmZA/GLF+a4zzfbT9o/OKW70GczP6kMen5LVIbO4W3AO
         GcSQ==
X-Gm-Message-State: AOJu0YynKZJd8fDNexnpt0MM1/kB9km51ZbrloAH0zr9EsSZiynReZFg
	U6bmVqRuXXkcnbptDvf0yYvZ2COQ9qNucXWO02VAt/AX3V45mEjXwhEnTGf9
X-Gm-Gg: ATEYQzww10bUfbQ+unnLl5lrAFoBrA20N2olNJEiJpGeZnBGx/upT792flDrvWA6ycD
	yl/fRaNNBJBKDYLFqamjNC5ku+ZwZBS8o3ZqmtHF5lXuvQQ7cxCdb5Ho6Rw5db1xlTdv6AzMrVv
	x5dc0Gz48bAEW67F0nS15gzYNp5Jewwe11rha+NaT2JMYyL3LsVEZTkeQ1jgx5ZdhWovr6cl15u
	i78KoB2KU81GtYPpasRXp8za9nDGGoy1Hzu4cQHpjpgutv/NoInZgJ3Rqki6taiAOiwqL3hrqoe
	EzfwYQZdz4IAvlBmwG+X3wuZqtkQKcFxZ64UHjjCkOulXE8MHTCfi8iSVdJ0QjaDUEpkW1u8Qnz
	1bRJL8E1+v2Fosza4rDNUc3vZPu6OC4FS4TA+AhlBghMJCxDvASMh5FDiCqgjzfhgrAC79+dGYA
	GDEa3Hx4o5Ycn7Lv7oGB3KJubyqZCtt1cHPw==
X-Received: by 2002:a05:622a:15c9:b0:509:10dd:2c88 with SMTP id d75a77b69052e-5093a14d544mr19509111cf.49.1773220388318;
        Wed, 11 Mar 2026 02:13:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e0ecsm9281841cf.5.2026.03.11.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:13:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting
 across receive-memory decisions
Message-ID: <67a74258-4a00-875d-1ea3-25068b283e9d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 09:13:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Wesley,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/229432=
22289

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1943750d8521
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1064867


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
