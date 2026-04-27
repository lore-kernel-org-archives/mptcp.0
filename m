Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E0391501
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274882; cv=none; b=fMbCNU24w9XBX4QWf2CArze7ypx7B1P5B33MgADj26vINzrd2bFP8mRJNUQa0dAMw6aVg+Bxh6D2RfkRsGx7fuxajLj50kh1C6ccvl91BmgeC8ui/K1a3dOY2FqFyghJDIfC+K4y3ssLAidHH00SV5XK4GTWxvC12qBxAZ/ZFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274882; c=relaxed/simple;
	bh=5MGbSAUEw1lBLn0isUn4wlCuNDwEA2M91kMZl4m3Vb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cs1hwzGWNf6FEnS4z+Utvvn+BFS6VNFiZ/fQg5yo1SNAs4O+GhozT+NCnVHPDCtWYmqvQkQb20X9mPfAoPVedZ7JMx6Z0aiwJLo1n6iwcjLfIZIEUbyOhlITWovXzykkCqnN8ZEzUMdrVL8Pk499ZlCcyMo1FQHS8rYDdqdvpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7cY1Tu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7cY1Tu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D8C2BCB6;
	Mon, 27 Apr 2026 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777274882;
	bh=5MGbSAUEw1lBLn0isUn4wlCuNDwEA2M91kMZl4m3Vb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f7cY1Tu1kP+KZPTOC32O7JRk4H10QkRQnwWBFxhhpecD+h202AIqCvQ+v/asxQSiq
	 UyGud6eqq0guuM+K4cRaD/xeLRYRqDacuuEm8riGbRJYyHfTu9SO8UUXW+YbTd3cp2
	 Z70Ictoc190pRPxm5Z2Gc657io14aJNKZdMwlPeedoB38+FsMBGM1dgQwMVZgYQW2l
	 lEo6ffiUyrqR5WkLZonWVr6aUJFirVNJawVKAZGhuPBM+ulxpwXbaE1MzB0nRyf9Jw
	 zq1MF80CEyznF7M5rb0Suh3IwdC9bdGlk763lqqWGtE+wp9lwsc0mk6qW00bptIvSg
	 xTS7YYxRBplgw==
Message-ID: <d6eda172d5fea261bce865a0a6bb1779874cad5c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 0/9] mptcp: address stall under memory
 pressure
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: yangang@kylinos.cn, matttbe@kernel.org
Date: Mon, 27 Apr 2026 15:27:14 +0800
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for these fixes.

On Fri, 2026-04-24 at 16:08 +0200, Paolo Abeni wrote:
> This an attempt to fix the data transfer stall reported by Geliang
> and
> Gang more carefully enforcing memory constraints at the MPTCP level.
> 
> Patch 1/9 moves the bound check before entering the TCP socket.
> Patch 2, 3 and 4 are cleanups/refactors finalized to safely re-using
> TCP
> helpers on MPTCP skbs.
> Patch 5 makes TCP pruning related helpers available to MPTCP and
> patch 6
> makes use of them. Patch 7 addresses an edge scenario that could
> still
> lead to transfer stall under memory pressure.
> Finally patch 8 and 9 improve the MPTCP-level retransmission schema
> to
> make recovery from memory pressure significanly faster.
> 
> Note that the diffstat is biases by the quite large patch 4/9, which
> contains mechanical transformation of existing code; "real" changes
> are
> noticiable smaller.
> 
> Tested successfully vs the test cases proposed by Geliang and Gang.

We found this issue while testing the MPTCP TLS selftests
(tools/testing/selftests/net/tls.c). The multi_chunk.c test was
actually extracted from chunked_sendfile() function in tls.c. The tls.c
file contains many test groups, and chunked_sendfile() is just one of
them. Therefore, passing the chunked_sendfile tests does not guarantee
that all tests in tls.c will pass in the future. So we will provide you
with a test similar to multi_chunk.c shortly, but includes a more
complete set of the tests from tls.c.

> ---
> RFC -> v1:
>  - dropped old patch 4 & 5
>  - addressed AI reported comments
>  - added retrans refactor.
> 
> Paolo Abeni (9):
>   mptcp: move checks vs rcvbuf size earlier in the RX path
>   mptcp: drop the mptcp_ooo_try_coalesce() helper
>   mptcp: remove CB offset field

When implementing MPTCP KTLS, I used this offset field. Please see the
implementation in [1], including mptcp_read_done() and
mptcp_get_skb_seq(). After removing the offset field, I think the new
version should be implemented as follows:

static void mptcp_read_done(struct sock *sk, size_t len) 
{
        struct mptcp_sock *msk = mptcp_sk(sk);
        struct sk_buff *skb;
        size_t left;
        u32 offset;

        msk_owned_by_me(msk);

        if (sk->sk_state == TCP_LISTEN)
                return;

        left = len; 
        while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
                int used;

                used = min_t(size_t, skb->len - offset, left);
                msk->bytes_consumed += used;
                msk->copied_seq += used;
                left -= used;

                if (skb->len > offset + used)
                        break;

                mptcp_eat_recv_skb(sk, skb);
        }

        mptcp_rcv_space_adjust(msk, len - left);

        /* Clean up data we have read: This will do ACK frames. */
        if (left != len) 
                mptcp_cleanup_rbuf(msk, len - left);
}

static u32 mptcp_get_skb_seq(struct sk_buff *skb)
{
        return MPTCP_SKB_CB(skb)->map_seq;
}

But unfortunately, after this modification, with all your patches in
this set, the newly added MPTCP test cases in tls.c did not all pass.
Are there any obvious issues with my modification in these two
function?

Thanks again, and I will continue to follow up and test this series.

-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/b86c642262c9718f4936ad52dab804b8f494aa6d.1777026753.git.tanggeliang@kylinos.cn/

>   mptcp: sync mptcp skb cb layout with tcp one
>   tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
>   mptcp: implemented OoO queue pruning
>   mptcp: track prune recovery status
>   mptcp: move the retrans loop to a separate helper
>   mptcp: let the retrans scheduler do its job.
> 
>  include/net/tcp.h    |   8 ++
>  net/ipv4/tcp_input.c |  55 +++++---
>  net/mptcp/fastopen.c |   1 -
>  net/mptcp/mib.c      |   3 +
>  net/mptcp/mib.h      |   3 +
>  net/mptcp/options.c  |  55 +++++++-
>  net/mptcp/protocol.c | 328 ++++++++++++++++++++++++++++-------------
> --
>  net/mptcp/protocol.h |  11 +-
>  net/mptcp/subflow.c  |   2 +
>  9 files changed, 323 insertions(+), 143 deletions(-)
