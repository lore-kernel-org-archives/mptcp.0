Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512E264F8A
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535911; cv=none; b=EfL3NaadIiEav1DxFtnvbduQ5KUQwywqRm5/0hnqWrJObXtIXq07xagQnTa0YPielFzXr6IQUQZREPyxJBht3YH6WR0TnIGvRNAiZ7aymjnhoejovPuXh1CB64P4fiwY+jgNNWJNwZmNGsFnthGHpEs4xjsngpRJ0ztT2N+FEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535911; c=relaxed/simple;
	bh=haNDUvnwHWFv9HNHkuNxGVabdzCCA0DG1igXP4NKH7Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=s5kI85sCv4w1DfJk+cjxUouB2fV5ARinNhp7sKHbK7ZHWmr0b/+hmpm0P6FF5+UEdUfDZPiz+KZL9GB8IBUemzgMtkt+4OLrn9f0V+qhOXApJHjY64v8EY/wY16mMOrsjYjL5aDwGyiOeJRaThwN16SyLjfjy9CDEvCXKhl9IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb6obfQi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb6obfQi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b38d4de6d9so26237231cf.1
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535909; x=1759140709; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7rhLUKlyWEXh8zISNPqrru9ewiRfvNrLUBCXQcxKLY=;
        b=Qb6obfQix/CCr7omHFQyytYnuPLk4uWDQoEPihKqcojOxdzkxJSZQXbxhjqEA9Ol7Q
         bvebvpqRNuvsuyqIUd02qOFG64lb3y6Qt9kaBwak6p83zRL5MytFTGXIwXxWgx/EMGTl
         gkp7l8jfPg9K8qlorE8Spn4pB3Uzxr32+qo+xZfn7NYTn1qApXXk8rHa5vQOT9MJgRlu
         dHN8J8/5FKb5Us9a3dqTq43E6an10psgXn55nzFhXY6bOIeCSS4K1ynIGOspHomPw8x8
         h57NODt0sjjKDQChwMdxtdm8UCUCVCOiDxOXwo9Ht9dz0EBGZDDwCrrqM+hSnsH1s9c3
         kMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535909; x=1759140709;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7rhLUKlyWEXh8zISNPqrru9ewiRfvNrLUBCXQcxKLY=;
        b=fz4bvYkeAVQy6iYIU0ZgaYzVyNdQoRXGtSGuFTcf8tgq/DWr9vc15iJBKGBfgW7bdn
         Rmp5rrtkcuw3epHSgzoYAQC5hDIrxjn5ELWjtkOqxE1zwPfo8OHN6QnsJSx3rnM44gHB
         FfwqsEsZwDE+Pkxt2YpVvwE91e1/mUWyCYMUhmelADMUU2Gn82tXma10oC4jZkdiAdX+
         Ps8xq08ozU8qDJ5RLPcBdRGbPbrpcKp9T9zcWrwylv2hPoBpJODwdxndTjeZ7f1gK1Bt
         3WNYTH7kyQgNLsrbm6z60LX3lTxrDRweFPNT1zuTof+4WttaDL5+l5qpt27fxYu8BCyB
         sxhA==
X-Gm-Message-State: AOJu0YwVI5pDxNLbiWoCLCtTN64TjEGEnIFH35AJ1VEWd1lrN5kiHGEQ
	+93ewfQS1Auee2U2Co4mLq7gMFLecC5eaa3y5sa4WMM3Jao4LicfWJc5bci2
X-Gm-Gg: ASbGncvNpnrBgRexEVFIa0mNPMRyE1UAQ5II02cHLyOYn03NahbzIU7Gla/b6gQT1CZ
	RrkBQDzOn/uHReZMSd/z/pYrvsJS2xfU6UGOqjRqus571r9Ipn5mwurptql5ztT1l9KTl77vdU/
	CAwgSZmeBDNwU89OWpBphRlPJ7CbPlZGpIenyeP6zTacAwiUrBI2YDhnBjReuqqXClgFeaOyAlp
	3B1/nJpwb2ol+j/FqI4+Gm8GcG9p+QEGy+o4/UmWFiUc3aHRwWMDpnVj5wrNqTdPq0OGF9Y8a7X
	mZx/XsreMPOmDcZ79E5EKGPwA9/9hwMO5DxrWxtK/vaYwZpFJB1wW18j0d+GEgZxJrUlZEp0fhk
	KlARmlFRuT8HH5vTsYTxvnRKXRLmiDOoIZQ==
X-Google-Smtp-Source: AGHT+IFfzLYOF3ExsrWnZq2qycWrW1Qs/tjil84WnLIC1wECIfVNmqO7/fv8NGKZTH3NeS7NaoUJZA==
X-Received: by 2002:ac8:7d45:0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4c06f938b30mr163298921cf.28.1758535908415;
        Mon, 22 Sep 2025 03:11:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda943c27bsm67008901cf.40.2025.09.22.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:11:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758339666.git.tanggeliang@kylinos.cn>
References: <cover.1758339666.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_receive_path_improvement?= =?UTF-8?Q?=22_v3?=
Message-ID: <ce72e8a0-723c-e48e-c1b6-3635bb0bb23a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2025 10:11:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/179094=
24668

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/808fa7e15d01
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1004452


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
