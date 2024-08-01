Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91260198A03
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520230; cv=none; b=t/63bbNSZVoQoSTv1l/73fKOPm3wgeI3LWb2Lhi1zWeAosPvTc1HymgHv4N+b8XsnAOekTAmez+Dbeorww+FMV8OKV3do+QztuBacV4BFZ54HgnlcjYOfmztfItbagsxrCocVRex3kq33J2T03ulhKuzGhMXIFJeP44VySOa73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520230; c=relaxed/simple;
	bh=IgH+NvwjfKkdFrXtcSnOqZQA7AWizdlKKc2xFg54jcU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=j+Ep7D32pXS8XscK0oD3eD/LoqbYhUE+l+LCl7bB14J8fadyffwnSVE98pNl5lJxbzP0efnvj6USQNBaGRRbS217IsTnA7lLuLAS9812Mp3bHv/ipxO3OTEwrQi0MFV+hWUmi+/IvKL45d/YkGnJV3vlgQgxSd4+0Vjs7J7JoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTBufXo6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTBufXo6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bb687c3cceso23101316d6.0
        for <mptcp@lists.linux.dev>; Thu, 01 Aug 2024 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520227; x=1723125027; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+zX0qTcx9uPVW929BK6dGtj5LM8Am2JSjNJq26mFZs=;
        b=KTBufXo61vdushWuSrzN2v+rl6RwVu62UHJEnYjBKCFonq3NhQJkf3icflbmKuaWvO
         FrQZJkWZdKDlrUjm/U/3PqYJc13U+CYc8ygg1SAnYyWSeAFDVgTr7hWWGhOzgCcja16i
         rQ6dweEWD4f+QpsFcYsd85fENqhhlkCkBD/qguPvqqVx/gFhXhvPeSQBGAICdh7oXho+
         nRI3msPRi3su14LOcUz0w9XWqlQD0RnUu7NjHJ0wDUtSLfNIfWR1ZOzjyiz5NbgKqSoQ
         5yrhu/xR+cmlmWgcSrUQ6bjhn7Lr2rEkvSyLmd1JCy0MEUp4+FkhW2dhtVJtSHwV1oO/
         ZKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520227; x=1723125027;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+zX0qTcx9uPVW929BK6dGtj5LM8Am2JSjNJq26mFZs=;
        b=X5T9FUUl2Z1yR9ganXw3A1sbpW20krXBPuRMq90U67q7TUBgftPKnynUXRSMQ5uce2
         CTrOz2/Lr2sYN6Z7VQiyGkWoU+FNBAppQe9yZ2BXYfR/D3jVMPR0ePPAtnradLGFBsuu
         ckcJfkAm8IBdLwFZUHmLERH6wiNrWkjQettlHhVTMjeNKL+McKkOitR3lCXnLPRHsoJH
         0NRaOz9VnQ/yiH3GW8IOnnl+2gX+9+cfcNr/2l9CFcExZgWp4Z/Xr3S4VBAjggPi/hdq
         XsP/lD/2kEIKeHwLKNBKQ13FtsExD68c1o7OQGtaRm1IJxfVSUSWLqBKwN8XI/IBQOqk
         QgHA==
X-Gm-Message-State: AOJu0Yx8QthDZjm/4vOIzKFKALexZfYlopFkrpxDqFyKFGleCPg0IcmE
	JDQqjmHruTL9eeVTfAjpj9nDYUcWGx09JSD7UqAuVZ5r2o8SNlf915W6
X-Google-Smtp-Source: AGHT+IGzdZbh6j823imZv/2E1+vrjNUioWWboRroTm8LY7BbwGgvoizCtoVMF+FjKCXF4YjS015Hig==
X-Received: by 2002:a05:6214:5d89:b0:6bb:84d9:8f89 with SMTP id 6a1803df08f44-6bb98379d96mr1803926d6.7.1722520227323;
        Thu, 01 Aug 2024 06:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb0bf4asm85354926d6.139.2024.08.01.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:50:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1722517019.git.tanggeliang@kylinos.cn>
References: <cover.1722517019.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/3] skip test if ip mptcp not support
Message-ID: <d618b50a-e42b-43e4-9a60-3203b65568bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Aug 2024 13:50:26 +0000
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
uns/10198995225

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d1d49379e03b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D875915


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
