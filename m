Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297A128810
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204634; cv=none; b=iLbTQmnIscde6Usghwm1EuVPDqSDEy8L+rSeziNBfuaHjXZPRIqVBcoACGgrh6yIMw1Oviz9AJ4iSlVJC1rvvjlOTxZnawvONxXlormbu3TjkOf4YutlwDUA3EFOrZMpGsub9+3BESH/lkpNtpZIHtXPzQNlxBDOvvASy6M3qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204634; c=relaxed/simple;
	bh=sL7x5k54I29sCMm6BCPJSs4YdDJyCUc2HBcE3KcKQhM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=q5e8jTOozw/sBQ3/TuaC3ij9dF3JQwxQkYZqNjR2ubxKSBti32RXPrdf5RF5cKb2XyAwoXzIfUTmpFktlFjZQlFQj0DzsEQLuK6vJWNwkkWcgPFnFldF4Hbtb1ZK8NQkxcVsiaZaC4Ys06jXzvhl4yPfkez6I6II+IPa897z4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezoJVpId; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezoJVpId"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78406c22dc7so340490385a.0
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 23:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707204632; x=1707809432; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IFnTP+SDK+SsqwfXCqyZiMki/0aQZVA48+GbpY+fLc=;
        b=ezoJVpIdrHaRiysbZBivl3Edrd6azAjYLgBll2Ll2UEnW4MYNh5RRAMLVHQ3xcR/eW
         e74sRsK+bcoW34NFDryu5YvqB0FTlunGdttHCG2mK4xul3ptib3fDKoUChvHl6I0Wqf1
         WpP8zQZacExhTUQuAZi8ZnvXdnJrbT1rro6eSgs0TVvrHy/kJ6yqRmvGLm9o3iEIUUm3
         tICtkIlTfc0J8Qb2sC6i9juL36ARXGGacfZvoXNYtIItWmFmvfmS2El8RRMGezocpVGU
         1bqjwb22g1xYQ9IJpBHcp8JaTYxEnQJ8h47kUTxI9agg9Ju4WpTGeju1lDTSPMEuBFuH
         tfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204632; x=1707809432;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IFnTP+SDK+SsqwfXCqyZiMki/0aQZVA48+GbpY+fLc=;
        b=NRbmSoWAJvw/tK/BRgqRhCrKRRerNuWJISBe2C7F9JKR88GhxkEoDJICLBtCjWjn6K
         YXPL9hzp2JzYNIjGlWlU/wApslGUe/UKXGaODZ+DsctNdYVX/G7Xt+CcIrBs1sTRSELK
         d5dhVDy8vqZfZ5itKUjeLBes5Z5EQyMSLbJO5Acc1KybLpkbCFuXF7eAKCfIC/ghOR3p
         bjhxSMBTkHmdP9SFRgcuvJawqESJbmVWveylNwuuaKqUnfcLBDyy6FoCXxmLKZHTWXO8
         nkqkVVOLxVN/ohcbdZEAxwgjdMyqI5e4TTsX9DShtqn811i8MdFtuT0sOW/fmc1f2LPz
         1poQ==
X-Gm-Message-State: AOJu0YxRzyla1lh69aH8q5zHMok112liRK4hnBX+gp0YWELeMLOa+ijn
	bfmYRm0QF2EAVZ2jwpABYxjlAl5YgecsNn4Kyo6idtbt6Pw0M15zmXIz3Z8=
X-Google-Smtp-Source: AGHT+IHe7pcZN2iAXTBkcroFYDzv7W+VlUgIodlWmizMBFYoDA4MeySgx0xcmurGCbed0WM41NI7Sg==
X-Received: by 2002:a05:6214:2b0c:b0:68c:627f:ed53 with SMTP id jx12-20020a0562142b0c00b0068c627fed53mr2015241qvb.59.1707204632167;
        Mon, 05 Feb 2024 23:30:32 -0800 (PST)
Received: from [127.0.0.1] ([40.76.238.209])
        by smtp.gmail.com with ESMTPSA id pd4-20020a056214490400b0068c89d8eb53sm777870qvb.81.2024.02.05.23.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:30:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <683704e855c0b54d003d6d635d0850aab0b71525.1707198093.git.tanggeliang@kylinos.cn>
References:
 <683704e855c0b54d003d6d635d0850aab0b71525.1707198093.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <1df897c7-3617-89ad-d9f7-00ec964414e1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2024 07:30:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6515054728708096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6515054728708096/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5054167002120192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5054167002120192/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c83ded2d90fc


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
