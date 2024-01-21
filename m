Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A015FC18
	for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873637; cv=none; b=uhHJqvAbgt4JWrnueL343HsaU98qLRD5LIoRB3RXhr97Yu/ipKDfN80syXAut2j4DlWr/abBfkd67jfBQLJISQjltnOmjoyj7W4fdHSnYiyHKXFC4slFYqfiRPYKSj3YcveTQWNFW9Vn92U8IOm6M1wA1seaLn4SHMehRIEZMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873637; c=relaxed/simple;
	bh=siP3TKr8Tvzxarx+ZkPHN0rBiuntap20HIGs0ylYJ+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VU7hGpXGtI9WjJt1Rv3IIHXqL3A5Hq/y8GtrrY9mEtMO27NkwsmlxYyfA/yRIOBg+X0taEYcawNoeU/VFSlzUSS7WCOzsTIPjdI/FjcUnmGU52+RPifDJeR2lLwoSdqeh1yd+kYD5O7gb8/JyB4Em+N/ZiREZsSsyipiBop1DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbfH/pZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbfH/pZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705873635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SlhWCq9Fq99eoDClFdqnLhO+aBx5O0aL/lHG7U/P36U=;
	b=QbfH/pZUn/6jeFztR5HqNfd4JPWaeYVdmhEdFr1QjPk0VsFuz+4fgfQRxJraGwH4mH8Utq
	1o2vWbVbr6maf6/pibl1BHkewxiA25smnLi/0JbMNpb608KY/YG0o3gLCvsqEg7Epp0LtR
	s5e/a2NZXGQecSpZPmlbGexUOn8cJeY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-dJpN15EdN--qsElgHtjpbQ-1; Sun, 21 Jan 2024 16:47:13 -0500
X-MC-Unique: dJpN15EdN--qsElgHtjpbQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830635331bso91785585a.1
        for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 13:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873632; x=1706478432;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnN45O/eZJmCJkPYMBfs2ibL2+7X2dXLQiqv24iqJcU=;
        b=cyGyxD7Q65sBQu6PkfNqQh1GoJdiyNoXYyeftfHQ5DAHOMjDbC0PVdyYi/q788MYy+
         2a5JESMCZn6t9uEB+NgCP0gLeetGXdRRYN69huqutTtTWxlIWIyV2eVLNqIRg0akPnn5
         DEdr+PRx4BWzNZxRTYUV3fSeYoobLPx9kSDmpXPOK9GUPNS066swzb0Kw5saSikYnDx4
         Mqo/s4Y4xPsU/NCJXqlNFIwKwKi+exNsT2vcnHVV0rmbE7d/Dz9UUNlla/PAiNlKY7Qn
         gyvmyUQFnaRi4iz9/DhqYF9mXAldefnUGHFsnOzHzFNp14ncNztCAANv5tsUYOvPhXZO
         SF4A==
X-Gm-Message-State: AOJu0YzceN75fLyxghXxDI7o//CQl9xRcqsTUVR2rzYa6+AznAeUovWd
	mLnfCdbObzuhnMNeUzoeGPZPYBCFnY/vrWIU/OBbzrPlv5FxQ6gtvPzD7T+WuQx2ViYec0zGUB2
	bd65W+XJmvQzQ9dHQJpEjSgOd669Y/ah2NfBqckYQrJuxExGQRulLq0twzjGF
X-Received: by 2002:a05:620a:2889:b0:783:8e22:e218 with SMTP id j9-20020a05620a288900b007838e22e218mr6622922qkp.6.1705873632187;
        Sun, 21 Jan 2024 13:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFLdWxsBi/kdsizI8zUR5/877MhBBoiDekjJNizz+4ODMvSLXLKgbWROM4I/rTFgDipLDRSg==
X-Received: by 2002:a05:620a:2889:b0:783:8e22:e218 with SMTP id j9-20020a05620a288900b007838e22e218mr6622909qkp.6.1705873631800;
        Sun, 21 Jan 2024 13:47:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id bk21-20020a05620a1a1500b0078353f07523sm1613186qkb.1.2024.01.21.13.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 13:47:11 -0800 (PST)
Message-ID: <063e86ef8d80ed39d8f257f9cca3651f9b46d500.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/5] mptcp: annotate lockless access for the
 tx path
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Sun, 21 Jan 2024 22:47:09 +0100
In-Reply-To: <348ef69e-3d3f-fb7d-2388-174ef14e3209@kernel.org>
References: <cover.1705427537.git.pabeni@redhat.com>
	 <92930a7b962611507f4bb87671d97f526ece5952.1705427537.git.pabeni@redhat.com>
	 <348ef69e-3d3f-fb7d-2388-174ef14e3209@kernel.org>
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

On Thu, 2024-01-18 at 17:03 -0800, Mat Martineau wrote:
> On Tue, 16 Jan 2024, Paolo Abeni wrote:
>=20
> > The mptcp-level TX path info (write_seq, bytes_sent, snd_nxt) are under
> > the msk socket lock protection, and are accessed lockless in a few spot=
s.
> >=20
> > Always mark the write operations with WRITE_ONCE, read operations
> > outside the lock with READ_ONCE and drop the annotation for read
> > under such lock.
> >=20
> > To simplify the annotations move mptcp_pending_data_fin_ack() from
> > __mptcp_data_acked() to __mptcp_clean_una(), under the msk socket
> > lock, where such call would belong.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/options.c  |  2 +-
> > net/mptcp/protocol.c | 14 ++++++--------
> > net/mptcp/protocol.h |  2 +-
> > 3 files changed, 8 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index cebbd0bc32aa..51b00d7e7c89 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1061,7 +1061,7 @@ static void ack_update_msk(struct mptcp_sock *msk=
,
> > =09=09msk->wnd_end =3D new_wnd_end;
> >=20
> > =09/* this assumes mptcp_incoming_options() is invoked after tcp_ack() =
*/
> > -=09if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
> > +=09if (after64(msk->wnd_end, snd_nxt))
>=20
> Is it ok to remove this READ_ONCE()? The snd_nxt local is stored before=
=20
> the data_lock is acquired.

You are right, READ_ONCE is required here. This is outside the msk
socket lock. I'll send a v2.

Thanks!

Paolo

