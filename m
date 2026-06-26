Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282E36EA8F
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518318; cv=none; b=E4hZGimJLRAw0bkJd5sWXdNab7lz0O8KQsD25bPnpvIr7tSawoUMfwwHdHkjBQ1W1xiNnX9I3Bci7kFS4UP9nZjTJ6rmXLAch0fQlLqba019cpEt998+A27LJksEPb4QGx2xwbMzM8mnlx/3OjrhsLgywAQO3lzckyoIsOvv2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518318; c=relaxed/simple;
	bh=kK4D51zCko3Ckotyd5pYP6pGaD4RUJ9EK3ZakU1oM6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Tj98z2u04n/mIE+Zwbx8/o/OwANq9QjRIP21VOFxfymBvzh38p0r3/qGnCYxZ1eFGpod/ZIdbRHGeeQ3N3kKXjVRHUAZPdsn5Tr1DBHWcmYHPLjr3dexrjK65yfjM6DsVmAoDSHZCtRLDLW70NU8A0na6Aa62g8mj1R2+ODYh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6RXdUvV; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6RXdUvV"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2545792eec.0
        for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782518316; x=1783123116; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOoO/XI0kr0/dgUCG9fAy/HQOGmyo479kSrH9oveZlw=;
        b=k6RXdUvVp6rZgxjO6sTJ3yCmVJbgiSmnea//lRGfQb3Ewv/k9Dbvxf5+LHfOQJ571B
         p0OMrW7+tKmIdsuH48oLsnMdJQCGzuJIFMzYmazcx5zWKQrD9c/K5XbsiaPqiIrLK0Vh
         1YPoe1m9k7q6kEvdke44+EH1dTPJt0MS6cWlXZcwpjixmnSGosMl9ia4fDuMy0fgDxD5
         nNI0H8kInkzsZ4pCaidl0y0y/yihCoe/w8iN2khiAGqVg5EyaF4LnielxsOeq12fYfB3
         SxaOanZEQM7J5kXuNhgOgNjoIatAvlxua84nFVduE7vcjCXfhBEipFJzadVTk4iS97C0
         4bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782518316; x=1783123116;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOoO/XI0kr0/dgUCG9fAy/HQOGmyo479kSrH9oveZlw=;
        b=rRpvFWkyqJb4Bu1iS6mNF8I2Z82EtE1slQOQZs3vg1xLgd4mxa/2XJlI46jjFQl+Ww
         b8BKuIVUDuJyFaDgOBUrZULVGeDUF44kZZrfp5pc7BiipmH7wFcrcO9TSrEYySF0NkFY
         ONjfDHbMoCSnJOBp3T0zzerEhCxORRHN+SS/gF9TNm0Ctw2BpvPBjNkf6NCaLazMyH6P
         IyrsM567yBEzgjMbxiIBQrr94TxKretQhpCMpFmKkBb0Rp1T25tn5QP1NLbyItGrlSIz
         wdIcNXqM7GkPW6PtBOdWitd3xdZ+uPw05VAjElRlSrGdeIXZGLwllk13NNifyoW0SScC
         tzIw==
X-Gm-Message-State: AOJu0Yx+y27MbKrZIFJ7vpRMYb8PkdYU/599jrw77BGiQcSf12nc+ySF
	OMMxAf8h0tA6z9Up0O4nAp6h/jPXInJ3ljD6NB5d4YkroZDCqIg/nD2268Z1
X-Gm-Gg: AfdE7cmyq6zypOSp/yxEQ8Kb9TxlpzO79ytTqTh0m6XisQ9OVjJV8LnceToQbNvYG+a
	orb5EGRR5NlgecdrQNJg8OrBSWACVNP92PQ8ykOL7VOhPBB+pbhtIm3g0P9O6L+cUjLhzkQwT86
	L0/BWHdiEsM5jDjueXwuzCbiEglKizM+AkcxAybVGkriMJYx8YRqANBlHQjg5WlteUUwS1KapnD
	D+F223sAFng3KphCgts31Kvda4qyVpldzE5eINTtA83cCqV+Q1mopmT/x3Z4kgO2sswKQ+91tc7
	9ItM5g3pEjINxRx6+a6wFFMPr02NPWIGrRdwN/O1+bexgiKAAKztJOQ3kLILza1E1m+ZELP4dbK
	sgh/aFXuOUUQKToV0RcljGw8q3JvW+MNiDFZYQzxuo7cD5H+dh24YUQzFK0EiV2WsCM/selSJA8
	9SfSa+aP2ndMy0Casjn1IBeYU=
X-Received: by 2002:a05:7301:a83:b0:30c:b4c0:e785 with SMTP id 5a478bee46e88-30cb4c0fae2mr540235eec.24.1782518315798;
        Fri, 26 Jun 2026 16:58:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.6.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c591sm29497831eec.7.2026.06.26.16.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 16:58:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782513313.git.tanggeliang@kylinos.cn>
References: <cover.1782513313.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/3] only remove entry from
 local_addr_list when sending a REMOVE_ADDR
Message-ID: <da31b43f-99e1-ba52-8278-fa62e4091470@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 23:58:34 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/282704=
21412

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0e0044b5cd3c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1117313


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
