Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E7415F03
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970061; cv=none; b=fk5fE0Enu7s8xE5g4yxZXfz98K6FjbnjdfaTRTKQDAPaVKqDkBfJsFzgfj5HpN5QXqOmUSS/zDkc8rBEijSf6ISSGnhruolO+86Hq5Vir21Adf0V5k4Z8MNeIq9zSDgHZSoPjSGOFXSjxNkuZsEonqCCCaflzRfnLB33ph1kcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970061; c=relaxed/simple;
	bh=VaOXmXpxO3wV/iSFBxBSoFuPh5MsnEq4RR3fNVlLpgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VYKLujMPBMCUXM7yo9L78RJLAQyeNrggZ2ul5iv/6AzZhtrn1xSDdcZHkfpx+BNUw0bi90V2zoRH0pH5vSLx54R7BIVDgFqBCF3pYAsWc5K+sjIfmncmDSITHiPlndnW3w5VAe9UrkHs72FcLNF+WWG7bhOIgp5M9V9eSfpVgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0aWlHoU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0aWlHoU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c95395230so28800361fa.2
        for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970058; x=1787574858; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQydu+3Ik1dTnmP9gfywWKemquxhh773NVFdpAe7SeY=;
        b=f0aWlHoULDVDn4OeClvDZ3zX+YC+m41zIy1T5AkWobyW9RAhReoxYJUzLjgM/fD0kL
         I/x8TUUBq0Pj3vfJVIZobF2IMCT+ZpSCX8kcAIH99AiJUfiAgZv/5lb+KD5fsj9bOZ0z
         4MSHhR2JFg1BEUHjIbEM6d+/CCnkIxJQFz/VmUYcTQc6g8rtSD/8r3gQF2VkrACVL7gK
         q4jriRHGF6JkJGtPPwa9LG+jsK834AqIDNMbJVeYS14Vd5LMPVZ1jnaetj5MiFY2YYJr
         Ln2VY/UjAf6QwaBluLXu/HZNz4+wUjWCuyHW8qbpMo9hs5H3plxY2FsUsooAKc+YuBnE
         GA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970058; x=1787574858;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQydu+3Ik1dTnmP9gfywWKemquxhh773NVFdpAe7SeY=;
        b=GwBjvWWdArGzyX4/QdUngoIOeOTHUeGyngoTQVlYrUAJ0Ih6kJ9sfS/Mfr9Mat003a
         udCodpo89xS9H8wI+1G+XHs2rYBLalDnnSO+5EDwqCFITsLtlYc2phOvGUF0qaTTVtny
         KwaWKr9k8YO0FqmOa9MoHBIFY32rsvLC63z9OTPr0lg5f3yl9eLui+MdPKTLqVsFl6RE
         Zu7aRAXuULkDv/dRBra+gnuSjzd/0p8ehST2yb25HqHe8BgnOjApMUX70vJ/Xfups0+j
         QuOvoyLvrRBg0FmgyHd4M4hIJV6UrBnMoFBDuEgerUafO7zwHBf7uL7nas8S+S1xEp11
         h3ZA==
X-Gm-Message-State: AOJu0YyIPqmnM5WoZ3iIVVZPqUtQsYPFmWPHjuxmcPgX6dwkC3+bGp2e
	mQL+gczVeE8zINVCqSvAbMHZrTyF+k93q3U7u37ys3LMwzBjbsHIloc=
X-Gm-Gg: AR+sD11wQDzlRpohH4gtiqf5jeHwYY/s1uGz0G/lNrXRi283I4s8DTE8yqIyzuyygDs
	/nNQ5qqfPP0BZdaj1kLCl3ZBatfZ3pg/3/w8gFbcDhcjpbsegjU41yGzMOuCB66FJjbU3knUePj
	YEaKGH8YYqZMYYkpG1Mx9EnZDFDOHi9TJWUW2mFTUG1+SAFIp/8E1TMlKnYFZiiCJHF+U0dKiB+
	Ma0l52d72JQb9Vt7RDxi2nyG5nhfTLXiiB3zkyQYiNNdDkXUeNf4aWKNQ4xLQivOvEs52e4T8jF
	gcpl0TqomBHZTMmvVgkxq0ElpFhiuR0LqFw6W0KxDwjsqP97KRUTsorXiaEek4VnmB7Hy7ymwfu
	Jt+8P3CQvskd10C93BNDw7rwm28O7j18BKwFnUgOO77kv+qbDkazA2LQAm8eH+4JWe3K1RwCOFB
	H1E692ImGpcO49aIiD2oTBc35sOq5nQ9gWbO7pm4ulcwY9NYsgJuAx9DxRnAYqBXQQt5krot85A
	5Jx8V2nMOKMXA==
X-Received: by 2002:a05:651c:b0e:b0:39b:d04:b783 with SMTP id 38308e7fff4ca-3a1324b3ec8mr23401281fa.20.1786970057522;
        Mon, 17 Aug 2026 05:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.125.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b1a9900sm3796581fa.23.2026.08.17.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:34:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com>
References: <20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v4] mptcp: bpf: don't expose
 bpf_skc_to_mptcp_sock() to tracing progs
Message-ID: <48a479c4-fb12-1e16-150a-0526cac11dd3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 12:34:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/320267=
02788

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/51b239585c5b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1147170


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
