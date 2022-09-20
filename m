Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196E1C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:47:27 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id t3so2443254ply.2
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+NEIRDpX2PxPAcYNBNMoUY1RzU+Xf9gVqYnUWSSaR14=;
        b=XuVr4oGUAxYUYQV/6CrEvyjT8DCzthcrgbOfsKBVb/pXh/z9Kq8h2HU0yfci+SLWHn
         NMDMu2q7DrLtWg+AIWPpLmFKf3FOu/wxECKGX1sT3kzB4Q0J9XPTs1hGb48aquq1VqC+
         jEEMHkkZbTlhMhHb2cy13dPQmQbjHkPhAID/bycLXmqEyqlK1A3ltT/1Zyh4UfXeIfY/
         FUBfOLycsdzPLX1gNrZUiRzLb01Zeve+GuVOhbCqS2sbXHHow4tjoIsheI3LtR24nqxz
         xkZ8VmaLpi3+olTuZ8WWv58+VXzlqgymX4ljH6zbhL1n4rVE66Gv+lHJpCNRHiVB4p2H
         CdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+NEIRDpX2PxPAcYNBNMoUY1RzU+Xf9gVqYnUWSSaR14=;
        b=77BuBgd4euMwDJ2H5qx1qDy23WzK8BfRmKxZKWYuEk+Q74rc+aB9tkvMSUyEb/K0VW
         aVx5EBDnnjj0w5q8eeooN+ieyGwCfGPJwfpRIxPkpQZvlKSoOm4ll9wJ+PGUh8xGsuaG
         T61Zwa2LW4f9bJeURS/pIKRTGPyjWe+JvNETtxml1Fhp4NhPUdOVyJYv60E3utqOT8Oo
         u5Is5l8Gcu/aAbkLzDw5mgT8IFZfLQk36eOpxBXg9KVAXX5tLD4tQe+kgASNPRF+S+eS
         UakM7inXYghCaG8sJR/auDB7OSu2SPpgMfr3AE2duXlzrlbhANGD9rC1OqW00i/F4yUH
         q9iw==
X-Gm-Message-State: ACrzQf3jeJRmdM16HwKiPzpjyHHe58WP55cIdU7yRLqOZsJTLeq/DGWL
	osAuxhxDzCOT0xEu2g3D+x9BHZW4fV6nQ8EqjGs=
X-Google-Smtp-Source: AMsMyM7/lzj/M8yrdjovLe09ylgriH0mLp2n/Z8PIY2tUJoP5+MnVTwv/D5uCJ+xkxShjB8m3dlCfWoGBLK/8OJBJ3I=
X-Received: by 2002:a17:90b:2504:b0:203:5b24:e84b with SMTP id
 ns4-20020a17090b250400b002035b24e84bmr3918035pjb.188.1663681647484; Tue, 20
 Sep 2022 06:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220919132156.3649522-1-imagedong@tencent.com>
 <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com> <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
 <6b78ea19-4756-64be-3599-79f8d8b434b9@tessares.net>
In-Reply-To: <6b78ea19-4756-64be-3599-79f8d8b434b9@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 20 Sep 2022 21:47:16 +0800
Message-ID: <CADxym3ZEjwieR-spFw+FeN1xthAsapWTxPbYheh9tV9gUUZ4-Q@mail.gmail.com>
Subject: Re: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 20, 2022 at 7:44 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
>
> On 20/09/2022 04:10, Menglong Dong wrote:
> > On Tue, Sep 20, 2022 at 6:37 AM Mat Martineau
> > <mathew.j.martineau@linux.intel.com> wrote:
> >>
> >> On Mon, 19 Sep 2022, menglong8.dong@gmail.com wrote:
> >>
> >>> From: Menglong Dong <imagedong@tencent.com>
> >>>
> >>> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> >>> Therefore, we can get the count of used mptcp socket from
> >>> /proc/net/protocols:
> >>>
> >>> & cat /proc/net/protocols
> >>> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> >>> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> >>> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> >>>
> >>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >>
> >> Hello Menglong -
> >>
> >> Thanks for your patch.
> >>
> >> One minor thing: please use the subject line tags listed in
> >> https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes :
> >> either "[PATCH mptcp-net]" or "[PATCH mptcp-next]", so it's clear which
> >> tree the patch is intended for.
> >>
> >
> > Thanks for your remind, I'll send the next version with
> > mptcp-next tag.
>
> Thank you for the your patch.
>
> If you don't mind, can you also strip "net:" prefix from the commit
> title? Having 'mptcp:' is enough and that's what was done in most
> commits changing files from net/mptcp directory so far.
>

Oops, I forgot it again. Sure, I'll send the next version
with 'mptcp:' prefix.

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
