Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51617BB24
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007404; cv=none; b=bhcz4UZuQDRYO1CeA9KfdiT3Cvatu8gB+7rFTssU9Kp6/kkvuodw0hTMYbteOAC0mFR2kK8U+RsQzInNAEYAzSrnxwMp3dSrEX6L8IP6148tz+wq4HlXBjTTIXszlYhFl+aeBVlnIqXx1s/VY6o3gukwCCv5Q72MdTP5jb6jbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007404; c=relaxed/simple;
	bh=3UDdDoFUWiQ1vblgj7NW8boJ6lUxnIFYsckR1dWHbgo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oGN3UdslWnyX+JaMQMBHxpRZwGlEzIW7BqLZ52LETIY598DiKX6/c8zpGm9QiysDsN24wQeYHFw+Bsjhauy4ajgTpww6eKKhOJVROYec73w5yWFL/s+zwsoUb8Uj3r06SWd9uQZQOOzlSJOdNxJ8KInlITGX9DfVjL4E+L/tiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8kOiXdS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8kOiXdS"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fed0301b1so4472341cf.3
        for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722007401; x=1722612201; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUNOOmuVTHtAmWONxYycsEBZxbVUKoVE5GBJSeqbGJc=;
        b=C8kOiXdSn1RqvS2+xT5rle4quyl6TME6cJFaDJWMbArgTRTjVlnH0TOEOYH89bFSyB
         nf6UAXZ4T/kBO65nWuCOB31AireNdb3DHnMp1BdOwq6K/3uGhneIMxUmTCcnPiAHazM5
         yQy/ql5UsmdU16qNm7JyYGmwnHFJZbfKIrmNKdOqyLBIMf/S4oebmHAwi6kzH87waWp+
         OJuGKielFF/XzZwdk6EqgG+3ffP6hwcBya6FqGJZGUZ+uj5buxGM689rTKA+5ssxy5MX
         5t0XLd2RLVq6hKG0n7va/AWxP45lsVqIWNKsQMQxVB64cYzg7a0jJaUD0enFzstXXCUG
         cifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007401; x=1722612201;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUNOOmuVTHtAmWONxYycsEBZxbVUKoVE5GBJSeqbGJc=;
        b=KfHWHsYaEYgDrB3mUfQFcyzvTtVN1MiefxbyfxZuCg+PUIYGWdcqYyiESbLsJ7MQkA
         SVtb4oOI1wSPad+C5yC1tUeBeTV53DdnmPoFa/G/eCxqDJ3c98hY8ClCktcnz4sgeK47
         WEV27CT/Mq2Iaa7dYP8yYEngHLTR/5BskhARwSPC+DVdpiL7wD9k5blX2z8slsAMcUcJ
         JK/QViSnGN+U68BHTiTj154foXr0ljMf1N7R3y23d97SSm8sF9LnDyfyhs7BPbllzzW6
         RsP22th4xK+AALthjbHm1YLRReLkbDuR14Uab14GuGtknfwAck1D7qqtjCE8Q0OCB4MW
         4RYg==
X-Gm-Message-State: AOJu0YwfDlJ8q4JsXj/K48wKqA4q3Ss0R6sz3MIS26eTDg5r89pjjnfl
	hKFrcYc9u9zDe8COcSuB3o/BjbHidMOnJbTpNBVa9Y1Q3kabMHd5O4tx
X-Google-Smtp-Source: AGHT+IGMgS95gnjrqMxIrrfx2ioI2CsRIa9rflAVAIeMlYoi9eJjOvXlQiJPkblUvOxG2b2PPVRT1A==
X-Received: by 2002:ac8:5f14:0:b0:447:dcd5:25f0 with SMTP id d75a77b69052e-45004f989dbmr1468391cf.43.1722007401416;
        Fri, 26 Jul 2024 08:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.46.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8123fb1sm14210161cf.18.2024.07.26.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:23:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Subject: Re: [PATCH mptcp-net v5 00/13] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
Message-ID: <61abe538-3b06-c7f9-eccb-29dfaea87423@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jul 2024 15:23:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10113181188

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7fbdf5eb8c37
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874103


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
