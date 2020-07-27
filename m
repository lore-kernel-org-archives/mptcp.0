Content-Type: multipart/mixed; boundary="===============1704243797476664125=="
MIME-Version: 1.0
From: Jason A. Donenfeld <Jason at zx2c4.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Mon, 27 Jul 2020 18:16:32 +0200
Message-ID: <CAHmME9ric=chLJayn7Erve7WBa+qCKn-+Gjri=zqydoY6623aA@mail.gmail.com>
In-Reply-To: 20200727150601.GA3447@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5325

--===============1704243797476664125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 5:06 PM Christoph Hellwig <hch(a)lst.de> wrote:
>
> On Mon, Jul 27, 2020 at 05:03:10PM +0200, Jason A. Donenfeld wrote:
> > Hi Christoph,
> >
> > On Thu, Jul 23, 2020 at 08:08:54AM +0200, Christoph Hellwig wrote:
> > > diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> > > index da933f99b5d517..42befbf12846c0 100644
> > > --- a/net/ipv4/ip_sockglue.c
> > > +++ b/net/ipv4/ip_sockglue.c
> > > @@ -1422,7 +1422,8 @@ int ip_setsockopt(struct sock *sk, int level,
> > >                     optname !=3D IP_IPSEC_POLICY &&
> > >                     optname !=3D IP_XFRM_POLICY &&
> > >                     !ip_mroute_opt(optname))
> > > -           err =3D nf_setsockopt(sk, PF_INET, optname, optval, optle=
n);
> > > +           err =3D nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(=
optval),
> > > +                               optlen);
> > >  #endif
> > >     return err;
> > >  }
> > > diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_t=
ables.c
> > > index 4697d09c98dc3e..f2a9680303d8c0 100644
> > > --- a/net/ipv4/netfilter/ip_tables.c
> > > +++ b/net/ipv4/netfilter/ip_tables.c
> > > @@ -1102,7 +1102,7 @@ __do_replace(struct net *net, const char *name,=
 unsigned int valid_hooks,
> > >  }
> > >
> > >  static int
> > > -do_replace(struct net *net, const void __user *user, unsigned int le=
n)
> > > +do_replace(struct net *net, sockptr_t arg, unsigned int len)
> > >  {
> > >     int ret;
> > >     struct ipt_replace tmp;
> > > @@ -1110,7 +1110,7 @@ do_replace(struct net *net, const void __user *=
user, unsigned int len)
> > >     void *loc_cpu_entry;
> > >     struct ipt_entry *iter;
> > >
> > > -   if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
> > > +   if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
> > >             return -EFAULT;
> > >
> > >     /* overflow check */
> > > @@ -1126,8 +1126,8 @@ do_replace(struct net *net, const void __user *=
user, unsigned int len)
> > >             return -ENOMEM;
> > >
> > >     loc_cpu_entry =3D newinfo->entries;
> > > -   if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
> > > -                      tmp.size) !=3D 0) {
> > > +   sockptr_advance(arg, sizeof(tmp));
> > > +   if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
> > >             ret =3D -EFAULT;
> > >             goto free_newinfo;
> > >     }
> >
> > Something along this path seems to have broken with this patch. An
> > invocation of `iptables -A INPUT -m length --length 1360 -j DROP` now
> > fails, with
> >
> > nf_setsockopt->do_replace->translate_table->check_entry_size_and_hooks:
> >   (unsigned char *)e + e->next_offset > limit  =3D=3D>  TRUE
> >
> > resulting in the whole call chain returning -EINVAL. It bisects back to
> > this commit. This is on net-next.
>
> This is another use o sockptr_advance that Ido already found a problem
> in.  I'm looking into this at the moment..

I haven't seen Ido's patch, but it seems clear the issue is that you
want to call `sockptr_advance(&arg, sizeof(tmp))`, and adjust
sockptr_advance to take a pointer.

Slight concern about the whole concept:

Things are defined as

typedef union {
        void            *kernel;
        void __user     *user;
} sockptr_t;
static inline bool sockptr_is_kernel(sockptr_t sockptr)
{
        return (unsigned long)sockptr.kernel >=3D TASK_SIZE;
}

So what happens if we have some code like:

sockptr_t sp;
init_user_sockptr(&sp, user_controlled_struct.extra_user_ptr);
sockptr_advance(&sp, user_controlled_struct.some_big_offset);
copy_to_sockptr(&sp, user_controlled_struct.a_few_bytes,
sizeof(user_controlled_struct.a_few_bytes));

With the user controlling some_big_offset, he can convert the user
sockptr into a kernel sockptr, causing the subsequent copy_to_sockptr
to be a vanilla memcpy, after which a security disaster ensues.

Maybe sockptr_advance should have some safety checks and sometimes
return -EFAULT? Or you should always use the implementation where
being a kernel address is an explicit bit of sockptr_t, rather than
being implicit?
--===============1704243797476664125==--
