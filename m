Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876E6ADB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680884979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sum0W/Fq9k4iE1J2x8zJx/ec/K7IALM3ZqDdT5bsIxM=;
	b=UigFHfYqA5XJv9RCHkY1siOQpgDsXtWIvZIdLZTzRnBp7LuQoJYzTvf6ZtwdgJWpaRW9++
	0jEx+Q2r2wFR+07TpWG+iwYqw8PBguzRej4MzjIDqMjBNnfnsNcdJs/tbm8vWf10lo9Vya
	xSsc0WRq4gPagm/XvVOvj5HXPZo42gk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Nk8oC_L7NvaKQ2eNrVgA-A-1; Fri, 07 Apr 2023 12:29:38 -0400
X-MC-Unique: Nk8oC_L7NvaKQ2eNrVgA-A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5e11d438c1aso2699796d6.1
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 09:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884978; x=1683476978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbUgLEKLz36c+BGqRzAtfVDgbCV0HreO2jcib55zTvE=;
        b=d9wteCFyGR8+xKXZXoy9qMv8+VJ7w7MhhrzxCL58R/UVpNs8jZyI1RqZyFCJ36rQmM
         J5aEhvF6N15WumSv4nY8zuuQxm+LfkwoLhhi4djKCXCK6ccAGbbEwubPyxs7wfnvKJ3Z
         0T5qgp4Gb24YsJ9Eyl4zPj1gldBYi2YhQC4IEWBJl9bNsMJkSICGylDW8d3KzEORTbn4
         LiGuQuEtFl6f/LCmVbYFsheey7/kYo9AoHe7soFUMhDf9ulCUDxCHin2dSlSZhduBQd1
         SEtsop9KxrFS3fWVTL6v12GR5oMj/vQq63SNCsqLYwimGcXZlE+ZN6CYU7DpuwzRfoDq
         obvg==
X-Gm-Message-State: AAQBX9e5hCT7EqiOL6NwI794/atYHoYA6DAMmHVQCQt9v0Fv1OZ3QJlo
	U0eSecQbP0rVzfexy7PaKudg+6qQPf4LU3gSzAsUAA7/DV6TDDk9qOTmMRSdiGUbdJXnEIXuCYH
	8d0a/dtmGDg/JSCAE7zT80A4=
X-Received: by 2002:a05:6214:519e:b0:5ab:af50:eb45 with SMTP id kl30-20020a056214519e00b005abaf50eb45mr5019888qvb.3.1680884978084;
        Fri, 07 Apr 2023 09:29:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvcQI290YalQkpJEL5A7xt39gwNOYeSsPEhB/N6Um0p1UlRLOFKZbLoIIFW8ac5iSVRRfxmw==
X-Received: by 2002:a05:6214:519e:b0:5ab:af50:eb45 with SMTP id kl30-20020a056214519e00b005abaf50eb45mr5019869qvb.3.1680884977761;
        Fri, 07 Apr 2023 09:29:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id me3-20020a0562145d0300b005dd8b9345aesm1454033qvb.70.2023.04.07.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:29:37 -0700 (PDT)
Message-ID: <2088a3dd668887cfa67d78a4b0c2ec2e349258af.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: mptcp: join: avoid using
 'cmp --bytes'
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 07 Apr 2023 18:29:35 +0200
In-Reply-To: <208afa12-9ff7-a4cf-ffdf-71bfc82194a9@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
	 <20230404-mptcp-selftests-join-busybox-shellcheck-v2-1-9113fa4d2ce2@tessares.net>
	 <fd34566a70fdfaed72644e6b13c635058b833bce.camel@redhat.com>
	 <208afa12-9ff7-a4cf-ffdf-71bfc82194a9@tessares.net>
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

On Fri, 2023-04-07 at 15:35 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 07/04/2023 15:30, Paolo Abeni wrote:
> > On Tue, 2023-04-04 at 18:21 +0200, Matthieu Baerts wrote:
> > > BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
> > >=20
> > > Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
> > > failing [1] because their 'cmp' command doesn't support this '--bytes=
'
> > > option:
> > >=20
> > >     cmp: unrecognized option '--bytes=3D1024'
> > >     BusyBox v1.35.0 () multi-call binary.
> > >=20
> > >     Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
> > >=20
> > > Instead, 'head --bytes' can be used as this option is supported by
> > > BusyBox.
> > >=20
> > > Because it is apparently quite common to use BusyBox, it is certainly
> > > better to backport this fix to impacted kernels.
> > >=20
> > > Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose t=
est-cases")
> > > Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/=
v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/ne=
t_mptcp_userspace_pm_sh/log [1]
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > > v2:
> > >  - limit the input file, not the output of cmp...
> > >    (strange that on my side, I didn't reproduce the issue but the CI =
did)
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/=
testing/selftests/net/mptcp/mptcp_join.sh
> > > index fafd19ec7e1f..bb26c406f09c 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -378,9 +378,14 @@ check_transfer()
> > >  =09=09=09fail_test
> > >  =09=09=09return 1
> > >  =09=09fi
> > > -=09=09bytes=3D"--bytes=3D${bytes}"
> > > +
> > > +=09=09# note: BusyBox's "cmp" command doesn't support --bytes
> > > +=09=09head --bytes=3D"$bytes" "$in" > "$in.cut"
> > > +=09=09head --bytes=3D"$bytes" "$out" > "$out.cut"
> > > +=09=09in=3D"$in.cut"
> > > +=09=09out=3D"$out.cut"
> > >  =09fi
> > > -=09cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
> > > +=09cmp -l "$in" "$out" | while read -r i a b; do
> > >  =09=09local sum=3D$((0${a} + 0${b}))
> > >  =09=09if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
> > >  =09=09=09echo "[ FAIL ] $what does not match (in, out):"
> > > @@ -394,6 +399,10 @@ check_transfer()
> > >  =09=09fi
> > >  =09done
> > > =20
> > > +=09if [ -n "$bytes" ]; then
> > > +=09=09rm -f "$in" "$out"
> > > +=09fi
> >=20
> > I think it would be better additionally remove the above files in
> > cleanup(), too.
>=20
> Thank you for this review!
>=20
> Should I maybe instead override the files? So have this above:
>=20
> +=09=09head --bytes=3D"$bytes" "$in" > "$in.cut"
> +=09=09head --bytes=3D"$bytes" "$out" > "$out.cut"
> +=09=09mv "$in.cut" "$in"
> +=09=09mv "$out.cut" "$out"
>=20
> Then I don't need to make sure these specific files are really cleaned
> up. We don't use these files after if I'm not mistaken.

I took to me validate the above, but I think you are right: should not
be used later.

Note that if the script is interrupted after:

head --bytes=3D"$bytes" "$in" > "$in.cut"

and before:

mv "$out.cut" "$out"

the truncated files will be leaked anyway, so perhaps the cleanup()
function is the more straight forward solution?!?

Thanks,

Paolo

