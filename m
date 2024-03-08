Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFA4C84
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900481; cv=none; b=nasbXoogviL8YpP2dmcoVio5uHA/fNWZPV9ihcRllE6C+Iviq7udb9Ekww+MKYm3OvGwEgplM4xgCAcXrLw/vPp7R3rFZkGWVuMgSv+h6syxwjFkNXiXyU5cBycQMj699AmGzwdx4aEY9zGKwJnmVNTMXRtkrtHM0EEi06Y7j78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900481; c=relaxed/simple;
	bh=tE4avc1yRmNUGSWiTUtA+zmxOidew+gXauA8NQi8wIs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BuyDVyvXdTr7JBZdCXtqjSNtZnDLLiYyfKfRbWCg1AwSwULlTIcG/QMckrn63YEPVtF8Da4KXNf/vdJX5hv14EZXPfKqObLhMOyFp+oa/Ih3do2l98U4SrK/29BUsx4BA9rITIyLAKErCZ9lV8BRDzJGJ0ly5LB4BPPiFUQc1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8rK251c; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8rK251c"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1ea5e54d3so1029542b6e.0
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 04:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709900479; x=1710505279; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkXwqIdeDbJPSO+ZVxcBflAGIJi8cnBBYYqJclQUeFE=;
        b=a8rK251cgdAnURoajtLXwLHgROE/BzK+WZxWOGiWM8xsNEx0Mh5FYzJo4KVWqnc9Zz
         FZJmqh22+l8buRbuky4ZTFTgTy/5jHRXyGRMyJYNyLeos/GapS49e2ULIwc/ZFQ14A2F
         5WcKNzOiun9y6pSHjFw0KwhLBiJr6jsR7T9giefsatCl0jfk0IYh47MbR2WO9JhG5nk9
         ijZ1WmK8h17fseY5W2msBWG2wqv6UI78cEUvdohloxLEfHXryLMu95LCRBmyPZi7uqj7
         KUlITWEMjmC6GzlT6SPIgapJ8d2Cl+XkCNw7gYACUxg50b8VUndjeZzHwdhPYz33phJI
         pIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709900479; x=1710505279;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkXwqIdeDbJPSO+ZVxcBflAGIJi8cnBBYYqJclQUeFE=;
        b=Xbw5tBHqrOG3pYu3NdyfpRhWGGHKbg0tPJP+DMqgMUE+MxERgUPvOseS5xJM/Bz3z1
         cRcN5+rJwW7Rkkqs3cu3hg10L50yIKrG8H7x9lEkVy1BhglTaHmZhr2lhzyj0WkSKPPW
         se1Bb8RCRVeCjc6F1eFdr5hoYnXlF9rmol04aj8ghQsPItaZF2yvRmOAwrV/B6B+8nww
         ezANdOeTqkXhIAZcvCBf6HUwbhU4IXuskRDPfpSsWrZ1tiDlIk4ytydn5p8vnyhL77oV
         ezqA0bUqJA409TbhdonsSpXKaFMssxMqMGexpqso3Sw7wk+FyfEdD6vlU0uYPAXQCQp2
         ixWA==
X-Gm-Message-State: AOJu0YyKPzMvjEgU9Rpd1WMiuXgd8i9ckGXQAaO/Ejlc18P4Hx89s7ND
	Yma0Hd5dO5HQgZmYq/MN71UyKBZkUC58fBdfGTb+4EZ+vQDeUzPlAPkA2Ww=
X-Google-Smtp-Source: AGHT+IE7aGBb7LXHliOhWSUvf+6I7u6tukXgN/OsL+2VecBX2E76f6wkWGHoiEAksz3fOy2qo6DkuQ==
X-Received: by 2002:a05:6358:9486:b0:17b:f6aa:6519 with SMTP id i6-20020a056358948600b0017bf6aa6519mr10485060rwb.17.1709900478695;
        Fri, 08 Mar 2024 04:21:18 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.160])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a13c300b007882fe32acasm4537602qkl.3.2024.03.08.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:21:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240308112504.29099-3-kerneljasonxing@gmail.com>
References: <20240308112504.29099-3-kerneljasonxing@gmail.com>
Subject: Re: tcp: annotate a data-race around sysctl_tcp_wmem[0]: Tests
 Results
Message-ID: <8176eae8-e184-2b41-301c-497edb515608@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2024 12:21:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8202785775

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e55bd7ed14f5


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
