Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC818B11
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCogy334"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700726464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqxxpO20DwF1ycS2h4LaBq4ml6/wu7DgjNv/ugSrwY8=;
	b=YCogy334Regvvsmqe4luqft5NhBvZi5KjpUMfgJj7pVEncuAyFDheO8SE7Bj8I14LUYJwv
	FlPxReM/75Ct64HWATC7GIscIBzKfvW6UEJ5J6SBdTgwKoAv7bJmFRkdo/uZ5jmJBULs8y
	GMdfX7vYalPQkoEEp6XWsJMPbX0rmrk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-7R6UY00uOnqugx2f1DiHWQ-1; Thu, 23 Nov 2023 03:01:01 -0500
X-MC-Unique: 7R6UY00uOnqugx2f1DiHWQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a02225ee165so11334066b.1
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 00:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726460; x=1701331260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc0JVrpQ0q+qWvy2uYw78zXNtmSoaii+jhiF+Na6Xz0=;
        b=cSMrEgnQ5QKVK5z2K1B/6E5OmxiXpKWdNrj+MeLul1m5SKaJC5T+bfk3ZDOzD6GdaC
         74yauVrCb6AXsQCi4nHVSVE9gToy+AQGPph25VzRQKWENoIuuAH4xowC9lPWWOPuNwW8
         K6OT+Zs6HOhP6kebTCi/9EEbXNar0OpVO/EPHT0il9DscIkM1VyWZkfuJyP3TtZg0pKW
         z3srz1fBb1xElCo+pDNYW6k+CoO6tmLX2J1mUzToOXMv7s+stiYOrmtC8OVArVcvE6qo
         aQcAQAXyW3urP52zVM9KJHPUIGGortmvUQv2ayQ8hHe213NQlt0EYE9DbSRlI/kenDfZ
         iWBw==
X-Gm-Message-State: AOJu0YyZ1RTatfz4DNoYj6fWRHL5YARfZ9ml3YUKyRVAJGBkn4spikuR
	n6abQ/4aDea3zuLS9b6bzxs8NPGjCUFFWVOlLVgycL0sqHRz/1GibN43QgX0sYZ8m6lCu/XAo+F
	y/zc+bxqu4jZObXU=
X-Received: by 2002:a05:6402:27cd:b0:544:3944:d7cd with SMTP id c13-20020a05640227cd00b005443944d7cdmr3887476ede.2.1700726459834;
        Thu, 23 Nov 2023 00:00:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeZEd7t22xXOJeCp2tazrytapW1GyPswmje6vnKsa5mT4uEKyU7gzX90EOT+fC2hdRju6uwg==
X-Received: by 2002:a05:6402:27cd:b0:544:3944:d7cd with SMTP id c13-20020a05640227cd00b005443944d7cdmr3887441ede.2.1700726459453;
        Thu, 23 Nov 2023 00:00:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id bc18-20020a056402205200b00532eba07773sm363428edb.25.2023.11.23.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:00:58 -0800 (PST)
Message-ID: <193463799264cd58373df81b6e93cc4091c83ca5.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Thu, 23 Nov 2023 09:00:57 +0100
In-Reply-To: <20231123004834.58534-1-kuniyu@amazon.com>
References: <000000000000545a26060abf943b@google.com>
	 <20231123004834.58534-1-kuniyu@amazon.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

On Wed, 2023-11-22 at 16:48 -0800, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
> Date: Wed, 22 Nov 2023 07:43:23 -0800
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of=
 gi..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1536e3d4e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De32016b84cf=
917ca
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db834a6b2decad=
004cfa1
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11469724e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13934aaf680=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/23ea827adf3b/d=
isk-c2d5304e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0f964ac588f5/vmli=
nux-c2d5304e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b061be889285=
/bzImage-c2d5304e.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in mptcp_incoming_options+0xc93/0x3a80 net/mpt=
cp/options.c:1197
>=20
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t c2d5304e6c648ebcf653bace7e51e0e6742e46c8
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd15ec73073e..01066aa7e67d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -370,6 +370,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> =20
>  =09/* initialize option status */
>  =09mp_opt->suboptions =3D 0;
> +=09mp_opt->use_ack =3D 0;
> =20
>  =09length =3D (th->doff * 4) - sizeof(struct tcphdr);
>  =09ptr =3D (const unsigned char *)(th + 1);
>=20

Thanks for the patch! AFAICS it should work, but I think the variant
proposed by Edward:

https://lore.kernel.org/netdev/tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A=
@qq.com/

should be better, adding the additional instruction only in the code
path needing it.=20

Thank!

Paolo

