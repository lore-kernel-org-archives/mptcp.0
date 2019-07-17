Content-Type: multipart/mixed; boundary="===============2602338528924893835=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] about self-tests failures
Date: Wed, 17 Jul 2019 08:37:36 +0200
Message-ID: <3815C2D2-CAE9-4EBC-A316-60D35D65F05B@apple.com>
In-Reply-To: d9f7c146493449e0cb0e926302831e2a2c96d32f.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1502

--===============2602338528924893835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Jul 17, 2019, at 12:31 AM, Peter Krystad <peter.krystad(a)linux.intel.=
com> wrote:
> =

> =EF=BB=BFOn Tue, 2019-07-16 at 18:38 +0200, Christoph Paasch wrote:
>> Hello,
>> =

>>>> On Jul 16, 2019, at 3:21 PM, Paolo Abeni <pabeni(a)redhat.com> wrote:
>>> =EF=BB=BFHi all,
>>> I spent some time debugging the self-test failures, and I think I got
>>> the root cause.
>>> The tests fails when, due to netem, the 3 way handshake final ack
>>> packet is dropped.
>>> When that happen, the sender never emit the MP_CAPABLE option in later
>>> retrasmission (has the '!subflow->fourth_ack' condition in
>>> mptcp_established_options_mp() is always false).
>>> As a result, on the server side, subflow_syn_recv_sock() always returns
>>> NULL - the session keys check fails - the connection is never
>>> established, and the server's select() never returns
>> =

>> I can=E2=80=99t check the code right now, but is there a specific reason=
 why this doesn=E2=80=99t work on the server side? IMO, there is no need fo=
r a session key check upon reception of the third ACK.
>> =

>>> I'm trying to address the issue forcing MP_CAPABLE option in
>>> retransmitted 3 way handshake ack packets, but I'm facing several
>>> issues, as the TCP stack tries hard to avoid retransmitting 'pure ack',
>>> preferring the following data packet, instead.
>>> We can't attach the MP_CAPABLE opt to the next data segment, or such
>>> segment will lack the require DSS - unless we place both DSS and
>>> MP_CAPABLE in the same pkt.
>>> @Christoph: can you please describe how this issue (3way hs ack drop)
>>> is handled from the mptcp.org implementation?
>> =

>> I think we have to separate between RFC6824 and RFC6824bis:
>> =

>> RFC6824:
>> =

>> As you saw, the MP_CAPABLE is sent in the third ACK which is unreliable.=
 In the mptcp.org implementation the server-side request-sock remembers the=
 key it saw in the SYN segment. Thus, the information in the third ACK is r=
edundant and so the server side still works even if the third ACK is lost. =
It simply knows that the client actually did ask for MPTCP in the SYN and t=
hus the state can be created.
>> I think it is important that the server remembers the MPTCP key in the S=
YN as part of the request-sock. And the server should not rely on the third=
 ACK to contain the MP_CAPABLE.
> =

> So does this mean that the mptcp.org server-side will consider 3WHS compl=
ete
> and create a new socket when a (retransmitted) third ACK without MP_CAPAB=
LE is
> received?

that=E2=80=99s it!

> =

> If that is the case then, since we already store the remote key from the =
SYN
> in the subflow_request_sock, we should be able to just remove the check f=
or
> the presence of MP_CAPABLE and the equality of the keys sent in the SYN a=
nd
> the third ACK from subflow_syn_recv_sock().

Yes, I think you should do that.


Christoph =


> =

> Peter.
> =

> =

>> =

>> You can see here: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.9=
5/net/mptcp/mptcp_ctrl.c#L2097 where we only check for MPTCP in the request=
-sock.
>> =

>> There is one caveat to that: when SYN-cookies are used on the server, th=
ere is no request-sock upon SYN reception and thus the server needs the thi=
rd ACK to enable MPTCP. This means that if the third ACK is lost, we end up=
 with regular TCP.
>> =

>> To handle this scenario we changed the handshake in RFC6824bis.
>> =

>> In RFC6824bis, the client transmits the keying information reliably toge=
ther with the first flight of data. That way, even servers with SYN cookies=
 enabled can allow loss of the third ACK.
>> =

>> =

>> Christoph =

>> =

>> =

>>> Thanks,
>>> Paolo
>> =

>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>=20

--===============2602338528924893835==--
