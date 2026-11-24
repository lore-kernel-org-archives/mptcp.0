Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482328;
	b=iMNNeWwWRrTEBnXOlzp1KHIcJ+I3tEldrOgBWSSNxCLXro7uZdKXhxd1Rf3DpTeVsHM3
	 U+/qlvm5xb3XVc0YtgKT/c5IWypNmXMMrQzHgpR4x0cSMTAY19KGbLi3/pq55jiSAohGx
	 R/bQcai4zvvHvcfFwVR+shso737XtKy6CdPpU6LGyp4VgptAaCteBSnIrfWTGWCinkw7I
	 2SfKY+4wpQD9ZmoaOltZ3SSctBWe4khQk59SWiD3Hs+wYndEKEmE85YmOKGxsNrNlqwvu
	 x7rHQk4vbUowsf4rNHJPlX+nB9pvgC920s4h1tQaOumf1oZViQGxIIStp2aPfso1iYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482328;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K88EdfLUGBdD2wsvtEoy4mPQ4vruucvZ4ot++4G2ph4=;
	b=5doC59WPLjH/7v9h6nd6z3+DdN/mu8zofZlWqFIawaMLLslfR591wPEPG9BUrmCB4Ru/
	 VS6NR34azdkIxGhYpmd2A2L9sZbQjallDSdqPnJY49NaXa/NEMP6V4JrAADuKNxpOVQCg
	 7gHYAJWibY/PFFGAaJ945KO4XiGa1xRGIUUt6yV1veXN2gsQyZgplZN/1w5TBVvAEpkyS
	 TKeHg9t+r4TGu1YZAhz4yqWA95CgBfR4MKu2M3Ic50+ApMQMxQUtd+A8cRj3iQp3uhYq+
	 Zzur0mleQutkC/K8AWKqj/uzF/dagSERSkaduFBbYMRcU1rHS+rF5vMUk/f3AAmLXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aY/ktrPJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA1606A32E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aY/ktrPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E3E1F000C4;
	Tue, 24 Nov 2026 01:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482328;
	bh=K88EdfLUGBdD2wsvtEoy4mPQ4vruucvZ4ot++4G2ph4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aY/ktrPJfQ91IlUeVv+8zQGzpUk5hkp8bqyJuUkYBnWEMxiL3qsb1KQXsjEWKMRzw
	 xVhDuUvnbFBkwmkvY9VsUqUzybK6uyzPENvwfNi+UabZgxXf3vl7MVkCMwyPldZd1+
	 yh8j1Dk0p0T9mxgAJ2UCvvq1qpCvatycKOBiZgxssngkyeesRSRQ9RLV+Jswg26l18
	 EZFzYpY2nRC6ZpduNN5t962TOZRWT9YRgXe0QdWWHvuE/yH5JaJTs8CcIKtdZz4EbS
	 UeFhXn5bOEthSfLwkVweJABagrc6o1mMnQHzektCYm1PxZT1h8qqQBTqvQNRo9se3s
	 3mIBJ0UBdWiNA==
Subject: Re: [PATCH mptcp-net v2 2/4] mptcp: add missing memory barriers for
 rcv_data_fin_seq
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 01:05:27 +0000
Message-ID: <179548232731.3133.14387340969806272954@kernel.org>
In-Reply-To: <da8ae9e6c48df602b08475d151a87841ad632400.1795348666.git.tanggeliang@kylinos.cn>
References: <da8ae9e6c48df602b08475d151a87841ad632400.1795348666.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message overstates one failure mode.
- [Low] The commit author address does not match the Signed-off-by
  address.

--

mptcp: add missing memory barriers for rcv_data_fin_seq

This commit adds an smp_wmb() between the rcv_data_fin_seq and
rcv_data_fin stores in mptcp_update_rcv_data_fin(). It also adds a
matching smp_rmb() between the two loads in mptcp_pending_data_fin(),
so readers can't see rcv_data_fin == 1 together with a stale
rcv_data_fin_seq.

> On weakly-ordered
> architectures, the reader could observe rcv_data_fin == 1 with a
> stale (or zero) rcv_data_fin_seq, causing mptcp_check_data_fin()
> to either process the DATA_FIN prematurely or skip it entirely.

[Severity: Low]
Can the "skip it entirely" case actually happen?

In mptcp_check_data_fin(), rcv_data_fin is only cleared on the true
branch of mptcp_pending_data_fin():

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
    ...
}

So a false negative leaves the DATA_FIN pending. Each writer path also
forces another evaluation later. mptcp_incoming_options() and the
subflow.c callers call mptcp_schedule_work() after
mptcp_update_rcv_data_fin():

	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
		mptcp_schedule_work((struct sock *)msk);

The other subflow.c writers are followed on the same CPU by the check
in move_skbs_to_msk():

	if (mptcp_pending_data_fin(sk, NULL))
		mptcp_schedule_work(sk);

>From that, a stale read only seems to delay the DATA_FIN.

The real problem looks like the premature case. If the reader sees
rcv_data_fin == 1 with the initial rcv_data_fin_seq of 0, then
!before64(ack_seq, 0) is true whenever bit 63 of ack_seq is clear.
mptcp_check_data_fin() then bumps ack_seq, sets RCV_SHUTDOWN and moves
the msk to CLOSE_WAIT, CLOSING or CLOSE before all data has arrived.
The application would see an early EOF or truncated data.

Since this carries a Fixes: tag, could the commit message describe that
user-visible effect instead of the "skip it entirely" wording?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address doesn't match the sign-off.
The author is "Geliang Tang <geliang@kernel.org>", and the only
Signed-off-by is "Geliang Tang <tanggeliang@kylinos.cn>".

checkpatch.pl will warn about this with FROM_SIGN_OFF_MISMATCH. The
in-body "From: Geliang Tang <tanggeliang@kylinos.cn>" line may have
been dropped.

Could that From: line be restored, or a matching Signed-off-by added?
The other patches in the series seem to have the same mismatch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795348666.git.tanggeliang%40kylinos.cn
