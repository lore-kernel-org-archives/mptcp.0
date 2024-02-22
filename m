Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062522F0A
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591906; cv=none; b=pbmv38+3tlNirqssTDUu86L34XWlRGfQiri/XHfdYsn859pcPjzpUMMBRdHKrfg1wCZwGA96TArFieFrGZ6P7NF8vRDUWD3DLeYAkVV0o8w3g+O0VZ2EoXICfY41SZSIPhd+5verZG7ll7ubfvQq41nxO0NwxbODWkDIqXJW+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591906; c=relaxed/simple;
	bh=Ukw85PcA/klb9XkxRncrJ/LxkAhVOr6/75od6T6e6Vg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XzTVt3PyWgJujnMLfaglViDjyRUzggDXFagJx18y4RgN6+ZepO1pdw0IGi0rjk/vG+wH+0OOxbITJreGU3sMFvv2boQt8n1/gxpq5HWFE9pwG0O5b5U0RyXCy5OIJiKCTkk3Gqfda7YVX8UK7syOvNewduVSwaYM2lbaAcQz4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXua79tF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXua79tF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818f3cf00aso44614906d6.0
        for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 00:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708591904; x=1709196704; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avYb7OQRj7nInMhTO9b7E5PhE7dasTBfyWx48YKhBrM=;
        b=RXua79tFFmJr1A06M3LB72z3SSFt+yIDNkFZYCjjW/NVO7w4sJDI5At0YStUdWRUA3
         fAUKN8NWWr9kxwebjYYrXaPSCeeRboNR9L1sYfmUwI2vpnSL7NXkI3D7wzaWom1Pmvi8
         3wywJvlXVbycePiE3nLVu3RKUcAsa4C1ysGb7rWtNwlkdi0CWevdbSrG6+G+yM3L9yaX
         P0hliYFEB6utKwivWAih9KDdcEBFa6JLPWOodokYiXZM2SfD2lGgZl96S/QO6dzvfn2i
         Y0X5Q82sNmsC2RDpUbNp54G0snR/rgqa54SLjh/Zs4+EIElsNUlqIWcIQGaYwh8P3TWZ
         s95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591904; x=1709196704;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avYb7OQRj7nInMhTO9b7E5PhE7dasTBfyWx48YKhBrM=;
        b=gUwyLqhPuqDRwO0YM5xpz3IZt8WzO33sc51QY7/g4hVOuPsyTA0oyKUbm1KnOW8HcV
         nHZaLwrci+/ndvOr7G6k1ZB+iw7Crf3qbOMHaDbqWXeqIZsdRCsWBaDYdoJ/2MtZLF5J
         PCPyEMO3HeKfU97cnT8WCd4eNav/D3YZhIJaJwvz0gfCxuw0DzJrlb4UdzOFsB83Dtow
         /ZAV0SkmoZVhL9Esjb7wGqyL1rsDRH9edIriAm6bmAIyRtyKc7YPh+PB4UYybWlkhOJB
         vgAKb44qDL0lc0Y6bF+5v9uyVXoofAWLDdnPjeSGXPlKq2OVG94hNfFUWShEKO6oV+AB
         pMfg==
X-Gm-Message-State: AOJu0YwdFfI2fCE2ehW382Za+Jq46jvB/Xuxi0AILk3ZPasqzr+mb47B
	ZoHSFnJG9dTFvK284EJdaMLJ2taU+90pzhQNK852JJd1uwilmzlGflcAnSY=
X-Google-Smtp-Source: AGHT+IFtHF4HxeFgLFizRagGWO0oRxODYrDuILGV8cnqVK0jQPyJWJuJeiysz+3MSL3uuowV4R/Q+g==
X-Received: by 2002:a0c:f092:0:b0:68f:3ae9:283 with SMTP id g18-20020a0cf092000000b0068f3ae90283mr16178699qvk.25.1708591903734;
        Thu, 22 Feb 2024 00:51:43 -0800 (PST)
Received: from [127.0.0.1] ([20.55.14.148])
        by smtp.gmail.com with ESMTPSA id lr10-20020a0562145bca00b0068c968c3b33sm6519227qvb.20.2024.02.22.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:51:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2a89f983d02141661c2f7cf0bfb4109ee74db60e.1708588977.git.tanggeliang@kylinos.cn>
References:
 <2a89f983d02141661c2f7cf0bfb4109ee74db60e.1708588977.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <db81fded-710d-8798-5316-93e324c0451e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 08:51:42 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8001362171

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ddc6b3c484c4


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
