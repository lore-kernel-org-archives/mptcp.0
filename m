Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368A23740
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQOgBXJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697459146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Uj6XAC11PNedcsOSciSm6bHwfuvRderQrw3wd2S/9s=;
	b=hQOgBXJOe6/7rJvNtBLvViS53gD7Y5+a6PEi5qMEbwuuMVtXrQ67JMCGIbuZ3CIBLmqO36
	OiEh0005Gs+IaW7BcUG5UL77qVQgt1ic2wI3Yo6D/OjdEe4S/3AXViIzOvnqM9PEZ+1Tp7
	Qs8v58duS9x0AipJkdGfclwvoQZ0K5I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-PEDbYXAjM9aqA7o8eyyY2g-1; Mon, 16 Oct 2023 08:25:45 -0400
X-MC-Unique: PEDbYXAjM9aqA7o8eyyY2g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so2857460e87.1
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 05:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459143; x=1698063943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Uj6XAC11PNedcsOSciSm6bHwfuvRderQrw3wd2S/9s=;
        b=KcsNrngEvu96uehmFcqpY/h3HhzYQBA1KYDgrGwNjqGabKjjSjwnWOVZNO3qZqpFPR
         MtLhXGERXo1geh1LPGL+I68u71+deljhC3rMTU/UlQy9T11+S2RTpgsQ7QLB6XQKCdvd
         2A0vLOFRyEo+qhGAFRlEdcGpxuNqxneJwJ70ywNGTbf+3gDagf+JIIz3rcRuxDM0OsA7
         uevguzBE92D14+evswGm5IYeptrxmS/iNVbW0JInMsL5UQoOvuUjlPdQ5pu8lA3V4Ggz
         dtsraDQPnaVrjYuZnCPvTd/tWAEQfPzO1VPGOXcm6W/CAnotLfxlx80LqYzuk2EHsLqu
         3aJQ==
X-Gm-Message-State: AOJu0Yzqh2GMHwdBQiar+cq1WZpBmR4ExHX2dVijRsg/sb833vqSa56m
	OyymXoBfscD6WEBHZp74hoXQIisgMEvQaeKmt/yxNMyx30dxMQ0HyM+A+zeHpLOanslmjtc+9c1
	RrIAmrQeKm2Hgmsc7mxtZ7qf6JgG718Y=
X-Received: by 2002:a05:6512:200e:b0:503:183c:1223 with SMTP id a14-20020a056512200e00b00503183c1223mr25419202lfb.7.1697459143673;
        Mon, 16 Oct 2023 05:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9YhOJtZ6HpnpjjxbGXdhmvAldT83MEBjb445hHtji4FFYqjqGoeySlNYy7uA37EK259gS+r7iMBu/rWZHTJc=
X-Received: by 2002:a05:6512:200e:b0:503:183c:1223 with SMTP id
 a14-20020a056512200e00b00503183c1223mr25419192lfb.7.1697459143345; Mon, 16
 Oct 2023 05:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <36fe14dbd444daf86a22cfa5fb50d590324e7b58.1697190267.git.dcaratti@redhat.com>
 <ee31bfb2-9fe0-4d20-ad6f-1627d048613d@kernel.org> <CAKa-r6vwzXYMcn7aP_ap+aHsApCngjwBRraUEk=zQSV2WngJ3g@mail.gmail.com>
 <439ff464-675a-40d7-9c1b-3e8224a23be2@kernel.org>
In-Reply-To: <439ff464-675a-40d7-9c1b-3e8224a23be2@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 16 Oct 2023 14:25:31 +0200
Message-ID: <CAKa-r6tPQsst1587ampPfduUGe+WrOSXLTHdZGJVoNwoMNb3-Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to: "net: mptcp: use policy generated
 by YAML spec"
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi  Matthieu,

On Mon, Oct 16, 2023 at 1:34=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
[...]
>
> I would prefer to have squash-to patches, so we can easily review the
> modifications and apply them in our tree before sending them to
> 'net-next' (or this last step in parallel). Also, by doing that, the
> MPTCP CI will be able to validate the modifications.

that means generating 4 small squash-to patches:
1) the conversion to small-ops ( 1 line)
2) the spec file (~ 10 lines)
3) the uAPI header generation ( 1 line)
4) the generated nl_policy C file ( 1 line)

what about the additional patch for ynl tool? theoretically it should
be inserted at least before the last patch in the series (in practice,
the build is not broken even if you add it at the top. But I'm not
sure if the resync with net-next will have troubles, then).

thanks,
--=20
davide

