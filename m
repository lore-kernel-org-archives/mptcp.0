Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A901FDC
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063156; cv=none; b=k0xrnWNVqQqaLjqvrE+xucd80NBhP1whHIkUM3s++qe+nfEzSK9pzzmstcSfxTudxMPN54nA/rrlklgx8pNhDfGI6wcEQQTvy1hHWdmw7U2miCfXIHkjqXmxBIGb629PTMMGt5iXyLTtw+txzF1QjJrVshkTVrpEeoS4EQ3OiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063156; c=relaxed/simple;
	bh=Z6TgTmLE1eLYC/8f/77DzTSQ3k1f5nLB6s46teDnqus=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GBstB2ilH4SyKdplY97bjrex3/C6OnJgfkLkDM2e/ms5yhztiu3NXpXKEfY52lIINzetQv1OjGBjcMnZXkblt5RWCgNv7c1UQqbLpvW+ZCcReqWXzZILvYGlqCahlIqON+airyLOmK4zTIvQH1Rd+hKZsLIMoJ0iuJNvY3LuYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3ew3Vfy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3ew3Vfy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78336bfc489so383932085a.0
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 18:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063154; x=1706667954; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmImZwS85lj/du7jMhff11eQm6PwzTJU/z7KlrOD4LI=;
        b=H3ew3VfyA0NrJjo8PQRPQOyO5nl0F0YcZ0Z6n5bZMIbmkrd+yzBQWjjlGdlNQEDtd1
         0SAoJF80ccykQkGEWMJr3HP31UvDydWBCKzITbkOp1GW7ShfUiFTF8WpHP8N8vmXAvO4
         atrbGlkxkfM98P4JTRynwop2yxPrub2C9C/RwpEfnlaIAeKr7Gs3DVNUVKjBgMK2Lclu
         DfPXqTzP4okmu41wSqT1R/SOstHHTM24ywuJiwwUbI2qs2FMGNx4utJn1IPo8kt6+w9C
         g6SYx2uws1VMX0lp1railpE71x88NINzLRKf0F55RPlvi0XOvifnikRtXWo5ZAhqnJ5F
         FAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063154; x=1706667954;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmImZwS85lj/du7jMhff11eQm6PwzTJU/z7KlrOD4LI=;
        b=FcRnyHazQjP73aV1KWLOfTZ2UhIRwLJ9gZ4ksf4g2S/EQMMw6sI/E7fZA8kztDtLGN
         7vBBNb7DqZXdBl1JfbDOAdoy+dqrgliUNgnJ7Y01gpJ8W6jD9dPnfgI+C6Khu1ZeMiqb
         iciaYd0TeIxrNgex+FQRx3ii+JmJ7Kjsbh7uGsp9IKh7RKhUd5NQ2Hyx5Bw9dU6s4B4U
         DsiCQ2KFlMeuolnh6KLE6J3TsgV3mPMKEURN+1z8klcCDoO5ARmsi55OdNcYTIe1tG1U
         ThK3LD0r2WiEW72eaBIISwejJNRs2N07xangc5tnucn12kVWpknjzAM1l7rQoBq6gZG0
         7nFQ==
X-Gm-Message-State: AOJu0YyuxXUBBKE8EMJ42obcRNU4+y7VHa7cN84MDLyir2cRzys16QvZ
	aySazyqm6oWxaVF99tfIeew7/ZkMF77XLBNuH3jDp1KeQ8J0FAM=
X-Google-Smtp-Source: AGHT+IGYNTp1IHeZUR77VVXmVqSLuEUHqnCxij1NynnCBwAzWDdwirm5mkdxMsapEDhYUvphmzjcTA==
X-Received: by 2002:ae9:c10d:0:b0:783:3514:63b4 with SMTP id z13-20020ae9c10d000000b00783351463b4mr7561878qki.113.1706063154096;
        Tue, 23 Jan 2024 18:25:54 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.105])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a022f00b00783a46b6f5bsm1753805qkm.27.2024.01.23.18.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:25:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
References:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Subject: Re: mptcp: fix data re-injection from stale subflow: Tests Results
Message-ID: <bdfcb929-d865-ad94-211b-e7b3a70b0c30@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 02:25:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7634=
219212

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/333cd7ebfec0


If there are some issues, you can reproduce them using the same environment=
 as
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
