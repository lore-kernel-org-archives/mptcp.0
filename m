Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F36346798
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681898; cv=none; b=qh68FBwcjx+Ra7n7YG23MwABMPpu7yejcbyM46x6AKi1vRbV+zMT9JQphGXVgW78jlwoEGT3OZp+BhsCmuw83rUlkP4Ig7JGyuAq6bWflGHoMA8HRJs9X9rFbD9EqyyTbnIPm8nJhXNITtlVjmbzbOyVfsMDQJqKxfdxO997Xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681898; c=relaxed/simple;
	bh=+gJopHk0R4DdHkhHVm7ZnULtwWykntkwCgoVu/5///4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QmSZTP3jFuaM11cvM1AECQSZ9cLnfABSl0uUtvC4+VQsUp++jHS2rYIASuS3mqhO71ABoBWj8JpAYfVYYTA6zCBF17fTY05sVe0vkx4MwP+B6O+F3gc9KM2YenIPsLQhG3YPNXPA/Tffok6i2DzTC/b1fG39vrmn0Ks+C5HNgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHEHrEqk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHEHrEqk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e7109321dso427879a91.3
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681896; x=1787286696; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2S69FiLRxj427VWDpegsLao0D5cyhMNx7+rQgHtgik=;
        b=ZHEHrEqkGgev/ppGOHszPCHTRSeveW7cyew7TjDMT7p4XZ1NxpFu7ypKPEhmx7+tIu
         Vti6VQsBUnjTsYD2pR439QECN89kVywx4EmtjDwG24MoBHg8nnSZoCW91b3TxBmwati7
         VHmwj3jpko64pySiJcQGV7vtUwepVjtBoOtHEcF3++W2XT2Z5MlZuENKPmlt4EE+AqSq
         2GjhSt98Hk/Ebl5GjVxI0a1zKjkj8Og1qGFT2ipSlWa17/ZdW7w/ypFC+p1tA4fIlc94
         sj/n5wtGOr5QqV29pob2+UNm6Kfg96tyjWjf314w7idqx+CIL683yw7izNW5tS6wCLOv
         2R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681896; x=1787286696;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2S69FiLRxj427VWDpegsLao0D5cyhMNx7+rQgHtgik=;
        b=Amyc5hBf8+txJl0tX/D1Ttrc8nBMZ2dIIuZk7erpoOHCKW/NQlsawetKrPOfWXNIPz
         t8UrxUh3JaEYfoDk2pxixRax88kSZ6qY9+q8Yp+1qKVBjOh095iJ/bWU3z5lI3K8OhTa
         TV/KDHK5JP3T32eY/BCGmKejpTDIIoXx9a5IFxd6Zsic5kufEejhtWbMTpjNYcwoyC8b
         82gU5sMOdf/oVhPEoX1vHfD3DZCjBxgMlbuuVhZwvNwEn82/vhnrpKBCHeFE5/Gt/kI1
         mlSk8Qa/14cSPCd/wmNTUhCRCBmNj3x3UVGcTviiWs8QemfHJaFoW3G0p7Dzhdl73W68
         1pMA==
X-Gm-Message-State: AOJu0YxEgAKDWbCQnLdMmaebSTOwla5bfu/aO+VygQbtfwzvfD2lUliO
	ehgIHTkbJqXYQl6WBNF5Nnz0z5a8pwxu2Ow8boBooAlTdlvSuu6Ad0HfXzfmBAI=
X-Gm-Gg: AR+sD11tad9QRbBZMLn3smDLzuKyqj+Ge6xGSu4l6zt75FCV2/t2oEHRKuJgJdXRsyk
	2wvAJpW+gfbHYzkbcxEfFi/KLVivXFOJEUud9wqfhnLOLjRYJTRyxOoBwWJadP1crFACzP3MA6u
	TK5oCJQvXYUSih/RXnGrbb5M2mTZlL/QOIlo3g7+V5mOUGSELwJJ/LWI1ewEZJ0i535S2MnmLWH
	y5zDwtQuNTf9ljGGShdT7gB/oW9x5Y7m/BJl0Dqmh8LLSPjfVfiHlk+R1FVdYIuKAxhvNMyWOg7
	2/d5zdxiyuKgRxwpKXkSJyu1HI6Id3im/0kJP1+FLOlMDyEnnm33oTOtAWqx7JpvzItgO2DiLzE
	vgtYNXpYEE53eUsdaHLei3DCUtSZcy0Wos/x2UeKUcOc0vO/s9ms6ovwZwfBUc4vro+oV03Pm2H
	JXqkF3j2FCyjal6HFAhNtOqaNZbnedwH/1cKt+JKNAVulI3qsw5DLmVPCWV+dQO4njq03hSzqUJ
	ZMS7IjXnpPf
X-Received: by 2002:a17:90b:510a:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3933ba87422mr3179181a91.16.1786681896178;
        Thu, 13 Aug 2026 21:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.117.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm5753641c88.12.2026.08.13.21.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260814032749.2222975-1-cui.tao@linux.dev>
References: <20260814032749.2222975-1-cui.tao@linux.dev>
Subject: Re: [RFC PATCH mptcp-next] mptcp: annotate data-races around
 sysctl reads
Message-ID: <ee6f5a76-02a8-b77b-75db-d21dcc1bec76@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 04:31:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/317678=
14900

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fa3baeab64f6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1145806


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
