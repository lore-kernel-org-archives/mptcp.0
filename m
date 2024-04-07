Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD512B7D
	for <mptcp@lists.linux.dev>; Sun,  7 Apr 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481304; cv=none; b=S6O+eLcZlwnMs+6z3dRdFnkTM7xmHltuBQlVJe0fzc1SPu7M+DZC5FQkMs4GO0qxJ+iNjHtY1nFr1ctmsEO7lHe+iZT/IReXd3d2udvB5l8wt2PpEF8/IwE97zz5/KEkgxEDm7rWCSH+SNHPhgAnxNeuq3ufy61PpYoT2VOW328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481304; c=relaxed/simple;
	bh=/KcAVT3vn8FNIwv/JOgxAxmNXgbMLUvtBAXcLQ5pkK8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PMLWI9SYn1Ag9uOSoAxVJOp82fuabUOrv1rtbt2JihWP0roB7uMv5uTAbE/op0cxMY36RTJPq5Olayx/kEwd8nQjVmHk3FbLIN0naxUyqpHLJMgEAqeRO6EZHx+nISS1uXvzBWZJHtIZxFO/W9R0dxIMDPv4SNx8bd0ivVXcUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJxg3ZUp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJxg3ZUp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-617d411a6b3so15339567b3.3
        for <mptcp@lists.linux.dev>; Sun, 07 Apr 2024 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712481302; x=1713086102; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1FX6haSTYzy+ahaLEJNy3USabM3d87DE/ZvAJefBP8=;
        b=AJxg3ZUpUORA6D3vO1dGA8y9VIQoUR7vUP1yiChHrPo8zS0GP50cG8jgACDB6YyZwI
         NOUvAsyRpwa0hzlaFuGzcuytttLLbP7gNctksXnq0dy2fQrNSpMMYmcaBDKuwIPmiV+0
         K3LBRys/ZYG9r0tzMdbP8OLnszY/j2m5opHDm4UmKqRzT0yHGWXNcLfZ4+BcxSIF8zk3
         LvsXmQcnYUcP4o/iyCQ4x0eaF5QA0vGwXCCeClRBjiru87JxkcKP8sv8d4E16PO17lfj
         /ehQpLixu4IOMvlbB6Mdz077lxYRECYpildyRRoybqFqf/9a1EbsoPfdb0H6PSNhMD7R
         Dv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712481302; x=1713086102;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1FX6haSTYzy+ahaLEJNy3USabM3d87DE/ZvAJefBP8=;
        b=fyPtiXEu4Pozu2dYoXrutSmw1TjXmobXrdAKG70a+W4uJU57DTgWhXIi+ek3e5nTmj
         7B1zJJU8DQVnuoPN5Rkpl9Hl+qJ5W/q/zpFVQscEUPdOjcHupw7WIe2oFIvDZkT18Vq9
         tgeGw1kjyYfa+9toYTFu7/GBsgoDi6JT8q6RDnVBNORLh5eRi4V0QZvt5YeqqFTTJfCU
         UzEchj4dXl47ipQXU0RDrwZAMwn5HtLVOT6EdiHek5Lbd+aExGOh+C44P/efSY+K6pVc
         pcn7PlNIsk5/4C+gH0iZCwWlRfNL/uzWafTrIP8dZYywi9JcqTvnDRykKiO3gnwP2dk7
         A02w==
X-Gm-Message-State: AOJu0YxAKvWVUE0MKgGW3kqk7DYcszlImnVYToHxfWEDxBpqmx7XvNPE
	lb1mDqogiEnt0tXKEWqMFIJQlJm5YmYx/AoE0v8G/A6H5GZ0IxAfTzJX+NE=
X-Google-Smtp-Source: AGHT+IEGqE8LTXzh1FZ/xH14BQb8JpIajdJIsjus/Yud2bvd1rWzX+acFmBhBa1t2S/YB/ZgzCoCmw==
X-Received: by 2002:a0d:d953:0:b0:615:8174:61a2 with SMTP id b80-20020a0dd953000000b00615817461a2mr5494937ywe.8.1712481302039;
        Sun, 07 Apr 2024 02:15:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.210.215])
        by smtp.gmail.com with ESMTPSA id o82-20020a0dcc55000000b00614531d94d2sm1196145ywd.59.2024.04.07.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 02:15:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6af4240525d760d0d89ed374bfa28826c18c7a2c.1712478251.git.tanggeliang@kylinos.cn>
References:
 <6af4240525d760d0d89ed374bfa28826c18c7a2c.1712478251.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add F_SETFL for fcntl
Message-ID: <9ea72aa4-bc04-fde3-8927-c9071ba73b12@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2024 09:15:00 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8587489016

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e64d6e3e59bd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842123


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
