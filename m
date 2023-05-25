Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63977156CE
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685032979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrmKUF+B2x7TJZzL5ywILyVVoM1xWANffN3FuXQzj2Y=;
	b=GmJ56swolkRCZBy/t/eBuUA/86wzL8pXyh0nDKGrZIhMn3+74IiJ1B9lV8wIvXJDFur8aX
	sPoVfGv87tdC72al7+dbtZISqeefmthLNb80F4O3lI0KN//sHzK4mSS50zYVKka55ekYgZ
	G2mX4aYoWV1vYOdKlNvz6LHPm8IjNdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-N39hC0OVNMWl9ZZPvjdQIg-1; Thu, 25 May 2023 12:42:50 -0400
X-MC-Unique: N39hC0OVNMWl9ZZPvjdQIg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08900caadso4095495e9.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032969; x=1687624969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPZ2D/x/zQU78l2Us0XpKJqjkoucuWt1YM70Gzpom5I=;
        b=Bc/Hgtv0AZdJCYM04sxpMp0NffcQFBMxdE07EY9xc9te7Cn8/XELSNHCaf9YihKb5r
         G7ZEbbbrh2eg39Gpf9XltTjhp3m2k8bDLUrTUs1ZcXVWo2c/OVcqdXW707vlg8clno0S
         Zp090rCR8Q9ICFVlqcRs5vHswsLGbLjAz4DAo9XtO4x/GdM9lmQL083ugguSQFC6eThK
         qLCrcFC0cfs+h1ke6rPxYL/7aFS3mlOm4Y78sBl6zPkiiPXzpXnCs/YxOJ2+MhmfLfOQ
         rEwPPui+XiTcBOX4nKDkOOtfM1rMs20ni6pzM1wXHWCRtEl2eLKWOe+prvrpO1NU2WBT
         ThPg==
X-Gm-Message-State: AC+VfDwmIcI0hgTAd7VogGIJ0fHmkynrFMaRPQRMYt6bY8OzZFXpxec3
	USbB+7zH2AEkTrtRwH3fUsQNBY9IyE6y9ucu103cy663tRuKKxJn3ZT7I+Is2usUiKjyi0+5LR4
	Ttm07FKjytEQp+8wZul0TeZw=
X-Received: by 2002:a05:600c:4509:b0:3f6:a6b9:bc87 with SMTP id t9-20020a05600c450900b003f6a6b9bc87mr253906wmo.3.1685032969206;
        Thu, 25 May 2023 09:42:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dbXmdqt6B0aIl0Gg/psSOE9LsffWtr03uUcN0ViOdPjT0CdY+L8ivgGEgbBYbPfI13/39CQ==
X-Received: by 2002:a05:600c:4509:b0:3f6:a6b9:bc87 with SMTP id t9-20020a05600c450900b003f6a6b9bc87mr253892wmo.3.1685032968922;
        Thu, 25 May 2023 09:42:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id x11-20020a1c7c0b000000b003f50876905dsm2655880wmc.6.2023.05.25.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:42:48 -0700 (PDT)
Message-ID: <ce17b935a9cf7bb11fbaf26e131f3727bddc5c55.camel@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 2/6] mptcp: track some aggregate data
 counters.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Thu, 25 May 2023 18:42:47 +0200
In-Reply-To: <0259fb14-db63-5156-881a-b74d07f15c8e@tessares.net>
References: <cover.1684997011.git.pabeni@redhat.com>
	 <9da66102af6d8df4ae08a5a5ff8526f52e2f34b5.1684997011.git.pabeni@redhat.com>
	 <0259fb14-db63-5156-881a-b74d07f15c8e@tessares.net>
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

On Thu, 2023-05-25 at 17:19 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 25/05/2023 09:17, Paolo Abeni wrote:
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
> > index 32af2d278cb4..a124be6ebbba 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -123,6 +123,11 @@ struct mptcp_info {
> >  =09__u8=09mptcpi_local_addr_used;
> >  =09__u8=09mptcpi_local_addr_max;
> >  =09__u8=09mptcpi_csum_enabled;
> > +=09__u32=09mptcpi_retransmits;
> > +=09__u64=09mptcpi_bytes_retrans;
> > +=09__u64=09mptcpi_bytes_sent;
> > +=09__u64=09mptcpi_bytes_received;
> > +=09__u64=09mptcpi_bytes_acked;
>=20
> I'm sure sure I followed correctly the discussions about that with
> Florian: did we not want to switch to __aligned_u64 for the new fields?
> (and why not the old ones as well if it doesn't change anything but at
> least it would be uniformed)
>=20
> If I'm not mistaken, it would not change anything but maybe better to be
> on the safe side?

IMHO this is the main point. I also think adding __aligned_u64 should
not change nothing. _but_ if will change something e.g. on some
esotheric arch, adding __aligned_u64 would break uAPI and will be very
bad.

IMHO the safe side is not adding such annotation here.

Cheers,

Paolo

