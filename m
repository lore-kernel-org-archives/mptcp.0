Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1753B7
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 22:46:16 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f954d7309fso1541985e87.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288374; x=1691880374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvbY1VtHDacTlHX2yMS2STO+wXONl3F2h/KAywN3deE=;
        b=VpYtjhDRUOv/3xoZwTsVh5JlMGftJr3HQ3rl3E+xq4oYjzwzAecmskRWSScLw6/pvn
         VBkxKA13nzwALSIhEUZ7/noQrDl43ulxUNZ+A2z9mMvG7nnnqCxOhnF2ibuUUzNedhRh
         UBump/paZbP8YIwsx6dksoehGat/rYh6h6brSuJBy4QIp6UJEMjLaNm6OalVT3IUPuUF
         GO0Uk9OH6FdHbMU4IG0AEvDqJRY3r8yDAZnqbRQ0aBqluZq2EQKXnxbNBlvYzl5uDTDl
         0gph90fsepnpdVpmZA0WvjGBHS1ym4zsyzXZS4sCU9w1lwKAm8G0cj7zPbTZWMd13pvN
         C7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288374; x=1691880374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvbY1VtHDacTlHX2yMS2STO+wXONl3F2h/KAywN3deE=;
        b=TZv0wF7e4CFK0i2eHTG43QE38VXH1K/H8WfX2LwK+T5E7VkrzOqKQ3OrRdmtE1pQms
         z8abpHdWN6PnI5fCv1c3RGDffPwO2/kIoPi43FxLfMukzI/2ITfheRKs0J8/IKyETdtf
         IhevCvZoqaW33ek/XN0dM8Kj5P7DPPmRbMFbgXUrDDOrQ7Et7LCVs6I//9MBRfjGGCx6
         GFah9WiV2rd7H1aYAEc2x7xcEfOhjCF10w1URaUl6goyIAf4Sh5756bLr7un1sf1z3wS
         ZgJzpyS7MmFSiCpd+Eys8pe6/AV62ODKqtbKsgGwvNiuy8gNFBHxzDcH2chccjFU6Hzx
         tyXw==
X-Gm-Message-State: ABy/qLZAZggBpVZdmspO8gyv00tI9TCbwYXuhSQMysVjRt6H12B5muws
	dqP2kN6T9tIgEyl7XXW0hkpq9DpzWLNnfzBFN4U=
X-Google-Smtp-Source: APBJJlH5+vpWKOq86J/bRX0q7MQSE32b91WSKMHSSoZi00x1LLCa9sQbwSX7r6wAgUGH/XEtb1ZHoxyTf0uA4Yn8kWc=
X-Received: by 2002:a05:6512:3e0f:b0:4f8:6b98:f4dd with SMTP id
 i15-20020a0565123e0f00b004f86b98f4ddmr335064lfv.32.1689288373786; Thu, 13 Jul
 2023 15:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1688616142.git.geliang.tang@suse.com> <ZKbzs7foUw+eeNnn@google.com>
 <20230713054716.GA18806@localhost.localdomain> <ZLAxAc1/UXcbIJBo@google.com>
In-Reply-To: <ZLAxAc1/UXcbIJBo@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Jul 2023 15:46:02 -0700
Message-ID: <CAADnVQ+aPyWea4QUD9TFNpr43u052zuqOXzGaqmM8-EeMrW6rg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
To: Stanislav Fomichev <sdf@google.com>
Cc: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:14=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On 07/13, Geliang Tang wrote:
> > On Thu, Jul 06, 2023 at 10:02:43AM -0700, Stanislav Fomichev wrote:
> > > On 07/06, Geliang Tang wrote:
> > > > As is described in the "How to use MPTCP?" section in MPTCP wiki [1=
]:
> > > >
> > > > "Your app can create sockets with IPPROTO_MPTCP as the proto:
> > > > ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can b=
e
> > > > forced to create and use MPTCP sockets instead of TCP ones via the
> > > > mptcpize command bundled with the mptcpd daemon."
> > > >
> > > > But the mptcpize (LD_PRELOAD technique) command has some limitation=
s
> > > > [2]:
> > > >
> > > >  - it doesn't work if the application is not using libc (e.g. GoLan=
g
> > > > apps)
> > > >  - in some envs, it might not be easy to set env vars / change the =
way
> > > > apps are launched, e.g. on Android
> > > >  - mptcpize needs to be launched with all apps that want MPTCP: we =
could
> > > > have more control from BPF to enable MPTCP only for some apps or al=
l the
> > > > ones of a netns or a cgroup, etc.
> > > >  - it is not in BPF, we cannot talk about it at netdev conf.
> > > >
> > > > So this patchset attempts to use BPF to implement functions similer=
 to
