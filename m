Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086783DEAD3
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921675; cv=pass; b=F48LChaek8sFZ0lOYWUYN8ouRtac9YAngY25y6Kjo+/lYRZ/+BTF34OSjU9eqrAnv+DM81jbIwzn0Kb0YQvcPU+kokdwOEfwFK5XiztCE3vocW5NYp+YTLLPDkL8BPEcxWyw9X7z9ePCVGMGzxI4N4LPtpVTUKpTQ3LvqNtKDCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921675; c=relaxed/simple;
	bh=SFYV2WaZ3KR0u1Xwung7OxN5MEfXoB9EAmO06GPqHGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2blFL3xNuN671E3uS0M+0hvNadMVyhKJycz133bING1a1ba4EmWeySfgNQXSUFWeTvlLTSsTJ6Yv+/4FowC3RRxp2k8o6yhLS6a/BnnxPelCpl0U1a6LW11f8eOFXTcWmCCrd7al1uFaspxsgCyQKZkEMebRrkoIZUH8sPqcpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3gCg5Lu; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3gCg5Lu"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50fbd79350dso43834971cf.3
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 12:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777921673; cv=none;
        d=google.com; s=arc-20240605;
        b=a+DBBaM8mimrnTiP1MxFXxfdsI8a5FJYsEaW5i1mXq83t6CBod+YKJk8p3Y+albGgn
         7qaXD8wL0Gy8abE9JLQ7IjFT57+B72JkXnTwr+NwRQ3lPdK2foPzT8CT5uXILoaCnx1B
         R1Rr2oYdkJalS8XCyOUatu+1Lcz/8TJKU0TTjWDJtUUR2pWRNK47bSq1H0IqJcUz9WFK
         zcPzJs0M9w2jcSqdBgSVEyjTpmPOR1vyoC8vJDhL3b/RgKYkkgWv4o1oBjsI6zWGMbc5
         w+CVHHN+WRtwR31ZdjBo0wrYyXCKZI4Y5Sm5gFkkUJb0eLdzEoPGMHdnw7z/qtg2fOAI
         5/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIlvg+UAUgqyDAlwClHHqgLLxErxdpSJOsiJ5UFj1ho=;
        fh=EH++s4Pp222m8t4i1afYnDN65AlO/qPSmACH4lv30pQ=;
        b=QB8tVawciUQFAb3kj83HvHThQYx0fMavEjOSSY77/+LAAjVmTBfw2oXCVv+DwLpSxT
         e1fV/58WfjwFfVlNGfr+Ab1mRq6ADwFAv/qUlX03LxR2HQ9ZCuMjN0Vm1s2CH+gLagk+
         mxmtkroMeEQdcqM+FgyuCLPbsK8Rjgxs6ULtYThyZG8HUhI0ZIro5hTrH2/XUDbssvPM
         N30y6XnI7OHNbiJjLFGvxuXTfMcrt4ucsbibPWyhHdoRbXmMgeEGW29aLHH8e3tmdBtr
         +oCU82hYHnI/Ym/b1y+UFRrlkh3OslklUKQFz3GQMwMshTKPCucjiNIIFHh0Ahqfpd2f
         Gifg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777921673; x=1778526473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIlvg+UAUgqyDAlwClHHqgLLxErxdpSJOsiJ5UFj1ho=;
        b=l3gCg5LuU55hpDOmBdHAYmv4NhThdRRBiQPAAiPZIFl8xCBocT05a6FSAH0Jmgd6F0
         /fG3OSWhznpn0H1BY3SiDVzPOqke1+kUlmCd5RxH5OH3ZjxYGC2jEuwGFXL9PRIhdzZM
         KXJiVCaYHgaUOemuD5mIMy765wdKRFEVcTyD5RSCLfn73iN/cuN4zGEZH42fo8N/Jxw1
         F45eDDTB2lWDt+WQGDvN1SiKS1tk++lopWI1UxfOn15kn33kFWim7kNCaMGqEc9/kg20
         1z31owJHfUZqcwkiD7mcMmMsbt1zCldPMuWkJ3c+7F9vBMNjOpKcxNko5WyDE+OoM9TK
         Pqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921673; x=1778526473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIlvg+UAUgqyDAlwClHHqgLLxErxdpSJOsiJ5UFj1ho=;
        b=UnBfKB9UzsQEUCEX5qiDTtytiSHMIQ57aNC9lX84oPZ/HRHYBdShGkneyKrx1keZ7I
         D3Ra07ktk4z6sXh6jtfw3/TdZ03tTiE02jP8ff7R+Pqyykx4Hf2lPnJSlbpJbBYOdXM7
         DpaqLkWsRG3Uuh50MfOhR4x/4zx1hypV0B8rLhVL5NO+xaYhQqnehcFlcQJhWuyUNty0
         Czr3NaAA3jj5iZ5wua41UFz7WtByR01NZ+tr28M1GA/MTY95qouVDK4kiU/jqYMDMzGr
         DxwLyKg33Qa3cAcGqthgWd0JR07CmUOv+nQeAAXO+9HZ2b81ke8sFXpgFtBBXlTlagc3
         sJTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qijKsJKE9uVZYEPEnRqzJRVNs4BEt819xNuDyFlu86P6HoqxYatxaTbtMgmmmtuMSZFKzaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvUJEQl4USsG8rIJsZAVeAcblKwwIxJJj82QYAWlhfp6FJqq88
	JaBBAb9lnR2Y0jfFECTRzhxsfEesa1o8yio2NsrJuOfYYANEX07b3x79jfLrvvtIKyLsuQe6GsE
	FB7iUaWv+jgYoL2vO4479nIBwNKGMgKKNy8DKsU07
