Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76A34D92E
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947363; cv=none; b=JZoBzU9p4xyKeD470Q9/VCAwAtSckkkZRJTrMFF5Trd3/tt/4t6a7+hbiN5B6IcOVmBqwGbhmtVUQ+4OruDmnYq7+bsziKkiNc8zRI2Yo0Ktm0awWArYIh7O0nLxMg3qpLyeGMFuqPylTxl8ygOzFev3cYfYdRybdlgGE73McaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947363; c=relaxed/simple;
	bh=r6hONlGn3+rr6oo8lR118MTMTWwDB8drkdIeVtlQxXM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WQFEWOTbizpRNMArtCn1SCJTBgvh58vvpTU4g67R5TEAXcp59xXkvCy2rLya6wvfNnoqdgpsMTSOBBUlp7hI2J+elg+8Q1PPP0ZZvZn44AvD5Lc7CnoXlJRRUl1YuHD77r8TTg4Ki0C25Y8XTtg0OOnEdzc0It5dYZqCTWa7dRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVImXh1n; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVImXh1n"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4eda26a04bfso22508091cf.2
        for <mptcp@lists.linux.dev>; Fri, 05 Dec 2025 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764947358; x=1765552158; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avj/X1Eu4pqtc9161bCQ2LqO04KnqCiSI17knd/RN64=;
        b=VVImXh1nVpDP26x+izBsIy12XRX8VlLMkxKwQlkp747I+3UJbAk2ur+e8pd/b+PfKD
         cl//ayh/nCrdASbCVkWxL8Dp7+LlEeeEPtG4de7EdNaln2jdQmiVKwNxYUbSHmm0j7Z/
         fb+S1ATl+TdGwRdrZJ5ZrjjFBOnObDiVblynJCNK3CWHaXl9kaR8Xnq8ljV8QouTEyNl
         oIBI/fbXf50cDJD6YOjT8mNx3PGZQeTnELuUJRTbDom2Q8eQomT+MvnrsKmLs7Vur/tf
         R/Kb6SrTfZQmPpNueu9FDHM/Wf+t7YpZRhIYFhE92Z/pLk5mhGd0WWwzcQOY4lgXY1R5
         0ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947358; x=1765552158;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avj/X1Eu4pqtc9161bCQ2LqO04KnqCiSI17knd/RN64=;
        b=dGGTYevNaMIqSWXvcfRug13JXRzL7u5wF9H83Wg8NiQL3eLrdXx+QJtniZosk5ZXkS
         hUPrE67U5hV/e16nx5Bx6zizoUGCHf/FxyqIRgNEDTrbZhErAEljo/wurscSDLZcgg2I
         sVcstfcwCQkEwOPwonX+0Mf86Rvdid1QAk1jfLFS7Hvezsk1QvGNejo1k3vvdLQfnS0P
         T0mVrTBd/FWsvLGnLOaYgwvWYDQFrSqU4PCmdBau5MFPJP2frO1YLlVZ5/omL0OmUnvX
         YkDgPAnsLTUVW7W/H22+zyc32u7kgGINR6bVv2ZGBpAvNnthe89ijsb8jL7QnXJkYtzH
         6HXw==
X-Gm-Message-State: AOJu0YzEpHqEY9jecFBbv8CflKzQHsmg7Sl2hNneHY2jwwgnvBRbebCl
	pZKViXS82I9ZGL1eWrbZVyUrTTH70PtF80B93gadLdz9FanCxCBtNkM=
X-Gm-Gg: ASbGnctk6ii028NXzNJDG/uA/hJtu7CrbgS07XlzwJmxA6AE9zpbBn2zvGSPtQkJnT6
	XEi9eDQEdZLAOEDFVkZSUOyHZbzUR07Nae9lQ8FGg1APSt2HSTQiCv1VIzMOJfOFqQe7zeRGYPs
	nXW5+YF03iIFDmkZU1SLBuDayEaNoxWV1acBSYlcTGm6/pyGdsb/q31BkQq6dlXhVkCMmnBsMd3
	SWdO4emeM4GLqxb6FqrZ9AszOtn5TIrwimRCBZhv77CkMIKpTNeerUxEaNBM0H/V09ur/3bHNsF
	qw+b3duu0e37D5CxtQjCq2N3PNG5Le92tsYqk5P3A65GCaOS+M6ppwxqZsbPBGkdmvTnUVEnOOO
	Z57aJyyBkOl3nZvwpyqyxAVCz0xY7v4u/MCzPCtZDGts/aqof9RmEdddOfR/6tKsteIBAltwqkJ
	gMFvV7eUSFi07rYG6Uf2HR7XkgyOaPLycR
X-Google-Smtp-Source: AGHT+IFtqkok2rn4FkWRI+/ue2PZql44/AGqaXYuh0QH6gYlAfADkGydxSr+aakROv5t0FaBfReAWg==
X-Received: by 2002:ac8:5fcd:0:b0:4ec:f001:e186 with SMTP id d75a77b69052e-4f0176561a5mr146750801cf.62.1764947353179;
        Fri, 05 Dec 2025 07:09:13 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d0171asm28537701cf.20.2025.12.05.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:09:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1764928598.git.pabeni@redhat.com>
References: <cover.1764928598.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: fix warn on bad status
Message-ID: <ed72601d-56d2-acbd-075b-3ea8fd86e05e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Dec 2025 15:09:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_dss =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19965087423

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ed0dfd57a2bc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1030787


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
