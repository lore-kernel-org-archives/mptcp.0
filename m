Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E01C5F1A
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629098; cv=none; b=BJhc0//GWlnxjB7goEgbC5da2HSSrtCPNa+PvjSmgs/u31l2DYRgN716Kj5QEaEmGYcR5dUg4cKycrDpPXNbRQpDh37Q6txK8zSlvBLCy98UU3/caBSMWaugtSkvnubOLg9ue6VNUbIHyipO9f4gPR6taHultln6jLNkl53grhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629098; c=relaxed/simple;
	bh=xwRVHrqyj1XQk3Qj6l+3RxP1Vsf6r8O+Nj+33p8dqkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw74qSimpuN9b0jqgqZUIB4Au1ZcJ4X1NokNTTqY1GXl8zQ8Dx7wYDhJy+gfuxV7I25IWagS7ATFfC48cGxHE6I2fMlDllI2MakZgMSrJcDJxKUtJXCf06UNXngvF93KuNktTwLCxPgCaf39ikCQheDpx9yW8qYEb5lWwuuHKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlMtUD0h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlMtUD0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737629095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKHMH0NHU1XDhlPLu3+SYuxAeIimPILkE6Cj8AAaCQQ=;
	b=MlMtUD0hi6PmQ8HpsdwI2KV9tBy6v0tqtf1Vp5BJHm+LBM+AV8kjAZjnbR5mpObFbMAFpI
	tfrustpR3A70E7cfLqqGJlkWgESgUJYyfr5ZOkmdktMRyiUV3zN7MygmhjohkDyM0SzzyS
	uNuyjTP3PZWZreU7J5P71UCGVT+hWsM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-AI-p9qNtOk-mIx06Z4g4qw-1; Thu, 23 Jan 2025 05:44:54 -0500
X-MC-Unique: AI-p9qNtOk-mIx06Z4g4qw-1
X-Mimecast-MFC-AGG-ID: AI-p9qNtOk-mIx06Z4g4qw
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71e13d7e9f2so524524a34.3
        for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 02:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629093; x=1738233893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKHMH0NHU1XDhlPLu3+SYuxAeIimPILkE6Cj8AAaCQQ=;
        b=TBG6+QPHVMKb4/mDPhybZb2tLxgklQAVUCK2eGCcrJGNM4CbfMY+H8BPEJBbkFvVy1
         ajAfyHe348Zi5wCrluyMyUZNYDTo4h+dUM90JOsW63XyVTgrmMnGhpes52u3nbh/NbuB
         ypTOgGuiTHM6j92PsDG+ZkNvzEDeVSZ6Ww3+QLqy8PxrF7/y5xTwLDdRN1LhZA8hDFDM
         rFzR9GKmZyo7lmsAzFQ2oyCUi74UsgcajdHt8wuAg9lUQisaQesNDxpnvc37cIU6FdlZ
         77mQiayJVDttgjb6sGKizjs3+kN4WTzOQmaPYtmQqufMLiVNW1cD/ylwtne13algCj9t
         Q4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Qxg01SSVQ4KFZHE7buAx6fsdBouQm84r4Kza/ruLTno/ut7DEuK4yiOHpl1cqcFoQ+LTLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsy59nJikMO/rmlTpRxVHbuMLMdHJ2CxM4+kahB6sda+ikLeFn
	NQCFlQvVbgEkOFrlo9roEqHwnUFGsjlO6B1mwsDEBELZsFrRRQ+iFFBOqeEZKHm3ow6yPmWd/Cf
	NLzttK5R3qxUdNgvdIOh599nuF0dgV+otCXaO7Fuainu4OyYk313ZHn2ujGzBxHLwQCc2tNLq/1
	9fn71/MzLmxf0Fj8rhEphvYpSBPiE=
X-Gm-Gg: ASbGncv1XCcJND8tBoJnIbHYYWoemvYaJVod/L27CUR/EWnx2tiaSjNiUCFkfB67Vr/
	N7FyuN55HDyeAlNnnVa+AVScEwVnYx6tqf7G09fdUheDR6SEoaq4=
