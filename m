Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAE10A09
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116454; cv=none; b=pHR7gVTo18O3Tg0z3zJO1iCpO94cfJ/FD/dg9ltXsFUcl53ceB2pz5X0k+1Dc5NfkoGHYjiSm9b+33WzRihstLir3RktU++xQWBfZTnbNhfAVeNVD10rhex0BiARZpTL4okSXeoG4OasK67JQ4zTATQcQ9LNIqJFrne8RAQhSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116454; c=relaxed/simple;
	bh=QL+iS6b6FzrMZK3Fs5FY6Qvm77LSlS5OMiz1ge94tlk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uq/Nf9NVtIeY5hN7M3KHx5JXK31UQZy2pSs6IbFJIlMEC2o1OLrFmgmJ99Xim2C1+z2S4cM4jFpQDeLPgm0S2kDG3CzCWPaaxqbgpZSqiABXxVXQzJFnv6hFktelYBQ8pd3y8Ag9qljTgXvW2ei86CITwwwgM48pPAIee8gSUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM/INQnN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM/INQnN"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-785388b3281so221655985a.2
        for <mptcp@lists.linux.dev>; Sun, 04 Feb 2024 23:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116451; x=1707721251; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls/yaCySz0IKPMx3tiEp/M+K9WHYY96vA7A1dSbdK1E=;
        b=hM/INQnNoLLgTJty8pCs5DaX6qYr1PmQQxSp3tbYmXiVy1k+dshLHftrjj57ZiOKyM
         kT6kmXCews6vUTINLXX0vi6K6M4l7sAkbespmd88ewwuABzNgilLKyuM9OZrQ5bFFele
         J8FZyxuAkmvzycI3qV4FtWlx0+y+1N/mKFJLXRYlxvtXgYOqoryrTfpCm/dxLFm2/mwL
         NimJ3M5LJc13zmk/qSxTK/qdkKtpyeRITV+NcMMktYGkjv+qBtuMP7Li+i+43UnZacm2
         Yh7rimRdG66hmUSl6g0/dKvgqyiqvj1EKYt6DE4gCr2r9dEvxEuEMxnUGxydcBTGhaD4
         Z7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116451; x=1707721251;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ls/yaCySz0IKPMx3tiEp/M+K9WHYY96vA7A1dSbdK1E=;
        b=dxX4jpDV0AiVIIwUO/Mqcmm8olQU9q9MWSPZR5OdDKoxEK1coscyrvpApfoYvD38UD
         qz453ihCbgpHzs5DGjnzFYPRRhkEtbVUgp2QQZ080WQeOqvMJv1xpetUh6dX5L+A/Y3n
         kaWRMbXYxaTyDmJIm2BYIpkbNgN9PsYHEhgYQDGXpW8Wpv6QWiStTnP98ucP078HgNgB
         AZbptYZ32WzrPmS3/6/ldSpDoOcZ0UtnFr750rZ9A/KhyqdMyMh5m9FIw0kNKXdxztH2
         imJ+6/R3LuaO6s7zIy04hYS3TCKMHNWx4Nr/ZlmF15gXOp6Dl+keSQtsKMMgtZqOfgdQ
         Q01A==
X-Gm-Message-State: AOJu0Yyhw6OvLwLhpYLSjUQnnh29AyME0vAqRofPPF7v18rCN6u8sXr6
	L/QpVdIwb+a84TKIO/Fp7tZ2rpEvSFdOyPEixyuFjg3+Qy5+oTuVGHHgyRY=
X-Google-Smtp-Source: AGHT+IE6UWOmLSm3RJfNlrfO+nY9YEK0pYqlmModC4uvi8F3IGsSjVlSxC4TJIjtKUrYlVLk3pk9jA==
X-Received: by 2002:a05:620a:1a88:b0:785:61c9:7968 with SMTP id bl8-20020a05620a1a8800b0078561c97968mr8005059qkb.42.1707116451258;
        Sun, 04 Feb 2024 23:00:51 -0800 (PST)
Received: from [127.0.0.1] ([172.183.161.203])
        by smtp.gmail.com with ESMTPSA id i20-20020a05620a249400b00783f94de52dsm2732457qkn.104.2024.02.04.23.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:00:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
References:
 <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
Subject: Re: mptcp: add a sk_is_tcp check for sk_is_mptcp: Tests Results
Message-ID: <d0f63e42-38e5-e85b-108b-4f2380dd8155@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Feb 2024 07:00:50 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7780432176

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/502ae07710e7


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
