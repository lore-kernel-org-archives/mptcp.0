Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C08480
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684916150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfLiQNSJDAMi1U5x2KoOsKiRBEXLFdXGaggP+eEDjjE=;
	b=bLtVXkutj6cmsTqP2yGjeURDfzVwX1LRs0AkEVfQzOy1F0GNC45Joef3YRIzE6babDNph9
	T0NC3dFHgWi3BDbhKvCIT9YrSobo8OvDrmtxSHZf/V687+FkTDqDqLV8IG/YmGduq0qAJZ
	Q/XEluOxjayMoTM5H1NRLs5XZxYBjO8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-TA5azPasM_KyR-cqx7qaEg-1; Wed, 24 May 2023 04:15:49 -0400
X-MC-Unique: TA5azPasM_KyR-cqx7qaEg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30944ad9089so77321f8f.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916148; x=1687508148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJlz/9d/RmRD+w6saSoFwPKJxMwArPgYo+WPcLM6n+k=;
        b=eB+U10uV9k7eMZL4VkVSmmHOfowwBpqq9QaG4W0GQRLj9061LDTRYK2/eqs5Pmv2V6
         MN6KfY8m0k/nhwTuv+PyIVwnY6UsEsZ+ah3+1UeXUVm0h4hZ+MGUo9WpCJlmB/S+hWSx
         EP6yzUQ0/svavncx+JyoBERdsJhPYXwyy20aEgxb1sgM5fxeHojCm7YqCtonxP9bR78I
         0KbDorvDA7CCv2/2dSFJDy2wRqooobGbUMq6Wj2/8l1DFi6dEgkbLemB1mwftHrfUfSp
         GV1fUtu/Z05Rb5cjclajGypyvfinBSCT98kNlbT0eW58AhTwUvTnYWUUeJhdkCN1EVmj
         KcIQ==
X-Gm-Message-State: AC+VfDzeLuDstRnqGcEanTj4ILyxGXU6YYwwrUkfbDyNdUZzsasS9qLy
	E2yTftRrif0WtUb3DAvysi79SU2dkazAYUkNnA+kRu3mpUKOAvZVX9YjI0yAxu5jOiSt5XnNWNV
	IdhN+wV7tMuZJOkRULoyDvZE=
X-Received: by 2002:a05:600c:3b08:b0:3f6:87e:f89a with SMTP id m8-20020a05600c3b0800b003f6087ef89amr5502785wms.2.1684916148352;
        Wed, 24 May 2023 01:15:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KyOPFxtQ2Dq1Gs3hgdmiAIILyEqUvmK2uSZzpYk+EfHnrhHEjLAKXwR8gGuI82qx9OyIeVQ==
X-Received: by 2002:a05:600c:3b08:b0:3f6:87e:f89a with SMTP id m8-20020a05600c3b0800b003f6087ef89amr5502767wms.2.1684916147984;
        Wed, 24 May 2023 01:15:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f604ca479esm1492930wme.3.2023.05.24.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:15:47 -0700 (PDT)
Message-ID: <df6358ce88b497eed93dff304840ddb79fba06f4.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 4/6] mptcp: track some aggregate data
 counters.
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 10:15:46 +0200
In-Reply-To: <20230523184911.GC17561@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
	 <6c8b8ab79ee6526dff0cd3240e35e2e82c300a5d.1684863309.git.pabeni@redhat.com>
	 <20230523184911.GC17561@breakpoint.cc>
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

On Tue, 2023-05-23 at 20:49 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > Currently there are no data transfer counters accounting for all
> > the subflows used by a given MPTCP socket. The user-space can compute
> > such figures aggregating the subflow info, but that is inaccurate
> > if any subflow is closed before the MPTCP socket itself.
> >=20
> > Add the new counters in the MPTCP socket itself and expose them
> > via the existing diag and sockopt. While touching mptcp_diag_fill_info(=
),
> > acquire the relevant locks before fetching the msk data, to ensure
> > better data consistency
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  include/uapi/linux/mptcp.h |  5 +++++
> >  net/mptcp/options.c        | 10 ++++++++--
> >  net/mptcp/protocol.c       | 12 +++++++++++-
> >  net/mptcp/protocol.h       |  4 ++++
> >  net/mptcp/sockopt.c        | 22 +++++++++++++++++-----
> >  5 files changed, 45 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index f4f42d88e58b..ac469625affd 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -124,6 +124,11 @@ struct mptcp_info {
> >  =09__u8=09mptcpi_local_addr_used;
> >  =09__u8=09mptcpi_local_addr_max;
> >  =09__u8=09mptcpi_csum_enabled;
> > +=09__u32=09mptcpi_retransmits;
> > +=09__u64=09mptcpi_bytes_retrans;
> > +=09__u64=09mptcpi_bytes_sent;
> > +=09__u64=09mptcpi_bytes_received;
> > +=09__u64=09mptcpi_bytes_acked;
>=20
> __aligned_u64 is preferred for uapi.

Ouch! We already have a few __u64 in the same struct.

Should we mix __u64 and __aligned ones? By pure luck, the both existing
__u64 and the new one should be aligned, even without the annotation.

/P

