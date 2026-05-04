Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B23783C7
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913733; cv=none; b=uWIXgo/lrwyKPe7z4IT8gr5HNPMHRz6kEdetCHJ7/E/oWxcIDiqA4B3/sSJsAiDu5e8h2D5Qj7hXJ43thy8zmn0Ns/JorQWMDOWlO22qlIQSQFcybt5wU5wRv9I9fsYet1jf0RViYPkDPTseUyVLQ3VcgqlIHPKiFrcCOc93bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913733; c=relaxed/simple;
	bh=5sfrVd9DGhzM8emUNcTA6OuaDmDo2bs5omLuiqAEtHI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OaKYEi9dvYNmKKHdUHK4p+kcXQs6EOxWQUPXeEwUpvypyE0DN5ftbEFpCw2ccS5uJiYyafhu8TrsYY4cZxDUPS0U5fii9W/HqPLZpDgPZxxooKNcJfe38V3C2nArnyQzoH4LDSBw2hu7etGIevOsTdGJdWKJYmsGQwZSgWSzPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ8Sdvtx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ8Sdvtx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-900fa9f178dso199771185a.1
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777913731; x=1778518531; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1mbWee8dEfCbS7JFH25qrSEAHIaRJVmSRWSdLzOKh8=;
        b=gQ8SdvtxAI1DeOidaMBdsgXLFFIv8c0lUdGZI5RmvfkvXu0x2DcAmMB3G8VRmcW/i3
         /OcmVzETrLDjCoLFeGQxufgKoCKq3QeZe4dnkSbaeSzViv31X8LJe8rN1DlHImmgorbU
         Iy8I6ZH6tI7oVWKxWK8Yky9P0sl30uuw21n8hxyYj3HkFPl3WwPo6i93+FtpoJtfYRqy
         7nv6jOk/2ONrqLljWiXYmpwi4/8HGDVtgmWCq3TRuTcdVokcAQyY3cXyCuw9upporVc1
         LacUSSX/eKJ5sQRiAPYIx/7cODZaiHMC+maiew75ACK2TBj1odcSTPwpZLnc8F246+/W
         6q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913731; x=1778518531;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1mbWee8dEfCbS7JFH25qrSEAHIaRJVmSRWSdLzOKh8=;
        b=jn07SZR2FP9vkt/JWOjeI3NnZprOZ5sOyIzCnt5l6q5PsTUq5fKz3IwZ8DI74hNcr9
         R+QvJgC4aGV2g4anHpK6LGM7xqyHX71lKPcTi2M3O0aWyNMT138GisJrZCUi23P/XLRJ
         IKdpfOhkVtuSUD+1Ejf3AEd7TG/2cjBsAJ7jnymnA2fhuEPTEyRdkI2HEWDLSlnz8ok+
         hCbEoOM8mrQOJb2D+IESWlzMQaplhhxtd0/r1aP15nPbqjd0LnOvFU2n0aSumiJN8FKa
         i1wYCgA/kDCDHGhPD8zkv8xgD+r+KAI1oPWiHiG+dCiNLKxP0aNDdR4haQPyyFz+N1fW
         DE8A==
X-Gm-Message-State: AOJu0Yxr/XD4YkYNKKN04gVlyVII2W4T99M5KWpO0QjYRqb8E63c7oJ0
	sCbFybRuME0gDVB3BW8Bd22LwxDD2WZWuK/V7EOasqf2CS7tKcWJQjGP0Pgl
X-Gm-Gg: AeBDievtYRWso7DOMeaik5qOuddofm3+CB8hxfmmZDRRvrCSPS5IUT+qjgUdxTe8DB/
	51ajMnJZfb3Wn3EwpXlHpuqkSyClIBfjFITuo/vue/8+aO6oZOHnMDQXRHZSEYWZhbvwkxHcx/n
	21In70d4FDolEZQlYVb+FsgKlJ0koKPN436uyRSsGYvKCvpxx+XrpQcO9L0/F1B8XKlY4MeObYb
	xVwWsS85PrxAd1YGYa2i+RaLlqtSE4TrdAhxZhh9Wl/OPAAtYTg0Hfbz06IDks/1CH6UIAOn0LQ
	FLVBvQjEVtXNoMk3QEolCvM3zeymlz0m8PX8Mb0K8zuGRVbwmPA7uaH+PkPWTVx0BvwzFtw5fVi
	TWPLC5bvtlipgVBwiuq+js6cY7xPKYfhui4k0CH3z4J8E6gy0QGzffLGcGRcUjoMZX92gJdRtoy
	9nqOA1S+ta1mQR7XrdX4oTC0WrIgjFa5l8NcYJXKzA9sW6odF0
X-Received: by 2002:a05:620a:1991:b0:8cd:942e:82dc with SMTP id af79cd13be357-8fd17e40756mr1511558285a.41.1777913731249;
        Mon, 04 May 2026 09:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1182919785a.36.2026.05.04.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:55:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777908248.git.pabeni@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
Message-ID: <0ad44769-2d1a-47f7-6076-fb902e2a57f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 16:55:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/253291=
94631

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4ee2213ed212
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1089374


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
