Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC4202F72
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002149; cv=none; b=QQrqJP24xyMze3aitPNvtOzFi027K8s3x3rv7ZiPh7MQmY7aqB2fsR/Ofwf90fWdnhVOYJ0Cx4yq/Y7hyE4xzTq9skkgR3g1xwcbK4AMMjcEPEczhE3UnPU+Aza3M/8rcFxgWNRvBn6480A5udlReXl8K8Kx0K/WCQ6sHaRRxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002149; c=relaxed/simple;
	bh=3bO7SGpJ3wsudxHSr/Jzc89svupdTnW9TYRfOaX/joY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KcvZZsc00nNqyar7YfryG5eJljBdMgAGnCVHW3L0LrlJYUQuahXFT4WoL6MbjUUqrF2XMB+MfZ+ItMuSAIT+vnqRo9balcIrKxlxgW3O2arjwz1mcol989cmF9vthM0klXTdllpFWKDzI2CRGLCn4TS3TojTub3fvPpjKxWJcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4m6atBG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4m6atBG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ba9825e9so315230885a.0
        for <mptcp@lists.linux.dev>; Mon, 03 Mar 2025 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002147; x=1741606947; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrYiwsRS68LURqiYxeXVkSmgKHAQll95vpQJis55EAk=;
        b=G4m6atBGJhEnpYYPdyMr6i+oBHqOQLti7JilzmyA85WrGZ/9Wa7qNwGvzW7FRYaaw8
         Xb8FFI8T+HvucMc7jvm/D2i4jZuPtDg2VSg34Lmb+awyjQXtTb5girL7sAcB9q6/Me5V
         hfIy9fYk4BmTqmUUFLJuj1FXptV1AxBWNkSQtLKlKDFabbBSRumdf7Y2RqLLRKSYZ5x6
         Grm/ZgUhA8zCVlO84UogkEtN+MsR0tYQYILPu9jHVvj0KbdlcdjUgNqhzvCmEF5HRdHB
         MViqqlGajRnW6iApMI0zutOpNaaV1frFgJZ+xingk5GCKog4raVWHTm91wk+KDfZQ7SI
         PuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002147; x=1741606947;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MrYiwsRS68LURqiYxeXVkSmgKHAQll95vpQJis55EAk=;
        b=aNpl5u6wzAk6h+s3zSLKNin9240FiVpUVG8NYi7L4c432X/G0x/cgOM06CA1B9PTih
         GdOnVgLbzbbp0qwXxycUhzvdHhHvnU+rtbX+IGov/hZF74cFIN8pv0TUT7lvhDP2wM60
         MaLf2u/wL4KJFwOZejrwslmea0s9tCJbpDwWtMu+TZPOZplrrsgIk0M9sEhfdv5AY7vo
         ZsKgidsIa9RUBJZsSuUPLcGgjqdQl/vxcRQyzHshhl2Nt3/UrxBzCZ5P08l0RzAUJ2WH
         N5Qr0lTwMIE3LkFO6kzDgtc+Ycy+1wEpF93lAwR6FwQ5KBxe0tLvS772iU7V7wo00BWx
         0CwQ==
X-Gm-Message-State: AOJu0Yx+idfZso20g+ScVpW+T1sCL6ZCC2hvqKBl1fDUqPKNiX4PGZpJ
	q0SzWTQQMA2ZXf25+XM3ZT8w/tri8qXlNq4XcsENPN7OLre/CdE7icSa
X-Gm-Gg: ASbGncvldeBTyGJfkG/lHwqKw9+ZacLt40F8jPqMqgG8wWzsI0k7Ge1ooMQ3odVVN5t
	CM19uhvhWJCcQGwhtJW8BIHr3y6CuP5tzdWe/FVsO+qMoa41jH3Q6rWF3AVYudWRu2ZZZ4clVwM
	vnpg/iqTjaJ2RRQqpPUtN84SDRpQ8KCMmTVNca9N3XY9IIQCMmU8nb7P7CsYnr7iXDayMRJE3pD
	YYNOaJb2vaPQMMB2b17P3uhWIksYIJjKOOSyKWeDkOh3HjwIh43p3wC6+uQ3cqVHZ5H1+65z/jc
	Q/OWO9FZukmK88HUFgWrefvSmRU6HEbye0CrAhyZ4BQQMmED4ZTBUtDjeg==
X-Google-Smtp-Source: AGHT+IG24MboDS1ZTr06NSKBE3NzC6aaGmLHXpPhsUmNtmbXahOL5/3lGgMyCpibf9rbs65zhdm0FQ==
X-Received: by 2002:a05:620a:28c7:b0:7c0:a216:404f with SMTP id af79cd13be357-7c39c4a17e0mr1682678185a.2.1741002147149;
        Mon, 03 Mar 2025 03:42:27 -0800 (PST)
Received: from [127.0.0.1] ([40.76.181.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c267c0dbsm67881285a.63.2025.03.03.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:42:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v5_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <e0803e1f-951c-b085-e67d-1eb485311939@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 11:42:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13629090242

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/db85e099ebc4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D939536


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
