Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4F3DDDC1
	for <mptcp@lists.linux.dev>; Tue, 24 Mar 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345637; cv=none; b=RFruXP32cvYHhjCdFT/zpMzkC7+LQhAIIH4iKRrjZPZ/cdO80e5KxbHIGqY/RFobwRk9ufjnBmapBWv30nJtl3srPrTxORghUGr1rsQDGl+R1DgyXneye+cbfWABuIq+bat3zYTEoFx/WkcztJfSBwfwrGNiW8H/oPMIRB2GyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345637; c=relaxed/simple;
	bh=z/pPI/ZySBuS2yj/P9rkv/58dvdQ3zBOatJ9t+k/WnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=YlSGsjyB5/aRXaeED9zPM6yD+fIUNeOZOuvekEgIaybUvD7sEfQo45qqMqZTnuAuGDq4t38kz1Ml+5yQZsHZVfiYKq1944BSrAcc1Ijm7TErqW0/PHacdLTMEmZwLkYFyiiRJC4wAiM+VRayxbqaJLu3Z6SBHzeGYz5yJn546JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olZBM+QT; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olZBM+QT"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c156c4a9efso109838eec.1
        for <mptcp@lists.linux.dev>; Tue, 24 Mar 2026 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774345634; x=1774950434; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6uWH8IYm487bvabK7D6EBEMeNuqlEyQXrvmGFp892s=;
        b=olZBM+QTlnQnF7668e+/z9PydG90ZMS/P2wsSLbSjtRc7Cf9COvzCeu5yDTItB60ZO
         Xw8/D2JjES2Qo9LuVVC1wr9qag5TDWoUue4zLid71/UqjDCmwhywtd1HeBEsGEUvF4oW
         II1e/2IsauV7rdJVAz84FZ1HNU7jLmM6tWoJNFs/mByRCDKEAttazoeLir7il+YXMqZ6
         9krgp85fLOPbQLyMA7QpvocR7XUeVXL7cRtzuQ5x9obiwzU5wJPZaPUk4S6beK12tS3H
         ZYvRfizjjRpRZwIyIsj3Q3NCwIiA5UK9kmKHEDJn9Zdma0R0WBzcuDfUn58t8j1ssMbv
         nRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345634; x=1774950434;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6uWH8IYm487bvabK7D6EBEMeNuqlEyQXrvmGFp892s=;
        b=Us7APqr7655NWkUUiA8lgtI1mt2gBTXKGHzUMI3qnmnTOIA20AZJdnobIDMJt+aKhN
         WOga5mJhq+z6NAGeNvKdfu6AIxJrKUw6SinUKRaYY4UYGwXbODy8irhuT2Nu+KAyJr5R
         4Jqw4TMbHeE5dbsRj6t7pLtLA6p6pQj5CtzSrBD0tTMik4rSkBga97wSu295gTqqAbr2
         u06jh53NUGt5ororfvYtLiT7yKC/9hDj6JuDD9RzVuvYqA20/uOjncX4RXSUkgPkOEOi
         K5WarZUzxdykGwQBAIC91iKAEF5dEgYiE1V56lzYGz1WCs57MSgPtdPBmTKhc1yI4gXd
         fbDw==
X-Gm-Message-State: AOJu0YxnRKj9dIooASQ0OewHjDgtOVHfBBaF4m/5Bo7FwnEAHcuMZUB9
	l+2RvK123Ga9AzTNPpuTv8rfk0y/k6fPVPR75f5djM1vsvuJXHfxOEQ=
X-Gm-Gg: ATEYQzxhRuBTFEEkKRQkvunGuXbKjUDuyUtq0kf9ixtqHjyMQfmaLcNITMx8F/ZioBx
	tFbsB8bPjEcsTyxFWdQs2/HNv0uUXgEHzpRRGpkWPKIUwXm9N0/ko3POtEtZKaet9ctfTYNZjLf
	wMqDtV7NKamx+Ipku5BfdYFMBKBDPKW6gD+VmXnRbXgorqu1IBULGOQqPrbe59MXXzOMQ/HSO/8
	by2yUEjLwUMggpV7WIoKI4TTE7HGhaK7Z9LhcjXIOMuk0nYL4QVIL/gnh6CqGyYxhXEInVx/IUe
	hFrapiAOxsCy/Bfn7ypGk9KbgH/5eoeK7ym5aX3VZ3/GQ1folHD/ntxH+x3uefptNYV/vCux/2F
	W8TDCLEGzhf5XV+j4UV0JnxWyGNCtUBUK3ZjT468ayGEVmMeDDuI8z/6LGbIjgHm/TUiCHR7Oed
	v6tqOPI5yshv5hLboLYn1d6mrahGn5WDTzZJM=
X-Received: by 2002:a05:7300:cb87:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2c10976028cmr6961882eec.26.1774345633656;
        Tue, 24 Mar 2026 02:47:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.119.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm14531680eec.22.2026.03.24.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:47:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260324085131.4187473-1-lixiasong1@huawei.com>
References: <20260324085131.4187473-1-lixiasong1@huawei.com>
Subject: Re: [PATCH net v2] mptcp: fix soft lockup in mptcp_recvmsg()
Message-ID: <51cd296e-d79e-4c53-df3c-a8ffa3d16869@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2026 09:47:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/234809=
63888

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/74f1911c8f43
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1071486


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
