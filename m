Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC039FFF
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757265; cv=none; b=WhRX7cuhfDGwrIkpTWEE8hnDxe1bAe2LyE4fns+5EwQDqmofL5uHd5eyvGmYpfX+YwNF3NS24dV76QBe7KU/+r6cyi19w8NNqe7EgRxJTX4sbT8iUaND4lpxY/7uOXmy+mutZcR/0menjeVPZXulBqeUu54EAxk+27drBfQcnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757265; c=relaxed/simple;
	bh=cBBgK7Vx8riVST+rq6dptAPnUT/sXkEbw7tOLrjDDtY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eNRAObZH3THE0+/WW76VQ/t2cMJpySRFWxcTWY5HLr9LmyMW4A040aePROsxD0PLfasL96UQTSMgvHITGWgJ2TYMVkvS4NE7ns4vLuvmog1IJYdK6yU15IxLhCBUnonaPTH3sWPQcuwO6HotoQw1WO4xhSGxL1OPKCiY8ymQNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA56BPGI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA56BPGI"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783dc658bd9so28024985a.1
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706757262; x=1707362062; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp7uDePbJYQeKshvbBrULfvn3CKUv+oFXs0SP9f17tQ=;
        b=NA56BPGIFUC74Sz2ss0T0KmZ2ZXP0fn0LUBzWlXrGp+rMJMFd98vWpSEkNUYaAxR6S
         UZHNqdHWiLb2wasLUB/DOFQ2RDZ30Vo4HWztW+lwA8OGdMX9fLwSOOcbuhtc55GzgQ2i
         kIOipuf4fw3gL9moWrKKXupQxvfg3nGrbNN2VVAI3ZzudcSOPvrDQ2cH3zEu/HnkBAQu
         e8WDozNkeu2OObh8Rv3zmkAeUrmOlVrhJo5bU21rRa2hRISAXJngxrolbys8IUIKanHK
         6ZFVxwyGGsh+zETw01sTE4WyHu4wLtfdg0w/hTWhINV4fBtlLR6NKr4F0RUiHk0677mB
         1iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706757262; x=1707362062;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp7uDePbJYQeKshvbBrULfvn3CKUv+oFXs0SP9f17tQ=;
        b=WI26Ic/R8LPIB5ikYa6K44AUj1vAvc6JHk1aksgQacsbosmqf6T4KEFFbaIVF/FTIi
         7PpK2y5XcfAOf/z9BrUyRmJ+SlpAd3Sd6oKnqPlF++eGFeX7KwefDScYYuECvSWKYDai
         fukbsClok+kujcFU29WNHc7IKIpMo7qfOIyTX/mZpLXVH85MECfZD89K61BTamsZc8kn
         wcWiE6d1fTkq12Q5dUvAVnPoY1UNHlXSGzRGDKkCpcwsKsEiOZrsmDwETh8mnFTjWo06
         N0tUqM9hrOvQ25ZcTqaykTxCfPj9+tPZHzsvTmXPuHH5H/7kjHIxpkuUsUzWZXDXDhnv
         KLrg==
X-Gm-Message-State: AOJu0Ywkk1TX1YLhblT6BE24A1nNEHq3J4VxEGDKQKzS8AGh/uvh1VRE
	ckkwFVDyEMNLjGyg5SAegbFxv8fdoo48lh6ZjzngcaeBIH4ixn0=
X-Google-Smtp-Source: AGHT+IFBdjBdBLZeo6NvQfNutKBFMO5WiUM26xy4vlTkMFSyOjfIlDPhkArJDL9kHKD6V+K1h32mNA==
X-Received: by 2002:a05:620a:6182:b0:784:853:4003 with SMTP id or2-20020a05620a618200b0078408534003mr1727485qkn.4.1706757262011;
        Wed, 31 Jan 2024 19:14:22 -0800 (PST)
Received: from [127.0.0.1] ([40.76.117.202])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b007840164c230sm2765794qkm.79.2024.01.31.19.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:14:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
References:
 <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
Subject: Re: MAINTAINERS: update Geliang's email address: Tests Results
Message-ID: <b89cf740-636b-0cf2-b12e-debebc75fae7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 03:14:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5507469795917824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5507469795917824/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6633369702760448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6633369702760448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2a536c07d503


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
