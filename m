Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C733F6
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528414; cv=none; b=RHln+kipPFwq1LYQuzQWKuN0BteNdQ7rgWI2ZY76msZIHhzOsxIiwHep0wDK3XR7SwDlMy64IljQht4roLd5usPVv6g0Pm6WtT1vHpUqoH8p9Fcunccsp5TvR8+GOW8L6WirXUWH6L0wXWrej7FGKT51TnuaKxx5/G4R0lr3LyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528414; c=relaxed/simple;
	bh=E3xQQU2m2NVPVWguXFrjp1SRxCHVgYfkCJY9948NDK4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HCGtAqnyevQ17GY970t2JlW5u3iIgHjZKrhi3kY8FrrEVjbVJhkZbWHi9t4y907YuKwPfb5IoOyHgrmzacEvPoxfLBM6/83VAU+vkqjDhAjCPf8JBs+Htpm+wl2bUi4UfsOO9eqjPfxPDQ4kN4zUS6VDOVt6pwcUI8S76qAUbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8ixzaX5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ixzaX5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78a9793aa09so3344826b3a.0
        for <mptcp@lists.linux.dev>; Fri, 03 Oct 2025 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759528412; x=1760133212; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6ob47IBtd81ld+ZAjHWVt8UfMhOt6ZEyAAC8m3JHYU=;
        b=g8ixzaX5MNYP6rgzSuIW0IUn+nkzwsC1Rl96QxHAlE00nZ/ndmHDeHNlQok2tS58Hg
         TmeC7vMPuz59z0Hf60zFHKtzXoqsPmYHq9xHWrQPt0RswvZU7HJxBdGm2jZGDuKOIjjs
         pe1m46eFO3aW9Fh6Dmvw468RdBaIlbUTP44EDaHS9npC5TVf3L2OaJSkRNyyYORyPTje
         dTb+hhcMbXND5OMnBC45x69CIJeYj/m2WbTPGr8XPWUCN+Z0buxtOyLAufwtc682Pcnf
         /7ZZWwbYNp697YBxtBTfhAnJdvLu8b1PVPHCa4GAt56q5RULDTI6rYLg+SxBKbBfUzYp
         9+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528412; x=1760133212;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6ob47IBtd81ld+ZAjHWVt8UfMhOt6ZEyAAC8m3JHYU=;
        b=p2hO6q4bi957WWNfa4o5Im+7zy7pOszcb6NXcwy76e2DrK4C9SUJIhp6J0oLqb2Osl
         j8e+7Ub0QKZchmzvoWO7Zyclif1T3IleYtOTxyAA3nAGqZ7IT00oPNuBH8cOmc1cuC59
         joKCzL1Vc/0YfkiO6qMa/i28upCreLKoio6QH2Gs5nfWhjjSQLzMm57WtfiHc+7ErSco
         /wWnsVOJNHpqj9EtG5atWyVBLfkxEmfQzWOiynbMdyC62bNonRDGbg4wHIekBhoArURl
         GvSSwElnz8VOvJ0rBB54liSc8vFniP32VqoRaJR9yDNOXfD8QLgUPNYbSWmgw28jeF48
         aokw==
X-Gm-Message-State: AOJu0YyWQ9bgP/JQpf5q7a6r69/q5QDluABtn+L9QjF1iQkGJoX/xoSB
	ylOivdjPyhTGCeOWbUYy3IIh501PwaVhbz7Z0ktEIFYKz8M2vy+V9zU=
X-Gm-Gg: ASbGncu1ESiBzPFCn+DAMdqvXKNYmobeFQeqmudlnRmFDuAX8R8LX+oMNgnrogEIY0L
	hlTEwtqlRazqIAMMiCXAb7jmWyEQyipUtHZmxp++l3Wba+mGsxtyWRgUoQUTorX8RJ4W3y9/Si2
	1t9w99+mmqo10RHFPEUaKsQHBPbZf4KMVBiLoMFWw8yxIP/goUowJI5GEj5GEluYAc/9PvY+8ln
	GvuepZtOvP5/EzAWCQIdJXOQI2uBPsGBufzlEXXLc8E+ye+3FEDN9HWIuupKGJngt8df/F8hWOh
	tsi2LlvQJ5OqIw+nR5DR1UHFMLApvqRqrjMKu6ArWkGVY99m/LZ9H75Kouoag+A/ly7irm31sxj
	vLt70QzWRNVEhG6Fdix8LDL4DfwgzI5CUnctxxqkMPR85dYQDjRNcIkZnqA==
X-Google-Smtp-Source: AGHT+IFibhiWUWiSjRbe16aIa7WPznWGixrXnevGDlQ9kd0lDb+b7GyjBVdLb/hmWfK9bCI59W98ZA==
X-Received: by 2002:a05:6a21:99a1:b0:2fb:4ac6:6662 with SMTP id adf61e73a8af0-32b61e5453dmr6350340637.13.1759528412215;
        Fri, 03 Oct 2025 14:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.138.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dcb3sm5807439b3a.11.2025.10.03.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:53:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251003205736.1019673-1-kuba@kernel.org>
References: <20251003205736.1019673-1-kuba@kernel.org>
Subject: Re: [PATCH net repost] selftests: net: sort configs
Message-ID: <d24a0646-3772-e164-7593-c9c0f2004e0b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Oct 2025 21:53:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jakub,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/182338=
92753

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9e84793f8b48
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1008381


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
