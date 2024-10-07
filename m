Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD7A2D
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302448; cv=none; b=GfOlbRvmculEwUrfB3KmVS/UM6DF1bCEn+gVbNbjTikX4Ci25O4kWjxRPzeyKyi7P+V14oO9EuVL66x7E6JrZ4lSnrGx/PQAbaniUBULL9D97vkw0Cpa8kCgxycOm4fnFUrd91pA488+scmm4VCjOHkHbeUMKNQ+9cWB3b8isSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302448; c=relaxed/simple;
	bh=tBsn4STx/kMesbSuYgTALmiwqUCuw0UBdAFiJekDYck=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SRp8mq1yLuAE/XRTyGbYKfD10IpX+4apsWh2VDwGe7iPrzKWzZDwsF9bFQxlohiylI0YDJnVwPrkYspriPE3cAPZuJKt3cGMfa+nh7zJLLQ0EKwanGZZXQeMXCrtAKpF2VlDnF0vO67eIFC6AG7vjtV97fg1sAF31hfgCQoc+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFcgv6CK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFcgv6CK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b833f9b35so36532025ad.2
        for <mptcp@lists.linux.dev>; Mon, 07 Oct 2024 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728302447; x=1728907247; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Zq5xcHtyVfy8JbRuirhcD3esFntQ5wfyR6SVaKTYY=;
        b=IFcgv6CK85ucsdsHyM3vOvEw6nhCM6qphhtb6MwU4FZEwK18HFV95kqhJRID7NgJwl
         VYqklJuFZ9ZXWaa9KiF73A0g0ATfWOhHmgi+FdrxpnY8kAIl7lohDPQvw/u7R0kn2UM/
         BdqyfDmj1Zx+1C3FDNJZyl0RJSZeBLYur1WWI9k2QEOwK9Zt46tFtEbcg/lowpIbi7wb
         G5c6PmVO207Q2mLPNlQ+U2eoDcrM8lZP1ItQCJic4JR0PqQA2dQqyX9NIuWs7rc32YF4
         VenD6DdqCdefXsyr0emmPnBIE6mUyH3PRdk4JU7Kvxc991PfaLI+3jNCalCBZ+2hrLYC
         Qdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728302447; x=1728907247;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05Zq5xcHtyVfy8JbRuirhcD3esFntQ5wfyR6SVaKTYY=;
        b=rT5L5PT5zMDpaJrjDS9P/Iq4nhE5qXiZ7ua118VoyJaetUuFmFrsv+rprE8/MsydOe
         IVE/KHDoyBH/gyGMf25Sa77ZWLlU4l2oN9rScSSk1i2fB2mwmb+GGZ0RgblayvcVfJ7U
         k4kNQVd35aXatoL8hU4OLXNKNa/NDwh/bzHS+uksk1oe/s0qK/y4GVEaKhX3rJseebJl
         y7otWNyUdTVuwFYN6gJdyz+FnmqjmrAFJcwf6YHn5u5/l9NT+OqZjqF3Z6Lp2CqhiB0B
         F6tXrclovq1uBLkO8rSGMa30EvQbWvnRQPFvuPSsIPIQYGUMxzCdHTb0xPcqPAqHH0Qu
         3tQw==
X-Gm-Message-State: AOJu0YyohzsUx0dBo+KZ3lW/17jRJ7iWRlQ4K5SUUExNGNr4CKJ9k2Pv
	BOODxV4fvD47a1j6crBaQxvoXkfmonOgRZyN0xfgtQppYR7kcKsMeLYX
X-Google-Smtp-Source: AGHT+IH97cqjALbZSXmH/5TMlVTjvUIYiKghNJa2l2PYl2RrItF0dst6pbsqI46QnT3dk0UUuH0hBw==
X-Received: by 2002:a17:902:e545:b0:20b:a728:d11e with SMTP id d9443c01a7336-20bfee36d4cmr211212675ad.53.1728302445801;
        Mon, 07 Oct 2024 05:00:45 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.14.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e866902csm6901381a91.41.2024.10.07.05.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:00:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/10] cleanups for PM interfaces
Message-ID: <2bfe2f26-6462-62ac-b5ff-6b909efc7316@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2024 12:00:43 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11214210776

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d1dbc083fdf5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D896160


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
