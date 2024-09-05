Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAD12B93
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547514; cv=none; b=UWkvkggo7Ixu5jhasxWRvfCYViqd0hHDN5wkRuZb5HyrfRMEUuL2c3WOtHDbfTGw9GKGnw3jcA3TuBMyljSkmPPzxIBLMopBffNzUfmfZZ1gqjAPwAP1uTMhCeCkwmMARDB5ycQ2DPWLqwGNadSNmoZ57287bXq01tUdKJlHD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547514; c=relaxed/simple;
	bh=PjsccrF+kHfvOaigN6PlawldsltavZazKz4T9rbViOA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MgnvA6u6TwtrLzTCKctroMaL/LExPhNmfsgELZLKGct/GE4rIez3cVIWynBnFSPDz5F9ZDxtE2PRqkf07wHBaVwcJkMAz1gr8JI+4ya1PZzWjOP5aw4G2AZf1HXNQOEu+YW343ZelhXyEbA6h3uArY1Vf595ylhVJ0ywGjFXv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS8IaeSD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS8IaeSD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7176645e440so623856b3a.1
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547513; x=1726152313; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq5zx1NGUuM29nUBN/q8ewvENiitm1YSS2c0WBZSyVw=;
        b=YS8IaeSDOZ9qLN/6UPyFDQHRTF81kMrgKz4wakgfCDK/ktWm1G+tT0hqYKtryGzciY
         mSxE7qieC6ETC6hkR28vx4dmbg6WGyoB7Cbk0IhPkEJOzq27x+0Eht0K1KzbsDYSXDjb
         WTi2u2RykLA1HxOWBTN3jSzJtQ3TNR5gglqe+jAHytwI3FzOI26hh8KXVxEHhw8oPIGU
         iFuCofs6YAn5qgf2ImuHCz/bDZU0JxMwioRGAFV+3JK2PV+b7V2KH2V0Tfpq7EA6Nuz6
         yto0GHTWq4on0u8ZJlo1T8jR3B9uxTrFIlRS96PKkiuBV2VGCcCAr3Fw/FQUSn8uxL5n
         UXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547513; x=1726152313;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eq5zx1NGUuM29nUBN/q8ewvENiitm1YSS2c0WBZSyVw=;
        b=pFSuQC320bSJ9MhYukuxKLhC81BQ+8YKJ3M0zLeGtRK1RnEx5GSkUMWujch5Ap6Vqv
         MaY5XbZjGSHRCK0H1JhRR/5h8EyC21Z40XiSBhs/Kh+l/UD9aMLOZu8L5Ypc2ousPW/N
         3gmGp/GvqZOJrUicOYeFZNBFYL6QLzryb2OCfKH/ZOJiQOR4zQOQ33jGyGkl0wFHZmiI
         MXXsiLa0z5y0huzFYZjgYmf/k5y+X9jsGkpWwxtu6XS8nBRvOBJeiCGW3ZpDJ6/93KHz
         qNsnQYiaBboyItBCaM95jVwauRVmzvFSmjW5o56ldhDiORLGqqh8LTjhGyIJKKSVyvXi
         qYSQ==
X-Gm-Message-State: AOJu0YxgV0xWLyaEyUlmD1Xrr1unIdXmDWGA3voGDW/YHWI2D/OQLSvL
	95eoSe/eqTcSxarhvIcS57mBqbD8l7pLTIESu9UZVonpQB5MhZOCDmZY
X-Google-Smtp-Source: AGHT+IFFpsy/Rn8efztAX9t/f3YimNiRA0+tBwpK90HVAty3IdjPxN5vmfa/m1TMXYMcLWhH1GSywA==
X-Received: by 2002:a05:6a00:3213:b0:717:83bc:6df3 with SMTP id d2e1a72fcca58-71783bc6f5cmr6677066b3a.11.1725547512535;
        Thu, 05 Sep 2024 07:45:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.70.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd93559sm3436964a12.54.2024.09.05.07.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:45:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725544210.git.tanggeliang@kylinos.cn>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] add mptcp_subflow bpf_iter
Message-ID: <5b812e91-5252-aa3b-52c0-5813f47fa478@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 14:45:11 +0000
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
uns/10721986852

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/88ad9420470b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887267


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
