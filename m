Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573A3AE185
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171949; cv=none; b=knlW6y3Xj+2wK9DQe1xJeyVijzb0Zfi7agyRCdLD3prDyL67jCONfx2BF7vDyohpQLVI7jiAVMLYNW/Yq/i9Lqr6Rel3hQwolamanw6OjZch6SqX61DyW7u/CfDU9NfKC+pqiNI+jhSiRmMl4Z2SzIddk64RbgrmZYw1uv8tHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171949; c=relaxed/simple;
	bh=iPB4Erc6jkay6k7PGZrvsuibRAmeDKv2iq3x9WN7L9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IwAuwfO72fwNy7+l6DCEQtA1BttVmn09QVgcmrdF4/66sR74H7Qfq3O2vcdVR++pQo3Xh7ErhipkJxfd7p2C6a2HyFndKwYMLMaPPZNHIQhKsJv0nh9agWqAUhZE3/vSSipvY/xIfbX9TrAFzchk3kjgAjYmQveMtdsXNyMnBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le1QyT/D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le1QyT/D"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so3558896b3a.1
        for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788171947; x=1788776747; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=85RY9ud4ENtk2oBw1uEM313B0HhzPWLEBX5cqFPdjOk=;
        b=le1QyT/DQdBWRd1SeXb2XhvFw6LSE37rAotf49DMMTYs8DloQACA4DxCw4ZKcvVXbf
         113rkenRRPxGjB5BFmmkJG8si/HxZ2NeUxBQCJ6ItzPfE2tZsO4DDFgNQJhNek7l/S6K
         9uW6f9u0gWMgty/LYht6Yg78eoDIX9YqmckfVm/pFvIfHw9891rAPVK+dfaVu2irvgAK
         iIEAyV1U2SOyC5u5FIRh23P6ZiQvUw6o/EvPNRzDG7lR5m/IkpaAh/geF1qp/iGI5A5e
         CuumOE/sTeY3ghQmQmAvU3PRoiKTTWF6ia5KBjQHYxwk2fFdu7W0FknXBQMOTpZfgMVv
         dRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788171947; x=1788776747;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85RY9ud4ENtk2oBw1uEM313B0HhzPWLEBX5cqFPdjOk=;
        b=YNL2QpmGtw1uld3iwN+bvubwIl19yMynL64tZspUyO8K1UiyMYYjGQhwUD7YwKAF+m
         Ap+1pT1wW3fKuQxu1OQQqTw7FgMata/ASoSs8fxa4w125FZmkkE6W6+P9xNRBHGReOv7
         895UhkfBL4A+qTMqAVpLkITiUI0dRxTrRwskmD/iE2j4SzXuL4VQ9UW5Li4u5/dXqqOH
         S1Riyfntw5QAyWQ9azcDhG/TN4fS9L9FsWbLWj/DFPRO7gzDT5oWIcJZCy3Y1escMP25
         TUFQOIb4HbEjk8v6NM42o1Gj72zRKdh53xrrp6IRAMDo5xiiAR2BA2jU1sz04yiD1m1a
         JofA==
X-Gm-Message-State: AFuF++na47pGVvDQg2oPRSk/APRrsVa02zvGimE4mSLNFzHtbpgi2laO
	stuTjAcuoIHFpKz+vurG0fVzXo8+qOWX7MBJfwshyUdIwjHqOZDDWIYFEHGl+FU=
X-Gm-Gg: AR+sD13lnXiADdUjpYMFKC3u8wonZl6x6Gl9FPXXqR7WMgQeXlUvsA3EgydnxXLTjlW
	Tv9p1aLqnc95EKzsGJyrTp7JxLzrymCA3o7bfjD/F6mpycsIOWOeiZFVh4vBK2PnQ8EUlolJXjj
	bk6yAb5XCvWVgv7T5quwqcg5AEqMaaPpZI1Kg1InuznK15dVRfnG6Q9vMXxDo8izOmYI8mjswaN
	kyIJIrCwzkBaIhg02Rmk1kGUIE6DO6ZNeHDyR+XrHZRqinYMrxV1khHYLhkGAPX4yUnke69teoO
	Pt5ydx8LJdxbndCKm5L3OhAXjzeoW7SGCGTzXr2HdIiHLRpJUb6Cb20/oyjuHUEI+wt7u5dXpqG
	CkSX1LXTW+ifujdCACAXgTP//Q6CtJQ07+N3I6/kZDa4fZVlYvDymTNz06NrpZEb8EU27m7wa59
	ccQTkx3GP7K2s00T9opVkUVIq6OJG+hhjL/gXrj9bju5N5fEcsSdHyXVQooT2q1Z0Obc0k3ANGz
	HUACtV2g64=
X-Received: by 2002:a05:6a20:b7a7:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3d268ef9e07mr43171227637.9.1788171947329;
        Mon, 31 Aug 2026 03:25:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.63.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm31526546eec.8.2026.08.31.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:25:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260831093206.689827-1-cui.tao@linux.dev>
References: <20260831093206.689827-1-cui.tao@linux.dev>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: pm: fix reachable extra_subflows
 guards
Message-ID: <7a47c703-60e8-8a91-c848-8613bc778248@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:25:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued - Notice: Call Traces at shutdown time, =
ignored and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/33379349810

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/190a5d9ad47e
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1154350


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
