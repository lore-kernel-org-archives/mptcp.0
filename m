Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68719B678
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9MpTO9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698426942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS1haIp7dERhvhx0DnblOBy2LCNXb90SryhbD/bp7GA=;
	b=g9MpTO9NEququXrHxTlDDqyyKyYFz9j2oC+qkNVYngdtblN+3aLPCqBmnr8WaNCs/NIyXO
	CPhxWVYokorp8pU+bKAGeTbzYocctcbJ+a98AGLz3S7VH6dTlVfJ3ZMyqD+1XgsTQ/ebtR
	pL8QEx1Aernew4x6UHF0ZWvaQxRxdrY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-aAyOxThFNCi3KKA7Qc-cwA-1; Fri, 27 Oct 2023 13:15:40 -0400
X-MC-Unique: aAyOxThFNCi3KKA7Qc-cwA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c439446b73so20930466b.0
        for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698426939; x=1699031739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/IUIuBlUAVSfw0ZYSSp7HA1ApY55xXa4CdJDVH1eo0=;
        b=nHivEvfDzpgC7bhTvkSuVjeJGpsLjdfzZ1/dMLx6RXds/Dwtv1cY1hVs3BVj2kxdUe
         7iuNpMT8kUbz/ZBv1/1FkPn4o65GKttM3/BgktZ4wKdRf04QobLwv1eqba1SnNl+eXbN
         idD5VJqS35qiDbnSQYVPIUv5mqheH6iTwvsjKenmMRTKMATi8WIM21BnvGqA5xxJSrHT
         gvMAIePlVBU+frIT9D90iOAAOdfABJS5AGePIjgXsgT61kg7a3S7Z7d0tUtNKBdnfiNK
         V4MABETmuLqD4ec3UOzIVl9S6tXGEwPdWZ158cWToCBYrT5joZYhIfBi845O7tPZrsb+
         /LIg==
X-Gm-Message-State: AOJu0YznHgPDfEhOtEsluEMer6Jl7r9CdKHpdc8e8HHL5NzJDfChZb+O
	SMp5lyOHIuwGMqnjdhQueMq4/vAOl+fQreKrWneeXmIRPsa6L+65NzRZSBasSlr9EWPweV2Ta8r
	cv5aYxx9jX1u4e5Q=
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057732ejn.7.1698426939530;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3zKvAwgByzPtlH8RkxXx58KVrHzT8wVir7rvNE4KKx7DFWWzSBC5wS9Pl7fc9z5bjQxnfA==
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057715ejn.7.1698426939166;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-222.dyn.eolo.it. [146.241.239.222])
        by smtp.gmail.com with ESMTPSA id md12-20020a170906ae8c00b009be14e5cd54sm1483469ejb.57.2023.10.27.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 10:15:38 -0700 (PDT)
Message-ID: <e245fb6a37d3c99df6efa934c5f05616bc1df7e7.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Fri, 27 Oct 2023 19:15:37 +0200
In-Reply-To: <0000000000000fed5606088ee598@google.com>
References: <0000000000000fed5606088ee598@google.com>
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

On Wed, 2023-10-25 at 11:48 -0700, syzbot wrote:
> syzbot found the following issue on:
>=20
> HEAD commit:    9c5d00cb7b6b Merge tag 'perf-tools-fixes-for-v6.6-2-2023-=
1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D123fbacd68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D530f7d8ed0a57=
417
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc53d4d3ddb327e8=
0bc51
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40

FTR: preemptible kernel, last mptcp program run on the CPU splatting
is:

r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
bind$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e24, @multicast2}, 0x10)
sendmmsg$inet(r0, &(0x7f0000000440)=3D[{{&(0x7f00000000c0)=3D{0x2, 0x4e24, =
@empty}, 0x10, 0x0}}], 0x1, 0x24040890)
r1 =3D socket$nl_generic(0x10, 0x3, 0x10)
r2 =3D syz_genetlink_get_family_id$mptcp(&(0x7f0000000080), 0xfffffffffffff=
fff)
setsockopt$inet_tcp_buf(r0, 0x6, 0xd, &(0x7f0000000140)=3D"a7", 0x1)
sendmsg$MPTCP_PM_CMD_ADD_ADDR(r1, &(0x7f0000000300)=3D{0x0, 0x0, &(0x7f0000=
000100)=3D{&(0x7f0000000000)=3D{0x28, r2, 0x1, 0x0, 0x0, {0x2}, [@MPTCP_PM_=
ATTR_ADDR=3D{0x14, 0x1, 0x0, 0x1, [@MPTCP_PM_ADDR_ATTR_ADDR4=3D{0x8, 0x3, @=
multicast2=3D0x7f000001}, @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x6, 0x1, 0x2}]}]},=
 0x28}, 0x1, 0xf00000000000000}, 0x0)

self-connecting fast-open with an empty data buffer (on a preemptible
kernel, what could possibly go wrong?!? :-P)

The splat is caused by the following check:

=09WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
                     !subflow->mp_join && !(state & TCPF_CLOSE));

Without a repro it's hard to guess what is going on, but looks a valid
mptcp related issue.

/P

