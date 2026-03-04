Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21946336884
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626658; cv=none; b=lt7dhDvCxXb3LiRBFN+sHPevqKSta1qT/eyHq3bZlhPZd67J5tL3nsOn7xmkpoQfWnoTLWdVxG6gKL8kWMHKNFBwFaUdf2tMirbdH32yGd++xbfb6k+l6U0xp/2V3ACD+QUKpRNNOQDuMJaNDBNFw39bMdvfKL0+uCKyEXYnjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626658; c=relaxed/simple;
	bh=pytZGxqSJsCiJ/qV1IC9fAToKf7baHIByM3ny6xX3sc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=a3iDuL/aUZpCNghlL9usxsvzkoQKFsxy0+wKGbXuNAar14Nvp+/1K99je/I3JuYpow/jpxkgUnlCeDCwaByijjvgkYBPmac1mveWtZkFJWe8cqnyp4uO1meixQ7yYnX7Pv6LNVtsT+3zjp95e2v+9VmXnpVqGXReVMEIPjq3ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zww58jUo; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zww58jUo"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6301225eec.1
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 04:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772626656; x=1773231456; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQW9bC66LKAYcJNz6lEVLG9/LA5XZZSGTSMhI19ve+o=;
        b=Zww58jUoUuYH7rDR5Mwsq1fA+EDtjZevk4+oGB7WS1TKdsZFNu3HklPVUJ+OGgVwCh
         6oXsNHdlUWrIyaZLu3ieJZ0TyxA355vQ8w8WfTDllF44e/bi0M5UC3Tqgisc73424HA0
         dNZZ+B/dwXuMkunQupay0vtVS9UGBvGs5gFn/ZhrTeXRQyTSE/lSKT2HJocxLbU1K2dl
         37+DEgaYaMvgGRIkHsDOP3Un2DpMfnF49nkI8WJP6aT6w18AZ09FoCSvHzrLHLDqGBp/
         R8LtQiEjbZf5w02jjbAiGi/Q/UqeX2+pXJSybV/TccHC/qMEWaXnElasZVMB7L+bT9PM
         gh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626656; x=1773231456;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQW9bC66LKAYcJNz6lEVLG9/LA5XZZSGTSMhI19ve+o=;
        b=qf5kr99jf3aOyMID3htfVl4xBOtxkElJjGe7BsxInFtMLI6IWVZ+eXQ7B9tb74d+IP
         364KH0h/KyC023w/dP6RIltmw7lITj3Ua+lxpq5VVoisiLSGVQ/DobM2RjoM1pJXGnwk
         X6j0VDa3X+D70uQSO/KxQtwAbMWHYQVNpvyw5wNQj73gZ7OKAS7IGqf1DsFcOxyCjVrb
         EWy6N0bddGkK+ke5EriHLM+eG+G9b0upaJ1+s7LsWFpzGzod57cIEpbImuv4fIw8LIoP
         /8i5ZB3zmukK4o15m/MLQi7zVOMgLvR73Dq2IKML47ln9RGduR7R3mrVLdRt+saC5RRH
         SC9w==
X-Gm-Message-State: AOJu0YzDu5aLllXYl6tRrWiw3Cc7n2KKaCxt6LzUo9Q9m7+Sv6TIV5EH
	nyduIt8LLNUzr9gH6K5AuyS0LmsLlOGHoochxlz6cP2hfevlS57RbBU=
X-Gm-Gg: ATEYQzwfRvwLaKaCedZ3ZuMHgTvScvztW5SwVmGUCOYzxUtc5f8wXnv5D6xOBFmCDCg
	9vA6xZeyqMkH0XyxxJNB/dqb84Uqxqt6Oxi9upFb2RwkLd4+nvB70JQ8UA5TI2rDL/6SnqM/IfD
	UqmBadCdzzw7qptL5N7iAmyYox6NKutxJFFVHbJ5SpTj4hEQ588dfOMvi8BQNQLQlMQ9pqOtE/H
	FtCPhgiRw6p738EMZdRVuBKL35yDy0BHwSREcx+JTDTauIRdxocq+y5lWnS8/RHglhBZWVtkTQG
	E7+wlWoWXz4UV/OV843AjEMZ8SQgqncM0eORZjkh+rHNAAjp872PNlzC8VhGsW3QjqVuWDA9tJu
	cJHQzPb8TjViPgKiCzJ7LJGK66Zs6jc2yIFpozYIB76a+LhhEjLPycpKPjFqhXtf8tbbQQ4xDeF
	8IPr7DY5SLncmJ7NWjFhYtyVphYoJXNUbM5Q==
X-Received: by 2002:a05:7301:1009:b0:2a4:3593:c7d3 with SMTP id 5a478bee46e88-2be310ace7fmr571872eec.19.1772626656135;
        Wed, 04 Mar 2026 04:17:36 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm8045305eec.15.2026.03.04.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:17:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260304111517.2088694-1-kmta1236@gmail.com>
References: <20260304111517.2088694-1-kmta1236@gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in
 __tcp_transmit_skb()
Message-ID: <8c74a34b-2e72-cf7c-f97d-6af883c3d9cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Mar 2026 12:17:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Keita,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/226674=
29692

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9d4f29f31cd6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1061210


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
