Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226792749DA
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879123; cv=none; b=ER8VImnIdjF9Vm2aZfWEfVwpMNvFmh1AjbpR9xDEZ8cM24/s7T54gJYNeY2iFhciSWHgXHwZfDmwkP3nZRLoErjtMZNyeHrGjmn6PtzWsGASrIwL9joBVwwtZzakGzsNc9SObw02P9o8txbKwMqAC8C+a7JA6J3p9taVpz7QaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879123; c=relaxed/simple;
	bh=9H/aHLBZtVNYaz0G3utdI4F5tjMmCG2F8oJiciold64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sR1im3L2GUcM+0umkDYSkNWiaxnB2JKamvF53s5RiTm+N3UZTZEUPG78epfbTp0AXpZe5S/e+fB+11jt2cQ+9aVlzFI4tWXuEpG4wkTfHe7bZQVR+WhtyeFohXzd8c9IwgX1ZY5V6/Dizb5hF/RtFfg9BVxZKdteyrk8tUU296U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY4C/0SV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY4C/0SV"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-939094306b0so34565485a.3
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787879120; x=1788483920; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wFieQUuhdcYEpwG7tB5h/SkVg0K0T5rRH03gP2HnQb0=;
        b=VY4C/0SV6STi76+QecHsfonfITQdnc+1KHQZMxtETVY9BJd272uv1qIaVdjMFMNg77
         Iw+mum9dL7oq9ye8TxRRFIvb/PEVNGEtmgpZB/MonUsBDG5BGn5rj8x0N+IhvVJcxir/
         7bwGHXqq65JG51KHSdBjdqX6NC1xn+U65mGejtJzf9pmnpUQ/veSa2bC+vbvoz06u3wh
         nRbdKVwfCoj6npcwYWqnMMFJOO1imLHQzaKDclkjwKWBFrVfe73nRxRbwEIUf6mC6QHG
         BeU7NwF1Gpz2FvGTlk5sZ7vEbX+PrduGONzKaBzvNN7OFk8jeTb/+c68qIX37WYnKqIL
         8cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879120; x=1788483920;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFieQUuhdcYEpwG7tB5h/SkVg0K0T5rRH03gP2HnQb0=;
        b=WRB2BH0fLRwdxZ9ySadnm/bV6EQSDJK49dfDqYWjVprQaCI31O8ZFUCjge+pFAZ5si
         olmu17n/8B4NZRmPwUE+KDsj7/XoYrBkdQlfCm/MO6jLAV7JxuxPlUSABJ8iyjULvf6G
         3UXwXVT7ULgUOZsQ5Qfmoo8Lym1UMrJHZWgu8GGvAM+Uo+aAZYIJtVEppoNK1hk44nN1
         gCiGHT4lS47LiyKXv9G49x0R9+yG/x9nl+rSjGDHwxzi92gZauvesaGXfMXBHFGzoOJC
         REHe5foHhcqeHepzAxqMk0F4Lgaym+esMGpOdfCc7P808Nf2/17Ew9m/rtWMQxmqBcNj
         /ABQ==
X-Gm-Message-State: AFuF++lHUG5xa1eo2FsqGS0TNWRjkLQr9+v0hOoPSArMVk0xtFGzNKLQ
	00YCDFlFmuLmp4SlitUr8KV9J9Y9UfEPjcW6TqY6WISyLs7rQCKV+8M=
X-Gm-Gg: AR+sD11bO6ioIQ/rYsxgpKs0r13sXZfob4ubBi9cG//phW6StlzBEKrXr74z+uX+GPi
	HjU6XLNNI55RIYVewlEwLTDTpHhy6Z9svDiJ35u6lJz+EB+Jm/+Xm1DBMmex5g8pK2ZZRlENcTE
	JD0XmjdNOHuw55Ns8Pz39UOl7FrU0Pjox3yPpEVOxP2brydWirTtZ8zE3N7zn6W7ZNSqtQyhHGr
	bAt4MZ32tqc9xvP6g7H16DnlpW5wpASJmAjLeA1CLRq1p+k6tW9WQkuZabcPRZQMAErfa1WqZMk
	XG9jYBU3OxWtVNK9r/HpcQPNg0gK2CnrmriJgAermKqdtSP/q4Jbfr6k+fip+eS8f2ddbSEgZOl
	X1ZvdsFA0nG6km05Uw4HDtCnuxirlmnhgipy0QaX9Be+QoXKgy8D7TBQ/ypuLTTZurbmrnLp8Q4
	2CprhZwCnIbl0kEeJP2ckmm3w/ghizFmKbjwbOZqtugPiKc8ztJIf4z5c2d9rZZmcbCUPrc0q9
X-Received: by 2002:a05:620a:8885:b0:939:5b0:3972 with SMTP id af79cd13be357-93913901e6bmr251615885a.23.1787879120418;
        Thu, 27 Aug 2026 18:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391700a637sm35014285a.5.2026.08.27.18.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:05:19 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <blbllhy@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
Subject: Re: [PATCH net v3 0/2] tcp: fix use-after-free in
 do_tcp_getsockopt()
Message-ID: <828a9499-2f9c-9458-5d99-887a6037170f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:05:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/331292=
26428

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2486bca7e19c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152901


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
