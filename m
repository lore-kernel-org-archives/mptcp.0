Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108523;
	b=U6SaQpKhtxt4tlfDSn54AcXK3TZOwA2qqqmNa6cGKYtXCxZI4OJLUmjXKicHMgCw7483
	 AXUal/7WiURZsB5WmslpRy8YhtSFIBRWAwKaGmraSiUWVcHNHJJ3tbsPQioEwUtifm3zr
	 sNypdtDjE92JgDpQdtHdp0nwqgIjKrjA0kTzAxXepvp0mj8ZNs7ti1cOBQXFi1seuAzoS
	 ZUG2rzdWi7u9NQJtuCRrfPRhKQWynmqnhJr2gqQ6ml7+RVPG/FlRZRh1mbtDttzqvwve/
	 rmsrW/N1YBqu5NIZmG/AFIw9rfyOjeFfK0VVx8+rPjuXbfaesw32RhULEpvMZsCmE+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108523;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0o1IrJTUNX+1Hnp/7kuO0LUiqsxuBZ70eMNrzlpuJgw=;
	b=ET0Pm4k0DkMDijeBjn31+7RspzZFKsv5pgTvi7J4P5rr31I8FPUNV4et7ES97tw4EXrZ
	 a7GQeAm0+Jbeak7xFeKHalSCbH47Vh5y20Q+w87Utf0QibkTc/JCJSNNdlWhLe2O8+ynW
	 MjWXlmmvnl2zxGwB1AGDV4G3AjxSBmiS6U7uftOmtTAuNIG53rdqdxbaHbFHP+koCpxtI
	 HwwJ4h08kxQgWbZCuJaGD08sp3kWauns4FKPJYF/k0n1lIxAz9lytVtOopCRP0MX/Sr6/
	 UUFUD6RNs0YEx5v7laIt/cZib36b68+E5TKjq+U5W9eGcMux5h1KZ4ysTNk5tEzNnhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enXb5x+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBA606A322
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enXb5x+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF231F01825;
	Tue, 27 Oct 2026 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108523;
	bh=0o1IrJTUNX+1Hnp/7kuO0LUiqsxuBZ70eMNrzlpuJgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=enXb5x+0IrE8FD89vtzppoV9U6MGGlwT/RzrcqxeKmV3cnWsk58P4nYpjuWgYYNLR
	 26r/9w+uiDiDJr4qsTSQnqQBWupMRdhgBSdiUeEk1QRvoKquyLc7tWlmnqrIMhRjER
	 XKrCeEWORNALxXN90BWxrs75C0/2q5GZXWJ+RZuV65N9kZ856Sh89L0AwfWWZMYeUj
	 z7HfwnhlhnBfkrInTmadPMdDGbMMzGM5PS61trjckOHACww0wg2lOIauqXbU1BXGz1
	 laTVq4E5GJybvePJ5+S0t+VSCilNoViUf9UlrY1GLJETfu7FtbV0jth05XcElBTtLm
	 DlBGzu+d06QkQ==
Message-ID: <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
Date: Tue, 27 Oct 2026 14:42:00 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
 <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
 <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
 <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

Thank you for your reply.

On 27/10/2026 13:29, Kalpan Jani wrote:
> Hi Matt,
> 
> I investigated the existing byte counters and the diagnostic
> capability path.
> 
> The existing byte counters are not direct replacements for the
> normalized sequence fields:
> 
> - write_seq advances when application data is queued and when
> DATA_FIN is added. bytes_sent tracks send progress, and the
> retransmission path can update snd_nxt directly without updating
> bytes_sent. - snd_una is assigned directly during connection setup,
> outside __mptcp_snd_una_update(). Therefore, bytes_acked cannot be
> assumed to reproduce snd_una - local_idsn. - ack_seq advances when
> processing DATA_FIN, whereas bytes_received counts payload bytes.
> Their initial values also differ.

OK, let's not use the bytes counters then.

> Regarding the capability check, the normal MPTCP diagnostic dump
> paths have access to the original request skb and can check
> netlink_net_capable(cb->skb, CAP_NET_ADMIN).

Good!

> However, inet_diag_handler_get_info() is also called for socket-
> destruction notifications. In that path,
> sock_diag_broadcast_destroy_work() creates a new skb and invokes the
> callback without an original diagnostic request. Therefore, the
> requester's capability cannot be recovered from that skb. Passing
> false in this notification path appears to be the appropriate
> conservative behavior.

OK to pass false in this case.

> Based on this investigation, I will keep the capability/privacy
> change separate from sequence normalization. I will also address the
> stale remote_idsn after disconnect and the inconsistent sequence
> snapshot reported by Sashiko before sending another normalization
> revision.

Just to be sure it is clear: the main goal here is not to show the seq
counters to everybody from the same netns. This can be done either by
"normalising" them -- i.e. starting from 0 -- or by not presenting them
to some users.

Just thinking about that: for the normalisation, we can also just
add/remove an offset the userspace cannot predict and different per
connection. In fact, why not using the address of the msk pointer? I
guess that should prevent the different issues reported by Sashiko, no?

(In case of "other" existing issues, please split them and move them in
a dedicated patch not to mix the fix and the main patch here.)

If the "normalisation" is not possible, better not displaying them to
non cap-admin users. But we don't need both.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

