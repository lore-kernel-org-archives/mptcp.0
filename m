Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A22DFA38
	for <mptcp@lists.linux.dev>; Wed, 25 Jun 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844105; cv=none; b=guDAzDx8yzhnfyGfoVAFWKmCe0Wx/poCdNyERu0Ia4qcyMwyjme1zpGCrDE/ByYD/DGSQSVBPeGy/RPp8KpRz07IdbJoycRg0umdFd2jWU+meHwYFu4JuOh/ijt/Xon01Q0OMXxMQUa6W0Nd4bgd7vzZSMTi8cpVnlTFr5pYuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844105; c=relaxed/simple;
	bh=2rRu350h60JHsmwsHwJzodt622gtKWzq+OPhnEchrqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RWmpIN+Hcdlzfe9+IftRYbxI7muSRGxJsS/NjEWtHC0rxoYKc2z7NtfZ8/6fsAR53S1MnthyWSsLN+wZlYGj1wL004fkShCudH/AHyQIYe7eOvLhjGh8MimJCpiyH8wUxTWjKjgykJRAJbw/nrIElMZvgRDNdyKmsMkCZtizbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2JVBFYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2JVBFYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750844103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mAqAwTOZXkehu4n5rF4nF6gF35YsBdMKC3cn/fzrXw=;
	b=D2JVBFYdNb1J7+h0Uw25EW2R694ur5EdA36FOsoooJb6uS0rHK9f4hbPD3BXITJPzjTQXY
	kkld9T4bTQIJNWrpG0urThzMjIl7SNfGpbvD+uZ3bRcNTXmLk0eF3cj1i0+Hnq/lS9gS/L
	X9jKtRcSL87+nL0/+RtdtN0a/dqSVQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-DKtjNfBpPJOPA9RVnldVUA-1; Wed, 25 Jun 2025 05:35:00 -0400
X-MC-Unique: DKtjNfBpPJOPA9RVnldVUA-1
X-Mimecast-MFC-AGG-ID: DKtjNfBpPJOPA9RVnldVUA_1750844100
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so7147915e9.0
        for <mptcp@lists.linux.dev>; Wed, 25 Jun 2025 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750844099; x=1751448899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mAqAwTOZXkehu4n5rF4nF6gF35YsBdMKC3cn/fzrXw=;
        b=lWkZXeeLWrPBwhvDYmRUVZStK5sOYM7/zC9BhG8eVjKK2S1xtxNCmkk+NGuInS2R1T
         cD918eQ8x9fGAN0WwEi8v9f/9pRkg9Bjv8HJTGlu0OQvsxrT4TAj1/NG6LNyfoHNwAp6
         b/IsjJ75Clp+RAsUxtTqEuNWYbO5kYdvOO3zvtzdXSZf/Z4teqNrJLIv+aiWg1/jbBYO
         ZCzL/8fl6Kzy3ztNPFu8QuLBV/+5smz+e9ad+KxZncr72ksKCGrpvvy+IYY8/cYLWsVp
         5xVajriDDcDSBuUUg7H7hbso19XXpegKe9WXRFoiRyzBTuvVHOvncR51a26VRD2Zje9f
         Ypbg==
X-Forwarded-Encrypted: i=1; AJvYcCUS7fLutF0FFczgnxAkbURBKbEwRG7mxAtTOJ+3GD5W6txDsTmTL9MhYWuM8vcS7BCZDzcMYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz06LRM2iFIMYcMgYAWBTsysQgEitTqJU4p++I3wJpkudY8lRLU
	EYl3nfTBZR18uuREztXU4O5D3bI6CASR51tQcFSKnEGTJLxQBf1PaQbqZRj8mjRVv/ZMfrnJU17
	kQXvDnPrcVI4MkfKNGc9Cw7GPYnDjHcE7I/u78sWtsrpsunFZgiLho+kX
X-Gm-Gg: ASbGncsEsHGXSEdcv9aBLBH8Ye2QiBeJmK0HjfBKzGtsX3EON81257PTGQVAIcDLa49
	zh8l0hZKKAxI5NMdcCjl+kP3pQ4FgJbO2WR09u9203pMbklszyThFbZjzWSOTd3lyU16FfKctwR
	Sgqdy9RdjIeXXq0gm2J71Nt73FO++9IHj44JbWhWkvflVa/zBeI8bZBVMgD1EUngkyp7cfqF3Ro
	SA9G2oZNQ8PDUNlUQXh4VVou66lwGkuH/blv754E1Fc0hk0aA+6Fpt/XsXTqqAT+vFMJe4ZSZW7
	bgMNE5x5rDUuPxR9hF4X
X-Received: by 2002:a05:600c:c16d:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-45381aecd69mr19753235e9.22.1750844099564;
        Wed, 25 Jun 2025 02:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVkdjnYscaljj059nOuXtgs3DwQ8AuTeC7qCsDKRiosXM4d0YU/2WmfNVz/msXSSKT4XX+kg==
X-Received: by 2002:a05:600c:c16d:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-45381aecd69mr19752935e9.22.1750844099160;
        Wed, 25 Jun 2025 02:34:59 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm14047705e9.1.2025.06.25.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:34:58 -0700 (PDT)
Date: Wed, 25 Jun 2025 11:34:57 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
	geliang@kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net 07/10] netlink: specs: mptcp: replace underscores
 with dashes in names
Message-ID: <aFvCwcH2mJ2WxFYv@dcaratti.users.ipa.redhat.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250624211002.3475021-8-kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ggbNKdYYa_bQNsjLl6wRGRfBjgqXZvsoB8VUIgOerYk_1750844100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2025 at 02:09:59PM -0700, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: geliang@kernel.org
> CC: donald.hunter@gmail.com
> CC: dcaratti@redhat.com
> CC: mptcp@lists.linux.dev

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

