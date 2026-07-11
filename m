Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC8378D7B
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764639; cv=none; b=c2aSXo64B/NWOoBFSGMLEczpBRUpMAzjEM+D64qeFgj0qVdfB/npTKX17ew2TKgsqjLVAUWRS4btoycTINUt7HmBtPFCJpr1BOdKCMQuKfu0o/rwY1gcvyu3eq9qREKSKD+k/ja9s5seM4YQL7r7rEMjAuvBIp041v4gSMB5Eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764639; c=relaxed/simple;
	bh=KGvTFyLEb1CbDmVF9lVz7gF9YqkYBHx9YEv0wO/2COM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Is+Hwj7etCnE0om+O/GM2MTfS1vFw0zHoJC/iM7zRXALeN8Zu0rzEceQ8JhWjDXT9it58Z0tsr3x2HjmE/kNigWLVNg7jIp4ok9a0DfwCbK1SRxLUwclhzwPzsLgJkJ/0bDxw13/XgMCGMbAN+1zr06K48d5DKlwviHa+vQrDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBpSk8Wl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBpSk8Wl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2808dbc3so10361271cf.1
        for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783764637; x=1784369437; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/6zTlxleHF/eIOr7HUsGcFJsRctBUljR4uWSr/if8sA=;
        b=fBpSk8Wl8XaV0PSenHiP2/6TRawAKRXbzmDEAB9gycHFnj4Ogl2QaaGuXDD/XTYAHg
         PuiHXZxGWIJpuOEbIZQGhqh9FfZ0K1/kasu5UesDeRRc4mvGjR2lJSfBiRJaTUsz3ZMD
         57BGy+i4tYVHuQE6kPWaQ51oyzj6u61OkJHKVvY0fVPmg63cM/AoiwMTzQDmq6tdSSPM
         y3ZllHCNysZNWtNpXHmp4LrrtqP/awWNgvscFDg0AxR/h3eLb2vWNIar1kcMOBGj6Q1k
         ZD10V4VDQBTUNaNGMB3EZQt0ABRGiedCy1C5cSArqPf3tLfJfPrcOxXoTusvDN+kXTJJ
         wgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783764637; x=1784369437;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6zTlxleHF/eIOr7HUsGcFJsRctBUljR4uWSr/if8sA=;
        b=PBe0QIOx2cUOusW7wPr0REk0El2cEsaThQTOr3rfcqe/1/DV3mka/0umhf6lAjQO5p
         rpneEytR1Nz59hsebNIyO6wCC1ANrEEwFaAE/ipZICnkgMvwAmRgfm4qjMWwnCpcsqIM
         wpL4yROJJwCur3AY3LblbaLPt8FiiSZiehI3SHQSvVSsY1bvdlBp8n+UCqbzBGRU3sM2
         fhc6TaVUUcjfC00hlfzFsE1/kWFUvlzq+KDiKB0ZIVG227y6faUWlIw/RZa3nfC7gDRy
         kibXcD93rSEDf+wxM8T3ROCQ/kbOLPQF+nayFxpuVEvhO4MP5RcyMsHKspMrkLTiI+Rr
         DhwA==
X-Gm-Message-State: AOJu0YwrejatIgr4ANSPh+06+n0h718b5H8CBO3o0hdc8ffkfDh88jI3
	pPuCX7SkHQeRKg9SEekppNKCccT50ny1xYzh6YM0Bnf36iU6wz0MBQLZmafRSBo=
X-Gm-Gg: AfdE7clo4y9B950VljC0lUjG8k03cvtFZKIjOCUqMM27XDyZtFt58/8LPvs3/QiSVb1
	mxhbpiFE2E6/1L7BTYx2F6PE7LwrG1UQ+/oRlUhFi+ij33OAuooHAn3wRk2P93GxxGAk8i3xyLs
	jL0yX2h+xCBRa2lHkZAjcmVO3hyFJuI9ljlo+gR6rHWXYC3NEyaX9KZvXpYsJV1balUetXmy5tW
	LoTO15ck3F6V6pl6GDHnrGSKd75PzJW4HcLGM4vu3jH9ZJF5aFIH6IoD0aJLHhfy5KU469+QCRR
	NOUl2/Y+3NE/QVZB9yORxE6QZEmcoM2O4/T+rZdXg3hGWRCRPhKxo3eVju5w/TnlCiLTM10cOjg
	GdnR6HSsnw2lAWOwB+xVZUgkpp/hzdRuaxBhd3QIainIqAkct/uG7/im79k5x+ULjm+1sXhjC9Y
	j+74GPVwMTkyS3SOXYTwwnuX2UN6dha2xrJpvGbQ==
X-Received: by 2002:ac8:5710:0:b0:51a:8696:cb38 with SMTP id d75a77b69052e-51cbf046dc7mr22443491cf.7.1783764636770;
        Sat, 11 Jul 2026 03:10:36 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.235.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm33297501cf.4.2026.07.11.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:10:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
References:
 <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: pm: guard the lockless MP_JOIN
 path against a NULL pm.ops
Message-ID: <80a08809-ed68-3637-2d97-4530ecfb06c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 10:10:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/291476=
47219

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1143323d7dd7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1125769


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
