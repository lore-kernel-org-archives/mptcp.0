Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD92F0662
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030628; cv=none; b=S4SUHSWe9X1LEUg3xyUJva0PRqSDDuehErSwjFScnQDClxAv5D0TM20l9cHN1oVRWkIv3CbBPLVSMR1aPhz50cPuGVXFKnxQPzqpB3t9HvNR+uz6o9YY8MruEUgSCdpFpPAxBhuW8Ecmi/YuIfMcbCUTWfcTrkdExaGoA41XVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030628; c=relaxed/simple;
	bh=JKAp6akZsn+ruZZrL25P07txyQhpiWHecjYqdx5/gEM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EBMW4zf3aiNdrXKVs5KLNWWTyNbBECvWcayuH3IT+nS1Ha4qwA6JampSZn1sE08zfcPUibJdVvz7jwlR0KEGA3iuqgomocGH8WWxg/XtAP3h6cqzuJESPmv4PqA24KGQH0Czo+ztwn3cowbtRcfftZY3QnyrarszDpcpO/vZckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeM7bkpx; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeM7bkpx"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e40212e6ceso25708225ab.0
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030626; x=1755635426; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV7LhhtXpVLgxDx3pks7QckFLAU/jIGuZp1uIEyCmc4=;
        b=eeM7bkpxYNK6j9oY9EDeBi6LClPAcRnpVFCBQTVgax5h7W8IK+hUnuEn8aRgR8r2Qs
         ty5d48yKQNHxw/2pjlZrj69i6QRtgL9mWsxCZ44fXQu0nAubOTYcHmeniulSDiHrmyz4
         qVkCK/3+twAjjf1ZusLK99/Ihy9BraDEWYwB66nJJeFLG7CQKgSzDKORxlQxSB3SZNpT
         gMdNp27hrru9M3Tvjjc+vu1p9Vmd8LZW6GDFOF1Yyr8nbRbl23hAgtgLtBhhhHIAHDT1
         JTrTyLAZo97HDseJSQwBhzhr7WUfCZYquyZmlPbQ64a9yQPzjDjbWMxu1qJk/nvsIttK
         oUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030626; x=1755635426;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XV7LhhtXpVLgxDx3pks7QckFLAU/jIGuZp1uIEyCmc4=;
        b=iFNUW8Y6kIcP8lFuO7JI1oUS6FTBOK5Cy9/H+lPyd9bi0WmQHZ6O3gNAN09tuWna3H
         9aHNg+pM9LWsGWsgJyXYfnpoPvcA7o4oiJBW6+dyN3hKJSD1gJPi4V+fZKWJPhoqlee+
         xK33Ao2AoDgjrmDvk2aR3qs0DNX0fG7Oqk9vMP4J0x21R6HQLmpHsJTWiGOYmL/pET6T
         eU+tlrShVbbrp0cMqHj/iOC0fpbzPNwkDugS3VK/fLA+f0xwpDpfL3YLCN7w3rqO79sY
         xyz9/7wN50sFpFLJu/Yvu3QaZ2D8NSm1wGjEoeLmOKs79k52GmNv83d09FXdQMvF607V
         MZRQ==
X-Gm-Message-State: AOJu0Yz2JwwL5cgxxiCCbcxzJFL//F5LkWh0PCPQBbVgcFzrhvKBtx5J
	8OVNDjYxkNgmXNsOkhDygdVZUYELtpTfg8+YJT46fkcX+FoAVdZPuyRboUvd1CI=
X-Gm-Gg: ASbGncu/auOeqIrySHgggs0S/H6qw8S0P0QsT6k2DdebJDnrUHmRfOBG7aiNXactIgv
	WN80411srM1hDjcDHavCwgDRcfSKPe9MlmkBQ0Wnv6DLD84GFiDfAh9VDmCpHQm2TdoOK9okTLW
	zugdYjdei+Mw0xICozwIvFMIs3DNIEIY4KYJf66IV7SBeaWMFCpOdnL4OlBjUNvk99fwZuds41O
	GlNe2p0tYIFIx1CMHqbnmS7Pc2bxc7CoueHWarWLVbyyxKtscX70KixoWssET7BzvBwNA8a4Ewj
	54c+uXz14zX9fu0VQ55NksNFujD5l+4y3SP6c0Kgt565mcWlLuSRRiE143oGuFsCTftWzMEcM6a
	QOOE/7i4jZaQ9TaTGhleM0uOuKjiZCw6vU70=
X-Google-Smtp-Source: AGHT+IHsaZX9G0Mdm+RhhRNDK0zLw7m7LRtIyR6ppb2D7HYTL40X1Hgw9VvJR09y0kmnewWBgJGwNQ==
X-Received: by 2002:a05:6e02:1949:b0:3e5:3a15:93b6 with SMTP id e9e14a558f8ab-3e5673a3ab2mr9288035ab.8.1755030626082;
        Tue, 12 Aug 2025 13:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.18])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5536236eesm20534515ab.21.2025.08.12.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:30:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
References: <20250812175848.512446-1-kuniyu@google.com>
Subject: Re: [PATCH v3 net-next 00/12] net-memcg: Decouple controlled memcg
 from sk->sk_prot->memory_allocated.
Message-ID: <6a03602c-b778-8dfe-9188-94928b49db80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Aug 2025 20:30:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 2 failed test(s): packetdrill_mp_capable packetdrill_regressions =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16917233905

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/38d2229322c8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D990685


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
