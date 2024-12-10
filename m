Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C1469D
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733805294; cv=none; b=m18M7YU9Xkrr2UklcKwyFhhGtSVniXDxBbKsf/CMEGXmaYz69PdyAWWclSXPP2WmkzEwo85VW67wDgGNIQ27CaiyDQUmZtthekZpivHrWhAuZvcjA0LcaBi0tQOmhDJnV9kYb83GHCxm6MnLT5+qkYKaXcuPOI37TzYrVe778HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733805294; c=relaxed/simple;
	bh=6MDh6o/qHWhAYVsNsvaC8wTl2J76xT+Ou1jOiZa57k8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VYSyjnIO5sD6KiI0QNZrzA4qFOEKiY/PVJa2A54BXuFwxn+N0X86CR80UPmfYV4AH6tb38gwPNW7wPazgAYSyE3rzex7m9gSu0NcwbvqTsrq/FmAhYMovoG+6oNBCFQTZLzoOxjSOxcTV6t+d2NI30PrM/Nc66LjTWI0qzWqLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHl5YERu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHl5YERu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6d032bfa0so259227685a.1
        for <mptcp@lists.linux.dev>; Mon, 09 Dec 2024 20:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733805292; x=1734410092; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uJ3A/ErvQkm/LaftT2qHEkzb3R0jr0a+R2SAaiYJo=;
        b=BHl5YERuAw/vA5LbI5LzZSUQrJoWjLKU6BfJsuXeoknvgmXwM9OHtfu6tHVcfXciPs
         pEdy65h70bt+AWlZcSBSzczXdXdbsVImkfZx2giaLPgH1gv1jR9gbddtQOejr7bmEWdY
         Nd3R0UY4HDk2W6UcRlZlaZfD5xM3kWxkFDq4dfoqIn99rYzU8hcKh0v1zGtR44OTnuwu
         XuKhhfvl4VX0aLN3jTI99IfMhOq9G7SEaYDPbMlgs2hWZ9eBAubspw/nO6jxg3tFeEli
         TT+5B0yK/dBBky+mVXDv6RK2wb7jXdOPOvyzkBg7XGEgOmsXZUv3pa+x9n2iP3KG1wYc
         4vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733805292; x=1734410092;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/uJ3A/ErvQkm/LaftT2qHEkzb3R0jr0a+R2SAaiYJo=;
        b=r9KEBUMVxv8orBDl4qN548sYlIDhOCiJam5P0vL1yE0tbJD4s3V1mFOV3JIZnIezgZ
         xjlBID/cSSCiwfhX1XGxniKJO70faietelJweJ752gP8XBnY19rE35HqyQU/sDf/q0vM
         Sdg6pjMulISUMk/eOMH8YSl3sQLlZPiPGFnZzDEu/IhBGqtZylIrz93nzR05AQSB5JIU
         wspULCpH3v52Wr34moBWLQAz2aGG4T4QSojBJECxs1Ghqx5bb5JGWDGeBRECP10jpIps
         V6ApDfCruPWbuZYBxHt6kqqA5skVOBNWdKMzivLiJi/GVFbC6jLRAAkbzgLQr5Ev0vWw
         O1Lg==
X-Gm-Message-State: AOJu0YyD++EtQbh1yATSsSqUGt/VC70PAGDQnki+GhVRfOCfe439KjOy
	C6H+n9OfFT2fZngMq2VmCj0AdAMTYr3Pf8KA5Eb8UhaRlic/jQXkVKsS
X-Gm-Gg: ASbGncsRZg0uKthChDH3ffIyKsZcUBgbOXjMeY1yPXG6DqHvSdO+Xl2ywCf3yF2to7W
	J859kIQ+VgWPG6Agy8jCwpG3nhn3CGZCiwiP8owofLp6QS0v8Okvp5tL4rYshHzQr/QlPIMMrDZ
	WzQz38P+d2K4FE9qz0tThuI7e4b6C3GUYeoxi8EHIgpg2e5WSwogXciSB1cnakVb5/Qv9vmvkjA
	w3Y1AtoOgxqcZia22VuKRp3U3Oce//Rai/Y5FvDmRya32v9NdizPMlLoME0O2yrfw==
X-Google-Smtp-Source: AGHT+IFXtLs6yM+gdZR8zymJSRuByu5/eJ7ShqgRqVFYVDCOmVLPFilXYY4Ky6pRcOGcn+QcoWVbUg==
X-Received: by 2002:a05:620a:260d:b0:7b6:cb81:95a with SMTP id af79cd13be357-7b6dce576e4mr515355585a.26.1733805291932;
        Mon, 09 Dec 2024 20:34:51 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f00654fcsm40444236d6.53.2024.12.09.20.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:34:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 0/9] use bpf_iter in bpf schedulers
Message-ID: <f2a3d258-b81b-9b5e-0d36-94c2797e022c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Dec 2024 04:34:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12248989279

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/58a73001abca
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D916204


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
