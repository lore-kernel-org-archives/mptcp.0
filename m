Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681983ACF1D
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461639; cv=none; b=LUE9mTKk9ixEO9WSmvdKMP+r0hd4N4ORKeiYuxrpvRjGWCU9a8zdpTGB+XGZq2NwTnaRL1bdRfveigQMURR2/aTP/EIe9a1CJecA7Z3XKGyefJehZ4Ujw598I9zdIxVpt8AjdP2NVd4u96619UL8vPZZrZ1ObTmvj1RO0Pmozhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461639; c=relaxed/simple;
	bh=G1CktnGPnnRZe24nL1Np6QIWm+3E3j3zb756uvkIxfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GN8b5OEUgfmFMND8dQcHo0Ijdn9UOJ3swgpplwx/OLUKPB0rbJS8215v2I4Ch5e4u/BZtwBm15pNItPXCnasK0yLMYBlHBMbdoaq/Wicn/l+akAXgbI+bD5qeH+iU7QFgBR9iZgnjI2Niec2HiJv/LsoHy0yFCyjyjMF1p03Vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+s3YnOe; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+s3YnOe"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139b914bab6so1061667c88.1
        for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782461637; x=1783066437; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5bcpQkka4m5h8nuXp/WAXX5SvrHxH6IlIE5dLtHMlI=;
        b=S+s3YnOeO3FUG+KFdYnDobgYRBbdPG67/sUysgtLZZFSsDXe4sZIEGuFbZ2JIBCzqz
         HQN8ifanvyv9Kixf9yNW1u3J8tYIR94HWGpLHaP+z3mpxr2INQENsX+JQ/fNF8uZD960
         sTxDGZx4I7fhCCEOyu3IAn1IU0Dk+fPnWVCSciUIw/fPU77WjBybvibTg9O3drZVBKos
         r56hz0EmQOl/uvtQ2SxCh0u+spuLnmz02w/B+j5MLOwu2Llwn/NOBnb80IfbvStghYVz
         4BuRyu12tsMH6CGr/iT0B8z9bUEseI/vW8v6xteKXrjwOHctjxtYGnSLFVgPauCfUMME
         Nk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782461637; x=1783066437;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5bcpQkka4m5h8nuXp/WAXX5SvrHxH6IlIE5dLtHMlI=;
        b=oZQFTAw8wStDKH2jSsNqe+6mU0EYUzrDLjsqHCJlMcYzXIAq6IRZ/k/qDT+Ci6F/8n
         pXkBXKD7rZzX1g9JZSc57X5/4OT2ULU8VD2MCC0og3nZNEvR4wL85LUCE2kM1H8E65ED
         592SfJ6HP1s7UqlYR+Jsj2pIrttZ2wmoD7NiVbfIj6L6Y3af3A+7nC+HqobllzTXLC0+
         RZt8/1lC+I1yt2GMXKYxEFn28q3d8pyLmZcTEsP+3FtvM1m/YsmOSWHHAIXqYi2yy5qT
         ndt4wwZZzSNN5Rg67fd2HOhje3b32FB1HLnsUKIlPl9xBxNusxozxpgJjJIhZ3zt8oW1
         kaqA==
X-Gm-Message-State: AOJu0YxBZAAhqvJzba/4MceQaMiWnKeY7bBUH+MxN8wI4bunrTBx7OHK
	1UPnnlHN/tSNIO8svUob0dHFnPyar7pWKCYa1HIC0043TFvJ7VJJYeaLpGQlnFA=
X-Gm-Gg: AfdE7cn8aCXPl2/KXLacmhyOBOdUOQ+pDFxRxhAC30sl4V6AoLnuZ2i0E9LZOkjDaoO
	66VJwyI37CTla0nnoyVMQWQB0j4v0fiORAxkebQCNrfKHbcdpK7jY/FrhFsg9pfPScGzYwxCmnm
	9mV2CXEfFS3CBch4nLgJDTYfvfNlaF9t46IdEDYJpL2u+vPi12FBt/wGwScfwjiyDFdwONbLa4o
	56JudIdiHwWpwBW0+841IsWR99qC87qiW1Zy5uDRZ+RUa+SAFxzbSoCUizDl5vyBhvAwAPSzEka
	4vGhBAxb1FRTsVl7jepC25iqaZBZZAtKO4MXnk3OFmbOri+D3cYyixBzL8CBFHp1wls3EOCDdft
	n/D9dh0sLcOfpjPaVzUKcztFsSH2sLQredRiNIMffaD25SbCsq5GlXEHDy1SdfMIJ8Od8g/uyve
	i0MX8RmCjP7/zMiMvmWb1tD4X6Aqv0
X-Received: by 2002:a05:7022:611:b0:137:f001:fce2 with SMTP id a92af1059eb24-139dbbc564bmr5544668c88.33.1782461637272;
        Fri, 26 Jun 2026 01:13:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6acf9sm15558574c88.6.2026.06.26.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:13:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <24cb3786d7ce0e7bb1397ef14c98c78fd4a9ecb1.1782457344.git.tanggeliang@kylinos.cn>
References:
 <24cb3786d7ce0e7bb1397ef14c98c78fd4a9ecb1.1782457344.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: userspace_pm: fix
 undefined variable port
Message-ID: <3963cbe3-a410-e35c-98c1-95135af7006f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:13:56 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/282239=
07216

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c63b9d67c778
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1116896


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
