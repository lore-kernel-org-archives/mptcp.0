Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AA3A7597
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301242; cv=none; b=U+WEYxeUOrAzNLftZJp/2JxEeecMcAKy4OiMXx+5vILsIFvJ3v2YJDw9MBV5hIn3BkpDnPWu77XVjBQ3LYz34TzZGWf3I06NNT6SETz3sdpIzqXYFo9WhTbPNSCkBfFU2uzlxedj4As2xxllW4a6/Q5jluZP4gn6nqvdI+eWpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301242; c=relaxed/simple;
	bh=uhME1zCVkpi9Vc0qdJY/IpcaXupCuSEI15bbY4kQmgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XZDbeM+wcPSVPUaqs+9Vx7SfULLP3T2IpHF5ryoDLoHR336n77OJN5vFHIWGfaOXjBgGMtIQbyhPuS4jyYXj+wk24YAeITKS11xvcsekTVkCCYsdSLilItj0guGRCoABii7MciKogq5npZDUhNo3xxF0mXEFyx0G24UbDwx5w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFK2VnOn; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFK2VnOn"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb63dbd229so615812a34.1
        for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787301240; x=1787906040; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GVAe+Bv7tneynUt78xwU8vjnM56w/tiVdA9x+yIjLsY=;
        b=tFK2VnOnC1m/yT8XFKn30O+0e6xzHDnMXUYpyhYDs69fC9WJGJYAMvRMjmOcLH0XUE
         v7m2USMUcgfi0mFBw+2m1iMLaa9WJc93FRbyml74BJ54PiFwWk/ZivzF9nxRoVxgxc4u
         2B77jdO2mJO0MA4zVA+MjtMgBrahi0sCthgHZKbUrwKOlt3OcnJyqwDMZ8Wun4MJ9BWH
         Dveu+mZhWrQAx6lJjEDZTa1RFI7YJQ+bFA/1IwmKTrg6FO1uJy01nilZ40+2pyyWWCHf
         FzAS6eBCOs5vMh0QoSRUjgLaBuNiNDynt+bTbce4PqxSl6tFde2l2TXgRVlKuKMC8iiM
         DEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301240; x=1787906040;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVAe+Bv7tneynUt78xwU8vjnM56w/tiVdA9x+yIjLsY=;
        b=B/eO0v6qONJyUeLM5zVxtLHiE4FbEcB1ovlpykt2rRKmCqhvUl1drgqAkL8AFnX9MZ
         yEEcs80SOiv9b/Zy8j/Rj0yqX5J4slb7k638HJg0QGkoeaw3RlIYxM/79XoCk7HHoM/G
         wOvgVjZHRVdfC6Yn9voRNKOMh6+VFVgQ9Rfag+70pc0DMx17gLgiuxrdwdtZLzwkgGZH
         MMeN1c22kkSNjGHZ23m/pxXTBl5mAyEa/qPkWpGfj7ombbDHajhVdQWMMtJ3QKvJieVm
         YfH79sEET1ndqRcgqDS4Rt5vigyGcbg9ZKve4O7/ZavvL3IcMRmeOvfSx5J5adU83hK9
         2X+w==
X-Gm-Message-State: AOJu0YzzwXojQ+mHFHlxQpv79fpWUN2bahddKUrz57PYzTkzXit7ZQc/
	zlAlX37Exkb/ZfrNXHyaJhSkt/Vsl4gADFj90PYQeBeJO4FNrBg6ufdMv67d
X-Gm-Gg: AR+sD10XetRfh1prAUOp3qkphxq1JanUf9VO/kF3hOC605qbNpU8wZmn2gzUg97oFl0
	cC67nABIc4FFYR610WH6sS/FiHqcOhd15R4wvKhYeo8ehaRKPgXjVM2NnW8E2orgS0nvkl7u70Q
	didBvnPJOTKI75TqoLHH7p+51zMBEPHNyW50vgpigEWGPKhFACdXDC8SL6pJOksZ/kizDGWQhm8
	lRyiQ9bbd2o8abW5L6pnHezHTFS81qw0mZ0XXwcK+W2lqrx2vkfY0+3Zvw3V9tjfQQIUcjgSmq9
	kVszXDh8ZktW65Q1uUkz2dlnO7Rk7eFAkmdlIXEesMBIr+qJ1Yp11aePo8gAfrFfxy+R00pqvtz
	nh1BiWcJEVN5g50Rf2yH0M8lr0gP1VDI+DeiUMGsB3byaKq4bfb3/K97KuIiDf5rs+0pvTmP/II
	79OJmyn7uw6gvern/kbAj6AYsdi3uJdiXO7VI8T/WgadnzMvj8lImuszRlObxfMxhCy22w5d+nb
	kwS
X-Received: by 2002:a05:6830:498a:b0:7e9:e19c:75f3 with SMTP id 46e09a7af769-7f46271366dmr4376873a34.2.1787301239609;
        Fri, 21 Aug 2026 01:33:59 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.208.148])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440023036sm7257692a34.16.2026.08.21.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:33:58 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787295147.git.tanggeliang@kylinos.cn>
References: <cover.1787295147.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <eb08e06b-7485-d93d-b864-37916dd03445@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:33:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/324593=
67353

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a26624708a87
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1149510


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