> > > > mptcpize.
> > > >
> > > > The main idea is add a hook in sys_socket() to change the protocol =
id
> > > > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> > > >
> > > > 1. This first solution [3] is using "cgroup/sock_create":
> > > >
> > > > Implement a new helper bpf_mptcpify() to change the protocol id:
> > > >
> > > > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > > > +{
> > > > + if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP) =
{
> > > > +         sk->sk_protocol =3D IPPROTO_MPTCP;
> > > > +         return (unsigned long)sk;
> > > > + }
> > > > +
> > > > + return (unsigned long)NULL;
> > > > +}
> > > > +
> > > > +const struct bpf_func_proto bpf_mptcpify_proto =3D {
> > > > + .func           =3D bpf_mptcpify,
> > > > + .gpl_only       =3D false,
> > > > + .ret_type       =3D RET_PTR_TO_BTF_ID_OR_NULL,
> > > > + .ret_btf_id     =3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > > > + .arg1_type      =3D ARG_PTR_TO_CTX,
> > > > +};
> > > >
> > > > Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify()
> > > > helper in this hook:
> > > >
> > > > +SEC("cgroup/sock_create")
> > > > +int sock(struct bpf_sock *ctx)
> > > > +{
> > > > + struct sock *sk;
> > > > +
> > > > + if (ctx->type !=3D SOCK_STREAM)
> > > > +         return 1;
> > > > +
> > > > + sk =3D bpf_mptcpify(ctx);
> > > > + if (!sk)
> > > > +         return 1;
> > > > +
> > > > + protocol =3D sk->sk_protocol;
> > > > + return 1;
> > > > +}
> > > >
> > > > But this solution doesn't work, because the sock_create section is
> > > > hooked at the end of inet_create(). It's too late to change the pro=
tocol
> > > > id.
> > > >
> > > > 2. The second solution [4] is using "fentry":
> > > >
> > > > Implement a bpf_mptcpify() helper:
> > > >
> > > > +BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
> > > > +{
> > > > + if (args->family =3D=3D AF_INET &&
> > > > +     args->type =3D=3D SOCK_STREAM &&
> > > > +     (!args->protocol || args->protocol =3D=3D IPPROTO_TCP))
> > > > +         args->protocol =3D IPPROTO_MPTCP;
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > > +BTF_ID_LIST(bpf_mptcpify_btf_ids)
> > > > +BTF_ID(struct, socket_args)
> > > > +
> > > > +static const struct bpf_func_proto bpf_mptcpify_proto =3D {
> > > > + .func           =3D bpf_mptcpify,
> > > > + .gpl_only       =3D false,
> > > > + .ret_type       =3D RET_INTEGER,
> > > > + .arg1_type      =3D ARG_PTR_TO_BTF_ID,
> > > > + .arg1_btf_id    =3D &bpf_mptcpify_btf_ids[0],
> > > > +};
> > > >
> > > > Add a new wrapper socket_create() in sys_socket() path, passing a
> > > > pointer of struct socket_args (int family; int type; int protocol) =
to
> > > > the wrapper.
> > > >
> > > > +int socket_create(struct socket_args *args, struct socket **res)
> > > > +{
> > > > + return sock_create(args->family, args->type, args->protocol, res)=
;
> > > > +}
> > > > +EXPORT_SYMBOL(socket_create);
> > > > +
> > > >  /**
> > > >   *       sock_create_kern - creates a socket (kernel space)
> > > >   *       @net: net namespace
> > > > @@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
> > > >
> > > >  static struct socket *__sys_socket_create(int family, int type, in=
t protocol)
> > > >  {
> > > > + struct socket_args args =3D { 0 };
> > > >   struct socket *sock;
> > > >   int retval;
> > > >
> > > > @@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create(i=
nt family, int type, int protocol)
> > > >           return ERR_PTR(-EINVAL);
> > > >   type &=3D SOCK_TYPE_MASK;
> > > >
> > > > - retval =3D sock_create(family, type, protocol, &sock);
> > > > + args.family =3D family;
> > > > + args.type =3D type;
> > > > + args.protocol =3D protocol;
> > > > + retval =3D socket_create(&args, &sock);
> > > >   if (retval < 0)
> > > >           return ERR_PTR(retval);
> > > >
> > > > Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpify=
()
> > > > in the hook:
> > > >
> > > > +SEC("fentry/socket_create")
> > > > +int BPF_PROG(trace_socket_create, void *args,
> > > > +         struct socket **res)
> > > > +{
> > > > + bpf_mptcpify(args);
> > > > + return 0;
> > > > +}
> > > >
> > > > This version works. But it's just a work around version. Since the =
code
> > > > to add a wrapper to sys_socket() is not very elegant indeed, and it
> > > > shouldn't be accepted by upstream.
> > > >
> > > > 3. The last solution is this patchset itself:
> > > >
> > > > Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and attach=
 type
> > > > BPF_CGROUP_SOCKINIT on cgroup basis.
> > > >
> > > > Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
> > > > __cgroup_bpf_run_sockinit() helper to run a sockinit program:
> > > >
> > > > +#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)      =
              \
> > > > +({                                                                =
              \
> > > > + int __ret =3D 0;                                                 =
        \
> > > > + if (cgroup_bpf_enabled(CGROUP_SOCKINIT))                         =
      \
> > > > +         __ret =3D __cgroup_bpf_run_sockinit(family, type, protoco=
l,      \
> > > > +                                           CGROUP_SOCKINIT);      =
      \
> > > > + __ret;                                                           =
      \
> > > > +})
> > > > +
> > > >
> > > > Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to chang=
e
> > > > the arguments:
> > > >
> > > > @@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int fami=
ly, int type, int protocol,
> > > >   struct socket *sock;
> > > >   const struct net_proto_family *pf;
> > > >
> > > > + if (!kern) {
> > > > +         err =3D BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &pro=
tocol);
> > > > +         if (err)
> > > > +                 return err;
> > > > + }
> > > > +
> > > >   /*
> > > >    *      Check protocol is in range
> > > >    */
> > > >
> > > > Define BPF program in this newly added 'sockinit' SEC, so it will b=
e
> > > > hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> > > >
> > > > @@ -158,6 +158,11 @@  static struct sec_name_test tests[] =3D {
> > > >           {0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
> > > >           {0, BPF_CGROUP_SETSOCKOPT},
> > > >   },
> > > > + {
> > > > +         "cgroup/sockinit",
> > > > +         {0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
> > > > +         {0, BPF_CGROUP_SOCKINIT},
> > > > + },
> > > >  };
> > > >
> > > > +SEC("cgroup/sockinit")
> > > > +int mptcpify(struct bpf_sockinit_ctx *ctx)
> > > > +{
> > > > + if ((ctx->family =3D=3D AF_INET || ctx->family =3D=3D AF_INET6) &=
&
> > > > +     ctx->type =3D=3D SOCK_STREAM &&
> > > > +     (!ctx->protocol || ctx->protocol =3D=3D IPPROTO_TCP)) {
> > > > +         ctx->protocol =3D IPPROTO_MPTCP;
> > > > + }
> > > > +
> > > > + return 1;
> > > > +}
> > > >
> > > > This version is the best solution we have found so far.
> > > >
> > > > [1]
> > > > https://github.com/multipath-tcp/mptcp_net-next/wiki
> > > > [2]
> > > > https://github.com/multipath-tcp/mptcp_net-next/issues/79
> > > > [3]
> > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769.g=
it.geliang.tang@suse.com/
> > > > [4]
> > > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249.g=
it.geliang.tang@suse.com/
> > >
> > > cgroup/sock_create being weird and triggering late and only for af_in=
et4/6
> > > was the reason we added ability to attach to lsm hooks on a per-cgrou=
p
> > > basis:
> > > https://lore.kernel.org/bpf/20220628174314.1216643-1-sdf@google.com/
> > >
> > > Unfortunately, using it here won't help either :-( The following
> > > hook triggers early enough but doesn't allow changing the arguments (=
I was
> > > interested only in filtering based on the arguments, not changing the=
m):
> > >
> > > LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, i=
nt kern)
> > >
> > > So maybe another alternative might be to change its definition to int=
 *family,
