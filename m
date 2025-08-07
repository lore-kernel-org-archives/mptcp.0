Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6C4A06
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596189; cv=none; b=aI1xknnapI0W2DdL1yYAqJJk2xCg3P+6ZUUBtOTtX2axlKN9Hb1dR8LYzNmHF/xnJOJGCV8jA+wthrzz7db+CnPmKq+uQNcXmtyCZb+m5STIcCWqepE/O3AREWlAyTVIM1xL7wG4wE5Q0YXykzdZW6BBdrt+ebFAN2Akp76sZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596189; c=relaxed/simple;
	bh=K5or4jXvD7zRNbFqYvMcQJCuLbV+y1TsbQPl+v36VAw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PJzst/ta9xZujHukw9wYsH1KL2ZU/rs4KB322sVKmmClcRIWYeAhaOaJSHH/6CTXwezI7XlyTSkVAsm/7/fiCcYSfptrDlRfZR1SzFJE5EzScPTgAamgiSiZO0U9w5i8Z9BdsEU3zS/rpWaWj5v4XszWQacl5DUjJlm6EmMDv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmJEZxqT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmJEZxqT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4af14096b9eso18788351cf.3
        for <mptcp@lists.linux.dev>; Thu, 07 Aug 2025 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754596187; x=1755200987; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS0FQkBVRNL+DOyq/Fzl4T2ppWxuj5+7Hy5Xcztz84Y=;
        b=HmJEZxqTBPJLegL1NGtfpxxtvyhf2DSgdLulWlh+9EQdFQolyhYPEbAhN3695kGmEV
         BL93Qz6kbWVwbiMVLZK166nAUv+QnF/Y9DV7QuF0eJvSYoxHRT6cYBhiGpv9jFGh7L6d
         qhnh/oTO6lmneeFCx/x3IEwbzs77hPKdGhIHCUc3BGv8yT4WnQDLw4jHhr/osoqfk+BK
         t99MjYjPIdnT8uA9tQ9ptUC6Xdb5DQW7REnEw+kk/NUkvKeNklTtGhrLwPXP6aINUSm6
         K409387Fc6yOkvYSYUCvcQ9eBQtoPeH7pz5P5W64WoLy+2BEZmEi7ZW7R0i7ZvBfgy10
         Ef9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754596187; x=1755200987;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KS0FQkBVRNL+DOyq/Fzl4T2ppWxuj5+7Hy5Xcztz84Y=;
        b=SOZAbYafJbiMANt/KEuj3UMi5WXjiSju3diDhAoh/IcwbJ1jyu+v5TU5FhU03mCPrt
         kqX3MUouorYcqOBgfvUvtIlnd2g4v51jpoRYLTeanjCJlJkgOAacGWLobwJgVR7X6oFc
         1NUTtsRh6P8Yk1EsqXoAveNbXW29uKRl8WHi8KZbuSkXuSIbo1IZwB4vb8ewrrkYTriu
         5116sgVC3f6zCMupOsGwgdmyAUXuS26y5iuJj4b9wyEaN066aP2SQzS4/MYx0Arb121B
         8VlI8NSOQkP8TZQOyLWiuYBM/Zu3v/da/5yIiGVrEQgczl/Bf11LRdCwpUO8cPKoDcLo
         mrhg==
X-Gm-Message-State: AOJu0YxFM5bSE4EwxrZTYqdz9RhfID0tRTNqBv/D5eUWeOfw2ozR60TF
	dfi7r4+zpuT3gZTuH0r2p62JXZLirZHee6Cza3S8Tzgb3ECiuyvvfM220vtzrfA=
X-Gm-Gg: ASbGncu4Wc9IGK5d7ZgJaFG7lz9kutlhHvoyeuzRhFWa6XFxUSK+NuZGAn027C02bdB
	OAytaliiCg1KSQU9LD3s5vvsVVreoRopoAF2eHJUP/fNPerbk6mafif/0KmeFAXoqy/BHvMlkE0
	KiTvrt5XAkDNggdN86jVW5lYhbgNExN995nyAReUBi/NPJm682AehwE01FnK56JGxK9kQuxtUJK
	/mAqS3q7CfvWdQbuvaIHVbEotwvdt/pIJwkxljilT4wUgEJ+axk3kyuxzcGUN427Nob3ALAK5/c
	DzfjV+n7c6Rk2nG0L57OJ0rpYH68wTgl123t24yf2iaq7ZqcBPvDVqbFXygFg+XFjGoeOp6fS6U
	UiY+Px4OsiT2o934CEKLVmGwDv5JIwOf296y/
X-Google-Smtp-Source: AGHT+IHkkrrkJO9vxFQ/mKvoqiciYenAoxqB4xsrJHXOmWLBpOlwSdkJNBje0Ts8w1UhVQVFhRl8oQ==
X-Received: by 2002:a05:622a:1a97:b0:4ab:57eb:24b3 with SMTP id d75a77b69052e-4b0aed2362emr8392041cf.37.1754596187178;
        Thu, 07 Aug 2025 12:49:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06ea8cec8sm53172531cf.25.2025.08.07.12.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:49:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250807-mptcp_fixes-v1-1-adfd79a88b5e@openai.com>
References: <20250807-mptcp_fixes-v1-1-adfd79a88b5e@openai.com>
Subject: Re: [PATCH mptcp-net] mptcp: drop skb if MPTCP skb extension
 allocation fails
Message-ID: <4da984d2-b20e-2549-3853-418aed07bd15@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Aug 2025 19:49:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Christoph,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16812517311

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/afb4495bb7ee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D989206


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
