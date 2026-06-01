Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB34331222
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312381; cv=none; b=mf6+9/y69hr4UUTQW7fwiMqjH0LjJeb1sjoY4+QpqIfnI1uQiVAMel7YiviFqGjhoOA/9euXIoCJLEg/qYsc6g1oBJRXrajZQXU0BHz8DNGoWN7iXw5GZPx8mQ8Bf1U1U8wi/w1dZ+Cq4x7+9xZf+9c68Ga60wXxBEQU8OWajK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312381; c=relaxed/simple;
	bh=+kc1EHA3cy7dU3BvTC4pXp/VacqaXMQNirfS3DsyAAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ApIiI7A/HnE1ThjnHqis1TW1WI+PCmtGWuwo3x2WZ5vC3kTApePIiNRCpb302RNgaCB8rW379fEYKnh9JDLzWIiaqO4SlJ176Gp1uHfsDFIZ1J7mgsk1E3KjFr+7SG4bG7UvMwgryQLf+nU9R924XJo7MbLzChLDGmk64WRnKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g09qtSGQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g09qtSGQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9df4732cso12836756d6.1
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312380; x=1780917180; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PCq62Mrv4DLzkDLcnsWt1pZYDNH183DgRhwmyOwXx8=;
        b=g09qtSGQhLgjJ4XJ1KcOLvcV8sRVxXtTa2GGxLRbdLtNDiHoOkzCTNfS9dBJdsVwBT
         MAwElsZ4luP72wEVJzDywjUdzpz0cY4TGMmDnSUdHPXIIl+ECGFaDGA1nQuFPe0iD8te
         4IxIn1aLP5R19qQyXJ1tqD/pyxscitBXepcmmawqicp8buZ1wwSOFO5r+XtMwLelha6l
         Ly9dVi5f4UaXKuDG9ijFFig5BIjuUCECKkeTunwNG5OWp3ZIDgA93kpFG2KIiwdJurVQ
         qN9K2VgNw/7wE/9N6jfjlrqid43G4E5I+oK2TuB1i0qe78/Vos56WGqaetCewOnuPa9e
         tBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312380; x=1780917180;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PCq62Mrv4DLzkDLcnsWt1pZYDNH183DgRhwmyOwXx8=;
        b=boVOSskfAZgm3InfS4j5M/SMsu8yX2x/fN47qZQt/ZDNyPzv9/3ul7lzBpw2z9GW3s
         MKQdvzXtDs9J5he1YawQ5Zuv8ObdJd9i//gpsw8tPlPkNXZL0SeaDKTkX60SccOSx2nd
         qfmWMeqZkjEhZr+6gAyt1pDXAPT6Ws0lw637+czdTNTktMXAPgOC4Ygu1/sdXSiG2AbY
         zyrMel0WTU5Y7MHu4cgsmC0gsoQ9zyIIqrkZhXRxFjjajmy7Km7dGW3LFllpiJMe4koS
         OG61vldMYLl+TxUHdGacxpXC7xW1Qq/sAEYVCKySagqLQJFb9tANbryO6OJtk8lJWl0K
         60hA==
X-Gm-Message-State: AOJu0Yz0VbT2bn955Z02AmwHjzf0JxUE55p2KOLBTthHBUqF1w9y9Jgi
	7nKtKRHGJ6Dgm1tgGA6JOqnKuf2KaaZQYXfmzEPi2NqJ/80kqM27h1c=
X-Gm-Gg: Acq92OHv3PS4B0FBFjSWQANTs3xf1cqByS31DOq7ayY983N3ZUa+7wyib0Jp2QgstoQ
	6sMad3seiwOp5yj74ACUlwy2BQ1iEerTSEWkMenjsSF1UDC66hk4n3kvO5Sse7xSQiN2am2U2Rx
	vhPZ8UauFXvIsg7g0enw8gzAEW8TdxJkraoMA1eR5VN6jmL3Q7vneaFBESdiBik4r2W4kkrorOk
	E7489evE5XPTUV2FMl0Guc8/j4MAo7kZ5OSm2dqF7eMhmPxfiUNYm9M4f9GRplxNbZXXCDKAKBt
	TIzCO00PgzbjcQ35mmGn0Y8bEMK7ZDpe9WzfHwypBcbL0MSjpTfmPfToR9JG7jaDPQbVk/Mh8RE
	XrWaR5AuI5PMvWhC4eiixyhvm7P3DA7MD/WEfz7xRgJ5zw3dy93WCzNusJTYdcf7iCfjW/sgrll
	C4/R21smFRQ301mL1qqPWqgJhyFPepO7RTmnjcrGbBhEQxnno=
X-Received: by 2002:a05:6214:c6b:b0:8ca:10c9:845d with SMTP id 6a1803df08f44-8ccefd92c8amr176610056d6.31.1780312379616;
        Mon, 01 Jun 2026 04:12:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042229sm90531196d6.5.2026.06.01.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:12:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org>
References: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
Message-ID: <a224861f-92f5-d645-fdf3-9cb533f914b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 11:12:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/267482=
50136

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4514016d2e89
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103913


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
