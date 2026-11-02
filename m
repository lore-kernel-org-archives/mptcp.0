Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645723;
	b=0aL6KqXn0xYxJfFrp+7ja63oAs38aC2l8Cvo3VaHWsm0sHiKKmElLu1rb/0L/KRn9lSe
	 spzBj/YsNRWoV4+loHXAxnwdWjVHbgr1LPNsCGCzdTENwlWryA90KFQ4lt9wvvPrfrYKl
	 BrbW3+QMf8ISjrDpuX157V3cp8kBbaDLjaQskoGSLPwWKKMgF1fLBOdhefkFvXsLShAWR
	 sJdsPMaRTDlz2ejqFSHWhMhXZw0s4w1FZwa/IE4uJodV0BGmJ5EDGoAmG3Hc0wUOTk2Cq
	 Ie6nqM9d6oyoPmVT/Z/i/kQisBY5Q/Q4J0Gdee7xqHN1uzJn2ozF9mTc8LgUAZGRSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=jXgdxgZW3NnuPU9D4V+upsxH1fMo94PDUzgnUW34sDY=;
	b=SuqtBz/1PlCgpSkISkIcDHaMc0nBkOrsLJxg6M1qpxo2yMlxITGh7HTqajY9QlZtQPv3
	 /Sokp9OAefytQEIyaPG9wMbdxnYdS1eQTft3Amc0SQQS50NsuVkqNvs01/EXVAok+zgkC
	 99dV7WUjIYbpmJxfODaFe1ioSKUEo9obyChC8BsJv5lw+CXJ0/OcXX9bCg3csFMwiv9U2
	 TySO4sv6eb3s37hb6WjswFhRErsU3DmTm3GYVjvWyK6cYsZDNkAT5tmuz6UENw1WmIINL
	 zbdOAQE77HIBUz/+Bro5D4jXpi2vVs+39+VnPhrrUBzcNKq5N8xH9OrmU4caRg3tcJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D55CGCSm;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66236606A33E
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66236606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D55CGCSm
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de2f213b7aso1448014eaf.0
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645722; x=1794250522; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jXgdxgZW3NnuPU9D4V+upsxH1fMo94PDUzgnUW34sDY=;
        b=D55CGCSmfoiBXqapSY6KS6KldU5IW/elpqOc8/J6EEAvBiV2y0tOvBhs/PZJn6s1Jq
         VzhDpCMnrjuQKTN/hoxlw9AWLrDTX5QKM1Vzx5fDqsJS77DEFB4J6VKUpZnZ2vkd7L4I
         cJTFKuZqMs7VR2WI8wQ28iHnNzAGL++r/5o0TAiKe1TdguVir2OZm/e0BDU0oc2hoJLX
         RQU8J2O82u6NPmJ56D/r1S4doKTfGWUMCAfzrVTRUQYrfM1lj4G7Cw0yrL2KtmJ+6HBS
         hg0XZ//VzD2kKy06wVUM0TpUq0OfYkQIljhhSStZ2pUJduipyWkpQhsfxBkHsvtbNJXj
         B6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645722; x=1794250522;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jXgdxgZW3NnuPU9D4V+upsxH1fMo94PDUzgnUW34sDY=;
        b=esv37U6IEj1lCvODH4CKD9posHBqIXfV9uwX2ocZgVKqOZExMxnqpkhdwbKWKoK8if
         WvhfIqN+aqtKsCiO1T8ZU0YYc3Z49yKBkEz64LtBbGsRPVpRMjm6rp+zPrF5Tmeom/q+
         eJ6myWzXKQXdxsk9A9m8VVo388XakVIsHUS9Sir03izWV2J4m+q5h3bpHBwu3qQlySmV
         IFFzbjXfwP7Z/UDW1JzubID0pGL6lfF/4Y49oXB5kz+oLcwdJvuSIPIFPwC5vbKFc4e8
         gm6ucidDr3ZjCj0rU0BcFKY8wD1kTvmiBGMXL9L9WWhUIbmgc6KBz7v5no5x5c7X3N8p
         21Ow==
X-Gm-Message-State: AFq9FYK0Jr+aUIAzlHEWgf3AIq1jjBaa9/DZKE0FScSzSzWaVFuLwf6V
	7BvEhEFvR8V6uXQIxDMsjzkIhmCwKVzocW0tcLoJzIpMz++DFtfJkMo=
X-Gm-Gg: AYBFou3pg0Vm55ALKt3vj72QcToBeX1PjUFUie19Evc00k4Q+5UPnh68IJk1HxBU6Wy
	AujVdQfvtPYEasWnwAxtPQIIH48EADerNsy5sCNw6WgoNgro/tj3+dci2/91+RP/A6tK728FmC/
	m0o7zeJm8LU9XB2p2I0ks4zDKGMKTMjzTrNy2vrQdTFa9A00ZjnR0xGCRAR29iJLoYrgVNXA06+
	DdwWkTNbuai8mDNjlF0YC1qV+WDbuZHpL5IEP3OVw8LjQuqshWgDbCHtEEDGwpY3W9h1xHLipFj
	mOcxPUsLcfeUxlosru536fHVTkckudbEE64MYjJQ6g/kthI15mc7rn8wbsHix/FQzoLYnBNw5Nv
	c5xIqMSPyx6/DyBEEeO+STDSwEVtV8TTI6DZfsvzmOU1XPTb1JPB5jay3MdwfbWeNhYfZv3MBWG
	GKtdGBeOqVKvoY/x9Ufxr4sRckBz30kFIavpM/fZZYTzF0b6X2Pma959rsdtjGbTWq3swAxnwFU
	WEfcwDgAlM5qTMNAo2TjB3YuzpTzO4j0Cr6OscSUD35XNhCfG2YJ7frPmdrffCrIxMw4gy4xlVh
	gTTeD+HppgjB0B4SOW8zWPnoaU3ynF2LRWpcReVmgxC/
X-Received: by 2002:a05:6820:3401:20b0:70e:2878:8d7f with SMTP id 006d021491bc7-714f2ae690bmr4148883eaf.90.1793645722333;
        Mon, 02 Nov 2026 10:55:22 -0800 (PST)
Received: from github.com ([52.165.251.240])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a80881sm7847472fac.17.2026.11.02.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:55:21 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
References:
 <20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22bpf=3A_Add_mptcp=5Fsubflow_bpf=5Fiter?= =?UTF-8?Q?=22?=
Message-ID: <541c3ce7-6d2f-db7a-1735-64746badfef1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:55:20 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): error:sched-weak-secondary =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/41489872178

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b0837827f3=
d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1199267


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
