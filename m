Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1016B18C2C
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617075; cv=none; b=eJvYTfGdZZdsDmGIx7j83nHqNfAeUyM4asHJf2revDvPxX8UJw+wgXUnYRCpD9MX+Iw/hAyzURu3JVVAKdUJtgnOQ2L+8uaiLmKummBBu56vf3Sq3duuGPaG057rjEVCxIBRyuqLdnUmN5ohuJAOJnal+w8Z9yQEqlLrIc9bwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617075; c=relaxed/simple;
	bh=IK0smqOvUFph9zpsj7mzc4TQ1QUIz/dTXueEVP2L6Fw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=D22+70UK9AoOxKW0nJEq4ex8rQ4c9kEkCMQefWWx7mXL3j/lPBr24eXvu0OgZ9dtZecxjh75KxysrApBekBefa/7fvICc5K6VI3HmLART1hHYV+iWjIMiS+iBzqaZNrgheOxN20DJIJCClHgfLMFxpzIHcd87SQQyx6FjiVFu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3wWEan+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3wWEan+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29516a36affso15354285ad.3
        for <mptcp@lists.linux.dev>; Sat, 08 Nov 2025 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617073; x=1763221873; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJSPIXzpUrnIEfePnKwODRItw1YZdLEK+Zq4vIM4gXA=;
        b=j3wWEan++Nx4pp6AiCM/j/IxCQcgWzzlawCSokveRUoAhkusUzD672gpPjxIzgMAba
         FMZ3V6ihCsbOK2Io1YWF/9mzX2f8MkKiNq6lsJVn8hDTXWv/YW+TU0bd/wJo0Rj+Lk3j
         gv7+kP+BMjoIr+5IyZayOrOuHV1G/lJk+5g/nuDNQQLKAqXhvw/Y1dVdZHSaKqMU6Bh9
         zngpNPvcO3LjfU0Mwq+CaG/P+B0WYeEGss64mwRimGQumGNsl5Vs5kRbhXy8yXU9SBGL
         Z/zR1AtmGaGJA4Pk9ua8R7CWEXzEquOWT4k3pq9RRMmTmdZyGiD3mfXRLvR3/S4jWTws
         cqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617073; x=1763221873;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJSPIXzpUrnIEfePnKwODRItw1YZdLEK+Zq4vIM4gXA=;
        b=NFCD58Lej8OayHj0YI9So17/v30zbECtBsDD+k6RcjG+TiXgwhPsb9HYMdHcXvkudc
         SCi0vqumGrB347wR1f83UZPCo7JKBk2bJXHAC+wx/M1b8b5u/MRZcby2TsNol6wfOq0B
         JRqWEMccfhUEh8gOl1IEm10xQO6Pt1q8H4kcerzw+P0F2RLzOG64e0G4/sgYMWl1iM7w
         zeWMk19Cin4TnOgsWRzdPJOVi6GiQi4i5YnS7LLkLiPLtpgYTjzKjD0oWHVoALRDbhfc
         KYAXvdi6Oj8dodBmZw796ZZ+oPbWS/XO3g7KMFXaIHuWaW02KXD/uEPrg5P4PB7Fd7jv
         wdVg==
X-Gm-Message-State: AOJu0YxvTFqynA6ZoJmQ69h265ONHLYEUrHnXg7T4LV5wL6RkQB3GdmY
	cFruw3Ofzjd1S/k/04LO5PAXHrH44/RxJizT9u1gncyiFaYKuyy5Uzg=
X-Gm-Gg: ASbGncvFzDAUuOOySkalNWrkZR8qL0JgEdw02kIILk0UNx44L4SGSNhk/8muy8fkxHK
	q8L4j2vELLRnR+RiZjBHJEWWhevtPjMLwg0sEXS6CLo+1A0kzqLcGy/qfIwPDBInLegjAsdg6B0
	njJAsnNoocTgtptwqnVrAw7xObtXq7zonAK+3wqwC240LDlgUVw90FyNOuoXQyO/f4pEKpqbQKZ
	sxH7pl+S7DmuBuEoFz6MATCM7Z6iB+rCeqvDTrnRDsDmR2fhSNUyT1iEW2N+ikyX17Ip2FJpxeL
	UFZm20sCaJS420xYYAKlFBBrELGSS/pQTLKn9ywAr5ACO+41DC1QsMIRI8UFTAa9WjhGGCxez9L
	GvyF7S5rQXMdvZgD9EGW0RnvdE7C3z/kMK9jQsF5xtEoFTTPXY6yk/miYVJEc1GiaLAW+oNN8dg
	IYZFuQQiCNdts=
X-Google-Smtp-Source: AGHT+IF/PIwFd9P6E50VRI8Sy2ddhiLYtiDq2owZ77FaK7EV1boCa/H4SdVcsnpJvyWexpb53LEgVg==
X-Received: by 2002:a17:902:f551:b0:294:f711:baa with SMTP id d9443c01a7336-297e540d880mr40917175ad.2.1762617073249;
        Sat, 08 Nov 2025 07:51:13 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cb47dbsm93194775ad.96.2025.11.08.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 07:51:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] selftests: mptcp: get stats just before
 timing out
Message-ID: <85c34a09-a9f4-48ec-57c4-a697f4d7dbf9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Nov 2025 15:51:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: debug =
(only selftest_mptcp_join): Critical: KMemLeak =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191944=
69113

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1b663aa68ecf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1021197


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
