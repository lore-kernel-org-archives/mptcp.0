Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AA31F9BC
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214200; cv=none; b=EgAJ0dX/Fj6qPSsjA2XL90MF1QjHPJ9C2gjgyf2L8aVKN+K+eS6nA8yxSxTJg+1PtHuXEpWMwlya1FCa5TRhtfuOTsGfHm4OmUy7SolFHn8MlfDI0aKpt+zXHE7CL4snfFGKENRGO49E6vbvKs7k1zM0It8yc1eJok4klSAF6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214200; c=relaxed/simple;
	bh=FWIm8Xq/gk9nDkUNQB+yTrzQKItVHJgyTX0G/Nadueo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mWYdzEX4izctrY8hwUn9jnMoV/8MpDG10hiztQEQr3ZABjaJGf1MY0h1dKOgUKi4/I466uZyx3HscsaZ2EaZ3HLMwfI3nJkYaAsB659Jg5gqHTGSgHb++IQThTtkS+eZ2d/Zpj4IAtvY+IT/eblpFkL4kKsCoyEKoV7EMVurcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk8o67K9; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk8o67K9"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5751a9020faso2902342e0c.1
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214198; x=1779818998; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKLW+PoNWefpKZA+e7ARSyrv9+PkZSob2t0JCTgBOcA=;
        b=Qk8o67K9hTzxUSdZ0f7vHAG/GoRoOgGHHjNWQk0DxUw3C12hi3M5MuRcxgXTtsVSlK
         q8s/nSzKkQO93dYS0alx+78jVn34aMqUvYIw+GTj3PD3OxGfdcgky5pkVNhVbroXMsqd
         zAYAsf3vJlkDjgt2VLcbayzSkKfqx55oY0mXlJfAupimFl5+3Rfb1am6iIhd6gBsdPRm
         i9YSyZUeeL/R7UBazUhXCDhdaJXEBI1XbUe5Ph0pDjcHUE6PsU5MLAzcDq6tPPVdhyQN
         p48ccbrxZdttRZIXz0vb2tkwl0oIQB8YVwruhB3VLyED63tn9Dl+dEgRrA1Ju9crzU69
         Gy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214198; x=1779818998;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKLW+PoNWefpKZA+e7ARSyrv9+PkZSob2t0JCTgBOcA=;
        b=Pw5SoL17KPNqgkzvuu8otrOZwc5k6Nb9qw6sORJQEOV6+QvuDEFDy0eIwld8CMIkvR
         WbqGLGX4l8K+Eahfgsu6ZVc5WInK1jObmZKFArO396u4wjqJ2X97zNkC0RKj0DmzjgdW
         u9nXx9BIYn5cPnTZsXjHJef/b4Du/jdFeQf81r/DDJmRY+9wru8b/0+/Kqg2g8qDHPMq
         Nf6A5QBxdKl50cGriYy5bVdTjzgXWmM2hSkTh6JZvg9VAuWeO4+lGaCIEtB7seKrAWaZ
         LaeGF+hy3Lz5v9n6wQKT74wKEk0AtJmpZogY26jGCcCcJOvaGXnRFCAac67C39MUZJ+/
         a3Fg==
X-Gm-Message-State: AOJu0YzBdfJQPfV52oWRRYZ+wWglY2mARtRFU2J+SgGhJkXFwll5VbLo
	FMPc5PTOlQGYudDADXIqTfMIE2VK8noZfDnuUFwN7HNHcKHzhNxSfzA=
X-Gm-Gg: Acq92OFLCCLmB+Pnma5fLcST1wtml31h6XgwRcfrtd6J6M9r4gXXtrLoa3HJ/p0ZlFg
	nsBME/ib+0cuCplWx+n0E/M9MPkOuBIJcwwV7UKpRlp66x73u5MJfNGykxg/rgC5DWjaK9LeR7x
	nenGrt8ygy2dl5CQkdphnraldj18GKIXN1OnYL89jIsfQ4CbQQbqLM1OKQPR4zbts8c32FHOi1e
	liAviiMILiKKhLSMVR3uxLtMf0yxawIjMtO3hDj0Ahwr8R+xM4swYCPpIiDr27tQnzD/yGVULdY
	a5d6IGt7p2ReDUpH+OkMNaWkDFiXQ/TWRnSrAUXcIuME0z3LRhwGHQodSKzsN1RtP4tA+qJvTyc
	vTa6/rPIoTsknf6s0nr20UjKILd+rD8Xb8wI40AthkozZr476W2d+Et/kAWV4DzsruRpDI1i9ac
	w18UQKDjFWJFSX5ekmfEnNqcQL8qnpcUNZXKsp
X-Received: by 2002:a05:6122:4f9f:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-5760be34e4amr11963242e0c.1.1779214197591;
        Tue, 19 May 2026 11:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.152])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2d278a8sm6509329241.6.2026.05.19.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:09:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779210016.git.pabeni@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
Subject: Re: [PATCH v7 mptcp-next 0/7] mptcp: address stall under memory
 pressure
Message-ID: <5cf1382c-da42-b975-62a3-8c8d2b1b5e07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:09:56 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/261134=
01623

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23b24a4a7ecb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097528


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
