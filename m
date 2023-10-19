Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D715179B7
	for <mptcp@lists.linux.dev>; Thu, 19 Oct 2023 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdNtfSO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697713731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQnPHl+aD/wYrG9iKQcofkEDAxgJWLl9JgGg7jupbD4=;
	b=TdNtfSO+9dKlKTe31stX1DIE43tMmdte24uZmfDw3ka2U1ObxBxqFv+LCM8DlgYDsXwWbx
	ACACu95tt4OIC141/9dxrkvgP05PYss963P1HdYOUX+6Ruvai5eO1907veRFND5qyxvt5d
	P4NPpTKohEqey0hGQMdBCvoNLUqv1r8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-hn1ZjJ-ZNjCt68GMJ-oHIw-1; Thu, 19 Oct 2023 07:08:39 -0400
X-MC-Unique: hn1ZjJ-ZNjCt68GMJ-oHIw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50798a259c7so6640317e87.1
        for <mptcp@lists.linux.dev>; Thu, 19 Oct 2023 04:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697713718; x=1698318518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQnPHl+aD/wYrG9iKQcofkEDAxgJWLl9JgGg7jupbD4=;
        b=qzVolOE/X+sGXzTIgd/APg7Fq62WFzmE1FVkbaCv8ySLDMpZBFgrEOWa7+xtmwEs6q
         tX44ELplKqqSITA/hBzfCIH9PDj4AztRcAkbJ+zdaogxJWlNaosPACsDW3tr+OuNue9v
         eovyN5NUhBrVsBz7c75heNuEt9x5Nkow+roGAg/F6kWxo6cNqrtBCjYsa3fBo6uyBsaU
         AeQqFDaGP+HqPerTX3QP8/HY128oArvox9XURdkFQXdWDNrCkp/Dh+GLOCdU4fJDulBe
         NNumrqb0phEmP7vvjYyW+mkhW5P1ZQ4/QLqeCDxBsKxoejKgPt5QpsnN33g5SkU66B0v
         xRfw==
X-Gm-Message-State: AOJu0YwyOjcZ8ji3L6MPpFbnBxcgvtqXcq9Zmhq7cgqfwrKHiHOZVFo4
	5s59aG8Xbsjc+EnpxzVpRy2mER1mMrs254Zi3qY21sFXP+wZBjWBjjDTdEEY52BH30mf/3PAWaG
	G54TdKJ0ZTBG/C3fOYdsPDUXA2fmYvr8=
X-Received: by 2002:ac2:4c33:0:b0:500:a378:db71 with SMTP id u19-20020ac24c33000000b00500a378db71mr1081738lfq.57.1697713718567;
        Thu, 19 Oct 2023 04:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWXmm5hRurZaR8VJyAMuHfoG2P78Uer/CNTHvlervpv0nbZ32GkX8StGjf7vCW/NN695bb/2Y9ZZfmhiEnfjk=
X-Received: by 2002:ac2:4c33:0:b0:500:a378:db71 with SMTP id
 u19-20020ac24c33000000b00500a378db71mr1081729lfq.57.1697713718236; Thu, 19
 Oct 2023 04:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1697463031.git.dcaratti@redhat.com> <5f5d26c9-4fc0-4d6f-abd2-12cba3e7bb54@kernel.org>
In-Reply-To: <5f5d26c9-4fc0-4d6f-abd2-12cba3e7bb54@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 19 Oct 2023 13:08:26 +0200
Message-ID: <CAKa-r6uS2=Kd7yYLV5oNdir22a3HNkF9PQ9GzMYJ_BKZ19jOcA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 0/5] v2 fixes for "mptcp: convert Netlink code
 to use YAML spec"
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Matthieu, thanks for looking at this!

On Thu, Oct 19, 2023 at 12:48=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Davide, Paolo,
>
[...]

> When that will be done, I will apply the different patches and send them
> to netdev. I can re-use your v2 changelog in the cover-letter. Or do you
> want me to write something else?

Ok for me,

> One last thing: can I apply your last patch ("tools: ynl-gen: add
> support for exact-len validation") between these two?
>
> - "tools: ynl: add uns-admin-perm to genetlink legacy"
> - "net: mptcp: convert netlink from small_ops to ops"

that's ok also. Let's hope it won't conflict with [1] at the next sync
:) But if it does, let me know and I'll try another squash-to.

[1] https://lore.kernel.org/netdev/20231018163917.2514503-1-kuba@kernel.org=
/
thanks!
--=20
davide

