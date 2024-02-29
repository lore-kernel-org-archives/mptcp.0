Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064279DD5
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203404; cv=none; b=cKcZjPAyylYhZO7Ql5YhSEvVk9iwgTRZB5OnYvorCkDs8vEHjJ/fYSfMJpL2/RqqpyiiD7RQNTXU5EDbucbP+7sQGo8peVTAe/PDJhzMZdBrC62aX9iEyJAOAFjW/y0iR/vuOiR+Cmohrkz97LLMbyYdcGBMDvci95Kp2/QrHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203404; c=relaxed/simple;
	bh=QSC9ZFyErEy2maP16nLsimG8hUAhghmtxrXt8qLiOZY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J1XfqseD074e0t0sgTJ1Yw6d4CD9jW7adQYA0AN37i7zuqOFYNotkBI8n9r2hM3mOOZS5OzBY8Z0LL6G8tot4edolqkZ0MnHgGZP5/xFv6+FxIrZZkEvQqafg7WqqfOG6ZcTBhYSYpGD2562cc42y5WcvCh/ZU4o5MhtzTXRxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmfppMud; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmfppMud"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787a8cc7d95so57723785a.0
        for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709203402; x=1709808202; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J45vuV3fZYFURzKeRIgiKg9d5uowKh1sZq3VZpZe89k=;
        b=bmfppMud4vfDOSqdAsUxATiZsdQOB7YVFE4ezGKMVhJPLZxZ1RKytDZ7a19kdNQn72
         s50r8wMWUYvNEjvGI8ZFZ3ChSvq0OAnDOnV/GiDRN2RXWHtk3WAXweoPHOY8JpRRi2C1
         l4frXfwdjtDceL/jam2zFG1aH0Y5gpJUFoZ2rDiS8Gha4ZjZNTtUVl3whn2IaSiAsPZ9
         AT9K0X4HD3YeqI9Afq/ApQgpgg1BuhMy0ZH2OUirnhY4efqdMSy7ZyNx8Q5TGyf5U6q0
         U9kMxeMd16WE4l5TJNExGljK2eBQz21UXuRQes+QBFJz5Gk5+DQ920EsT6t1r97ccFLU
         Gwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203402; x=1709808202;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J45vuV3fZYFURzKeRIgiKg9d5uowKh1sZq3VZpZe89k=;
        b=njTglmvSCMk4ZBHsJ4/8OwIWbr2ScwZnCt45NSHD5eaocQ6pXUccQ7CIJhFQWwlWgA
         u/r56HKTWGiteWUkL24DFL7zchUc/+EjwMJ9svyqXZ6m71jwzc1h4Fgbk5mpVAypY8l8
         96p7AeU63V/KSqo7aSxlC4Hb6MI4I/svnrAtvnDF0AlOmtL3B3bLZoD3J85V2aTkckcA
         RJNgTFaqOhoKZwd0/MBJ/rahpIPVLd2CGiF1n1DAO+mSWzywJYhtebjS03DQGrRcko1r
         OO0/BNaAw3BUGfWMAppb7NWMa7RlPcoNpLZRMi5p16tmtj/KZkJZPI+2IaHLBYlO3IC3
         BH6A==
X-Gm-Message-State: AOJu0Yz5nQyE3zvd+C2QnVWRLHnVXaENGCr+NtcudVrEJjPcX2ke25YR
	X/bGvy9yeEXTNWfeHbljIkmnK7gxxQ1zHVZ5WjkJJ3zpGSLOa+yexXw+0co=
X-Google-Smtp-Source: AGHT+IHSD+jplRozWWAPOF/PhbvikPe1/NHKLdWP6bGcITErSbonLfF4sfLtikoKC/3gfEKKWrgkmA==
X-Received: by 2002:a05:620a:2a0c:b0:787:debf:c584 with SMTP id o12-20020a05620a2a0c00b00787debfc584mr1974256qkp.1.1709203401920;
        Thu, 29 Feb 2024 02:43:21 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.192])
        by smtp.gmail.com with ESMTPSA id f18-20020ac80692000000b0042e2002ed12sm581236qth.57.2024.02.29.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:43:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <81fd6204fc60dd90a4410b3435ab4552402b71c0.1709200070.git.tanggeliang@kylinos.cn>
References:
 <81fd6204fc60dd90a4410b3435ab4552402b71c0.1709200070.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <ffb7309e-fdd0-b604-83c2-0b85ba50acc2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Feb 2024 10:43:21 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8094234270

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6e081d52655e


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
