Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA91E515
	for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126110; cv=none; b=NVXS14XcE56xdthRM461H3fpuHuNrJF4xfqW7q9vGjexdMOHY1QfGkXeO1gDT5/3Fe7Akwqjc9A/zoPW+fUq1CP89ihqxixMfmpe2tvnhWAMgarga228jCi6UWQWmSHwzAi5S1QKwfWuv5CsU7GxK16YWjHZ8SLG/zkN3bDJ+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126110; c=relaxed/simple;
	bh=Y62IHU4iy367fY3NtN/9x7F8Fa1pJOtm/to+5Voa5aA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y82BONPhPbVjGkE91YInJyEQJmqmAM6O6zXaAPy2Y1ALBSzU6koDN1/NheWl7oFaOE9rPg4UGf6VUm06dV1/5zAKpSoWB56oE9B4U9IoNAzgAILsQNhAzNpCOqi7NgSfgEeZYX5l316RL+8nXEwbGGtBwiWgwdwkyFZJCo3ENFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0IpVGH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0IpVGH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3C8C4CECD;
	Wed, 20 Nov 2024 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732126110;
	bh=Y62IHU4iy367fY3NtN/9x7F8Fa1pJOtm/to+5Voa5aA=;
	h=Date:To:Cc:From:Subject:From;
	b=t0IpVGH8iTdHa7lO+Zmksd1EpPyF9QGuP3O8a1xwsDQVdqxrfpMKO+gffUlX1CVuf
	 aMXArH8xtGoU3gyx34fpCHECJM93nTXcRShlYH+CVs46Med3QObGJypcn/H2qUnZi8
	 6AbWz18JU1MeKREJ5CU8H6qqBx6ftetXe0LH5NUQ1oQH4TdbPIS7RvNsc8HGTFhI3P
	 viW6oA3yyFFXQRIzDOCTFIEkZ+k/B+dF+ffN/pkmV4BHADykEhVJ35ah+yEmSDEMdg
	 MTV4t5AR9fMnt93A51o/WXL1vluCrgCV2PKrwFcZ4dXblw4tZSCCMpU8URX4TbANef
	 nJaQARJHrfE5g==
Message-ID: <31aee33c-386e-4270-9a08-f12668f8970b@kernel.org>
Date: Wed, 20 Nov 2024 19:08:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Subject: CI: new actions in case of timeout
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

As discussed at the last meeting, I recently modified the CI to get more
debug info before stopping the VM after a timeout.

This was necessary, because, in this cycle, we had a few jobs ([1] [2]
[3] etc.) that got blocked, and no more details were available. I don't
think that was directly caused by MPTCP, or the tests, but still, it
sounds better to extract some debug info when this happens.

In short, there is now a background script running inside the test VM
that will wait, and then run:

  echo w > /proc/sysrq-trigger
  echo d > /proc/sysrq-trigger
  echo l > /proc/sysrq-trigger
  echo t > /proc/sysrq-trigger

Doc: https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html

CI:
https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/commit/ba46718

WDYT?

- Will this work? (background script inside the test VM)
- Or do I need to access another tty, or the QEmu console, etc.?
- sysrq-t can trigger a lot of info, maybe too much and cause other issues?
- Any other interesting sysrq that I missed?
- Or something else to get?

(To test locally with the virtme image, you need to set the
INPUT_EXPECT_TIMEOUT env var to a value above 60)

[1]
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11834706526/job/32975942269
[2]
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11802728376/job/32879029307
[3]
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11473893644/job/31928844677#step:7:5346

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

