Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179931;
	b=pf0Wvy/17v6lqqphtY89CTNWC7KWlihKFJE9kVTGR8gNFp9MdJC3HBnYewI0KnF2vUoh
	 LUGTc1L8SYX2TMHSWHiRcxwq6orUsCUbN2jGoNI2944fY6krSW5qnfHwTCOGut9lijCWr
	 ESi8HXCBSq2ThfnaCUupaDhkEYuqJ4TIj3BM6eYTvecwgZigaiDsAtyZMkbGwbSmHGw7u
	 ptBkyhh8FNfiTGN3T/IloX1XLisIIERUCQk/3lLQnH4vt3N4SM95fBXclI7nb+CjR0VjD
	 7PDdxIqu4dyVfLJyOFaZ8NOrV3xkzG5a/2X279sQFp5/2XkBQCr61pJ6N3QUTxThVdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=cg7dVXrQM8cT3Wg6VKqFfkAjgPksddaVzYQ8+kbFF+E=;
	b=m1G5KQgy6AHyer5y4Qtcf6bjCQa7MT9IAy3X3/RLoE7v2H339PNyzyVznAz5yHUkDrYj
	 cj3qTI2X1ys2YcsVLbUVjehSWZKqVdW5cvtzx5K+Wzr2ZzYDwL4ujCpzwcTZAe3OFwuk2
	 iwtAxJAOHUv9pgFfzRjqokJwe9OyFXJ1JKeCBFkao1TUkIHGOU0rxhgcNdfyyesleYQvu
	 4BxIJSv93mzxUktWq25PNB7CRMFZc/qN03VJyNxa58tSLvdersREoYOtOzwPdiO2Dw7Um
	 vdn9koUO61RNr6tkZNjyRgH58UVg+e4uCCGHQpdB/lBwU7Nco6HOqOgx3DQFF9w7A7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVghYpns;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E9606A31C
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 09:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVghYpns
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e635220b4so62439085a.1
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793179930; x=1793784730; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cg7dVXrQM8cT3Wg6VKqFfkAjgPksddaVzYQ8+kbFF+E=;
        b=fVghYpnswlyM4+9JJVgCgYkH2zZe36klZ+w70D5eOIn4BnrgTdl1PSBgXGL8lG/1Sn
         KxXXKzw2E3787dW1KUkd8miD5Yu9iPxBQPNGmqSTLCLaAMyHJmsUt6/M5ma2vNx/QNDG
         dSMjwCciKI40B8dsncZlB0fOFzxa7RXOVQpqzQ//lrLSeX70tvV/7zitc7/Q0sTe4Dpo
         KlwdVKfjbkI4gR61FIsqseMmd7BOyJ1U6qYUB1b+bVdaM/M9XOGdL+NyzsaZ+X2RTVLs
         4orL5SsZdvwTpFpl8AgiH/4RNqgmtLduzi0SCJS/OJ3lMfJDWkymz2Z9GoAkgEcnvKj0
         LQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179930; x=1793784730;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cg7dVXrQM8cT3Wg6VKqFfkAjgPksddaVzYQ8+kbFF+E=;
        b=j92XTaffefLUR11rhZn1E200NcA17ijH6T1HW24FSYCE9gY976g/2CFkcfHbIp+xqo
         ocU+xPBmfdmrVqHmqiNLIvPIh2Jq+QNioDkz3O22Zqb1/UA5OsdKoKrrBkpOVgy4SXpN
         fc0CNh3TQZ7mSUZ3HG/LwHNIgr+6H80Ef/lwgRgwpWElk7abICE8Mml8z+m97amDPRQZ
         OBlS1pjvjX6u1MuAz6/+sHXs249PQ3Uhn3MmPvRk2TvilTUHe/ltVi5efTnbEBmblQ2/
         Y7O49k3ujKFmVCDMq8WkUTxkspRzaQRSCIr54rwW3bvwmd0l6+LI1msAap20Nw3ohsb5
         jzkg==
X-Gm-Message-State: AFq9FYK3eUYkH3TDpfahiajXnS3ae7sk2zjP/k6cbOZeNQGgQyhP6cOX
	qTJBt5oJiN65zs+xDsCf3fHwvdnFRx+BaGpPfPgdIefy0nDBU/kTJ9vBwNEF
X-Gm-Gg: AYBFou1DeBRfyB79yIqvzezYJDjdjBfRDX+oaEYH9D423paBVW/hRW8nAJL/BvZGVGX
	AQAVlbjps3nWr9WaeiKXcwEmzG5L/GyKW7tzJUE4Xxc1mt1oixWm4HreYE0coJilLUFedWws3gr
	whGg4HXYZDjobahJwVTjL15GTsAfap1DI3f5+Or8XSkPI++UOFwzMy3qJn5Blwlw/uDVuh63au9
	YpXu0PeDYRRi2BsDuNLrXEqrlREIi5hmDJgYK8AXTkFWGs6BVYCItpdxJFKovuf65sXSjQVj1UK
	qbPqHDR3CjaCvfpPUefBhi4OOUvXKU1iGF5NT4NoF6L8UZYs1N/ci4oADzkJzObPevoPk1n6cQN
	hK5FjoyJEGmRog6MpfzS1dQIWcjQHJCgKO19H6FWqh4VJS8UHZCUI6wc7eg/pZN1fDeUZbNDzti
	bgbgDfiy48bLiMR+tfvz1hb4UkqmVb8SBBYFwd6/13wk3UUeVbOREhMPE+mO3FnxvYKIO+UXje+
	qZDztiM4b8oACQ1c6XRn7SjYNqBRzk6/VS8tm/B1eJBBucBF1IL8Hsn8nV4pSGx9wGjqBmDJxcG
	ZOru/Ahv51vssuqqTMHRJM8hEeazj/vRdTQgWJYvqg8/5T0bMzX8CNobJTerNIw=
X-Received: by 2002:a05:620a:460f:b0:93e:53fd:4139 with SMTP id af79cd13be357-944089436a6mr238593585a.9.1793179929802;
        Wed, 28 Oct 2026 02:32:09 -0700 (PDT)
Received: from github.com ([20.55.223.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f068328dsm1221199885a.23.2026.10.28.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:32:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
References: <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [RFC net-next v11 0/2] inet_diag: restrict MPTCP sequence
 counters
Message-ID: <8d2d4016-b0ea-29fc-d6ad-4165f5f44296@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:32:08 +0000
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

Hi Kalpan,

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
et-next/actions/runs/40658455981

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/af313b5e94=
2e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195245


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
