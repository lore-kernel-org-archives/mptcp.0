Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A1154A6
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:25:17 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f415a90215so4631345e9.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684311916; x=1686903916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNsre8w8dttvFSNGphOs8/RQQeSWxBW25zY/SPaE09Y=;
        b=RKyPCNsbiRUoIRHOs8lpAc8hkD6bkyzObv3E7dC3enH0rEvkiBwH/361L0EjQo4K7l
         blEcVkobSWVWiWwY+QidJ/eT/WPUuss04tL+77q1NbtkCrzHrIZEl21N/INtPQD8AOaO
         Hxpf3cKDbsbPRUQKbbh3HzKwX/fok4h1W38b1z4wKFHK2Wdm8bfJeLYawR+JzjMnih+D
         4ddzX2OORvsSF5ZLJTsVT4vP7/bDBKydDbt+C8v3GIWtcfmR53skFtdpKUOS/Q5SoV7U
         oF/6vCjICpmTUIU7IF01pVQ+nUDd71Vs3jwbqVxuDOzJauAxQ+jZOxJk+TeAlyG65Wbw
         FMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311916; x=1686903916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNsre8w8dttvFSNGphOs8/RQQeSWxBW25zY/SPaE09Y=;
        b=J4NM/5mZFShfZfLFqv/RfXoDqn69PsPqxok6g4v4ydIiTg+m4ZKybLjPuBzHgAU9J4
         Nvbc5PzQIWuBYzDgF2pzduPcoTmCkpzrSBp2q4f4NtVSwTpJ9sYt7QEMPOueYgzMgJcN
         P1DPhr+Vlc7ByxtfhJcMZQ1i3Y7cwzFAB5o96a4LtPPP7x+f2A3RQ8ghU4vtB7MBC+ps
         fPn1gJuh0Th7+i23grd64xLe85yaSTzMUbUFdtonnKTj5DuoG79uZaqLmGtlb5aPb7wA
         09PAC/gkmoJUdEbPUL3PWvFC5g8AbtiSNZe2+2L65W94/fpEOTprXBmfyFWtxKVgJaDf
         oEow==
X-Gm-Message-State: AC+VfDwpPeQjNuvI4AsICI5FKj1cYtD23AzB/jAHVtRKmGHRqaje8Ik4
	iQaHsf9ZDGY1hs5gHE4crSu1M8hgyqmtgz3xvMW/8xIdxsc=
X-Google-Smtp-Source: ACHHUZ4GN3Me1GV6PCfsUUUnv19BoWIyOOPcQVbVCBVAo8VI9YUrQkIezS67vM1o5fQmq7btZ1INnwM+S9/HdnjMg30=
X-Received: by 2002:a1c:7304:0:b0:3f3:888b:ab78 with SMTP id
 d4-20020a1c7304000000b003f3888bab78mr26939495wmb.37.1684311915744; Wed, 17
 May 2023 01:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1684297911.git.geliang.tang@suse.com> <5ddd82f8a26cd37805ad9fdc23d16d936ab71813.1684297911.git.geliang.tang@suse.com>
 <4aa90a22-c099-b405-7ec7-da492b282fc8@tessares.net>
In-Reply-To: <4aa90a22-c099-b405-7ec7-da492b282fc8@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 17 May 2023 16:25:07 +0800
Message-ID: <CA+WQbwugQkGJS5fQ-bgb833M3Gt21fDzmJbi-Tu=Zx5VPeuRRw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: Add bpf_first test"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B45=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=B8=89 15:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 17/05/2023 06:32, Geliang Tang wrote:
> > Run mptcp sched test in a dedicated netns.
>
> Thank you for looking at this!
>
> I just have a few comments and ideas below (the last one is also valid
> for the patches 2 to 4/4).
>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 61 ++++++++++++++-----
> >  1 file changed, 46 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
> > index de8b6c68fc30..c6fd5c2449f3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -271,42 +271,69 @@ static void send_data(int lfd, int fd)
> >  #define ADDR_1       "10.0.1.1"
> >  #define ADDR_2       "10.0.1.2"
> >
> > -static void sched_init(char *flags, char *sched)
> > +static struct nstoken *sched_init(char *flags, char *sched)
> >  {
> > +     struct nstoken *nstoken =3D NULL;
> >       char cmd[64];
> >
> > -     system("ip link add veth1 type veth peer name veth2");
> > -     snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1)=
;
> > +     SYS(fail, "ip netns add %s", NS_TEST);
> > +     SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> > +
> > +     nstoken =3D open_netns(NS_TEST);
> > +     if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> > +             goto fail;
> > +
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s link add veth1 type veth p=
eer name veth2", NS_TEST);
> > +     system(cmd);
>
> While at it, should you not use here and below:
>
>   SYS(fail, "...", ...);
>
> ... instead of snprintf() + system()?
>
> With that, we will be able to catch issues with the commands here and bel=
ow.
>
> (also, cmd[64] might be too small, in SYS(), they use 1024)
>
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth1",=
 NS_TEST, ADDR_1);
