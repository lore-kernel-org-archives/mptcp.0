Content-Type: multipart/mixed; boundary="===============1548331989001156446=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Wed, 22 Jan 2020 18:51:19 +0100
Message-ID: <10968aa4-21ec-5aea-f2e8-e5d9553382dc@tessares.net>
In-Reply-To: 1ee87284cdd7358258f18d9d3ebbcd14bb74f1de.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3491

--===============1548331989001156446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 21/01/2020 18:13, Peter Krystad wrote:
> On Tue, 2020-01-21 at 15:04 +0100, Matthieu Baerts wrote:
>> Hi Peter,
> =

> <snip>
> =

>> Or do you think it will be mandatory to have this optimization now?
> =

> Not mandatory, we can go as is. I realized (after some code review) just =
this
> morning that for v1 although we do not send/receive MPC+DSS we need to ha=
ve
> space for both options at the same time. This fragment when processing
> MP_CAPABLE in mptcp_parse_option() shows the need:
> =

> 	if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA) {
> 		/* Section 3.1.:
> 		 * "the data parameters in a MP_CAPABLE are semantically
> 		 * equivalent to those in a DSS option and can be used
> 		 * interchangeably."
> 		 */
> 		mp_opt->dss =3D 1;

Good catch, we have to deal with v0 and v1. Then indeed better not to =

modify part 2 and do that in part 3.

> The code for part 2 is fine as is. I'll send the optimizations for ADD_AD=
DR,
> etc. later.

Thank you!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1548331989001156446==--
