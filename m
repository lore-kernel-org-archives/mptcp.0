Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF53418372
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104097; cv=none; b=MJQYeWnknyQfndziwl4bh6NSw/zuDA3P5ub2+xM4ppKHC+e0b+rfBsffscM4PuzHi3Kt/2HBkOFUdiY6S1LtMaa2CFk9cr8FaYg3T+KgCROx8PXau1YLQWQtKNKe3lY2nPKso+2acLTLEbLGAM9w9TUAxHZv4fwj55YdcledvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104097; c=relaxed/simple;
	bh=YaZr+6gluJki44HtVAv9vu5leJrZCsLpt7zvqV6nSrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OppT0JY197bGTkfG2lL4XR3SQ7csJ6BdBEDvSMndtM2XfNC/cdR7wRLp90IROGF72tCfLf21z2PgniGY1ZsaL0ekeMXzpAPaV1PCq0GbfR46KvY2l2scI/xF8BVkSISe9Tk5UnqXaqAnUCJDYFEzkvfntwLlmZurHlxfn+k17EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SamxtMYr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SamxtMYr"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f72317a6so190036585a.3
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104088; x=1786708888; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/4Fn9+FaY+Y4HSl5/K+bHj6b1jCgAXOGljuvuGd/UsE=;
        b=SamxtMYrOvjBAXVXLSTPtfn47AgZGTckmx4h1k+ui7Zhv+gT/gsc5WRVa9RlrW+nI7
         GEasFlEJB/JZmlYubSweMk49f9cAZDO9KEsoJdy76Z4sBLJLIUlofztCva0tQjtL3nPF
         U/itUe1XItkI0Zc6hYDZ/qtwCxGdSUNZYd/A9Fw4AaFsjEagcVnWbVfdwYrboNpxFn5G
         xFnzYiaCk6Amck5PwnKX7g3Z5sZn6PGRdXt7vW5lethczxQPx84geTAvNfMiOmYy7J8N
         F8WRmJiuLUWH6eV3T2dF4qmxQ5IxqeV7XjhhhnCTAi5FG70aY2g83tkqS/pdr9R73ZoR
         uEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104088; x=1786708888;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4Fn9+FaY+Y4HSl5/K+bHj6b1jCgAXOGljuvuGd/UsE=;
        b=pZyn4O6MWWhYfkgwfB0HOsFNeKPFL8lDF3ygV4oRScbV+yg07uUpBTUVS29b7642Vc
         hQ34qrpHoBgfZ4NvL6GkVr3MXNNuvQ5x1aRJafiXEwAUX3q4p0TGHbbpeL+RUphS9xOM
         UydQ/gt3AuOdr7wkqYQku2n5MybTKZfszz7rPcJCPjENfwYcL6kBoRy4PRLT6oLeDZG1
         HEV/u50DCnSMJDNkYU8x6cuj1mYv1AaOwYMF6TtnhVxJ+1ZnRVNMcltFsDhuTHFi4eL3
         GZV5Crd15dp+EHc2gLey8O2zVNAW5LoxZrZZ/smrwPOig1DSxdcYDxdKF/mJTVQtQA8f
         V7FA==
X-Gm-Message-State: AOJu0YxBxTt5uBwlKrdy/a9BKnwTZfHB/d7zFaqiB3NFxn/BRS2jb4eL
	ac0ixC2HUq2sCc/hPktjKPY9RoqeAkr94EqH62tdfmYQEMZjeWUG3FcdS0G1
X-Gm-Gg: AR+sD10GnVaWVsQtpq2vEgGirbkAteJ09fGvlA5pAwdWY8JmJB0fuReAbUVfV4rbJ49
	6z6NIe5FW4bEyU+Tn493fCT/LcgBsWyyS1Zuzy6sHnNNSYD0OK5a58JeAhhG1H6mqQraGbvvbiG
	VRS08fx3yJyV/HhXf35SeE20FKv6zCpcnfTAUnGJRyhVquA6ZFeS5NO49cb3rppE7SFk+Wug+9y
	2vY9uMF21kyiH2P836EFu42+aq+oddtmXq++nOaO/FH0z9F31AFWOZU7MNtgeYQaGRNUYS3PKKv
	pan2LodauLs3uxr+NjCTSZ/jF9laD/aBMkt3pAGuFcJG7OyU1gIb6fBAnrLtgj2LWdTy+GGFdwd
	OL7F2C7NLI4rBj1vsBbrbw15rrVQZ7vIhOJwV5Asb+xrGpVNXdRPnRjrvk5wU746+RCfJMXycM4
	TAl012xoQCpBeYekrW4UEfxgGYD23nksSz93Vy3wsyNCyb+SobgVPhkMRe2dg94TjrubjdjK3V
X-Received: by 2002:ac8:6546:0:b0:51c:e14:87ae with SMTP id d75a77b69052e-52ce614ec09mr270568961cf.34.1786104088017;
        Fri, 07 Aug 2026 05:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.151.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1659b9f0sm10364451cf.14.2026.08.07.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:01:27 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org>
References:
 <20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org>
Subject: Re: [PATCH next mptcp-next] mptcp: pm: userspace: make
 remove_addr_entry static
Message-ID: <cf89a819-ea0a-8228-b0c4-0721d328de92@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:01:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/311734=
77284

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5a8ab818b4b0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142138


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
