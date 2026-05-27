Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2453B0ACA
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866442; cv=none; b=DPIn9MWQNrX/vOEF8wBA2xgcB36QW+fbjaTQkllxpAPZztAOINgjcv6WJP9eQeK6CSWKdTzL83LRgGT8DdqTJN7q8AeFU7f1SFjaAWcp2tPM2rWiZoBmeJsr+es3qIQ9DCyk587Rh6eCr57YLiPY1c9CSsI7tScP2YUeVx6A6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866442; c=relaxed/simple;
	bh=HrSf1h/sm/f/PiljPn/vskPBrjIraIM3KbGhLkOmieI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KbgVQ+6+gROurg3IHXb5yPxv2oI5PoCDOFAkyew71PWn4FqPlcphKIrp9LLLmHm2r9IBkRUMmWMdqeOqJIhwiXgOMLCj9zHCOzP/FgaTYwis5EEJKEW/aAWWk+EzsUGbh9z1vbWih1EKviLedeA84LF/MObX7VXL7HBXW5rKnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+HVqZNc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+HVqZNc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914db409f1bso220338985a.3
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779866437; x=1780471237; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UreYdww6sXOodyXpA+D/os2nfrlZeY9KwwN2OPffIvc=;
        b=N+HVqZNccWBO2xsikbKyH73MIwHQ1ncqVniuUKjeR4cNIjsUV7Gff7JQKiqeu35Bgt
         v87/43PBZrSvE44lgg1k4vpQhCpmU4Qsw8aonB5eqJIGRppoM+1Kl5qdGR6r5rnsL8+g
         v5R0D96I78b+Av/S2RYQGqo6YjqVNz/n1IS+g5RoCzhAMzRx3DKYzPRmhNwDS6WStN6M
         8FII3yryTkKOqBHQetprJbRFOqGaPaA9mRCMNt5ATx/vH619tFk3MY8lIqvkM5Mef/qG
         acyQH5hoa/8HQ0niekyjnXsUWJ+t/7ONgOEbix2w1tFGVhTHijeQcDm6Zid8DPEYikgc
         XdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866437; x=1780471237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UreYdww6sXOodyXpA+D/os2nfrlZeY9KwwN2OPffIvc=;
        b=m5jdirW7PvrEqNSPcYrIFnvNQG3qwpWDDMjm2SC1YkT9jfsFw8q/z8LfgfgAmFXKl0
         nkGuB/GqNDuMwFL34aAVBZmIuB3rtKRv+k+L+w8KwhZwsqYBGIA5fJiJ0jbKOhW2uwDx
         kIcnINc42FlPRBQIJI8++03M8rgA4t+Qs8kc5FgLMSra2RXPLKGil6JsDEfHh5gXZYcr
         z/olZkglUfTg3tCFbf+Y9P9Bwzn76c92iFJf63iGaZlLBGVqNRZTghwVgJZEmtIZKkhK
         8LyBG9Fxhpuugb0S/JOEsiWDOvyatio1iiFjFzW1qQ8qUYaejossccs3y3nxm68KZIDz
         tZxw==
X-Gm-Message-State: AOJu0Yy7GeL9oxrpJHMXgnp6fP0nBDwGtYaab2Gn2ko9zNvR180TEcwN
	03hxd1XfZsgyjdox2rFjPksVK5q+Emv+0H/p5gjHv+SXkd3NV4LySySp5QzT
X-Gm-Gg: Acq92OGaiWBp6iglzsiYurH75FKTIwizzxWkKTi+kSB6ybdellO7wtzh5/78KPZKHk1
	9EyOpb167IZr9B3EJi8bI/T43IDLovdEwLUJlJASMS2JxbumcJa1H/7Oa95tMqRxJMLPPhzMfvr
	e54btXc5riRXUWHD/Hq7LeZzFYX/gQhkQSq1stqMgsFlxsCIUXgcudDnZWA2IvtgsLmh9+YlSUG
	O3fiKPk0dejGhBy4U14R4k71nsZhoUYfKCjl7H1//Q6+2L3yr1hymvEG6hyGH3+5i5NGRabRRwD
	ExCZDcm95XugYxBqPLotlhEvQdfVpQs4r+xozLZ633H4h9lWt8WwlgdZG6y1wGkHuBAh8m2Kx7w
	c3Wg3HP6/qZhieFdyLC2RjsrHud3WfZXaGNL/YyPA0qFcahrA6wsxg54aP2XL5QYfPQWOMy+WDr
	HcOs7YyEin+3BE7RxihuqI/Ma3BotsOTu+dZs=
X-Received: by 2002:a05:620a:319c:b0:914:db40:9be8 with SMTP id af79cd13be357-914db409fffmr1754107485a.50.1779866437178;
        Wed, 27 May 2026 00:20:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.47.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86fbce3sm405305485a.11.2026.05.27.00.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:20:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org>
References:
 <20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: set sockopt on all subflows
Message-ID: <56a64002-f0a6-e1a7-f5a2-cab40a1a76c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 07:20:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26494709412

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/48cb8fdb0919
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1101402


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
