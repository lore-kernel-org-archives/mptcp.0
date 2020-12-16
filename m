Content-Type: multipart/mixed; boundary="===============1932406733057930764=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 10th of December 2020
Date: Wed, 16 Dec 2020 14:42:04 -0800
Message-ID: <880c766-ae5e-4b59-2a95-e8c36a5a80f9@linux.intel.com>
In-Reply-To: 20201216030442.GA13980@MiBook
X-Status: 
X-Keywords:                  
X-UID: 7199

--===============1932406733057930764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 16 Dec 2020, Geliang Tang wrote:

> Hi Mat,
>
> On Thu, Dec 10, 2020 at 08:36:40PM +0100, Matthieu Baerts wrote:
>>     - news about Intel's kbuild? (Mat):
>>         - less frequent failure on MP_JOIN selftests
>>         - ADD_ADDR timeout was detected too
>>         - Mat will check at the full logs
>
> Is the ADD_ADDR timeout issue's output like this:
>
> 12 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - ack[ o=
k ]
>                                        add[fail] got 2 ADD_ADDR[s] expect=
ed 4
> - echo  [ ok ]
> Server ns stats
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtMPJoinSynRx             1                  0.0
> MPTcpExtMPJoinAckRx             1                  0.0
> Client ns stats
> MPTcpExtMPJoinSynAckRx          1                  0.0
> MPTcpExtAddAddr                 2                  0.0
> 13 remove single subflow                syn[ ok ] - synack[ ok ] - ack[ o=
k ]
>                                        rm [ ok ] - sf    [ ok ]
>
> I got it sometimes. I'll fix it recently.
>

Geliang -

Yes, that's the intermittent error that kbuild is getting about once a =

week. Thanks for looking at the problem!

--
Mat Martineau
Intel
--===============1932406733057930764==--
