Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40514A06
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595968; cv=none; b=c8RV6PQ2TJjidcoNI3h9J2PdTXOIO75xvooQpUHsxr3RJP+sM7Qch6jIexpb5BYZm3O5KIrQNldecjadBdfGYbZWS8yLbL06nIT0YyH46DNgjv0DWiAIC/0N+mcKwLrc3dZtpjD4RNCx95K4+o49Op10baCG1we8JScq5Nhw+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595968; c=relaxed/simple;
	bh=WXE+cYscnbzCEQXq/iibomJ3pXUbK/1cIQySkC9Kmfg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SXaaKNi28yX5vW6ZJ7HjTmO1DgoNfvHw5dqyWPLnZyz+Q1Sn/LXCmLjoKNWZBrS1PWYVFnJl8XGdRQJPyZgKTq+jDo16vVhHPl+11kuZ/qb/SsDdOic46g1rPakCE/ZIMSVu1tBo59cdV35RqjkPI1EYTxV1BttW/iVty/IlCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKndWRAB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKndWRAB"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-707365f4d47so14644396d6.1
        for <mptcp@lists.linux.dev>; Thu, 07 Aug 2025 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595966; x=1755200766; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JY+7v7Nd02zuSB4PCwmOr4n/5ZDpefrkt55DA/VjRk=;
        b=LKndWRABlr0vf+UbSUVsSpPZFk4Myr9EEzyd+HTTElIeUhyKB1izcZgWpVNLfW3OFt
         TnbiT2cUPtC3bKc1dVNINNM70/27SCx/Mkvq9Am1zCZjk2rcoEJcS1YunZbItKrtwjre
         EAkt7r5FLvuWXAxh12PahCNVvPxRCbEuZE/fcu3XPLWkYyJkFmVIBlRBPVbhdFwKnySd
         R1e42o0g1bjjm9qGL9Nk3QTFOWTbWLUf8/sjM508fz7kvopor9yZnKkQjfdNT9nSkCdb
         3ZxyhvI3WscJc1mKvIUNQRB9774dmzEmYOZlqeNq53Xbwu4FTl9hNLLnaTzDhH1WET0n
         CIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595966; x=1755200766;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JY+7v7Nd02zuSB4PCwmOr4n/5ZDpefrkt55DA/VjRk=;
        b=lOcWpcOxCuaOWDgKhn0tvELPDr5GOjPaAsU9ytMro8TaoIuaVefFYNwGvh6DuOdM7l
         nwoF6t2pBmiLnfp7187d4ntwaMA5mdYYG726EOZUMr+JEpSP7RiiaFpH67RIwiFU2qnQ
         ViUzr3zDReMcKCifo28C7XguO168G2pTjqvGtYoyWcwYxxbtTROgJuc9QH+j1SnqG2UT
         L1Bavxr2kDeBdptGRhkCcDnMrl395nOPpHaoezzNzIJvBpfVQWgba2yPkriQLyaX33tH
         of9Eb8biYkogcqzH+yXiDjtWfMVwqbXmMdjcEj31mTNpBwZu/oVnZ9G6oqInytC5y2tt
         w/iw==
X-Gm-Message-State: AOJu0Yzlvae6rL6JQzv2vesOXRGF217kwnBEYWIfphELDCLIUp89v8lB
	CqWYxcoRPpqz6RHhac9cj418NyqddxWDhpoX3m/yGpf7bfeX/z1SLPDcMD01
X-Gm-Gg: ASbGncsB/1g+BN4BPgEMFKaZ+p2F74SAN3EexRB0BoWYLiPB1AsDOpw/pbsNimBOrds
	Quga79tvD9feyZqQK46OLPs/losz9KyFNUaTzl7ZZzaEiINroC674ClIGEpbR4T9eLc0tyLWRU+
	ApEHsfoep1386RJaCV5O/6LruYrxbW8pKa66wtowij7EEFVm5hDB8ZrLky2CJmK1J5lqac4g4Jb
	wbcV1BDEVc0g0a2xIe4JtA/3PVpdcrq76TD9v6N/h/vDMHm72/GhwTIGNRpHM9IqKfXT55jf9fx
	F3krcgdn5ZQnMb2HPROgMenzXt4QQQpNIq1Pd/CZqGaRO0yPFBVtfFnwhCYf5Hkd6p/gXQmiAQv
	bbnHbXuX8f6uwc+LIxZim8SWn2YvsRMujDA==
X-Google-Smtp-Source: AGHT+IHcDpuo/6PEsYeLH5ILDELdCR57kpmtsCuu2K9kEMn27Jt4YCEsXCKFDHIJmsc3CxkSTDb78w==
X-Received: by 2002:ad4:4e52:0:b0:709:9979:24f with SMTP id 6a1803df08f44-709997904c6mr9259796d6.19.1754595965791;
        Thu, 07 Aug 2025 12:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da46esm103726906d6.3.2025.08.07.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:46:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
References: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
Subject: Re: [PATCH mptcp-next] mptcp: record subflows in RPS table
Message-ID: <c4777ed7-0b1f-9fb2-a589-d7f8ffe4f881@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Aug 2025 19:46:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Christoph,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16812537653

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8452b3707158
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D989208


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
