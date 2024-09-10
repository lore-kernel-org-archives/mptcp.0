Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994661FE1
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990595; cv=none; b=R2q+gyFXzt1sWbFWvM6FFR8ofJm0xmSyFuwJeAuIU0otDZbpR3lmJEmIbGMrZv/VUHkBPFxNHXk0xuPorWTfjKT9hN2Vlm+33kCs6ZNfUbyLh6DkDayLv3JzrGMORVROEfLRnj8NoEq+yN93Y1aDcqEBeKOm/e84VSaxLUSBPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990595; c=relaxed/simple;
	bh=vSDBG1232z9SX4lQuGCVdqtsa7fxcQTewS40GaG8too=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JgkD5fkFX6bjo4Buv2elf683UsB+oEFmZ1QGyryafFqrArQ0YLyee0fH8IGbPLAbgXIgoy05AgEgiu3Fnl6m+ikT7IQQakcirHHXrKAbm75gGPaidVpZXDZtGXXvr7CGNKN84gNyKLIoMiMTJ0bcQOfVAvTUptPdqctBFBZbpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8R3TRUa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8R3TRUa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so52145a12.1
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990594; x=1726595394; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra4Ia5sHyRmLoKijVQkECTJB+lBcIUH9RBAwRotpr0s=;
        b=U8R3TRUaCbZ5XJ2gW0CukoocmZPjkTIORfC02/Ynx94IprMfDbxQ91zSefKzq1mUA7
         19IIPB8/5z4P8qTFKPPjyeTcCz1W54fiPVB5SFyanKNYxkkDOVJNPSVM1XQM3B2bS0Tu
         RjOpQG+o1455jjvNciweiBznVJ1A7Q0gqloiN4ghESBIDps2cGgcM4qE709yIlgrfI2p
         0BFanG4H42Ev/T2PM0IAVgaukS9V8ehzKTXEbq+mP/ED+tLtMCekPTnTbjX/HDDggclI
         EsL5a97RUZoy3tiM39K64ByLhwevDnM4vJdMDtZnpl/vw+TBXe6yDxKk8J24k7bxePzG
         kkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990594; x=1726595394;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ra4Ia5sHyRmLoKijVQkECTJB+lBcIUH9RBAwRotpr0s=;
        b=fyX0iRIWzqSRFdhE52M/eRy70/ddRICmuqHEULQ90ueqr5WuLpyXjjnYjTdGFQSwAi
         dG+B3yd3efGvXpYXNEuIq0yMPghzUIEDyPffz6zFc3hn6fs/6RARFFuoGDDwaGI2zpkv
         KEqlPIaV11MQUjKBBsJGB6HYsRhOkCf0noZQgs6b61MpDeH6Vgwdi1oZjVDoImb5bvcG
         tSUtXWkzPyVWQHJ8xX6+ZeAyefM8vIBDFV5ds1Y9a3j/UpOWf+oempQxcZezyaOXj4iO
         UvKWuvUvBzHgFhiJ/QaNSA5gal2abOvP3Uf5KmmuALjfd7VTiLIyn5LHwQi3nfjBP+da
         xP7Q==
X-Gm-Message-State: AOJu0YxV7dZ1Ma3IsE0vgSguysGa6Lgm2MpcmmTHeHna2kWhw0dh5ljT
	9skB3Iv1WcQ3QB7mJ0TUkfW8v0vDJM43BeQfmVy7GfBzLhv3J7wKhDrm
X-Google-Smtp-Source: AGHT+IH143+QbmZgKlrgSo2t8kawcOBQLhWqV4nyeAbw4yWKga1B1VHFg77PLnrZk30BEGGqEfPAtw==
X-Received: by 2002:a17:903:2a90:b0:206:aa47:adc0 with SMTP id d9443c01a7336-2074c6dcfdbmr28609185ad.24.1725990593369;
        Tue, 10 Sep 2024 10:49:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.36.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3de2sm5969498a12.29.2024.09.10.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:49:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
References:
 <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: misc. small fixes
Message-ID: <cfbf5c15-7d32-b636-5d77-8d5b4397b5e7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 17:49:51 +0000
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
uns/10797305656

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fba3bf5d0fe7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888987


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
