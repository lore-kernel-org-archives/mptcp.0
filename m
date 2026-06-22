Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53446C2FF
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123370; cv=none; b=SFHnvlsf+y6kSqt+L56pJk60D9Zv0tGYPVd3qtVI5uhdESifPOQf8flRMJFTfaZDS2wSJT+jGAk1hKCWW+INJBwxkAa+XfZXdLRYehJUlXGjIiQUfg7MHWnn05qA8uEgKZbckpbyzDdjZTrzSlYWsPs0DFiOOJhLhK/+JJ3k/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123370; c=relaxed/simple;
	bh=GL3lcSR3MMLcBbDmCHDQYL77B2gbF9IP0C9iqR9E9m8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hWWw8aOYYqJf3ov5v4+hjGc7u2rn7Irdnb7o91Liet2x7G3Ri8R1d/spuE80KzE7q8KRuyZFT+dxtZ23byPvJq10cDsM0ZTVZndNs7MVnFvQJkgzcT7i1OAk07hrVvTncl0eNDyZIhj76+McZiWUaFBAMZUMdqTUGSAA5we2x/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=govuGGkh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="govuGGkh"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519ddebce3dso34603701cf.0
        for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782123368; x=1782728168; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwQWwtAkseNJkAIIj8VMD9oIncJ3pfhgXq1kWUYRvRE=;
        b=govuGGkhyy11xzWBN8l25tSrEh4cORgKR91G4keIjt+W+LQsefqXJ4gBpoa7Fls2y8
         uAzP2TXpxyBw5wfoS2qJ1DloZ7oPCdDB/D34lLOJCpfoOqvTHA5Acki/qGy9+XR8Vs3L
         920WEjjTDxo4goP3heIWQp4TxIJxrahVbFG38+wlr9AC7HwRhhXxU1WEO5uMEjaq0NXb
         ZdID38dixo+PHFVvLoR7jAGZ2A1JiUkiDcM7hpdU8yNwCvblJBcn5UhpQ8+73fX3zYTr
         e5eeG+PvMF0bU0Jw2ldstbxwGYEG6Jv+X4hgU6pmfPhSF/IbiTvrBV19HzPgg/fz6GLM
         QfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782123368; x=1782728168;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwQWwtAkseNJkAIIj8VMD9oIncJ3pfhgXq1kWUYRvRE=;
        b=LuhodssPPJIZYl/F5k2koQr+Ft49rhsagzy5AHoEmW24GWgnUp3tN4PhskFh2eUTIb
         6tYgrwI21izCDyXo/rIN9gEoRlOlwjob6uvmGNh2fuvWNtLwaXYzS7UYg/FQj4YCToJs
         bo2bsMGaxy0aPnkny4XvAQXJ/29BdIFaxUj6+GuwLf4i6plaDfjzLSOII1p3zbvWxLsG
         ZJvp02nmZiL1lk3/SmM0M8AhuCvpSrotrM22XgXH3xJch8WbTCLcaU7rZsRRWUpqpuwv
         YpPgpksLQ4xScihvXBGdeykI6iwV4e9hrugExGHPdGLAuT+vEZ8qK1KJJ6cBYQFMlEux
         6APw==
X-Gm-Message-State: AOJu0YyY+m1ze9InNvG+e1GMsd/yv/VzrVofLV11xIyfsognppVwVFFu
	DrUa3qW/dY1f/CP1KWK9X2wNEwblHrDpipeIPl5IR/Vv5PS2UG31RQ1XQvPJ
X-Gm-Gg: AfdE7cno5pzx5fFiMo0GNm1XvfBQpNe02X7a5eih1v5RAwFz0sHZlsNXT83xpen1ifC
	G5+8JKoPDETj5jlKEGHZoZYKMd/8BdgWhHROIXeDxwQce2NfDrMuZjwbOTrlyvKyBi+cNfM4pvp
	4E2tXNEbiPKx91N1BW+SexUbHeVq6Rg7fu/VaZJll904V75hqeXvLm8ml0cOt5kmCA0jz2+psh6
	Dw1KljiGC2Bgp/XGGpn3RFx4RX1eggurkXuf1wyXfiZCi7mAM4udeapArc5t+zyyHPPeFxs6Aly
	1+Fxi94CHARrSR0wA+Y9AMY5MbYL3mdHfQ2ndpTMQfm8Pb36OkRuY7MkwEUyM69/D74f4eqHsJC
	fXwxdf1D2SLA6L2MgrmLWexOeAgZ9j/yZuwRJ4GR505y3qu6cetkzzj+0hPTjJx6Bos7enE8L7d
	OQYWF65UB3TA+S/wK/yZUhaaEzPw==
X-Received: by 2002:ac8:6699:0:b0:519:f2b7:26d0 with SMTP id d75a77b69052e-519f2b72e24mr140499031cf.15.1782123368116;
        Mon, 22 Jun 2026 03:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.237.143.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0989f0a8sm63462301cf.22.2026.06.22.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:16:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v4 0/2] mptcp: pm: fix stale ADD_ADDR entry on id 0
 removal
Message-ID: <10bc23c9-33ec-fed7-045a-2aa813ced1a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:16:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Script error! =
=E2=9D=93
- KVM Validation: normal (only selftest_mptcp_join): Script error=
! =E2=9D=93
- KVM Validation: debug (except selftest_mptcp_join): Script =
error! =E2=9D=93
- KVM Validation: debug (only selftest_mptcp_join): Script=
 error! =E2=9D=93
- KVM Validation: btf-normal (only bpftest_all): Script =
error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/27944189431

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/279ca4d41984
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114633


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
