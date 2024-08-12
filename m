Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0215C154
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448699; cv=none; b=SLdwqwrpG69M/KLH5gMNTpW1mYJp5iEt8q6g2xFu2dEseNYSITa827TD+HbH/ro0TAwUhXvD0tt7rGCaK0SoCZn2zxGKiH+3lahOlkc6ZPz7r7xUyaIOIS7FI50rlzqkqHAVv+wjlHWdMK03MA/DAN/An2gysdw3fj6JX3jNKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448699; c=relaxed/simple;
	bh=cKtRbCxrLupi2Wa8PPblif11mQLjPQHTJQSNUZIZiAc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MFDZbvRFumIXy/KgEB3E/1HhSnn7jLwLVeaWtaJQCKUmT5TXcfWDNyZUptBvKTQ08MDuwHH8XuZAwnvRd5sNM/Nlgn8SKwiMhn3/VlU6ZpgYtAGDx9GDYLj5nZZxg3fsHJQE91fD7Q3IcXHGngsFYH1MtlJscEM4nvIvvWsMyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bud0sQhB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bud0sQhB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39aeccc6377so15082195ab.1
        for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723448697; x=1724053497; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKj58xl6ireWa4cEYjGtUo9Tl4mc6QE6qQ800gwYwgg=;
        b=Bud0sQhBLCSAOtzZz8bK1U7yWOW+6oai/WuOYImcuoW4OuqWOvAVsOtr9xvAP/KvHs
         jB0t7odEsyU7lzow2wMfPoLqqddlkUqr7Mh8Y5Vicqise85ektT7lSYCjPydzask0So1
         TxgOmi/n2+MUX6qkNLaFpnMRpOih9WMLd8U6jf7Ldzq6kYGF7T0ewK6VqPlFxy6o6K+y
         6NYYm5oHomyH3TrS6xleh3eGCEgpfTgom4NHX4fKlLsANEeHq4YETjW+4/FoJPmzNotQ
         5d4FFPXfHaOzeWFzYAxBxR63D/q4ItSwK7Sw6mm4p7zLF25iiz7oWaZA4X4/HraYZqAy
         8MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723448697; x=1724053497;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKj58xl6ireWa4cEYjGtUo9Tl4mc6QE6qQ800gwYwgg=;
        b=dYXBaGj8Rrf0xMCXpZ/FCdpCDjEQiv5qkrqr06mqndT0Mp8YYkigjRu/lcLOPZAbNt
         A1gclE4Bq9e8ZTJsVrfORlFEI5Ub61hUfc1OGD8rxBaF9kinTgNEhkPyClHGVIrIeF6P
         izeDiVxOOJhslP1X6R3T5pbA8PSp4+CseyPQe7T9GenNxbg9oJ+HBTWuyYszik+SvVHH
         bv76WE7ikkgbf3nOtBUtWA18ThYsCZ3xhSesX6fuimx4N+TTK+zP1XLHxryMdQYyQZUQ
         1saTvF9579GV2hGWBp39971vA8q/HScLrQawhYuw/xr6q2zt+t3dET+N2eCSg9KqqAoR
         OSYg==
X-Gm-Message-State: AOJu0YwbsWsIHsSDKS0FCrwbgSCQqWBOw8TN8xYlt6DDrPpFsVxyvZky
	mysGcxZlPKVqyF0sWBgY44QEjQ44Ujs0sn5jjPzcYXNDc+5Si4Y=
X-Google-Smtp-Source: AGHT+IEEvVgzYPOaB46qTcb6q+HMGihNOIYAUVsGEkC8qya1D83JWsh8lHv63TdzoxImiQhwoKoehg==
X-Received: by 2002:a05:6e02:216a:b0:39a:14f7:1c02 with SMTP id e9e14a558f8ab-39b7484d222mr111645885ab.3.1723448696948;
        Mon, 12 Aug 2024 00:44:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.29.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe3b4fbsm3705116a12.48.2024.08.12.00.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 00:44:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240812065024.GA19719@asgard.redhat.com>
References: <20240812065024.GA19719@asgard.redhat.com>
Subject: Re: [PATCH net-next v2] mptcp: correct
 MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size
Message-ID: <b6a8f617-f006-f6e3-2bc2-1c56ee23a69a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Aug 2024 07:44:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eugene,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10347391530

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/986721c2093b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D878657


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
