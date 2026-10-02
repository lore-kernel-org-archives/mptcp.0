Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086642E424
	for <mptcp@lists.linux.dev>; Fri,  2 Oct 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950040; cv=none; b=eONqCamSC87vt/8xLum7djzKRhZOLTDfZBdOM+VZgVu1sbjRSyUtwpWbQvUvY+8+u2v1niZBnTzmsU+a7YotueV+5ghW8bK74vOGw7VLy/GD8Xb5JccwVWNnU6uLN2V5WtvHej2fnrLY/cySV+IbMi2hrCHP241faKYt451Sb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950040; c=relaxed/simple;
	bh=yfDvPO4H/mIRlRzgF1ehHxShRFO4ABWe5fq0yL3+cMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5JGEVyHiB2yy/01DtCgZzEFz8X0xtiE5TmpFwO/Sq7M8YSXb3gXA9Wg81BvznGUPRa/PGNbj4UzWr/isJpAVmmOsG7RLVgz40APKI686N0cp1huDOBdUjp+R6/PCUkjeSeYgdWfRlPggB0x5POFz0RnGuOcs6PywfqBWSzgkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eftsUuVY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eftsUuVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=eftsUuVYCPvq8xq1ZIWulJtLktke+IJKxMUPlpxs+dnvurIJRsHIzkktOuF9D5Ahq0jI/x
	l+tXmaJahlnXTKfbpRs1xjld/rqqEaw3XrrYZwCCpXntHkHMKvnR/PPdRhYtfMasumhS9f
	HYVRKPdDZlElN7gLpbj2KoeFU7N/9kQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-yxLWHwIxOAeDSs4CZZZDtw-1; Fri, 02 Oct 2026 10:07:15 -0400
X-MC-Unique: yxLWHwIxOAeDSs4CZZZDtw-1
X-Mimecast-MFC-AGG-ID: yxLWHwIxOAeDSs4CZZZDtw_1790950034
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a782ba9e23so325131fa.3
        for <mptcp@lists.linux.dev>; Fri, 02 Oct 2026 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=Atzl4xmOJteqIpXF+Dp0hCWV0SV/fymKXVj7V3cOxBXjflPzLCasQjN2D03tmx8q7z
         53ad86B9uekH8nqtlKS6+awn3kprbG7fWTG9nR2S/GLlSaEt4MhcW4kRScRK4ZVTBUmb
         vsNRCnU5VWbyYPZ3q9zGUf5ToTrl1Qmr3FQBsTw2aLxqg7GX/pdq00pFYGhsNO+M5wKI
         4bV3x/YM7GdH+diZQNiduV04mfVk+gm070SQUbp/lykjclcL0Q7B3dl0qoFljB9T6z3J
         b+/YaoYoG/R458F5QRwxr2vkKwmxS+sSxlvSsIForof4J78Z/E0uJPkDnK8tSMDjKA0j
         glKA==
X-Forwarded-Encrypted: i=1; AKwUvBzMj4Atq3HGfrAK5v2WrNuJjebiFyn57Q50Ar125GtrKjGrkToHgzHgWD5riX28T5l32j0GvQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrEnhC8qZ/IO2aYjrdSd5OhQBHdPfMq7Yo/RTyFvKnIoPoJbF3
	puSE1mnmIhrsipds+0zin8UyMEYJj6x/SvXs8UnHllsrhGr4xherqWWHdfvlUEaN4ihBN++3qiE
	y/MnVewDA2VE174P4SkZmClcpS4/6uE6JI9DBb2Gm6vMm4MBmZ/NKZ3QFi0mhJavSExLruX7S/p
	uDNy5rMmdF7jOQMt/oZDqOtYWzhMQxdvo=
X-Gm-Gg: AYBFou27WMD/ZGn9aLT80UAqUyik0XSErL9Jv14hFQSTx3v4ACzDwlA9MNXSkMBkewb
	t+C55/WQ2tXUEzhTS4DZEn205hcMCzDhynDPd/uH/uoRkZf4qiiYlsn4e5B8I4zIG6TEbNjs8Xu
	5VNkoB4R7yus6XRffKOe1RKLQy8dx8y4egPSCUaX04uaHYJGDld+VoQgRv
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514241fa.20.1790950033901;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sh9Tly5wzKSSJNxA2yNnygiWuGpta5Z4mJgO6GD0jtU_1790950034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex

