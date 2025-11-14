Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB2311971
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116209; cv=none; b=am+QUifmn6XnylhuPnyOOXsdO9WsWwJHvLuzID0gQLwmvTbr4Xo8FtgXUFzNs8nJSbOGVA3swJYuzHQHzmFNRfQakCf8ZumFGeuQktJNEg/yojMXpFke5ju2smibhprnzTFJu7X9Vy4H/uAtMfs/yPu0CIW6WODppNURLJM4K9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116209; c=relaxed/simple;
	bh=nXg34ayy2yeu04dHF9kBM1aDBtx8cu+aGukTgbMijo4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YjBMiIZuQTUST73EsKTzZOSi6OMJOiC36IABLC7UjeOL9BVSQlun2ek9D7sjFJaNaILvXISVTNHCOgqKQX5W739dj0MD6sfhnTuXQuXpanvYm440wWO/auoZutMtbAvZRgiImeHEHg5Ur/w5pX+E9jukHsWKu/G7OOKFtwIL9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdhMrt1q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdhMrt1q"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2627269d5so219555485a.2
        for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 02:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763116206; x=1763721006; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4SP5rtRqbxLR5f3LremmI9m/wC0iBuF4lacr9AlrZs=;
        b=TdhMrt1qWiqPIqSZE2lF5ShkRIZOgl1xG2d/nudNK1XvNPmAzkQIVu6Ri/qWf5Q2Im
         xU027kSsM0J0tqwDYATgY1a8vBVriLKiPFBKgkkLtt+rvMobkUiSL+L33TpFgpnGcO9B
         OrN7FAyyE5nLp8Gf+j129+AT+w39Yr+jX+QUtzVK4YwmnS3SfiXVPgejvd8Qz/TXLH3C
         XRZzms62G1wZKsetl/fb5J+Aj0bngxHAA478xrPTZ/ew6giiq+eVCbkz6z2KrOQsudl0
         RkEtQYZOpSh03WdzpKXYcTujqP3lXSU45ttuyeAFKIPrYAJhviUsiV6ElvJSWOxSf06n
         QJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116206; x=1763721006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4SP5rtRqbxLR5f3LremmI9m/wC0iBuF4lacr9AlrZs=;
        b=isfb3u7xOThiRsJ426wjKZJ0SaPpqN7k8R0BAIMVAVpkkyxpZCFIs5Yta2AtKHP3c3
         8JRwKpNM1JEqJFjBu9veU5TU1KJvDcsyp6d/n2ScZUAXUQu9CLpp6rTfWIJWgF4TYOcH
         rOL+qosQrUt13YXdNplGo5lPXJhlWWaZNWLT8sLBy81efSmdsRAuhoHeBiTzooSj1Uls
         iL6Pb9aeyZbB2YnBkqqBmCztdImPysbK4plsa7LoUpbyOb+PrXnWF2pPPOGT7fam2kbt
         siLTxj10evkMAArnl4p88wtxra5b8SAgHd2C65XT5J4HpdlTJoUMZ85cO9YwNYr3+1Jx
         BAWQ==
X-Gm-Message-State: AOJu0YwLk0TO2c8hBC2sgo3r/Q5jxfWv2/sO8fRXoF2HHTSse4NvugAV
	JYCFcXt66zhk2tfHxKGZd2IYE2b+F5z6PaSnHCgrnDKBoArhdBDXN7m5aNv8
X-Gm-Gg: ASbGncv9RSO+YW29lv621F0nuhQfXWxr09I+cjJEhQBps/nc9X6cWYmvyvAuz1FAND8
	3qF/cvaW3BoOtcUp7pJjXzM5Eg4Et4nkKl6lu68JJEYkWb+gPmEcY2C432JVnNwIzYu9eoWBuKG
	X7Zd2w3OpJGlE0LQq649vePfYeKg+9JxbXNIPtRxFFSADvu8AitXuJI7xxAZdFfwHDc+9xkWdtp
	RnrouOAoFIJFtOvWANbajPYAzbxIWcXfqlV7Meou4I/4x+c864s6u/cXdDeWafposPXf6f3luFR
	Zdw8w47PT23CY+OQj0qyowFCPnO8JAxDCcrsjBHfpx9WJ4nzzRYcmwCfePiit+iCkrNuaTj6WHF
	XsZ1g3o0Ci5qR6tHJdYiwRRHx72DJozNjvdgfAUI7YxxYGvTKNWkxslaVzgJjsG69zHheFhCnEi
	91b0UwrjKdBDcA
X-Google-Smtp-Source: AGHT+IESp2Xxt98X7SHZE2HgcelayZAA9zCaoFIW4U4xgsPp6NRZA/OFI5jVkKlj3m9oRreb9XgorA==
X-Received: by 2002:ad4:5ca3:0:b0:87c:2c76:62a2 with SMTP id 6a1803df08f44-88292705031mr32534376d6.64.1763116205705;
        Fri, 14 Nov 2025 02:30:05 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede8848af5sm25919991cf.30.2025.11.14.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:30:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763111767.git.pabeni@redhat.com>
References: <cover.1763111767.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 0/3] mptcp: cg and backlog follow-up
Message-ID: <81cf2a29-6089-2196-a27b-e9ac35edcc63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Nov 2025 10:30:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/193603=
90865

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c7e19c65fe47
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1023415


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
