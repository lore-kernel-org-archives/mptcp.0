Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF179945
	for <mptcp@lists.linux.dev>; Wed,  7 Aug 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044249; cv=none; b=jfomAzU7i4tjKye0sU4vX9jONqfQWjjnD0qStuDdJQE20QJVcDDQA/cXdLCbUkjUaRAy+AWGrKtI3DkYnGF3VmtclDFDygJ2mOatASo472aDVs/iuXzAH9kE0bMfSyToJZsaGaZH5XJUI1331LAdgmTz0+Katw2U5iCz/WKwB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044249; c=relaxed/simple;
	bh=qqwx1gJRUQ1zex6AQPfb4Sxry5H3PLctWS+R2EpNwIM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HrYGfYFb+9lMn8OMpf7Byz2dM8bZtW7RZHAK6grbRvmB9+kbFIL7QtSHIyo2DAmRpgxXGAZBs8d2z59bOpWueIYBgu/eg6NqB5bgtgWp2mt0ZSf0pOT8gce88llahhWqy/vM0uMYUxVTc0gwnmG5o/kFWeXOPZwfNX2smKsg/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAImvrHz; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAImvrHz"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9e13ef9aaso15079b6e.1
        for <mptcp@lists.linux.dev>; Wed, 07 Aug 2024 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044247; x=1723649047; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+whv93205HO48FlOjVu3brJyKxplS9Kf8Dj2CSKzULg=;
        b=OAImvrHzRxzZdJ95jYTNIcNi1L+mBHjh3wf4+dOpr+povu9vsvzps4DH3WG+sEmjGf
         RlmQkU2JUEOapU8J9NnhaXrwJANzaNH0LVj31scKe513+N0fX39aLLKHy3SPUD21kJJU
         q6aGLDmvesDFT17DhkSYdcEccIuJDFTksU5m651jIoDQZ6cIh4ZFe8WmCAY1BBbW1LwJ
         3HBlb/T85sTbJP3/BEVPhFsbRcUZPZ/dALSz3nqz/vW2D704EB+0ySqOcuKsRiA7ieOR
         YQeOdH/7Inz5A5I+oBubgzqzAzJ7MIo/91pyRH4YiKfuNMU2ljkH9P+gnwf8VJ3odyPu
         oWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044247; x=1723649047;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+whv93205HO48FlOjVu3brJyKxplS9Kf8Dj2CSKzULg=;
        b=dXY9LCoHUUY+SeSDyKTsZcC6fpL+ibnX08KWAosxivW2/rXM7lGwHwX9iaEZwvskIB
         5/wzRgB3Rilhd9D7MsWjolMoYv3JzrARjt6ZjVuNV6F1/Br7xbJN2V36XgqFJNIpaGrL
         pYfmIzTlHb27zTlBAMnz0o6Z9qcjj19LyZNpnY6hQ+FzO7Xd3Ok8qbW0edoY0byxj/xE
         85dMbdnSmj3sTf4kBlbiSGutHVJnyUSE1oIx/KBUD13HPB3OpqqdnVR1P1fI/mW4C7nG
         9SNje/BlZ1ooxEHOIjaxcnb8MZcp2+LhmPmPXdVY8GfDwK5X14q6pxJKTtMFOlkPOb7Y
         sZTA==
X-Gm-Message-State: AOJu0YzbMSGqn0XkCe/XOMkmp2EOJYzbeHMHfWvlt2VBvufX0bjmzDBM
	R8u4C3PhKMABQ+bElQoDSo8ru94UkOSR9tZ9Q32iRYfpATntcD0=
X-Google-Smtp-Source: AGHT+IGp9kMuOOfQXywULGx0+KnNnWkbXnPk+CP2zdDcYlnhAH5rg89xTo0X0AxORM9mkbX/kREq3A==
X-Received: by 2002:a05:6808:189a:b0:3db:1c0e:af55 with SMTP id 5614622812f47-3db55800ecfmr24743840b6e.13.1723044246976;
        Wed, 07 Aug 2024 08:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87fc919sm5590931cf.96.2024.08.07.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:24:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240807143438.1471057-2-matttbe@kernel.org>
References: <20240807143438.1471057-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_Squash_to_=22mptcp=3A_?=
 =?UTF-8?Q?pm=3A_send_ACK_on_non_stale_subflows=22?=
Message-ID: <d9dc9d4b-21db-cc6b-2136-6ac02adea878@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Aug 2024 15:24:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/102865=
33140

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a760b5afd4bb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D877450


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
