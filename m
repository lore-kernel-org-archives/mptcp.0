Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578211B9B33
	for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221103; cv=none; b=nZVGlyfVl4e8AqDHzlcTgLRo1MLxzkHa14BZZHgvhhbqkkV2UzdthBRTuaYF7G98j+6lKT0vioNwM82aPub+6/m+Rqqs81oclTbxiSbJzig92R9KNPCeRrTsqr0maYgj6cS2YbrMQqpvJbynh+Kfdy5YFkhW2uFg7R4K2dpOpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221103; c=relaxed/simple;
	bh=U3wZkOKLegFOXYzUQn9aOsx2dtAY+xnPKmvDxavDQUA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Sm6F9vk2TlIruY+xWPTuT5leP0bae62wS5HWE9K1XsM+4p0bo2mfXVHaoQcw2kXZ8/sTjtsi/7tOfIlPN7JnMVG2f7HC03PqbAFCaRqEXkJSi4aZa1936daFXjqFNX3fP30zaLdN22KkMJJ85ozSRHCxpe2E4z8wkPGAA5hTyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iit18WtZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iit18WtZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c352bcb569so10215606d6.0
        for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726221101; x=1726825901; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KzdDkpwkbHKm0LSXz8X1EUQOOjLjzg9AeQKvRN8bzU=;
        b=Iit18WtZGViulyjShNmJMxGXr2xGF23N/8z0EPlM4bu1vJoaFEODGpajlW/DmmzPfz
         OqHO6mw2MaxWLNPRyEhJyFd7YzIvxX/wLuj1wFJUIDFseTKskLRKoSTvzlN7TEAdUg7H
         vJMf6oLmJUzbkjdFeljNvggR1lH6RLpyBqPos4zYiOfU8qlH4zdujAoBufqP3haCKS85
         4WaTR6OLhMZ8mBv4uiDQD+D33/VMxH7VGdmz9u2zTWWcG0pTICEp/kRw6biCYc+tfZsd
         y1YAJWdH1U/B4Gukf+Yw6gIo9QKMYlk8UduNKfN4i7YhRXOZpY8ges6VcId+3O/yitmx
         hR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221101; x=1726825901;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KzdDkpwkbHKm0LSXz8X1EUQOOjLjzg9AeQKvRN8bzU=;
        b=seAKRUVLkf5se9w8vXIzVrO+vvVcitncBSXdxz+trYBFWTQmC5pK13Rhr+KhSVrIYu
         e7FqPksC8hJyrqBypgg0eFdFKfJa+EIPvUO4cgqhLf1vSFBF0H2x2/GJaH0FLm1bLzJe
         BTvu6o6EF4cIKAuBrH0eP9ykTKD4I7iOiqtqiD/8EX7J+V3FT1ZVos8OSOSwCrIBaeGa
         m4a2lZ4mgBFXpXBz5vjq05JfPQOKACcbXZLkyNAlaroQzSF0JNfvKsvJuHUSnlMKRjQQ
         gw1tfNkxc09nE5mWbLVAM86nNl0paaV8xscAa6DhHGqj5wHRHe04pCZwUp3mgYcYfI4K
         Hznw==
X-Gm-Message-State: AOJu0Yys75CFfgjZ7a6ENukPrszqHanPsNFjHek9YAcEhDoOosvVX/NO
	u+BN52gap7BZf/ZOn+YfPOH9R08cAB5pEtPi9wLMjvMGoz4WmuCfBdVG
X-Google-Smtp-Source: AGHT+IGh5LaW+x/DZXMz+LTqrKA4a3CjJqQnt3avuegDayR0w6ZgTKJKZNUmKHK3DeP3VkgZDWXfbg==
X-Received: by 2002:a0c:f410:0:b0:6c5:57e2:88d7 with SMTP id 6a1803df08f44-6c5735bc873mr78177156d6.36.1726221101096;
        Fri, 13 Sep 2024 02:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5347871edsm64536126d6.138.2024.09.13.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:51:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240913085555.134788-1-ast@fiberby.net>
References: <20240913085555.134788-1-ast@fiberby.net>
Subject: Re: [PATCH net-next] tools: ynl-gen: use big-endian netlink
 attribute types
Message-ID: <9ba0c220-b3ed-303a-b643-4fd10388a756@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2024 09:51:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Asbj=C3=B8rn,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10846362552

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d71dde59bc3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D890048


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
