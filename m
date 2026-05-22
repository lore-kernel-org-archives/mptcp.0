Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7B3D3302
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447047; cv=none; b=fTvMdCWvxbrRt61IWz85P9OhYks3FGehSmdpW3rQVTzgtHfsUuDa+B4JAGM+EUlb2w5WrNZhvnkZk+3/dgUPw/+I23Y8x3F+OzGRQU3pcBMMcbwwDDAoMsX4e6aGJkc2n4ZxkjNHcGt8sQepjZj0Dmmn8w3qdAnifSEGu6yOY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447047; c=relaxed/simple;
	bh=IlSUmH7BRucVs+2hFij54WaaDXaB1vrr3/0cZ2Ct1p4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=W9QqG0IE7mw+A+BwWCKU/Nj+/MiQgPPTLafMIUxagiIfvC8+hZK7gZU9k9Kn5MuEwzXc+axXSdxppCycHMf5ZBTv8FCZLU8b5eUpcl06+ofcFVtlYch6eyc42Vhr5iKMdI/OAVKMCcWIL6e2n12Eq6mApyM5P4s6ecyTPxEtAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkmcdIot; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkmcdIot"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3044857f09aso1435548eec.1
        for <mptcp@lists.linux.dev>; Fri, 22 May 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779447045; x=1780051845; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwNBxAsY2O6QyW4ri6aPCcHKQ97amyh6fpzG4C+Zi6Q=;
        b=GkmcdIot9SAZkfp5Ya3hQzWspFSUHH+E0gC8f7WuK6k/b7CuwPzIVz/rYc8WTPmBIe
         PDN9SVtSHJgrMZLQ3E1EZnIQRpWYJpdUa1cth5lxVn+ylIsN1Yx/ev0Tlbe+FIkmN3eh
         oKobUBKIKl8NljprVljtS++4yhU4JTVyEgf/shp9JxwLiE/ZOdy2JlEHK4H/38HDsvyp
         ODoQWJrZZcPJbD7eCkyfoYD8YjHSJmVPTb6/5AbBXatq3t75nYHN/fLgDFh8DWtWM7RV
         lVzzKS/n1FBefAm+Mt2Tqm6kB8W1ep0VSIkJSnY15qF1NZw9UmheOcHhSNhqsnKfl+2p
         x1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447045; x=1780051845;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwNBxAsY2O6QyW4ri6aPCcHKQ97amyh6fpzG4C+Zi6Q=;
        b=rE/RTObxoFmEqyaJu99OhnFRUsFnKjuY4WjMBC4YG4Y1h3XqD5VY7GjU7MJxHmPV6m
         uGMvCUEBOiuE0yqS5tZIwwjXhCBbLajw72+mJfO4xu/o52mf4ygAPGJcyBzLKzMXVxSP
         7EECCZjfI9T8V1oXU+wRClh+1TGg2oLDkfHE+oV2RkZHjXd+v4IbIOCzSrdUWvvdeZ9u
         soNaDpll68hD+WzRNleD7YnPwWBlUqDC5JXjoL7sFnDQQK5GbChSLvMqqo6RXv8WHk9j
         jnVf9a+8xrySo/jgks5zk/5GXRS4KGLfB9OyB5ZR6dEuY1kKt0Iwj30Q4Yb8ENwHK1oi
         kAkQ==
X-Gm-Message-State: AOJu0YxiqlxxNtOydb+AVqZo69/rtCAUCM+XB+1F89F/2Jmg74/4Z/Q0
	qaLC3BsrkcTMnywJnvsOPlKkUaXvm+u5yRkZJQp/hRlUQvzQQUZzZC4q91we
X-Gm-Gg: Acq92OHIjoR2MoDcPyFd1k+r9GqQqXLB0MvUxyegdFEVCHh/K3v39VDDthX1FjopZS8
	MbQMbdHzmEucgPDb1QXgLzivH2b8/yv4oAODA5vU6DUx/Ou7Ffw2HefNbTYFV0v5C1sPyCjPTLV
	IZ2497GQLH9L3GbrRFzMzdI8tO0u/vRWGk+XW9Y9DJqSpv5kZP2KAAEUQ/qToG9Z1YsbPqMh81W
	qRnOftf7JwIgrIOGvRTDCV8p9eb0u+DW/PqaaCxiKjdyrRsduQ6fhgW+Thu84ZcXiDZfd9x6d7S
	aJie1Y8VX89H/87taEEuaSWRgSzjaGkGIRe69XEE+PEiTiP2k8c7WS3iBTTpbR7SGvS1XB5ro/Y
	WY7w4Ov1EOSJ1cki5NvJ8pqQ3ZsoFE0G9yp9AAjOtC2kWVJ3IrI3VguhNl/Nemxh6r0AEnAVKVL
	LBZS+8xiRuTSS7gkAiJJgqDv06RoCVNAs8obJ6AhQ=
X-Received: by 2002:a05:7301:e21:b0:303:f2dc:8ab4 with SMTP id 5a478bee46e88-30448f30810mr1632825eec.2.1779447045199;
        Fri, 22 May 2026 03:50:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045223103bsm746243eec.16.2026.05.22.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:50:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/6] mptcp: convert to sockopt_lock_sock
Message-ID: <6cfa46e1-2792-a3bd-2327-b42d3865b89e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 10:50:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26280262996

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a95f90e437ae
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1099233


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
