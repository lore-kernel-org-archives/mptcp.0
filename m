Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA61E0E14
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384340; cv=none; b=brLOceEKwHOF98hS5glLdHhOZLmuYKAN3eWiYc39aqM52YMEbvuwixGo89jyh4SihI5SNCOlm9hjyap3NF5K/mX8lVApa6KWSWFZuDAgKGsKKWWLxa8LafJNpAnr1Ben9UFwH+Kz/SJjjbHyGYwM5tWCiNgB3Kny+KHWuF5IQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384340; c=relaxed/simple;
	bh=8+XZP0/aeGxTr/YcHDzcVcvqjSVSpmqQvRpr5hfs8YM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sdJwBe9Amim/tkgH9bKkhPWgmDuRvqlpPPFcgZCy3Fl5/X57Tx9NZ157/yJgAQDKl3JB3vVg7rAEwDzStjiu8VSsv2QQrFpZOHDWOSUqGNbK6yqd+vgmdxBJP3epZ15b31xwjlRwW+YZC1FmZ4vDbpS7tJUmf7C7UdvoffG427o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCdHY+z8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCdHY+z8"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92f03daaa97so113396285a.2
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785384338; x=1785989138; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t+3iUC0COe8t7d0bW/7Em3zY43tShpEQF5yf16mQjHw=;
        b=YCdHY+z8ZbRKPy1ql69gHe3L4uHUUHV5hT59C36+RdHKMKZaxhC8oS5LY+4NEDzjaU
         38PYr46QiG3SU7NfCdGV04iNzYyxySkUxc+D4EkoexGaU/47d4QEVMzglPzX0PfyLLNr
         Awp1QwDuNVt7GSEZ2eIiMWRMxBi95cdSfMF2RaRYQEbJuLphRfIjLWtqZc5ZELFuLwK/
         6oo/tTw9ntHdQpdyryPjTCMnKvEaKAPIrZ0FmGHUGO29gmQGYQiOjFgjevlclWLsoqvI
         9FGWfUmdING9ZMUVjS5NVN5hyYL9xPYqaf0F3vt6Ywanvl0bEHMsZDgHoFftfjpKYpXL
         xKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785384338; x=1785989138;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+3iUC0COe8t7d0bW/7Em3zY43tShpEQF5yf16mQjHw=;
        b=MQ1n3R37LDDBnpy/o+AmZGHTTNmvlVJH+wiClVo2nxunrvo7s8od059oVLWH4GUq+P
         PNc1V8+omlWqvGsp4Jm7ROKDf/tc212gUIO1QEloXOU3zUMvwOHSvlM4DBhIq4t3FB9b
         5s7wL8mfseDADdV6IHfCZWmRBOEKp6HoM4OJg6ISgqm9D+lkq2Fv+d8c4Vlj27AvMb8v
         bNMLFJg8p8tO3rwfohwp5ASCThBxT56fk1QESXpB0y7A3QQ+LueqULUpTzdfdA+FJ221
         zV1yxDIwnQhcRuemqUGYP54mQ1Mr0rOq0xHi1HfWGMmUfmJsTXZErBTIUBAXHdO3zJHH
         zyMA==
X-Gm-Message-State: AOJu0Ywr1onePgmTNYSXRNwYr18jkC2lyTHiwvYu6B4Pky5FW7jEfQ/7
	IKi6avUCJEOkVMK6ZhkGe872NPXY0mUH7kxCTzvkq6FRe7Q5LdGd9/KxsL8H9iI=
X-Gm-Gg: AR+sD10OdU8mt8FS5IVfQ4MTEZQh5RAQB1xwrz2SndcXMZDYG048R6iRJT2N7PE7szI
	lbIFkj6gYVZri6Mw96jijOWdUsaJlT+TIsNfM2ajeLpgSdDVaD0JozWR8GzAe/yHHuz455VAkYr
	h/vo+SqJSdNskSBPJnHcluAgCI9qWbW4rvXPlXtyPLtS/5xO734/2aTkXYK3p3m6jtaicpBiSQS
	Z2qXRtrvj4RmzaxfRbMWQmPzMU+nYMIP/rcMpirzPIqSfdUA2+lqaAHPCyBpr+4quOREshOIC+D
	7mT0OeZAq+PKHgn1QNK9OoeEh+/qMXEdBpvbq16eG79OiLJIqVaH8NXtGy4KMKbZs4EAoslVC9h
	vMgQ4w767X+fevB9GPHunBI2Nz0FBfbAHKJBt0hZvdFwqmVd9mxRqy4P4jy0+VZx+I4v+u2ynlt
	cw0PZSe6v3isSjOiQYseqO5l2loKooBZJQIsRFP3mf8Sr/S9jbidcHnLrfsdC2fwXxcIccpz8f
X-Received: by 2002:a05:620a:8b14:b0:930:dd1a:5675 with SMTP id af79cd13be357-9348614fb30mr67752985a.55.1785384337569;
        Wed, 29 Jul 2026 21:05:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.245.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d338d836sm324878385a.21.2026.07.29.21.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:05:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 00/10] Fix socket options used by NVMe
 over MPTCP
Message-ID: <68c12cf5-dd07-ded1-7909-c4d249b83649@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:05:35 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/305105=
31796

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f0d1b731f8d9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1137054


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
