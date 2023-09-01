Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27593A92C
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693562242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3O793ah7NSmkjIfjjZHeVzHo6kYymczEiwCMbnD998E=;
	b=R+OkaQx0S0cVzmbnotEBQ3hQdVnbd3Lrr63JEZLx9Cjc53diVLDgoi3/RMybPbiHPf9fdt
	v+vPrLyeMPnvdr8SRnTdLqRd6VH/8G5HSpIcdxVwidC8/5KX/M2AvG5vzZipcPKcIDZA+1
	DcFn+L4tm/LiO5nrCXfOtzK52a5OnAs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-M85bFUBNPGOtupFat02Pdg-1; Fri, 01 Sep 2023 05:57:21 -0400
X-MC-Unique: M85bFUBNPGOtupFat02Pdg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcc0c073ffso3811561fa.1
        for <mptcp@lists.linux.dev>; Fri, 01 Sep 2023 02:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693562239; x=1694167039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3O793ah7NSmkjIfjjZHeVzHo6kYymczEiwCMbnD998E=;
        b=BhCbQc827u94WTuoyhnMBrCeCpoIEkczYXGPTuE6COFvYTYCtBTioe71jcGHR4PXGu
         Ppy81B/nuV0AX24ZWuZT1NjNFeC1bol4kzKH+S/7LyBTi/tup4B2DZe9UQt7Go7d5UIe
         4TddqAUY8TcU1P95xZ/dw8yJAecKDaGHC4zPyuBPxiSGjskwUZL91AnEvkfAFIwj6kTa
         0QSieBTfvNStncARkCqgLRh4uMfDLpDIp8nacJoFv/ZZ4JOIWIGV0c9b91Fc1z7F2fH+
         7UbM3QrJMltgedTuYnDZOKDDOUrxffMMPlgHoYoSkX226qnQG24ibdeHoglr0r51XQJC
         FV5w==
X-Gm-Message-State: AOJu0YxLV0WEeOs+bSnTmB04ktAU+CpLp03wzOajKVNsaKi9UPNwTtlx
	p+2lqgzqo+yWMqdSTyHzK760qEvFffFk/tiWBaB3n5ahIJVE9Hz8rPnyM6ezUDFq14iVXdCGTS4
	aE8DBDiWZWSOxtP4hONc7PmwHuDtjDMEN9GybN9Y5zN6RB82TIy2gKbQMdfJtSs4dJVxMYIvf
X-Received: by 2002:ac2:456b:0:b0:500:c589:95fa with SMTP id k11-20020ac2456b000000b00500c58995famr1113164lfm.0.1693562239283;
        Fri, 01 Sep 2023 02:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qb55tNQWZ7NNc4JFTJjothzAgY9R8VWAemWl1prDC2fWzSiBZhDIEW8RKNTJ0GsuppL04g==
X-Received: by 2002:ac2:456b:0:b0:500:c589:95fa with SMTP id k11-20020ac2456b000000b00500c58995famr1113143lfm.0.1693562238828;
        Fri, 01 Sep 2023 02:57:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-248-73.dyn.eolo.it. [146.241.248.73])
        by smtp.gmail.com with ESMTPSA id c24-20020a056402121800b005256d4d58a6sm1860737edw.18.2023.09.01.02.57.18
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:57:18 -0700 (PDT)
Message-ID: <7f8d7e6e937bbf85363ff4dfa694601513b7916e.camel@redhat.com>
Subject: Re: [PATCH MPTCP-next v3 0/2] mptcp: fix another close hang-up
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 01 Sep 2023 11:57:17 +0200
In-Reply-To: <cover.1693560377.git.pabeni@redhat.com>
References: <cover.1693560377.git.pabeni@redhat.com>
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

On Fri, 2023-09-01 at 11:27 +0200, Paolo Abeni wrote:
> If the TCP subflows close silently due to timeouts, the msk socket
> can hang-up indefinitely.
>=20
> Implement an additional close timeout triggered with the last subflow
> close event and move the msk to TCP_CLOSE when it fires.
>=20
> Should address issues/430 and issues/431.
>=20
> v2 -> v3:
>  - fix int overlflow in patch 2/2
>=20
> v1 -> v2:
>  - fix timeout timer scheduling in patch 2/2 (timeout never fired on v1)
>=20
> Paolo Abeni (2):
>   mptcp: rename timer related helper to less confusing names
>   mptcp: implement connection level timeout.
>=20
>  net/mptcp/protocol.c | 122 +++++++++++++++++++++----------------------
>  net/mptcp/protocol.h |  22 +++++++-
>  net/mptcp/subflow.c  |   3 +-
>  3 files changed, 83 insertions(+), 64 deletions(-)

Darn me, scratch this version, it's wrong. I was too hasty. I'm glad we
don't have a 24h ban policy on the mptcp ML ;)

/P

