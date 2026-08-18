Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAC4503B
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080822; cv=none; b=iAM78UqSFI6jN4UdJolX7qJ60N9dqeQySWBvqQ3hL+O+3v+49BmZ4L93T9viAcQl+HNqmYVho0fUPXdwWTxYUpSggXXqjNgofANQAR+emqUwAEGMg1Td55SVBvLbe0rNKoEm6Y032Yv3sgWwPKJEDnxjgFifbCady+ZmMEG93qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080822; c=relaxed/simple;
	bh=0qg1NZD3USSjan2hjC9Ocj2XRDHkkevHh0dAMvV7HeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=roggMdIQ5sMS3Lz0REGWqZIHIubhenVMPKHkdCir40H73K9+q+ne3WTa7inwVoOjeaSZM0kXcav/jxL4+roPl+dl9IcOVu3XmbwzpsQFciesuqjh/S60cderHRxso6djoBjAVeU6/ugIwbpo5d685JAVU034rg3F9IlY7ajqFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wct/LFrT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wct/LFrT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so309289a91.2
        for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080821; x=1787685621; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0nrcA2tAP7jh6JDDYqBUe1hzN1o8rzuyAQactFv7akI=;
        b=Wct/LFrTkPv+hMQSna2HRYkwPMZ8Wtlw45df5Ut/a4ALT1P0Oqr7aZ5i0xTuQpf+i3
         i+9LrCfmMBQutNMdiIdBgQl9LW/ukpZZ/vwdHInnmLoubdL7GkjVRIFhA0KjUrHAPw/I
         3thY3VmVED7J1GVCwmjA4ibCrF0jvykRBfiaZNrf5XVL2vjIY5+c5+ueWb/wmQbVUHSC
         h6jN7WmM5n7/t2jKTok3iHPbl5qqHU+2syigvpULCLg/0opaThAfJxm1YEbCxg1fbt9k
         lbVLB6pYIlirHM6gDcmrN9gB7L3aRXa7izWyqYns1lp7iZvrBUwcManfff7i5yJcZoyR
         ySOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080821; x=1787685621;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nrcA2tAP7jh6JDDYqBUe1hzN1o8rzuyAQactFv7akI=;
        b=Am+LNOiWZPV9Tf5z1WCeAzJBbCkcJ7wgKso/yGSzscistFGgm/JkfuVbElvHIYSEli
         Ip3XNg1kOtdyUiOARdsrogcuPRECZlfLn3uY2REAA+H9pjvQ8pE6jyLjdluCABX7burm
         hQsRp/aLnvpwN15w6PaDbzXmb9wGEDXOy7hRpY8nA2IiHIn7eY2HGkkU3jd2ayu8g0zf
         PE13PMuSXX8BbVj+cxQUEs/EQpZZnx1aTfJii9SAaRDs4zecaBXDvryNFVOYk8y63vUX
         ZJXKSeUUQEJemftCS0lFuUXZjZ9JY1IMKkNY7/IzBKl1CX7APhAVG1OGG33yrtbr+dER
         eFUg==
X-Gm-Message-State: AOJu0YyHdPohRltdDoTTJZWbtPlEWKgUjHrAcUvF421cR6iO9bimWC/Q
	4x18EgEIcXg5WX2R2tx+AJWGaiRjM9lh9HuGxHK/4LKJvP3zT4hw6we9mU9k
X-Gm-Gg: AR+sD12ezcLGVBu1jDJo3MGeY0ruN1yHv7IFq5FVPL7bgWm20l7NO6EM8W0JCkw6r0/
	z+N9X363Xqc9WqO7DR0TreoZsC/y8DOOkzcS+p0m7lsPtKuYbPP9yXx4kDGQ7bApqXvcOFuMacw
	oWlCk/n7cSMp1mD5rJ2CgxQSmCRzuUBq/7t2rGFiH+SWixBZgZO/6jPX68knr4I/HFfohXkV0Fj
	BCcawJz8lTmCpuyjyGq0LzVQdx7i4+zOqiESJidWdYkHTeL9Vs4hZBzYYJpTqLQDDfPJliHuhQo
	UA3IPvw5xE1Kib/IF6uVaBee6zPK9Do8MzkdQaaYnfj7hA4PeAW7A3bFT53U8Az8cWlvpEUhCPe
	dfqa7deXIZc6NTXnnYxJRAMl+O4NeD1TO9zxRcDVmDO2Atino9OvHe6zMjBZbcWWujm7oLum1OU
	T3ovYyWFzU/5A2m7NC0GbILiRs8uNaq1kDRTCirATmt7acunJ/NBDEhDcpxodwWeHWkE3u3YMAD
	w==
X-Received: by 2002:a17:90b:4fc6:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-3957b05de69mr173956a91.0.1787080820673;
        Tue, 18 Aug 2026 12:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.85])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141530793ccsm20247812c88.8.2026.08.18.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:20:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: avoid uninitialised read with MPJ
 with SYN cookies
Message-ID: <e9ea4afd-f549-1fa5-3eac-910b12ad7e4d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:20:19 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/32171215149

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4172949dd486
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1148008


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
