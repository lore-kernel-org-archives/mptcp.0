Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199D1BC091
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617103; cv=none; b=ORfjGfNZF/dic2FVE9E6KoLzW0KWY2vF5kVv0Fg3tsj79SLw9F8dGyTRV1oYrgg3SGOG+0jjSSPnjRtb0aiWi+FPemnS43fKxfOCihif7jb+kDjx+K63okxVvoi8EF0tSQvnSPj46a7SYn0PVNSr6uB850PSbwsXOekt8/ARZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617103; c=relaxed/simple;
	bh=wvA+kM7C97UwQvYrcYlFrX7guraQiKdqhQdK5LdpmDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eImaWkOycz3jGnlqqG4z/nbtGVdDCVsYwkP+EgoGWLiE91vGsCa59aNssRzLhdZN+w0pWLE9lBuUIL/vwI7HfCOUnHsSYmWRbnURLkBfElF5ErXjxhz26Dq0zJgmTKEtLaQaRxOdyhWpstRBZz5E0JtC6Yh5V+nkyzOP55zfWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGT9wW8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGT9wW8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729617100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvA+kM7C97UwQvYrcYlFrX7guraQiKdqhQdK5LdpmDY=;
	b=NGT9wW8v87z1gaejEBZ5ixcwuUqGSvIDY6Pr6js51/T08hgvHDFF6VcpZM3PAVIdIWXNkn
	bvYNMsNuSGDSwz6A/7iIjzpXZpGD17/cGic8gaPhxCZqKJBKlGbnaSwxFC8QgcW8V2VcAZ
	hfVfzOZjFgMsnGdZ5YfRVx8ZFt6ddEY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-sO2gF6PXNIaY7zqJJzX6UQ-1; Tue, 22 Oct 2024 13:11:39 -0400
X-MC-Unique: sO2gF6PXNIaY7zqJJzX6UQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso5524333a12.1
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 10:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617097; x=1730221897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvA+kM7C97UwQvYrcYlFrX7guraQiKdqhQdK5LdpmDY=;
        b=FZ/PFODebiCzFxBWeXk1oSK1G8wT0Rg+my1iTBBiQjVa5pzu7Lyfrzi0esSWB/DTmL
         GLC5wPt46zOi8mU1R4o5ym8sB84HEuVfUAxgR5NlOdoRIzobKVXiq/8smAQak9c4zmAW
         LtXuwkJQ9Es63rxtchXA7Bd7DqMBSs52FhR8F2v3r9U2U2+rL3mjPXOyWIryJp+Dp3oG
         bjvjAkGXt5sntjl1ARoc+hylZg89YyUFi3LNUPMu6rp/OOT082dw0HfqpdxEd1CDAGOc
         0qzDyStbGntH9qjPn+xkawvcth2vcbPo26cafpuPsX95nDqvFXWQ3lhaVCD1Or78AgQo
         WRLA==
X-Gm-Message-State: AOJu0Yy72zMI+D9x9gsaYzuuBfbLGqHh21hk4KY/nybGOvvdZwMlOIDU
	yDkfso03dNB1FYlGSwc/BaPWghF54Nkm/jBa+rY519UQ+Pl+EwAFcML1wCQKnOiBfdcFdkDpihQ
	9msogFJImyVtHFaE1npmJjIpVocs4w3IHmh49+v15HfVpYHY6YbCXNVX+BZmxEkjRUZ4LSv7MWo
	FkTxyvE+eh4XG9a36el/P9q/xRUL3md25pvkHLYMSI
X-Received: by 2002:a05:6a21:388a:b0:1d9:2292:8730 with SMTP id adf61e73a8af0-1d96dece206mr3413361637.27.1729617097254;
        Tue, 22 Oct 2024 10:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa5X5KS7prF7JFHUUJ3CZBiAHNzBf/MwrjqsjCMaN+LrF3WJv1OfP+HgtSQrP52Hmlk94/yw8ACdegj5e2Z+Y=
X-Received: by 2002:a05:6a21:388a:b0:1d9:2292:8730 with SMTP id
 adf61e73a8af0-1d96dece206mr3413336637.27.1729617096986; Tue, 22 Oct 2024
 10:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
In-Reply-To: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 22 Oct 2024 19:11:25 +0200
Message-ID: <CAKa-r6sP-zzHWxvCyoHj0jCExF+bay1n_io8TXzFQp=qWwAWzQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: no admin perm to list endpoints
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Tue, Oct 22, 2024 at 6:43=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> During the switch to YNL, the command to list all endpoints has been
> accidentally restricted to users with admin permissions.
>

right _ the permission was preserved with MPTCP_PM_CMD_GET_LIMITS but
not with MPTCP_PM_CMD_GET_ADDR.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

