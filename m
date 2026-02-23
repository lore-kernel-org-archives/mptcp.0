Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040B368271
	for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872369; cv=none; b=s9cWg5y2N0w0WG2GMfuYUdnyINmBTbzUxUTvbEONmEzi4E4de1lKgwXbIFdtZVYbT4doLK0RvcunRFOse4xplMDx8r5+srf1EMh/yf2ODJDlQfotGAY0xuJxLcig6Fazf7ctQMjTlRPa3EFHL/JR6SPaL3KvnFZj5CHFyZvQK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872369; c=relaxed/simple;
	bh=F6bZlIqLmfTpvGKCu99vlUN0T3dJgpCPlTQTE0OYpUQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Y4swdrf6GtWri8B5WJdNkeUZLh91R3IHp02cwIkIRtjzl42J61iKDewz2Kmp1uNDV4sh1yUyN/NWseA+jPuM7JqDar+63t84yb7NaRi/VGlgvL49HhbHsgcWkLXDLRMFufe/qVsDXf+oZwDfoqI1xjhc10xWjn/HRkSuemWZWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Q//dXX; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Q//dXX"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso653417eec.1
        for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771872368; x=1772477168; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhh89WBriCt86k50crsqCV9EbQlJVrFW/hwNGQWe6cs=;
        b=b1Q//dXXcP0/nvJqQRf3bnPUoiisT4hcSREw9PKWLPcGNcVo62PWQW8RCv1PJQhV9m
         sW9FPTzUTVL1r8lSLbO27geVi3r+gU1s3IKmQlbWg4ur8KIXaq4vt10nu7efxOER1AZy
         avYOq7khyzcpN+UmXl0rOHZGl6HSGMQSUATHn3OJuC26NCdgxNnn51AfQA25r08iG9z9
         8pZZ/NTkL1tuuZK1Vho5VQIZhJZSw5hJEmH+e5W9YWXDN2X+XJut88DRMfsUpj9+j0Eg
         FjkR7j1DKxvbx/uDoIPK+oSKTsh8GIyCIyHXvD/Kdg+sVXXrBSieStU9WO+x7JkQcEf5
         FINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872368; x=1772477168;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhh89WBriCt86k50crsqCV9EbQlJVrFW/hwNGQWe6cs=;
        b=ClUKUMU8QAGHfxjOA1Gopg3Dv4KfbD4NT11cmYYslh9GuANg/la+1deGNYClFNaYQZ
         spUpq75Ha54ibmjzc9JvkC88l+8B+Ot09LSDQc0ECtv06Jsh+lm4AuWDuufYp7xqwX3+
         Q5BM3vJ6JPtf8PUXLr4FeI6hBFWrwyNJgEUbJWuxFOYDd75GDc6Y3mJ/zRr+Ho2z//xy
         h0Kahfz/xRZWDQ/e+rVNluZYb8Nmdtsy/SsEKk/BFLdEDPFRDQAznFB1nSEi7dXG9rLp
         qsZSRltlc4e4AROyWvE5aIZn+tr4+LGynW+QKbV86cD32GSyp8nY0Xc+rccNYR6n8TuZ
         jMtg==
X-Gm-Message-State: AOJu0Yx+qk1FnsouPwunXVeaVwo/SfdMFDQwNICzL4nCf824cug/eYz+
	mrZZpSCJ62BKpW2pNsf9foK3ncvbzpaU4F0zaXUHNQxQeTfvu0+KnKquMkFXFZ8=
X-Gm-Gg: ATEYQzyO1VXRDQsKjm+wtROHskMAKNhFgpmRkGmcm8R6e4CwqXqswnf5L6EIpsA6GXN
	MAoI5OBDL9U9MaUHggU96aF+gHtGXQmmtU752cYsH5QiuEyI0zwrJagEKGVopumXpm2KhWt66kx
	F+LWR/P3TZ4gGHlqPovZQw2Y/tJX3ZyQsgtKrJArR0IVj0i6sgc2VUqqshU5VjbN5x+QJpHsJ9+
	Hu3RPiYWhJFFE/U/YRFiqJX9W86J1/DSNoUpAuDcAewEun7sMiE3PnP6nzxPBagXEdMQt5uRikp
	EmGqdE8uJSAhu4zXma5ete96ZY3zsSbhOqcDDItJvxOJVoZMQjfvESkN6xPCdZFBpymQQ2ByYUH
	wIkG5TWficSnlEHueVcqTdVoBJvH+KK+/J/H5BVOBK+rMIF5KhDmgSJNeMq/kP4C9A+m3ep8BRw
	sgL96yeoLtIqbbe/i3qqj9V7oHg0kEIqivw/M=
X-Received: by 2002:a05:7300:2153:b0:2ba:70a2:fc11 with SMTP id 5a478bee46e88-2bd7bd7c91bmr3539970eec.38.1771872367586;
        Mon, 23 Feb 2026 10:46:07 -0800 (PST)
Received: from [127.0.0.1] ([52.161.45.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eea6sm5287368eec.1.2026.02.23.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:46:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org>
References:
 <20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: in-kernel: remove
 mptcp_pm_has_addr_attr_id
Message-ID: <9bdb826e-ca9b-6f98-0851-898e53e6e719@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2026 18:46:06 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/223183=
11107

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e8955d8b020
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1056692


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
