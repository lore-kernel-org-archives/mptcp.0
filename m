Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533995;
	b=1zqB9JuaXP0KNQTOKWkqbR1+tRc4v+/BRLzKwCfZjoT3N9Zdj+dEOewbfxgUPz3tQZoq
	 ifXBe+NGdad3Y3NYvfB8KV800Ypl+ASoiipJxnDp06mO5bJOjq7q00KGZrKRSy+sAqjQO
	 qiOCdqXtmnQY/2a5fbpJahyr910kfOY/IsanwpLvnIFi0InquLMSmmMY5MEoJsADb2iKp
	 MhRBvjlykaxHlKKqmCQD7CS7uV+dkC5rQUyojcWqy28MPqhUKa7p4gBdY1fGpX6tQcq7P
	 kTw9QorXf4N5Mw/NJosrdSna+FgW7ciLZDvM//B/4/LNb1zVvnDn7gZ6ILKvBZzX4LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fHwNGVS0uA7ZhkuR/8T7d/qIlnk9XxivVjCvaKlXIcQ=;
	b=ARNtOYKxM1jW1As0UVqirCo1gTgtM4EGxz8tIVqgyM1o59gKXxZa4dPkbbOQjiYzuQYb
	 7v/Us4Hzx2w0Ibk9+s9KIx4Ef5lf+1hEkzkvWkp6ZpkO/UgWOpRzGEFURdkX5rB6IBTMf
	 CEL4MnsRXpKJbka8tHSu9c4niUsuYDI65V64kY58Kye2g2flv/aQJ6oNWEhHDdSv1EdyL
	 c7ouZldiz7HUeSTdAql/LGqOG8Fn6nWj/OUjfVYS9cUSl84an1riLK/bJlfepVOyG2NX7
	 75nEkrNX01pLKAHFDgEvljyFSjI/IxDVYl8MUg694LBYbYkUdviusmbgvjKETErleMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOQulocQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D069606A329
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOQulocQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269D81F000CA;
	Tue, 24 Nov 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533994;
	bh=fHwNGVS0uA7ZhkuR/8T7d/qIlnk9XxivVjCvaKlXIcQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gOQulocQZzrpd+8oC+T3HcrYY4lA3jC5GeZSdCTvSKBaBl0AtA0QZDcK/8Gp4ujo5
	 abV+aqHFawAgEWSlAWdKi9R2c6evmS7hCLZoZE9gOztLpzvuOWB8WnVRWOLAhJCkYR
	 F5i4DOdBi2q+bt1q4o5yrRyoKjNd5ltBPI+PtAQ5a75QzjHUiQRyScBb8WxclJYQ7Z
	 i/bo7BDPbQcvypQqwUoNevHaOi/WTx5+XKbdHkvzQtXC2gD2C4PkH21EiWBBw4yZid
	 +YosJUGnLuU/TXcoKbI9NpOQVhn7qbWfXjWibySEWthrJg96KXb/Mp+ywvUkOwpkL3
	 O6mOk8Onq6chA==
Subject: Re: [PATCH mptcp-net v3 2/4] mptcp: add missing memory barriers for
 rcv_data_fin_seq
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 15:26:33 +0000
Message-ID: <179553399369.3133.11820722476737181809@kernel.org>
In-Reply-To: <da8ae9e6c48df602b08475d151a87841ad632400.1795396910.git.tanggeliang@kylinos.cn>
References: <da8ae9e6c48df602b08475d151a87841ad632400.1795396910.git.tanggeliang@kylinos.cn>
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

- [Low] The From: and Signed-off-by: addresses do not match.
- [Low] The commit message says a stale rcv_data_fin_seq can make
  mptcp_check_data_fin() 'skip [the DATA_FIN] entirely'.

--

mptcp: add missing memory barriers for rcv_data_fin_seq

This patch adds an smp_wmb() in mptcp_update_rcv_data_fin() between the
writes to rcv_data_fin_seq and rcv_data_fin. It also adds a matching
smp_rmb() in mptcp_pending_data_fin() between the two reads. The goal is
to stop a reader on a weakly-ordered architecture from seeing
rcv_data_fin == 1 together with a stale rcv_data_fin_seq.

> mptcp_pending_data_fin() checks rcv_data_fin and then reads
> rcv_data_fin_seq, but has no read barrier. On weakly-ordered
> architectures, the reader could observe rcv_data_fin == 1 with a
> stale (or zero) rcv_data_fin_seq, causing mptcp_check_data_fin()
> to either process the DATA_FIN prematurely or skip it entirely.

[Severity: Low]

Is "skip it entirely" accurate here?

Suppose the stale rcv_data_fin_seq makes the !before64() check fail.
mptcp_pending_data_fin() then returns false and msk->rcv_data_fin stays
set. The flag is only cleared in the success branch of
mptcp_check_data_fin():

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
    ...
}

Each writer path also triggers a later re-check after rcv_data_fin is
set. For example, get_mapping_status() does this:

	if (updated)
		mptcp_schedule_work((struct sock *)msk);

The pure DATA_FIN path in options.c and the fallback path in subflow.c
also call mptcp_schedule_work() after a successful
mptcp_update_rcv_data_fin(). A DATA_FIN carried inside a data mapping is
re-checked by move_skbs_to_msk() through mptcp_pending_data_fin(sk, NULL).

So the failing case only seems to delay the DATA_FIN. The harmful case is
the premature one: a stale seq that passes !before64() bumps ack_seq and
sets RCV_SHUTDOWN while data is still pending.

Could the commit message describe the impact that way, so backporters can
judge the severity correctly?

> Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]

This isn't a bug, but the author address (geliang@kernel.org) does not
match the only Signed-off-by address (tanggeliang@kylinos.cn).
checkpatch.pl will report FROM_SIGN_OFF_MISMATCH for this.

The other patches in the series have the same mismatch:

  mptcp: handle ack_seq advancing past rcv_data_fin_seq
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  mptcp: add mptcp_inq() for SIOCINQ

Could the author address be changed, or a Signed-off-by from
geliang@kernel.org be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795396910.git.tanggeliang%40kylinos.cn
