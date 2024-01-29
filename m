Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63055762
	for <mptcp@lists.linux.dev>; Mon, 29 Jan 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520950; cv=none; b=aJXKe8UT7NnUMZJKSp8cMxEJTfMFoHje0/KCTq+RxETc/w0RQ/otCkm1U/kFFs8OO+1nR+2r8o4AkVEHRuNp3XDgKqtRLwGR6a338aaxmNFJCDEEkyNln4bMToP21Gn5GICnIQQChjWMj1PjCytx4LaONJQh+uK1Jjlxngi/tOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520950; c=relaxed/simple;
	bh=623EtBHyc5Sp5oRhsO6EXNWtK7glvokLIx+V+0f958c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riN/2tjaJQJWrE9XdmGo9hm+PpgU+KdTcsYAkqD3goP7kQKPQMkLisc0AZOVSJhgjrDowOtetKK0ngoajp2cukFvY8aFyF976TvXkLsbAKOGjCeET7OI2I6+bNN4P3heo8zWO1aQNe91tkcI9bTgFV6bgmQT093ScdGygVbb+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2WzMklI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2WzMklI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706520947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=623EtBHyc5Sp5oRhsO6EXNWtK7glvokLIx+V+0f958c=;
	b=V2WzMklI+5de6dLHOEIIzk4qRJtv25L1OWpFhGi4WymXugZn/22Uxv397a+J5dKNMkdK0Y
	qPuxVb5QjxAmJAtco82tlNUaKKkTkizwSODZQ7KpuYzFAZEgD3cxiYMJhClCcOy0uWXTAE
	rD09pommlKJUHBgz3ThKJd2HVXYtNZQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-vMfYQp5-NNy0rL2RnWgBLw-1; Mon, 29 Jan 2024 04:35:46 -0500
X-MC-Unique: vMfYQp5-NNy0rL2RnWgBLw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-595b165ba50so845710eaf.0
        for <mptcp@lists.linux.dev>; Mon, 29 Jan 2024 01:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520945; x=1707125745;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=623EtBHyc5Sp5oRhsO6EXNWtK7glvokLIx+V+0f958c=;
        b=s+O2SHrrOAMPN5G8nDwHk/mdLqNNIYP4RSqRnfOykusdyGlWv8uhesPGakIdBBvL7+
         i+RQPs1VPq2ArU1Eww9Qz8tCbKhPrDipxeQ6Yybq5O27nAHEFPQb733XVAuC60/fLfUN
         PL5Pljc4DF8/rZY+l6x0tJfVByydW/LF8JDgzxQr5EVMfWGSZUufhEQWRKFdTRzn1QlG
         0W/PBpMjww1GxlOSpH2EnKDFsF6IqjTxnWVWYueOTRcCIlj/PQcnBotAa4ymeHBqsja4
         SxtATJazyzRhc4fjs2erqLFQV5a5gV7Yro6UPHIkSSY9SuZoqBJYzyPG8C7Di0H2twP+
         tmoQ==
X-Gm-Message-State: AOJu0YzTZ+a9i93KF4EaRN4g86l4R2HnJDQTxKco+OTMB3F5dS+XA3lq
	s9MUCL+fhAW9SOgawmM7il2lHGzihurBCi3z/dPYasXJ26RuBOxbvypPmk9x9eh2MzJdcYdVrLv
	Mv+Ej7OMYOBKV35yfZNsjbjbtPxOkJL8Nq721zmG88tHA/L7jOdfPy8ZEHW+5
X-Received: by 2002:a4a:bd8c:0:b0:59a:bfb:f556 with SMTP id k12-20020a4abd8c000000b0059a0bfbf556mr6065513oop.0.1706520945255;
        Mon, 29 Jan 2024 01:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeC/2/liWCrrZAJsKlqLdHzygekBE7emLJS+6jkdP9XVu34tRIOSi89tXeliCABntOVjQrYw==
X-Received: by 2002:a4a:bd8c:0:b0:59a:bfb:f556 with SMTP id k12-20020a4abd8c000000b0059a0bfbf556mr6065500oop.0.1706520944915;
        Mon, 29 Jan 2024 01:35:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-151.dyn.eolo.it. [146.241.230.151])
        by smtp.gmail.com with ESMTPSA id c25-20020a056214071900b006869dae6ef2sm1698072qvz.106.2024.01.29.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:35:44 -0800 (PST)
Message-ID: <482549332bcc96a8b4dd37292cb289b271b49511.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: really cope with fastopen race.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 29 Jan 2024 10:35:42 +0100
In-Reply-To: <89ef77af-b4b5-8674-52e0-92405a0c0ea9@kernel.org>
References: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
	 <89ef77af-b4b5-8674-52e0-92405a0c0ea9@kernel.org>
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

On Fri, 2024-01-26 at 17:18 -0800, Mat Martineau wrote:
> On Wed, 24 Jan 2024, Paolo Abeni wrote:
>=20
> > Fastopen and PM-trigger subflow shutdown can race, as reported by
> > syzkaller.
> >=20
> > In my first attempt to close such race, I missed the fact that
> > the subflow status can change again before the subflow_state_change
> > callback is invoked.
> >=20
> > Address the issue additionally copying with all the states directly
> > reachable from TCP_FIN_WAIT1.
> >=20
> > Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
> > Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
> > Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> I wasn't able to reproduce the CI failure, and the change looks good to=
=20
> me. We'll see if CI is happy when this is applied to export-net.

I used the repro provided by syzbot upstream:

https://lore.kernel.org/netdev/000000000000e8ecae060fae7a47@google.com/
https://syzkaller.appspot.com/x/repro.c?x=3D17abc23be80000

with my default debug config, and here it reproduced the issue reliably
on the unpatched kernel (and no splat with the patched one).

>=20
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thanks,

Paolo

