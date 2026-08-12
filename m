Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B2424D7C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531393; cv=none; b=tMkp8jNs9w64NmDmgUVE8ZnipNqSGjUe0T/E5kWeMmCEic1J5zXMFZ1TLT2wm6hrv3NWQrvj0MgFZhhED18wnTCvXmN/Yzviy8EVyf3pXCgXgbZhcEZXq5gLo2X2YoMzFpFFB2G/8V0QNbSXiXMJhTWZaxbZlyfmZn7yniDh5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531393; c=relaxed/simple;
	bh=iByHOxw1MP/KpGEiS3fMwleTfklkDAv4NtPgGkCh5Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktXLGnqHKae1E6WjNNtmc8RLpa0gqNpp2C8a+Sw7v1BqeQbWqlHeiY1NtFdfUMZQDGbaMwCAPLLcqXWnto4AJi5afagym88JyQ1/92olymEPUDloQi+uYHgCAHyCyQm81e7dM4m687RO96UGTmRmqa7G7nxvPER4Sq3Xw+DAojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+eqw2gC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+eqw2gC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786531390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYXFQlex2BtnYQF7FkjXCggu00nP2bJaboaCmQ5nE8A=;
	b=N+eqw2gC2jTwX4OGnw5LcOjqWhtVDuticQz3/OJhpjJQdnOwSiFMp1Xv4CXs06cKVx1WXR
	1kgfeaXKSxQFgmnyy5JqR5LXuK6YAo9E9X6psPByxUVvki3rP9JcMfn/XSE4lgDTptkFOD
	5rpDQISeObvRgaPo/m+zjAtcKIc5BIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-EavFXGaHPw6C7YeanUmL3w-1; Wed, 12 Aug 2026 06:43:08 -0400
X-MC-Unique: EavFXGaHPw6C7YeanUmL3w-1
X-Mimecast-MFC-AGG-ID: EavFXGaHPw6C7YeanUmL3w_1786531388
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49545071724so8022825e9.0
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 03:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531388; x=1787136188;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYXFQlex2BtnYQF7FkjXCggu00nP2bJaboaCmQ5nE8A=;
        b=iyaWhj1gzwXD/LIu49sprjNgtpRlveVTqaZO6U9n/W+kYY1thf+Dhp+V7dxXC5A0sp
         su4LV3Q6R9B6Rp8+8edITUC/NHvMK4KA+SPZIwFJkvpdiIVA+Yn61QotZYhE3V3nMEFG
         hp0/OORuDstQlubXw6RjBVHC+VcadCvhvP6JZDUMcIxgaK9B6X+5Jqy+M/dCvz3Jj0AE
         uBQ7uN4al+YmplyRH1fwBNJmsiGMuawMcUZOLt3P16dHkfuQEKZuui+Eh3on2K/Gii6Q
         LoNMy2B2kpFg63n0GH8VficZs/DYZ6hP9oMBb0EIEkgdS1BhFrEiXdKqpkWweEKPdJy+
         7zww==
X-Forwarded-Encrypted: i=1; AHgh+RodMk5RS7pgPETqIWy3xqYvhtxoEA268cXnAJ6IpehOyh1sNbPg2D2tKluCkyZ+818nrQnHVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGb8V37JoYUQl0NR8DUrhqH8baPrvqBm6Kt3qTmoa1lyURcRAU
	CNxucCODiTXx86X0ZxmCDkxVCavVqMoFbcZ5dxX2OOigEG4eCgEeOYggDztMVAJWFXYc5jIR48z
	8i7cwtW9oLUbQI3AsUo8GfI6ElwSftYWr2zwPdPSxsWqdCK5Vg/sHIBqalyh96aY6
