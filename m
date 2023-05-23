Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C61F93D
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684861261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAEN1cIDZ3C5DaV62JXKvK1B7KcCiHM9w7pjuXmZ6SI=;
	b=ceAFT/X9uygrqgjfXeGgpn9SVOZtmNnaOzlyLqwVSdfej1DlEDaA7puV4dLUJld7/4+trh
	wsocrMECbf7R7eCPc21X5FtLcsCAhMlV/tgMOQ5NScPOxgDRZch3WxcqHQ+TJPZLlXK5Su
	QW0VBbTpkZBSksaM1S/NMntm3YR/uws=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-0D-qngChPpqGbqLa8G2bSg-1; Tue, 23 May 2023 12:59:15 -0400
X-MC-Unique: 0D-qngChPpqGbqLa8G2bSg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f386bb966cso11728291cf.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861148; x=1687453148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CtFrkW3JRVDnT4ZLVE8LbalkLx44MXM3DZ91l+Ejc0=;
        b=amUw027fWuQi7Ln2yZZKedLE69cvo/kfsRcazk+6d+NKjgqH/Ah0Oas+HCNhKjMg5c
         KXqzJvVd4zI9efV65sTNNtSUCU0+qxjd7Pa44/yApy9kZ3k5uNuWbFjqWB2OiOvg//oK
         1Ma4WAaW25IwI4NfQQiZeBaDUGtpIgj7gR4D5SUGK/+CsHp9F6lpwPXP+AM01J0ksXc4
         fwI39DMP3Gmbk3cYbKNcI8g0eEUDZJTr14We75zwgeczXyJ/oeGEMiUIuhX07EPqp1Lb
         anWQ1x8hMTfmPtn79U19jAs8f4it+yf12+jHfxT8p9Vj+8tGz9VwYlNfvLRAWXhMInLY
         nfag==
X-Gm-Message-State: AC+VfDzTclTOCa1+IS+hxYFrUkK8C4dm/H4mXcof6+iRpYPEvcq8BMxH
	wWJeHs1XokIRZj40jmZdV7z1lJBPKTcZQC7f3Pctnqd4wm5QVtlGl1CZ8tV8kIQ2YFQOFOrJeh9
	bfDFIFIgmZ/4rqqfnAy//tLQ=
X-Received: by 2002:a05:622a:1195:b0:3f5:1def:67f9 with SMTP id m21-20020a05622a119500b003f51def67f9mr23893678qtk.6.1684861148219;
        Tue, 23 May 2023 09:59:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zYgSqPtnT6hIT1Gig1WrcE/GoauuzxMPdsbffUaIMfCbl7Bu/sa6Lf/7f9oIan4WyB70NqA==
X-Received: by 2002:a05:622a:1195:b0:3f5:1def:67f9 with SMTP id m21-20020a05622a119500b003f51def67f9mr23893656qtk.6.1684861147894;
        Tue, 23 May 2023 09:59:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-246-0.dyn.eolo.it. [146.241.246.0])
        by smtp.gmail.com with ESMTPSA id v10-20020a0cf90a000000b0062136626e09sm2907328qvn.57.2023.05.23.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:59:07 -0700 (PDT)
Message-ID: <e53c77aade018d005dbb41e343a0afca9a793f19.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 5/6] selftests: mptcp: explicitly tests
 aggregate counters
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 23 May 2023 18:59:05 +0200
In-Reply-To: <7c0c7c6e-c3ba-bd6c-7dfc-c0d1de272a5a@tessares.net>
References: <cover.1684763196.git.pabeni@redhat.com>
	 <7e32265ebe2ed650df1373c3774656c1b62f04d4.1684763197.git.pabeni@redhat.com>
	 <7c0c7c6e-c3ba-bd6c-7dfc-c0d1de272a5a@tessares.net>
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

On Tue, 2023-05-23 at 17:29 +0200, Matthieu Baerts wrote:
>=20
> On 22/05/2023 15:56, Paolo Abeni wrote:
> > Update the existing sockopt test-case to do some some
> > basic checks on the newly added counters.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  .../selftests/net/mptcp/mptcp_sockopt.c       | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/=
testing/selftests/net/mptcp/mptcp_sockopt.c
> > index ae61f39556ca..869c041c34f3 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > @@ -51,6 +51,11 @@ struct mptcp_info {
> >  =09__u8=09mptcpi_local_addr_used;
> >  =09__u8=09mptcpi_local_addr_max;
> >  =09__u8=09mptcpi_csum_enabled;
> > +=09__u32=09mptcpi_retransmits;
> > +=09__u64=09mptcpi_bytes_retrans;
> > +=09__u64=09mptcpi_bytes_sent;
> > +=09__u64=09mptcpi_bytes_received;
> > +=09__u64=09mptcpi_bytes_acked;
> >  };
> > =20
> >  struct mptcp_subflow_data {
> > @@ -83,8 +88,10 @@ struct mptcp_subflow_addrs {
> > =20
> >  struct so_state {
> >  =09struct mptcp_info mi;
> > +=09struct mptcp_info last_sample;
> >  =09uint64_t mptcpi_rcv_delta;
> >  =09uint64_t tcpi_rcv_delta;
> > +=09bool pkt_stats_avail;
> >  };
> > =20
> >  static void die_perror(const char *msg)
> > @@ -320,6 +327,9 @@ static void do_getsockopt_mptcp_info(struct so_stat=
e *s, int fd, size_t w)
> > =20
> >  =09assert(olen =3D=3D sizeof(i));
>=20
> (see below)
>=20
> > +=09s->pkt_stats_avail =3D olen =3D=3D sizeof(i);
>=20
> Good idea, it is simple! But then we should remove the assert just above.
>=20
> And maybe we should have here: olen >=3D sizeof(i), no?
> Maybe we don't need to support newer kernels but it is just in case we
> add more info later even if I guess we would modify mptcp_info if we does=
.
>=20
> Also, maybe "struct mptcp_info" will be defined somewhere else and we
> will not use the one defined here above?

Yep, I'll use:

=09olen >=3D sizeof(i)

thanks!

/P

