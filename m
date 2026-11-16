Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800666;
	b=IeJUhc3EXyGW23GbSyTwLTQueB96NVCkMzXUi62PoAb7Q4C7bSKIoEg1t/PCUXNQR9nr
	 Vk8xPih504YJYeDpDMt7uSZ22/pUa0VwRH18/rOqmycviwSv0O6gP6kv3BK1dG+mmH7jY
	 t/QISbKuJOFCBaLx0o/LqOs68gEAhswL43FF0vyAh46bEtnDattANd4F5quBKEU5uq5XC
	 tuSvhHNsl+jHc1wmzOD1eYQttQ7qEG14vSCSljt4PgeU6cQllzGRXMlXhWhgToQhCBmtS
	 ejdY5SqFKWECLPu9m1FkR3sYIDbWFhqz35HZrFbyqypAXqVkV1Aq8JT1UOI15CmMeNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800666;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WKt6wY/4/6TAegX6lJPbYhWN/+FeGreQ8O/+GYBquk0=;
	b=QF5y2kckTnbIMosVzIjM4epUb4FeEi+LAfio8gaZQ8nUahK63IR1SysYi70shjyPDNan
	 Y/fgY+ZW1Z/AuP0ymMRPSUfhgmqOHbmNoGtlh3fYt+rl/Yw6zElQJdMTYHL4CP2v74SVl
	 000jHBz3ens6Yk6GEzPp7wSqyZoTbz4ZfmR1+CQO9WEBXEgafsjLFKvupLqZ/ZeX4tkU2
	 BnC5LYOO11zZeEz13Z+SZNpQtBq+GoMESwn29ODP5swU9KOYwCX/hqdnpyA9M1L3+TOk0
	 78wE2j1sVx0DX2n8o8Ay47T4pdTsTS3Eua+iKEAtpgO/LqHB8A0WsIuW9PcE8E4pQYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EE/7c3/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00999606A329
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE/7c3/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718151F000C5;
	Mon, 16 Nov 2026 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800665;
	bh=WKt6wY/4/6TAegX6lJPbYhWN/+FeGreQ8O/+GYBquk0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EE/7c3/DQJukJ/enDqxv/fGq6Zjp7mkOJgox4kDeQ1t7VZdHvB0dkyjolu26UUP7P
	 KtDftHkIogfwffIeIlg/dTwSjyYuJ0dw36m8y0Skn7SiWmr6ui6WLGCIUw6aJve2xg
	 AC4fH0ucd9Mo4JHgTTY+hL9SjQLoRbpWtOijeWvVfkq0v79D/NrJWvqbrgLGDdvhl5
	 fvpfApz3/xHLyuaf3467ZjM7NcSdoYKWxWwfKzLm4AShQhsgWD77nZ5bOYZVdhW78j
	 TCBA+bHRWSTRs0aa8O0sEmVvqAwOBvFRwok6pxe5SpzeAJsYqSJ2o+nl6VGBbixtIA
	 7cEbopQ38v8ww==
Subject: Re: [PATCH mptcp-next v27 1/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:24 +0000
Message-ID: <179480066494.3133.6783069014755032087@kernel.org>
In-Reply-To: <0d1bfee6213106144f29abe96298b691ec01ec68.1794663678.git.tanggeliang@kylinos.cn>
References: <0d1bfee6213106144f29abe96298b691ec01ec68.1794663678.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit author (`From: Geliang Tang <geliang@kernel.org>`)
  does not match the author's `Signed-off-by` address (`Signed-off-by:…

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() (bytes_received - bytes_consumed) instead of ack_seq
minus the head skb's map_seq. On passive TFO connections the old formula
returned INT_MAX, which broke SIOCINQ/FIONREAD, TCP_CM_INQ and receive
buffer autotuning. The EOF hint of 1 is kept for the empty-queue case when
the socket is closed or shut down.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the author's sign-off address
are different. The author is geliang@kernel.org, and the only sign-off from
Geliang Tang uses tanggeliang@kylinos.cn.

No Signed-off-by line carries the geliang@kernel.org address. Because of
that, checkpatch.pl will warn with FROM_SIGN_OFF_MISMATCH ("From:/Signed-off-by:
email address mismatch"), and the netdev patchwork checks will flag it.

Could a Signed-off-by be added for geliang@kernel.org? Alternatively, the
author could be changed to the kylinos.cn address so the two match.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn
