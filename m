Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC3C8DB
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz/ayHA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702973105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/+vOW0n5EEuYBZY77nbcXgUDyissPPrOhwo2KeC+FY=;
	b=Vz/ayHA228ZQcZqDEnidb6FCWYk9RdLfgGRNz3WT/nU3kXlmrd0whH1e4NFjh+JtULSy45
	3srWo+zccSw3VAtRiTzPLaqzwhooqbV/No0JCOtRoSZLW8oJLOl+WazqXpqbKcLupPGP2h
	OIsSuurzyGkLxj6Xg9vYcJ8wZtHf/2w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-rBFHQdcTOt6yI46-Viw_cQ-1; Tue, 19 Dec 2023 03:05:04 -0500
X-MC-Unique: rBFHQdcTOt6yI46-Viw_cQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55348311ad0so326042a12.1
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 00:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702973103; x=1703577903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/+vOW0n5EEuYBZY77nbcXgUDyissPPrOhwo2KeC+FY=;
        b=S50Sno/IwztREl0QMrub5hWA1150YiXvjzPQQtDNTyC7xEHsqOAeHODIbLh9HA6Bp5
         iUZR0bTolJNHwuqsAqcVR5uHHLoh304XPYGTq/69ElnWnNHYWdkkacBMFLPFnG3gUCvW
         +gknGlOCAWK2J8GISRXv2G24Ux6z2XJGcDHtYRfcdHYmTBTcAhWTXHZyuZIuvzEmf1TM
         cMlFqUujpVRAWR6DJRATV5mp5M6b1JgqJF/bP4LiIDfsqvwqsr2iltYhk+yQSptSLcXY
         XNEo1P4lR+wPSI5dXt3QksAhkVzwU5fk93QlZJ82u2NRrhsSOHzdJycNfVNg8AKScuuf
         zg1w==
X-Gm-Message-State: AOJu0YzF42iF+2roGPaYf+anTShTa5hyt0TL+QzKfGDhwgHVNlcDNB9M
	py7H/1aqjT0h/+75jK4mPDgUdWjd895q1CzYRSBZ2UH65v3+jdnYhj9KBSWu0/Jp3r/rGyxnXwe
	ODNZL07iDYhoC4rUVdxNnpdY=
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr19021859ejc.0.1702973103014;
        Tue, 19 Dec 2023 00:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECQJfoUWFGfRvK1IVv+7FfwPWNSZ4uxcszL1YtlbRCWiC2lt2sVpaoixifkpsA238Z3Wp5Jg==
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr19021841ejc.0.1702973102641;
        Tue, 19 Dec 2023 00:05:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id y5-20020a170906524500b00a23552d55ebsm2405269ejm.88.2023.12.19.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:05:02 -0800 (PST)
Message-ID: <d2663469f30b05f4b38d250dd50678148cb55f44.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under
 lock
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Date: Tue, 19 Dec 2023 09:05:01 +0100
In-Reply-To: <ce5132c6a8e90c44835e0ed05ffe4e093dcd703a.camel@redhat.com>
References: <cover.1702889134.git.geliang.tang@linux.dev>
	 <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
	 <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
	 <2a3ded63-0abe-4f9e-a4d2-8d9342b25467@kernel.org>
	 <ce5132c6a8e90c44835e0ed05ffe4e093dcd703a.camel@redhat.com>
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

On Tue, 2023-12-19 at 08:57 +0100, Paolo Abeni wrote:
> On Mon, 2023-12-18 at 18:29 +0100, Matthieu Baerts wrote:
> > That's what I had in mind, but I was not sure if there would be an issu=
e
> > in case of error (and I didn't check), etc.
> >=20
> > But if there is no issue, best to move it there indeed!
>=20
> If __mptcp_nmpc_sk() errors out - or any other check in
> mptcp_pm_nl_create_listen_socket() - the newsk will be released just
> after by __mptcp_pm_release_addr_entry() so there should be any issues.

... except that such release will call mptcp_close() on the mptcp
socket. If the error happens in inet_bind_sk() or inet6_bind_sk(), the
msk state will be TCP_LISTEN, the first subflow will be already created
- by __mptcp_nmpc_sk() - and the latter socket status will be
TCP_CLOSE, causing a warn in mptcp_close() ->
mptcp_check_listen_stop().

I *think* it's would be better special-case this status change here
using keep using inet_sk_state_store()

Cheers,

Paolo


