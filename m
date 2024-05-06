Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB5DDC7
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025310; cv=none; b=dqqWu/iZufHNmQ7zrfHsCKQX4vNDk8OB2WfojlNbSdsDwhWO2EIZDZq3osB+eaD2otXHs94Mhp8dHXGj6RdfrqybdcMS6BMdYrEA3qMBOA4YkCWQju39n+DWFgvPLenvF950CtawR2t9ySFB5boYQZm8qHmcE1mKJgJxlhPcr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025310; c=relaxed/simple;
	bh=hB2V8kLnupnVdr+FIXnXePZl8GrOI3bWM1pLjPSHL3U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cmvYOdffMGIRAaL+Vx3fOxkC2DNHQKMytQkKm+IzWNtalbS4TmEXappbj8H0tz+sq90sOyDGlmFpemLTumsmWOzpUfXoVzAoZuZb18WMWQusWF7uRCMnv1hNpxrTgJ3WNAZbF2+cn5PYYXUPt5oLBUykozLYH+UNjrGeQnqLyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db8PNsgN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db8PNsgN"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f043eaee9so144047685a.3
        for <mptcp@lists.linux.dev>; Mon, 06 May 2024 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715025308; x=1715630108; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmj1USb2J2YoExYOiiqzZfgjVXy3OpaIOeNBPD5BS0U=;
        b=Db8PNsgNT2/iF29cKhRVnTX4NdArXEWpjTivgBUWl0qB3+R8nERY8uqgLYXCmdMSnJ
         cFmH3Pkp4Muzym4oZZvN/qkG95d21LX3eAOQQraKyHjxCoxBpyrtndOgFM2VFmqnfm1a
         4haOo/Id59K7fnNA4V+44D6z48UVseR9N+SlAKtboqk0+U0x1XCs9YC+/wDJbyDvvY9t
         wzZG15zSQq7fIdnntKYkAZ+29pHJNm49vLQT+b9TzC4jEqOSbJ6n1ftkG0zwU9AQ5Rja
         pQ1jdDWPlKURbEmj77bvAkhQ4DLYFAHXWlmouqc6NsEC12mYsWkERH/o/8FyyO24mPSE
         Euwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025308; x=1715630108;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmj1USb2J2YoExYOiiqzZfgjVXy3OpaIOeNBPD5BS0U=;
        b=qFeJj79nuNklRvy1CCanSoDr+reseFx1soPFvH5c7wLO1QUVDOjO6yHeO6j5EHTmZZ
         I0TZZIfiVTPZj6ydBUf2dXcPjnRvaphbJYHTMVG9THYWgQ0yslJqLKfO0XSYL58ghjW4
         IjC6+2in1iR6gZqCR3bj1qJC+1xf2yfNVXtOL9uuY27BFzffH8dYmCtZ73TcACQJIpkg
         t885g6dN6LUp9kH6Ekq1Bjn0rJrHvPAJQ19/Y7sHBaeE9vUfTxiAOzB6T5W+7IUFPE6k
         YM8fAufEcNkj6rM+sTSUp37IrOz/xel2RvmYlxrFgAkoLuj3lZhd05cf8y5qggR8qIWQ
         eEhg==
X-Gm-Message-State: AOJu0YxiMsIiPkojBcca1z+0ASLpECD75w+fG77DHTIgEddh/sIY7DnO
	a7A9pfQxhnc2sz9EKu5QL2q6tWmP8IWckXx+o0lWUAkadHeFUko=
X-Google-Smtp-Source: AGHT+IHlzKjnG0KYZoGgsLnK88XbhN1pE2OMNeocAUTPI3gf9uyZXOM1jlf4c0rG6yNmBGm74K44hQ==
X-Received: by 2002:a05:620a:27d5:b0:792:9487:c474 with SMTP id i21-20020a05620a27d500b007929487c474mr6038527qkp.21.1715025308181;
        Mon, 06 May 2024 12:55:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.55.76])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e718000000b0078d5e60b52esm4161951qka.114.2024.05.06.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:55:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240506190204.28497-1-jhubbard@nvidia.com>
References: <20240506190204.28497-1-jhubbard@nvidia.com>
Subject: Re: [PATCH v2] selftests/net: fix uninitialized variables
Message-ID: <308ff142-92fe-10cd-56a8-4b2049967e33@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2024 19:55:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi John,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8974532880

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/21cccbac5dd3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D850921


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
