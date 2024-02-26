Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74C1CD02
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943597; cv=none; b=ksWacEN1Qauw07rNHsEa1OQgHcL9eV9JS9gqK1cw7QBbDKE0/vSGEdyOIvM0DzTbN43tODkRHnlHNP+79zkkjCJbvfw1lYZ6TKOG0cP+/FFl3FJXMbMNK4wbsXLlrL7lG/YuaT5nIjF8/LFpG2jTRyAnOcVhU43A4iFL5ddI9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943597; c=relaxed/simple;
	bh=wvQZGROYHHF+0w2EtHzm+0DqEaYc5uxrglLG40YkE5A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lNfeUiUadGjK1sIXF9xdOXxi5tUmXtKA0ZZNALN70XAkT7cMWFaRD40yTwRqgfZelhR854DnlKc1R6Max3GiXdxzlBPYU14J/2TxMYhVOJwd3lKXQF9yxwjXKPje+J4bTmkoZGsmze4mWlLNbazlq39ElmMhamy9an23T5zljPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhoSwx+m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhoSwx+m"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1db6e0996ceso21724105ad.2
        for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708943595; x=1709548395; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp5+ajfSreeEWoWgIcC8sWb5ZRA1tHXdftguknpBvvg=;
        b=PhoSwx+mGG91wluh456zVVPGYs8lIMBXu/8jNLOTiViJK3EzmlXdGWoq9DWUJhfX66
         mCECwRhfGsUFq3gkjR5d7oI1lh1mMNrfysWOQ0veA1IPWYvK6X+e5PTcT5RcI1fjRzuA
         ld95TDDbAomT5/iD42LT9mh1UwO8m2Viu3gbbIKH57eiOjsFGPf5K+UxPSj8ytONwa3W
         GZnGl9f8Hx/1D+MwBlBx6K3xkSAob1JZVhbio8nOF+gOJ7PnhY80ColuG7TtHdDcO36l
         Fk+QnpHzXpLFn0RrH05v22tVK6dsLh3RIQLjsnc7Y7C7L88Dyd84paqJI3WsK/Cq/frd
         ZxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943595; x=1709548395;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wp5+ajfSreeEWoWgIcC8sWb5ZRA1tHXdftguknpBvvg=;
        b=YFytGwp2WDPHvWh0P5M+BFNkBfBhF1jCOSwKy/CirdipMRHxLygkDUmkGLlKlsPfqF
         CibZf8VWs02gtTtXJWMKBhL0/eSPS+Ep73Y1UiwqKGjDYOyfEMCSExhPhrRfBrDhBgbk
         wQ8y+Ndp8bvLeaS1BnPnGVL2/36U4w/qSzRfkjRzT1izdyhISaEfsB2OGy0fa6MCVCup
         Yw8xgz+5jmNSA9prIzwIhQRH4jMIrxKX9K/Z4wguPMK94+xB3RWuke4S0co7LhtlSRfv
         bRbPvegO1Tnigtdky2Tb4YbyZr9EMWwvdVExVJDNY6TTYV7D54oL6jyRS1P+aXgdtyap
         Ueag==
X-Gm-Message-State: AOJu0YwGT2P2fJMrD17Czyt4WUGSMk4IpcD/m+T73b08rlBg6+BgDAQp
	cRPgTOl8LZZkW/rxxTK1zJiGHtprQolBDkhtHw+ZT143DlYl6h0lWCaoMTg=
X-Google-Smtp-Source: AGHT+IEnYQo5qMV7EixCz30q20ua1sCdw7LZ0U+mj00Je/zQ54HcK/TOw3+4qXs1MTvhPWZEFp7vlw==
X-Received: by 2002:a17:902:da8a:b0:1dc:b17f:69c7 with SMTP id j10-20020a170902da8a00b001dcb17f69c7mr165132plx.39.1708943594619;
        Mon, 26 Feb 2024 02:33:14 -0800 (PST)
Received: from [127.0.0.1] ([20.171.122.32])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d0d100b001dc8e1375e2sm2786858pln.104.2024.02.26.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:33:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <33dcbce2a0b189195d040dfaef55634337fe4aa1.1708939963.git.tanggeliang@kylinos.cn>
References:
 <33dcbce2a0b189195d040dfaef55634337fe4aa1.1708939963.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL: Tests
 Results
Message-ID: <d6c10018-6e62-d415-8d4c-920ecbdfae39@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2024 10:33:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8046892754

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/44959d827650


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
