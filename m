Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251353ECF9
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654416; cv=none; b=VrQVcqXZGk8UZjHNJYkfdYmqoY5v0Neht/kAaT1dng3CmuoYHaEiveAihOrreH6iQzZeL3uIL2cQLnpEjO3+bU77hbKJr+rQQCR7lgShCUS3LR+YxLAnRH1FyZcpRfIDMAtx1WIqohFFeUA8NncXZZWc8tg7zL3jb/85H/mIVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654416; c=relaxed/simple;
	bh=RmTGgPe6Ly+x+oxfsxP7oWVvhntfr31kPF6Lwp38xl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=UEA3qj4FwZuM/ySoEx+2UXE3p4z2r5+KEgCLxcC4cFIc+60E48SFEoLkedyz47TOFiMNkhYJvzGCB/v3ZD/VcCJfQ6g9Z2gSDJjIz+J+ukfsjbp/8g+yk3ReoFLOodtd+eWXQg+zsMBHGxTO67ueXwy4TZ6G5L7+gkLSEX6Eyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYVw+prZ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYVw+prZ"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so9633565ad.1
        for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789654414; x=1790259214; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gI9xRUeC9G9cG3BWWP0a3Cx78qva5MS9yCWWVBAJI5M=;
        b=WYVw+prZ8GCYnizPEUwCWPOerDpVWwvFOjG/3ZPAyCJozUUJSjjUN/68XTLrHK7NZf
         e9mS4cKrBUTH7wgDXRRWL1vfkw5L9WmTwsZ3krDqNZcCsOmXu34ablDSwTuvrVMdgodQ
         3WJhUvUk3FkoGlmprQZ1SXjB11RQ/iAnTW9Ke0DZUunr8/3RsaQw0jCYHJkc8OAWoFrY
         WEX3uzhPDW2s5mPaqIhWQMlGSaUndeu0Hk/gWcp7YKrqyAdBUECuhu7xk6Uco8+Z24K9
         0eIhsR0zABtVFKbXxu8oCQpMDq1oxTfV0fOobJyngq+ns7k3/qieYXJs8fXYLZopdKQN
         +Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789654414; x=1790259214;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gI9xRUeC9G9cG3BWWP0a3Cx78qva5MS9yCWWVBAJI5M=;
        b=S+SGi9Ut71DVvcKY+IXKa12y6IHzRJn9x6ltGqrphyOTvW8JErByF7Zujlp/gpt3Iz
         XTf2y+2V1zI01s5f/7iKxfDGb3Fs/l6B6fmh3284JDY2wVboixdEK6DGIsTfnX3h0cL3
         BnHmrBZZqlQDnTUMwPAtUFx/T1+PNodUi3ZRhJtuWC0s1wtCyq7e5JXxweFKTB15kLkn
         Z9d3Bopx4hTsoObN8xZgGhTTI57yjoS/8IhVl4/0tjIOguc1yV1Se4ScQUltCwH681/q
         VvjcclUqqdZGS/DBW9T0hUPq8+FZKS4A4hgnssStZ8Q9MWV222xUI1kUL/OrwCHDr5Fe
         mBjQ==
X-Gm-Message-State: AFuF++nwwjnZQRU2mP4/46cBeIoHKppubDNS0xE/EB3l/B/ShvVwM4nA
	dVNAa9AQimQTqXbrpGaJs4n74PEuwmKr5qYZ1V256VCbpYoKAZZN9FU=
X-Gm-Gg: AYBFou2xwuP/9ioJmiHwIGW6sX2e+Ul3noY2UIwMndaNhL7A+HnX5BU7pC+ulvEx9nB
	kfTenI+ruZcW3ChJmjLArfrWXVxv9Gvw0P+S3UStJ3IXTfQRUU8eJH4LmXMyjHcovUy8Co2dbeq
	ri/3F+jH7INmkEC+u3Of6TSJ6YUHVFn0uaJiFLd/08AzcMfpdesJEshkZImtjkgTkZBYRYN26QO
	/oD5d0lhvac12xkon1NLQklyBfPa47AYUl6eX4756bweot4phP33XjpS1surOvNWRFe1QWv+ddU
	1OqoVliceqs50r0mgMsCAv1vhaN3z3L70h8M+9BYN/Uuk594lp0mu/DLa4+vUaNqw0XtNCcTho+
	dHmJRxkSJ4xAco/CvU/3leIPhYKKPxWtWcH310On+zCOsoIfmBx3nbgxVzHFPDnAY/DH+QIWGvC
	+f3+pqSRrTcyQmEZ0thCSo6PSe+3UNlaWBLOnZ5thCWOn+/mUObda2EZ+wtKbnlEw3KztNj+Eka
	3WNPn9j0qE=
X-Received: by 2002:a17:903:2a84:b0:2d9:3850:2741 with SMTP id d9443c01a7336-2dd8cc9794emr154812745ad.0.1789654413634;
        Thu, 17 Sep 2026 07:13:33 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.7.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eba176sm27489985ad.36.2026.09.17.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:13:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
References: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_misc_fixes_for_v7=2E3-rc4?= =?UTF-8?Q?=22?=
Message-ID: <8b3d2993-177a-220d-1631-b47cb8945267@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:13:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35226968814

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0ede0719f4=
22
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1167597


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
