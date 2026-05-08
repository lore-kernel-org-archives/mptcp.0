Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2F3E51E3
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266463; cv=none; b=AxTVOcumyr0/N2KRdH3hA70AnB8ybnNhIhOORhRK+wf36u89MzZdFNDiPcqmbV3jFtBHG/nPcfWVzJYcZBN9zbE+dYgVL/232n373HZGcrrEMT0axAP7OdwnSt4lrKBmXwLQ6VqiGbAQvSIh2bvZUJ9FIXr/5noF4TbII0st9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266463; c=relaxed/simple;
	bh=prEQi8I7KzQQjNNBCQrbFnA9x9Y1xsK4mq7bcrIkaw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PNpcToDQw3wT49oNcSS/3Q0dCBOn5e9+UkijVOPDdzEe3Zk2FOr8MckLPcT+h/77pvDkoEpX4oJz7Aqdl7tc+blDm3pPD0x2wFq+eOfoKQTzfLcQF4Fdmk5nFmpD7grDIILpp+ZwG6sf2TM8iHsTeJEMpEa2JkF9eXj4WKGsBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWVpqcGv; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWVpqcGv"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so6156072eec.1
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778266461; x=1778871261; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIOU6et6p0H4ejq93T5jo++Pf5sSwGiYFYU9CPbY7Ag=;
        b=oWVpqcGvDcMsMaXtGtQ6w9trqSK+PuO3j7ihp6sxTMPJINFGr8yWwlF3HiTcK6wn92
         mQxLmUYtrd4YYUXCZ6G/xSWwpS728u/iWY5++iOWA9QfVm+oYAJaod47TNSssVnOy3xA
         RW5EWiqQ1sFacO09RCVLCBj0rnaKOwbjTbGkVNwkJ+Jmqosl+Ek9zl8MAl41ZOp1p2D3
         kD3TtStBGd4+KNUw6dXbMmQNFEZ0Jb2RUriwfJ5KlJnyr8kC4JOxvAVzDUFmEXeRZ7NL
         zN5gQGalm5PgjdD4dlB8lWHujI3qEhdejDBikpr8q2Fgyhdl1VXm0VeHFkigoMlnRWW4
         bvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266461; x=1778871261;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIOU6et6p0H4ejq93T5jo++Pf5sSwGiYFYU9CPbY7Ag=;
        b=XDuc+J/+89t1hlStW8HR6+Y1DIfXch43vwvVxX4JP47rCsq4D5mraXylgalxz8qk9P
         N6qozgT2FOTq6Ekkd/Z6uDsdpifSJBhj3XzdsuvMQ+oFNuBVNLXM5k2pmWoeLDUaFr3x
         SKQDHiOO/cpDQAkclmJuJVsqclEv24XBBRJRp4J7rzEk6yTNjsCa/CGluDqxeiIcv4xD
         APlzTe6PLprze68+1dSeOev4noSnS6LwHOyamso68BHlXHhH/9Lpjjkmimm/uufbEv/o
         YD8qSiBriU7ZyzWM7zxpF96RHT8BzpxgteEYXdtZmUW66SK/ibHgUr7qPdjUxpNVFtAU
         GwrA==
X-Gm-Message-State: AOJu0YzqmNZH+/EHoSEoE+YPpIHNqJsJbBzaTCMfe4/gyZmyCRkti17M
	b2h8hOKIywv0DQS2dKUYoWmbhxQ3AMOeCirf2rgJ0HJcIxMpuJmZ35o=
X-Gm-Gg: Acq92OGA7ABWws44g7jI71Uf3B2kRjaLPoDa1U5ar2+bddHl+N/srYMduXFRAWX8aHE
	aFJI+jLOwxlmTG4SQ5ALRHOP0UvjGh9XkdwRAMTGkxgGO8z1zjh10A8BpcWyYcR2EvristooBjw
	gf/LPD8fFmNgSePBqBYc43kPlpNeX8kVcYy/x+ApG/DNWoR5LztUBE4xuHs98T7i5nwZaQ4HtPO
	pqlhtnM9t+2i/0fpTtD6EvRrV+iQXh8aVsqeva0hqjNDS2C2BWOXIx2mRR8GNasR008U1QwAdUq
	nbUFadk1IfSXz4emITS7j3Q5ez5AVxfd8kb6zlF2xkyaWt47MhJEt/tw9iqws48yr+EXAKl3qOt
	BL8eDFgEDTQy4/AAUs/tY6i/FXwrj+youS2BGST31lqECD3LXkMGDPeysRyyY6LNQXzfkxF9y+i
	lFa1DnmHf3xXxBdbuizWqyXYV2nqknrP2E0Ai0xA==
X-Received: by 2002:a05:7300:ac82:b0:2ea:5057:a31d with SMTP id 5a478bee46e88-2f54ad72b1cmr7273366eec.1.1778266461327;
        Fri, 08 May 2026 11:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.109.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm1983659eec.0.2026.05.08.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:54:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
References:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
Message-ID: <3b0ed116-015e-665b-13e7-b65bed9dab24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 18:54:20 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/255713=
80159

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bbcbfb2925e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091768


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
