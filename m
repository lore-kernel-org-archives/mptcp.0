Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955272;
	b=qNjtc0PNz7UXsT9UX7jpCJ5GE0YvOZISJsg/6Dl/cqT31LwQPgVeCX/130TKuvH/HILs
	 aS8uICHbJiP1ZhGb3cygVXtjU23HPbQ7yOGPx/zj0dtCdORIc4qtRKRhF98L72gInjtFr
	 LEol0OVmjsUhYz8IO+tdISZfEY+yiEw7eUiK9bRBJZxyRXRAmuqQO201KudC6IM+L0EmY
	 kh5WK1737FrHwf31SXodee2R/Blq4Seh1s9MxGB6071kxPrnCIOjPCKgH5+ZauxGwcb0l
	 ePeyxyWcWRO5hHusofs8pQg4Nhidj9lzifCtIug3TXwzuOChvBnMdo9mfikoxC91Iow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955272;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hddy5hIltTHCj83tC+KmDIvsbyEOkWxHqXiM4xEbxuw=;
	b=SvERIrCOeNZqKA0gD/aWT43UvMxLqk7nksgEvRHGuaFxABSwdK/lvy3dSfTU/visd98f
	 /0dF0qznIwLmwGJhrCfb7xMri/yfRBbzHVlhXxL2b7wRzyQ8ngLvpuQt7kWLXa5niXneJ
	 Rt2WOTX/xDGi+8YjR/oFX/nvsQ9+OtnnvyKF5UoOs87WNCf0jpE/2c8xg7R6ir4ysUkyx
	 N9K3yQKy3FQwemnmpgdU1rplAjsDYYEBsd0A0hjBJuoFew2Nfae5kRCbKVHMGgu78AU/w
	 XSzvsg5Dn6bFLNaxlTXv6Zld6YW76Uy65zwsD/TiJloow3+3OIodUK0HI7dlujY1hMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6OhGd1J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952E606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6OhGd1J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D71F000C9;
	Tue, 17 Nov 2026 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955272;
	bh=hddy5hIltTHCj83tC+KmDIvsbyEOkWxHqXiM4xEbxuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h6OhGd1JZ6zSCj5KDwG5D3M6EXgfcH7t/FHwDeWR6TGcD9hTue2r61xvbmpNth+Yy
	 CvLgEaz6A8IvhyhAIzU382k2GnnOCVbVaG/Phh0zSH9FpPwTd920gskpNvzEm+UG1e
	 yq9+jj7evULzKLlAEGago7uUMtu1OwGEab+mPnq+Y7mu+SvXmoWKuyoaJrCLy2h3vq
	 fjj6ThKjfHxbMUgElwzI7u8cGZ4uv+1QcL9Ym0V1JeIFXg1V18FMJOkQ5prFP25HBE
	 RlTup9+cbuNTML4sK8HpJ7VDSPT9CkLmO+zQY9Eb/5I8A4SlZiYTE8g5Qw/lAxXSyl
	 kcueMQtgqOoCg==
Subject: Re: [PATCH mptcp-next v28 07/11] mptcp: encapsulate CB DSN field
 access with helpers
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:12 +0000
Message-ID: <179495527210.3133.12002266299417037321@kernel.org>
In-Reply-To: <143b8387b6159088b7acf529a3cf43b45615aacc.1794810809.git.tanggeliang@kylinos.cn>
References: <143b8387b6159088b7acf529a3cf43b45615aacc.1794810809.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message says the patch replaces direct accesses to
  MPTCP_SKB_CB(skb)->map_seq and end_seq with…

--

mptcp: encapsulate CB DSN field access with helpers

This commit adds two helpers, mptcp_dsn() and mptcp_end_dsn(). They return
the map_seq and end_seq fields of the MPTCP skb CB. The receive path is
switched over to these helpers to prepare for later CB layout changes, and
no behavior change is intended.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 395bdcd0080c1..c780529342d68 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,7 +167,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  {
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
> -	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
> +	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||

[Severity: Low]
This isn't a bug, but should the from side of this comparison also use
mptcp_dsn(from)? The to side was converted on this same line.

The commit message says:

  Replace direct accesses to MPTCP_SKB_CB(skb)->map_seq and end_seq with
  these helpers throughout the receive path.

Some direct reads in the receive path are still there after this patch.

In __mptcp_move_skb(), just above the new dsn local:

	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;

and in the partial packet branch of the same function:

		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
					     MPTCP_SKB_CB(skb)->map_seq;

In __mptcp_ofo_queue(), the uncoalesced path still reads map_seq directly,
both for delta and in the pr_debug() that follows:

			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;

The pr_debug() in __mptcp_try_coalesce() also still reads the raw fields.

At this point the helpers return exactly the raw fields, so nothing changes
functionally. Even so, the claim about the whole receive path seems too
strong, and some functions now use both access styles.

Later in the series, "mptcp: remove CB offset field" removes the partial
packet read-modify-write site and the __mptcp_ofo_queue() one. Then "mptcp:
sync mptcp skb cb layout with tcp one" changes this comparison into a
deliberate MPTCP_SKB_CB(from)->map_seq64 != mptcp_end_dsn(to) check.

By the end of the series, raw reads are still left in the copy_len
computation in __mptcp_move_skb() and in the pr_debug() calls in
__mptcp_try_coalesce() and __mptcp_ofo_queue(). The layout change also had
to edit these sites directly.

Could the remaining sites be converted as well? If not, could the commit
message be reworded to say the conversion is partial?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
