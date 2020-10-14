Content-Type: multipart/mixed; boundary="===============6159551201568737832=="
MIME-Version: 1.0
From: yoshi nishida <nsdairy at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Wed, 14 Oct 2020 02:02:31 -0700
Message-ID: <CAO=PVE-KKsfQufb1N8xjqqFKrqQ09vc03yPP_zv01FnScdDXkA@mail.gmail.com>
In-Reply-To: 20201008182824.GB34635@MacBook-Pro.local
X-Status: 
X-Keywords:                  
X-UID: 6299

--===============6159551201568737832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Sorry for the late reply. Yes, I meant the repo of multipath-tcp.org kernel.
As far as I tested, it seems that they are quite different and they
cannot interact with each other.
But, at least, I understand the situation. Thanks for the explanation!
So, if I find a bug in the upstream code, it is ok to send it to the
upstreaming list?

Thanks,
--
Yoshi

On Thu, Oct 8, 2020 at 11:28 AM Christoph Paasch <cpaasch(a)apple.com> wrot=
e:
>
> +MPTCP upstreaming list
>
> Hello Yoshi,
>
> On 10/08/20 - 01:44, yoshi nishida wrote:
> > Hello,
> >
> > It's really great to see mptcp codes in main stream.  So, I've tried
> > to use it with kernel 5.8 in ubuntu20.10.
> > However, as far as I've checked, the mptcp in the kernel seems to be
> > different from the one in the repo.
>
> The repo, you mean the repo of multipath-tcp.org kernel? Yes, they are
> entirely different. The MPTCP implementation in upstream Linux (5.6+) is a
> complete rewrite.
>
> > I am not sure how to set scheduler
> > or path manager with this.
>
> It is currently not possible to select different schedulers on the upstre=
am
> implementation.
>
> For path-management there is an ip-mptcp interface that allows you to add
> subflows and addresses: https://man7.org/linux/man-pages/man8/ip-mptcp.8.=
html
>
>
> Christoph
>
> > Does anyone know about the differences?
> > Sorry if I overlooked something.
> >
> > Thanks,
> > --
> > Yoshi
>
> > MPTCP-developpers Mailing-List
> > Visit http://multipath-tcp.org to access the source-code of MPTCP in th=
e Linux Kernel
> >
> > To Unsubscribe, visit https://listes-2.sipr.ucl.ac.be/sympa/info/mptcp-=
dev
> >
>
--===============6159551201568737832==--
