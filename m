Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B014884F
	for <mptcp@lists.linux.dev>; Mon, 27 Jan 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006534; cv=none; b=KbL7TaK/xWlN7jiSavful74NoK5Xilp+pZY0LGYYjFUqVgis0kuu6B/SvUNIxBtS71fwkv9Gh/Kp6Yd72kjJwnLP5zrVPzEe3+aM+hiXRXkBeyO2MItse4qXO/5SA6165+Fs61wkfmPm9t6HX0eBrJk74y2+I2yIlHEeJdWhAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006534; c=relaxed/simple;
	bh=p3C+rBxV+aDJ9KMzT8oBAp7gpqk555VcZiopwyQOZoM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WLRIrHW/Xoi7r5f9ZtlMiIpykJGuJQ9T+CHVZ6WIgnE98j150Lm0KIton5hQZz34aagU5N+pSBvNBXbUHnYKraEs34rFn+M9NvweMy+ihTn7vli7qIA/eK/edDJHzS06BUH5XCt2/BiCjKsNrwGSzIc2gtkrHG2RAlZSPfa5690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbO81u5w; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbO81u5w"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679ea3b13bso39583611cf.1
        for <mptcp@lists.linux.dev>; Mon, 27 Jan 2025 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006532; x=1738611332; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB0RmxERrJXJrgGXQSPX5stgun3pi2bye8Z6+zTclfc=;
        b=bbO81u5wIi9eyc5ZczR9k3KmN89e3W2DYEi+b3NA7omCc1T7BkOUAwwsdCgqEtujlS
         VTwRcdSWrOWwGnhaEoSICTtR8CjjQ2KnAkfpnemP4cbAyqSUHkC/piPjIdUI006ONw3f
         Op8BnkSGkLSq8n/dFUFHSL/bZRE8S4wUVoSV7Itc7Np3vUfb+O+cQYbhw6sS28sWdK3r
         YgGH6pA12g+rrD6V+hil2ZQuZvM2HhPk+wdpLR4dhWVNcnA4yaNxoEvcUWW48m4aOOIp
         pldya10LZ/HAfnBTGB5vrL7hrZsHeSQeBURWV26EDbnTjduINBXaE9SlOts3LTzSYmEW
         sxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006532; x=1738611332;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BB0RmxERrJXJrgGXQSPX5stgun3pi2bye8Z6+zTclfc=;
        b=hd1gnQ+d4kf+y0jiynxX+AvSoSYaRLLJOuFGgmcZHHCq1NtJDlrvS0pEhkR9fFH3pI
         y1z72VwhSahCXD09kB5TOxaL3QEDbs7eVah7JVawPk5iYOD2juYIf4wqageqgPOhXkyy
         uh37w1hdEZ5YtmDlJ6aUAWm9ZTV/92fjBQy/Me91A3W6l077mE2z6Rpijqsn61Tyqo7D
         05ZKqHT5q5gKF3/UHDU+yvbEsVgbUw6zkmtWlhPmqQULR43lqELcTTfRYPaP4whOwxot
         50ytXtzBth5HcptoVVCOSgUX8a2Vi2Hr1pT28HrZw6kpeDLzviVO5NMtc5pO+YzF7z0g
         3YPg==
X-Gm-Message-State: AOJu0Yzirv3gVSy+yydKCnU9T0a5v9DeCiVKJKmHZuhOmlXBETC1tkZn
	gLJLkIDSD5oQV9Q7tVUOuBh0jTF4xnA9F0XB7frPEyBAN+2Ny9QiZ1To
X-Gm-Gg: ASbGncuxEfUyNmGWzEIGBH5sHLtmdjYUnh2QkPOrqMrzngNyEeMrdCSTQVXW3BlBsia
	rSQyRDzaYaoOoDKX4y6toRk0XKViR3dClTvOHlBzVkHnoEyTWhz28RnuSwP6dBmmt0TkL8Jhi2p
	TqBjmX9U5SnkyVGGvCS4nhMYZdT1HjI2mMiE75Yo5YGjV+IEDRxlWlvxlt1C6Md5pJtzAk2D3Ww
	8GxBJQ77EMMd/cw4pL9owXwyW382u+5dSwS4zAt3L6oM8ROd0UPvtcQOShsURVBYYgDTN+Rj2tR
	pLvRU/8uFuhp3H+p
X-Google-Smtp-Source: AGHT+IE5I1gpg/1U55I5Gzs4+aEGhAelG7BO8QhDj0V0WABK3cH/926O9L3hmdfGHzTSdbmXmq2R1g==
X-Received: by 2002:a05:622a:341:b0:460:8f80:9091 with SMTP id d75a77b69052e-46e12a58ed0mr570726271cf.15.1738006532141;
        Mon, 27 Jan 2025 11:35:32 -0800 (PST)
Received: from [127.0.0.1] ([20.57.79.238])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c304dsm37575586d6.110.2025.01.27.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:35:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
References:
 <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: connect: -f: no reconnect
Message-ID: <d535e9ed-3b6a-4253-f4aa-b75fe4a219e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jan 2025 19:35:31 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12995996342

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ac94edd830ea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D928611


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
