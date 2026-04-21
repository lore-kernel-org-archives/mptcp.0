Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E331F99D
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790375; cv=none; b=I42ETs+ufwcAgYYUNJ4WRr9vMfZRkKvYR+dFuqT37T1hVKTBEfwpnocDSOxIeEE73/p3vNnhGXUnBT+B5OgaHIrdMzTzBTJplcZePHve4K9lWd2WxjKvMeVQFN2uK58xetO0Asgvu8sQ6TqNqoa5SYSNNXWiVUUxBAYtx9YWrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790375; c=relaxed/simple;
	bh=zVCxeiAPaI0krdsJ85DYjPpRnX5joIjpwS4hudJ+XMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kRAkqM+NW3VxoBhS5Y6UAr5B//zxw96z9ls2gP76fP49aHbd2M0w2KT2/pdPS0kN9EZAzjK5jfccrfcg+qzW+jQVlHHsmcdSaZ4dWskL+ZIpKyWDqqWB9RCZq23xsFoIPX3AJnfURSx8HBfnvIQuNUO7uKPsOF5qGy3ryn9TktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrRifHkK; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrRifHkK"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c88e5f4aeso1248380c88.0
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776790374; x=1777395174; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlBFZ0CFa0f8QxUxxrRTXWLxH3emFnf1zfaq5RPMnJo=;
        b=PrRifHkKHD5HdINBU0Bob5b1xrLb/mm1PZ9kKnx6VDbOS5V9vxTVU/DaYhXuVDRCMu
         vLqjQ/S7dHMYhp6WEsu6ppmV/ZbLM3IAyhta7i80XZu16HiG72YpHafGsLxS5FeMVCiz
         h91+FBLXYdVjdMLDpSrV0EwXkEx0ZpERiOwR0cINdJOMXirtSZuG6GEQMhsX4szvpYOP
         yeja+QgANDpPD3P/r+MdsWi1JHHJCiOonizbU+WR+DNM4WNtGXh22LxOMvZbGrMJl7xW
         cWcQnmHqcbisrI+ftKtdirnV7piCY/cZXbTNmmd6Ta3XErKk6eeZXmX8cLzhKvKZf8XE
         qZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790374; x=1777395174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlBFZ0CFa0f8QxUxxrRTXWLxH3emFnf1zfaq5RPMnJo=;
        b=LpXMtxrGKlRekBFP6/Mywx+KvGb2HBOt5oVkDtYi3lGZgWP1ytvO/Rae44z500vt2X
         YjmJNizYRL1c/FPWG3t9PKw6GKQOJwI2wAWW212hq459+n1moxAJnR2WJ0Gy7QM84Tjh
         QsCJ28U2TVRE+YOltIUKZ+Nf7tcpY8OoXICG7WfNJ/MwivR/4fhjMsjA5nGcofZtPCxH
         4lAOmGBocjulUef4iigp48CgCxW0c4rXUfe5Kxk7GWy1+igpahTNKVvXM0fQXdXIED06
         SnjHx68PutbQ1vj0GlqpjdOP5EjqI+TjbXSQM1FdGKwPv8TdqFWln4XuJdq3IGY7QTh0
         QY3g==
X-Gm-Message-State: AOJu0YwGkYGEAAhE006c9KcRmH+LjQAchPDhA2/EZqbAli8hvWdfdQ6M
	Qq35gD7rV7KfpDAuzbvjnw00IWNq44vdctV9VbSqYR3x+4tr5bNV6yDBVprW
X-Gm-Gg: AeBDiesBSBj+S1njPka4eZae/9KQ0v9eFfbNezYTi3nI1l4COimSjQU5vwuSDgn74vC
	TZf1l7suJyaGX7TAAv4WRfHby/wocVWxUrrDY6La75teHHk1jQp8OHYK8PmoNz71e4SIEPHz0UH
	MRiO34eiQ5rfvbC/VHvY3vHso3fT7rp/pgIyloJXqRpZwxNynbbFM0RlMqhIC/8XpMpC+eTsm1/
	0SGl2+ToXledn+Ez7ogmJjsgzSf8UXgidOt9rDfGZmkmak0PEysY0E8yPa5S3nQeaBLZx3e71o8
	2I6g+pW62J0s3M/45muUkhU1RXfdSXT37vx33czvA/hVnGe9lGZ1gZJYRHhYzaB+516WDzSi0Ck
	605Wa+nYig+PN7GFtsEz+sK+U1BizR6P4eL1L0Fm6NcHusysq1JlPNHi0SUnfZ38L3nCAbYFH6a
	8yUwBs0k2IB0nBd02OCHZRMLDCM4k2QGVN2ir/m5YIteKTrmLm/w==
X-Received: by 2002:a05:7023:b0d:b0:12c:8eb:80b9 with SMTP id a92af1059eb24-12c73afa081mr6899244c88.6.1776790373544;
        Tue, 21 Apr 2026 09:52:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.134.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm513974c88.13.2026.04.21.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:52:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org>
References: <20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fastclose msk when linger time is 0
Message-ID: <ea705a7c-64de-6466-26e0-b67ea21c1a3a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 16:52:52 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_dss packetdrill_sockopts selftest_diag =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/24731778234

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f24800c45cb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083917


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
