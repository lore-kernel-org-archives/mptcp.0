Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA13D535
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599625; cv=none; b=faBa7Ek3j6SveSX5YFdvhd4hImjH2xYKtOFGNWL7CnZ8kvSl+qZKmI7Ld6Tudhz7HyngSY5e5gUC9xunI+eOYuQvq8fC6nc19lYeoAnzOpIrV7v9r4xZhJtDiz4r6L4PutBqTdmletYhEpIqv+EDKMIKndrkkHZF9khVO7r5sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599625; c=relaxed/simple;
	bh=NJd5G1bpD5qj/ikMxKLpjtX79W2Ula6dJWQH3FDIcak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2tmT00q2fILUFZvnyC5QIRW9RjvEfIvglZm7GItgzKNWIt9l24PyAv3T5bQLkyAHNtnLj5g4I+tOzhGqnIApbpI8HGcquUll5IAkYsQ345yXhPs4sRQc5UJ8GOzxP0CYMCJhhfJYGiPI8Qkp7H8bq0msyr5/UrX+6v2v1e0Rig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4M233Xk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4M233Xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720599623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=31sPR2uMHF6k3dOMuiTRsn8I2bU/HR+Lwe2s/ssxSNg=;
	b=S4M233XkdOqVtHq4IyAuzWVifYFN/ZllGMG4lnkcxylFd+BO6r5l1v4lPkHJrI7X1fUzoL
	3M2rt2NbaGggMj7qQVsxMl00dzmQFxQlMaJJlvDIpV5HZSY1dpZuT+5kTx7NsDWN07vVBg
	/7wyPeHgO7grnnYzsoKA1WbY0lvW37Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-FPQphBcuP5yGzq9u0PTmjQ-1; Wed, 10 Jul 2024 04:20:21 -0400
X-MC-Unique: FPQphBcuP5yGzq9u0PTmjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4267378f538so247975e9.1
        for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599620; x=1721204420;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26mZ7S0u9xIT66u5JdYOfSqAurJT73tsuXjAAA6MY9o=;
        b=Wx/uPNHZrbnZzLyzZr8WRjH/AD9Km5GoR14Y8D9/zQ3nLL6iigK0y7AGSmdQGj8vrV
         QGoGY5Cy4ZxW20h9Pebi/bXFvAK070hzIZeJulJHGP1LPXFHePe2mvxRhgv5H7grujol
         9z2bJgmF5tmGSMQQOAXHJFWcxEQTCaSb2iB7e6AI3DOTHDnv7j3TQHq5FPtu2fz2BOud
         cnzeCkHAlOesGXkcI/d4up1Wu7QBhRXARYxmzTH6bp1Vh9X++yTiJJwVNc45Z+wx3EbH
         cA+CtyZ3Xs7NXmKer7gycIIaKMhMosdSTAyZBaOWohdlNpDKd6DzjJq5xdLcEemZ0IF+
         POhw==
X-Gm-Message-State: AOJu0YxjSpdFImPpO7PwTv+AX5r5PFBzjTfTFf8BBNgLXoR2sjLAMqKX
	JFnQ8PewIV+HgX7y9je3TnjGET1zQ21Bn1MzyGjpPXuBV2Q+QtYT2bafx+gCjNBQ6/UXlTu/gMX
	J+huPdVYeDmBVFrDq+UEhyvVCjCC+Td4mxEBip4g3H3aFaY2pbj5GjCYK2fxmXk4=
X-Received: by 2002:a05:600c:5106:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-426707cee07mr30283755e9.1.1720599620278;
        Wed, 10 Jul 2024 01:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhWwlkzfW1Gn9A+3kbMRd/7fg6xWR6xtspUY2P1yi4JbUR2Dk9ZSO83DI05oUVQZONRcGwug==
X-Received: by 2002:a05:600c:5106:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-426707cee07mr30283585e9.1.1720599619864;
        Wed, 10 Jul 2024 01:20:19 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f736188sm71752235e9.31.2024.07.10.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:20:19 -0700 (PDT)
Message-ID: <a92c310c1bc914289f26abe120b85733d4382672.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 10 Jul 2024 10:20:18 +0200
In-Reply-To: <f7d368e3-1349-491a-91d2-caf79bd02078@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
	 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
	 <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
	 <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
	 <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
	 <257091ee7be591bcb9aafa0ab4caa4dbca11e4e1.camel@redhat.com>
	 <57efbe56-3ef8-4e3b-b425-8405aa3374bd@kernel.org>
	 <17523f5898468a0b63e57ffa3aef5ec97caf643f.camel@redhat.com>
	 <f7d368e3-1349-491a-91d2-caf79bd02078@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
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

On Tue, 2024-07-09 at 19:43 +0200, Matthieu Baerts wrote:
> On 09/07/2024 18:47, Paolo Abeni wrote:
> > The announce list requires a very small amount of memory from a single
> > slab. A subflow creation will require a tcp socket, an mptcp context,
> > and likely some lsm context, I think is very unlikely all of them will
> > be successfully.
>=20
> I agree, but I don't know if we should change the behaviour here with a
> return.
>=20
> Note that mptcp_pm_alloc_anno_list() can also return 'false' if the
> address was already in the list. It should not happen, but I didn't
> check if there were cases we didn't handle correctly there.

AFAICS, we should never enter that branch. In fact I think we could add
a WARN_ON_ONCE there:

=09if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
=09=09return false;

because the bitmap should prevent us from adding an already announce
address.


>=20
> >=20
> > The diff reduction will be just mostly for the trimmed comment, am I
> > correct? If so I think we can keep the code this way. Note that
> > most/all of comment above could be moved into the commit message
> > itself.
>=20
> For this fix, I would have only added these two lines after having
> called mptcp_pm_nl_addr_send_ack():
>=20
>   if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
>   =09signal_and_subflow =3D local;
>=20
> Or we take this opportunity to reduce the level of indentations, but we
> use a "continue" if mptcp_pm_alloc_anno_list() failed. WDYT?

I would go for reducing the level of indentation.

I think that in practice the behavior will be the same with both
'continue' and 'return': on 'continue' the next iteration will very
likely fail. Perhaps it's better to be avoid wasting cycles and/or put
extreme memory pressure on the system and consistently 'return'?


Thanks!

Paolo

