Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2652F65
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914238; cv=none; b=PWPEOjrxzWBTuywHjd9QHfoBE1jJoxm1LkHTVtEfYYQcsXyjM9GjXi2My99ljJXcAW1vJPxGITK5C0k2GtKDXrM+hHJqVV0Of7Us7mvzNeCnkbfRur335I1W7zoewLCopUPwmuAfWFwCwGg8aFCbnHtUZe14o0sEkrBQcl4uKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914238; c=relaxed/simple;
	bh=F3xtjJZcv5ehYsH0jD0AyB8QbF36EQEay82CgV+qN8Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Q8y7n20bj8S6Y5S8y5gjTmK6ySdb+k2C0j4OlT/Dxfzors5uBL8nY+23cfNbluP79tO9mOqp/x+p0tUCkJbY8IOPt4+49t7kDt9YMuckU9UweOgCZzgFKrQkltivKGJiVH2n8a4KMQUUfuhglx+3RcQUlRSYXB5kWVnjUBrZZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBk5BMD5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBk5BMD5"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c0471954faso971838b6e.2
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914236; x=1708519036; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecOj6a1FANoHowdf950wxmhD2l9d1JWnuubs3vat974=;
        b=bBk5BMD5Y0hffItT0FnB2ac6aiA2t4QLfqbJt/KwTK+FPlav5DPmvEvzCSBbRrJQTh
         tJ7nYq+6JJ30BdeKx+Wvi9e0J0RBdxhz8fwcF8wxCCGtWJqfsBG9Bs92SVfExUeCC01I
         Uu1dQCI+xfmDgPTYdUGejR3t4yw5H4YOehDE08EZDeKBSMRaryxR81fgM4DBAtBTn//p
         kLdjAhC4FM6upou30QFp33mSDt06cCzNZgQJLP6l7cmAwClJmN3NylbW1Sbvh/kLAY2x
         N6zKqP1fJoiAfuUnisULlcmUxBlQuGA0vk0d1OvoKOmuVd0bZ9i89wRiW04kS5sAd1cT
         R8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914236; x=1708519036;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecOj6a1FANoHowdf950wxmhD2l9d1JWnuubs3vat974=;
        b=TWZ7+6OylbXcb3BlHcHOy1vCUTnFFPu0bcQfPONYGiiP+sNdaPFKh5RC9M0rskjG3w
         KhihDwDzxBmgnDa1gWgAgsqqDIwsXxDZFFze6CgrWZ1EnO267PdAZi9PM5wlQRxRI9IE
         mKjBU0B9jHPlrFPBUfzurkvSLitltp45eZ1h41fq6aDGY47g8kdPwRlRiDdmrMJHZK53
         GxRjLVFoB4Fps6LIbb1BLKHs3D42wCTx3SMacxdj1fH60LRMtG+OmqpcF1dYvibjWQtT
         mF0fZ8bHaFIjswHuLIzKcVrUiWrjcVEkDnh5BXrqt5dbESfYT0J7aiIvPJkYv0lYBTHv
         FXsA==
X-Gm-Message-State: AOJu0YziJljPlR9hlqWJPuW3z+gMQKD/LlrEWmcDc0++tzKSDCGqAL8d
	mEQ3i9rBX8xOBOqcn9Wt71cSa/X+Z7fNOL5dqojUDWn9pAK0OHTBLb00Fzk=
X-Google-Smtp-Source: AGHT+IFMPFO7QTxyyDdIDKVkMShM7ZFwH7quPzIOnWqrkt5zoqR8cHOxcJiWcuPgoswds+R0L5hs1Q==
X-Received: by 2002:a05:6808:1487:b0:3c0:3f3f:16e9 with SMTP id e7-20020a056808148700b003c03f3f16e9mr2849555oiw.12.1707914235148;
        Wed, 14 Feb 2024 04:37:15 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.146])
        by smtp.gmail.com with ESMTPSA id lv8-20020a056214578800b00684225ef3a0sm2224868qvb.93.2024.02.14.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:37:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b46824466aa1ede15dd8c8e0e5d6233b8b85ddfb.1707910454.git.tanggeliang@kylinos.cn>
References:
 <b46824466aa1ede15dd8c8e0e5d6233b8b85ddfb.1707910454.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <6335189f-669f-9503-28ad-574a79be405b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 12:37:14 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7900781714

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ef0e97c755ed


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
