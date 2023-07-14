Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA636AB2
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689323897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+MJzAt2cWYquLOBxBywl7IwuHdw12C+frHn5ehV9tw=;
	b=fCudkYMiHVjVgUo6wV2spwzAIIYCkTDrDgmoCgwG9sUQJ29GEHpH38necHG4tdwDO4rjGn
	4nKwN7yRBEVfLXc+LoTZbzHYwWxfbePAnPiE+MeBtJNltqy0lkFxrh3PndvJ9x9BxoApnt
	pp1BpyXUazLUh/uvo5+vDI5WkgLtfLQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-aM096xkoN0W-_oT2SNTRaw-1; Fri, 14 Jul 2023 04:38:15 -0400
X-MC-Unique: aM096xkoN0W-_oT2SNTRaw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767a1ad2175so36010985a.0
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689323895; x=1689928695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+MJzAt2cWYquLOBxBywl7IwuHdw12C+frHn5ehV9tw=;
        b=KemRAy97UX7yNbVXW5jm5mHuqVf8bgvfK8Sd8IAZRXAakguavfCzcCz66wx8jgjQGT
         eCwY6K6CLohJAOaoX/WKW87i+7ngzU1YWAieBjtLUN6j6A59XUJYQAzEZhHaHfJm1Bsx
         O55vJcQ16HK/qKfQLwbCVze9CjWtPcCKRLqJS1EB7xuY70b29zBh8c9/FLMjrWNcAwRV
         HnFElhowTZLRnaCjISRo2+hgMPdekCvEdV70k7Rig2Hc+c26LvUGygLz3aITJD7uJ4x8
         D3CU/s8TweGN9+eGEYH/zZ/D/qP/cmMwmKzuDexATMDzqa/66w5MZaw47CzQ1SLgiGzK
         9QAA==
X-Gm-Message-State: ABy/qLYuT+T6UIkUD44CLbNsbAoFDvYMKXmvgep6X/18vBSzk0lkiQRS
	2Fc+eNaWxHEBDFgVBnjV+snlPC6f+AeW4wZARMvdX5FDzGrDkv3E8OLYAeV+nTKKBWMEEHlp77U
	CjzEDe/+K3b9VLPkEFI44JIU=
X-Received: by 2002:a05:620a:1a1b:b0:767:ffb:58aa with SMTP id bk27-20020a05620a1a1b00b007670ffb58aamr4966380qkb.3.1689323895072;
        Fri, 14 Jul 2023 01:38:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBLhRcgVnab/ERDepXlQqykOombN9BpmnHbQlk1Ua8MElkEYFKnWzK71CeytruOmmff+xp7w==
X-Received: by 2002:a05:620a:1a1b:b0:767:ffb:58aa with SMTP id bk27-20020a05620a1a1b00b007670ffb58aamr4966370qkb.3.1689323894735;
        Fri, 14 Jul 2023 01:38:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id pi21-20020a05620a379500b00767c9915e32sm3633291qkn.70.2023.07.14.01.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:38:14 -0700 (PDT)
Message-ID: <e34d61ba3b9197eba4b7cd63e413f6f03b40aa79.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 03/14] mptcp: avoid additional
 __inet_stream_connect() call
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 Jul 2023 10:38:11 +0200
In-Reply-To: <968e1118-6b2a-41fd-ce78-2f1cb7427840@tessares.net>
References: <cover.1688993569.git.pabeni@redhat.com>
	 <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
	 <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
	 <968e1118-6b2a-41fd-ce78-2f1cb7427840@tessares.net>
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

On Thu, 2023-07-13 at 11:00 +0200, Matthieu Baerts wrote:
> Hi Paolo, Mat,
>=20
> Thank you for the series and the reviews!
>=20
> On 12/07/2023 23:49, Mat Martineau wrote:
> > On Mon, 10 Jul 2023, Paolo Abeni wrote:
> >=20
> > > The mptcp protocol maintains an additional socket just to easily
> > > invoke a few stream operations on the first subflow. One of them is
> > > __inet_stream_connect().
>=20
> (...)
>=20
> > > @@ -3653,21 +3655,37 @@ static int mptcp_connect(struct sock *sk,
> > > struct sockaddr *uaddr, int addr_len)
> > > =C2=A0=C2=A0=C2=A0=C2=A0/* if reaching here via the fastopen/sendmsg =
path, the caller already
> > > =C2=A0=C2=A0=C2=A0=C2=A0 * acquired the subflow socket lock, too.
> > > =C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0 if (msk->fastopening)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D __inet_stream_con=
nect(ssock, uaddr, addr_len,
> > > O_NONBLOCK, 1);
> > > -=C2=A0=C2=A0=C2=A0 else
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D inet_stream_conne=
ct(ssock, uaddr, addr_len, O_NONBLOCK);
> > > -=C2=A0=C2=A0=C2=A0 inet_sk(sk)->defer_connect =3D inet_sk(ssock->sk)=
->defer_connect;
> > > +=C2=A0=C2=A0=C2=A0 if (!msk->fastopening)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_sock(ssk);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (ssk->sk_state !=3D TCP_CLOSE)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D ssk->sk_prot->pre=
_connect(ssk, uaddr, addr_len);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 err =3D ssk->sk_prot->connect(ssk, uaddr, addr_le=
n);
> > > +=C2=A0=C2=A0=C2=A0 if (err < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 inet_sk(sk)->defer_connect =3D inet_sk(ssk)->defe=
r_connect;
> >=20
> > The above code doesn't do everything __inet_stream_connect() does. Is
> > that code omitted here because the caller of this function handles the
> > timeouts and msk-level socket states already?
>=20
> Is it not possible to extract the code we need from
> __inet_stream_connect() to a new function in af_inet.c? Then we can call
> this new function from __inet_stream_connect() and here.
>=20
> I'm always a bit worry when we duplicate code from upper layers because
> we could miss future modifications done in the original code (we had
> that a few times with the fork and it is hard to track and maintain).

Well, that kind of problems becomes order of magnitude worse with out-
of-tree code, because nobody is aware nor interested of such code
needs.

Chances of issues here are really low:
* mptcp code is in tree=20
* maintainers are aware ;)
* bpf hooks should not change
* [most important topic] the dup code is extremely simple and small

All in all, it looks reasonably safe to me.

> I
> would say that the minimum is at least to add a comment stating this
> code is a duplication from somewhere else, just in case to make it clear
> where we need to look at in case of issues there.

I'll add the comment in v2.

Thanks,

Paolo

