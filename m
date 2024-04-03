Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37D6F085
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136390; cv=none; b=t2zkJeFDSM8KqvAaAC332OF+QBAG+A1P9ROSYhtzogBj4xbaBT8TbCLO1QeuB/8bkqJ75D/j1N6CSQsKgdKfZeHrprghQg52aKBET4qfeuli/ZI7zKHcZwMb/Nw3+bsUqmr1HKeMhkZKerCtjVAS/EUmAsjzn+1tZXFFqBjFfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136390; c=relaxed/simple;
	bh=eGrC0DuJTu8qNKCeC5PB18y4T4NHoTfRDvHucl4Nf8o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BOZ1OOteEUTcjqQRtkerNrIDb9DMV7cKwCwoISTJKXmiFklxb4rp9mwu+v/xuBe4TUQ+Y1WgCjLvTNTt8qb32lH4+d+l8kwNpgOz2UssXqY4axsDD0X5G/Xr24nNyZhrF6vX38dzpB3ColKnb1DmMdEFkgdwvIxuBBCzbNP1Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXtMQH9n; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXtMQH9n"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a7a4119d02so2097963eaf.1
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712136388; x=1712741188; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAnP8IYHAyx+r501dDg3xdZd8FxP2hWBlrUhMZz6VKw=;
        b=AXtMQH9n8/iGzC9voyPaP4oT6YGwz5DsYfSj37rLzVHxv0Q0hCwMKMWSrJ1kXM9/SD
         PmYrXxQzTmXe2FLArMR4QEkCZD60B2WplUbE75YvEuKLkpLsRgVvkZb78I56Us/OisPY
         YLHo6mlWth6xk5/Srmx4OiQoclM7CbGWgeD8j+RiTiDyebkrL7amZsnfuXQNBw/E2D2o
         +eFZpRWuT5cX7nNVJXmqGbwJnREeKLAliiLBGVEcXpjTTe4TLljJFdXrzoUrFLyzZ43+
         CaTQaTEsvffUqqt3dFzoIzbxdrf1DybPpogB6dOvSuMWez4+qF95Ha6hZj4UZu3BPQo+
         39GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712136388; x=1712741188;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAnP8IYHAyx+r501dDg3xdZd8FxP2hWBlrUhMZz6VKw=;
        b=wzj8NvN05pYuuEbvBOQUUmzXBdueFoMIScZbN2Mp1Or5UR163PV7lQ2/WO6YyRKLyu
         tn8DDjCnOjR7jhbbZklbVmTAHpSIYqw262RilnEozOB2AErnj6ufumA7iSay2pKO17yP
         IGZ8tKiuO4rGR5UxuVYp+eFzV9OJ1lXEC/SjCZGNdIKonBaaYJyv5UlAHshkybdQET6D
         xha7Ulk8t/Oj3eq+ot6rkJQ4PLkR95hbmTh5KCJMQlUDP8LoP+TD2AgYYxjIHwvhN58M
         wQ7rD33rSD0wiPhlGNGOvW6RVj/7Ocp7CeuPj1fKxwwGgpBHIv14gos6hDhxDBFt6N+q
         e8vA==
X-Gm-Message-State: AOJu0YyWCaobm1FBKAZUcymWf1SzX+sT5TSbkh7gnZ1y4uHmW9L0aBcv
	XXu28NX3l4A1BuYhpfUnlyC/Wnjig/6GUUWgNkY57TnJ17u7o8AOc5AqOVyEYw==
X-Google-Smtp-Source: AGHT+IEavZwgr1K+WxADNMGSsWWwKz6Ah7xP1U0d+hoEvQUHCnaZiXS9/kW2Sii8B9BAbNASoG0BLA==
X-Received: by 2002:a05:6358:2829:b0:183:c0a8:fea9 with SMTP id k41-20020a056358282900b00183c0a8fea9mr10473732rwb.22.1712136387455;
        Wed, 03 Apr 2024 02:26:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.5.224])
        by smtp.gmail.com with ESMTPSA id s22-20020a656916000000b005bd980cca56sm9868573pgq.29.2024.04.03.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:26:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
References:
 <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
Message-ID: <7c67d2ff-aaee-efd4-d352-eb6960c496fe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Apr 2024 09:26:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8535893261

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/81bb737cfc7b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D840962


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
