Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F75C8FD
	for <mptcp@lists.linux.dev>; Thu, 14 Dec 2023 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHWUNi80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702567114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
	b=FHWUNi80hOmW+A3goryKJ+eRrjsMvUmr7q7Po0pWNzKYMhXCeF92ATRrhhUvLuyjH4ZvmF
	slm7BQQ1/ZZNhWAOzvraPbjPDmho4ozO5TvlY1jPqku7gGbjcvH0BpjdEWELdyU0DMx1wg
	kzgcws6nLscM9olVpje0z7kMeUrqdwg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-0k3SxAZPOS-3f_6QAFiP6g-1; Thu, 14 Dec 2023 10:18:31 -0500
X-MC-Unique: 0k3SxAZPOS-3f_6QAFiP6g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f72871acdso134445166b.0
        for <mptcp@lists.linux.dev>; Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567110; x=1703171910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
        b=EgkQ907bigL/OrABkEF8unOt5VnzF0cUw4x9y+rSt7Q3P3NBS+yWQqWqZ5PZc+Qszl
         XLeg/Gjb4KhCHBiqOsibAe+iYLLXYhyeZ/I1bPWt7vI+BK1yEqF7lBk/5zduHmpRXpzd
         uZnHU6f/Vh1K1RmWOKYn8baTq/Jpf5kXwiagHMFv3DbZJXWwt00eIzmEBdeIKt8V9uej
         PDdAbbzAfQ8XOuvEh0DvhspOTLxEJdUPNpeOqbZ/ZoWDo/AH7j72jVaFPbvrRM8AezOq
         WHSDaNmBJXQ6vtVKgFmEZy5wcOFR7R4Q91cHO9et42rVOmjA9wPXk7+iY/A3tG35GPkq
         JFJQ==
X-Gm-Message-State: AOJu0YzfY8CZnReEveImC4sORMISXfoiiPbp2I+bvzFpGMgj2piAK9Xv
	yOTeXIbZhq228w7XAD7H+7yrAhLRhUfGEquY0zGyvF7SoT+3IrlJEkuXplseGNvCongmhapSPYl
	18CYXoYS+mbumFfY=
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509604ejc.5.1702567110030;
        Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbLh6Ckh+2C7wi9l0Q+FDN5slGlIEm9FPCvaL/O8/HwM1PTKqTgUfLgM/T/AGEUxS/XBLhng==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509595ejc.5.1702567109820;
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a2310f34d0asm725097ejc.196.2023.12.14.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Message-ID: <4837d1401e1610764eeea7446280de87d51912f6.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Thu, 14 Dec 2023 16:18:27 +0100
In-Reply-To: <000000000000703582060c68aeab@google.com>
References: <000000000000703582060c68aeab@google.com>
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

On Wed, 2023-12-13 at 10:53 -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    2513974cc3e1 Merge branch 'stmmac-bug-fixes'
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D116337fae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db50bd31249191=
be8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5a01c3a666e726b=
c8752
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1119061ee80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D110ca006e8000=
0

It looks like tcp_diag_destroy is closing the listener subflow, while
the mptcp stack is not expecting anyone to touch it while in listener
status. I guess we can relax the mptcp_check_listen_stop checks.

/P=20

