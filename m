Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1807174C2
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688147430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzgjVzQaHlfE879xofLR/uLVFsCOIILj7Luh67b5rdc=;
	b=TJx3I6TCJUJu4RQArmnc4NR6fntFf8uzMQ9hpwTDXh7+geCXVhJX7d0uqmNkJttwjTlzjU
	0eFxQ493yeOuPzOoGjIBMatmalutKyzwOSNnHPS7Lv2GcMGULII+SW3eDc5yY7XFI2MkB5
	NoAB8EhK4oZUl8Wfl/8ZYdauyck4LCI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-aFw6T8f7PWOLXuCZPlInNw-1; Fri, 30 Jun 2023 13:50:29 -0400
X-MC-Unique: aFw6T8f7PWOLXuCZPlInNw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-401e1fc831fso3644691cf.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 10:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688147428; x=1690739428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XH8AlaynV2KiM5XK4NFTT8Jf0bmCJLG1cExA/92XEzA=;
        b=l2+jfwXpRJNQxmt4O2BzlH5P6gkPNWDGXIVwf3CHrDN6KKUT5FCcxyoU+yozbni8zX
         j4b0TZIKi2PpP3m/tcGea4hJoJbVlrfgmVgIUl3ekMPDcBNeOVatGh3MTdqRhMpSfcI0
         1j7GrzOpA00s2x7fYB3NThwrOfUV8vuaCdsgwlTkGp1LGecgQAJHtIBIie7Pp6TiKU1x
         kqUGdSFO/EPhdOkyhQSDYO0TbvGAlS+bxRXH/VM3wSGxsFPZylhrwE/GbdVvpZT/kdJH
         QjFMhnh+5iwDZS6RDmR0kQBLH3kVMHjIbsABnm14gpI/Z5xk5RRSF8//xtxNq+XexAhf
         9RjA==
X-Gm-Message-State: ABy/qLbtvZQtWXhKdMVwwaiQiAucde+OJu6IEcI3M/TJqUbaZdMIE0uW
	vvhezgh+8cPLyH2Hnlt9N6tRWx+IgHFOhdqREn5YGLH8WeNuyEO/3L4CAKHSw17HnPdlibm0hKP
	AE3AmTQOYDp20IYY=
X-Received: by 2002:a05:622a:10d:b0:403:2c71:3ac with SMTP id u13-20020a05622a010d00b004032c7103acmr4427125qtw.0.1688147428504;
        Fri, 30 Jun 2023 10:50:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+5rub8HQlyJiVCtufMWu7pjIp4T0XQqcgt71j55WPvFWk/BhcrF0LUUajevM0VIwxwhtO0w==
X-Received: by 2002:a05:622a:10d:b0:403:2c71:3ac with SMTP id u13-20020a05622a010d00b004032c7103acmr4427095qtw.0.1688147427999;
        Fri, 30 Jun 2023 10:50:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id y12-20020ac87c8c000000b003f6a0fa022bsm3509653qtv.51.2023.06.30.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:50:27 -0700 (PDT)
Message-ID: <9796de2e676c03208c684cf3d2097c0779864b42.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 06/18] selftests: mptcp: connect: don't stop
 if error
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 30 Jun 2023 19:50:25 +0200
In-Reply-To: <a7d7b29d-625d-46ef-06b7-4d31bb90a8a7@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
	 <20230621-mptcp-issue-368-selftests-subtests-v1-6-0cae453ae1fa@tessares.net>
	 <76ee3a32adb98108a88c81babcfbb9cf3edd724c.camel@redhat.com>
	 <a7d7b29d-625d-46ef-06b7-4d31bb90a8a7@tessares.net>
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

On Fri, 2023-06-30 at 16:41 +0200, Matthieu Baerts wrote:
> On 30/06/2023 12:52, Paolo Abeni wrote:
> > browsers! ;)
> > On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
> > > No more tests were executed after a failure but it is still interesti=
ng
> > > to get results for all the tests to better understand what's still OK
> > > and what's not after a modification.
> > >=20
> > > Now we only exit earlier if the basic tests are failing: no ping goin=
g
> > > through namespaces or unable to transfer data on the loopback interfa=
ce.
> > >=20
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 27 ++++++++++++=
++++------
> > >  1 file changed, 20 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/too=
ls/testing/selftests/net/mptcp/mptcp_connect.sh
> > > index 780b8fef2261..dba58875ef4c 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > > @@ -7,6 +7,7 @@ time_start=3D$(date +%s)
> > > =20
> > >  optstring=3D"S:R:d:e:l:r:h4cm:f:tC"
> > >  ret=3D0
> > > +final_ret=3D0
> > >  sin=3D""
> > >  sout=3D""
> > >  cin_disconnect=3D""
> > > @@ -837,14 +838,25 @@ display_time()
> > >  =09echo "Time: ${time_run} seconds"
> > >  }
> > > =20
> > > -stop_if_error()
> > > +log_if_error()
> > >  {
> > >  =09local msg=3D"$1"
> > > =20
> > >  =09if [ ${ret} -ne 0 ]; then
> > >  =09=09echo "FAIL: ${msg}" 1>&2
> > > +
> > > +=09=09final_ret=3D${ret}
> > > +=09=09ret=3D0
> > > +
> > > +=09=09return ${final_ret}
> > > +=09fi
> >=20
> > It's not clear to me which is the return value for log_if_error() in
> > the '${ret} -eq 0' case.
>=20
> It will be "0" because there was no command launched in this case.
>=20
> > What about moving the return after the 'if' statement?
>=20
> I don't think I can do that now that we have "ret" and "final_ret":
> - "ret" is reset after each section when calling log_if_error(): it is
> the result per section.
> - "final_ret" is one we will use for the final exit: it is set to 0 at
> the beginning and it can only be set to a non zero value later in case
> of error. It represent the global result.
>=20
> So here, in case of error, I cannot return "ret" because it is reset to
> 0 and if there was no error, I cannot return "final_ret" because it will
> be set to 1 if there was an error in the previous section.
>=20
> But I can add an explicit "return 0" if there is no error:
>=20
>   if [ ${ret} -eq 0 ]; then
>   =09return 0
>=20
>   echo "FAIL: ${msg}" 1>&2
>=20
>   final_ret=3D${ret}
>   ret=3D0
>=20
>   return ${final_ret}

LGTM, thanks!

/P

