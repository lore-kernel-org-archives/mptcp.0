Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF5488757
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889134; cv=none; b=apjt2ejY3pYuOSXzgq29ZGKbySFwt/UdKyA1DoJv6sFgJswGygQlvmWTpERAT+4b/7oQ3HkKPYVweVoYeA/QZhuF5AgYQVVLRX4UtQPqF2r3pESX+u74t1MWW6zeW+DSC3sZP44pikhKbXtYuwhFDhpZSgOpUSDwPsxDfUJn+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889134; c=relaxed/simple;
	bh=atWnGSixhU2EqBxYuSlk8g4qyv3ICZURdDqBqQjnRZw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QRATd7HA+zBGPSGdW+rZQ4v+BSdST+FOi4DnR2bCNfjAqZtaLkIzsqAtyO5VUuIqI/xC0OQq7+OUJrNF3vgn91tzJXiDfO5LD6rvFCc5obIqZ5PWuhkZcpCI2z6+p78ZgIdXo1udzwgKSCZUl38NQYctmQiDKnITnBodN6mIG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3UUuywO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3UUuywO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CD41F00898;
	Thu,  1 Oct 2026 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889132;
	bh=r0NUsWJxyyHWlY4NeD5LrL3sWLxlSR66Y4M2xDFIawA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H3UUuywOGo/HTImyIGqJhNRbI87IJMyk7QQNY9M7ou4J6cBswqA/JpuIA7bV3D63H
	 Z4Vm/9tNzN5/ZptD5C9v9UpUm2ASwuLrI4CkJPZh/+u6YZz3XXXAqYyG3fG8PeJl//
	 uUxYql3lj3LiWum/gvAIqCE7Uj74VTYvGzzaxOWnWkIZrh3m8DoYo1cR39bdyD976x
	 BXNgiIyvIzWGn1YnZlMBW0hd9l0+kbCgQ9PBY4g262P2ZFOt7gdVZzqGN7YGJPdsV6
	 VY5IPa18qLnmGpbKxxkpHWbpQL9Sw+9ZW4pJpDWxnjbUr14qDUqt4wM33axjcUztxK
	 /y7zW96895NIQ==
Subject:
 Re: [PATCH mptcp-next v14 07/11] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:12 +0000
Message-ID: <179088913203.3135.11419962416862692363@kernel.org>
In-Reply-To: =?utf-8?q?=3C3ccb18c2210da287ff7c13b9d28d85310e2b671e=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C3ccb18c2210da287ff7c13b9d28d85310e2b671e=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says that wiring mptcp_peek_len() into
  mptcp_stream_ops/mptcp_v6_stream_ops lets 'upper layers get the…
- [Low] The commit's author identity is 'Geliang Tang
  <geliang@kernel.org>', but the author's own Signed-off-by is 'Geliang…

--

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq(), which computes the number of readable bytes
at the MPTCP level from ack_seq - copied_seq. It subtracts 1 once a
DATA_FIN has been received. It then connects mptcp_inq() to a new
mptcp_peek_len() in net/mptcp/protocol.c and sets .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops.

> mptcp: implement peek_len for proto_ops
>
> [ ... ]
>
> The subtraction is needed because MPTCP's ack_seq is incremented by 1
> in mptcp_check_data_fin() when the DATA_FIN is processed, consuming a
> sequence number without carrying any payload data. Without subtracting 1,
> peek_len would over-report by one byte, causing upper layers to wait for
> data that will never arrive.
>
> READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
> ack_seq and copied_seq because mptcp_inq() will be called from TLS
> contexts with the socket lock held - taking the spinlock would deadlock.
> On 32-bit systems a torn read can produce a wrapped subtraction (close to
> 2^64), which is caught by the INT_MAX clamp. TLS callers use mptcp_inq()
> conservatively: over-reporting defers work to the next iteration, where
> recvmsg() provides the actual byte count.
>
> Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
> mptcp_stream_ops and mptcp_v6_stream_ops, so upper layers get the
> correct in-queue byte count for MPTCP connections.

[Severity: Low]
Which upper layer is expected to reach mptcp_peek_len() for an MPTCP
socket?

The only in-tree caller of sock->ops->peek_len seems to be
strp_peek_len() in net/strparser/strparser.c:

    return sock->ops->peek_len(sock);

None of the strparser users appear able to attach to an MPTCP socket.

kcm_attach() in net/kcm/kcmsock.c rejects sockets that are not TCP:

    csk->sk_protocol != IPPROTO_TCP) {
        err = -EOPNOTSUPP;

sock_map_link() in net/core/sock_map.c sets up a strparser only for TCP:

    if (sk_is_tcp(sk))
        ret = sk_psock_init_strp(sk, psock);

TLS and espintcp are TCP ULPs, and mptcp_setsockopt_sol_tcp() in
net/mptcp/sockopt.c refuses TCP_ULP:

    case TCP_ULP:
        return -EOPNOTSUPP;

TLS also doesn't go through ->peek_len. It calls tcp_inq() directly in
tls_strp.c, tls_sw.c and tls_device.c. Since mptcp_inq() is static, TLS
can't call it either.

The message also seems to contradict itself. It first says a one byte
over-report causes "upper layers to wait for data that will never
arrive". It then says over-reporting is harmless because "TLS callers
use mptcp_inq() conservatively".

The existing TLS receive path uses inq as an exact length:

net/tls/tls_strp.c:tls_strp_read_sock() {
    ...
    inq = tcp_inq(strp->sk);
    ...
    tls_strp_load_anchor_with_queue(strp, inq);
    ...
}

tls_strp_load_anchor_with_queue() then sets anchor->len = offset + len.

At the end of the series (the "mptcp: update mptcp_check_readable"
patch), mptcp_inq() and mptcp_peek_len() are unchanged, and no TLS or
strparser consumer has been added.

Is this preparatory work for a TLS over MPTCP series that isn't part of
this one? If so, could the commit message say so? Could the rationale
for the lockless READ_ONCE() reads either refer to callers that exist or
move to the patch that adds them?

> Co-developed-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author's Signed-off-by address doesn't match
the Author line, which is Geliang Tang <geliang@kernel.org>. checkpatch
reports this as "From:/Signed-off-by: email address mismatch".

Other patches in this series, such as "mptcp: remove CB offset field",
use geliang@kernel.org in the Signed-off-by. Could the two addresses be
made to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
