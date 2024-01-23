Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A033CCA
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047317; cv=none; b=q0k49Cadw2EDKyaVnXpwApzLOjDL9jkCTZEhX0SaeAcODHGEouyQ/nQFi5C5frLaSD0kQwS6SI6gXdqBTIZIu/+se8jcmwvgCaSrN6Zq9V6krqx7X1sOIhhq/EcvLKcfYMkZo23UpFsiH+DiUxld3cSqqiuHN/dPbrgCfnN26CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047317; c=relaxed/simple;
	bh=2CKz0u+zV5hrhiN5Qdl5x5vSYyt0NGBr4wTnW03G4cE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eLfnmbw+plDdxC4AQJ+cZ4cvefpYBWvLZX0RmHBbJKhGhwv+ZEIhhHQafvIZpul8GqvVytpA9Xd3HIw3E0FhSVXD/k1CFNAIbwS/TS8wMaKlFEVjtU2gusxf0uG1hKV6UFYeGXJZDhvHmoRrzkGLUm5Zfi8LaDBeUHMxpOxRgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPGcuJHL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPGcuJHL"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78329cb6742so308387485a.0
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047315; x=1706652115; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKglC1AbXv9+nRUkZG2dGlrGYAs8HMh6l7dpysI7x8U=;
        b=XPGcuJHLRktf2uaaE4XzLnKKTipZbWIa2M2GMlbu0rmkUnVDDouxtNhFkHDe26yo8e
         Bf8DYQiHAkjn5y05XVOElSyyP6nPotgBENKALDlzYBTlzCbHkUTdd40MaqQeiEHnyh6L
         YU8EVgjrxC2KC8BAMf1Dlf/Ls5GeDwO+KunA9/FpZ18fJ5lFAazNedCgTskHwH2gz+Jc
         VBpncBevOXdFJa49ViK3JO/LdFkdDcGD1rhJTgMYjYufYkE0AX0zMVAuu17O9GRsEygG
         99RSB7iyFDUlpvobXWftLQy1gEVHRy39HJMNIlPGaziehOAk1KR/5oRaRjaMNwA69cQB
         iD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047315; x=1706652115;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKglC1AbXv9+nRUkZG2dGlrGYAs8HMh6l7dpysI7x8U=;
        b=ZohWf8sG4UpIWAXafSoo7sLvLysBVj0v189raVFjgKUyN1HdATfAtZR36+s9caJWbb
         K/xXmXr7WLybs3TDFqkNiCQNC6FSjls8z83CB2aAbbKSun1WLKQqpvTe+UzPmqafpxZG
         h16jUN8X2JmVXTxhcwCXaUEuFR0VQXBbXi4ph7aPzMyszXec6HMBYwckZJ+2frzPoVj6
         JtRA4++1X17LykQqwgRF96BqIqGsOrDAnrN62qxOkwlWcPDEdah8p4houYkxigjUPdgE
         MjGBRZEeB3xfwfEQ9ovK+SysTn5m3Vy6KSHfGc4nHYrJI2LDCRVjuHZL6eY35oCrPoeS
         LfaA==
X-Gm-Message-State: AOJu0YzQ1oAH7RxlCQZZCn+kzbyg+OlWKhJMakvDcpSRvAKqxFv2/iDC
	a9203rTcYsYf/egJv5WZ7N8nKE6yFZ8JUIp0J+/qxw0UsMwOJZg=
X-Google-Smtp-Source: AGHT+IHo3VHfJ7k564+gzc2/euF4W/AwRws6Aw1a1LOJk1OstEIDbMJu02oFV+jix43HOHMYDp57oA==
X-Received: by 2002:a05:620a:2489:b0:783:8f1d:a995 with SMTP id i9-20020a05620a248900b007838f1da995mr7486777qkn.102.1706047314785;
        Tue, 23 Jan 2024 14:01:54 -0800 (PST)
Received: from [127.0.0.1] ([74.249.21.243])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a0f8900b00783189b0aeasm3480377qkn.46.2024.01.23.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:01:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
References:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Subject: Re: mptcp: fix data re-injection from stale subflow: Tests Results
Message-ID: <15089fae-0afb-90de-41a8-eee70b75d48b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 22:01:53 +0000
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
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7631907725

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/035781441dd7


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
