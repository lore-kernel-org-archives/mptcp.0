Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D83F65F3
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466500; cv=none; b=feZYu60AhB1AtyPfUuKPf4ZH4bCOdBrsTBSE9jkydaE8GmuYCRmlmxtJMRlX/7/fN1Rvt+ne7cg2LtYUPqPzf7cRRkf3rE8m+hLFxTtsW04x460E+vcsGatBL1M+xYU4hkq6O886HAD7NlcN4krmXXfzTah7ts25bIFOzpOyTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466500; c=relaxed/simple;
	bh=DOJDMXrCW608BmaoSkD1fMT9ERYn7bKmLV/YX6hNjNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=bY2naAFVJvlBoIE7Od1SmzI466vZvqUifJwliHy3Sabo4Z6tx6eVq4siXp+8WS+V9Im2xdtenDNzUFPF5a6fKPHUcykAROkN4BXOnqx4dBRwEYRYzoNaWjnUHoT8CRgF67M2M54GPlX8/2upkRmdQYyVBQwe0q9Ks2VE139bhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3WQG/mV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3WQG/mV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e97863425so97079211cf.0
        for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466498; x=1778071298; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiXaZCixUoqFrCLxGYfq32hYSr+0t6UZtFT7RbDYtIo=;
        b=D3WQG/mVjeULQ0nNhel47Unn6pRIcBIuyKgoRFIOHiodTLnq7XrMxB2MrbXEyRvJUW
         czLI2zGGcQuzRHt78o8c+QwgxHtuKymrosYBPJmBAAdUl59k8YVksl1X/1XvNkc/A6SI
         BsPvz1fKNmYImz7s/LuYizBk/jhzSOjY0+Kl7CUhO7Ac35009C2CGdkjzHdGVDVkLLYQ
         0j0MN/y8hau045oKKr4IwWBq9Y6V77xdwcmtDPJ6pJfthcfNS5FZ8bMeHNa1PXjq6FT1
         fEdwX6juuRJNcHkvtuBkkdr4Jr3U+68UhamQ62Vjo37xAt1WjCjm4zNPs/xvQ9U/+doO
         n6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466498; x=1778071298;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiXaZCixUoqFrCLxGYfq32hYSr+0t6UZtFT7RbDYtIo=;
        b=PTx6RdIdqPQO1rkLprfiHWMJpY3xxnHRnyuNehg2glJOZB+OjGfj3qHUfDMWNFYTm6
         ZOSAhssoNQrB7vnRsgUf1GLat2R/sdQg7hl4XMge/zW85DS9kXm9zq5O9X+wJaeeJYTs
         0AB6JVGLH8gi9MRu/QZ7gUjppoCaOXX/wa/2mOMf1kGH7BVtrPYllXi/6HcQXmhzJGqd
         sBrE/221iphqSpFd6Ys3mxLA/bbmz1XsIrmHbChevqujoy9nTJXVDnOfBKX16dDSqfqY
         3AXA0O6+VV1v+vUfAbNC3DzK9vM23K2cqVwswGydOCVLU+Phf45FT2QOohA8WtVkmOy+
         Rq1Q==
X-Gm-Message-State: AOJu0YyGimVhyS0DQSdjqyRmcPUhRkdwNUeUXUaP/bIB2gMxREua8ZXF
	17jQt9Yl3jK4RWS4XDbGzM1lkzB/rfb6VHtLjn40xjpAi3C4UYWOXtE=
X-Gm-Gg: AeBDietr7XMjVq4vMWXeE3SRF6TqLFvydgf/5GplEFP61hWc2anxy7qUo8T6+Ll8xzN
	OXrosLqemr/T5eTvOd+PavGOxqt2YuWxfOtoGPhhoDaJMtgxNZa6tAjiaeEcALByoCA8RwQ3fYH
	ZnOX6+gDqJ/4gM4G/4JU5N3hyK/nReZnyj17nH38PxJuFPaSKGrWjfYIvT9I1IT8+eGjf3yB6/s
	3YUQr+9r51DPQ/OuSBH7CBVzbdAPKSqR8RPXTR04XdsIT2EI392XE5reoGPx4zdqRwr7tqLAXUv
	4O6yFd3StM33QOq9jtipJjgtpi81MIQdfAc5fdf5PT1hTYGLHYViuTnzBGHR72kWPAa2CwivS0K
	h7HPrXCT28WDWiEUyLUOvxnU07qmuqnuQzSznvX35YGa5tMqyP4DgWX/x5yKKnSHKGA71wOZbqA
	G2VVFga0DSWMtEoJlg3XFw3QzzSS3HV8G2kPtu0KC6yXCHf38JzJQRK0HsMg==
X-Received: by 2002:ac8:5e10:0:b0:509:f36:496d with SMTP id d75a77b69052e-51018a356a1mr54297311cf.33.1777466497730;
        Wed, 29 Apr 2026 05:41:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.87.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101accd914sm19620911cf.7.2026.04.29.05.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:41:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
References:
 <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix rx timestamp corruption on
 fastopen
Message-ID: <3ad5d9c4-1a60-0dcd-7df5-08c56782d527@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 12:41:36 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25106678391

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cebd25803b46
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1087424


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