X-Gm-Gg: AR+sD12Co1zGdc8pmDrVK9ahryMA+qE6yXefeKrftfzXykSFYRmw/fYrRNe6T56XjDM
	92v6oaHLR5RwwH6ud1TMVzyTX+4Xf5BPndK1VVf4EQmEl/p6w78rq+16ENcI6hJhgoAffncyikD
	QK4BNdKfKMpc7fb6XO1dFiGDSlSc6ffDdN4/VO4KgbRbtf9NvUu2K9ISZW8XQV9PcLJkMNVBSCy
	PKqWSWSwtqF2sacou4JvypEC6QydbCAeC4mR6DUSVcF/+Q08F+BRmMZKngpM9L8kpQ6twjfo/3O
	ZkErOLFbrUV1S0mDn+L8qzAbz8FKuSho9j4GU1JcXvPh5AJgCSJZKOAt/KQY4Pzdfyd4thpq6dJ
	vVP3YBUPAwNK/D2v/pqot87+TQ2owvG9MTYz+Os3VyYCgDN6TMLvvJKZ//ZpgLUC8U1KiWVcMih
	E=
X-Received: by 2002:a05:600c:154d:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-4997c0fe6a0mr49627925e9.1.1786531387628;
        Wed, 12 Aug 2026 03:43:07 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-4997c0fe6a0mr49627555e9.1.1786531387190;
        Wed, 12 Aug 2026 03:43:07 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c98d205sm32790755e9.10.2026.08.12.03.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:43:06 -0700 (PDT)
Message-ID: <7edf1313-be99-41d8-9f5e-3842b9b6c75b@redhat.com>
Date: Wed, 12 Aug 2026 12:43:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 4/4] mptcp: fallback to TCP on MP_FAIL with a
 single subflow
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-5-chenguang.zhao@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260812054653.43799-5-chenguang.zhao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X56INmFRrf0gkF4Mf-gRAXrglpGtuxcNOPPqHVOYHrg_1786531388
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/12/26 7:46 AM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Fall back immediately via mptcp_try_fallback() after accepting MP_FAIL
> on a single contiguous subflow, as required by RFC8684 §3.7.
> 
> Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 9 ++++++---
>  net/mptcp/protocol.c | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8c263084db7b..cb85caf1df43 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -876,7 +876,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  
>  	pr_debug("fail_seq=%llu\n", fail_seq);
>  
> -	/* After accepting the fail, we can't create any other subflows */
>  	spin_lock_bh(&msk->fallback_lock);
>  	if (!msk->allow_infinite_fallback) {
>  		spin_unlock_bh(&msk->fallback_lock);
> @@ -891,8 +890,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  		mptcp_subflow_reset(sk);
>  		return;
>  	}
> -
> -	msk->allow_subflows = false;
>  	spin_unlock_bh(&msk->fallback_lock);

At this point another subflow can complete the join, and set
allow_infinite_fallback = false ...

>  
>  	if (!subflow->fail_tout) {
> @@ -901,6 +898,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  		subflow->send_mp_fail = 1;
>  		subflow->send_infinite_map = 1;
>  		tcp_send_ack(sk);

... so the this mp_fail processing will be bogus [1].

> +
> +		/* RFC8684 §3.7: fallback with a single subflow */
> +		if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +			mptcp_subflow_reset(sk);
> +		}

>  	} else {
>  		pr_debug("MP_FAIL response received\n");
>  		WRITE_ONCE(subflow->fail_tout, 0);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f879b1061f2d..519e8d9c3164 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1418,7 +1418,9 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>  	mpext->infinite_map = 1;
>  	mpext->data_len = 0;
>  
> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
> +	if (__mptcp_check_fallback(msk)) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
> +	} else if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>  		mptcp_subflow_reset(ssk);
>  		return;

I don't understand this change. Can we ever enter the

`if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {`

branch? The msk already tried to fallback in
mptcp_pm_mp_fail_received(). If the fallback was successful, the code
will enter the `if (__mptcp_check_fallback(msk)) {` branch and not this one.

Otherwise the fallback will fail again (AFAICS nothing resets
`allow_infinite_fallback` once in become false).

/P

