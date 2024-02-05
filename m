Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078340BEF
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151835; cv=none; b=XMXn935GVZhWS23skm9Y7//+kmIc4mphnf6+wXwPeWzOMo1DgfvZ2WpsmTgCs22VJIOOnw4HN35seHo8UNzCQ84emXx8NfIrdAl5IEDfqD31fHdlVcgeObcs+xCaTvzOVv5c0AjMGUhxMIw2uqI9hKBQVjxnBJZN1r5Tg+1QIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151835; c=relaxed/simple;
	bh=Hm7SOu7D2vuxQ49jKCB8+npZlvq6Ib2a9IcX4+iQljA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kBCxzHcS8KCHU7bG8J7zvl43ej8tanW1wd89VkU0zX9TgRCJaX8SXiMSdYLJ2hH3hJQwgZ0lxi5HZ0OomcwfYoggFtDFoyP/YqK5nsic8MjMAQHhTdMmO/z0CpxQh95vcTG/OxDlmwVJKoxQ+OdN/7uBTzfebX4g/bs+1goRwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQDxMLsX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQDxMLsX"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-295f3bf41d5so2348181a91.0
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151834; x=1707756634; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQPXEIEvMO2bSCoAzTejAa0yCm6UMwbrKa2PkYiG0s4=;
        b=XQDxMLsXWZhnapinK+0c5Q0eeNmDi0x/Bo6yuhB2hnxqG3u1Anj6Yx+XicUykxGPBl
         e5Df1ubxTda0lZQzlYlVhfBo8kbxo4/lG715ZRxlISwHpB3TtFb83wb98IKhbEqoKIYM
         cgJF+HBcSrYs93B+UlEggJ1jFXmXTZjgb72xAo+dvhxLe5HIOBaunf5ULppdQyQFmGF+
         sW5j537Xl68x7mUbRLKjAZYvABI/ZpCLHdlCGVxfFGRUO62xpwZo6bmt0L37xbvYdX4O
         7y126rGEbomkwhBdYigd+CaZJcbC953uGHL5MH/flvUGgBLuW63rxPzUBNLdZFj4GlkQ
         k9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151834; x=1707756634;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQPXEIEvMO2bSCoAzTejAa0yCm6UMwbrKa2PkYiG0s4=;
        b=FCBy6fWsjLN5+DkvksOQm5N4FABk2zXdfVjQcIFIRqGvO8cM8l7izY2Gy0R6X+jbCX
         W33mB/Bp55r0XME47sYnweqxgMUBPFXItHVCqTGxS4QpEphmXef3qUduLZJqOPtq9rCB
         pT1oGNij0zzFAwXbCoNXafs9vl6MqKwcW+tEM1mGMRrLTkgIui6IqkQCRTOwYip/+Rx3
         934LUt5MLJM4x1b+PU9JtycudsienTsBcgMuHkOmVzIdisKKQazTfEp/Xlgc5E9U3U+p
         fYp6gz9+cOcEmQy+pxTOqAzLqEeqHpsdQBWUnSnzcJcKVXnkHREIC95Uj6N8Oy2v2+5M
         iQYQ==
X-Gm-Message-State: AOJu0YyJGnb0f8RSFIFm/nwy0/NovujfsQniNKfuvgmRh+Z2biSKAfxJ
	qYyDmpT5TjQN0+pMF/DLA8QdNVqgLWl5D2cOTXlm+Xs2ikYQRrExSaoEGmI=
X-Google-Smtp-Source: AGHT+IF6tX+hN1FRBThrio+CsXzMwsdlQVn0It8/T3w0+h1dzenCR9EMIZV5AFRZIV9bdwVru0yw3w==
X-Received: by 2002:a17:90a:6c63:b0:296:6931:e70c with SMTP id x90-20020a17090a6c6300b002966931e70cmr301067pjj.19.1707151833771;
        Mon, 05 Feb 2024 08:50:33 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.152])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ecc100b001d94678a76csm82287plh.117.2024.02.05.08.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:50:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
References:
 <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <ade85fe2-e04f-db06-6db7-1a5d1b1d388b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Feb 2024 16:50:32 +0000
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
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7787400213

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/75f455f724d8


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
