Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82391347A6
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elevwnzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699369148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYTjNdwiO3GnpnFD/zQifiWfCI2CB8JjC/IxwUqeieY=;
	b=elevwnzQwlk//UV1cv39l+NEFWn8uR3pxDImwKR71+rJQ+U3GFEXGv+PB9xribXvPmGrA+
	zpcwYzeTX8m9jTr8jrAVVdm29suUp4nJP8+J6knZDNcIdDCZ5dHt5lE4/Auoi3Q3da9vVR
	KBKeaU8Rny1yn4b/Po/oQA95oqNK05A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-WcD9t6TWOQyggbszrvWBvA-1; Tue, 07 Nov 2023 09:59:02 -0500
X-MC-Unique: WcD9t6TWOQyggbszrvWBvA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5435b614a0cso784571a12.1
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 06:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699369141; x=1699973941;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYTjNdwiO3GnpnFD/zQifiWfCI2CB8JjC/IxwUqeieY=;
        b=gv9kSrJjDjBw9DlVpko7hpDrwOQ1r+wt6HYhxaM7jmp9Hh8Qv5AJm1CXfIJ1p1mDtw
         hu5BwqQ3FYcOZERFwEgu1+zVQq/5ngp6KE6GfF60PfYBG+15LaJ43F+Aa9lCnLVcQbCl
         FuJsIEpYNnTQKes1dPgjwqvMzIZAajyiJUeL1UvXdSBmb6GpyLDxEmOfOT9xKAHlo9wI
         hGVUP5x5xRpRxw0SchJ3jbkFCBFdYc/F4Do+a8d828Sub9E7e1NJt/nxt3gDUwxAFPVK
         1VWRMFBSH4g2rbvwQCSCDVwRbdSmmLqnGDJJgyqcJa5QVSkmKN46EcXmJbbIhZQifSPC
         0qLw==
X-Gm-Message-State: AOJu0YxKjEw7yd6Jo/HjG1ulrRpH5qPBaV8ZRVWI6KVELNyAUEQkCUnK
	Oy7omKUNOlYVfLoFTNeWaPz/rz7sBkaC1LgjblSeU5ynveVv0vewD8nXHm/WEPL/j+DZ7tGgw/G
	Ez292J2lMo3/mMck=
X-Received: by 2002:a17:907:6d02:b0:9c4:4b20:44a5 with SMTP id sa2-20020a1709076d0200b009c44b2044a5mr29589606ejc.4.1699369141191;
        Tue, 07 Nov 2023 06:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwd3gFJDDsjK6TqZpI9XtYd8PlhoQjF7fnRS1dTpx3Si6j5wmwz+LMpPCBZ0r4GhaYBHDvLg==
X-Received: by 2002:a17:907:6d02:b0:9c4:4b20:44a5 with SMTP id sa2-20020a1709076d0200b009c44b2044a5mr29589597ejc.4.1699369140806;
        Tue, 07 Nov 2023 06:59:00 -0800 (PST)
Received: from gerbillo.redhat.com (host-82-55-195-172.retail.telecomitalia.it. [82.55.195.172])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b009a19701e7b5sm1144758eju.96.2023.11.07.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:59:00 -0800 (PST)
Message-ID: <af0b44d9ca35964d3754dc1bd372a423cb695e4a.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix possible NULL pointer dereference
 on close
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Date: Tue, 07 Nov 2023 15:58:59 +0100
In-Reply-To: <4d50ae35-689b-5223-75c5-1b1845ab6211@kernel.org>
References: <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com>
	 <4d50ae35-689b-5223-75c5-1b1845ab6211@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Mon, 2023-11-06 at 17:44 -0800, Mat Martineau wrote:
> This does address the call stack that syzbot triggered. Are you sure=20
> enough that the only way to reach __mptcp_set_connected() with msk->first=
=20
> =3D=3D NULL is when mptcp_set_connected() encountered a locked socket and=
 had=20
> to defer the call? It seems like that *should* be the case but it's not=
=20
> obvious to me that it's impossible in every other scenario.

AFAIK, yes. msk->first is freed and the pointer is set to NULL only at
sk destruction time, by: __mptcp_destroy_sock() -> mptcp_destroy() ->
mptcp_destroy_common() -> __mptcp_close_ssk()

The commit message intended to point to the above even if a very very
terse way.

Putting the check in release callback - in an unlikely branch - was
intentional to avoid unneeded conditional in all the other cases.=20


Please let me know if I should repost with a more verbose commit
message (and addressing the typo you noticed).

Thanks,

Paolo

