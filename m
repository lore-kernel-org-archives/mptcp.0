Content-Type: multipart/mixed; boundary="===============7290470658414599697=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Tue, 21 Jan 2020 09:13:12 -0800
Message-ID: <1ee87284cdd7358258f18d9d3ebbcd14bb74f1de.camel@linux.intel.com>
In-Reply-To: 60a32d03-df98-fc36-5161-dfb6dd6a40dd@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3450

--===============7290470658414599697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-21 at 15:04 +0100, Matthieu Baerts wrote:
> Hi Peter,

<snip>

> Or do you think it will be mandatory to have this optimization now?

Not mandatory, we can go as is. I realized (after some code review) just th=
is
morning that for v1 although we do not send/receive MPC+DSS we need to have =

space for both options at the same time. This fragment when processing
MP_CAPABLE in mptcp_parse_option() shows the need:

	if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA) {
		/* Section 3.1.:
		 * "the data parameters in a MP_CAPABLE are semantically
		 * equivalent to those in a DSS option and can be used
		 * interchangeably."
		 */
		mp_opt->dss =3D 1;

The code for part 2 is fine as is. I'll send the optimizations for ADD_ADDR,
etc. later.

Peter.

> Cheers,
> Matt

--===============7290470658414599697==--
