Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E5261B8D
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946006; cv=none; b=cQfckdQjSztU9d4/4L5BbpCeXavsqhJxw6t7oZqLinYlu6utuBDDXdH4+fwam2OTOAkaAUq50e7vc2bnBXUYQqSGzg3M3mB8OPiM6nnAUfUOQLeOtqFj9Jz7qoJam8L+KWG+gbVAw1xfFJgAjQo0t2wKGQrgbNxZPpgZtDyzLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946006; c=relaxed/simple;
	bh=VbIpzE43/l4sqaPpqUJ8JF3Z4gw00sbkjEWQO7RoQdA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eK9E8qk4SoASQVpeD2wL01zRNdU0iA66ZtOlxVbrt14MGQ35ncS+mbciD9x92UQkSUg9oHiNBT6ziPX4UCVr84+XVRW7x3Ci6HcEBVnWqbCsc8qKexK57BjO/M6pcfR25VnDwE88fJocMPLsH+3rSbEuFxFUYnhlAEVjZPJMW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HczXe/rc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HczXe/rc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2984dfae0acso8753205ad.0
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946004; x=1763550804; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KuJYaKNmlpFbWIIc0eut5VgOBWYgmHq6GAs3QW1RBo=;
        b=HczXe/rcJjqIBbPr05hU6W60Cmd+J8DRV0Vha1JZuJ6pZeWZwy8rHPjWqsmRrc1wb8
         AqqZP91cETZJXppNNWu2CPZiUuMvFJQRhI2eQpOA8uEc3bMQ2tiY+tMVAcaQKTOXQt/0
         SgEbZMMOlvlUhsPAMqNtDWwvh9A0wh+bLSlDTKck8b3z4jItCp6xMVDC65tLes9NM1s4
         9Uci3fOwCibBqUUyuTfbvlzWJHjeGm1l6tSf/p7sL+tQc0GXx9ZsNV50kuIf5xB+QdaM
         jb8MfrbyMSXtZiVPVSl7vD2tOdgL8aw/+N+zILhfjK6wl3Zznzb1p6unTdjHsaXNJB3V
         8AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946004; x=1763550804;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KuJYaKNmlpFbWIIc0eut5VgOBWYgmHq6GAs3QW1RBo=;
        b=h8dlcIGshQgCbfslos69o0cB7plTQRI/w9LOgBLRov9I9aghMvYmSChtFkFWzgUngJ
         gDlKfknmVti/m1/xphu6gYiceYIjAqaGuI0var5Vn6RAiiGiakcHgr1E/bnzAlBMkpwb
         SxnDf/mUB/cajGJDGraXE94SgJqMcVvUjbITu24XMcbqqezytl4HPHIoQ7YGveL2opL+
         Oh3ImvcVDIPmlGizRbRTqBImIfAFGRrPaqsysXgTfeyGjYNrzSSzRmr+nAVGkEKhe3ms
         aqfsOT/BuMVudhh8MwciKqPikNNgxnfwK/WNkIPH4EO9bhjXSu43NUf3sAcslK9bXPHb
         iwYQ==
X-Gm-Message-State: AOJu0Yyxe6e3vxs+jSlFFUH52pA+/9yeMCisnzwAT5Ojm8ZjjoGTwP6c
	Yxn0/60/ZmgSrJOPERZ/DIL7SMxGjPnn/MrPsUQA2BkAGdjRbi9xhqDMjQue
X-Gm-Gg: ASbGncs7fwlHxuj30k531VxcPhUcBsN3gPMQsQAXzqFZruhOwX8x7EMV8+OpgsfEqKa
	0QC+Dx3yEOvOJfMRm44zHNRbtmSuA4XgKdBALNJS3UOO90Gosz73+vXR4UXE4ithrOF47W3s6ox
	R2XMOO4xdYzoMjdzr/KxYU414GXdpGyfgPagHQjxtyud8o3FLLfwwmOukfSl2tNMFzb8RAz9YnV
	qy8GBGNHRa3HYJibe1g05GmTl0P3fZG/K1VXhQAsz3U+aYr5rkwMa+7Txk0Pb+pQjO7Rdm6cj4c
	C++AE5c3kybR1Oadz4D/TYW2WjnB6KSuTP7kEMhuk7aMO0IsqG5RPpBKlKl63D8QWTRd80MOpq6
	VWdeKMPq6+9NrQHEtgS9YV+yLG+yTPZYASTXFwYSIz2x9ZBjpEbIP48kHvTe1wt1SpohS1GqSjm
	PJ0ZXG8MFqEQAKuCk9pDxXoIs=
X-Google-Smtp-Source: AGHT+IFfdRaIPLnf+2nk3xvvRo7AV4t43/PtV645y0diU3/gER4AB/0LDN+OpVUlqvwtppWKQlMEzA==
X-Received: by 2002:a17:902:edcd:b0:298:450d:6926 with SMTP id d9443c01a7336-2984edcaeb6mr25266175ad.34.1762946003910;
        Wed, 12 Nov 2025 03:13:23 -0800 (PST)
Received: from [127.0.0.1] ([13.83.166.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf64adsm27722735ad.42.2025.11.12.03.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:13:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
References: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: join: longer timeout
Message-ID: <c53b867c-0e33-5943-45fc-1acd3fbf85f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Nov 2025 11:13:23 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19293439106

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fcb8a7e51251
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1022413


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
