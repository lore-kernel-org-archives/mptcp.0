Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459576;
	b=sUss+ThgWdon3EIM+wJyEt2eywIAJJWiXGxNkrFYzYm/OIhxr10p+3MCl4Jpyo0JuLwM
	 /MuRcLOLw4YH5LtZ4dl/pV04FkzArP+6vgVP1dZkuZnnCGSZfIV1T2DiZijDjGnpBmTsJ
	 MNJwIeVeCxMhfHbcbS9Vg0D2fkLFQwVgsrTGTSvUBFlnpN0JFKxp9GTENcrfHsPoTZ5f/
	 qgFrropVmNovAueOPaYmu1IAbUTFQeOwfhn+CHiwRHhqUD6oaXCHbsH643PqNvpVh/We9
	 kYFkvNgco2eZHQrOMijGArmVQeZZmIH1VHKTo2MZWQ+/USTxTliiJlbG2TdJNcXtAtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459576;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fXDff3Dc0mk0Wz2yFgX8STrMMy2qGtXOwYtQLEh1yMc=;
	b=1oAQvZLUwvwQE3EVBw3EnqdXtYnmaJrH7CBM1X227qMB68NqxHpPF9VXpOb+cy3avwVO
	 5HSFreRjzZTGTSGIXuQZAzkxYr8j9daCCwAArqb74xMq5vvlTZFaDPi6/uyMEKAec1LMv
	 34TdHU7MJIfC0Qg+p0agUEq6/AzgcpM+WXAcDuLlYgvaCb58tglHip3V9mJvQg4wXuKUK
	 B7BXjOSNAjgYUQU9uMxuP6dvOaY4Iijvcw/LvkpcJRiaZ33drwShDFpIhTSakBj0X8g32
	 YW6u//4ZBv6COm8DB6PrfHbJqMXxY/H8iHPYPZM5CAeC9Qi/hYrODu4R0fldnMuCwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgg5qdiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD97606A31C
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgg5qdiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD241F00A05;
	Thu, 12 Nov 2026 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459576;
	bh=fXDff3Dc0mk0Wz2yFgX8STrMMy2qGtXOwYtQLEh1yMc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kgg5qdiNtwa0FCXKOTxsjYPn2NL4PXRjfy+qtsUA3MTyHNuVnxNeDfiC5PLqxgrIJ
	 cb9hyp3aXY9ENNuSi/w+oTZze/+jlFUsPzZvR6FbtkZk92Wbmxvgv8bCI39qK6nf8r
	 ghUTTTb3RSNNYuOnGX0zkV8dPTv3ZWONlCZ3/g7ghtmMlkVlB2DbgQYk7HCH7iUNVS
	 Xo2quBFbbqvI9cVgh8IPaHY3SySziRy8zXUTC+hy+BzyF5iuoC8xdaYKdMP5oFZj9F
	 Xa418L7WD/nIQ14oJQwOQM90QYhfT0JQceLExp0X7z10l+5D4u/d3bKAY/0RNVxFXo
	 KGoC8qNAF3duw==
Subject: Re: [PATCH mptcp-net v25 1/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:35 +0000
Message-ID: <179445957539.488855.12944386671709466852@kernel.org>
In-Reply-To: <ff754c69824fa566626bd37287f696c39afa7ec4.1794304840.git.tanggeliang@kylinos.cn>
References: <ff754c69824fa566626bd37287f696c39afa7ec4.1794304840.git.tanggeliang@kylinos.cn>
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

- [Low] The commit author and the DCO sign-off use different email
  addresses for the same person.
- [Low] mptcp_inq_hint() feeds both SIOCINQ (mptcp_ioctl) and the
  TCP_CM_INQ cmsg (mptcp_recvmsg).

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the hint from
mptcp_data_avail() (bytes_received - bytes_consumed) instead of ack_seq
minus the head skb's map_seq. This fixes the bogus INT_MAX hint on passive
TFO connections. It also changes the value reported after DATA_FIN from
N+1 to N when N bytes are still unread.

> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the sign-off address don't
match. The author is Geliang Tang <geliang@kernel.org>, but the only
Geliang Tang sign-off uses <tanggeliang@kylinos.cn>.

checkpatch reports this as FROM_SIGN_OFF_MISMATCH. Could the From: and
Signed-off-by: lines use the same address?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..fc4ffa3263176 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

[Severity: Low]
mptcp_inq_hint() provides the value for SIOCINQ in mptcp_ioctl() and
also for the TCP_CM_INQ cmsg in mptcp_recvmsg():

    unsigned int inq = mptcp_inq_hint(sk);

    put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);

Does this change TCP_CM_INQ from N+1 to N as well, when N > 0 bytes are
still unread after a DATA_FIN?

TCP builds TCP_CM_INQ in tcp_inq_hint(). It uses rcv_nxt, which already
counts the FIN:

net/ipv4/tcp.c:tcp_inq_hint() {
    ...
	inq = rcv_nxt - copied_seq;
    ...
}

So TCP reports N+1 here. Before this patch, MPTCP reported the same
value, because mptcp_check_data_fin() advances ack_seq for the DATA_FIN:

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

The commit message says:

    with N bytes unread, SIOCINQ now reports N instead of N+1, aligning
    with TCP's SIOCINQ behavior.

It doesn't say that TCP_CM_INQ changes too, so MPTCP's TCP_CM_INQ no
longer matches TCP's. Is that intended? If so, could the commit message
say so?

The mptcp_inq selftest checks TCP_CM_INQ after FIN only once all data
has been read (it expects 1). It never checks with data still unread,
so it can't catch this. Later patches in the series don't change
mptcp_inq_hint() again.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
