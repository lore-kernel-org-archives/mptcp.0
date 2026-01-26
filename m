Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD2D541B
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459698; cv=none; b=EEr0fljU7NwxxAZGohuAhADefO9lOy2blzCm/gE6QptVrGaIORGSWgyL61e+D4wtE/pR4x3RFBZOSmKcmsLHm/Fg937YQbxZIsVritGUeGDCETVAL9xyMgCsTkX9LgwxjqqzNvk3hEOY1uDIfAGXpLzJcyNOaz1YLE7N4ER8lIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459698; c=relaxed/simple;
	bh=OAKURAzmK9TqfL4d7NctQrgQ0xaN7hAsRRIRszhanNc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Df6YA4VgLwdQhlQUlzbseWc3Z64mdG5pLLd0++/Fd1T8EwL3ZyhyhD5g9Y3gDecsra6oSrntkIrQUnCjSHqiJw53lH+uyCvOkNp64Jz5QaKgGw43gY4mbmx/m+f5qixeW/Hpn/KbJ59PJjjtdTKDV3XnO/ZkWflE5TyvsZ7b5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKB4aOfw; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKB4aOfw"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894770e34afso84266616d6.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769459696; x=1770064496; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3iB2m3Kc5nRKWsxX22Nhp0on2OgFTsOqzxlbLyxZao=;
        b=gKB4aOfwyk0Zy9WSQH+9Atqbic5af+I/uAyavnWyryODZL5PgBjRTPrbUpJre3Q67r
         1+oaexfz/EB//cB/D4W9RdkxE0uX+FBg5UvETD7z0igx4tdWbUEHbqCovgQtC7UWAf4K
         gXUopKqNGvLgFBjuMm7ymyN2j2Nkz4RcT2vTvmTkm+EV9fnT/3I5QdKEmuDTcrR6BP4b
         znLohi5S8otUcth972mE7aN59CSXNOm3aCFHRL/sA8k1MB2xSnY+vjcXzjngsJ2kfFem
         WDCptfQXOPiEWf46/LnyfDxrafN3sWkc6TVgqpsQ59Bcyo7tKbGgMWS6H72IamFNHWgc
         TjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769459696; x=1770064496;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3iB2m3Kc5nRKWsxX22Nhp0on2OgFTsOqzxlbLyxZao=;
        b=daCzdUqW9kenfKFez9GI8GY/K6TMBScgAXQFs3e9O62SaBnbQKAu8NgIo2Oe0hx97Z
         GlzP+5rFfzinJXDDZJWIvPyFtCsyoVo4TV+4KX4gjLa8OKJ3Uhmpvfn3duPZ+9DlSWbB
         MSlOLYH7nDXm+2uy3ex9EFFPs+lfny5l3Ulp2bbPa5TNfHObyRGWkB+deliEpLLVDuHq
         hhZpSSd/6LInlnmQJi2WhH+tne4XJ3PH5g0k+ND+H8ltPWcGQgQDF2qOOiimVJph3FJL
         5LUqGqRo12vi2luGnS8TE8E6HoqFwcXtZuqomIgrI+ycOlMGToI1Hvrf9f3X6SVm9d0T
         6QxQ==
X-Gm-Message-State: AOJu0Yw68xfoGOFPhkJjBglwpc3+K+MnB5MoUcdvzRV9ftxvRksOmF7e
	pP2gb93vUCE2QPuOAWz45Nmt2H8iW3iaUvZ13M6ot7B8ZYpaI5+gYM8=
X-Gm-Gg: AZuq6aI+EwYsnfk/I2A18lAI1vIdYzrYNQSFl++baGMDamo+vgRfs7KkmNLVjoKXhTZ
	i6xF2MN53QbCPuYnvzYf0y7Q+kfS2oL+dlqLZYJIQ1BBMXZ4Tp2PDZfx2TKUovHl4ndCorTmBQg
	IiB5xUlcmvzFw2OiNBGOV441rOUZc2FyqmhOOvCyQ0yg/3jNg9qQ1116qzqbMtOG5tU35xtINBU
	jasOAu0AXd1VLoQZWcpeOzLf9V6x2fv0X815cytKwGxnAkZ0wKuHXlr48gA4Z2baK35Hvh8EqSp
	JHXgxllSachIvxRxjKw6mpfX126EmmXBxgxPqnkKaTW19PlsqDQybkojmgDfhcjldyZet6WdAXz
	u8kgdpsk13qwl1PWYa/+37Do8yUUCh4c8Xd+r/HAtF9NHP2JnA+D9OuH0mYMgAYRP6ccH3y+dMC
	pBehyYEDtcKaxXYiotu5BfamE=
X-Received: by 2002:a05:622a:312:b0:502:99a5:5f0f with SMTP id d75a77b69052e-50314c512aamr62878161cf.30.1769459696279;
        Mon, 26 Jan 2026 12:34:56 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ec4f7fsm109961941cf.8.2026.01.26.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:34:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/11] mptcp: avoid dup events + error +
 misc.
Message-ID: <b261c049-dcb8-d0d9-4e75-371b43bb0816@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jan 2026 20:34:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/213716=
21189

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/69110da63c84
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1047262


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
