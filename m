Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6716D308
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715576; cv=none; b=oziqFVY0mS/8l+s/1i1bvLUC9cEV+ZER5neSx1MsNUjoXY8iPAQH7coMZHItPmkt6SjfFK0miSvXLFDDSR53yFD0HkN/tq1oqxBT2aEXPQf3Jn1u9TtjCvUVTk2kU4C9CxC7CzhvH22N0YHyvQpA3ExXb8bOxTYflm71YppcpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715576; c=relaxed/simple;
	bh=FhPeO/Ccdz69zJtRknIQGH+nwvcDvPF7K4L/xPqcNbE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=q54v7Djkua7zsNXUc/x2Z1tQnsSGnxJWTBsUhd6I8hUnwQKepBGMgaZjDQn0xF1Bl8eCmsQHgVIdU8FoOOMsiFOxJIGCZcKDA4lFP7TezBETUJl2W3apBtcCBQhr/y8hJeNDfE40+ERLr2Jib8nyQirRePMay54bjtOPN0/itEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK0TSE66; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK0TSE66"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-650b8e0a6ceso11089397b3.3
        for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720715574; x=1721320374; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W41bE8qwyEHzHnYE6j67Sl6sn6z4C0+ekdXxbqZ7SWI=;
        b=eK0TSE662Wp70/e+lj04303KlGrHFLQVWMrak+yrhZNtju+/4nNwH4EvZZ7JPObUeY
         BZqlMrO++AKsieft0DzzayNjyx4dUmfPlX++gGPeLdFYnDg+Q6heJOxIWBIdXCCOtfku
         0FlvvYGfTQtlm/IEurk4+Vd21OZM+HZF85xs+JvMliGiSzBEq46cfXvkQAUQL5mGsQWP
         ThJCe5/qTtnKcDrHJDw1n8PFYkOaGAkvIU4J1A1woYCe2Mg99aergZ5r6c/0TFdP1tst
         e2rl4bReQeQaPnEi9BKiGDHVslJaF5oCCEAJ0Z7v6eyBOFrmX09gXDwHdredLGtU/qDL
         yDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715574; x=1721320374;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W41bE8qwyEHzHnYE6j67Sl6sn6z4C0+ekdXxbqZ7SWI=;
        b=UmeYZhwVS7p6YHtkNqtVFNpejHs+w0CE0KWWrXMHPGj5FD5s235YKCpQIiDXHOb6DZ
         29duNnM5ATBxbaJwZ+FFVUmvPOGRGBuzIBbm36A4wlDM2vNTttqy2gUQDYk7Df5N0BPP
         /7JnilQpYOvfq5Sp4eDsu2clg+xblOJd6P1rDTg4NGt+E98BMXit+kkcDMfYb+A+nHmK
         kFwaUCP+cdhBzVA/519WyfQXK8n2Y4dWVewPGoBqyfRDfQ4SgUORSaxbyduwyLnUWPze
         Ncw50GkZ5nyScCMSdp42NXRxDj8vw+iWIgJEWfS+EijJwmfMgcLJyhdsLmWUdwbMINcQ
         Qs0A==
X-Gm-Message-State: AOJu0YxS6WWPi3qZI2/fy5oKqtI4/zXLjNeF7BRrE4mXJC3FNkzDkSR4
	pLl9m+A6YOW+D+DYOgMGUqU1FgkSLXKiQEX0BjjBHkyDCM+0GF0=
X-Google-Smtp-Source: AGHT+IGCXR8RKJPWpVtBPpmcTttJMR5X1r/nJe5Qi4BJEt+g91beRmtGsu/4bWdBBltAQ6c+40H4Rg==
X-Received: by 2002:a81:b549:0:b0:650:8d5c:9611 with SMTP id 00721157ae682-658f07d75b3mr80799617b3.52.1720715574187;
        Thu, 11 Jul 2024 09:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.132.29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e5317d85sm11417837b3.63.2024.07.11.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:32:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
Subject: Re: [PATCH mptcp-net 0/6] mptcp: fix inconsistent backup usage
Message-ID: <5d289983-12d6-8fdf-5a05-7bc7b80d8d3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2024 16:32:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 4 failed test(s): packetdrill_mp_join =
packetdrill_mp_prio packetdrill_regressions packetdrill_syscalls =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 4 failed test(s): =
packetdrill_mp_join packetdrill_mp_prio packetdrill_regressions =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all):=
 Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/9894657332

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/76eafcd3c7=
62
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D870531


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
