Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62E2C9E
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 15:52:17 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id fv2so13008330pjb.4
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ys6AzI+mDPMzgbBgSQyZ01em1WyW21362JFtILWGCqU=;
        b=TDO7ZUtET0X32Sbb1Y1D+bE7qBGyzSMxMxi9hjLaZvExXOB51XZdVKrxJLu1miBLbQ
         6nvwSZxl5sCp0C5qw/3lBjTODOzDfTr01bJw6nU69Lxfcj2je5z5AMJLFvY2Gy7fNBld
         dudxAaMu6TvabdAJGQ3KngEFdUC108TOKVxkLA8Vl+BLe5YJ+LIbaQtzF+sy5/iS2Ouu
         KSv+TV72kobsAnsb9KG6ii/0a7ntIZvvYEL/mORhMZV1oW3cjxAJBZ7eaOhoEstlQ0Iy
         o897s5K3XAPj+r0glF8fDY7JOr7fYrtFSFrZ0Ld0kuYbjRR47OAFkqXI22n1i34NZsM3
         l3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ys6AzI+mDPMzgbBgSQyZ01em1WyW21362JFtILWGCqU=;
        b=17h1HctHsSQjfSYd0KRoQZ+0wRC+wNyx8nZQJEwGrCFmwQuc7jCFQqClsKpom1bZPS
         RbUfWR7HrgGBcaHWqMBULKkBXFc9giMOby+D/Il1XCOkKAaPyH8AJ2JZtcoNopU5EfNd
         vgjZT/1EcsRBSyhEIZ3HTuC62lwWA1r65j4HDcPbmVb83r5PsY8kCm98HqZ3DptsphxQ
         nuoGTBd73dLYxhsm6hal433XDBEA3xvpVAV4O3dB7fT4AbYxyCDg75/msggCHPqfChRO
         3wULHrxWOFlVXLk5eDa2LD0DWjPNmwknUinwajFLOx/kWQSicuHwBhmnbeXmQez8OEnN
         mi5g==
X-Gm-Message-State: AOAM533EeYeJmrd/2C/3qq07wI4/3EB8M7m1bhdNR1RspHTL3k7v0ZNc
	KPimf4K0e8bWqJIsfbSwTX0+mrbv712EoLOTlZk=
X-Google-Smtp-Source: ABdhPJwwT0qS35BbAfihT3uOM8y/hdTK78T8uSdH1F8Mtj2HLCgUrNKloQkqgTmAVEWxnafWtcZrPED6P/ChbANH2S0=
X-Received: by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP id
 t15-20020a1709028c8f00b0015eab1c591bmr3546186plo.171.1651506736894; Mon, 02
 May 2022 08:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
 <7c93496c-5153-5b83-48a9-6dd75da42542@linux.intel.com> <12a4ac76eddf80868bd61dcadfcb972d597ba629.camel@redhat.com>
In-Reply-To: <12a4ac76eddf80868bd61dcadfcb972d597ba629.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 2 May 2022 23:52:06 +0800
Message-ID: <CA+WQbwsTJ5n94RMDi8UyMx-Y8JeBmK8jpUsi2H=Y9R5zGghHKg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the skb
 is writable
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you so much for this patch. It fixed the issue that bothered me
for a long time. With this change, it seems the bad data in the
MP_FAIL multiple subflows test case has been dropped correctly now:

> sudo ./mptcp_join.sh -F
Created /tmp/tmp.lqIytszwoM (size 1 KB) containing data sent by client
Created /tmp/tmp.zChji3JlEJ (size 1 KB) containing data sent by server
Created /tmp/tmp.iTuFZCucnH (size 128 KB) containing data sent by client
Created /tmp/tmp.YTN6JELVhq (size 128 KB) containing data sent by server
file received by server has inverted byte at 169
001 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                                            sum[ ok ]
- csum  [ ok ]
                                                            ftx[ ok ]
- failrx[ ok ]
                                                            rtx[ ok ]
- rstrx [ ok ]
                                                            itx[ ok ]
- infirx[ ok ]
                                                            ftx[ ok ]
- failrx[ ok ] invert
Created /tmp/tmp.iTuFZCucnH (size 1024 KB) containing data sent by client
Created /tmp/tmp.YTN6JELVhq (size 1024 KB) containing data sent by server
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok=
 ]

sum[ ok ] - csum  [ ok ]

ftx[ ok ] - failrx[ ok ]

rtx[ ok ] - rstrx [ ok ]

itx[ ok ] - infirx[ ok ]

No inverted byte is received in the MP_FAIL MP_RST test.

Do I understand this correctly?

Anyway, please add my tested-by tag for this patch:

Tested-by: Geliang Tang <geliang.tang@suse.com>

Thanks,
-Geliang

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=80 15:55=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri, 2022-04-29 at 13:56 -0700, Mat Martineau wrote:
> > On Fri, 29 Apr 2022, Paolo Abeni wrote:
> >
> > > Currently pedit tries to ensure that the accessed skb offset
> > > is writeble via skb_unclone(). The action potentially allows
> > > touching any skb bytes, so it may end-up modifying shared data.
> > >
> > > The above causes some sporadic MPTCP self-test failures.
> > >
> > > Address the issue keeping track of a rough over-estimate highest skb
> > > offset accessed by the action and ensure such offset is really
> > > writable.
> > >
> > > Note that this may cause performance regressions in some scenario,
> > > but hopefully pedit is not critical path.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > > - fix build issue
> > > - account for the skb hdr offset, too
> > >
> > > this almost solves issues/265 here. I'm still getting some rare
> > > failure with MPTcpExtMPFailTx=3D=3D0: sometimes the transfer complete=
s
> > > before we are able to use the 2nd/failing link. The relevant fix
> > > is a purely seft-test one
> > >
> > > Note that a much simpler alternatives would be simply replacing
> > > skb_unshare() with skb_ensure_writable(skb, skb->len), but that
> > > really could causes more visible regressions
> >
> > To make sure I'm understanding correctly: skb_ensure_writable(skb,
> > skb->len) would copy the entire packet payload on every edited
> > packet, but this patch will only copy the part that might be modified (=
and
> > maybe a little extra).
> >
> Yes, that is. All the above when the relevant packet is cloned.
>
> > Seems like the full copy is worth avoiding, and
> > that users shouldn't be depending on pedit modifying shared data.
> >
> > I did run the associated test for a while (with the other patches for
> > #265) and the changes look good from a MPTCP perspective:
> >
> > Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> >
> > Do you plan to upstream this one yourself, or should I include it with =
the
> > other mptcp-net patches?
>
> I think it can (and should, to avoid blocking mptcp patches with
> net/sched discussion and vice-versa) go on it's own. I can send it.
>
> Thanks!
>
> Paolo
>
>
