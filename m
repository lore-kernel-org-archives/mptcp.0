Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FA38DE4
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736166; cv=none; b=TSy/NCOL2kz+w1e6revxUxdT/k7uk0+vtRqloYA361ldIVkgs6rRKmuOaL/J1Sbo4V658+B1kA83U7fQCH7Pi/MUksueKaeyypCnwaMAPQEYn+fWrL+bkB/HyP8Kyii9Pi8Pkaqbr9TzF64U5L+XAcJ3HJW79Wwk7On+h+i4AB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736166; c=relaxed/simple;
	bh=oxquBxXawKlS0sD0mwmU0haB447uwCw74IKr6Bh85eQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW6LIOtnI3IB33JilfxNy84aWZZFHpVr3O1nhyjGUh+o54JwYUgTcD4DUJRAXMQyYpAZHGumzVpf4uHKlfkRVx4pXwd/RdwcZDhPkzpQjQfJ3QM3G+DTIjpqNWlhyfw9YeeebgvCMwMdam0w0dvW/etYPjM+Uxv9JaA40GxIA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdppCNjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdppCNjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707736163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxquBxXawKlS0sD0mwmU0haB447uwCw74IKr6Bh85eQ=;
	b=MdppCNjmALmbpfZJpE12lf8JoqCXsA8SAEn0YPDDCZe2Cf2f8r4PmmMDmff2N7m0u00HHT
	W0I8XPPxf5awn+Gx8i/xQyrcT3G+nLFaRDG6pgbbYow5RZr3HMG3c393fJ0YnPVMWtkTEI
	5ApxImscfWnK9Wqhvq/c+IMf11CZ4rQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-CW-u9H6zMJSRfP7M3z1k9w-1; Mon, 12 Feb 2024 06:09:22 -0500
X-MC-Unique: CW-u9H6zMJSRfP7M3z1k9w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78130939196so184335785a.1
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736160; x=1708340960;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxquBxXawKlS0sD0mwmU0haB447uwCw74IKr6Bh85eQ=;
        b=GqtTsorhtsLz+0ggR7BFDlArzWYZyOtLxzwMZ4Y1FAk8rPLrQws9KCO0PwoZ4N6U7z
         tulHR2h2RCLZ31v4W778cMFbgT7lqA7sYC/IiERfwf2BXeGeYUnPRGa7PtZtQa3m7dcy
         N369pY68rdyPpLmOZzveNmvWBf7P83muDQkBu2uc0yY6Zx70O/lQh7+rn+QozbgoSXtP
         uz0wCllFPL1ziMvH+U4HDJx+NeqaZHSu3RAV3ZDk5ggdcJg5ZHAURUW9+uBhbgy5X6Ge
         hAjRCb0nNAcfyxR5wbIlQlvtQhozHY2HSlelIRuOUwAUpB8CD1mqKxHysq78g8vHuIph
         10eg==
X-Gm-Message-State: AOJu0Yz+pc0EfQW4JoSnhJenobDr5oVOxHXElmBvpP3LpkJpu7i1fT7M
	0y88L4lilBfrZVB6SI3o7qC9SLrYCWdU5Gp/1iIjqazFU01jxHA0U2ZHJkxoH8D1bOlF3rRgGkq
	CJng16NEDLJ7DluXLj1KjNuMq+beBnpdJ+1G2b+ViFYzrpOthZrLx
X-Received: by 2002:a05:6214:21eb:b0:68c:b693:6b31 with SMTP id p11-20020a05621421eb00b0068cb6936b31mr8685577qvj.2.1707736160586;
        Mon, 12 Feb 2024 03:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqnhCLAhGUSBBAf5bGPjJu72xVjSxkvdHq2gG31LNBSYJ8/BGNDgbT91QFlxQs/Zu6aiGdSg==
X-Received: by 2002:a05:6214:21eb:b0:68c:b693:6b31 with SMTP id p11-20020a05621421eb00b0068cb6936b31mr8685564qvj.2.1707736160217;
        Mon, 12 Feb 2024 03:09:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-233-147.dyn.eolo.it. [146.241.233.147])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b0068ce9f8df8csm43614qvb.115.2024.02.12.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:09:19 -0800 (PST)
Message-ID: <c817c679c011d28479d48dd9fabc2591844a86cb.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/7] mptcp: fix potential wake-up event loss
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Feb 2024 12:09:17 +0100
In-Reply-To: <57919905-c224-b7b6-1a66-54550487973b@kernel.org>
References: <cover.1705836321.git.pabeni@redhat.com>
	 <27f976d6a8f1a88ed5ad3822af43d0fc648ab9f8.1705836321.git.pabeni@redhat.com>
	 <57919905-c224-b7b6-1a66-54550487973b@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-02-07 at 17:57 -0800, Mat Martineau wrote:
> On Mon, 22 Jan 2024, Paolo Abeni wrote:
>=20
> > After the blamed commit below, the send buffer auto-tuning can
> > happen after that the mptcp_propagate_sndbuf() completes - via
> > the delegated action infrastructure.
> >=20
> > We must check for write space even after such change or we risk
> > missing the wake-up event.
> >=20
> > Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
>=20
> Hi Paolo -
>=20
> These first three patches have "Fixes:" tags, what do you think about=20
> applying them to mptcp-net instead of mptcp-next?


I'm fine with that. I send them together because are needed to allow
TCP_NOTSENT_LOWAT working in a reliable way.

Cheers,

Paolo

