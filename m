Content-Type: multipart/mixed; boundary="===============2058075724213550621=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 05/16] tcp: Add IPPROTO_SUBFLOW
Date: Thu, 11 Oct 2018 14:33:54 +0200
Message-ID: <CAKuKrBnyVTKRiA9K1--PEa=2mNqnOwx6gY2e0Z3U1jqOawmbYQ@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1810101355130.11293@dwiltz-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 824

--===============2058075724213550621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 11:04 PM Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
>
>
> On Wed, 10 Oct 2018, Christoph Paasch wrote:
>
> > On 10/10/18 - 19:47:29, Krystad, Peter wrote:
> >> On Tue, 2018-10-09 at 20:35 -0700, Mat Martineau wrote:
> >>> On Tue, 9 Oct 2018, Matthieu Baerts wrote:
> >>>
> >>>> On Sat, Oct 6, 2018 at 1:04 AM Mat Martineau
> >>>> <mathew.j.martineau(a)linux.intel.com> wrote:
> >>>>>
> >>>>> From: Peter Krystad <peter.krystad(a)intel.com>
> >>>>>
> >>>>> IANA protocol numbers fit in a single byte, however the protocol fi=
eld
> >>>>> of struct inet_protosw is an unsigned short so defining IPPROTO_SUB=
FLOW
> >>>>> as a 16-bit value greater than 0xFF with the same LSB as IPPROTO_TC=
P is
> >>>>> convenient for registering a unique protocol with inet_register_pro=
tosw()
> >>>>> that still transmits packets with IPPROTO_TCP as the protocol numbe=
r.
> >>>>
> >>>> Should we then call it IPPROTO_TCP_SUBFLOW? :)
> >>>>
> >>>
> >>> Hopefully we won't need a special IPPROTO_ for the subflows in the lo=
ng
> >>> run. It could be defined internally for kernel code with some checks =
to
> >>> prevent userspace-owned sockets of this type. Since the MPTCP kernel =
code
> >>> has complete control over the subflow sockets, maybe we could create
> >>> regular TCP sockets and modify them before using them (kind of like U=
LP
> >>> does, but without using the ULP infrastructure between an MPTCP socke=
t and
> >>> its subflows).
> >>>
> >>> Mat
> >>>
> >> The purpose of my approach with IPPROTO_SUBFLOW was it reduced a lot of
> >> impacts to the TCP code by allowing overriding all the 'struct proto'
> >> routines, and defining the sock structure size as the size of
> >> subflow_sock. Tradeoff would be more "if (sk->is_mptcp)" hooks in TCP
> >> code.
> >
> > Yes, I think it's a good approach to have a separate struct proto for
> > subflows.
>
> To be more specific about what I meant by "kind of like ULP does":
>
>   * inet_connection_sock->icsk_ulp_data can store the extra information
> that's in subflow_sock now (so allocating a larger sock structure is not
> required)
>
>   * all the struct proto routines can still be overridden immediately aft=
er
> subflow TCP socket creation without defining IPPROTO_SUBFLOW

Sorry, my comment was not clear: I also think it is a good idea to
have a dedicated struct proto for subflows but my point was: because
the description of the commit was saying we are so closed from
IPPROTO_TCP, should we then call it IPPROTO_TCP_SUBFLOW instead of
IPPROTO_SUBFLOW. Because the latter looks like a new proto, not linked
to MPTCP nor TCP? :)

Matthieu

>
> Mat
>
>
> >>>
> >>>>>
> >>>>> Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
> >>>>> ---
> >>>>>  include/uapi/linux/in.h | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> >>>>> index f65975c801e5..6986aecd0f46 100644
> >>>>> --- a/include/uapi/linux/in.h
> >>>>> +++ b/include/uapi/linux/in.h
> >>>>> @@ -78,6 +78,8 @@ enum {
> >>>>>  #define IPPROTO_MPLS           IPPROTO_MPLS
> >>>>>    IPPROTO_RAW =3D 255,           /* Raw IP packets                =
       */
> >>>>>  #define IPPROTO_RAW            IPPROTO_RAW
> >>>>> +  IPPROTO_SUBFLOW =3D 262,       /* Multipath TCP (IPPROTO_TCP | 0=
x100)  */
> >>>>> +#define IPPROTO_SUBFLOW                IPPROTO_SUBFLOW
> >>>>>    IPPROTO_MAX
> >>>>>  };
> >>>>>  #endif
> >>>>> --
> >>>>> 2.19.1
> >>>>>
> >>>>> _______________________________________________
> >>>>> mptcp mailing list
> >>>>> mptcp(a)lists.01.org
> >>>>> https://lists.01.org/mailman/listinfo/mptcp
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Matthieu Baerts | R&D Engineer
> >>>> matthieu.baerts(a)tessares.net
> >>>> Tessares SA | Hybrid Access Solutions
> >>>> www.tessares.net
> >>>> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> >>>>
> >>>> Disclaimer: https://www.tessares.net/mail-disclaimer/
> >>>>
> >>>
> >>> --
> >>> Mat Martineau
> >>> Intel OTC
> >>> _______________________________________________
> >>> mptcp mailing list
> >>> mptcp(a)lists.01.org
> >>> https://lists.01.org/mailman/listinfo/mptcp
> >> _______________________________________________
> >> mptcp mailing list
> >> mptcp(a)lists.01.org
> >> https://lists.01.org/mailman/listinfo/mptcp
> >
>
> --
> Mat Martineau
> Intel OTC



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============2058075724213550621==--
