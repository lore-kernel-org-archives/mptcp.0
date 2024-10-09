Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDD18CBF9
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474235; cv=none; b=at1sdsd2uuezQ5PR7FCOyOvYzuZb//t5GYVuSBKTfogyKV56NtjWxhAGPqLSuQ+6WXUIF0fSJmiijjyld2ufGxBfBcY5oGdQzIegLcZnDe4sBTrh+AFadVlX4APkudrUv8dgOdBBALOaJsLtTsq3H7Lid/e3X5ESka54nBVhy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474235; c=relaxed/simple;
	bh=QM4tcZQwGVB7HJw9GsSYVOblVvIMoDMrPjK8kdLXsMs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fgXQ1sdfddH0jbtw4wHiedaMQ9R3B/bp6t50CPADdQFQRquDaQsxb269hE7WSrfYaecP05KEAhnJwNm98LhsyyCfF7bn4pDx5yoLYUm5nZWZwNLpyI6Cs1rc3xpkhjBztmVW7bf3UnHNtvtN2tNxsH0CWC9HjrZAHH2SaTC3bFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7hoNMqk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7hoNMqk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45f091bf433so6955531cf.3
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474232; x=1729079032; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmzNU/5AsuYs26Su7r+QggmCwmPdt1jmh2/Nti9pBa8=;
        b=l7hoNMqko2u5lNdOgweqc042iNSMLQWcQAlPGU6ktMiIDG7qWC0AZE8L89s+GtJdTm
         dDSNe16kALQNc1Qpdi3jw7u0dEoHMKizqrIWbeF0hiQ8X9gFRVRW7nT0617OaH5q5l32
         OgpRWWpK9prqsO9I1txcsepbVOGTQ2etJD0jnXxUT7WUvWg6W54AA6VZDpR9feGG59w7
         vZdTLc16pR3ucigj6u1CMCYt+nXdcAg6sn8icHozRTdWIgBOv3Hz1bGdUcr/zCOePoDj
         tHUvTZYxI38Y8ba5HzBA6oI7VWqPhlL0A73H4XQmI71vSb4B1TukuZ+CFJ/ATFfmhWe5
         8ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474232; x=1729079032;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmzNU/5AsuYs26Su7r+QggmCwmPdt1jmh2/Nti9pBa8=;
        b=dMHQkASBkZp1YFUiRyDIgY6+nGSM86vc0klvtzQCAjt59QmV0iNNfDdC3+jZdEFIEm
         Kiw+HtE2W8Ocfw010JYiJ9M1tUeQuJrdL6sodkQXqhYEk3Kann5ErTcJQGkf4ADlVMFn
         fJ7XQlqRsiLt8CilQB/BSumLLyTbno+tNq1qXJtc8scqQ4M0gF+4v6PLEoHedXC48hhy
         WVs25ypROQZg/jZTDzkHDrvVUJ2OyaGJDZhcg0X/Xi/rk+RoZ6C3aHU2mNL/4ovRqCE+
         LH/m1Kw5FXBpCEto8GtrGac7hgRmMTgmFSf/DKvc4xWHO66Ekjq7sh6RfrYrmNczhh/R
         AA+A==
X-Gm-Message-State: AOJu0Yx5Ar4Lh8yl7Lvu85tZjrN4Zw5WyLPr03N9K4ZZ9Tj2wfLUmpev
	wk72xnPZ8CwtvrTztLPl36H61r3P01k02s958Di6E7W5c1py289loHRt
X-Google-Smtp-Source: AGHT+IHUrykn8cA/MyaN8GZHNY3RLMxgpuN5CTygmRqAPyXY78C9BHAC5hDUQZAH23Gfg6cjULx/QA==
X-Received: by 2002:a05:622a:1a8d:b0:456:7d6b:7605 with SMTP id d75a77b69052e-45fa9ca3470mr15473041cf.41.1728474232404;
        Wed, 09 Oct 2024 04:43:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.88.15.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4603b14f689sm2162691cf.43.2024.10.09.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:43:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/10] use bpf_iter in bpf schedulers
Message-ID: <12972d51-25ca-7b18-32d0-8048f5e8708c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2024 11:43:51 +0000
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
uns/11253414698

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a77e05f49292
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D897127


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
