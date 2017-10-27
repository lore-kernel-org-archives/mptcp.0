Content-Type: multipart/mixed; boundary="===============5826534782533641130=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Fri, 27 Oct 2017 12:57:38 -0700
Message-ID: <20171027195738.GJ29152@da0602a-dhcp227.apple.com>
In-Reply-To: 5e21435e-d6e2-7950-b4c8-9b6adaf53a6e@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 142

--===============5826534782533641130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 26/10/17 - 15:26:00, Rao Shoaib wrote:
> =

> Hullo,
> =

> On 10/23/2017 04:10 PM, Mat Martineau wrote:
> > =

> > Yes, I'm interested too! I know David Miller is interested in making
> > good use of space in data structures:
> > https://netdevconf.org/2.2/session.html?miller-datastructurebloat-keyno=
te
> > =

> > If there's a lot of unnecessary space being used they'd probably want to
> > reclaim it and then we'd need the extra shared info again :)
> > =

> Thanks for the pointer, I will take a look.
> Take a look at my last couple of patches, they are all using regular size
> CB. The relevant changes are in mptcp_skb_entail() and
> mptcp_write_dss_mapping() and the obvious=C2=A0 tcp_skb_cb and sk_buff
> structures. The change is to calculate the mapping when the header is bei=
ng
> written not before.
> =

> I am working on net-next 4.14.0-rc4 and have been able to achieve the sam=
e.
> Here are the changes to the structure, cut and paste of the relevant code
> from any patch just works.
> =

> The change to tcp_skb_cb is
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip_dsfield;=C2=A0=C2=A0=C2=A0=C2=
=A0 /* IPv4 tos or IPv6 dsfield=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 txstamp_ack:1,=C2=A0 /* Record T=
X timestamp for ack? */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eor:1,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Is skb MSG_EOR ma=
rked? */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_rxts=
tamp:1, /* SKB has a RX timestamp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unused:5;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=
=A0=C2=A0 ack_seq;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sequence nu=
mber ACK'd */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=
=A0=C2=A0 mptcp_data_seq;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=
=A0=C2=A0 mptcp_path_mask;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =

> And used a scratch field in sk_buff, these are only needed on the Rx side.

I would love to see the rest of the patch. Especially wrt to writing the
mapping to the header.

How do you handle segments that are being split while sitting in the
subflow's send-queue and later on need to be retransmitted. Will the
retransmitted segment have the same DSS-mapping as the original
transmission?


Thanks,
Christoph

> =

> struct sk_buff {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* These=
 two members must be first. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct s=
k_buff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *next;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct s=
k_buff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *prev;
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct net_device=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Some protocols might use this sp=
ace to
> store information,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * while device pointer would =
be NULL.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * UDP receive path is one use=
r.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_scratch;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __u8 mptcp_flags;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __u8 mptcp_dss_off;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct rb_node=C2=A0 rbnode; /* used in netem & tcp stac=
k */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =

> And here is a tcpdump. Host 192.168.1.3 is running net-next "4.14.0 Fearl=
ess
> Coyote" and host 192.168.1.32 is running "4.4.88 Blurry Fish Butt"
> =

> =

> 15:21:28.581388 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [S], seq
> 1515497212, win 29200, options [mss 1460,sackOK,TS val 2460468540 ecr
> 0,nop,wscale 7,mptcp capable csum {0x26b923d415f6c4d4}], length 0
> 15:21:28.581449 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [S.], seq
> 3412665074, ack 1515497213, win 28560, options [mss 1460,sackOK,TS val
> 25517800 ecr 2460468540,nop,wscale 7,mptcp capable csum
> {0x8fd2dd8f92b5f72c}], length 0
> 15:21:28.582533 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1:42, ack 1, win 229, options [nop,nop,TS val 2460468541 ecr 25517800],
> length 41
> 15:21:28.582612 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [.], ack 4=
2,
> win 224, options [nop,nop,TS val 25517800 ecr 2460468541], length 0
> 15:21:28.591889 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [P.], seq
> 1:42, ack 42, win 224, options [nop,nop,TS val 25517802 ecr 2460468541],
> length 41
> 15:21:28.592922 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 42:1378, ack 42, win 229, options [nop,nop,TS val 2460468552 ecr 25517802=
],
> length 1336
> 15:21:28.593028 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [P.], seq
> 42:1018, ack 42, win 224, options [nop,nop,TS val 25517803 ecr 2460468552=
],
> length 976
> 15:21:28.633043 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [.], ack
> 1378, win 246, options [nop,nop,TS val 25517813 ecr 2460468552], length 0
> 15:21:28.633956 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1378:1426, ack 1018, win 244, options [nop,nop,TS val 2460468593 ecr
> 25517803], length 48
> 15:21:28.634012 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [.], ack
> 1426, win 246, options [nop,nop,TS val 25517813 ecr 2460468593], length 0
> 15:21:28.647684 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [P.], seq
> 1018:1382, ack 1426, win 246, options [nop,nop,TS val 25517816 ecr
> 2460468593], length 364
> 15:21:28.653439 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1426:1442, ack 1382, win 259, options [nop,nop,TS val 2460468612 ecr
> 25517816], length 16
> 15:21:28.692996 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [.], ack
> 1442, win 246, options [nop,nop,TS val 25517828 ecr 2460468612], length 0
> 15:21:28.693584 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1442:1486, ack 1382, win 259, options [nop,nop,TS val 2460468652 ecr
> 25517828], length 44
> 15:21:28.693632 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [.], ack
> 1486, win 246, options [nop,nop,TS val 25517828 ecr 2460468652], length 0
> 15:21:28.693706 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [P.], seq
> 1382:1426, ack 1486, win 246, options [nop,nop,TS val 25517828 ecr
> 2460468652], length 44
> 15:21:28.694310 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1486:1554, ack 1426, win 259, options [nop,nop,TS val 2460468653 ecr
> 25517828], length 68
> 15:21:28.694976 IP 192.168.1.32.ssh > 192.168.1.3.40096: Flags [P.], seq
> 1426:1478, ack 1554, win 246, options [nop,nop,TS val 25517828 ecr
> 2460468653], length 52
> 15:21:28.737617 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [.], ack
> 1478, win 259, options [nop,nop,TS val 2460468654 ecr 25517828], length 0
> 15:21:31.599860 IP 192.168.1.3.40096 > 192.168.1.32.ssh: Flags [P.], seq
> 1554:1702, ack 1478, win 259, options [nop,nop,TS val 2460471559 ecr
> 25517828], length 148
> =

> I have some other ideas that I want to try but right now I focused on
> getting something working so we can all start hacking.
> =

> Rao
> =

> =

> > > I had to bump cb up to 80 bytes in the current mptcp_trunk :/
> > > =

> > > =

> > > Christoph
> > > =

> > > > FYI. I am working on restructuring MPTCP code so it's not
> > > > intrusive to main
> > > > TCP code. I will probably try a few other techniques but can use
> > > > this as
> > > > well. I will post the changes at the appropriate time.
> > =

> > Nice, thanks for the update.
> > =

> > Regards,
> > Mat
>=20

--===============5826534782533641130==--
