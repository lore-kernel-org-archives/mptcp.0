Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B793603C7
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783826414; cv=none; b=iV5k/QnViEaHtDrpjJFeppGxd8Hk4PBtPN0E/XapvcnNiqmL/RgrO7v7pE+h4ycF+L7zL3E9BEz3Tq40NB6cUHTIFC/SCaO4l6OPChYzUgoU06mQzDe6hDOUJU5QV5LDNjqNpE8nc7XCWypEAmEJACj+DMKQsr6rZzTugmCWGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783826414; c=relaxed/simple;
	bh=bUYCGjCxDDpmH6OC/xvDQV+GX+6nmd81nEyTU4SeHfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=auWBFwl6dhFfpg+3bUpeNi2e8M71bdtXlj6ydf6IqLRRh5F4yL1R7TbvEiKm1Vp7aK0jaAGWsU2EooMBzSSfV8UubyX7Dv4lzDVbsbwjBaO3iyXCPnvJQFPj3WV2fxi8aMxJfU4bn31Vndp+cX27eH0ZBnBpFuJVn87MHbyAeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO8PG9eZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO8PG9eZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2065790a91.2
        for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783826413; x=1784431213; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uJGSq2WDemqkNW0yfRJPlkYJ0BxsKH7YJdVvrFQ6Kd8=;
        b=VO8PG9eZhsLCx1RarHA387Vo5OD+Zqnr+M+nhX+3W3AB7GRHI67FYFlpYKxnWZZz0s
         +sKUO8KDuBBBYCZ9UckiA3YAg1SK2EZCP+yimtUgsK3LFH0IXZKD3iVE2RMHk/97Eujs
         TQFI7fssGQ2iIdw/vlaOSPY0YK1IptoYW2tuzw44M0MQw/u5c1Xqn4MCDpkviFpOfAlG
         8DJdLmVkQjJ+YpW6eboc6xaC6RxfSmk/jJFPBrYUtr3foj5vr2nwTRTZI0kYLZn2m+jB
         /Q6LzIAP90/m7+ThWSxsBggKqPYiclqeamB4jWAhq2u+YWaf712M5gbPw7liM6co0hcy
         IOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783826413; x=1784431213;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJGSq2WDemqkNW0yfRJPlkYJ0BxsKH7YJdVvrFQ6Kd8=;
        b=nNVXF6mC7SXNyldoI+XlkFI8WfU2/GLoW4CH7K+tg0zS7OAj5IWvf3+i97BaXp/CcD
         HC4xoxn4BjbsVutwC8qbLmyr8rSM5u53LOf3UyulHTglZV0NPwqMjShsN4bViiTX94n3
         O6veP1Xc1+spk7lmWao1OM3gav/0vcqbJmSr3UMbf3AnVGBaPFWpSCqP5N7cGXZyelMP
         JXKsEbENJTm4SkUd/FWtoWASrjE5imShzZK4VexxyDQZ7+1ADy2Otbnx0Uylt5HeCwlx
         4Tfm+bzJw30w5Z3ohRmcvX8IPg27OPj5oL4NU7ukmWfeMMz5AVSK+YbdEWVpvjAq+yAB
         Ib9w==
X-Gm-Message-State: AOJu0YznNJU5d7zwRs4bFlzO9qmD7eiHar0527pYJ0aUSHUCs3s7RPB9
	QJNl6cuo6indmJ8m3EqZBV/esibyX/mdrUAKxv1MP71P6Frbp0ipPkscT/8nQjw=
X-Gm-Gg: AfdE7cnIHhSqT9O8YLp74zr4EwMK+0/OOn/Jxbt4sNvX3FfNbfLQU8lp7rTTcCYjoqs
	JABpQJIPREH8Xi88m7JcUYhn+BKdpE0nN9NC9h5NWIekAXRsOS1yqjzjCzXo688pozD/lL6akVq
	eohvjUnyxDrMiceQqd7apf+4+37H3up6WoonqDRdwA6l0eltUx/oOhTKae0FOf3SPJH6KZdZXHG
	u0ns67rDV1rFQzpUKqlywDG0IOlpPUJZLO3rTOz8Y/lEXA0oGOJk4OP5BTjHtcEDfy88MbPzwXy
	UEom8gse5YuzPUbJM4GF3Hk90uP+TYf5ZS8ai1LiCwXPFEZdDVuVuFhl7zCPKBs/L/qje5AAAj6
	2IkTisvI+8axPEDbzkKcBtgZK/cd5O3sHXGhy+46ZlBvIHKgkiysA0nHqOIiVbxHxZgFufkJOao
	spfJUS1YUrrXS3zPOwLB+enTf4ffUa
X-Received: by 2002:a17:90b:28d0:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-38dc75d1e58mr4470508a91.14.1783826412821;
        Sat, 11 Jul 2026 20:20:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.135.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313af819732sm24010581eec.16.2026.07.11.20.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 20:20:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783821830.git.tanggeliang@kylinos.cn>
References: <cover.1783821830.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/5] mptcp: add MSG_ZEROCOPY support
Message-ID: <ee633403-0b0c-24bf-6d25-412e57641dd7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 03:20:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/291769=
00092

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0823ba4cf786
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1125980


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
