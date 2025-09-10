Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981919E97A
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528254; cv=none; b=rljPEPoPP1ubB1WaJcp6s+V8YoFx4TeV0uaszVcff2dcgq8XQkTkVoB6iRKokOtpJvMJQ+CImMdaIfn47YLU+4NeFxJzJTX1XZ63ZwbuvWeUwmH49xdNEHloohk1P4vLo8J1f/nsxkgjFZAtbZ4ZGYXZ1gRwZvwYojUj0CDH5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528254; c=relaxed/simple;
	bh=r7eLh1TCjLodVnZfBwVfuIE8EK3Z8/QX1Ya2AAsf37Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RuCqb2saxuiqhfnt94k5xe6N+kg1993AwFkFQqQZhzC0fCPA1sbL0SqRchKAgMsVOeenRKT7JedUK1LOtbIldC0W/q12gwf5IzYl8ZBhXsezTdDFyTgenbvr6+J9YkJORUsJL+9zkdVZR48D28vvMJ+e983NRl2c8BYTl9MR7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7qedTzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7qedTzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCDC4CEEB;
	Wed, 10 Sep 2025 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528253;
	bh=r7eLh1TCjLodVnZfBwVfuIE8EK3Z8/QX1Ya2AAsf37Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c7qedTzKv2ymDCiA0qF9iQL8oZ9fwmJsaEHmyW2+e9eT8yyxsOuBdwAKJ8zeqrVmn
	 xNCv/qUi/KZAMt5A7gvUPbaYfY0Jq7ThP4mhuh35m3w/dSElFJDghLglzHFS/MQSBi
	 ojoN2NIgI9qIpnT/fW6v0EQPTfxB+HFXSCE9R4hpX8ntiY3IjUdI+kdk6tJhKLiELC
	 hmTKDAlhYen+nJUp5z3mU0buqHmN9jw1IfeV/8S60nfkf0MwYLmE0PhnatNJe60Pru
	 QNikDRyyM7HcCFAx26HzU1yefy9AeVli6XcWrYCI/qSu13/IENWKCjKmO3Fz0e+ZN6
	 3s43e41mBjJWg==
Date: Wed, 10 Sep 2025 11:17:32 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    Donald Hunter <donald.hunter@gmail.com>, 
    Marek Majkowski <marek@cloudflare.com>
Subject: Re: [PATCH mptcp-net v2 0/5] mptcp: pm: nl: announce deny-join-id0
 attribute
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
Message-ID: <ced8a24b-14ed-745a-13e2-b0b805116863@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 9 Sep 2025, Matthieu Baerts (NGI0) wrote:

> During the connection establishment, a peer can tell the other one that
> it cannot establish new subflows to the initial IP address and port by
> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
> anycast IP address for example.
>
> When this 'C' flag is set, the path-managers must then not try to
> establish new subflows to the other peer's initial IP address and port.
> The in-kernel PM has access to this info, but the userspace PM didn't,
> not letting the userspace daemon able to respect the RFC8684.
>
> Here are a few fixes related to this 'C' flag (aka 'deny-join-id0'):
>
> - Patch 1: fix a small typo in if-idx type. A fix for v5.10.
>
> - Patch 2: add remote_deny_join_id0 info on passive connections. A fix
>  for v5.14.
>
> - Patch 3: let the userspace PM daemon know about the deny_join_id0
>  attribute, so when set, it can avoid creating new subflows to the
>  initial IP address and port. A fix for v5.19.
>
> - Patch 4: a validation for the previous commit.
>
> - Patch 5: record the deny_join_id0 info when TFO is used. A fix for
>  v6.2.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Former patches 4-6 have been already applied
> - Former patch 2 has been dropped (Christoph)
> - Patch 1 is new, not linked to deny-join-id0
> - Patch 3 replaces former patch 2, and was linked to former patch 7, but
>  now using 'flags' instead of a new dedicated attribute (Mat)
> - Notes: changes for net-next, and the deprecation of server-flags will
>  be part of another series.
> - Link to v1: https://lore.kernel.org/r/20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org
>

Hi Matthieu -

v2 full series LGTM, thanks for reworking to use the existing 'flags' 
attribute. Agree with the plans for net-next and deprecation of 
server-flags.

Reviewed-by: Mat Martineau <martineau@kernel.org>


> ---
> Matthieu Baerts (NGI0) (5):
>      mptcp: pm: netlink: fix if-idx type
>      mptcp: set remote_deny_join_id0 on SYN recv
>      mptcp: pm: nl: announce deny-join-id0 flag
>      selftests: mptcp: userspace pm: validate deny-join-id0 flag
>      mptcp: tfo: record 'deny join id0' info
>
> Documentation/netlink/specs/mptcp_pm.yaml         |  4 ++--
> include/uapi/linux/mptcp.h                        |  2 ++
> include/uapi/linux/mptcp_pm.h                     |  4 ++--
> net/mptcp/options.c                               |  6 +++---
> net/mptcp/pm_netlink.c                            |  9 ++++++++-
> net/mptcp/subflow.c                               |  4 ++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
> tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
> 8 files changed, 39 insertions(+), 11 deletions(-)
> ---
> base-commit: 12e66f7051b4b535a990cd20c149d76a98ec68c3
> change-id: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