X-Received: by 2002:a05:6830:600d:b0:71d:415a:5d18 with SMTP id 46e09a7af769-7249da56ce2mr17703509a34.3.1737629093567;
        Thu, 23 Jan 2025 02:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi6WLIndQdZXsemrfl2iOkDN0XoKsqLxfvKzEEANxD/42Ao5OkC5eQ4YGyrCpagt0VMOKs6wPnVEcEU1Eb+Qs=
X-Received: by 2002:a05:6830:600d:b0:71d:415a:5d18 with SMTP id
 46e09a7af769-7249da56ce2mr17703499a34.3.1737629093275; Thu, 23 Jan 2025
 02:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora> <Z5IBPOGvfPozjrl5@fedora> <8ee5ad75-c550-4559-b46f-e511767b3302@kernel.org>
In-Reply-To: <8ee5ad75-c550-4559-b46f-e511767b3302@kernel.org>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2025 11:44:37 +0100
X-Gm-Features: AbW1kvbfBjT3WVjr-q_-Wl_3bczkryyrXglCzumXVRe52qfWdH0gjvrAotDYNL4
Message-ID: <CAASaF6z4vEKq2Oc+UW-XzMxk4z+U9bppKrTvYenmh8O0h=ChWQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from environment
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Hangbin Liu <haliu@redhat.com>, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -JjPtba8VgIfGCr5aMVI5cqnDXqk3eQOtwpLwvkAUOs_1737629094
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 11:26=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Jan, Hangbin,
>
> (-cc <eliang@kernel.org>: wrong address apparently)
>
> On 23/01/2025 09:43, Hangbin Liu wrote:
> > On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
> >> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> >>> Package build environments like Fedora rpmbuild introduced hardening
> >>> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> >>> and LDFLAGS.
> >>>
> >>> mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which lead=
s
> >>> to a mismatch and build failure, for example:
> >>>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/m=
ptcp_sockopt] Error 1
> >>>   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.roda=
ta.str1.8' can not be used when making a PIE object; recompile with -fPIE
> >>>   /usr/bin/ld: failed to set dynamic section sizes: bad value
> >>>   collect2: error: ld returned 1 exit status
> >>>
> >>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >>> ---
> >>>  tools/testing/selftests/net/mptcp/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testi=
ng/selftests/net/mptcp/Makefile
> >>> index 8e3fc05a5397..9706bc73809f 100644
> >>> --- a/tools/testing/selftests/net/mptcp/Makefile
> >>> +++ b/tools/testing/selftests/net/mptcp/Makefile
> >>> @@ -2,7 +2,7 @@
> >>>
> >>>  top_srcdir =3D ../../../../..
> >>>
> >>> -CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/incl=
ude $(KHDR_INCLUDES)
> >>> +CFLAGS +=3D  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/inc=
lude $(KHDR_INCLUDES)
>
> Thank you for the fix, it looks good to me too:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> >>>
> >>>  TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh=
 \
> >>>           simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> >
> > Hmm, net-next is closed. Not sure if we can target this to net since it=
 fixes
> > the build errors.
>
> I think this should target -net. It should then have a Fixes tag (and cc
> Stable). Not sure if we need to backport that all along. Maybe enough to
> use the following one, because I see it fixed the same issue in net and
> tcp_ao:
>
> Fixes: cc937dad85ae ("selftests: centralize -D_GNU_SOURCE=3D to CFLAGS in
> lib.mk")
>
> BTW, I guess you will need the same fix in
> tools/testing/selftests/net/lib/Makefile and
> tools/testing/selftests/net/openvswitch/Makefile.
>
> @Jan: Do you mind fixing them too please? Also, please next time add the
> target in the subject, e.g. [PATCH net], see:

Will do.

Regards,
Jan

>
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> @Netdev maintainers: this can be applied directly in -net, no need to go
> through the MPTCP tree first. But it can if you prefer me adding the
> Fixes tag.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

