Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48244EB4F
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428051; cv=none; b=G51vGjtqfwiwBZu5DQRPRkuCPedT83IKO21CQBDIUI0yti7UGw2rk7bRazTL6FqOEUxnlMjb9HsPaaDktgSMRTqae6uzFsgX/2FQXTWVcLoUealj45veY4O+4BNnE/nIBi3zb+o8VxPRZY12yK0lMSPMnWS3YX32HNuQ06oxlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428051; c=relaxed/simple;
	bh=fhUlCu5UsUqq7vo/J1PIROPNzDkYsGINcGDdX7dTQ7g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=X3yaZ2qbYB+sP+yxdYrycjvyMws6gZAZIXPn2jrM+b5dGQtAkhhjDY1hVZotOxsiIDFgrEeISP4nFkxxrkNZ7aCEoastK60KT7U6zTKXapqcfE4jErdRfGtTm70Sigfx9KZY2WeBDQIwJKRFLcNwpQQ19I497V5pSn2sVH1GMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIsVc+7m; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIsVc+7m"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783d4b3a026so22892785a.1
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707428049; x=1708032849; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDeN8u6CaFbgWwfq3FTTfBPeP9jK78kFvl1TVdCKBek=;
        b=BIsVc+7mj9gcF8jC2CjwfHo1mvSTgOh4kJZW+XrPywraSPQDmhuhN+IAZ/Mjaix7Jl
         ot4CSb/ReZ96CJL6IY2RhvgOPEi2A77Y8I1InGxOOoOii9a4HI6F9fl0ac6NCed1uOiv
         U/UUxEPyWJZ7vY3bnYuQ5HskwdTh7DFO+p1IFNSguMZFdCYm5H0v5fNvdDt1tdhmuxDT
         WeMgPjni+kt20Pa3C4HqBL9lJFs+GNQbKhtISrOqFYfl8gtJhmtDvufUstGfT9ooleOO
         rql7hRSabvq+yV9KB1DdNUpgP0Vjn3xoZ43FWz99e31SvRZfb37e4p6GgpQRGAF56xMC
         huzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707428049; x=1708032849;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDeN8u6CaFbgWwfq3FTTfBPeP9jK78kFvl1TVdCKBek=;
        b=IW7RXF1r2TMXuTfzYjnxfwmCTj5Qy7zASuOiRJ0XoN6yXiYb/NQBKF0HQbl3HJzsoU
         Xc8Vb0xAz05SorM8zId9N/ymHAPNsGDbryjx7ttdwLqF29OvpupiXXPwszvvRF+NWYYd
         zsMYb5hfv2zAMTwnxsZt5FmHZEn7y1OKKry06Ffth1MD7TRbSCtDnT3m9DgVVyZmRgmG
         +qCfrrkihzuU6ghn8WdqZq+LAZHg2fCsEWktMRc+tuTyQ1uHXRg3FFvfH/tyMCBNUtGD
         v4rBZc5gNXfe85j+DOAFL+oa1qBhM3/Z2T6sxH1b3Ggk44oGkjZ6snPiXU0ltxlFlAHr
         FIHg==
X-Gm-Message-State: AOJu0YxlyFdqEsAYdNQGBbxD+mGubdPO6xPnK9R+SxZ+0HSSmitCADtV
	iTMX3ySnXOzHOmK00Qi0tKg6hrqn7+/2TOFm5MrBBqKYEb2cwrA=
X-Google-Smtp-Source: AGHT+IHhHbRTF01uzoEP9TixYCg07ROEaf3jVvsfbW/hVceTBjgdJ0TtyVQ49p/LNxuXM6dXsdL7Ug==
X-Received: by 2002:a05:620a:1453:b0:783:f6a7:6d9c with SMTP id i19-20020a05620a145300b00783f6a76d9cmr796731qkl.27.1707428048676;
        Thu, 08 Feb 2024 13:34:08 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.191])
        by smtp.gmail.com with ESMTPSA id vu16-20020a05620a561000b007857e7b35d0sm174277qkn.114.2024.02.08.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:34:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
References:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <ec60ff80-76da-ec65-fd48-265ad54c0994@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 21:34:07 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7835837100

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2770999be5bd


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
