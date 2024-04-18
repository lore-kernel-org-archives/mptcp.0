Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D18364AE
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429366; cv=none; b=XQqpvxRGYv5L/ihEINMYN6nq+nwXokGeHLX9aMFFEjrTIs9ciVJNvfizIPFWllMnhlSytfuoaVRnTF3LzQ2flS8yrZqT7UzvrP2xN2NMvf4gcrw/rvkuaB0sOUzMIi7P6E5hZsmE1wZ8DX9QYmcP8pM7hfRSmqTzPCAGUyKUVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429366; c=relaxed/simple;
	bh=vFPksKki9m0yngSO+8VuCK+rKQwKnW5Z6gg49IjyQwc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sgrQpn06xHx26aUAD7/CbqvtW4fg7VG8A4PNPJ0OAwnTZ2aQw0I4QWS2ODYs+Fj2LIE0JKru0lXvrYrN3gsZMbOIYMHv7J6wuP4jTmhOUg985qWfL1eskJ7tACyw5Ag56A/A/LZwlg3476JrQYIdTm7CjSHxpSkcksAYffZI3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1WzrFts; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1WzrFts"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f0592309aso43825285a.2
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713429364; x=1714034164; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojdjYldIRQXwqs1FBbXd+6S8Voek6Z3lbrJLoTzhfks=;
        b=Z1WzrFtsmGC+7Aq5bRm0tSQBzQMF4HPFVpDm+udFBLVATI2X+/G2JGKfJKEQncoz8d
         pKJxwE2SS67oWEkc7eGYmKtMy2+68l2Bsm9tYD2GPSNA7cEzFkkqaXbJKtQpxbYVE3r6
         CjamW8haNQpizD86la993U9/D66g0khuqgU3luN/L8yn/uALFZGw16EdlCwjuErRN/IF
         um65LHS1ss3PW41eC1X4f0qUXqNgZ1363RYFSD1fvThdt8CXepohpC+5y5kVmzrnA4BT
         WlS8SHsMG39iJHWuYWVMjwI0/5Tkl/GktmTl4ipOJswx3Ut9wdUuy/MkKzHZ6y+n2U06
         3LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429364; x=1714034164;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojdjYldIRQXwqs1FBbXd+6S8Voek6Z3lbrJLoTzhfks=;
        b=n+dbVZwKhVNs9aPI5teB7Po+/WdWG7zMjM1noTJ6XKblGeZOjGMgYk6zVVhEtJKfRd
         TB5x4t5pQ+pCQ6rmtFhY4Ew2HYQbAJzsm478gzaCbZg+QWsB9vl9NeIXYWsACjfsXehe
         1x/LCXrnLS+0qQOYnoa2gfJKMlJtU0IN/h8a8IDR4CTb2YfwOSoHK2tEm9Q3cNwmCx1s
         1eAQsBFQuqNNWcPalm/H93016yKqy3mDSE3hNB/H247KMSts14yks2O7lqGt9m/io9EY
         n6B1WI9Bvrp+diL/dMdz9n1pM2UulicmLiSbGlntE8vTE35hWqYQTPicuwMMiLdWB+by
         X1+w==
X-Gm-Message-State: AOJu0YxH3QXbOe7cgHLT8OjZFW3pxWEqDEKVL2uANlJDPA9tF370ljtt
	OdNt9sa74Wknlxm6PVGNExDCbZZsK/bjN24Pb2TekBPP5siUQ0g=
X-Google-Smtp-Source: AGHT+IGKM0Z4ndFBheeC4lvXB5iooyjWAEAgFSIbjj32kGBOezjNMP4D5Jkci9Q3vsnA0Fz1yYF7nw==
X-Received: by 2002:a05:620a:8120:b0:78e:f137:2012 with SMTP id os32-20020a05620a812000b0078ef1372012mr2206868qkn.61.1713429364397;
        Thu, 18 Apr 2024 01:36:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.67.133.150])
        by smtp.gmail.com with ESMTPSA id w2-20020ae9e502000000b0078ec3aa9cc7sm442144qkf.25.2024.04.18.01.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:36:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
References:
 <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly
 initialized on connect
Message-ID: <cc9b9c7f-a322-2499-e838-270a99388dec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 08:36:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/873439=
8749

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1448b6c11f46
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845694


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
