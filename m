Content-Type: multipart/mixed; boundary="===============1920913587215464143=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Thu, 10 Sep 2020 17:12:39 -0700
Message-ID: <alpine.OSX.2.23.453.2009101710430.6323@pbudhkar-mobl.amr.corp.intel.com>
In-Reply-To: eaac35d1-30e7-7cea-27dd-35fe1a733af2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5795

--===============1920913587215464143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2020, Matthieu Baerts wrote:

> Hi Mat, Paolo,
>
> On 09/09/2020 18:45, Paolo Abeni wrote:
>> On Tue, 2020-09-08 at 13:33 -0700, Mat Martineau wrote:
>>> On Mon, 7 Sep 2020, Paolo Abeni wrote:
>>>> We already have 'schedule_work' call to handle incoming data fin
>>>> in mptcp_incoming_options(), can we instead extend the checks there to
>>>> cover also this scenario?
>>>> =

>>> =

>>> I did look at modifying mptcp_incoming_options(), but this patch looked
>>> like the simpler fix.
>>> =

>>> The existing checks for empty packets in mptcp_incoming_options()
>>> accomplish two things:
>>> =

>>> 1. DATA_FIN is handled for ACK packets that don't get in to the subflow
>>> receive queue (TCP FIN packets do go in to the receive queue, even if
>>> there's no payload).
>>> =

>>> 2. skb_ext attachment is skipped for ACK packets.
>>> =

>>> =

>>> Changing the logic in mptcp_incoming_options() would have to look for
>>> seq+1 =3D=3D end_seq and TCP FIN, and then (maybe?) not attach the skb_=
ext -
>>> which significantly changes the code paths involved. It might also do an
>>> extra wake up of the worker before the MPTCP socket is caught up with t=
he
>>> incoming data.
>>> =

>>> In comparison, the above patch stores a return value that was previously
>>> (incorrectly) ignored, and schedules the worker when it is most likely =
to
>>> be able to do the work.
>>> =

>>> Given that, do you think it's better to extend the
>>> mptcp_incoming_options() checks?
>> =

>> Yup, I did not look into the details of the other option. It looks like
>> it's overcomplicated, so I'm ok with this approach.
>
> Thank you for the patch and the review!
>
> I just applied your patch with Paolo's ACK!
>
> Compilation tests are OK, "export" branch has been updated but the CI is =

> still validating functional tests in the VM (selftests, packetdrill, etc.=
).
>
> I will try to report the status later on IRC but if you don't hear from m=
e =

> today, I am sure this patch can be sent to netdev!
>

I found an interop case with the multipath-tcp.org kernel where v5.9 is =

not acknowledging the peer's DATA_FIN, so the peer keeps resending the =

DATA_FIN even though the v5.9 socket is already closed.

Working on a patch to squash with this one.

--
Mat Martineau
Intel
--===============1920913587215464143==--
