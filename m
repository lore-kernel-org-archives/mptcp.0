Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200D79DD6
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542893; cv=none; b=D2b+wGQA8l0J8xS2AUtT6th/FBdw1WhOBHhaLash8kbeHb6kcH7Z1O0Dwz2xMMFqONvADvzoegUONOqLrBkB4SBQKjEndUnzm05W+w5p3ERgwd54xDo3pUpP2NN/kWDEb6pVlBeSXQxxOHsf18QDehFFmoN+mZg6nNvl2w43onQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542893; c=relaxed/simple;
	bh=+ihEvZwG+86nlZOC8ZJbUCzgjLqQnSxhkKhcIXJM0/k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=F+x1Ie8RDOUrlIjXycs2+6QuY5Pl4SD9e9FYuGfVldPkxf+wjXY/0k2xzmzZc2qIKWb3qCtQmOtuEvZLRWi1ZTqijV0qolx0rzFylKOJJkg4DGCExgvteod+n5mg5h61G50G6LfW0UlxpFUrFKXWtYLl3OOiGip6CQKgUUotEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbUCAr7h; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbUCAr7h"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e3235b0d1so5544811cf.2
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708542891; x=1709147691; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Xjk/Pq7XO3BH4yZz8om0iHbc6fEg7r0m7pxOMQ5R9c=;
        b=MbUCAr7ht5SFvk/fauaHhOcFjmcKJKXZNeULqWMpP+exmmSQoWyycjUKQcGWNGdH60
         vaDmUWAKN5JmSYntYCHAZluyqE0UYQ4tQBQhypgk6KHkPwsVVsJ4KCOz/T5I0+9P0OHH
         xa93s+tOioTe/kBTmDorX/RVdzqmco0NFutFflZU6J0cKAJo6Nd4d6ZBnBPz3Tq+TyKu
         GAPhuvd5Zs8u952uGI49TrfR8ky8c93Vda5EUG9MD9O+/l5y2ioUMgQANdklnncEdf0v
         HU/8obhojjU/wsIEHX6+yveHUoB+FJEhesPFacCIxYUoJaFX/arPsZ06Fo0u/RIiLS0M
         tfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542891; x=1709147691;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Xjk/Pq7XO3BH4yZz8om0iHbc6fEg7r0m7pxOMQ5R9c=;
        b=OI6h98Y01ZLl5rYBs2CWNDZQL5++Va9o5u60Y4eHR7RL0U7J8nuh31Rz823mVtqMMJ
         KuLiK8vBWDPt/Qlpon6gAnPwt3XGiNpcnPaHbg9LoLNSyTyV4jQ0govwn6JiiaPII3eL
         2OAlAitwtvcdzFaWyCBPfFSBXZ9j8vLZtXm0210+DcOXNB4NlcNIrjUJPmHWpjWGhHd2
         kU/u/H7CQ34UGw415HS4byCvzOdtWvkUi+2NMXqzor/fw0lHhhUJ+1o3rk/A4QzigDUJ
         F26MkPfokBvKp6F1++wmoZrd9XUStTtoKQuQ0AvNUDwFL3So3Za4Ax6Ty8nzb7Bt+ssj
         Uqfg==
X-Gm-Message-State: AOJu0YzMs2FDC50PiMBzgJB7QlqvvjEdpRRctdzyXwMegqHrLN2ZeiiV
	biuwLkHrlf6uScdmFPQOMez1TV5ywpOSb6w2zCjiNvtZksIoryg=
X-Google-Smtp-Source: AGHT+IEhpFHYz0ZSn7mabrZQnqMpr6SyKXXv+C7R0OuAp2b2o5xMRNF8/2gftE9gT8TL070xcXajLw==
X-Received: by 2002:a05:6214:d0a:b0:68f:4643:eff3 with SMTP id 10-20020a0562140d0a00b0068f4643eff3mr15519849qvh.1.1708542890699;
        Wed, 21 Feb 2024 11:14:50 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.242])
        by smtp.gmail.com with ESMTPSA id or23-20020a056214469700b0068f6f344d6asm3768557qvb.79.2024.02.21.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 11:14:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <00b53a9b00cf4f35361806208f1214c030fad974.1708539640.git.pabeni@redhat.com>
References:
 <00b53a9b00cf4f35361806208f1214c030fad974.1708539640.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: explicitly trigger the listener diag
 code-path: Tests Results
Message-ID: <b1075da5-3959-e9fb-c5a3-0d11c0d1f57b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 19:14:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7993934084

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/282733d05eba


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
