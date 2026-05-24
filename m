Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896A360ECB
	for <mptcp@lists.linux.dev>; Sun, 24 May 2026 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612968; cv=none; b=CcUZ9ElfLetuvtGzIO0gynaKGLqu5r1W+cLZbVLr51BM3m1yO/B+SjyaXvGNDjjJ7nbXpGjR+bRSINHrsGcdL8YJGTiGOLJTDHgI8w/hWzpsTwepq04zaVkwq9QvU3TRx72lyQE4B7FjcL2p3vBxw7O//1hFukgF8SfWfR2tJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612968; c=relaxed/simple;
	bh=njobClBQ3743wTHmXVIyt1/wkH1Vj3wePAedwzE6EwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qO7oLzykKO4gdZ07pxqiaLpMD0DDBvA9FGuih/ex0mBsBBiGdcTLRbgAyDIaVUixDxKpDWiyk2qMwSHr7m6xgxdDwddo1OoHlAxV5xNA50iJcyOUwAEXNG93setfbRKzIUDXf9vAAlPMLoI5fVqXicuChEpYvqEoPi5IPlfFNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWey5u8u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWey5u8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779612965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNt7Vlzz19lSoXlty5+IawP75KXDJrLtgP5C+ybUSro=;
	b=AWey5u8u/YN+oPotMkWlMBX4obpyO+IzAb8TqBEBJx5spSWcKG1Dw1aQT8tiBjSVtBFnhS
	HaFqEu2HXoLi6OKLWY8pf93r8+8Hhelv2BkZZJGaprJQHqb1CjtuuLD92L94NRCa2x9uqa
	/H9P7Auc0B4iYFrBYXuoVv314R6jVmA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-RgdItL3lO5Om_IN5Bf0u9w-1; Sun, 24 May 2026 04:56:03 -0400
X-MC-Unique: RgdItL3lO5Om_IN5Bf0u9w-1
X-Mimecast-MFC-AGG-ID: RgdItL3lO5Om_IN5Bf0u9w_1779612962
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso6006604f8f.0
        for <mptcp@lists.linux.dev>; Sun, 24 May 2026 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612962; x=1780217762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNt7Vlzz19lSoXlty5+IawP75KXDJrLtgP5C+ybUSro=;
        b=fVxqOTDg4CVufRNhZozn5iPteaAc8Udk/VAqS9rTZ50evn8E2WLQut3KfVu3PS2OwE
         c3yW/hZ95Ev7iQnkHF6NCENA77A6LCUDdglayHtZ4kbwDm4k/P4QWIW0rnIrkauAFamW
         94ZnKXtDwUTyZAgPYHPtYclh2TzaID7Pco2o0dhQb1HeXF/9fSvjf5OqacahQv+Eh1v0
         srTnNeaEw4qRAEXq6MRS3cQZAEABR4y9CrIeFdV7+VseY7y6QFbeSR5XpqrvCffE4WF5
         T9n/+1ScQsgelD3ypVNIUJMeLMaK+r0vAJeX9vmdtJM5RCzTIXV2A8IqkjU3PjvqWfk5
         9/aA==
X-Forwarded-Encrypted: i=1; AFNElJ8o9st1x0rgFtBqX/3z80XE1hgQImlhehb8Igu1Pm6/q794UstEUJL7sUGk1X/mCUy4Rwl/cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU6K+VAIIQYZC2DHoJKBxcyr7ef/8duaTK/w0+rxgUTjM/vqYC
	FqaguDU5t/EksnMZ679y938g6xs2hd6hnkVBBjmrtpan1MVACn8ITDgSAd3fIEbfWa0NCPE9537
	7QSEHV8fNhKJS/9Z5kFPdJYCbs2AGYXOlccur0vH2rFKdXt8dETPb7e/bEJDrLNCQ
