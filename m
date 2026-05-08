Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6239DBC9
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235845; cv=none; b=rfFhqRlR4X5oQeNzdXVTyDgxilP7USBoHBLuKU0qcMzzb1XSCx8Ji6kU9xeNxG2kZwyStPnXXnkknkH/CJJB5xPCE8DL/oMuX4p3uKQJwK7JAgS9WQs6Na8UzDUMcY3iMfSwlupqFgVuguULKjoaSWiimJCoOVwln6zYIRc2TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235845; c=relaxed/simple;
	bh=V0S77WuEXUDfU2urKVEn7xkQzr0Ul1uEZMmvaVqcTQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJFOzOCN9hv0UVWIZL8bSrE4KqByUhOrAAsyk//4tsaFVV6kyM6SVtKwBu5auxoqWomX4l/7d7yeocli69/ctl5ADK4qFWMsR3jaTBcxh8EEOfmUflR5YNslSABUghkyZRcFsRmPkA5RsMgFPfE/Rvwvl/elUoj6UwQyaa1qgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5QpGj/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5QpGj/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778235843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aqqvi31nG0cLuop8j70SGka90++tg12ySoiLhybgfc=;
	b=N5QpGj/y+gXLKdIlz6TXwCyUjbvMPdkFWd4PKnBhDAgoM24qUMTEnLiT8kHGAM+vRee+ny
	hm2x8i3pPBFAOu53jAhKuX7AkA9oJxDpzE/j7k1ks/n/ZjU1hJtAQIeuIyIkUqTrzdiFKT
	gBfFV8/uwQtG2H3hCKuKNWUSnosF3So=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380--nu4fhq3P8KHKhiO80S5EQ-1; Fri, 08 May 2026 06:23:59 -0400
X-MC-Unique: -nu4fhq3P8KHKhiO80S5EQ-1
X-Mimecast-MFC-AGG-ID: -nu4fhq3P8KHKhiO80S5EQ_1778235838
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d0677b5f7so10859235e9.1
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 03:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235838; x=1778840638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aqqvi31nG0cLuop8j70SGka90++tg12ySoiLhybgfc=;
        b=L+xaCwAowr/yKyW6vkDxBL/1cIxjqdPsiRI6XaTbO2GIJSmlYNMWXhQf+4KSqx81vd
         SzumHsOWwtqPlRQ6yfbinZk2idI0Y0crzH1IwkFXoFZgVmGDKVRw8JTrGutjPwo1zY+u
         n+G6A5ABc3PPoufM9FuI34lfid9y+otCRei/AxLhoPCeEOTvPxiQne6zFzEHJRYEue9x
         ftw3gvKE/6Z+71HsRs7sxH4g9wAzZA8krOX/THCqCNwVvq7ztQqGL0TLykZze6uZpEAB
         t15Vxo4bxNHDuKQFWPMtCSoaqRlHHVoEn8jQsXe9ZwOKrPFhKeCdFGP9R6G8VV+x7Lrz
         vs5w==
X-Forwarded-Encrypted: i=1; AFNElJ/wnLs9NZizBibliiHpJyDBtB6bsC2inwvwEMsvrVR/XL+RMsu0Kdk+VY2ABSW98soRtloLnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJWsi7CYLx8RQVVflD99u6U6u/r+0t08Rrk0Ujs3RRdCMo3aV/
	UXQNm2RtWpkQG20vCHmXfmcnbpRnnfyQK/FRga3E98GF5XsOKEMxpOBjOVXXK4h1bTFonCN10Lm
	g0mewQMDFC2eTrNS7MWy59AZsrLQ67itD9y4tOvitXdOlr2c6ZxQEpD/c
X-Gm-Gg: Acq92OEP03R/Ko1yUerY0X0yC0lEgg2ZdqIGtyUJxTUz2ZRo8QwOh+YU1vASWn+CxLc
	4Iy3JUGCfTTLlO2z0eiq7LMiKttkg+2S5Mx/Pmh7vYtcytHSBPMM0gh/J6FiW5lR1s6TcbSKYG4
	y5r0/2yTslcpspmRUxU71YyzdSTdHYuLQeGhuPscM65M6zU3QSThSUz+HDpEEw9WmHW/fwlvJQ7
	j8W7xEVFh8HFRy1BlSFYeXM5hDtdQnzu/fVelcoUAjoj6BQniT7cjZPPYjTX4yX27lpgRMsOkCx
	E1kotIoHVK8q3fOBfr2XKRLf7vNlKUnW+MCwUPRW5mr07CwiZwLYGFpKU+Ent9rShNlSrkUcqeH
	9aGJeKfV0J6gZFy8whfNVCNDC5KQBu6onOf8EQBHScYDgyTd2hI4oRjJVbQ==
X-Received: by 2002:a05:6000:420c:b0:43d:7a97:78a2 with SMTP id ffacd0b85a97d-4515c5752f7mr19940556f8f.28.1778235838502;
        Fri, 08 May 2026 03:23:58 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:7a97:78a2 with SMTP id ffacd0b85a97d-4515c5752f7mr19940485f8f.28.1778235837943;
        Fri, 08 May 2026 03:23:57 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm3873533f8f.10.2026.05.08.03.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:23:57 -0700 (PDT)
Message-ID: <8988ea27-59ae-4ebf-ad7d-6e4ef3bf28ed@redhat.com>
Date: Fri, 8 May 2026 12:23:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
To: Shardul Bankar <shardulsb08@gmail.com>, matttbe@kernel.org,
 martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nyrxxw0dUxzGWU64W_-uNY0K9ROLTW1q22OiOmYDIEM_1778235838
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 4:39 PM, Shardul Bankar wrote:
> When a packet arrives with map_seq < ack_seq < end_seq, the beginning
> of the packet has already been acknowledged but the end contains new
> data.  Currently the entire packet is dropped as "old data," forcing
> the sender to retransmit.
> 
> Instead, skip the already-acked bytes by adjusting the skb offset and
> enqueue only the new portion.  Update bytes_received and ack_seq to
> reflect the new data consumed.
> 
> A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
> drop partial packets"), reverted in commit bf39160c4218 ("Revert
> "mptcp: do not drop partial packets"")) also added a zero-window
> check and changed rcv_wnd_sent initialization, which caused test
> regressions.  This version addresses only the partial packet handling
> without modifying receive window accounting.
> 
> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

It would be great if you could send a v3 addressing the AI comment.

If you don't have time or capacity, please LMK, I can send v3 with your
SoB and the needed editing.

Thanks,

Paolo

