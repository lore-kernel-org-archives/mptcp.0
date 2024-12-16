Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD6847B
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317269; cv=none; b=fhL5QErFce9TLYhq18y4xZZkshJjfi3NW79ZlvAQLJP5kWJoWCgFeClmYZckeB/LhuIYAcBra1Cwe6vZTrDrEXKzuqgrMW7DbiqWLZSd+rxidfjPSoE7jXO3BE1K0hdL/P2AT69MPx8EsqRLjzvPf+ChbPyHOVJrpeV6Jo6spXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317269; c=relaxed/simple;
	bh=OkitNcQPi4mVaMgw1X0L8TfJ7dkkdxbafV6+/hmwMjk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U7r7K1QpQjDo/RQGQWqVbBf4qDfQOjo483hHWQvvEnxdSbmO+FKRWK9SJlMobFLp9afLC2HWjoX+j0E463vKxG0oFs+YTgXqB0RLw5hdrSuusK7earMWz/T6r6DjEnAihlDL24oLaoGzys471htTfhdTZMVpTa8plKG5IyAdJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYdGAy+C; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYdGAy+C"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678cd314b6so36808481cf.3
        for <mptcp@lists.linux.dev>; Sun, 15 Dec 2024 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734317266; x=1734922066; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XmMKogBLtFIyvH8tpP9Cvurcsl0HU0IxYeLYFwvOpk=;
        b=IYdGAy+CJjd0SDC581NIKp8hzHh/1faLZEHzOCzAiMED38SmaLJ+QpTmCuSOQge8wh
         B15be4xNyWEKmMjEBd3rMvU2DcI8y98p2ORLNOmS3C/PBul/9MM/pMLaWDNYFD23UYsd
         hGBCxItaD3eHPjTnYVFIQAEXgV/Iw2QEX73phxbX4W6p4B8pzoC9N6PWoMH4e6oj0jux
         XsFBQlnArcEjLjFZUaQ6LpO9SUfR8nwH4xC9scoWOd+FS+MF9K2wb5RvYi7qA1Az5cKq
         ZRcE/1lMqU0MIxZIj9pHryOY7ULt+C93x1GMs5GT7VeGwb/G7WeLz6tQ76OfDIeVeg/c
         9kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734317266; x=1734922066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7XmMKogBLtFIyvH8tpP9Cvurcsl0HU0IxYeLYFwvOpk=;
        b=O2KGqzaz2yfvCajCeCh9rKSgEmWmhB4pzpI7nzOm8/T00xhFObOibcbXfz0dZXaQKU
         nZlILVoTzhmYkA6KN/G2VgTbNrCXElEf7qLfjvs8JGLXb0zdj82Ymnzr+5AQEECk8r4r
         3UdPWmiMrwm7f+uW66/VlMFeYfpiPmI8HOwDAtTMH6/O9frqj7/oGPh7YA2GYf2rESZ6
         uRF3QdydCz+nD2cSARmYbcFdnpLCP7pAm38C1jHJKdLBFPaOnTDIATb9U1UNHVZI0WgG
         OL1HazPUq7Ov+aGcgUTfPEmfElI6/YUfE46CZtAamF8PIjfjQUpGgrVDgW0xqW2CQRAR
         kmYw==
X-Gm-Message-State: AOJu0YzVe+7QJDLNA9mOyEo1853W1S0zgS8sBMiEpQ+EJJtXMVd5mqIN
	uobar2FC7FCiWcvmW5uFMDhVKvxew2I5825AvFtWscHUMLiGf4i+hQun
X-Gm-Gg: ASbGncv36Y7BXWhX/NMbQ2u0Zx9Ti9hg0QiP0D5/TkBHxdwPLJfKHeEMQKoFCASfI25
	Ugo079dT91JKH12V/A0HCdEEjlbQnQDCTJK+pHLYaPLzzAEzTLuPn7VBTnBB+VmZCA6BJhx+Sqx
	6S/UE1tRbLOEr6byPSi7wpGwbXrh+tgM4+zAN5Swox3QgpF6PNVFVQRQ17ZCw+325vNQqOc1RvB
	SAwGXd+cO2sWNomytpBKm6HCQ+hxxqoVQy6A4BrQQCb5apGYqVbs7i0lAUYqdCsuA3s
X-Google-Smtp-Source: AGHT+IG4orw1+4RlVlTo7XRBionvJnZPvYpmY5o9DpuE2jyvlmrrlAOyVW3YpxuEEZdjOEza0slFnA==
X-Received: by 2002:ac8:59d4:0:b0:467:5a0b:de08 with SMTP id d75a77b69052e-467a57222f8mr205742421cf.8.1734317266268;
        Sun, 15 Dec 2024 18:47:46 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e81708sm22875381cf.58.2024.12.15.18.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 18:47:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3f7656f9232ac4a36017babc0eabf5059c283a63.1734313517.git.tanggeliang@kylinos.cn>
References:
 <3f7656f9232ac4a36017babc0eabf5059c283a63.1734313517.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: use GENL_REQ_ATTR_CHECK in userspace
 pm
Message-ID: <152b0092-f69e-54a9-6380-14615c4d2580@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 02:47:44 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12344549631

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b5a63ca29adf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D918034


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
