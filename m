Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6622157B
	for <mptcp@lists.linux.dev>; Tue,  3 Mar 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540130; cv=none; b=hGN9/q16DDKMvnskK8BUUG+8GMpgI+3OgWjWaslEfwzqREyMHVHGXN1hDE6iyMhZDyanpn4AQ6XAskqZP9etXirEq2kOo0eYPRK4P3z1YCB1rS5knE5hGiugNXXeWaqC1cwnNuOBfAjg2ZrVaJZZZeast30upJnpGxG4SfPIrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540130; c=relaxed/simple;
	bh=1Ql2c6Qa/oi1DMI17mu4pOfISTkUDq7TK0jdsODY0tI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BP1DnvSu4Ij+YQcURbLX6emXqYXIlyNQTMQ2W2SxSGf94Z9r2giqe8bsOrJ1EjSEU0/bOdQIR1prxYiaUEI/9ZdJz0LfUWNrKDy6aTfCcA32HaHdPhJI/JZhbr+e6pfajL8fPm1WVZZWD7PLgW3poueB6n4Lo0reWGv6hrGbMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5n6n9yO; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5n6n9yO"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679501fac3cso3708808eaf.1
        for <mptcp@lists.linux.dev>; Tue, 03 Mar 2026 04:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772540128; x=1773144928; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2LMfXmFL0mHzK0FlumJ1U8Zm/p5NDloFHlbX8PJJKA=;
        b=A5n6n9yOevx7hhqzbiowho28QTm8ArwEF/vjcxjIqAigUNiafn1wUKdEazayneATMA
         1I4h06FOgUYskn+Wd3CfuwDC+r6D6Ywgak8Lng+SxrOLt5VtC3IKarW3iPwNDjx+PEsz
         nh+a7iYAXZfvmwpGNPoTM8TZVg7jgX1ZBgVW2K8z3t8bB0YuUCHtEyokGynupIKlyULe
         tP+mbYdsKJAq/VVeDg+pY5PXxkp+rE4K8qCzaA7usARL+hWwypQtgRTiwD4ZUYNQT2Wv
         aCfSQb/O3RQxmM/bMMwTndRSGeIzIvMJb5v1XOnKqbDTchgyler1mY1LYPjX/ScV9e1c
         7RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540128; x=1773144928;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2LMfXmFL0mHzK0FlumJ1U8Zm/p5NDloFHlbX8PJJKA=;
        b=xSXQ65nNTTxlxHdYYy2A5VS7ZcHR3q5F3bA9qix2d08e8whtwCFKnURFQB+ZaObB34
         oNkk5j01qqOx2wvElKM/W2YDvLRZdMBBs5uwnz7TrWNiw0zGHU2TCfiWVnPTK+ctJS5w
         ZXI1QQas8AnbmtN7GM4Fm8oTLzCeSeOHAvMUy4ihcbcEja5hZcsY/gj63cG0YLBOP8j7
         FT3q4HgFqIA4cDz9tgoHfZCG9+LGV6tCfuNX27vORQaxP7ndYkFcg/n+H4FIQb+FSHD5
         OPWHgCbpAPoEeZFNlgXmewaSlGu/9bD4Z4ZG3eUr3yqsJaegaE6dLwSzZtu2KSbRSe3v
         lEMw==
X-Gm-Message-State: AOJu0YxHFeeOdcOvp64hlqaaac2J00dYxEbG4lAH7Ka4VGdVUZIPfOLF
	QvIYl0/SiGA2DP8bVE+wBBjxdURhBS9xIRWaJvqNSCmL4pqA06hmSxc=
X-Gm-Gg: ATEYQzxLghiy8A/5aQXLGM4v1h0tycxREYaZJ5P+fQug3w9NSKXsaGVNR2oh4yVX/PN
	c/j+PcFpNs9MUQAdCms8/VOC7x98mcFhFD3MbELj4gEnxK7jA6HVxrQC40DHYkjbEGV2xZWWaZm
	aZzfKTkmmN+F8/smiIak0v474YwNYRrtWuc+1l6mUpgXmvmsCOGVnZuD32xTYqTxJ0sOQWX3pQC
	zOZGkfqpSilEBkHefw+YOXvusjL07O4d+HN6JF+YRERzIZdNzinADKyOp0H9+k74N6wvK1qDMhu
	IO817xnu50XqtmDuNNt/MvArNhIs52DhDBuNIHac8X+I9sNmt6TAOARrtuHUrgBa5gqc4Vv8/DM
	OtdVIrVgwtEy5nADcw6ytMmU6sY7KpNXSKClfl5wlcn0ErQQZFNe8QvoX18DJkb5BwEl1AOW8w4
	rfZ0BlnrIGyUuFtibaYQ+yKkSnfGJy8HvOUo/g1l1sbGYRkak=
X-Received: by 2002:a05:6820:8187:b0:679:e7b2:9fc6 with SMTP id 006d021491bc7-679fadc292emr9945270eaf.3.1772540127975;
        Tue, 03 Mar 2026 04:15:27 -0800 (PST)
Received: from [127.0.0.1] ([172.212.163.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2db737bsm11160769eaf.15.2026.03.03.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:15:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
References:
 <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
Subject: Re: [PATCH net 0/5] mptcp: misc fixes for v7.0-rc2
Message-ID: <f88d2994-bd51-86bb-c1f3-4511b2ee5f0c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Mar 2026 12:15:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/226202=
86139

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f28fe9348b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1060560


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
