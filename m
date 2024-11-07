Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAB1917FB
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001598; cv=none; b=AOVhLmgaD+qAHkWnWHl2luRqVdhOxGF8UU7Roo+RahmCmnxRJqB+VGlhnN1kKCQ1uK0o6dWfjroV0PORYJvpEeiycDXWTj0BMEWAhiY4J1p1l19w6mg1AaJ0nWLraqisn8B+MUbd2Ek9F3Ol3b1oOPK9bC0D87Ey4wamu6qJoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001598; c=relaxed/simple;
	bh=ZxzQ0We0q+DhXqbnl6jCcwR6CouP+vqd2q3mHq7HMuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP/frYNGSHyfu9z4sbclLG04fpGMuUIvwFEcmQv0FnLmHja1PVye7ATX2ZG4aPc7JDxfsaeujwPNgNbrg4WkvPHJ/5SoJQMYRfqZHU7g7YUwseGueG0qyWnmOHJ5u/IDoEGeD4G1z07QtRc552JnUWDl6lUspEc2i90S5yNCrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5hennCh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5hennCh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c805a0753so13154555ad.0
        for <mptcp@lists.linux.dev>; Thu, 07 Nov 2024 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001596; x=1731606396; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCDm5TkIQ8O2flDWJYV9Rk95Ql5sknkttmMph639aPA=;
        b=Y5hennCh4mqR+jWc+imxE7DavMm3HFXeuWW9aoockEi/KM4f1WU5jnW4YC4+3bLh85
         CXEq/a2DvWxyV2+vMBarSNwoKH5KhCDSWPoRirq17oTUSl1SHtsFyqNWDipPz9Jt4RpQ
         mACdTW+aI0FtxlUHfFTbGQhdTdr7lo3Bm/nfk/le2NeycPx8XzOCIUrifM+I+r/p4Bv7
         WWc9ZVMadGxI2WQBamgkxGQx+guS+bxkcSHappnjJwbI3ZUW15jRv5LOZphsBiQ5rOkz
         yWrFLxmIqfPk1iAASsTq2jAkOEHWPKby6vebckKKMmnfxTZIRE9jYospnvIhcVpnlnpH
         3+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001596; x=1731606396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCDm5TkIQ8O2flDWJYV9Rk95Ql5sknkttmMph639aPA=;
        b=pSIsIj9iP9ARzpx4wlGKvjJ9A+r8HMdheQobdzSywYj6X3gIxe9+vRtQOhr/cALmp0
         KF7iDbbpymjNHTF00ppQUgJCi8/3Xlg0t2iRfXiig70OChzNWnAzp3L5qtHwv45igJqu
         KJZMk3knl9KLULrUNYwHm3iP61uJoKs9UNFCnWpwcKqfaV5D/0p9CnDiYmLPWH8X0EgH
         DffsLD+bPj3Ls2btWjSy0c0c4WH10anl3nZ3hJpmZOzEe9iSglhsIZFHZXTT8PSCq2Cp
         fZJpjoYsvuawmBm7YrCLyrdkm0/Ljo6Ycm8mOwx2uwRYmOs/rhnZVpBAj6DfHYdNNwqy
         dVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcwmkgD+6dHgB55neFssn9tGxDNkKzP/QQXoxh36bB8A0QfzxT5bxox9/6dwN6kvSuPp/w9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB6R/2aPus3ef0X9o8EpWXZrMRxIvMU9unfGwmLayRpbxyaBOU
	6ImNTCJ2sK3ZGxxCUEhXW3q5TSGRb0UalPf5qxsByHsTHCkP4bRkH3JJkVhXuiwS49VzoKW7JXi
	wW7E9uYOFlRX/3Q76nI0SV8reJNo=
X-Google-Smtp-Source: AGHT+IFS61YErhMGyE1e7CSJuHP5D8rTcf7usM+suyIOxoVkHE7OEYndNdtcdrJqPiyHkl23c5alRySs4G0b9f6FhnM=
X-Received: by 2002:a17:90b:17cb:b0:2e2:cef9:8f68 with SMTP id
 98e67ed59e1d1-2e9b16ee943mr34257a91.4.1731001596434; Thu, 07 Nov 2024
 09:46:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241106-tcp-md5-diag-prep-v1-5-d62debf3dded@gmail.com> <20241107002555.57247-1-kuniyu@amazon.com>
In-Reply-To: <20241107002555.57247-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 7 Nov 2024 17:46:25 +0000
Message-ID: <CAJwJo6aB+GL2fiJDmm=zq_dNOu4pS_6c8NOgKzYgbiEG2e3xmQ@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/diag: Limit TCP-MD5-diag array by max
 attribute length
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: devnull+0x7f454c46.gmail.com@kernel.org, borisp@nvidia.com, 
	colona@arista.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, geliang@kernel.org, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 00:26, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
> Date: Wed, 06 Nov 2024 18:10:18 +0000
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Currently TCP-MD5 keys are dumped as an array of
> > (struct tcp_diag_md5sig). All the keys from a socket go
> > into the same netlink attribute. The maximum amount of TCP-MD5 keys on
> > any socket is limited by /proc/sys/net/core/optmem_max, which post
> > commit 4944566706b2 ("net: increase optmem_max default value") is now by
> > default 128 KB. With the help of selftest I've figured out that equals
> > to 963 keys, without user having to increase optmem_max:
> > > test_set_md5() [963/1024]: Cannot allocate memory
> >
> > The maximum length of nlattr is limited by typeof(nlattr::nla_len),
> > which is (U16_MAX - 1). When there are too many keys the array written
> > overflows the netlink attribute. Here is what one can see on a test,
> > with no adjustments to optmem_max defaults:
> >
> > > recv() = 65180
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64804)
> > > recv() = 130680
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64768)
> > >              attr type: 29555 (25966)
> > > recv() = 130680
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64768)
> > >              attr type: 29555 (25966)
> > >              attr type: 8265 (8236)
> >
> > Here attribute type 18 is INET_DIAG_MD5SIG, the following nlattr types
> > are junk made of tcp_diag_md5sig's content.
> >
> > Here is the overflow of the nlattr size:
> > >>> hex(64768)
> > '0xfd00'
> > >>> hex(130300)
> > '0x1fcfc'
> >
> > Limit the size of (struct tcp_diag_md5sig) array in the netlink reply by
> > maximum attribute length. Not perfect as NLM_F_DUMP_INTR will be set on
> > the netlink header flags, but the userspace can differ if it's due to
> > inconsistency or due to maximum size of the netlink attribute.
> >
> > In a following patch set, I'm planning to address this and re-introduce
> > TCP-MD5-diag that actually works.
>
> Given the issue has not been reported so far (I think), we can wait for
> the series rather than backporting this.

Yeah, my concern is that ss or or other tools may interrupt the
md5keys from overflow as other netlink attributes and either show
non-meaningful things or even hide some socket information (as if an
attribute is met the second time, from what I read in ss code, it will
put the last met attribute of the same type over previous pointers and
print only that).

Regarding reports, one has to have U16_MAX / sizeof(struct
tcp_diag_md5sig) = 655 keys on a socket. Probably, not many people use
BGP with that many peers.

I'm fine moving that to later net-next patches; I've sent it only
because the above seemed concerning to me.

Thanks,
             Dmitry
