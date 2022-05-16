Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A8A2A
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 02:20:40 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso16054990pjb.1
        for <mptcp@lists.linux.dev>; Sun, 15 May 2022 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HYc1KBnMRHIGYYTXYXfwZVkVgzlXkDCdUTN6VcRSFuM=;
        b=mSH6ZoY3WRYUaFE8iVU2NHWb3Kh+SlE0wMWQTsvxR9XO558N9uOe2X5C3XoAUnHlU2
         EOhSNhOGpSrFGW9Rfc3uNwtWIZcjtQZpU/kTJsmQQ1E5LdY+KCQGbFOWtTGBjIiFiN55
         Jfpp7WOLA8PYZgz6Bq8Yb7WST6bgh8SNvIuDmFlwj/Z8ppjn2QJjR6F7Bk203AywYDGA
         IJfQzPA7S5qBqCl7pJJ/1jJUiBZZ/ggRUuTA2mtJgOd9CyZS5upoazcbfzzeF0bGQdtC
         yCICNzpNW1LwbC4QtqCulpTXoGh3/mXydQrSVgqOJcRWnHCusPgttDY5uOGMjrizlLiR
         n9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HYc1KBnMRHIGYYTXYXfwZVkVgzlXkDCdUTN6VcRSFuM=;
        b=IUPlpOZaKN42DykxNWxQyv44xvJNLMGvBtAx2HXpTULAwCjdjYkg1y6H3eYr6++M7u
         MQjVeGuZHnnqCNDy36WMGNEdMnoVeFmjSfHP879ItSOSy/MbW3G97H0KtD+x54eVcQPL
         OKVf3GwRybwLV+0+ouuR+uhCE8ZtnL6fBw5bSsQi9mvKhB9jPFIP+c6XUn/TtZgT5CRG
         rYCRMe55VEH04dmwTDeLWWZxUscUrRFUSDCH59Lc7vzDFfTok4cA5FYSgX/kTt+DHdix
         +OOnTHDS1gmSfQy9vymMRBDHEL08O5zem2iVssHziaHz+TouARuYOW5lCfovp//0kg39
         ZAew==
X-Gm-Message-State: AOAM5313C5Jo4JX3p3kHLVBzJ44X7J2tgSJao4LTRfJYXuyUvU0SaLgz
	sBKb3jOyAHw+nBGOp15v/UIXOBxhcUAhveDYSx8=
X-Google-Smtp-Source: ABdhPJzzQMIif/C6kKiocjlD/CKX5YVbxQfXAyeH8fWUJB5WShQ/T0BD/03m2Raf7hTXIbHVrK0RoI6hpnzW9T1WZog=
X-Received: by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP id
 t15-20020a1709028c8f00b0015eab1c591bmr15772383plo.171.1652667640079; Sun, 15
 May 2022 19:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1652255615.git.geliang.tang@suse.com> <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
 <20220514154845.GA4189@bogon.HOST> <f697c655-618e-841c-4f60-3c57078e4a76@tessares.net>
 <CA+WQbwvKWodtjjjFyidvzXVCAj=0-qYinvvbUUd=QjUQ+oejyQ@mail.gmail.com>
In-Reply-To: <CA+WQbwvKWodtjjjFyidvzXVCAj=0-qYinvvbUUd=QjUQ+oejyQ@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 16 May 2022 10:20:41 +0800
Message-ID: <CA+WQbwsJpiLPNhtEMyV60if7qoSSjtq0xmgRW=DAS71OJVnGDQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E6=97=A5 00:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Matt,
>
> Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B45=E6=
=9C=8815=E6=97=A5=E5=91=A8=E6=97=A5 00:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Geliang,
> >
> > On 14/05/2022 17:48, Geliang Tang wrote:
> > > On Sat, May 14, 2022 at 01:25:35PM +0200, Matthieu Baerts wrote:
> > >> Hi Geliang, Mat
> > >>
> > >> On 11/05/2022 09:56, Geliang Tang wrote:
> > >>> v2:
> > >>>  - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andri=
i)
> > >>>  - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Mart=
in & Andrii)
> > >>>
> > >>> base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
> > >>> net-next-next") on export/20220510T054929
> > >>>
> > >>> v1:
> > >>>  - drop bpf_mptcp_helpers.h (Andrii)
> > >>>  - patch 6, skip the test if 'ip mptcp monitor' is not supported (M=
at)
> > >>
> > >> Thank you for the patches.
> > >>
> > >> I *think* everything is now sync in our tree but feel free to check
> > >> because I had to "manually" compare patches with what was in our tre=
e.
> > >>
> > >> But in theory, our tree is now ready for a v5.
> > >
> > > Thanks Matt, but three patches still need to be updated:
> > >
> > > Patch #4, selftests/bpf: test bpf_skc_to_mptcp_sock
> > >
> > > if (!tcp_sk->is_mptcp) {
> > >
> > > ->
> > >
> > > if (!is_mptcp) {
> >
> > Thank you, I missed that!
> >
> > - a973ee164a70 tg: fix wrong merge conflict resolution
> >
> > > Patch #10, mptcp: add sched in mptcp_sock
> > >
> > >  struct mptcp_sock {
> > >       struct inet_connection_sock     sk;
> > >
> > > -     __u32           token;
> > > -     struct sock     *first;
> > > -     char            ca_name[TCP_CA_NAME_MAX];
> > > +     __u32                   token;
> > > +     struct sock             *first;
> > > +     struct mptcp_sched_ops  *sched;
> > > +     char                    ca_name[TCP_CA_NAME_MAX];
> > >  } __attribute__((preserve_access_index));
> > >
> > > ->
> > >
> > >       __u32           token;
> > >       struct sock     *first;
> > > +     struct mptcp_sched_ops *sched;
> > >       char            ca_name[TCP_CA_NAME_MAX];
> > >  } __attribute__((preserve_access_index));
> >
> > I did that on purpose, I thought it was clearer to read after.
> >
> > Do you prefer not to change the alignment?
>
> Yes, I prefer not to change the alignments, it's much easier. If we
> want to change them, it's better to squash the changes into the
> original patches.

Hi Matt & Mat,

I think it's better to keep the alignment of members of mptcp_sock in
bpf_tcp_helpers.h as the same as the alignment of mptcp_sock in
net/mptcp/protocol.h. So I just sent a squash-to patch in our ML to
fix this.

Anyway, bpf patches in our tree are now ready for a bpf-next v5.

Thanks,
-Geliang


>
> Thanks,
> -Geliang
>
> >
> > > Patch #13, selftests/bpf: add bpf_first scheduler
> > >
> > > bpf_mptcp_helpers.h
> > >
> > > ->
> > >
> > > bpf_tcp_helpers.h
> >
> > Thanks!
> >
> > - fc2aafca4737: bpf: use bpf_tcp_helpers.h instead of the mptcp one
> >
> > Cheers,
> > Matt
> > --
> > Tessares | Belgium | Hybrid Access Solutions
> > www.tessares.net
> >
