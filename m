Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526766D39
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676909370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG9CWb2n5SWYgmm3LNFw8A/4YFO/h90mKKUzOPVaadc=;
	b=IQC7TmFIt+ao3kANBH2epCwcIwvG/OJHDaZ5y7D8uKKyaxA99zUBcG+R2aA9tfvFLeDVGu
	0nbVxpWnCNDs8ntPvx/jjiEhe1ZYNYHz1usMA7v5nFsnpBnQNJVGNiOzp21HZZO3CFeJ2h
	a+Tr6Pamwyc182a3Pzh2IpuvFeqlN0I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-5oO-lEDNPyCKfe-httRYrg-1; Mon, 20 Feb 2023 11:09:26 -0500
X-MC-Unique: 5oO-lEDNPyCKfe-httRYrg-1
Received: by mail-qt1-f197.google.com with SMTP id t5-20020ac865c5000000b003abcad051d2so371778qto.12
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 08:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676909366;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VG9CWb2n5SWYgmm3LNFw8A/4YFO/h90mKKUzOPVaadc=;
        b=sjzGqRC7BIKJMHB/s0wNX6puG2n1X7sGWPwdw+4p/Rxf/V8hn/7B0/GInAo1PLYQSI
         SGeP1Up32QJV+xMJ/NBn58ZIBcwWax/oyWrJCrHmcz8egqtvO8Xi7Rf6/RvLprYwgJK9
         t0SOya5ixLFvkahQZ8OSggDvPWt/iRptW5Ni3NOue2tnMqHF6Y2Cpmw+CrZCUlqEwpim
         /znUTh5Kd6ho/xv60iDHIJJRdGbT3NLgHYZ7prs98ViS6On9mVHA8k/qPZ7tRitzECou
         lfHGTZNy1PPtmw5cCugZXNYeohL/M+wV3nJ99+4kVTXvYAfar0/ZEyu8M6RUsgMZb0pY
         J5jg==
X-Gm-Message-State: AO0yUKUvaRL6TUvZWqphfnM7p5EkBf2tWSCBJlTbjtf6rLCcXDRkhB3B
	xW5BKaTPjDwKX/dJXC/g6ybhk0rYtSSnEH0ZNmuePC5ILwPODIE4k9bihKDlBqLYKwIHM/05vhg
	4xVa541uC4XBwR50=
X-Received: by 2002:a0c:f0c1:0:b0:56e:89b9:9a92 with SMTP id d1-20020a0cf0c1000000b0056e89b99a92mr2062513qvl.0.1676909366289;
        Mon, 20 Feb 2023 08:09:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8L9j91dnvn3dZRtdMtrRlFKSKY+b9jNHc0t1LXDGDxV2oSugOUGq13ccBwH+jkMOO2QrCrVg==
X-Received: by 2002:a0c:f0c1:0:b0:56e:89b9:9a92 with SMTP id d1-20020a0cf0c1000000b0056e89b99a92mr2062491qvl.0.1676909366003;
        Mon, 20 Feb 2023 08:09:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id y127-20020a379685000000b0073bb575dfbbsm5869607qkd.40.2023.02.20.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:09:25 -0800 (PST)
Message-ID: <ff85210e42fbacb69ae14d4ae972e8a95c098962.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash-to: mptcp: refactor passive socket
 initialization
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 20 Feb 2023 17:09:23 +0100
In-Reply-To: <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
References: <29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com>
	 <7a23540c-0c17-6a8a-7826-2cea1e7c2ebf@tessares.net>
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

On Mon, 2023-02-20 at 16:01 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 20/02/2023 15:27, Paolo Abeni wrote:
> > Since the squash-to commit, msk->first is set even for unaccepted
> > sockets: mptcp_mp_fail_no_response() can take action and reset
> > the subflow even when msk->first is still in the accept queue,
> > after that incoming reset already closed such socket.
> >=20
> > That in turn will end-up calling tcp_done() - via mptcp_subflow_reset()
> > - on already closed sockets, which is illegal.
>=20
> Should we not add a WARN_ON() there for our CI (and syzkaller) to catch
> that earlier?

If you mean as a non upstreamable patch touching tcp_done(), that could
be useful.

I think it's better not touching the upstream code enforcing such
constraint (either tcp or mptcp one) because it should be an "obvious"
one.

Cheers,

Paolo