> > +     system(cmd);
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s link set veth1 up", NS_TES=
T);
> > +     system(cmd);
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s addr add %s/24 dev veth2",=
 NS_TEST, ADDR_2);
> >       system(cmd);
> > -     system("ip link set veth1 up");
> > -     snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2)=
;
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s link set veth2 up", NS_TES=
T);
> >       system(cmd);
> > -     system("ip link set veth2 up");
> >
> > -     snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2,=
 flags);
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint add %s %s",=
 NS_TEST, ADDR_2, flags);
> >       system(cmd);
> > -     snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=3D%s",=
 sched);
> > +     snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp=
.scheduler=3D%s",
> > +              NS_TEST, sched);
> >       system(cmd);
> > +
> > +fail:
> > +     return nstoken;
> >  }
> >
> > -static void sched_cleanup(void)
> > +static void sched_cleanup(struct nstoken *nstoken)
> >  {
> > -     system("sysctl -qw net.mptcp.scheduler=3Ddefault");
> > -     system("ip mptcp endpoint flush");
> > -     system("ip link del veth1");
> > +     char cmd[64];
> > +
> > +     snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp=
.scheduler=3Ddefault",
> > +              NS_TEST);
> > +     system(cmd);
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint flush", NS_=
TEST);
> > +     system(cmd);
> > +     snprintf(cmd, sizeof(cmd), "ip -net %s link del veth1", NS_TEST);
> > +     system(cmd);
> > +
> > +     if (nstoken)
> > +             close_netns(nstoken);
> > +     SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
>
> Is it not enough to just destroy the netns? So just the two last steps.

Sorry, I didn't get this. Could you please explain more about it. Thanks.

-Geliang

>
> >  }
> >
> >  static int has_bytes_sent(char *addr)
> >  {
> >       char cmd[64];
> >
> > -     snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'=
", addr);
> > +     snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep=
 -q bytes_sent:",
> > +              NS_TEST, addr);
>
> Do you not need a larger size for 'cmd'? Maybe safer to bump it to 128
> (or more) because the following is 65 bytes long (including the \0 at
> the end):
>
>   ip netns exec mptcp_ns ss -it dst 10.0.1.1 | grep -q bytes_sent:
>
>
> >       return system(cmd);
> >  }
> >
> >  static void test_first(void)
> >  {
> >       struct mptcp_bpf_first *first_skel;
> > +     struct nstoken *nstoken =3D NULL;
> >       int server_fd, client_fd;
> >       struct bpf_link *link;
> >
> > @@ -320,7 +347,10 @@ static void test_first(void)
> >               return;
> >       }
> >
> > -     sched_init("subflow", "bpf_first");
> > +     nstoken =3D sched_init("subflow", "bpf_first");
> > +     if (!ASSERT_OK_PTR(nstoken, "sched_init"))
>
> It might be good to add the name of the test in the error not to have
> the same error for all subtests, no?
>
>   if (!ASSERT_OK_PTR(nstoken, "sched_init: bpf_first"))
>
> (same for the other tests)
>
> > +             goto fail;
> > +
> >       server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
> >       client_fd =3D connect_to_fd(server_fd, 0);
> >
> > @@ -330,7 +360,8 @@ static void test_first(void)
> >
> >       close(client_fd);
> >       close(server_fd);
> > -     sched_cleanup();
> > +fail:
> > +     sched_cleanup(nstoken);
> >       bpf_link__destroy(link);
> >       mptcp_bpf_first__destroy(first_skel);
> >  }
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
