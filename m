Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994802;
	b=CJJY7lpzz2HeAP5Jq0it2SSZBte3BsoGlaW1hr/QiRxmaHIbIN+yM9fVJxHq5Fto9iDy
	 YaJDu5dwG+1TdHRUyQBL3yGZzwYRWo/F9oXrWlloxdS+lrbbU1FAUTYESeggBmI+RE/Vj
	 KXyJyKNg2K4+2WtzGMjJdW8AqvFBOIlomNlzELbOUGGFR1dTAAZZ7UtXLDBixGv2meKq/
	 BpFhbHtIFb5sir5BSsnfjk3kSo6dfARRu1jRNIwdW50CVL6Gr5h4PlYgjnWwk4Upo1JNh
	 2z49aDmOQ/ny9NkBkvMXpTthxX3gzF845ZYzSXgBEqbgc9bl2u882+LWi3E0sfwuKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994802;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0d6pZZP/7+lXAyITHeEMB0K7wCc5RBlIQotDFTnvYqY=;
	b=v4DQTxtr5rCes99oKgxVfi/fL1JzpBs48hqLg6pra5d3qvlvKH0t3q6oC1qUVVg+mQyw
	 eoO4uTg5wnAVscfS2vKQNou7dPvY/coqxlV8A5lYcF+3/fMYlt+zQ9ryNJADag7URiWkn
	 qF6RHu5FXvkz6HJRty1x/iJHiiiCf5r+d/MtHsY7HEqKZqr5Re4rTGBu0RbhpaHdAsiAh
	 FDSsrhHqj0lEh2R4rJc6N+lc4dRKLygs8bY79qhQZmcRmargHyP8R3n/oehcGhkbkcxap
	 vwYZqJI6duPF3E5HHHeRC2CLf1X36qSXT3/qdI3sd79NIq2YYel93xFvlf79wPCLUrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfN8Ydt+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD7606A329
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfN8Ydt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28121F008A3;
	Fri,  6 Nov 2026 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994801;
	bh=0d6pZZP/7+lXAyITHeEMB0K7wCc5RBlIQotDFTnvYqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SfN8Ydt+DWoNy+/NUqRkhvnLJGA9Bu9GgYVCDrgjWXLz3FW31yYpaey2SUFCFt1ue
	 UtypAbCnemHgc2kTnoBYzpEDhtDpjK1UT6gKMjF7eYh53dIPA8G1waVxWSKu/D7k1L
	 I8VI+NmQO/ZLoBUcr1KO2zzzwC+3oKOuyQPCYgir3nz4I/l51mFNBpGc26XYG4u4R2
	 qedQ4ulJrQ9xz1a66IS41BX7kg3JSJkqbeJqWCBMyu3hZUpzKZqXrBEsn3/pODJWL7
	 yWMxZLdZFu37Ya9TOH1/9nezugeHLbYI1MYpirL3FNPQSk/BG2mIGw3A9sJmBn3q8c
	 69t5qzFdhnePA==
Subject:
 Re: [PATCH mptcp-next v6 6/7] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:21 +0000
Message-ID: <179399480120.488855.2920411988965034359@kernel.org>
In-Reply-To: <1f1319763b4e12e1a3d89f6fe05d17591a86a3ef.1793860134.git.tanggeliang@kylinos.cn>
References: <1f1319763b4e12e1a3d89f6fe05d17591a86a3ef.1793860134.git.tanggeliang@kylinos.cn>
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

- [Low] The commit metadata does not match its sign-off.
- [Low] mptcp_rate_check_app_limited() (net/mptcp/protocol.c:2041-2063)
  runs on every mptcp_sendmsg_locked() call (line 2096).

--

mptcp: track app-limited state in mptcp_sendmsg

This adds mptcp_rate_check_app_limited(). It calls
tcp_rate_check_app_limited() on every subflow under that subflow's socket
lock, and skips this when the MPTCP socket still has unsent data or a
pending retransmission. mptcp_sendmsg_locked() calls it so that BBR and
similar congestion controllers can ignore rate samples taken while the
connection is application-limited.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Signed-off-by address doesn't match the author
address (geliang@kernel.org). The name is the same and only the address
differs, so checkpatch.pl reports FROM_SIGN_OFF_MISMATCH ("From:/Signed-off-by:
email address mismatch"). checkpatch.pl doesn't read .mailmap, so the
alias there doesn't stop the warning.

Another patch in the same series, "mptcp: update mptcp_check_readable",
uses the kernel.org address in its Signed-off-by.

Could the From: line or the Signed-off-by be changed so they match?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b9c7b0bb6f742..889f244d9da04 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2038,6 +2038,30 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{

[ ... ]

> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}

[Severity: Low]
How much does this cost on the send path? mptcp_sendmsg_locked() calls
mptcp_rate_check_app_limited() on every sendmsg(). Whenever the MPTCP
send queue is empty, it takes and releases the lock of every subflow on
msk->conn_list. An empty queue is the normal state for request/response
and small-write workloads.

On the TCP side, tcp_rate_check_app_limited() is a check without locking
on a socket the caller already owns. In MPTCP, __mptcp_push_pending()
then locks only the subflows that the scheduler picked:

net/mptcp/protocol.c:__mptcp_push_pending() {
    ...
		mptcp_for_each_subflow(msk, subflow) {
			if (READ_ONCE(subflow->scheduled)) {
				...
					lock_sock(ssk);
    ...
}

So each sendmsg() pays for N extra subflow lock round trips, on top of
the locking that transmission already needs. The loop also visits
subflows that can't send (closed, not yet established, or the listener
subflow). Marking those app-limited has no effect.

Could this check be done in the push path, where the ssk lock is already
held? Or could it be limited to subflows that can actually send? The
commit message mentions the per-subflow locking, but it gives no cost or
measurement.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
