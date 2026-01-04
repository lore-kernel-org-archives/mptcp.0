Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8A2110E
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767496531; cv=none; b=GZjIwDiryAhh/ZlcSNu5xzgP64mrYsNYhntWEjzNqBBFcA9hHGswLmmN4vwsHg/OzNaifO6X/7zIwBghTG+VwRL5FOQiHwok1WeQZfkoRxvFU44YDE0CvCGP3zp/QqhPOWQM3n//I18ddP9jIWSBHBph1y2nbmWAuvVQ57LRSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767496531; c=relaxed/simple;
	bh=V06k3Lo9aSkLwjhLYl76p/NVKcPCvp4Y/l/M5qfnr/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uykhU1pgFTK3MNHfMzMYHxuDll1CK6Tqo5QnowqScsSY4BPYKnAvDJXq17/dBiEympPQXJAJ9qoWyWg98YuD+fAXURv5gSx9VIxbQozIadEVuOBz++UxBhQh9XgeIrMLm2VN8STI0xipT9oIGoN5SDn1Xxs6xxhsgRgGtwtmgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACiH17vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACiH17vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31583C16AAE;
	Sun,  4 Jan 2026 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767496530;
	bh=V06k3Lo9aSkLwjhLYl76p/NVKcPCvp4Y/l/M5qfnr/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ACiH17vxkAuqNXcVb5DLvpt2HVKy5mWn79qOzXzlUq+sT7fZR7aeWsboYWHSwGbZP
	 VGAHTdmEzptG/2hJORTuflCTsIp3zxMBQLdy6q1W1Jp8bHXRpO27tps6SyCseQsDWh
	 rxIenedOT27IrFn5fFDD3r528IazTNTyWklAC1WcGxkuDWLTcHMo2uZ+zl6VMC48zD
	 Az7BCQwchYwYsfnRhEaPDfsp+EOsaH8QQHivSfM04XVUMojqmkzalVRNTj8eQsoEMZ
	 1HGTWlZFVaPoDfk/qnFtBnAs6aCkBcIAxu3Vb3pdKTdIOjosB3s98fqauV+DgVXrwM
	 rxqs8OO7Uos+w==
Message-ID: <c05e6947d8c058026516dc07554292ce21486526.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 01/11] mptcp: avoid dup SUB_CLOSED events
 after disconnect
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Cc: Marco Angaroni <marco.angaroni@italtel.com>
Date: Sun, 04 Jan 2026 11:15:21 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-1-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-1-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> In case of subflow disconnect(), which can also happen with the first
> subflow in case of errors like timeout or reset,
> mptcp_subflow_ctx_reset
> will reset most fields from the mptcp_subflow_context structure,
> including close_event_done. Then, when another subflow is closed, yet
> another SUB_CLOSED event for the disconnected initial subflow is
> sent.
> Because of the previous reset, there are no source address and
> destination port.
> 
> A solution is then to also check the subflow's local id: it shouldn't
> be
> negative anyway.
> 
> Another solution would be not to reset subflow->close_event_done at
> disconnect time, but when reused. But then, probably the whole reset
> could be done when being reused. Let's not change this logic, similar
> to TCP with tcp_disconnect().
> 
> Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
> Reported-by: Marco Angaroni <marco.angaroni@italtel.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/603
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 900f26e21acd..1d68648b5194 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2622,8 +2622,8 @@ void mptcp_close_ssk(struct sock *sk, struct
> sock *ssk,
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *skb;
>  
> -	/* The first subflow can already be closed and still in the
> list */
> -	if (subflow->close_event_done)
> +	/* The 1st subflow can already be closed/disco and still in
> the

I suggest that we avoid abbreviating it as "disco" here and instead
write out "disconnected" in full. If that makes this line of comment
too long, it can be split into two lines.

Besides this, this patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> list */
> +	if (subflow->close_event_done || READ_ONCE(subflow-
> >local_id) < 0)
>  		return;
>  
>  	subflow->close_event_done = true;
