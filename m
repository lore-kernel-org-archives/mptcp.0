Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F09330B30;
	Fri, 14 Aug 2026 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746097; cv=none; b=BmGeKcMuTaaLe32EaLhL/vxHhE7ClbKcu/zmUujTCJtNaKbAo3C8v6hxf5XEomWNgkzypBsZAWb6ivVpMr/TYpPdl7I0ih5lo7uOpaZmzCJy23LzFvmXjSkbpLNC2zJIDFo8ylDrRoKtaZBxn+6hDKLrmL8YfiuzuVrJzU+uLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746097; c=relaxed/simple;
	bh=tCQ4PNzLmAGrmZIrmzJuoExL85TvaHVSD7oxsnQvBNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGxysN0/AlsDYrCNZVq0z0scgDxyTKDWz1gyerupEJxqsAKEFGI2QC4xGGd0dSqK133/7A+zmdZcBI3sI3vnymyfb3r3uUmYQaUwuL73W5ywOidvgILNfp8gjvjQgqrsgV0pZqeevLckuNIj9ybGZPBwNp5vDDT0ly0EglGcozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAnkxS84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAnkxS84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E941F000E9;
	Fri, 14 Aug 2026 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746096;
	bh=44n4rDZVdfXt3y2cJYpgTidsC0pNUuMsU/QAeyEupkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hAnkxS84QNeiPV6EmTAJkCJh7W0BA/Brf7t0liyqLXVzmT61WdMo7BWtdt0g0jgc5
	 F8WEzCCIYy2dBjVeLWlasjq4S+ytYAUO2sgWqS5pkcA8i3aCMxaXtNFnIXVIoE0e/W
	 8Smjw9RIVH8uwCJqhj8gRaXwL9FYcXc/W1QEbXDyjzxKSjnzJcgd0RB2l39ESBuRRZ
	 UqDa19SbxSKYjB43jqY9X8T16HlIQ/Cv+OGYoPYAdpQPPjx7tOCRUveNkefXN47Fgd
	 VP+hy7bIjTPSTL1M9l7V/HP1sX5kkjgSA+s062WJLTcaR/f4ASIcNMlqIt6wUoG6y3
	 To+EpTJWsbtsQ==
Message-ID: <fc1945ea-e63c-40f7-b8e3-6fef832cc595@kernel.org>
Date: Sat, 15 Aug 2026 00:21:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 00/11] mptcp: misc. features for v7.3
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Jiangshan Yi <yijiangshan@kylinos.cn>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 12/08/2026 16:55, Matthieu Baerts (NGI0) wrote:
> This series contains a few independent new features, and small fixes for
> net-next:

I checked Sashiko [1] and Clashiko [2] reviews, and here below is a
brief summary. TL;DR: I don't think a v2 is needed, and follow-up
patches fixing pre-existing issues will be sent separately.

[1]
https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org
[2]
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org
> - Patch 1: Add WARN_ON_ONCE guards around extra_subflows to catch issues
>   with this counter, similar to what is done with other PM counters.

Pre-existing issues: fixes will be sent to net.

> - Patches 2-3: Follow-up patches to remove data_ack field from struct
>   mptcp_ext -- now unused after recent fixes -- and makes a userspace PM
>   helper static.

Pre-existing issue: a fix will be sent to net.

> - Patch 4: Honour tcp_rto_{min_us,max_ms} sysctls for MPTCP-level
>   retransmit timers like with DATA_FIN's and fallback timeout.

Not needed: suggesting adding extra checks if the TCP RTO max and min
sysctl are misconfigured (min > max). There is already a check in the
code to avoid a division by 0. The rest is similar to TCP.

> - Patches 5-6: Add per-event MIB counters for MPTCP_RST_EMPTCP resets to
>   help to spot such situations in production.

Patch 5: some imprecisions in the commit message, not worth a respin I
think. Plus a suggestion of adding an extra increment, but it is for a
different case, so no.

Patch 6: no need to handle the only test where the server initiates the
subflow → the goal is to check that globally these counters are not
unexpetedly incremented. Maybe MPJoinNotEstablished could be checked on
the other side as well, but this shouldn't happen with the current
selftests, and this addition can come in a follow-up patch.

> - Patches 7-9: Small pcap-related improvements in the selftests.

Patch 7: no need to differenciate the mptcp_connect_*.sh which are only
there for the CI. Someone doing the debugging and asking for pcaps will
use mptcp_connect.sh

> - Patch 10: Fix compiler warning in the selftests.

pre-existing, and not really an issue: the selftests don't try to trick
mptcp_connect

> - Patch 11: Avoid a buffer overflow when misusing the mptcp_diag tool
>   from the selftests.

Small typo in the commit message, not worth a respin I think. Plus yes
it is a fix, but not worth being backported: can be a bug when this tool
designed for the selftest is used manually with a wrong address (which
is written in the commit message). Plus pre-existing issues that are not
worth fixing in a follow-up patch for this selftest tool.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

