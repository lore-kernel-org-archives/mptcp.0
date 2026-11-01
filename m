Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793525244;
	b=l9mYsssqyNeARZhESc1wtWST3BMtRjdEXYTty73peRzsQMKlqjdmswDI8cJSYp164j8s
	 XREvNgju4Txj01ghBQHU5iemunDr7B2dGiazIluLrZ5dHN4616bKcjjnpaROkBFY2u71Y
	 rMT7teWLf8Du8ykpSgvJjIDpCz1eRTxbYXEBi7voN1BbnL1Pd7G4PkapztfavBxC5M8Sq
	 ebHRUP0GiPWhYyHDpQjTt9kvtwMxqSnyGT0jcTgIMdq3EUgcn2xbBUgQPiIaAlxhPtB3F
	 1vK7zU5LoYgbgypcSg1KhbFJ5QuGlxxcnQo7oIqavXTXggd3G9fF61l4nxmN0BoRgSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793525244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ahyekyQaEg9qyumspQnODGsMl4xs4QsJZ0tyVCAio2E=;
	b=tjo4p5nqqS7w6/tkP4dpI8ktOw0FG8dwGT7HdgkMSFZM1Gvcb7TKuscVd/McipyjH3gG
	 CSCsVuaJk0dQXfTQGp+9r9OQaZdocqDYUO3yjFIz8nLFmjx9n798X68GqjKtlcEkOZMCN
	 o0yOH5VP4E9GU/4m3QpDd4ChxHupaR0ea0NtOw7cqmQcnnH4LKeaVAteF0rAJ9UCji2oH
	 Z8K/eP+cUMkamL//koG5Js0swWfJ1U4Dk4cKp1Hnj4wMl0IZzbmiCTr3k3tKwxaMa+oom
	 BDadOOvM1VHgPQYjmrqZ5ivYRwvvlPO13DKRPAjwnHNGAlAvpAoPp0QK08+DK1hnxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1i0d14Q;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06417606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 09:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06417606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1i0d14Q
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so3143168eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793525243; x=1794130043; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ahyekyQaEg9qyumspQnODGsMl4xs4QsJZ0tyVCAio2E=;
        b=H1i0d14QAXR2u0YG37phaLJ7PYgD/0am/dKGKjgKU3z+vWJXhIksekt8JPsCE6gAko
         4QA9+akkf1lU2tzmzbo7/aZkCltU00yzYSlCv5V4DE/tChSIYsPYTOlob25rJNZ54HU8
         sryl5WVBL3RvEbyYt15sCx13nOpxa5wC0Dotxy4XNCUE7XzbAZegxbIgkOF0qBzSuI/q
         RRzDk/ICDd2SgUqPZrNUBagVGkgT/3LOxzHE5t54urLuOM9925Pq6QTPvBQLHWyHM9tz
         mf7ck4il1A8GwFVBFdSFm3cRrY8EYr7DRRJWHQFNrRF6BUkr0Dku2bQdSyUr4lDUNLu/
         bjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793525243; x=1794130043;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahyekyQaEg9qyumspQnODGsMl4xs4QsJZ0tyVCAio2E=;
        b=cHfQXOnhPu7GysgioHfOTHSJPBIR9do3/Ei+R5VEV9bvzZpAfkFpY31pmgHhx55Qq5
         mj2/vrNY1I/BG5OpuLX379E52zloxs7lYgJdoAKSMIlLAKCwINgIMPIHY7nuEN5cEdqy
         L/s0yfLqEWrwjgYU60UGM2OOhg5Fe4NCjlIRnrqr/CsyN6Mdj9Lom3Akdhjv9c2ucpHK
         wamoHOvHZvpA4uTbnHGiLwWkGdHidrmEGc/NebA5p/VgY3MSjILGCTuqrSBYSRtUhJ+L
         YBfmKqvm5UDt+4b3sg8nJc3StWkzXEWTIr1DPPFygEzmG9ZoI0shmHJvoZ6P0jmN7wE/
         VJfQ==
X-Gm-Message-State: AFq9FYKAZKdelAQZQbUpyIfAYjY60IRO1YlGfO13nvNb1eMC2pnmjl1w
	b3dzueaRYOGt1/cvGzdmNek6As18hxUzGQUQiZ8Jc2GtFxNuQpNRmaQ=
X-Gm-Gg: AYBFou1Hfq/nxIDR28wjSFXSFbF+RFKKA6P7yUIpPAx9Q/tlwziOjTwZK2CdKaVNf/i
	Kd4aV1x3EtvlaaREc6Ik2ioBEywEob5DLaS+xR4GkyOpvizoxfbpTbC97WmDJuzciEu0bqHEpPz
	HQe8p6AQrK3oO6+F4IbWg+hQqEmLGW9xwPGZq2b64Evaf9seJLt9+Gz9ooK1ciw+NuUnhwFwSMW
	cUHLtwJfqkzn5yqAmPejxPL3xa5E/0Ve46J2Rwi3fv7Diim2cCG6Q6uQ8iWYxvJg/BChVQHvu2A
	M0xFe5egUrQPK0Elyj9vc+AkCpbALm7vAAjZcQCZ6jPYMyZchhAthn86YAnoqKHDDTfCeG3fUqH
	9WMfU9QoXFnkeIf8q9Kpy4CKZQoYq5aVVkz//3Gah0xE8Nt/xWDzUZWuGiZS8YePm3j9AgdV3nv
	jwosn0FBFymoCAxHpdb6t/rR+tQzKuShNIoqVinaihwpmnu+OPCbDPKbHtGtflLWG3w+PZ+RHbO
	mHuec8Ab2/fIR3uizdXocccWT2PAcs+SNLxxzmu/qGcAIfnokYgffUfptKNdDYQBlWayxOrIBI6
	eDB/mXtDZ1nU5xr97+Rr+DkxbwRaDckwxq6V1599eg==
X-Received: by 2002:a05:693c:88c9:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-36a42444bf2mr11329488eec.19.1793525242952;
        Sun, 01 Nov 2026 01:27:22 -0800 (PST)
Received: from github.com ([20.172.109.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm29545576eec.25.2026.11.01.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:27:22 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v14 0/6] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <535f1172-1ebb-ad7a-1f7b-c70a3673126b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 09:27:21 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Unstable: 1 failed test(s): error:mptcp-perf =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/41285859293

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f558d12747=
8a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1197992


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
