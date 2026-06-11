Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369373DC4D8
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189810; cv=none; b=lKcgSzHB9QFpxGU5FsIa3Yqsd45d6Ng2F1R6xgMFb2ug5n1YCXTnwoQasz2Png0LLyrEAt9GD4tvcxa3aJOFm4aufaRrDU7m5WLDESjlIGCIx88teJ27jbjTvK2cUTl4ad6G7d66ZObw+Z4rlJvbRWX9hoVaPTxoNMK863m24RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189810; c=relaxed/simple;
	bh=YRJnNKW/WvSIg5YR+4ykJOifDZNJJT4nEK3/n4Iky1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GonIZk6RJTmwi5MwCX8msPUFPR+VzBqIeFoULY5tn+6SXc6ApK1OqqVSM21hc2f/6gwnc2/YXSc9e/twY0LeDnCYv6tQ308wXZ67smv2ldhrBznaYZOPRUc6WfOVcWoGS657hs/wEsNwC+7xeggPMYKXRKJAhrwTQHXopnPfIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfWwJ7K5; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfWwJ7K5"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e83724bfso10299237eec.0
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781189808; x=1781794608; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW1pBdHAAalSBULf8G8s0F6Vax9vqdqOz7DGMRrSf3U=;
        b=qfWwJ7K5vWArpNcS5QBw0IOE5NMZYMI5yU6+O0Hmt97JRPn3jRmXKTAbaA0T+79i2U
         HPHgsVEFRyhq3JY/CnNmcVmRvd1tSqObu8SpfUF2iQdl9Y3SP2mKpbF7Lu8aUm9y5wkR
         zMH55yEWDOmfyeMCy5zrLZXKPqsspNN0SioDZdd7geyZ7issSFTnR0vFdYF+U9fGLIR7
         rogLTKlZFmKyrPMNh9VPZfRQY1fKL/Powc1IuvEBccxIehSUiDIX8wDhII2id58DG1uL
         +FdLbNQHm5XpwKLqvgJhe/VEYaK5LHuJCyxB9IrOwESMtAwtqNV6V8tuVRuQnRBrwiDp
         29Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189808; x=1781794608;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW1pBdHAAalSBULf8G8s0F6Vax9vqdqOz7DGMRrSf3U=;
        b=Xzu1Y2+elgsjMTa0ZhGISTcybHyqTHXdFprGx5s3U93QfpUsQydpknaX+U/L176pUR
         jvTSmvKnQlh1uJV1w2uJR8d9zewGgPDCi4ORuw+Afrv0k5cd0DpCdLRscdFlgKU2Iu6a
         jprOy6YN29HV3SXEl9/z3Cm5m73hpTRZzCpwkO3DpWJx8II05HMlNgWO3suAkpCh+0Wc
         24A0bEgUpnFLvIIQx8MiTk2H98LIzn7h3G9zjuZKTLt6Orzsxd1O9Aa2XFbPQfdS8J8t
         WboMfNEqPOauSKDr0mikWf8b6QIRFXk7qwGDJbUQod9k+EkqSHuAVdCs+Drrkgzl/+vh
         svGQ==
X-Gm-Message-State: AOJu0Yyy0inCjVM1mTW+m399xe+AECER2GCBuKsv9TcLH30sRDyWYsH5
	AUrJ4T9etCOztt6v5FYmPN24teu+KRkAsX+3xzubfANTrhiQ+DfZPEQ=
X-Gm-Gg: Acq92OHtEup22dnaWV9mxpUbaiwdOdU0pJNxzux1LeeYENFyroUSqfDmn6ScvvSW039
	5L/LLZ7ffAXfmzchg9iIUSt8qxDuItGs5aEWSTb5lOwnXX9sGIAtD3jm62v6gVXlsfDwxa2obWB
	OlAJz+MPVC3vzo5y2SPNFN2uapzx565Am4CO68l0a+DnDfFr/x2ajU2di9SFnaeaesk07zy0nvQ
	aeG6mhjqkqjSclOlEvjnF5F4qTLW4Tsz+KoI/GP5093tgmvtpkxoSC3PMKa+62UQQMrcfIx8JeT
	PVZbLWMl6lD56Rfz9lOozacJ9wp3OqPmMP/CWSCiU45s5JhvnWSOOIqbhN9ZPvFG/qcGC8i7ZqM
	NE6e7EJ79KO+/uQYlVUS04Vn5BROg1aIF9GM6ARR3Sh+Y0q5eawZUFnayU5gI7Gbom+Zwpn9PEe
	9tu7dzx2ErJQQEsdzEe+2MjdBsDEzwazN1ybtUg4q2jOKQkeJl
X-Received: by 2002:a05:7300:8c09:b0:303:f295:4db2 with SMTP id 5a478bee46e88-30804172660mr2266928eec.0.1781189807984;
        Thu, 11 Jun 2026 07:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.125.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c47afbsm3235415eec.10.2026.06.11.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:56:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Wyatt Feng <bronzed_45_vested@icloud.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
References:
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
Subject: Re: [PATCH mptcp_net-next 1/1] mptcp: fastopen: only mark MPTFO
 subflows with SYN data
Message-ID: <06d96c53-8284-0573-89cf-76292aa69e95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:56:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Wyatt,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/273512=
17630

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cf5ad7ddd3d5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1106932


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
