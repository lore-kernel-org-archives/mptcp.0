Content-Type: multipart/mixed; boundary="===============3560881695750886226=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v2 2/8] mptcp: update per subflow unacked
 sequence on pkt reception
Date: Fri, 23 Aug 2019 18:37:33 +0200
Message-ID: <49dd44ae2a5e22104b5d1f54bf08f7568ffd964e.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1908221624420.27597@gargpiyu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1689

--===============3560881695750886226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the feedback!

On Thu, 2019-08-22 at 17:34 -0700, Mat Martineau wrote:
> Rather than trying to sync subflow->snd_una values for the purpose of =

> expanding them to 64 bits, the subflow could record the 32-bit value and =

> let the MPTCP-level socket do the expansion? Then the subflows only need =

> to track their most recent data ack: the ack value, size (32 or 64), and =

> whether it's been updated since the last access by the MPTCP-level socket=
. =


I think that tracking the most recent data ack can become almost as
tricky, if the peer interleaves 32 and 64 bits ack (IIRC the RFC, it
can).

> The MPTCP-level socket has more information to know whether to reject an =

> ambiguous 32-bit ack. Latency between the update of subflow->snd_una and =

> the check of that value by the MPTCP socket is still an issue, but could =

> be more manageable.

Since expanding to 64 bits looks safer with msk->snd_una, and moving
the msk->snd_una updates into mptcp_incoming_options() should be quite
doable. What about that option?

Yep, we need an additional lock/atomic operation, but <quote> Premature
optimization is the root of all evil </quote>

> Side note: I know we have to handle what compliant peers send to us, but =

> maybe we should keep sending only 64-bit acks!

I think we already do that ?!?

Cheers,

Paolo


--===============3560881695750886226==--
