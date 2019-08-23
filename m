Content-Type: multipart/mixed; boundary="===============1204378847559725441=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v2 2/8] mptcp: update per subflow unacked
 sequence on pkt reception
Date: Fri, 23 Aug 2019 10:40:00 -0700
Message-ID: <alpine.OSX.2.21.1908231023570.37311@gargpiyu-mobl1.amr.corp.intel.com>
In-Reply-To: 49dd44ae2a5e22104b5d1f54bf08f7568ffd964e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1690

--===============1204378847559725441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Aug 2019, Paolo Abeni wrote:

> Hi,
>
> Thank you for the feedback!
>
> On Thu, 2019-08-22 at 17:34 -0700, Mat Martineau wrote:
>> Rather than trying to sync subflow->snd_una values for the purpose of
>> expanding them to 64 bits, the subflow could record the 32-bit value and
>> let the MPTCP-level socket do the expansion? Then the subflows only need
>> to track their most recent data ack: the ack value, size (32 or 64), and
>> whether it's been updated since the last access by the MPTCP-level socke=
t.
>
> I think that tracking the most recent data ack can become almost as
> tricky, if the peer interleaves 32 and 64 bits ack (IIRC the RFC, it
> can).

Yes, the sender can interleave.

At the subflow, it's still simple (any new ack replaces the previous one =

regardless of bit width). Since the ack always moves forward, we don't =

card about the old value even if it was "better" (64-bit). And the =

expansion of a 32-bit ack on one subflow doesn't depend on the previous =

value seen on that subflow, it depends on msk->snd_una.

>
>> The MPTCP-level socket has more information to know whether to reject an
>> ambiguous 32-bit ack. Latency between the update of subflow->snd_una and
>> the check of that value by the MPTCP socket is still an issue, but could
>> be more manageable.
>
> Since expanding to 64 bits looks safer with msk->snd_una, and moving
> the msk->snd_una updates into mptcp_incoming_options() should be quite
> doable. What about that option?
>
> Yep, we need an additional lock/atomic operation, but <quote> Premature
> optimization is the root of all evil </quote>

Sounds good to me.

>
>> Side note: I know we have to handle what compliant peers send to us, but
>> maybe we should keep sending only 64-bit acks!
>
> I think we already do that ?!?

Yes, that is what we currently do. My suggestion is that we continue =

with only 64-bit acks in the future.

--
Mat Martineau
Intel

--===============1204378847559725441==--
