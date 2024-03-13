Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CF10A11
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710303091; cv=none; b=YquJEF2q5UJYB+8+LuZa0iFLxgFqJrTzinsSkKOwwZ6MQCyOUPTrP+3zqW9QJ6+TxKAjK0AKvMTSQYEptsCsqE9TvpvlW+7pvVVyWlz04pivF6uCVwaCPBQJelNsiymFW9QXJfYVBXH4MGW0bj3MFATBBaUSKWU42BSz/2Ozo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710303091; c=relaxed/simple;
	bh=h/VRMsr9TH/blSXBdYXaTOFyYrZB6kDzSFEKhql6cw0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fujrOaMbYIXI4b5+cMb4IVUCbGh1MNB1c8aCUwaWC0JmT5J+2rnhmdRtzLkd8WFzRMYtIY0CXyVbp3WynNgSE0NH4/8gGm99pUTWlmV7yiI1IOUY1mhT1MCDGQwnfP+J1FtYAQQdnT90vbAtUYoZCJPMQ2MMjdrcAIyaP9S9pXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjK/hMbX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjK/hMbX"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4308c87f6faso2619601cf.3
        for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710303089; x=1710907889; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1ZZkAyRdUtVrLkfTsDu18hjJQslwNfCkVqzdX6hQl8=;
        b=gjK/hMbXeJKlOr9DJ9969wk7ph4Qnep+39ASnM+rzNhHbMqGhtfu9hMsRXt3RqZRHm
         hlxdslK7jrtswtr4GLWu0KPrPpN73m6Yj5aBdCldkNElu5sMW60uGv1tLhnf+EW4Q6XJ
         n9riOJFUSKnMQ0UlTzFT8q54mOvKK7Bu4Xi3fTr8ubSWFwFRo4gKqXbhQtO6ncncQAvr
         Bs1dL9H0LYGWkooIRvnzAwzQ/jn7flD2LsGYteDmJhtDYYrUL4P+wpedvlIPDvYjtgve
         4SFopXaJ2OwhBwC9tyFZPtGOadNk8nCN+poZgzlkM+zq0JRaBM/yOEfQAETRq7xlZw6R
         ysaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710303089; x=1710907889;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1ZZkAyRdUtVrLkfTsDu18hjJQslwNfCkVqzdX6hQl8=;
        b=G7cGmJcShNJkPMldMUEbEv8ho9TnM30Y6JASc5zyody26xtBlnn+mFE9y34WI/hX4p
         w/A7Oqd6N1yHSNVNfmnJMe/zf3H9fjm/rQcbU8RtBe7uEW7RLBz5Z/sGnUirnPwqK7j0
         Ap3lg/BnUW2QPMn6mwbu4H8p/yw07T1s0z7P0Vpj90WANFfTWpbIW/Yya0sKXgGQwbrC
         xzliJunY0IfN/beKT4OMGWE2bBgr8t71pepxv38neAqwpaVlqK1L13iONLz+BLxLMFio
         DJP42dtbD4L5bJR5l8n0ectoTStDwNifZa7xkQeTMeuJtWocZz6uNuMcDpZ5foEKTSlS
         tWkQ==
X-Gm-Message-State: AOJu0YzVncybjKOTpS/bMOfA2id0mJfYiWSQS8gzYPRDwaZllqhsNtib
	T5ChEqkMtellqulCWt3kx+RxkSfk93mItdtJwKadV9v9yC8H0H+/tERTuqA=
X-Google-Smtp-Source: AGHT+IGGdurAMmoK5L0eckiFlB1II7yjCV6E/Ka7+T96RARYCZ8Y+oyqlhcb9VcipUmmKrp04VX69g==
X-Received: by 2002:ac8:5d10:0:b0:42e:b8e8:dcd9 with SMTP id f16-20020ac85d10000000b0042eb8e8dcd9mr16074639qtx.15.1710303089035;
        Tue, 12 Mar 2024 21:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.39.68])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85152000000b0042f04e421d2sm4315938qtn.24.2024.03.12.21.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 21:11:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710299501.git.tanggeliang@kylinos.cn>
References: <cover.1710299501.git.tanggeliang@kylinos.cn>
Subject: Re: [mptcp-next,0/2] two tc related patches
Message-ID: <61a29a81-6693-2314-258c-77ec0805d2dc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 04:11:27 +0000
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
uns/8259068044

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cd3741dc2965
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D834831


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