> > > int *type, int *protocol and use lsm_cgroup/socket_create to rewrite =
the
> >
> > Thanks Stanislav, this lsm_cgroup/socket_create works. The test patch
> > is attached.
> >
> > > protocol? (some verifier changes might needed to make those writable)
> >
> > But I got some verification errors here:
> >
> >    invalid mem access 'scalar'.
> >
> > I tried many times but couldn't solve it, so I simply skipped the
> > verifier in the test patch (I marked TODO in front of this code).
> > Could you please give me some suggestions for verification?
>
> Right, that's the core issue here, to add support to the verifier
> to let it write into scalar pointer arguments. I don't have a good sugges=
tion,
> but we've discussed it multiple times elsewhere that maybe we
> should do it :-)
>
> Can we use some new btf_type_tag("allow_write") to annotate places
> where we know that it's safe to write to them? Then we can extend
> the verifier to check for this condition hopefully. Maybe other BPF
> folks have better suggestions here?
>
> We should also CC LSM people to make sure it's not a no-no to
> change LSM_HOOK(s) in a way to allow changing the arguments. I'm
> not sure how rigid those definitions are :-(

imo all 3 options including this 4th one are too hacky.
I understand ld_preload limitations and desire to have it per-cgroup,
but messing this much with user space feels a little bit too much.
What side effects will it cause?
Meaning is this enough to just change the proto?
Nothing in user space later on needs to be aware the protocol is so differe=
nt?
I feel the consequences are too drastic to support such thing
through an official/stable hook.
We can consider an fmod_ret unstable hook somewhere in the kernel
that bpf prog can attach to and tweak the ret value and/or args,
but the production environment won't be using it.
It will be a temporary gap until user space is properly converted to mptcp.
