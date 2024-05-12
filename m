Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D941865C
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715506488; cv=none; b=l+aT/lA8DoGihtK0XSa9bNJ9JM90rQJy5HBy6YpDY7BdH6PAh+anHWrZkmcHxM3LcpiaFryk0R2ZXB83tI4TEylbv07zWOf7Kp7EpdtB2J4rCy2auFJAuetUZexbmzD37Cs3OxGlW3kIOqNCR8syxxDu8qY/EyLkOhGBlhhlsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715506488; c=relaxed/simple;
	bh=ctXipN1cAfXYWDYn5ZdfQPv3MAwwQL4loGHbvTWbHIw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hMO4L6O4sx3Qhj7Kb3RzmiTxy9B2CFxXdSKY5KGIXupQmQLcWglg+FakW9mkm7KR8C5aoEnR4Ii9Gh2FVfkDYMoAws3DTXvGwtObvt+MfXHDIV50vdkBwavMGEcYRc1RDwRE07HPJ8EjBGY3PDQ/4MzHjZwF7f95u+gTIGo04r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBZpCsbu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBZpCsbu"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23db0b5dd28so2339225fac.2
        for <mptcp@lists.linux.dev>; Sun, 12 May 2024 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715506486; x=1716111286; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVeMB8MYQ5wevvbmvyJWKOfULz1OSFD4lACdBBkEwc0=;
        b=XBZpCsbuEG6INTxh3cH3bFTYx5hwZQj8aTbn+cpIahQW+Inf07XY2aNsEu8RonAm98
         EpbW+skYQwg6DvJ/RIN4SkpDoN7pYsqBUCKkREWptNrrddZMHm6GW1EcpFCC+zNGQD9D
         kVHcMMZPRThgszA3Ib4vil/pk3SdMHQ1wU2fdFg+M/CFABOuT0KAV24IDVrGXSllFRx5
         wOlfzkBwMUwsLslYQLbORW4VEI8pn+h0joRsF/4CYZU8Cov2AwbIXsY5tRQGfNaEwZr9
         N54gOiIjTy0y1Ffzzb6VZNr/5rMJC1TiUjaU1V5tt+D70M6iq8/h406XzpfUwqgaf972
         SwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715506486; x=1716111286;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVeMB8MYQ5wevvbmvyJWKOfULz1OSFD4lACdBBkEwc0=;
        b=sPOuephV2Z0ImRQRQ9G061lf3uj1o/ciBnJNHrhmiZvhvzvAWZG85SHFd1ysk+F5v1
         qP8RWPXjHIlNZdSYIgITziBjZb1AEfATEhsMhOqCASuEUalF7hqg5qeDavx95pe0VeYf
         AG4SFchpC5jmC7l9+giYBlt1kGqjNOaN0KMqe8LRD9PvkIpgXl3MW6mU18YtoGPtzYta
         GrUD5RiJcbHe+8iZjYQjb/mUMt9SPEOrxhc+GB+wmZrzZTk+15Miwi5lV9xqAHNwQE+a
         kSophs3S/0/M2ZcXFfJSg7+LOupZoyBvaTwgkrMgt3wl22hpyCNmkDIK5KgguhWmGw6Z
         htBA==
X-Gm-Message-State: AOJu0YxMLs23F2en0aXBw4JaDEwsfSMT/5XEzGQ3ygGAMQ/NM9t/sEu6
	ECK/2IXTXXtFmEPLzGUuPemnjX02Hx3OYnfGTyIEqzcezapmSWv7Ba97/Ss=
X-Google-Smtp-Source: AGHT+IHz6GlfMN4gXY0tnykKDHmgOIXvpUuEkV3r2VpBpCjoKt1RoPldXiPYJBcjV940xpm2HzMbtA==
X-Received: by 2002:a05:6870:224d:b0:23d:a4ce:b86b with SMTP id 586e51a60fabf-24172bd0243mr8977049fac.26.1715506485468;
        Sun, 12 May 2024 02:34:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.24.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a86a5asm5494372b3a.81.2024.05.12.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 02:34:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715503185.git.tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/3] patches for new MPTCP subflow
 subtest
Message-ID: <8f9d395c-8569-987f-f50f-eb98245e234c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 May 2024 09:34:44 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9050206459

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f24a9a4e12f1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D852623


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
