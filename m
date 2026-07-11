Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CE1E834B
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779230; cv=none; b=gqpy+kfFEZxQp/iH+1N0tuuxFi4pFZVtfKeDoP9MHdhIujFErQLIJJeWKGDCdmxTJPPxe2jkv8AFBBijj87DpgZsrcrcnADtYze5ajRkI8Atzv215ySE52IDNXBqhgxP45EI0P4Cf6rdIYogtQh1IadGRO6czbNIH0IjcTg4NeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779230; c=relaxed/simple;
	bh=rt6K6WG4sAxMzIfNs+iE17KofDbAKVEHfUfkUQB3vfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SfG2Wssgkhh+a/OhlvrDmFVQVR2L/6g1XUKKAPD8Olg5qDRnq20+HHL/t3kTAVCc9CDRKQb/vN3z516gp1g0d3LEvDEbIs6ySxIb1/DApeKHpqsEonuKcJOrUOAebvD5g4Zr5If2hI3qV0LZDYOAy+mU4x+ViuyoUc8C7I3Shxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN8hWZFG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN8hWZFG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50c5d14cso87470685a.2
        for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783779228; x=1784384028; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fEpPM6/zOaWPFUXIbEOxb2Xtm4TeIvR/yigkC13CFQY=;
        b=gN8hWZFGmaZMSntFIcXVhEwKQ3PLodLPZXZQueHm6gU1ASeFX/diSS/zDrzQCrRjyE
         tdwFMCdJaTOt+6W9Aft0TbKxur1t89SdXfuy3zNtKGuIiaip8AgQzFrdEpOwGFXs4pgI
         KkRL0ch743YsdkBtgonlvney3SH2017abUuL9bQ77VNAmVPGfH/E5GpXg8sUvsSxYsr6
         K1TszkUgA2kx7NNeKiSsnIWh264on61lB3QxkR38yi3LGUC+8KA9gBkprduC7eZS3kxm
         JJxgKJpqaMGOCyty98QWBO688enHfpwpUto+gV5znJXnqkeooU49yeReCPg+Ha1UARZl
         rIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783779228; x=1784384028;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEpPM6/zOaWPFUXIbEOxb2Xtm4TeIvR/yigkC13CFQY=;
        b=emacpaqKxUi918QHEE4+x+1JrRS/TDi5ocELJ3Qr3DlwsrZw6SpYpnoG2vlelEiRZv
         JiX3Qbh/L0sBrCqvOeEoz0JUlbBRu6YTZ4UX1iA4bf8eUqc3Tu7GwSVGhK2wYC7rPMEY
         EcpGs75BG5gN3FbzQargfAlxaLrn54BC0wVQnHpRe7FwdSD3XBtMW406h3TL5lHarGjt
         WBwERxto4/UcoWb4hs+fGNRSuRDThMfVrdYuX+QWFr7YH4RY8m2wZPiq7mBjujlzCtgY
         CCqZVNVY3nrNTpVVjW0HMcjRkNiX8ezgnA9W1XHV1phpNUtqH/yMJ85P1S6gcSwVVFdU
         9TrQ==
X-Gm-Message-State: AOJu0YxWVoVkX+fjrJdc+VFNsip4ekAuYIZbjNlUQq4TQ9uNQWVFJA5I
	p+dtXaCASWcIL/TdebhRLgvIfpT1CEKofEc953jIICEfsHk5yylDtsvskCHE
X-Gm-Gg: AfdE7clSPER0Yvktx6fxTFc7uLU0/FFYD0ChQy0K0isL0B0J3yTyalUVpLMeLn3e0fD
	s9VIlXRe6Y4S1subAaG9Rzbc+ANLB4aaHeU4n+Jn/oJ0qvMpO8JDZzVTnQq7zxfiOiRPtb8RePF
	4IRk3Ac/sRRtxaCYEV2aKgcRiXn3oUZfoIkibFhoXvl2j2jk3VCxc7sQBpFGqOz6jaImhPY9Y1J
	Qpi0iRyCLCmBiZDpqXOsnfSNbUjJkjiOQ1Ruo59qRQWcxXSiDOucwyf5NKE3YNUJqewV6UGu6Vj
	9uV+LjqYY6nQxVWWswxbJq4MAhpJVmf5SxVlg89nLFOPE9FGYf13LO6Va9VwxfsPDMUSN+bXCU6
	J1sum5Tvh5bgaMWuj/15WsL192RfrpfcVqk4ye483eHL7XHt63JMNxVbY1odPvq2ToWnhLIVzOr
	HHmxyDqs51FGFEq90FqnVxPDVuxA==
X-Received: by 2002:a05:620a:29d3:b0:92e:c118:18df with SMTP id af79cd13be357-92ef2cd27b3mr313333985a.86.1783779228354;
        Sat, 11 Jul 2026 07:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.238.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d2d68bsm458789585a.33.2026.07.11.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 07:13:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783774784.git.tanggeliang@kylinos.cn>
References: <cover.1783774784.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: add MSG_ZEROCOPY support
Message-ID: <af6a452e-324d-667b-4618-551b032ce763@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 14:13:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_zerocopy =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/291542=
77861

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f0a2581ba929
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1125835


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
