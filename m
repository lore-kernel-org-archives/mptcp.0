Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41423A1A2
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745357; cv=none; b=S8YYl6kzBynMxIVseaE+0WZSGmr4L+vdxFiWhJObz0HELIEUnlC5PIT//VNsiB6OwZYPft/+pR8tmw8G3gz/Bb6lgt5DzbE6k97JbFab+vUdlYx2bcHYWV7fRZVWWULctlFyjvoGVSiUU+PqkOUhGfhI8bfJviQ1u00UtdkRwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745357; c=relaxed/simple;
	bh=Hkn0HAKIfEV9UkXJJH+svXZNJ6t6mn8Fffa41pdHe5I=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K1MYV7fujggDN/cixGPKOuxbYhDCvkXPfd3B4u6iC7ZSfsjGH08WjVhNP/0+5PEiWS3+zeMP3FDICyvugv7qf4tbIlLPIssJrBkN1c3uSH+12QmfJKDYHmKhLO1mWCIUMXapyTodV0jHyGsJeH7R6maMgLbn/KqZ1f+1ChKZr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7g53XYg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7g53XYg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7838af983c1so272875985a.3
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707745354; x=1708350154; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKBcA+dCRt7uh8mQ0fVWiV5O9ndy9KRFTY/OUeBiOOo=;
        b=Z7g53XYgVxTzfB9kncALlyC1HRBZXKCMjRtbQfLory0DHUBPW2o+IE9qjYJCF6TfzM
         6tUDI6ZWI9Px5GinSq9k4F3CVeG8srL0cQ7IZGeeNNi7hl/hLoCtkfelY6K4g/W50D60
         EA0/BD0+wRSe8iD0rAw7cTECoVRKu6faOcFqrQ0Vo2wYxbowNfmEcN3XEp/BpSoKfrFc
         s2xzQUODYWtJxEg/zt4xeS2z8yoFSXmQiqtXUw/CdfgYG3xYUp9WWiQy9QEmayHAaf5m
         png8OWMmgvK/bobeL16zFv0zwgo4gmLjKISmI+x+88zVnd5DRLkKhQ0WObVnnqdLu+EY
         vt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745354; x=1708350154;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKBcA+dCRt7uh8mQ0fVWiV5O9ndy9KRFTY/OUeBiOOo=;
        b=J/4nnTpI41oqosjvOwwP+rPTYhsBETnimBq2GU3Wap/gm7dQzZ8xXYEJ/yApsT6mpQ
         woE+d2/uUtqAZFd9IsRbDpH4bH5wCriCwuKkvUovuCW0wzaG/EpDOpIohdLRc3smpdwV
         4eCGPBscjgU8K0/2sJamCOBdMadaZcnI2XRNhVAd3bCIV/NbViK+eW7UZryPdChMbzGD
         SuuF1czyjvWvCkSvf58goQ5P7UZYnDajDz7VJI3BJzqkcNDnUv2wGeiRN2SVzItpAL9C
         A8kP+tDUsWnCZBlDjP9ckJei4vAlOxxgw/cZARySyHVf7V7vKUEsHva3yDC6yX+Yg3br
         /kjg==
X-Gm-Message-State: AOJu0Yw91EGu7/0lVLwF0h8KOE5t+/kuCAPNdFdOHRtefJiyfuaKXX5V
	r/FBSNAEVPe30AAE8fCXr0GQ4GidkxvNJMqybvMKFAYo4uoN2R14YRbmWA0=
X-Google-Smtp-Source: AGHT+IEZrfS50RCHeTQ4JlOlE5pO5F712q7XnuKJZ6/RbpQ+InWCyKhxCHQeujEGMFGIBC5QInh2Lg==
X-Received: by 2002:ac8:59cc:0:b0:42c:7cba:a44 with SMTP id f12-20020ac859cc000000b0042c7cba0a44mr2570629qtf.3.1707745354674;
        Mon, 12 Feb 2024 05:42:34 -0800 (PST)
Received: from [127.0.0.1] ([74.249.14.208])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86684000000b0042c78553d1dsm145859qtp.28.2024.02.12.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:42:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
References:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Subject: Re: configs/debug: add NET debug config: Tests Results
Message-ID: <7f70e336-b8eb-8c70-98ca-0a526fd83a3a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 13:42:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6433317642305536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6433317642305536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5098397330309120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5098397330309120/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/367eed27e7e3


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
