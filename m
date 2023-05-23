Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F04C91
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684861830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKmOVxoz+nDUYuokpu/93cWGEDejPbRKHB7PnpmuyGM=;
	b=ffqOg6ttZuE/KIG378eQRkLq2Ns3Uq+/Bqzm2DIEocQzB08Xgy3DLGQ3MnfWfUJ4tzaqmd
	Lovh3KiDYvvsks8VC9KuMbixa7NN55uH6/fLH7TyMaGSafbtWsezvt9OcscO5YeoNzFXpt
	DD7pRKbfiVLyUzRjZ8kPDdpK4dR7ZZE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ioTuNCFJNuqNnjoG3cQJvw-1; Tue, 23 May 2023 13:10:28 -0400
X-MC-Unique: ioTuNCFJNuqNnjoG3cQJvw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-623b86d929dso2604876d6.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 10:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861827; x=1687453827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UKmOVxoz+nDUYuokpu/93cWGEDejPbRKHB7PnpmuyGM=;
        b=enYE/VOXSyDxNlkX1BhADatIH7scUvn+KxbwiUUmfnyh1KA94ffVOo7W4b6B4LfDUq
         5yU3rDcliS+sH4eIyWExuV69Kar6C/HJmMpe+7EX3SmBlFPZjmPavUOj/MSlQ18rNkfq
         yFz5+msxzfHkWYjMyckL2ybXr13urkB9+zWCu4wcm0ChkvzFV45r/Q3lAyVR6jNLpBIx
         36eo57mYPkXKZ0MhQV8ONcluwIBoH3cVrxo30miWNAELhj5nElVNbAeLDjEO3R17ZQTh
         eKX5QSLm8iuvdSx4s3xPcJrUpXp0X7t+S5HnM1KiTxt9tOt3NlbDjBpMAPg/Ec8EF1By
         aAVA==
X-Gm-Message-State: AC+VfDzffbIsXELttYNI9h6eT7X+tlQ7sxPEyLFEcuPZ6TDOtllaEAyS
	OnVK/YkZWFPBOiP0vM5jkrIPLP/5JLmH2GQuiq7bobBdJTGv/dnAKPo8Mi5HcoUIs3ImbmrPo8x
	Yaru3TdBKuoojEx0=
X-Received: by 2002:a05:6214:4003:b0:625:8684:33f3 with SMTP id kd3-20020a056214400300b00625868433f3mr7921569qvb.0.1684861827384;
        Tue, 23 May 2023 10:10:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aj0CZiQkuMBJ1YlhhGJ9Yy8SUfzr3cFYMozBHErkEUgVyOTIFLqYXfYiyzKK9tm0xB4scLQ==
X-Received: by 2002:a05:6214:4003:b0:625:8684:33f3 with SMTP id kd3-20020a056214400300b00625868433f3mr7921546qvb.0.1684861827117;
        Tue, 23 May 2023 10:10:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-246-0.dyn.eolo.it. [146.241.246.0])
        by smtp.gmail.com with ESMTPSA id em4-20020ad44f84000000b006215d0bdf37sm2919019qvb.16.2023.05.23.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:10:26 -0700 (PDT)
Message-ID: <ae69d6dc7e8ceaeee7c5c9359606dc7dbc68c0f3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 23 May 2023 19:10:24 +0200
In-Reply-To: <c89568ea-37c5-5e64-2a5b-1ef810f5e4a0@tessares.net>
References: <cover.1684763196.git.pabeni@redhat.com>
	 <7caed74486cdeec1c929cd2b62d3f04dd67db46e.1684763196.git.pabeni@redhat.com>
	 <ee0d7408-4b5c-857f-10eb-02cb1162b5db@tessares.net>
	 <1f166b0fe5d7d79682cf8bdc398c7638e1a52a72.camel@redhat.com>
	 <c89568ea-37c5-5e64-2a5b-1ef810f5e4a0@tessares.net>
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

On Tue, 2023-05-23 at 18:55 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 23/05/2023 18:46, Paolo Abeni wrote:
> > On Tue, 2023-05-23 at 17:31 +0200, Matthieu Baerts wrote:
> > > Hi Paolo,
> > >=20
> > > On 22/05/2023 15:56, Paolo Abeni wrote:
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >=20
> > > Do you mind motivating the addition of this new socket option? :)
> >=20
> > Sure, I will do.
> >=20
> > > Also, it is not clear how we manage the different size for struct
> > > tcp_info and struct mptcp_subflow_addrs but I will look at that in mo=
re
> > > details later.
> >=20
> > This patch does not allow for different mptcp_subflow_addrs size. I
> > hope it's not a problem??!
>=20
> I guess it is fine, it should not change. But then it is probably better
> to add a note in mptcp.h, no?
>=20
> The alternative is write something like:
>=20
>  - header with the features we want + number of subflows per feature
> (and the kernel can write how many were available)
>  - feature 1 (tcp_info):
>    - mptcp_subflow_data structure
>    - tcp_info for each subflow
>  - feature 2 (addr):
>    - mptcp_subflow_data structure
>    - addr for each subflow
>=20
> So we can accept multiple features and we can pick what we want.
>=20
> Just an idea, maybe it is not useful or too complex to manage.

mptcp_subflow_addrs includes 2 __kernel_sockaddr_storage field, so it
should be as future proof as reasonably possible. Even IPv8 should fit
the 128 bytes there ;)

If not, we can always add an MPTCP_FULLER_INFO sock opt ;)

I think the current schema should work. I'll add a note in the uapi
file.

Thanks!

/P

