Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404F40A93E
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455618; cv=none; b=b1hK6gPmwhiHObC/WEMTa39wyMFx7Liy3lqQnCOYNXmTCL/9uifNMhI0pvpVmDQG3hZbsq946C0X1U4KAKydLKmVmU9DiDU0E7GKj9kl4JaACv/G6MkOoN0mG8ZeAZce5uEfslNinY2HhZMkt92CjOKEgVkXEXe/DdMulMwBosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455618; c=relaxed/simple;
	bh=e6Tr9bVfFq9wjisyV/V8QwWGu6JiBlBPR6aZPx85y14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZDoTwoGroSRNsSIZoLVWBErIFBk9kHm1htSXfLciFQCYlivebBKnWeUxIZo+a1qjkkaRyl7l6BWw8lsa3rcvpTE+0C7/UgIvvfQ91lRpVtWLXp+pVyUqCvpyTGo4CRJ4QBCwH67M0VLCR8nZzFUnNnHV1Pq7AmHjNzPBpbQ0b0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKS8REdu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKS8REdu"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df5e315bd1so1581120eaf.2
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455616; x=1792060416; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3sbcVIQDTOelTtX/UC9+23s47ZZAMWt+sdjx0emlGbU=;
        b=XKS8REdubeMmGuwi2oq2y16Pzd+gi2vGCJnaE5Y88nb03kNzfyD6WRga4IylOlWOJq
         1q/IrxdV/+BZHLa0ZVS1NZVq6+j/fITLuwVE7k4b/0ertY/xoepTCw1zZ7RuS8m8cI9p
         Zhukhy1+nQIRvqMy6CjvLNkwhLKbLtF00bWLsF9YwzDhurTJoPOUTQyfz0hEqi0V0cJw
         5W0CaBEgE6YJnBbduAR2f75KM32uf83zRVkx/nBkC5P+UtqJbSvWnH3FmL06QgyRlpSy
         5nlvTLt3WIF2czFv01yFy8rvPM5c+BgOaQcQh90w8AOE729708j/OmLMb7FlAcbFbQdS
         UgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455616; x=1792060416;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sbcVIQDTOelTtX/UC9+23s47ZZAMWt+sdjx0emlGbU=;
        b=rWtg5RTmFS34LznTgYza1BFs+B4LrkrVlaQBnXftsXlry5rQm/usF7wrBQAn5Jldaq
         63VtcfBZEeeQ8RdfZxymNZunABsKxYiFZqHJoaQfpyR4d3z/7GnqyMUyUsvl2rSgIJSN
         kG/sBh+EzgXc5KVcDzZoy4dAec+dApP03qOIY89T0mbGC4u8eSFBXjZ1eFsgRECkkzjw
         jhrQw+ZJCAsChAcuAv1+kvOaTb0tE2XqkhAsaKJX4zGv+qjdvgmuuTq/WL93TTlzmDwQ
         t8itKrHX+turoymW+nqSJDlnJsVJ0uQ2OhPQk4Lnotq01rImDRRm5F9qH95glCimKp3W
         XUgA==
X-Gm-Message-State: AFuF++l1Nc8bzNzXJu9XN4QATF53PJe9Vu2tHcCKnp3GuEZqGZDQHqWJ
	D0l5/VF9DRz47upk8ivl/8UTGde2O5WmwBTZlMt9IosvqhE1MUlRaTcu6/b7
X-Gm-Gg: AYBFou1p0zowCKxpNMKOvdxicVhz6cYzowYvSs6QDYayK5EOd9X4m2YK0l61ZzRTgec
	csjwYkNdy6CCc0jGCHKiqFqlGPI1RU9Y4eFq3pRMswnmAMrPPoouC5qLKatCmHg6EclBqVbPppf
	kWthyUIrfRKNa6Zpbj8Tx0wRzwi0HuZ1kVsl1rPWxIf3quN43Qq/OtMJUWgFGeOEHsf9aKSQVc5
	3bKpcw6EGzx3qT7Y/jqxKEK72P3CsKKFqCjXWoxNgkinHH3dzm7z9wikkDu8gXCRlaRY/X6hMXI
	u9if4j/y8n/IDPtvMmLHYIsvACYyzJZJ9RL61yDj7S7KKl7uPcbYYkbM5aN+ryNA9LjS96jq19Q
	0enMHcE0GKOyxvZwoRQjgZIdJEaDEEk9fjXmYZCN2h7pnCl3+/vLGxXg9+fHtfFEktbswJCa4b8
	UHGdKKl8eJwr1yRu+p3bmr28vSLHd9BeopRmihpptRmXP4EiVH/wewGU9H+1ahB09OTQ+Ypnc9Y
	DnIXi4E7jU=
X-Received: by 2002:a05:6820:a0a:b0:6d7:6278:2d60 with SMTP id 006d021491bc7-6e7a8bcfd88mr4035657eaf.55.1791455615652;
        Thu, 08 Oct 2026 03:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.29.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e78e17e7fdsm3753426eaf.0.2026.10.08.03.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:33:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008-mptcp_config-v1-1-269d05f7e6be@kylinos.cn>
References: <20261008-mptcp_config-v1-1-269d05f7e6be@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: remove unused configs
Message-ID: <33f9e262-ce47-cc7c-ab3a-6155ed2f3c05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:33:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

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
et-next/actions/runs/37758614350

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/95c1feb8aa=
98
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181492


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
