Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAF79952
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166361; cv=none; b=L9WUIcSFsNUkYb5x3l/HycnQ6Ge8BpBOluiDXCELO40vNoN1PEIp6z4kPAlf6HvhgtumziKvbvONf6pnVEnuNKJ0lJc+faUjqprmr0Co+Og4o695kilubxpfIb0tK1b7h5J8MtZmAG33fP8vuSA/xXlms6i28n0i7Td5FP/7uYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166361; c=relaxed/simple;
	bh=UvE2tUmK8HpL/aNT2hKCBcCTxb6pbtSnB60jYsN5aBs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=l3ltl3klM+ChoTSHSX1PTgR8tPKXsXlypispqkuSYJHat0C43XxO92ikBJEpu2hwZeyj1tmC2FEPHeSOBjj/gWuP3mduPiSm0jO0VipyHIERIWAcAtq8/qeSbI05pEfrqlsdaMgx9Jm8xYHpCtCzTCpzR+YfnHxH8yY8XazhdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETlKtOJi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETlKtOJi"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79ef8e0c294so14765285a.1
        for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721166358; x=1721771158; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qAEYsPW72ZoxBlOePUPe99Fvo7wqDvG3rTJNQCzDM0=;
        b=ETlKtOJi50gpf/so07+StB5brlj5Rd6WxgI9Ig9ej3u8urMkhwqyPsQJknA5VGz2Hw
         NC6Y9hz0Sx4tWlD1P07z6TrRRfzAoK/3IXSNtnA+H/+pl2EO5ofI1SWvz9M6HlSwlKz6
         v5WlfVsyIvydM1+/pVsKvBBT47NX+r0oBOEYqKPWsQukx0aEOw1DueDMcl9oOqQCXCNQ
         /ggkBknCHvcXWQIIQ8NLL7Dx400Ik7/6XiW/uP3CTOUr2iOpFN5hQQKO6t8hxRS/WCvj
         flQ873vaU13t8JsJVsI40z3qNEuFWpn3dQHQFU6K1bx/1QG9AZ7wEeTlpe65iV3FV6L5
         sWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721166358; x=1721771158;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qAEYsPW72ZoxBlOePUPe99Fvo7wqDvG3rTJNQCzDM0=;
        b=qbwyF7JT9/ORZ21QL4CNJzhDIuseH9PsFyTWlXOR9NT3xb5Bux92AM3KOuTLS0+z5m
         qwsCCyu4ig/wWmH8OBvs7K4d+X+V7GoReYDC+ZAVMHr+W1TKqxJw7SlRR5u8YUqfPDiz
         Jc92DufX2jwF9wANRDedoKtJAubVQ6PeL9vKo5LkvxZtoYKlkqUx3FMNbut8Hsy6Zm1Q
         2W4CDQQlO3ZijsHse65YbJJ6zz2imqVCJIn+8kBzyONZBh9bk5zaxDbXgxFL5TwgQipf
         tSQYcP0d7sj8LDKoEweaLQgXjGpg5hSN0lOowNVz0vsY/p/O2c4ziJB5ws8I2mB4q0wv
         mMfQ==
X-Gm-Message-State: AOJu0YyFyr+k3zbJjuUh58LxFkJONPPDB1JeqRO247E5Cq2Ri2bMg0nO
	CXz6xiDgoltIo5ZQjKASmUaj3S2Totg4RRG+L7S2ouc9ZNCooXs=
X-Google-Smtp-Source: AGHT+IH5BJMSIQg07PdKd5N9cBy0YSYxmg9rnPB5c151Mdf8SApM89r9oKYfeTQdCh0dDlFRzOlwaA==
X-Received: by 2002:a05:620a:4011:b0:79e:fed9:795c with SMTP id af79cd13be357-7a17cc5bf68mr593752285a.19.1721166358275;
        Tue, 16 Jul 2024 14:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.132.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c868d9sm332865085a.129.2024.07.16.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:45:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/9] mptcp: fix inconsistent backup usage
Message-ID: <7efe2805-c622-990f-c85f-5d8c4d8f87bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jul 2024 21:45:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 4 failed test(s): packetdrill_mp_join =
packetdrill_mp_prio packetdrill_regressions packetdrill_syscalls =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 4 failed test(s): =
packetdrill_mp_join packetdrill_mp_prio packetdrill_regressions =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all):=
 Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/9964158437

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/12a566ab87=
00
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D871789


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
