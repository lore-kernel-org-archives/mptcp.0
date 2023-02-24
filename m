Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BB6FBB
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677255283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QkmZKI4HeU9BEF8GdSRhUvp2Ybq+rl09179pSk1iqw=;
	b=WlqtJGA4OeCZTV7Gqur9IX6zu2o3hh44QEhKzPjngDf9cERC5twJfTf2HysmggDrUXCU3G
	K6nX7aOrIaJqkQSH0KAYZfQaH4pkNqFD54+bZ4C1KTVu7/C61bsXrxbYIU9n2JGbryaAP0
	rvKx2PvS6xfrYHPewpFr9RzYUUkk8+w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-xiweP4HON4O3Z-NoZRMaGQ-1; Fri, 24 Feb 2023 11:14:41 -0500
X-MC-Unique: xiweP4HON4O3Z-NoZRMaGQ-1
Received: by mail-qv1-f70.google.com with SMTP id u18-20020a0cec92000000b0056ea549d728so7141577qvo.10
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 08:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QkmZKI4HeU9BEF8GdSRhUvp2Ybq+rl09179pSk1iqw=;
        b=DssehCo8ImeaJwuV4OvWLFdjZABj9U93J+RJGrt+KEo+ihBZ6X3mis9DqSv8AYwOhz
         wc0H/xcvNDDxHxMmwKoJrLHVCRaX1ivhGomh8fbsouIuJ34MqA3geGFCBWoS8+opJ8ks
         qG3Bfu4GGqGDiZ/Str//7RcJEkdxg2/BY+p9YP00t0BZwDmcA99nNMF0vILE9iGI1rHt
         M9pZUQP89mZUFqwou/wR2SXldF0A470DLdA+En3F/yqlWDX3KocjyGw6Ms3pjW2qXBE4
         fYzS0CjUv1ct0WLeZuC5sYwfl0oNgDXNgdkjMUYcK3asgY6Bku+GAJSpmBrvUo/40ote
         yhEQ==
X-Gm-Message-State: AO0yUKXSgBpzJ4KN/Gbqk0EeeAs8F3s+If1zYa4Pbhwt+vlxRrxBPHLw
	rYT67NCKJ+ZXSowhFHueYY4GeDBE7Rm4fw0bSV05q94H+PE6GHe4xZ+zWXErsCcFk7Gy2dNe6jq
	4H+8B00SyPKeVRFOCP4UL
X-Received: by 2002:a05:622a:1911:b0:3bf:b8cc:6a39 with SMTP id w17-20020a05622a191100b003bfb8cc6a39mr7018022qtc.4.1677255281095;
        Fri, 24 Feb 2023 08:14:41 -0800 (PST)
X-Google-Smtp-Source: AK7set+bpJFhA686QeSfFWnAL9xJtjC5yDVxP47FJeEeu62JyEXu4h78a9unSTEhCrkz4HkKIh/4oA==
X-Received: by 2002:a05:622a:1911:b0:3bf:b8cc:6a39 with SMTP id w17-20020a05622a191100b003bfb8cc6a39mr7017977qtc.4.1677255280784;
        Fri, 24 Feb 2023 08:14:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id q205-20020a3743d6000000b0073b75718428sm6770058qka.134.2023.02.24.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:14:40 -0800 (PST)
Message-ID: <c8760ff6bbfa2691fbffd41c2f72c11cab759acc.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket()
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Christoph Paasch
	 <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 24 Feb 2023 17:14:37 +0100
In-Reply-To: <c5acf58e-8bf4-be18-13c0-891af8146c5c@tessares.net>
References: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
	 <c5acf58e-8bf4-be18-13c0-891af8146c5c@tessares.net>
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

On Fri, 2023-02-24 at 15:02 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 24/02/2023 13:01, Paolo Abeni wrote:
> > Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> > error path, when such function is invoked by
> > mptcp_pm_nl_create_listen_socket().
> >=20
> > Such code path acquires two separates, nested socket lock, with the
> > internal lock operation lacking the "nested" annotation. Adding that
> > in sock_release() for mptcp's sake only could be confusing.
> >=20
> > Instead just add a new lockclass to the in-kernel msk socket,
> > re-initializing the lockdep infra after the socket creation.
> >=20
> > Reported-by: Christoph Paasch <cpaasch@apple.com>
> > Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creatio=
n")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> Thank you for the fix!
>=20
> It looks "simpler" than expected, no? :)

Yep, but I did a few other more complex attempts first.

I think this one should stage a bit in the export branch, to ensure
there are no side effects.

Thanks!

Paolo