X-Gm-Gg: Acq92OEvN3gPDd7Hh5piJqtxWChcAIZWlWMdC7kZbwAd00ha29clPfOf5/z5Sdg7Vc0
	XM9yIhJMQzxjXtWqIZtgOoJMe+ZIlF7sahXNbCDSJBaQ18JxJw1PtO23XqVTRtCmpFMD6WJ2bip
	NrAp5MIFW3Y07k00E1JD30UVo8gGUV96tVsLduGNLltuR8OKdFxWuDFMZTYyeJateuPKaM9N0Ji
	nUwahDgqqRNaFM2jJP6T2mgV9ysGBY+f++ugbojzwCRFRl9Z63Mn9k9v/b0iXCY4JwGJXyl95ek
	q2BYfqKkaTYCo7awm7hw8UZfqwFV5NGZlrhHN7EyKPhGsYDkcMQdRTFr2O7QtbsKHoxexHcu5So
	a+nkUACXAtPBAwGMybbt5sESbunq3m0QyMsDBwCBmvZMJ5c6iak2PgcQ4mA==
X-Received: by 2002:a05:6000:186c:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45eb38a650bmr18075902f8f.33.1779612962188;
        Sun, 24 May 2026 01:56:02 -0700 (PDT)
X-Received: by 2002:a05:6000:186c:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45eb38a650bmr18075871f8f.33.1779612961786;
        Sun, 24 May 2026 01:56:01 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm18356676f8f.23.2026.05.24.01.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 01:56:01 -0700 (PDT)
Message-ID: <bc2bcc9b-65fb-4246-b25d-c9160367508f@redhat.com>
Date: Sun, 24 May 2026 10:56:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RKCgl0dbQvEqxUDwG5cpyrRU0OsB2Swq_DTj_DRmr_A_1779612962
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/26 11:18 PM, Shardul Bankar wrote:
> A divide-by-zero in tcp_tso_segs() is reachable via __mptcp_close_ssk ->
> __mptcp_push_pending -> mptcp_push_release(ssk, &info) with info.mss_now
> == 0, triggered by :.  __mptcp_close_ssk() leaves
> the ssk in a state where __tcp_can_send() is false (FIN_WAIT1/2, CLOSING,
> LAST_ACK) and then unconditionally calls __mptcp_push_pending(sk, 0).
> For such an ssk, mptcp_sendmsg_frag() returns -EAGAIN before reaching
> its tcp_send_mss(), so info.mss_now stays 0 when the trailing
> mptcp_push_release() feeds it into tcp_push() -> tcp_tso_autosize().
> 
> Commit 1094c6fe7280 ("mptcp: fix possible divide by zero") covered the
> alloc-failure branch by moving tcp_send_mss() before allocation; it does
> not cover this -EAGAIN-before-tcp_send_mss() case.
> 
> Initialise info->mss_now and ->size_goal at __subflow_push_pending()
> entry, before any early-return path.  Idempotent with the assignment
> inside mptcp_sendmsg_frag().
> 
> Found by an MPTCP protocol-flow harness extending BRF
> (arXiv:2305.08782) via the MPTCP_PM_CMD_FLUSH_ADDRS kernel-PM admin
> path; the oops is reached on the first qualifying run.
> 
> Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/protocol.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a72a6ad6ee8b1..7977f60f98474 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1627,6 +1627,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
>  	struct mptcp_data_frag *dfrag;
>  	int len, copied = 0, err = 0;
>  
> +	/* Initialise mss_now/size_goal: mptcp_sendmsg_frag() may return
> +	 * before reaching its own tcp_send_mss() (e.g. !__tcp_can_send()),
> +	 * leaving __mptcp_push_pending()'s trailing mptcp_push_release()
> +	 * with info.mss_now == 0 and tripping tcp_tso_segs() on the divide.
> +	 */
> +	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);

Please don't add duplicated non trivial check in fast path. In fact the race 
outlined above is so thin that syzkaller has not been able to hit it so far.

Do you have a working reproducer? if so, could you please test vs the following?

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b..8fe93b8459e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1711,6 +1711,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					    (1 << ssk->sk_state) &
 					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
 						push_count--;
+
+
+					/* Prevent next mptcp_push_release()
+					 * from pushing data with 0 mss.
+					 */
+					release_sock(ssk);
+					ssk = NULL;
 					continue;
 				}
 				copied = true;

