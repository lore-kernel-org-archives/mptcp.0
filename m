Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868067E73
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519417; cv=none; b=N3roYXkknNH6G+ZeUrshv7XC/YWvFgd4lwBqcBLKhyL6dS8p2/iWSZa61Gi5hwwmPhX+lJKeaXlEoemeO93I5oV+YXMM82/qnMfEaiSmhPbBE7tdsW7MRBrcmiowwLZ5VlOJO3IQp9Y0ya0a5//lEvE/NfIV3J1mcvUHKca8QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519417; c=relaxed/simple;
	bh=U+Q+tjB13/JIY6ulasMgsqhW8L0qV31P4orghjj4JtU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mAukgsff/w+8fGiFVfmWI6xAc9cEjoO7IeOmV4GJvCH2e8HLSMOySNeU55k7QRsjGkaTD0fxtFqV0WDdukxhFrJFtbiHwTQCy/YRjUMWGNQ/F9rYfkVoCwte5DiUGCBfGz0YytuEDCQuBGZO+tDqjFFWs33JMdg26K0FViY0d/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTQVUBZ6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTQVUBZ6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787225a2addso323350885a.0
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 04:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708519415; x=1709124215; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTyyIzDjFD03Nd81B2ExZCCsO93XIr6Mbe6luGw0xyI=;
        b=QTQVUBZ6kBxVdahn32Gx5kVLdKu520d4LqK46RTw+RpwXfBL+cESdHdNpNGKC2meZv
         jwluRQFEFR+oIwW+CNkp1jiRr54en1tQXDC9hYR4fs696yWz+oOgqWF66F8rg5UgwgYb
         sfbgPUJ5sGQltXJ0rwSyEEVT9+KKYOb3BabhIzj3v4MYOghnKsGymNaVI+IJVjSL7yZU
         LQhbCByicRejHfa3I4OCKZUS2LXy6HpjeKhXVLpjaoTh14tdaNjWl1tkeQs2EuoQ3Dhu
         3MZv9e8LFh+hhHOw6RnEKblL8jrM4/wldaOYvEyiisTiD4kcVPyLjfHZsMvqFnJWe3QB
         hMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519415; x=1709124215;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTyyIzDjFD03Nd81B2ExZCCsO93XIr6Mbe6luGw0xyI=;
        b=FC8E44y9zju9nAhfnjRgsq2lUmyJlzVnA+HsyMrUoWRAvb1G6Fx42z3j2bHTTPNMyB
         pNK7qhQElsGEqPS5VtoiBEQSws7GkcFG2LnhA6V4JjcjE5xXNFXdtPuefFDy6FqCBplM
         MvdPWRLz5JGtUmmkH/iyufeftK4sFszxjWc9h6EAQnizXe+LMrr4zjxmi6TtmD+ELkFZ
         RXvu+FXyrrLBqrFcj209U3JXMWAIvzckhm/jI+9sk3juSv1uMdgraguWAvtRH/BZ6r2L
         oTytsn64htmo7FC3cExRHqYnqO2yH0t1cyba3Ey8LD69fUMl7n7phWt71WUJfeC9wHs5
         3zSA==
X-Gm-Message-State: AOJu0YxA9qJz3zAJytKHJvHMOMKYjNcpqZS/HiOuUbfxxb7w3ZnuyUDX
	vxrgZ8LvjihQqZqTzj8L/Ui+Zqgihjrgq/IGCP1OlikezWLASDY=
X-Google-Smtp-Source: AGHT+IGSVNLdqjBJ6VAVpWyj0UtULcJPVUNmCwxsPbqbIvx4EX5XufOOTmaXQj+Kk4ikpVhJ6d1qAA==
X-Received: by 2002:ae9:e41a:0:b0:785:d6a9:734f with SMTP id q26-20020ae9e41a000000b00785d6a9734fmr18100685qkc.46.1708519414757;
        Wed, 21 Feb 2024 04:43:34 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.53])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b007878458ba10sm556682qki.59.2024.02.21.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:43:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
References:
 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: explicitly trigger the listener diag
 code-path: Tests Results
Message-ID: <8da41d33-1bf2-2e06-730a-525c3694db2a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 12:43:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7988706773

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dac9a523a0e5


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
