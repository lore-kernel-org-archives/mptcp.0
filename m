Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB81F933
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684860400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsZ1L65SXYCog/ULD+JB5HHBrFKjV0nHL3NkFbMcBpw=;
	b=FkGSoOiWwCCXaQNsAlMu+zLgB9wViGFULrNp0qsAuu6emLBRyWUussy+hh94tjj1dVSk0b
	54uQyxWIRzMBRS22xUEkTmyg7xJBy75CxO/0PjLB88ACJFYsXH7gBRZCKD7xW2wz+kAWf2
	bpdHhwDmnD2+jCZIXaiXi5MhHUI2knM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-elkmYOZRPFW2fbZAWUig1g-1; Tue, 23 May 2023 12:46:39 -0400
X-MC-Unique: elkmYOZRPFW2fbZAWUig1g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6257fdf4bc6so5761256d6.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860398; x=1687452398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsZ1L65SXYCog/ULD+JB5HHBrFKjV0nHL3NkFbMcBpw=;
        b=F+r1jA7VGFzrX5kAitKrrG0roSZw4rN8DhrxZXoxO/OMPmfy/OskqL14rf4rZQNC81
         zfvHApVtA5m/aeLq9qF6jnMQzo5jS6ntrGHYZ+ILDSNIkK5004vFKyA2XV7QyoEwGozB
         btYGl5YQlycihOj3Reu8BZ4PFk+l5QtP/JmfO8XipNhv20MqeS2l5PajXsMlfAKVhupx
         uM64OWTtoGPrqhLnrPN1MZQpsylsr8iBCrZmYyzfg5N0sAJtMktYHvr2p70OqMdezLn8
         gZVzRgf1T79KfoJfRdOxbwZ9F0tK3ulaCo8dnMr0NP0WWHZFtcM6tJs2SDOqO30HMRzJ
         7ylA==
X-Gm-Message-State: AC+VfDyQ1QW+Xpn3JorupUgHNXFW0AWJwODfnRZhZoblrd8BOyQx8YA7
	LenpwrvIMPXkYUHhs9Ac27wg+OynvYptG0RD8EX7mu0ShrAd1Maukgqjvfgeye+1LVxISjwuJhc
	TXdbHK6m6M+2YHUEtupPnXko=
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr23322402qvb.2.1684860398606;
        Tue, 23 May 2023 09:46:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UMeuX7QQJzokT0yyIYQrPw6lEMQ9wghLO+f0smQYBYaNJGgzAjsS8t5XNjaFbhxG6z872UQ==
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr23322379qvb.2.1684860398373;
        Tue, 23 May 2023 09:46:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-246-0.dyn.eolo.it. [146.241.246.0])
        by smtp.gmail.com with ESMTPSA id dd18-20020ad45812000000b0061b2a2f949bsm2855603qvb.61.2023.05.23.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:46:38 -0700 (PDT)
Message-ID: <1f166b0fe5d7d79682cf8bdc398c7638e1a52a72.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Tue, 23 May 2023 18:46:36 +0200
In-Reply-To: <ee0d7408-4b5c-857f-10eb-02cb1162b5db@tessares.net>
References: <cover.1684763196.git.pabeni@redhat.com>
	 <7caed74486cdeec1c929cd2b62d3f04dd67db46e.1684763196.git.pabeni@redhat.com>
	 <ee0d7408-4b5c-857f-10eb-02cb1162b5db@tessares.net>
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

On Tue, 2023-05-23 at 17:31 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 22/05/2023 15:56, Paolo Abeni wrote:
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> Do you mind motivating the addition of this new socket option? :)

Sure, I will do.

> Also, it is not clear how we manage the different size for struct
> tcp_info and struct mptcp_subflow_addrs but I will look at that in more
> details later.

This patch does not allow for different mptcp_subflow_addrs size. I
hope it's not a problem??!

/P