X-Gm-Gg: AeBDietwEclv/yClz62mtRRSrdqTA6emzd+LgZGy96Oak/H25DqZn7+h4f1wtiEhh1U
	G+fciY4LieXZ2H9KZ+yuoio35SPdNYXl0Z4QohGu9vSvXJesJiVovRFhpCLU4KKKHmIuaqtCDwN
	ioi086/XVozFBYAZTvyverSGiqSiNIicrItZjkvr/m3a/d/lWmVl9JGv1+jnFe17rUjfyTbRmu7
	O08RRJSJjRucD6ObCxycdjanh0OF40bvHNxLzOg1Hlw6IRs1fC4Qgn+281y8kr3g8BD/aFJybNJ
	A91c2h4vf60mRxnf+XZnWV3HEla7FCVAHh90uYeq1e+Rkd9wuu7xgozQazw1g8trnP4p21GeQd8
	7T0WjPLug7+dIleLaU/N/LMDKMFrz6lJSe2bYsIND
X-Received: by 2002:a05:622a:4c8e:b0:50d:8b5a:1317 with SMTP id
 d75a77b69052e-5104be2b9b9mr160400901cf.13.1777921671974; Mon, 04 May 2026
 12:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1777908248.git.pabeni@redhat.com> <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
 <0c361889-533f-4467-b908-0774dc23f08d@redhat.com>
In-Reply-To: <0c361889-533f-4467-b908-0774dc23f08d@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 12:07:39 -0700
X-Gm-Features: AVHnY4KdZ7wP-zZM_hI7dHl94heF1D0xQJ5BnsedaS51t6a3CRnoTlNpb3N27iI
Message-ID: <CANn89iJk+0M6hAxx+L8vfLzCzo=_7E141BYty8F4CiBUM2F6hA@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 06/10] tcp: expose the tcp_collapse_ofo_queue()
 helper to mptcp usage, too
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi Eric,
>
> I'd like to re-use some existing TCP helpers (tcp_collapse_ofo_queue()
> and tcp_collapse()) in the MPTCP code, to avoid duplicating the non
> trivial logic there.
>
> The idea is that the 'struct sock *' in such helpers could be either a
> tcp_sock* or an mptcp_sock *, and the processed skbs could be sitting in
> TCP level queues or MPTCP ones.
>
> That poses some hard constraints on the sk fields that the helpers can
> access. To make them clear I'm renaming such helpers using an 'xtcp_'
> prefix.
>
> The full patch touching the TCP code is below. For completeness,  the
> whole series is available here:
>
> https://lore.kernel.org/mptcp/cover.1777908248.git.pabeni@redhat.com/T/#m=
e6eda13ec2c70fbb400b6223aa2d07a4fd3bf865
>
> but I guess most of it is not interesting for you/from TCP perspective.
>
> The MPTCP bits are not yet finalized, but I'd like to know it you would
> consider this approach doable or a complete no-go.

No concerns from my side, if we except the fact that TCP collapses are
a high risk, we might
remove them completely (or at least guard them under a sysctl)
