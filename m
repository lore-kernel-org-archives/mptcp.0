Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76D1A27D
	for <mptcp@lists.linux.dev>; Wed, 25 Oct 2023 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WouiDUtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698252068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45p4m02wDHtfK/5rEeQxDQTRj1TqzHPqRAnek6DIdIw=;
	b=WouiDUtxwLJg06sC2h1CrjRLQCWO9xMuo40Yx132a5p0A8mnWVq9O/q8SKOyqpzDQwCNE+
	pjZKD2T3TwZ16Q8Fm2ZLG+9GoF6pEA/LZcyIwqdEHsQCXBD/NufgY1yLf32CJiEOvnGcXo
	OhPG6fyPpNWP8hvlirwOAJRxEEKIOo8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5i96ItG5MLuDB56YwHSJVg-1; Wed, 25 Oct 2023 12:41:06 -0400
X-MC-Unique: 5i96ItG5MLuDB56YwHSJVg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b79f96718eso669973a12.0
        for <mptcp@lists.linux.dev>; Wed, 25 Oct 2023 09:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252066; x=1698856866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45p4m02wDHtfK/5rEeQxDQTRj1TqzHPqRAnek6DIdIw=;
        b=Z4gEqax8wk3Bf96tSZHUpos28/cprl88+PKGjIVUst5Cr7RPb8jbcl29BXdAAyoX0Z
         UWNSxI+KGLoAOISCgfMnxfwFKNQzAW9ooXDPZKAEM5nxxCc9HaZGwQFFT1P4P+L766WO
         x8UdNYH5VUIR4yBfIq2hLgE7P6czxLLYfQgA+547QFguvnS+4/bg5CQcV2mElcQtCinS
         +cMeWrNYZ7xpcjGPmbWTbjGnDU+YkLkykE/vgSqx+vbisZebxcPGi6UUGGGMHxsuSo3D
         w1EC//KjzrU3usSpS0822tvimtlqILEYS30lwFNMGjTR/bWjluW8AnlhrWkp8MJZOX90
         LJrQ==
X-Gm-Message-State: AOJu0YyUeBullvdvPISdd6kqrUF4wCTdVNM9E2iNLtD2iUBeotTuPYmU
	JvtPsX/CQms4+3qhbMZDTsqC87GrhBKfw0xXXTXFkFkj/lO5+d6emwvflXC2LtBF3DmMoaO6nxn
	H/wGuxkHhVL7QBIxs/LTVEpR6wLB/47I=
X-Received: by 2002:a05:6a20:8f1a:b0:17b:a34d:5b56 with SMTP id b26-20020a056a208f1a00b0017ba34d5b56mr193002pzk.19.1698252065841;
        Wed, 25 Oct 2023 09:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSMFtLZF6hT2B6SagLd1tIs/d8nGPwGyqXWu2J7MgBFAHiktU0p9lRUP2Jys/EDmwvtCDM7p7RBF0in80bIiM=
X-Received: by 2002:a05:6a20:8f1a:b0:17b:a34d:5b56 with SMTP id
 b26-20020a056a208f1a00b0017ba34d5b56mr192979pzk.19.1698252065453; Wed, 25 Oct
 2023 09:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
 <20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
 <20231024125956.341ef4ef@kernel.org> <a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
 <20231024164936.41ae6f3c@kernel.org>
In-Reply-To: <20231024164936.41ae6f3c@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 25 Oct 2023 18:40:52 +0200
Message-ID: <CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

thanks for looking at this.

On Tue, Oct 24, 2023 at 10:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> > On Mon, 23 Oct 2023 11:17:09 -0700 Mat Martineau wrote:
> >> +/* for backward compatibility */
> >> +#define     __MPTCP_PM_CMD_AFTER_LAST       __MPTCP_PM_CMD_MAX
> >> +#define     __MPTCP_ATTR_AFTER_LAST         __MPTCP_ATTR_MAX
> >
> > Do you want to intentionally move to the normal naming or would you
> > prefer to keep the old names?

given that nobody should use them, I'd prefer to move to the normal
naming and drop the old definitions (_MPTCP_PM_CMD_AFTER_LAST and
__MPTCP_ATTR_AFTER_LAST). I was unsure if I could do the drop thing
actually, because applications using them would break the build then _
hence these two "backward compatibility" lines.

For the operation list, I see it's about exposing

cmd-cnt-name

to [ge]netlink*.yaml, and then do:

  9 max-by-define: true
 10 kernel-policy: per-op
 11 cmd-cnt-name: --mptcp-pm-cmd-after-last    <-- this
 12
 13 definitions:

the generated MPTCP #define(s) are the same as the ones we have in
net-next now: no need to specify __MPTCP_PM_CMD_MAX anymore.

For the attributes, I thought I could use  'attr-cnt-name' like:

169     name: attr
170     name-prefix: mptcp-pm-attr-
171     attr-cnt-name: --mptcp-attr-after-last <-- this
172     attributes:

as described in the [ge]netlink schema, but the tool seems to just ignore i=
t.
--=20
davide





On Wed, Oct 25, 2023 at 1:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 24 Oct 2023 16:30:27 -0700 (PDT) Mat Martineau wrote:
> > I'm not sure if you're offering to add the feature or are asking us (we=
ll,
> > Davide) to implement it :)
>
> Either way is fine, Davide seems to have tackled the extensions in patche=
s
> 1 and 2, so he may want to do it himself. Otherwise I'm more than happy
> to type and send the patch :)
>

> Let's make sure we update documentation, tho, in this case:
> Documentation/userspace-api/netlink/c-code-gen.rst
>

