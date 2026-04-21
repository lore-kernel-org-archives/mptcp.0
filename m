Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64737D114
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790254; cv=none; b=lwYdVuC+tfVNTNQDVMFK+Qhd462LsO8a5/oaIqwYa3/0grJnXIvLdI2QZLk+zreOaPWEzZQj12aGrBzrOihsnvW5jO+3SRTXcgHpVl70ZyN/p9JEjOgNxsS0qriUMhv6hSD3drFyVg5bSFTxBDAePyzQyAGt4sw1VwoTNbuYECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790254; c=relaxed/simple;
	bh=8Eo7ggSL40jrTt/xDQxe+vhafK+uj20QJaTyNzN930o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Png7BFDRflauRFCISR8VD1mxohcGqehqKYNtng2JwXvW8Rd1Qz22wcZWj3I2U/TWEnzKOlvGlyxUiO4Cv4sRXKL535i+pJeny2u2wasBziUyA7b/pdWjQUdDwcnfv7ljRTN0PqpVvZVczV9PDHRA4TuBYCSpDLCHKrqqA4pccKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8ZZQLsy; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ZZQLsy"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a151012558so49025556d6.3
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776790251; x=1777395051; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeFVlYem7bS54bh3S2LnfnhwA7r6NOEQ1TCFDYHkggU=;
        b=S8ZZQLsyKo1caFfbzPm+HJrCUiBl3BlreTtBi14lQys4PgFuXCwXEH0d7krk0XOgNY
         CCbSMQR56QUzgDoVL0Aa4vXmEA6Ld/NtGAQDxoU7nYNSgzHjw/szLTZQpWWNwlZAr5D3
         kn7QheVOOKaPTlVVnkVBnB1MD4T4BVei5wskie/U/YGS5Fune4IOM19+qvp7RlBnnCqn
         0TQFyRH+77Ynv7G3+Aa+54dc9ya5CYdpgUGY6hHowNNuugFywRHezUOUJ59Kq1lkHwA8
         lxaHnhsK+FoeYVYv/+D0BXZ3mdRV/fDexYFq4iZmJ25v/ZhLE4HWgXYGQnh4lUy9KKt2
         gcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790251; x=1777395051;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeFVlYem7bS54bh3S2LnfnhwA7r6NOEQ1TCFDYHkggU=;
        b=rgQNkseGBBCHtZKY0AEz2Rq9ZAoZMkXxew1GqYceOzO1ugtjTHjdQTKOvPH7NvGJVC
         QUlscUxqGAWaXngx0FnF/XihIrxNBvL9K2s0Mj3C3mOw7FP8R3MWSb7Ekm3IQs5Nmepg
         4ki40E3s9mY3GsvC4hsAyfjwQoPkPBGwos8v0O/hkprAVUpqJ9L8b8ikUjNr975waLOZ
         48012iYiD9GRGnQRt4NusJV5aMP3aIlzszDlTYlt8Y7hlDGE7a1rF5OKqi4If2Dduc1P
         Z0xo4m/A4vVXwnkehB8OUxoib+NZ+koSaYWuBWGE9jZmOB7WaN/pSgWHG7ajW2Ok8X5t
         34EQ==
X-Gm-Message-State: AOJu0YwzOUWQ6ehvAI1O2dqILoPhBVM9K8kL6aQyYM1r8I1Pf2/wla+8
	ud4jT9tz7DigDyDt372ayFSUxieKFeBJxUT0VIYenUReHQmXKQRSoUk=
X-Gm-Gg: AeBDiesysFek2r9XL7J06HoveMkMRz3ENaFWwoIPdERppQxlf0TwqJnaqggfRzrQO99
	YaFrLLW+a4URo7pGHwP92kBVeg03SWxNOKnAeRPvTFRHu3qk/RmmuA2Jx/2WWKP/iiTElF1YOmh
	kkEo4qMgmgGnf2Mc13ueYpnnb5kCkEKoipSpb8qiOdm8+c/+rfmQRxO7qnZrTTS+eTn4ibNjTh5
	CCLGZ0XUUV/t454i0BXvofT35DJ5LXzVry8FeoqTclQ6m1U3NS82ZN2lQjIqvynLh9o2G0w9TYC
	WIX9ZlApjw136OoFfLQ1RQW8SVsPp8N/MCRohQknhLexKXXKUYj4Wy0jfbCBzwtni5ZZ6rcIdry
	ySMhk05MJ4GXbjWY8T7rz9+flJ0hmQlAYiAhVfLqvh6rX+jlZxrEPuIaW8p/6APli/MBUrNmDf2
	1MWDeCvPjiUv/4GNJbB+4D/ghOsrDvwSk0FKNYjH0bV99SDm4=
X-Received: by 2002:a05:6214:5b87:b0:8ac:ab13:8f15 with SMTP id 6a1803df08f44-8b027ff994cmr330527626d6.7.1776790250816;
        Tue, 21 Apr 2026 09:50:50 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c26csm109860186d6.31.2026.04.21.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Subject: Re: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
Message-ID: <790ed396-c01e-b324-b631-8f9cb28698e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 16:50:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_sockopt =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 4 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_mp_join selftest_mptcp_sockopt =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Unstable: 1 failed test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/247317=
34242

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5dc9123ab172
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083918


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
