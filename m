Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED353AC39
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847323; cv=none; b=ihxq9qxXXn696h3HCOKDIHVFt2EAjLyYmY4/dJ5NCJHzQq71no96fCaTlh63ufm2hlN/aXWcrQcGUd/Bx+Bo5VOVu6bTOAIzAV8vrwkG4/jHXnm0UvSjyqRTVmS3JN81bTicGtb2c2/qN40+Ai7gwfnlx+CKWcOB0MSCxe5KS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847323; c=relaxed/simple;
	bh=WvItXitEEOJgdwhz139y2HPBpdXforhN4p9Alnt4wTE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=p+YsapE1PMskOlHVQm+hJnTcRWMaR2dLk9pmUcF5vJb5sZbjx2Ue/R6HTo6bUc82z978MgAfRqrEnIwrWQGqtOOLn0losFy4NM4agtRB1NKqMxHFVxt1F/JU7SYuY17NysJ6ITjfEwwhJNoRf/wp5ci1ZGKiZOT8amVbH7a3aF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7YNvA2P; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7YNvA2P"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso1968463b3a.2
        for <mptcp@lists.linux.dev>; Tue, 02 Sep 2025 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756847322; x=1757452122; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaInbLb8uOO4gsWR5zA+yHBcEcyrRCCu9pTg+3YmU+g=;
        b=K7YNvA2PhGl2oQzdw0Pxkq5SfQEwF4h0kZdPfC3rtIZ/3M8u0UvtkzPfsW/F8Kb+aE
         PI7K+AgSqxS16eRcj+hvbbCrCVbQs2/6SBx0i6Ct05vZo7FK4HMeN17YKDV16J9ergk/
         7i+CJQMH0c/1bpQoINCGI9XJMCgYvpkt6HMqvgJUQNUpIlsN/bXMi98U/VEWaRB6EF+X
         UCZHA3l1KzyaY7JHtGjXQrdvrzOS9zAJPvGQ6NfHnoycSuirylc0/8vn7HGFKF1VGuZo
         J6EdV0vKi3VaKhVYFkuSHBIIeG6oHC+bpEkBU3w6nUTSeg70OqUYxCA9ziTtYXs9ATw+
         Ongw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847322; x=1757452122;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaInbLb8uOO4gsWR5zA+yHBcEcyrRCCu9pTg+3YmU+g=;
        b=KS+CyPH5qzdIsmzPXmU+SKhTG54rrnxLcidRhmv35K16DXSCtd87PLcCBHVoazz/9O
         WgClPwYJyYkSahnXr7kpGFD941BlnLRC0nWGj93Hh+AsRMMowOWfdCJhSPAxa/Kb4pE5
         L57JHLIehV+geWJ+Y0Twdg2yqd9XTTZvUUWT4BIPh5AnbcBZmZpKNZJwEfZ9tLXp8QEN
         b23gZDSkCLS6gYlnoDkBPy84oPevuHSaOZARXl5MnJWxgJZM2E7leS2I86iwRhrbRQXO
         pMyYa3+gqspLjV4tgAS67sRc8HaJ7cUGq4EzFfC7WjkBxxiX1vkiR221N8QZpJinUAcD
         GKFQ==
X-Gm-Message-State: AOJu0YzxEyhf4LzQp9uieQATTSFY3p3HurgYahzS/PeC5Tn2UYPjkod8
	G1oXoiZ/g60OKuTfQ6SIJaYhchUWUK1aUwIwU4E0ZOUu42Nm+cAJ9Q/cRr0l
X-Gm-Gg: ASbGncuOD+8Q8lJz/Em3bn21Ys58C523Efz1q1t0lpAz9RGP9Pr2GVTxb/nthImceor
	lH1mEPV4v0HOUAEy6v3l4//P83lTd/L8Ee2w0HnsgcyyMKiMzLYvwkj3lAfXOIJfQIvJpowsfDb
	KkovKQrpwQeyNwmomGVfnkSOnPEs2vY5PxgsBwioD9i0ZmZVEiD2dvbA1MUgffSDCzmOLgczi3w
	Ew0O64tOxEXtiyKmUgqLiAuFaseUWI91ttrMn6SWlk5+ocGxtIWobenxddPv/g95i3m5jiFzqTi
	9lGOdRsW6X8iHhy5gRRCoJMzXggJfDV4OdVHndzLK6ej4LqKKP7s8xtxmWLHb9BkI0UVbbZFOWh
	VOnUGprc3XyxXaKeoIqWyUlU/rQx6QdUMFA==
X-Google-Smtp-Source: AGHT+IFIQnukrgus2qrA5ItgZI3Gp/gl98qJ2l25EmToC5gRCEpleLMTbwX2R9d5nnXocE7rxTDWfw==
X-Received: by 2002:a05:6a00:4b11:b0:772:2ca8:9378 with SMTP id d2e1a72fcca58-7723e341374mr15214041b3a.21.1756847321583;
        Tue, 02 Sep 2025 14:08:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.61.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f59sm14235662b3a.77.2025.09.02.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:08:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
References:
 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: fixes for adaptive ADD_ADDR
 retransmission timeout
Message-ID: <a2154f65-aa3b-4a97-ce51-2b11326c2541@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 21:08:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_capable =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17413711600

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5b20b8115e21
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D998127


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
