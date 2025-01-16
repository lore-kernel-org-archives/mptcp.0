Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515A1D61B1
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016457; cv=none; b=LKmKZm2JUjL3HO3g/ILyywTW4z+u5xsF25oee9uSV0wua0fH5cKv1W2qPQofIylpqT9hnXoAyiURqbHb3k//9YPaGD/P/hZnheAhLCNiNXQFea46/8KojA6A85Fp13KSpmKZwzPHXppOZiEfeQK6cer13mEm7DwGkR5tNgAYJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016457; c=relaxed/simple;
	bh=xR3oim1bT/KkNJfRb3k8zJf4rub4RcxeD7LkjwNweIU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KiCiS/Sq8Boa0KFRQWsNfWdNAeGd1AbWwVkXqGdaWN9GDdFkFd9qJRHbjBZCdmf8VCIXWk/Fhyqh28ZR9NOtFlOOwErStA7n0CM0mOP3MrKsTrNjjBGjwTjlIROCc7GZhErovQst+w8GMZTvW6V5wIqovXMEpGbC9MLLfqIdS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbbHA3a8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbbHA3a8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so52572785a.0
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 00:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737016455; x=1737621255; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcB73MIjgQ5PIFujAS/8AH7fj+EJ08EHRdPUEVnHhjo=;
        b=FbbHA3a8Sbl/urhww2GBalghVEu7Gh+01ve+EeOYUHHuAConUNdRG++0VsJ1gw/5JG
         0eTb1QJpo8bdmq4WQX0IfesYYePisydrOuO4DwVdOuUQ5BMjMUExj7gyQ6cHMF1lM/ek
         dCwY+X690HUcLJTBYKp3+BKE4J0iiF2U41iEZkbwh3Rs/W6wp9vTKCVvx81wAOGHKyUt
         W3g4aeOMI+52lST0otV0ZIXloQOPCSYlDbkZbhOG+94TGpVfXrFmQVR7xUXP51Y1SvuM
         iyplfy3F+DwRpcc28dTd4XTtcErLmdNUTVxaR6mHqj1CnbncuqohI0AMT1mzRviOgV9g
         xigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016455; x=1737621255;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcB73MIjgQ5PIFujAS/8AH7fj+EJ08EHRdPUEVnHhjo=;
        b=tn8r7lktPMGIG2SE4YqTjmNPy0f+68hddFVykWubwTjz4jzKBN42jG0NzkT47HD0Bz
         Ejgae/PyNrjNBiiSI2YSwJ0KssxC3gSzFvzMLdR5+1zmb7NRiJr/xb3HE3FRg0/1duYM
         PtqH9PQkQ8YfkYIhHULjwRZG3XTnUFIuqLa4RPChFNbMAY1wW5WR3vT5oZ+OmGkxlXh+
         OfR0izAC4XLpZ31jJXbsmbQigsmmJiFooMla/UPDao1O2SWsGl0pmXSCOZDMfwoWmytU
         zSzJ+rJarp6BcFKtUzavYLQwr8VgX6iAzIXpfFmSyhH3OwYQw0ZNmZnirEMkTqXGLWXH
         nIhQ==
X-Gm-Message-State: AOJu0Yyokton9JbMopWC5A1wIL354Y1aQ85omwe007AvJC/pCgaTK5Ss
	vszvBkNTes4P/1hYxi0Licy9m8W2mLeEKIZ/D3WtAeR+5Mx8lorfTYTe
X-Gm-Gg: ASbGncsxsq0s9GYrH1Ack9Lh3jklAgAH/lt4SaixDOHZexx0sc4p+ICM13fk8OzRuFJ
	bJ7cEzPlbJ12IIQKOXaBCbDD/r8/nRQ/Ev17L8/3QY6huYIIySqMdRoWOr7IHScqKR8FaZSKd6e
	zK9X2NJv2p4ujMFWjk+hnzz/c1VSOHXn8YA3AqBfqa5O7D3LhVfgPHEhNfaRXf3w7ZVxA85CKkY
	G68+TJ96maTkNuZNF9PXwD3P3C+jZVcQLSjJwJ/TNkE3v7cjeFM2WLf4nQ1BzLeobZt1+CU
X-Google-Smtp-Source: AGHT+IEYcbGEYP8fDa7L4n94nHvllRsrR6Af3Fgi8osnHdV66hPr4jC6vqDad7cWNBhfKIoOPft6Dw==
X-Received: by 2002:a05:620a:4142:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7bcd970d4b8mr4829178285a.18.1737016455074;
        Thu, 16 Jan 2025 00:34:15 -0800 (PST)
Received: from [127.0.0.1] ([172.200.199.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade89283sm73622316d6.105.2025.01.16.00.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:34:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1737012165.git.tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/7] BPF path manager, part 3
Message-ID: <d8bc15ab-6677-bb72-38cf-9e197c41d3e6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jan 2025 08:34:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/12804233622

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c2cc4b634bac
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925958


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
