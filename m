Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263086;
	b=L7SaQ/8YjRAPZkiHARlcLmOUUdgUDOlD5AaKw/qlbkmtjEwCG12bI90ucnhFEig9rrDy
	 ZidzwmWFFd4yCIkybLrFwLAzvToTGXE/gcuIgO426cCGzxDTOHYeFxh3hUL9sr/cJO8v2
	 rI2c27s/OmH13AmTwP9qxaruwSvxkPLhSLXRTZcHBJ0CYwerikRbpPpzdp89mb/r6ae34
	 ohGBMRYocX4mOhcn9z0NzR2wN5PB0UhgRSrqIPMDyqxP2/FNfs4ugmuovW08Sb9qhW8IY
	 A3BhbqIe7d+dYTCPs+jyM0Q7iFBdcsL8zzs3Gi3NlnRYbLG5xVR707dcqNTuUU8LTqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=5OJJOtxTNPpKMqDKcmcvurtWufMeBPZmCO+RRGTRL8w=;
	b=XkhG1vdqS1RlubDhUSrJGuePjrrN0a8vz3Re9bI7VPPLoN0Vgq9L2mTMUPY9ofbBrwRp
	 IQQFSUIhQ4HSgUN/s+g/X7McoLelaY+gEPIQlE5bcSYHXrzuYaAmdDLkvjqk1UK/0F9A/
	 ipHnPGMQumgggJ9ec7B02S4dbrtjVqILeKHlsV/OYdlRkOFhAC1xHrEbShq8IIslpzsq5
	 tPFf6oy1pRBobzMeNyrSeCdEyr7gCW333A/xJuLxET5cmkQWNjGkVgwVU2kBJexCJe+eA
	 U0ByguyLJ9lQtaqKrRYRA63xm1ku5fyNd0xYgoF2P+IdAKpPWw7ADIoIJAaC/VQ6R4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nIthUpZu;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619B606A32A
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 12:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1619B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nIthUpZu
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4d198f1a591so1761534b6e.2
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795263085; x=1795867885; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5OJJOtxTNPpKMqDKcmcvurtWufMeBPZmCO+RRGTRL8w=;
        b=nIthUpZuUMXmXY2klIewv38QaO9LVAUbOhmeVNV6iJH7tT+Qd9SThF1nu4s4Ej0hUN
         ZK2qAFiH7u8RaHCtIZI6gGEZpuVZGYBDszw8II6yLyDUOLv6i0C15jm4iw4E0ihTecvg
         U5vntUTHb4CE6PfSX/fJMQJ3VDlXK9Zxn9XJebHoz9EiTi7aVR3D8czNqQmR2aa8TirE
         vwCGP6phMFMEiC8TYELWsjOrw8r0szb5gAmfu2A59oT8C22LpA5JCeRhnNgcIT03n2P0
         qQYxZtJt/FQNLMH/buOxMALK+eFnE/e2RNMNIOnTMIOi24w743nen9cZU0LAJ1xwggTp
         d6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795263085; x=1795867885;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OJJOtxTNPpKMqDKcmcvurtWufMeBPZmCO+RRGTRL8w=;
        b=Bb/cb26Y2B12nRfNLsuAML9zHpIoc5HHX7LggHP2B00q1ionVUqsSZZJLKLGrQn+64
         RYuHiJwzDLiTGuESol4R88a6QY7RjarAfBC/1LHxFyhy8HlaUi9eEJw9d7tsTYCOcFyF
         AXG/BzTw6e8uU42vfpNgOuDMXMgQYELw7Ayo6c3tPipeVEyvDm3iRdPu567SNon7a39C
         rXJlPU+gqIvhtIY7FqmkXsneJ75MdulIBK2rpwTYlQzrDprasU2RTxaBjujwKLtqZ6jF
         fAr5qEMY6msWr85lDG1QQ0S5fNq1uIbj8cBQF9ywcFjMqGkg81Lhe1QDTRi1kZOtkjnV
         KkeA==
X-Gm-Message-State: APuU4Z/coSfiudZdrLeEZmwm3vlwbErQxoPkMbRtlGNOIoZEeB/IODO2
	wze7w8FaIYKE4eCs6IvdH/Z+2sD4H89EhIezqtXnmCRyW8B/M8ZMYXU=
X-Gm-Gg: AZFdTZdD7A02IdoHabBZSBRJ0dBu8dOuzhrScFweoM4786RJGolf4Q8NouFIZJ4xsP9
	TGQY9TjRqsi1outZ9Ff0GdgzpbYE3t9zTC79ykOud1JNTTuv8bSYRgw+CCmT74UXlthP6Rnj5kh
	rIAXNAEpXgmnkv3jX+xbVq8Kn2S3OZkwLyoVZtZsqnP2R+WF1WsGUAxhZhIdag2QcsEYwRfCisD
	Z0T9jfICjkF7QKR8yzRsXJaq3vi4DxSrjKX5MWRxx30rhGukUc0x5RPYAOjZT9VuL4hgUf1/gFw
	JxFWszs97LXqhAGMgClYE6uWPkRWDjYKhXFQdEMoeC0kVTOBWbikxPmZMGJYILkOHYJbF7WXh5g
	NSrKevbIxROkia9LGoc7eUVdi1B/6BN3CoqiHRCDvu5nH/Y1hq3gCPhz1u35y7rw+haqvvHlQcf
	BP9/kslq/wMz43f0DJtvIQ0B8OWL3XhsnLEOl68LwfBw/UfCRUjMTe5YKxCOTfCtEFAZ0Jr6Ik0
	DhvRSYsfxXBIZh89VvrADvnQGVs/YAxPwIKrUPQk6Zw6bNY4xzmshcDz86t/85+gM1q1Djfed2/
	cpkQohpNbnYFeaMOUFPyaBeOm0tgJYKZIlSAEgtrvOwfFR5DgzDcyG/V9XbXq4bsZw==
X-Received: by 2002:a05:6808:c1ac:b0:532:d9f5:1de6 with SMTP id 5614622812f47-57a0c09624amr6423989b6e.65.1795263084906;
        Sat, 21 Nov 2026 04:11:24 -0800 (PST)
Received: from github.com ([172.169.255.129])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm4705919b6e.17.2026.11.21.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:11:23 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/62] mptcp: misc fixes
Message-ID: <c0e653d7-0591-629f-a1ca-22b3ce371751@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 12:11:21 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_fastopen packetdrill_regressions =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 5 failed test(s): regression:sched-baseline =
regression:sched-mem-pressure regression:sched-rmem(3) =
regression:sched-weak-secondary(3) validation:sched-loss =E2=9A=A0=EF=B8=8F=
  (105 new outliers to review)
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/44893077071

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ae8564eb0766
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1218014


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
