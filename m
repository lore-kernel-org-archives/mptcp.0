Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E583164C2
	for <mptcp@lists.linux.dev>; Tue, 20 Jan 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924927; cv=none; b=Cu52UJvnh5X3QRspufTiTsTRtK7yMJ/MCx+X0yaL0IXabQEP4jUoz8C7sC4Ixkvskz0Ea8G/hYzs/S9YMt6waGCDgkEL/WDfjFoYciVcMmPg5lcGzyowDIH7u4M/jhXtqNNvXikMSqq98vOeJ/H60h3/RiWl/XQNStVjKDpXlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924927; c=relaxed/simple;
	bh=qX5hTfZPJkjyJAyNdWL5cm5sbfdbK9R0hIyOk+uYU+E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tvNHYCIHNarBNOxCK4mquu0708brsyeWPcil26Na5cZmPC+J7gxlZbNSkidDKdsz9IvWh2CTaZLgD4Ew7UayydCNWS3bbdV0zBFFmQ8PCumsqhOAAyZvwSZIT82tIPhF/PJAqESJO6BXKuyAgggZJ3Z5UnJ5H2sG0TvfpaVfdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6r2B8Kr; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6r2B8Kr"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c6a001e3bfso337190785a.1
        for <mptcp@lists.linux.dev>; Tue, 20 Jan 2026 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924922; x=1769529722; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=168sD/kSFQDLrLkQJv1zec8ZeK9RY50bslzwxMo0okc=;
        b=O6r2B8KrMk7XNsEOaQxlRADvCK9wxXgfiNIs1jqfERw/pljeoY7ndsChdIkjFIrSOk
         NUKyvsd2d9yyd2EHur2tZyOfrMzHeEFnauS3nq5A9sQ5Du/jxJ+3CvCD3XGY8tz2YL0s
         Wu3tAlFrzSNn5A91AgNGfTfvVEe9QJEFGAxBJUG3HfHn3uI52eaUKsk7/QwS3tjbippv
         CufSdHuFCUKHAdfuArE5ud5Su4p9JZooBpiKMKekM5b6T66dE3rjt+18BPjSr0ggKdYO
         LMkayPZTdLwb0Pjw3VWI1ilEjWPf5bxS8u1u6BqWhx2BdIBce5/AkpE0L97eM3HJJfJL
         WuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924922; x=1769529722;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=168sD/kSFQDLrLkQJv1zec8ZeK9RY50bslzwxMo0okc=;
        b=dQdiL0/N5+O0QDU8XyC9ACLK3TBnnk7JC4xBjkesUhVQ2Ha+r03E34JSJdfR982LtJ
         aEfnh4IkUflIB4WOCaqgTiesXz5mAxHzycWnP6e0w0T/Ae/8lGzCn1sCiIcrz9mQ8xka
         77YUegcROyhsCP0jWJsHlQBaNAK08+6ZMOuyqX7dL5dZLW6mEIzivKtGDgqqESexgU4Y
         KK7qHiCwfbVVxS9Aqswlvb+zLmndXQL3U0T5nQb0Z4gkmkmqneBV62vWNTGE5xljozna
         DW+2+PWvXtx0fQQ69rp+S3C8JRvQCnaB1qMHParpBoDkJSit1k4vF4nVxB4RivzxbJVR
         TvPw==
X-Gm-Message-State: AOJu0YyyPCmDCtVWZnyYVuboFq7yw7SFio7JFCkwimRN1IiqqyRguVCT
	EJ4BVhfB8GxWxTO1FFmcNQ4hayN2RUHjvoYE5OO6j4O4AlEIZlEcjfg=
X-Gm-Gg: AY/fxX7ROGTx/YjamYHm0Qa+qXdA/7uMwdl6WP4wXac4SNLxbapMj64AJJi/cTYm/xJ
	1m1eFYWb0apKwyppb1Zpf6h12/SLMI0igmef+z9FU9+Fs0M0+S0Q4NFiSjxx9sCj0WNOoEhj5x9
	4mZsZFBNX99fofUC7pBGC/LrbRn2wdeZMUIYA/n4SjVHFR1Uttb4B/xURtK05YjXAD5TX8Xp+CI
	rMjvdIqGWzHHwHWE1D6wyVVzfpiYsuP9CGUq4CYurSbJeCX/4CyXR1wg8WVr5DWbzY3P+vBcRni
	8ehMzrGibgMoIrbUUX++keGsctYi6FNyBLxTG+xcDwoinaVycu/oESmff4D9LCtOmVOZfRHOXTh
	1cYI+KQ5Z7yDX+rQtiJrLiXR2geOdTLF7qFEd/k2wI5xeJMN/5VMmgbm0ye+9sjGC8GNPhyZ11E
	FthvqMbOJqTu70TWuS46CPTlfc
X-Received: by 2002:a05:620a:4052:b0:8c3:6f44:46c0 with SMTP id af79cd13be357-8c6cce781f7mr252957685a.16.1768924905410;
        Tue, 20 Jan 2026 08:01:45 -0800 (PST)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab288sm1108411785a.6.2026.01.20.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:01:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
Subject: Re: [PATCH net-next v2 0/4] net: uapi: Provide an UAPI definition
 of 'struct sockaddr'
Message-ID: <46b69dbe-723b-a253-2830-275584e8f266@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2026 16:01:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Thomas,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21175122829

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/81d99f1609e4
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1044679


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
