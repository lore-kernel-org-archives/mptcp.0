Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E173DA7C2
	for <mptcp@lists.linux.dev>; Tue, 16 Jun 2026 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591329; cv=none; b=cE+njRCPqR8ardUbhM5JbwLm3wbAu8baKLGWQA6P7BrnZpxsPgHaUOqOIeiOcP6zHieT6/Za7CT0Ly01D9azbq9jM5GOvHIH2KNRIAmCAF2PWBgbeND7ABoCnVq05ij0F63hqSdtCQ2mD2XAuesRrRYfOO+OTxQRYmWENy/oasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591329; c=relaxed/simple;
	bh=lvfOSZQbKY5/jk48tnFGy9Kvxw4bexxa/cECyc8STXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jawJWSPyqdq58ODDfLgwT+8ZVXSphJVntS1KA0S1vaXDDPDKoiD0d7FH3JAQyUMvvjjXIhusTqAqdW2bQRqNWg0YzItxL6Il9u8u0kEoVuqeAW4V4cEaAjrG/D7IgzPNdGebCBIKghVfkBqet6q7t/4Ejbf9C//kWnYTMV2TvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AuaRL27F; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AuaRL27F"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aYxGXpFAt+32492HrsCZrJhTUMpEHQ/ilnan+pMUHyQ=;
	b=AuaRL27Far9kG5VouEfKVwRTf4PAiCpZRg0tYB0fkrMmBeWysWOuypdUA8wkvgCX7d6ZV0nS6
	RLuafYvdF9l0DR2pStOClt8DQP1+watOuQ+ybiN8clK5uR2Po8QLhDFapkegamIecHG3iKg5zuu
	I9zonk+DmsT9dLGN+J1iJOc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gfcKB2HCWznTvW;
	Tue, 16 Jun 2026 14:19:42 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id C9A30405D1;
	Tue, 16 Jun 2026 14:28:30 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 14:28:29 +0800
Message-ID: <95552642-7b60-410b-9953-70e0b31a90e1@huawei.com>
Date: Tue, 16 Jun 2026 14:28:28 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2] mptcp: use configured TCP RTO min/max
 values
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
CC: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>,
	<shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>,
	<shardulsb08@gmail.com>, <mptcp@lists.linux.dev>, zhangchangzhong
	<zhangchangzhong@huawei.com>, yuehaibing <yuehaibing@huawei.com>, "weiyongjun
 (A)" <weiyongjun1@huawei.com>
References: <20260611064937.422416-1-kalpan.jani@mpiricsoftware.com>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260611064937.422416-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi, Kalpan

On 6/11/2026 2:49 PM, Kalpan Jani wrote:
> On the TCP side, the min/max RTO can be configured via the route
> ...
> ---
> Link to v1: https://lore.kernel.org/mptcp/20260610101123.765958-1-kalpan.jani@mpiricsoftware.com/
> 
> Changes since v1:
>  - __mptcp_init_sock(): seed icsk_rto_min / icsk_rto_max from the
>    per-netns sysctls so that the helpers return meaningful values
>    on the msk (MPTCP does not call tcp_init_sock() on the msk).
>  - __mptcp_init_sock(): use icsk->icsk_rto_min directly for the
>    initial timer_ival instead of tcp_rto_min(sk), to avoid a
>    lockdep_rcu_suspicious() splat from __sk_dst_get() at socket
>    init time. Reported by the mptcp CI on v1.
>  - mptcp_set_datafin_timeout(): add an ilog2(0) shift-safety guard
>    for the rto_min >= rto_max corner case.
> 

Just a small note, in case I'm not missing something: this still seems to
leave the rto_min == 0 case uncovered.

This can be triggered from userspace with a route metric, for example:

  ip route replace 192.0.2.0/24 dev lo rto_min 0

If that route is used by the socket, tcp_rto_min() can resolve to 0, and
mptcp_set_datafin_timeout() would divide by zero before the max_t() clamp.

>  net/mptcp/protocol.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a4f7e99b30db..878a0c023f90 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -563,17 +563,19 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
>  static void mptcp_set_datafin_timeout(struct sock *sk)
>  {
>  	struct inet_connection_sock *icsk = inet_csk(sk);
> +	u32 rto_min = tcp_rto_min(sk);
> +	u32 rto_max = tcp_rto_max(sk);
>  	u32 retransmits;
>  
>  	retransmits = min_t(u32, icsk->icsk_retransmits,
> -			    ilog2(TCP_RTO_MAX / TCP_RTO_MIN));
> +			    ilog2(max_t(u32, rto_max / rto_min, 1)));
>  

Thanks,
Li Xiasong

