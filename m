Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4236C0C5
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746055; cv=none; b=ZKot42aaygST+32a6qQbLFh76pevegHmGDdZSDgfZ2evQhq9vKbCXHBwmdn2Bm4agSWAt/s1DYzmb+AK3wSimM5Ny2y83RQ0oL2ELUHmPTk4C9mznhVWxbRGXK1SYaOAXhh5HwRCbDyk6GeRa0MmM04mikB/iTXXnMuUMlCQbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746055; c=relaxed/simple;
	bh=4Gc9QMhUf8J1G/7+2a+1oxbBKf23YTLHX1daSE11AaE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CNhnfP4SINkw6IUjEMsNQtSnopeydEEOnfEjIBQjZPFj2j9fyRm3/Om7vsW/o+L2qr95TTUEIg7M3T6Ulo+Pa6hYbcxxLWDoKv7nnowWJzAItzkz04UP0or2NypIK+pPW3KO25ciO6Ghh7anmrERyJjdKaOVHax5+/9yWrLwer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXDZPgiA; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXDZPgiA"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0b7eda342so2232727eec.1
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746053; x=1774350853; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4J/FMPxSyhQ3T36Pa9tTHMHABYMG15zfKaR3pmWYPo=;
        b=LXDZPgiAMkq0ty4QhLcdIRfx4BiOlTmqqbDblvZ4GN0XkghSqal/7Ro5iQtyiV7KiA
         8HA0IQjBIyWCUFbyzjcrm7O/DItwEFa4KcgeX+Xiqmv10fJts4/P9m3I9AASWmRxO8rV
         g9SWeNCURgxtnwB3Xr14UTvQ2sYe5AvOlTMaf6MlAuE6Rads0HtezPKV4YPM3ChqwJ+e
         so/emowJwE1aLFGGckrmaUzH/5dDJSw0kmyAnzOxH2OYCW+he2otV5/ohl2rMIDiLCn/
         ynh6VKXTfwoRJtnonQ/J1teCcl02RlH15CFTpHzk0pyLafApnojvO7cP3mLafiEuyElV
         51eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746053; x=1774350853;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4J/FMPxSyhQ3T36Pa9tTHMHABYMG15zfKaR3pmWYPo=;
        b=kQZA3rOTXG+GsguVyE7KtbkyBJKPUSK93TBXbdcskNUnSMMHm4bz+NoZk0DZIlEkvK
         hopTZTaTuPdQkBtkitwluS3bMWjR82rOxo5XL0pR6oBk1Kwy86hxb4Qd8D9dQYiZcSHi
         WVTWmGgcet6Y/+qNIr0c5fPA9Ne62sLBs5vkezbumkEv8zHq/0mL8jZqvtvjGOnT5dSB
         NYTZjb8jtwkONQsEF/l/m46k9Y4hCMK/eQHUCxj6vtoFRXdfrOLkqIMBgEE10YafLDK4
         4vEUqcDT5nckd5fPoRVp40eqGsBw1gOgvipHSoKy23HSjCOJxpVZDO6qDqsDD8QwYgrh
         3m2w==
X-Gm-Message-State: AOJu0YwZknFsRBiwj6rXOLKf3j484coJfMb/2LrhRG1FNLrT2zjZ0e/H
	8o7HhjO8QfIBWjAMI+qrYStCCmXKaHDrHU0Wi9Nof+oeaRFUCZo7wh4=
X-Gm-Gg: ATEYQzy31JgbYaWLE2VJicKUcxOokQGExLBt6+8kXUPdC2R66jPgca8+n9nWZI9pm99
	lTXKOjqEPCELiP2K6b83Lu1yn2bPZW8aYSeshUa3Ic+iFA5MpzwMWR/Ky86VgyjjFHSafsY7qSB
	treDERIA2M3lAMdqCm1ZsYIvknpLf7V4QxRmrq5j57N1S2WF9cy4JozRaTYcjAl7wjBDPlKxPru
	kpZeCEwWDwnWJhWiYsdHRae+3eLUp9yxjzzUA0udR+i4KPL5oUDkYVE50ciEOZzI0GN8W9gtIoC
	Q22aDQBokFWQUFEVNycu7Y7zy8T9S+IbEPopurPpAnx4+GWAb+lQEqQy65jKjAsD80bfQNJWmE0
	to1T8uT9yoiPKobWUMvrrSJ2gnoUdSf8vapvT7dXcbcrazDiWS5ODD0G1ZQ9d6VaNCP9qqsEjTx
	td3NvqjfHNjFrKymVPW7C9pSFNRntTHr2o
X-Received: by 2002:a05:7301:1292:b0:2be:2b16:b99f with SMTP id 5a478bee46e88-2bea54616d5mr5830943eec.13.1773746052928;
        Tue, 17 Mar 2026 04:14:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.29.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b86f9e7esm11597297eec.30.2026.03.17.04.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:14:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773741427.git.tanggeliang@kylinos.cn>
References: <cover.1773741427.git.tanggeliang@kylinos.cn>
Subject: Re: [RESEND PATCH mptcp-next v2 0/2] implement
 psock_update_sk_prot
Message-ID: <7c499b7d-b7e1-f8c4-a605-74262f918aae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 11:14:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23189108848

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/697c10324f1a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1067882


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
