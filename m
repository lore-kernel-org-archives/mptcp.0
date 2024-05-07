Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF01D524
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053981; cv=none; b=KGe4oOtsdZ4NAo19y89I5WOpuawif0fPwQsl+yGvIoErHzdLr8hIT6K71pGif3+ZSWyzl1v9yaBhO0yt+RxEhM61v2O0JC/kvLvy3J99Dt3UNEBCbG24dN8n3z597HxgHZeZneY1DUbsRcyMSDpvAnowHBhkRsfyQEEQ25t37i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053981; c=relaxed/simple;
	bh=WWW8I11iRhP1pEIbEsmCpG2QHMRnwSVFIla2BUdD16s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/K0DtQ2/EPV4v1loZNyDT5tl3QNBdMhvQbS2eIM26HQ6/f2jiEau7XTBWfUC46TrrIQNPw8bWn1blczo87on4EQvrGoRkP4J+Ve+by2Y/14aWbIHpef48c/LZHuekAiGGsBQ8/kv7jcj+Z/y6dfe8bgC2evxBD4nnnpHghS+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQZ67PhX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQZ67PhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DC9C2BBFC;
	Tue,  7 May 2024 03:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715053980;
	bh=WWW8I11iRhP1pEIbEsmCpG2QHMRnwSVFIla2BUdD16s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eQZ67PhXrEuugwQdkDkvih4sstjpklHQMLCYXMBIsQefR5Zdlp1QFT02ox0evQzL1
	 OU18nZvjmAfnVE/O3I4WMPLo3WBewvC5IxxDxXI4VCCVgORCSD0VQzPffiqdYjJUR8
	 uCsOIJFEPazFVT+wy/+sADln7K2cfDMUniNyiJ8u1diLhIzMyeLWMEFknVfq8aAZZi
	 ls+x4PBBr0SR9vtCdPBb1HIhqchwIaX26WnBYtkJzuH5AapjAXD819QKQrZrFetb/F
	 dyjFHIQoTM17huXrb0xzgi+usNIlxuu4KMqBp5Qb+U6yG54z3aLcGF+Lb8xCE7iWeD
	 fV/EluU1gybgQ==
Message-ID: <e90b693a9452a5c28597b04c6d1aac84c7b961c4.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix EAGAIN errors in MPTCP BPF tests
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 07 May 2024 11:52:56 +0800
In-Reply-To: <24b54657-5afe-b4a9-0229-3bd30477936e@kernel.org>
References: 
	<4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
	 <24b54657-5afe-b4a9-0229-3bd30477936e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-06 at 18:02 -0700, Mat Martineau wrote:
> On Thu, 2 May 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > BPF tests fail sometimes with "bytes != total_bytes" errors:
> > 
> > test_default:PASS:sched_init:default 0 nsec
> > send_data:PASS:pthread_create 0 nsec
> > send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
> > default: 3041 ms
> > server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
> > send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
> > 				has_bytes_sent addr_1 0 nsec
> > test_default:PASS:has_bytes_sent addr_2 0 nsec
> > close_netns:PASS:setns 0 nsec
> > 
> > In this case mptcp_recvmsg gets EAGAIN errors. This issue
> > introduces
> > by commit dfa2f0483360 ("tcp: get rid of
> > sysctl_tcp_adv_win_scale").
> > This patch fixes it by adding sk_is_mptcp() check defore update
> > scaling_ratio in tcp_measure_rcv_mss(). Do not update scaling_ratio
> > if
> > this is a MPTCP socket.
> > 
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/ipv4/tcp_input.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index ad8fa129fcfe..39237d6713ee 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -235,8 +235,10 @@ static void tcp_measure_rcv_mss(struct sock
> > *sk, const struct sk_buff *skb)
> > 		/* Note: divides are still a bit expensive.
> > 		 * For the moment, only adjust scaling_ratio
> > 		 * when we update icsk_ack.rcv_mss.
> > +		 *
> > +		 * This breaks MPTCP BPF tests, skip it.
> > 		 */
> > -		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
> > +		if (unlikely(len != icsk->icsk_ack.rcv_mss &&
> > !sk_is_mptcp(sk))) {
> 
> 
> Hi Geliang -
> 
> It's not clear to me why avoiding scaling ratio changes when
> 
>      len > icsk->icsk_ack.rcv_mss
> 
> is the right solution to the problem. From the conditional right
> above 
> this diff, it looks like scaling_ratio still could change when
> 
>      len == icsk->icsk_ack.rcv_mss
> 
> Does the MPTCP code handle that case, or is that not exercised by the
> tests? Are you sure there isn't an issue with the MPTCP code where it
> should be able to handle the TCP layer updating scaling_ratios on 
> different subflows?
> 
> Paolo do you have any suggestions or notes?

Thanks Mat, I finally found the root cause of this issue. It is indeed
an MPTCP bug. And v2 has just sent out, renamed as "fix the default
value of scaling_ratio".

-Geliang

> 
> 
> Thanks,
> Mat
> 
> > 			u64 val = (u64)skb->len <<
> > TCP_RMEM_TO_WIN_SCALE;
> > 
> > 			do_div(val, skb->truesize);
> > -- 
> > 2.43.0
> > 
> > 
> > 
> 

