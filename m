Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599600;
	b=1GEJT9Bk7LcBMAUbPcVO7tsRMVvsji3vRKY980DNOZqxTX8152VVnO6GJZbHFcUQ79w/
	 +u/l+A1IOy50tRuRrZJDngfQFFHm+flbxeUVXCr3Af3bET0yMMCfIKMAF3axK+LFsSXUA
	 n+2Kry6x/dBnGRY1wnIEwab+ZZ48vbloh8JSjBQpymyRab2hGat4FXx6uVLZWqY9ya3+2
	 ITXoriMobD2l3nfZ1da7b1TRA/69J/Uq4EwrS6/u0BNvyjOx7OUxwkkZWnODuXAuR02rz
	 C90ZcCpXnjVOZ/IGKJU9Oq8ttlFlcYbCtNnnhmOoY/NUw8vo5CTPFIWDa+zB8qXFL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=n2DWaQ7oAyf3hnwhyVZDdQOyjyCDfRI8wZ9fxH5nT64=;
	b=WQi2u1n8mk7zPk70MTBU9PbI3WJyq2ah4RxMA0QgOno3DHF19dk9LJ9/jstlKasGi6iO
	 ELub7CiuoXs9FsrT4LAvvmHTC1br83fxdiC5laA7pJy3AS4H08onunidflvDhWk0RPBrG
	 o8IVIjKJTWmFjin37PRLB7RKqRMAS3HVBCzIbl+/YAbBXOQTk8siN2nAhcJtX3hWzJCDa
	 c1EYYvZE/v14MJ+qlU4ZJWQ7yQQqIFr7Avwl6I0cgTJuuuz4AtJdfjYiqabfdAZYARlxF
	 4HmpJgNRDKEOJzva2ZloIDf5EcqRbDemv2cRfjxLOIRFu6TOukUhrAJFfC54+twmwkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9T8gGNE;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B93606A332
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 09:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B93606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9T8gGNE
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-862aca1ed4dso2235366a34.0
        for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599598; x=1796204398; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n2DWaQ7oAyf3hnwhyVZDdQOyjyCDfRI8wZ9fxH5nT64=;
        b=x9T8gGNE0HuK9bwSCn/kk3Gs1/uU2i6BimEm7UBz+PTHsQhgg2JEN88U2RJP5btH7j
         LjklAy2NL3BHazwR13eoAqVqLEEUVtRWGRjttkXzq4McYqPDoU6pF7/FGBoRJQHYOQxo
         JF1PWs7VhuYx0RyQtOmqjWGHOSDRdDO7oxQrjQUWC357U+b0G63ZI0VL+PkwFV8VlGnj
         eL03CpAwpZGjUhrSgrsjeZcSRMLIhgEWhWyFnaMDypsT35YyNHGLqHVJc8xM7fDF/s1V
         dMId3sJL69HZsksu10VL1wRk8HPAz5Q19B7PRD/Du0HLvSrvaZalb2La331Hxa4sItBm
         T6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599598; x=1796204398;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2DWaQ7oAyf3hnwhyVZDdQOyjyCDfRI8wZ9fxH5nT64=;
        b=fDhbbaFiqGpKjOppyc4TCbIDdwdSh1ahJe1HqcbDlCtiMPFUXGvribrB9EjJZRhSl0
         tp18IP2+cHd/G/vwYoIe0YzU0dlQq988hNpEdm5bfODt1A9PaP9o779/kecsGk3+UVZe
         uympnZq83rjxriJos+jMR1Rdmt7JdBbyPAWE+fzEYnCjA57Vbgl1+lsnuhxW84ZrkSSQ
         1GmaTaJLPYYsloxpA8sCysr+rLjlPs6+TNczkblMmxwhUdFDu3SMKCfJMEraH6HU2UHz
         LInzHFfD8KvJeOSVK2M4Y6E5bVBXY8+pl8wQ6yo1QBryEgnP/34sf+M7dL5IY5SUFBgN
         yLsQ==
X-Gm-Message-State: APuU4Z/RNy9gjdKpyD8Bt/YX1RLPihwCQPxBJ2ApIMPV/uxjE9wXBJvy
	z7Z/Y38QkiCghkUD//IGnbG06OubrIKJCGXPYQL0Ab/ywcgt64PLCFFqaiC5Fmc=
X-Gm-Gg: AZFdTZf42Aorf2dItvyBnhatWmgzaGsYucwjJgx5Gv2qlU+vMWWtj+9esfqZCAftFbk
	RMhxSAyk6I4XhRi1eVyAwzqWteuGRC2SzImj8y8zSnGDujIQpRyPRcO9AZkKiGIn2CygAqTG248
	YBRDJHG5DtUPu0OOM9tViCRICGluagPGu+Mp6m/gt3Qpj+UHy8kDI8LEYXX7NI1o0p76mzrmezg
	RCEgbwc/g9C7CIAyEXDJEPmrGDA8JPMkarU4TzUNV7vrz2BGOpTByRZDbCrPONVtPXzlgKMQh9L
	bADOjONHNhIdx9baP8ERUU1Bc8dHp9ofiTW5oUtSIrQek+oI87aMSYkhh57hc32ISeFQ46dOFb5
	3F84MeAMl4WJl4AR7Mo1VWqIZa+zuQVKJNkdO57N/57mZ/qtASLW32p1jyJNKALuC7TnoWLV47A
	UDihi0HbAkhoSqMzs2s5RrjpaY2XzxeH3lsqnKUhdk8KFQQDiAONsCYRtlFWVzH3MxlJbBly9m9
	JrQb0TJBdTnd8YfGHBAuQUExycCy1Dhm0rHGEnYqKgjCLpo5MgbfKNSEZOiBMen7PR55+Jolyyi
	tCfn0qdILJxfXB/EubxE3smv/zfus/liWWv5FNB6nQ==
X-Received: by 2002:a05:6830:348e:b0:81e:abb6:749f with SMTP id 46e09a7af769-86315490d2emr17311325a34.8.1795599598395;
        Wed, 25 Nov 2026 01:39:58 -0800 (PST)
Received: from github.com ([52.230.180.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dcf38sm12431537a34.9.2026.11.25.01.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:39:57 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/7] mptcp: add MSG_ZEROCOPY support
Message-ID: <3bf3b8ec-c0f9-fad8-1c8c-3df0e57e3918@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:39:55 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_regressions selftest_msg_zerocopy =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Unstable: 1 failed test(s): selftest_msg_zerocopy =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 5 failed test(s): regression:sched-baseline(7) =
regression:sched-bbr(5) regression:sched-clientlim regression:sched-mem-pre=
ssure validation:sched-loss(2) =E2=9A=A0=EF=B8=8F  (3 improvements, 56 new =
outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/45570779969

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/95b50a4b8e=
72
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1221715


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
