Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AC7E
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 02:08:37 +0000 (UTC)
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-3f15a6f72d0so35853017b3.1
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 18:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBH1NCfGM0uQDcYGhuil27iyED/TBwGIdOiHXwUvgXo=;
        b=XsC1+KesBR1YYJBFYLDTw4wGxxaVR5tcCt+7FS1Eg3Nj/0lQ0tQfVMPYgIdcpqN+1z
         GKEj7GvhmwwGTwz8GOjgvx1639cpKdRVX8CVA7dI/nCuaObe2qXhsheFbMkiZ2GY3yJ9
         N2fA0xmumxB1LvLNpif6ZPLJiD5wy+0UhpWBCezt1+Z4YuJNmrMTmZtrDArzeigEqsni
         bxCx0FTUjc+cMIyP54JHY9gQ08ZDrId5LKszEvy/BL6yFIlyW8rT2rm5F2TuzHCHk9nj
         ojnx8rEp05EbJEXhLI9c9sUIK23MXc4MZcOuBMwdXilNMF6h2XEbGc1kfTsmxE0tNNjJ
         H+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBH1NCfGM0uQDcYGhuil27iyED/TBwGIdOiHXwUvgXo=;
        b=ZArMBSDrueJ8uu/VJN1u+MTPG1vV37F66YGtYE/rq18cFrL1ttX7/qEO5qSbd15xpn
         pPgyk9aDwLPCmfk+NZhpVZXIqhnmtxYUN0PfKzW+nCdqFM6IzBJGD706fuoYI3xLiHfX
         tYhSVFOFQNQE4krrMv9DsfgfoXwV25qEdFYvJuKuXYv9xidHlLSP1PNubz8dQ8FTs1KO
         thXa7afWuRIjSSWbQ08syLo42PSpHsl8JMWJ+aeu2eFWW1gMefOf4Rvcqd9aVzounfV+
         DGO/QytWp6snuGFnRZu0WqiqJUCeqZ6XH0EJypUej6RtzBxgS7oVioOoOs97keAu/hOA
         UO7Q==
X-Gm-Message-State: ANoB5pnM+7LBZ5ejMdXQQlOnUMxwlQQUMI2pg2+0bwdZ8lf20GvjiMvL
	iFhvDCoB+VAl3KcYqMvDZy/w+AQN0gvJTSnoHQU=
X-Google-Smtp-Source: AA0mqf798mdie6SeMblB80AGHNOesZdVu3bE6yk2J8VsvfZg/ZNtd+YO2CobqJUwk2NsO9+30xjGC3IYp7dOVaWAngM=
X-Received: by 2002:a81:1709:0:b0:3be:16c3:6829 with SMTP id
 9-20020a811709000000b003be16c36829mr56653802ywx.298.1670551716209; Thu, 08
 Dec 2022 18:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221208024543.113633-1-imagedong@tencent.com>
 <20221208024543.113633-3-imagedong@tencent.com> <b4ef6ea7-4eaa-05ef-9447-43763e1c0aea@tessares.net>
In-Reply-To: <b4ef6ea7-4eaa-05ef-9447-43763e1c0aea@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 9 Dec 2022 10:08:24 +0800
Message-ID: <CADxym3ZRTyY-gX_uJCYE7QvtU+p2isLgiiPPWVf=toBFu33UTg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 8, 2022 at 9:53 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong Dong,
>
> On 08/12/2022 03:45, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> > Therefore, we can get the count of used mptcp socket from
> > /proc/net/protocols:
> >
> > & cat /proc/net/protocols
> > protocol  size sockets  memory press maxhdr  slab module     cl co di a=
c io in de sh ss gs se re sp bi br ha uh gp em
> > MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  =
y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  =
y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v8:
> > - remove the MPTCP_INUSE flag and do the statistics according to the
> >   creation and destruction of the token
>
> Thank you for the new version!
>
> I marked this series as "Changes Requested" on Patchwork because I guess
> you saw the CI was not happy with the KUnit token tests, e.g.:
>
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): insmod - Critical: 3 Call Trace(s) =E2=9D=
=8C:
>   - Task: https://cirrus-ci.com/task/5270512411082752
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5270512411082752/summary/summa=
ry.txt
>   - Debug: https://cirrus-ci.com/task/4989037434372096
>
> Do you mind looking at that please?
>

Of course! I'll run all of the tests to make sure they pass.

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
