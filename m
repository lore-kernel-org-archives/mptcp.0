Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31128C009
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337949; cv=none; b=qQukQHF2qWNqAobiDV0KoQB0phvm5GJG0FvFEn8/TCOy6Ct+9ANHGWddeBvTbOU82vMenZzjTvz1E+5zIu875hkX/gEA+vpwMoWicRMtYoiTatVmOhpL88bX5Aq7Dd5FEMHfq/+zkQGi+71lc7lPQuDKY3paSa7P/Q1o3kvrJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337949; c=relaxed/simple;
	bh=D5ISYCvKB+MdNW10OUowe3IZmfNvoGuEyjBMXHIWlSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HjBcWJvlIACMDUsHar1ftTj54cHAsS0aM4ahN8UQ06pWwPCG4n5OVcZ77+0W6Y9FjkqI0zDOJ54rfLZN3BGtkBupdVpztdcr8+iqggWAJG86faBwYt+t/SXK+hQhJpIu3tblCLEtKI3ESTBTZjtihJwcfXNJv262tzi77kbeEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XENi9hUu; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XENi9hUu"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c726ef332so15043697c88.1
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777337946; x=1777942746; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VbG+kRyiJZMZ2ecEewqs4IvMJJxL2+Vpy6qpqWzrCw=;
        b=XENi9hUuI920wgkJfjTv4s6ieHb7v6XMbNAm0bNutTsl3ohoPTxue3skTAnW4HzaHh
         xvIcGf++vR6jIA6940XqbBK1by2zP5U42QepTHo+Ei8lE0GuRUUNzQYQBhMcUn2XS4ej
         THqiQCLsjxHoIlTqAPAgCn68tlBlrn14OSIvLOW2UaXgYrtJwbsLiDxh/w0WEBbCfivL
         kHxeFtUAP6xcA8CYermUi0rLup8iFZw2bte+szIAWURb3mJN76MPAITIvbMhkqtJevi3
         mrNpmkwQi4eFuk0OKqxlrWc6ddP6ooTfAl96d1SM2GN8scspW2MfJBP0glnlFBcIj0Nn
         4ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777337946; x=1777942746;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VbG+kRyiJZMZ2ecEewqs4IvMJJxL2+Vpy6qpqWzrCw=;
        b=pjvO4NlV0AoiS+62HWAl9JKlD1nZo141FFVEuqRDJdMzKf1sv7OMS4MCUL3jRNGoLs
         +W9C8V0fw90jSv+eWhgsDb0sOnKMMmSCpTSExmjZV+obKtRoxyR1KfwzZGEgkkPb/6pH
         JJm8SH+AsvjmfVsUmKJ7zthk+8Ci4mFs4MjMsbgttP827WwBrSbf5BpXUovpWDGu6VAp
         4WdCFcb1lARO/2qZnn8GRhRp0ta5BKE9iEThICjIGolKxvs+WYKICphtTmCfyRMvZEGO
         pruwn6ac21HUeyQOgHH7kljuusCuFMC6DHf/ZECMzcgKM7ETV4WzgfQp8w8gkLfkz/6z
         xZwA==
X-Gm-Message-State: AOJu0Yxlfl98qlrKKItcguy0eBpZOs2XAngHkNb1q7F2eMeZoaNJ4FZ/
	vcGXW0zLkKDmmUh/aAwST5KjRMVRwbU7QrEYd02eiNGrGEEOye5w5nQ=
X-Gm-Gg: AeBDiespf/2sPeHcHoV2XhnCI31hgC560q5ygMKERKS6OLQnLSnAck7Sv3PjDfvsiRK
	Ujq3vwxwvIidqewapqGM6yVf1Jcjg+9N6Y2ApSIDTBMS+cWm7pPbReHin++b3RsSw91RGC4KZTK
	qDFoNvQTfQS/A1H/t1PT9R1WG15OZv0VUIzMd5NevZ79BdKfNko4BtqnhpE1JA7zaHcnA8PsDlL
	hpWlZFUeIStTd6Z+wnnQ/CeeEkzp59wckFh65lF5A50bzs7ImXRkuQGKVmnIkgbVbHPrHVvegE9
	vRipzhpzN8SW8Ghfiil432ds2yJkr625Sobcd8dGgwSUh7r+qM+25B5iCdM5RCQLQKzouN90gAk
	mkL7rwex6fhJDrcuXO6yu540lv8QUdVXRU4IX3PamikKmVpfwHg4/0mD/qd4X7XI7gKXXK2Snti
	84gd/ncfqxBWhnVNOILKOmU6Jca/4fE//wytj6dNyuP8OhlY8l1g==
X-Received: by 2002:a05:701b:2412:b0:12d:de3e:be8f with SMTP id a92af1059eb24-12dde3ebf69mr55174c88.43.1777337946087;
        Mon, 27 Apr 2026 17:59:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.210.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9321ddsm959455c88.4.2026.04.27.17.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 17:59:05 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260427234934.1611893-1-shardul.b@mpiricsoftware.com>
References: <20260427234934.1611893-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net] mptcp: use MPTCP_RST_EMPTCP for ACK HMAC
 validation failure
Message-ID: <3ef39e35-1a1f-fdae-ddbd-58d6d8861d86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 00:59:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/250264=
26180

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/206390cd6818
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1086481


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
