Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A583A3821
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707544; cv=none; b=cYDMEDJTC/Cskdx4VlMjTlNNMidlFYmc9J+o36N2PS+sYfY2nLQHMIphqnLzQFc+nyzeflEwMWCzdtmbV76CRJPAJgr3Xu7YYTowk/ADU5e1kOhUBhhOSjGDXsfCJbfbn/2GL/h+i2TG4znRZ1sJGKLuiXm/Q0UNFp08Bacwj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707544; c=relaxed/simple;
	bh=JitOUBw6cvwjbSYLtaEAFVMqEwbcYf7juD3IqbwwapA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YeFh5kDwbV0Q4FwvDOMHIKptl2UeMPjar/35BPaZCT4Mn9kO9RN4OjuJLgWpxGbREH4LXQyY9A4Pn4tiqVG3Wd9bElTVkdhanFTGZ2fbmNmzw7BiqHpORJGp1jDebDg6aXTwv0/rvF63AXG9aaYl0NZpp7yscLv9nDGjW8nZ/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnnLatdZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnnLatdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786707536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JitOUBw6cvwjbSYLtaEAFVMqEwbcYf7juD3IqbwwapA=;
	b=SnnLatdZ4Wz7VCS0i2pKvrCmjHi3R5K2tAirxEgv+HQWSb+uA30LjIzkPrL1LEQfr/Iyhf
	o5B0/L+VJ7WhdwkVA1OiRJ5hwkkGsp+uD6u5MXU6pBIe6I4ycJQOedumxddLXZvF6pl9iR
	soNZypnyp5ovs0dWjoirRwdyq1tfFSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-lehjGLiXMsi03yGWy6ubHQ-1; Fri, 14 Aug 2026 07:38:55 -0400
X-MC-Unique: lehjGLiXMsi03yGWy6ubHQ-1
X-Mimecast-MFC-AGG-ID: lehjGLiXMsi03yGWy6ubHQ_1786707534
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4997b060af8so5629955e9.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 04:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786707534; x=1787312334;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JitOUBw6cvwjbSYLtaEAFVMqEwbcYf7juD3IqbwwapA=;
        b=GGw6QoPFvCFmNO30ZpehO58Ck7weW57zJIAf8L+UpOlaqRCHjpWi6A6ZK7DgatKLEI
         2fbYhookPhBDFfIQlR4UBAvPYyoploAivtcYOs+gq8tqpXN7nUrWA92Qdq9OYBHHcsEI
         +RqG3i/cz1bm9nJSNUOX7gat8l+Am0ZPLY01gZhdn4C7tOdjaT776WJBVo7V1vmgtkGS
         hlLgdC3zXgguEI495XWpww/aJxqClVpHEzQsIkVS9c2/sMbl1ymOzukk/oPecLpJJTH5
         /aTD0740yEHEbW9MXsIlb82p4kzp9dhyy+tZQmXbRJ2/RzV6EUD09Gxvlc+N7+KdEjSm
         mw4Q==
X-Gm-Message-State: AOJu0Yz9sMIUDy8hPQ9q/Kev3iLE7QZR09qoQNZvFM8K7xJyuT9WNf80
	2v8CtttaQI3aOQVVTwbb6VgKsXucezx9umqWl3ckS2WX6F7Djxp5jt0UDgjzkEfAsk/oVUZoGOl
	FmB7IFMqt8cXwqsPvGvYyLzhVkiOXPBbxoC5XLpbUtiz3jt06yBOeOVOF
X-Gm-Gg: AR+sD113yAcpjJIzkDvDyWSbmhjVm5AXw8hzkKDtTywdb+Rr0FlwmbiYVYw0TRgDyqM
	DqRSM2Ld94jgkcl1q+COVSJS6s2UBCocSntUIQkE2bSXAmAtPNBHHuLwWa08cgOCa2TWdrDUyL4
	rDT0O1qREPjijFYpENn80m+4HHgUQ/lskowVknQwjGl1+atFV2SHptGbKQK/YFhoRd0/ROuGuSv
	YXj/Tki/yzkjlNEWKPHJ3btRO73CfPoSLn74Hv+qVlwvhwSxUrkYdHrcwM5RXym/NHOOlwVrm63
	2V5CeNFCXoFjYF+hB85o1hu5BCGEvPaJewswQsAjtCX2bb3o1j4I+fZqYth44sxBapKbG/8e3/f
	wxJq4Dl3pk9sPrKt931glfaxSprI5pk6QLD5sDmtYFCTtXxWTeC+xRX+VUkmOGpP7QH9TtDN9ZT
	A=
X-Received: by 2002:a05:600c:4f56:b0:499:7312:2d5f with SMTP id 5b1f17b1804b1-4998799eb7dmr76215305e9.19.1786707534052;
        Fri, 14 Aug 2026 04:38:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4f56:b0:499:7312:2d5f with SMTP id 5b1f17b1804b1-4998799eb7dmr76214745e9.19.1786707533692;
        Fri, 14 Aug 2026 04:38:53 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998b1593a2sm3267825e9.13.2026.08.14.04.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:38:53 -0700 (PDT)
Message-ID: <2dc0fab3-c66b-4249-8593-122ca4be23f2@redhat.com>
Date: Fri, 14 Aug 2026 13:38:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/4] mptcp: a few fixes
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1786553006.git.pabeni@redhat.com>
 <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>
 <0858d963-e20e-474a-9f03-ae5d323ff6d1@redhat.com>
In-Reply-To: <0858d963-e20e-474a-9f03-ae5d323ff6d1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W27Jj_6DOoDC7lXJOS4HD13eXtGON-6cvOS8J89cPwY_1786707534
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 8:34 AM, Paolo Abeni wrote:
> Staging the series a little bit in the export branch will give some time
> to ponder about a better solution.
Slightly related, sashiko could not apply the patches. I'll rebase and
re-send them to get such review.

/P


