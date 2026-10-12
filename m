Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E947F77D
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807677; cv=none; b=FnAAF5gXAgrxBlySL73cgiTYOmElG4hdlF4wgHiDvpkJx2Io18Z/eAQZAo4GwFUCxphrBPIoUQgnNm8tfKSwIwAT5lQhZTYrfJdD4JAnyGYpGbBIOVq60bd/1CTsUsxgNK9vnZu4apdlyJ6Qx4PRVc0e4wIjeiXeNYK332uagaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807677; c=relaxed/simple;
	bh=tY0bY38PkI8uDER6KoScO0ahm40ekXIxR6HxmpIw4/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=odISxZLU5mFmbgjcYEzZdagCQeTZu4AM6srKMSrObcAdpFleG4GtJKY/ATwtyLRc6dqZgZ4jqePYnirtV0uieWN1OOcf1uCE9MmPkEtjx8ynReJ/n/RJcQMMtsmeKDfNPVFTlClbxUMZhj7yzHMHzE+s4Oug/1npQaVjvkfwFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMEePD0c; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMEePD0c"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dd059478dcso1346524eaf.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791807674; x=1792412474; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fdgHH3IwtyXA2hpqImliKrVX8n66ewcRaAz00Slc3hw=;
        b=dMEePD0cfh/9Qwa9Y0geXS4E6GOUDDdsCN/XkbbOel/kzHBeHN/wLSpS2otL9tjdfj
         OswE49ZWbBBnKhGR/LsJpYM5GfpgO2l3n+QnL9MTk5frACnao/ToRwFC+5/7R+0n2QMu
         VG/BGEa94QnOW8sCnJh/K6riVNv53/9tbG1GyL8f121l8nEtRbNy7PgK0tI1dUNrTu6K
         BmiT1alKSEJy4o5qioqkh9wLx7aMRKwXVqBmVVxS4EHddJvJ78j/3qDoj2DjMu0pfemz
         BJkjSd1FIlq7ps1F5ciWhf3ysnQ3cESZVBNBeokWw4bNAkMNSGvQlqGbITJwC0yMGh/u
         te+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807674; x=1792412474;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdgHH3IwtyXA2hpqImliKrVX8n66ewcRaAz00Slc3hw=;
        b=M7t5kh/sykzXLwMJFt75xbZsD4Cq+9ZNCA+HFgec0aupvQZioK9QEeyr6eSbxzzR1B
         e6XvbPOU4PFGXpRzEBVXIx+j5bHZsEA+jkejrqGUHQT8oooGPwmHxW/KKmxYpifWri7H
         WzQ1kujus6Gz9sms+LiDxvyjmGRFL+DocXM8NF44SMph590mnPxK3g/B/L3Vv/Zie4pr
         8WmJcAS0COZugJhG8CsebDedNC6ia4bTRw87g65u52N4Tuqh2cMaKVDgpfatZmFuGRuI
         i3sNXavegTVCn08fdq8QPak/7ujplea2IkIN8MpnX0VJMA19hzniD9auA2WG7KYu7CVi
         QwsQ==
X-Gm-Message-State: AFq9FYINLxD6a9O4lQP0O2o/xqAVPtancHTFAmixHCyH8CI8qNQ/+U/r
	gb/R9oeGvXysrV2TDS5Afh6G/N8OFooAzDnduN2FbewatSWK644mxEw=
X-Gm-Gg: AYBFou09scRG9uu8GM5DwQzX08oMFxYH7Gu1ab2OlpBOvzkFhni1Ebt7N9ciYbrrUfy
	g1VdR++3g9Y+lh+FwZkjws32CP2z5bWeNvMdIbYkh5GQBV+x4KIuEfafoYmDS21txY85Fj483lY
	KK2tHD++vjDcFDvosd1RERzUweMTC1r4DBvqhwOBekpU5dXZgFE81AFYo5X5drzSI0p2xEdd6Nc
	C6tLN8Lwu7PFThRqu2pKaGSWhtp8ls/fGFvdIfb59fmfBaNiZhQQ9oVI7CbqIp6rJNfjjXw23Gn
	a9gdfwYYHl9xeQi4bi3lTM1wbS8SyIBoZ1RpbdZk2kgLBXnEGD2JOKi8k+JeQJ7YV34FXwJwg/L
	3VsJeSSLQOhTjHTr5MwZjMC2LSHjEHOTU25JNqYKgQIpvOKGrGVoSUN0Nvzy2gjBIIF05Qlu1sP
	uVLvvUOlF6fmHaHyRIASRAnoC6iaWamXFm9O6kiWsUppm2oHAr38DojANwbAtqDKQHjVpzBh5JZ
	SMEMwGxPQ==
X-Received: by 2002:a4a:ee14:0:b0:6dc:e1c3:b2a2 with SMTP id 006d021491bc7-6ef0f4a3c08mr7348394eaf.57.1791807674491;
        Mon, 12 Oct 2026 05:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.29.17])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f56b25672bsm3052025eaf.11.2026.10.12.05.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:21:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
References: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or
 invalid DSS options
Message-ID: <5bb72603-4e11-24f5-8bf7-1f8004ba0545@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:21:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38243692179

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b2c2369c30=
b5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1183809


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
