Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2D192D9E
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370564; cv=none; b=oKuF30YjmJdyGCun6dxgJwIZVgPxmldLegPpL1BFm3Bb84GTX3GqVzlUH/I0bDbd53SvqxYryoVIHjpteEUPB7ekxP8eNRVlHODOCl4SxyBod2sEENhuJh+KmkdzdOQNIizhvGQJNjWRlZ3bziUdirjh++mKdNUq6arqfDlf040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370564; c=relaxed/simple;
	bh=bYNWhIGGbahcj4NAoHCM/JOfUlKdfx0pIWfZgGbjXu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VP0k5E3EB9sYVNe8RwfzNhNSPvizlXqNlcie1WSjEOXtzGN+dF9Iv3Uwn8REIyDWCWd66AfnYCCn664arkeBwqaI4VJwtUae5W+BR+BYiuFOtcGBD/zOeVhCpHeA40S57g6BaUNTtg1ytkDNnyzeFujFc03tUoTj0uHppl+JM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaG7nJsL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaG7nJsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728370561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tOv4xKuh8EzFtAeW0OqnWiMRBmIQxVPVDxXS8vtmEM=;
	b=XaG7nJsLQmsEpI7tIh2gD8pahDocQKjXZQ4Q1V0kiaHWLUxMdf3zyFOi6sjlSBPJRlx8bO
	gO0fThxxhYiAdlqbuSdcpiHhx+9xj5pfKTHZcxHWTz+nYUgRfmawL6gKFjHb2sYwdy2zzR
	sLcIlvVJAYU19Kkjfgil6bmsNvhZi7g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-pLeKyKPrOT-vofJxE-ivZg-1; Tue, 08 Oct 2024 02:56:00 -0400
X-MC-Unique: pLeKyKPrOT-vofJxE-ivZg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cd08d3678so2319615f8f.1
        for <mptcp@lists.linux.dev>; Mon, 07 Oct 2024 23:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370559; x=1728975359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tOv4xKuh8EzFtAeW0OqnWiMRBmIQxVPVDxXS8vtmEM=;
        b=fCdqtWG4Lq8lWvas874EDKEjlxrI1CkKBBcJ9S+VrRvUWuL+8vjgF6/1o4zXsGWn1x
         9ALK8pHcQi9+e7Li/Fe967N2/ziO9P2xkbzWwV3ONrs3Bbt6gKu6S7lVkrQH64hvOV1c
         naz3FuEIXdRWnae09oG4p6y448NtQ4rkKg4huwSSYUcLq9rAMMmPr/6s9wykb5DTPvcj
         DBmUj0QWL9AYInczsycov4tXYZVWIiaIIuDFHTaPmnqk2tP5llcggKv7L5QM54xTLoGY
         AmB6WXMhy97zHo9eZdlEHGNxv4B9uAG244OuNPMYKY/AID+TkCg5LlzIfM36Q4IME9bG
         ahRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZJ8OkocP6MY3CkNdQF61nbeqtgCqLSo4KlbSSiKyF4WfOQDjiv/f2I7uWEO7pMonWu6y/Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0KrhTdxuk2lxpOe/VwQcnVX2DPKEgdcHW98MeOgyTqjbu6wKd
	xn5lLs7f6S8LF7Oi59dNIwN0PHF/xDV9bmB0VFKa9gKZDnq8kKwQz9G3Gc4eF280/6JgwUuMNSR
	j3Z0b1dkTSv8+u2IKBnIrrH3kx/Gyh5ErnC1WEJ60OYO5NGyZhAgf
X-Received: by 2002:a5d:526f:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37d291b9fb0mr1265797f8f.6.1728370559326;
        Mon, 07 Oct 2024 23:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH0y4R4tq3sJZYPT0rfwFFxSrLVqU4xwoJhDGplIPZ+NDkc722kT2p85Ho8+9NEEBtMyPn1g==
X-Received: by 2002:a5d:526f:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37d291b9fb0mr1265783f8f.6.1728370558906;
        Mon, 07 Oct 2024 23:55:58 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430509725d0sm9409255e9.20.2024.10.07.23.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:57 -0700 (PDT)
Message-ID: <76f527b4-4a80-44cd-925c-9de397562345@redhat.com>
Date: Tue, 8 Oct 2024 08:55:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped after
 1st data
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>, Davide Caratti <dcaratti@redhat.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 20:43, Matthieu Baerts (NGI0) wrote:
> As reported by Christoph [1], before this patch, an MPTCP connection was
> wrongly reset when a host received a first data packet with MPTCP
> options after the 3wHS, but got the next ones without.
> 
> According to the MPTCP v1 specs [2], a fallback should happen in this
> case, because the host didn't receive a DATA_ACK from the other peer,
> nor receive data for more than the initial window which implies a
> DATA_ACK being received by the other peer.
> 
> The patch here re-uses the same logic as the one used in other places:
> by looking at allow_infinite_fallback, which is disabled at the creation
> of an additional subflow. It's not looking at the first DATA_ACK (or
> implying one received from the other side) as suggested by the RFC, but
> it is in continuation with what was already done, which is safer, and it
> fixes the reported issue. The next step, looking at this first DATA_ACK,
> is tracked in [4].
> 
> This patch has been validated using the following Packetdrill script:
> 
>     0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
>    +0 bind(3, ..., ...) = 0
>    +0 listen(3, 1) = 0
> 
>    // 3WHS is OK
>    +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] nokey>
>    +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
>    +0.1 <  . 1:1(0) ack 1 win 2048                                              <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
>    +0 accept(3, ..., ...) = 4
> 
>    // Data from the client with valid MPTCP options (no DATA_ACK: normal)
>    +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 500, nop, nop>
>    // From here, the MPTCP options will be dropped by a middlebox
>    +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>
> 
>    +0.1 read(4, ..., 500) = 500
>    +0   write(4, ..., 100) = 100
> 
>    // The server replies with data, still thinking MPTCP is being used
>    +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1 dll=100 nocs, nop, nop>
>    // But the client already did a fallback to TCP, because the two previous packets have been received without MPTCP options
>    +0.1 <  . 501:501(0)   ack 101 win 2048
> 
>    +0.0 < P. 501:601(100) ack 101 win 2048
>    // The server should fallback to TCP, not reset: it didn't get a DATA_ACK, nor data for more than the initial window
>    +0.0 >  . 101:101(0)   ack 601
> 
> Note that this script requires Packetdrill with MPTCP support, see [3].
> 
> Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping errors")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
> Link: https://github.com/multipath-tcp/packetdrill [3]
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Davide Caratti <dcaratti@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>   net/mptcp/subflow.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a1e28e1d8b4e39e14bc8f98164013d302d62595c..61482f8b425b5dde17a4f3272d04973ae5ec7849 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
>   	else if (READ_ONCE(msk->csum_enabled))
>   		return !subflow->valid_csum_seen;
>   	else
> -		return !READ_ONCE(subflow->fully_established);
> +		return READ_ONCE(msk->allow_infinite_fallback);
>   }
>   
>   static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)

Reviewd-by: Paolo Abeni <pabeni@redhat.com>

Note that when checksum is enabled the condition in use is much more 
restrictive. That should be ok in practice, as hopefully no-one uses csum ;)

/P

