Content-Type: multipart/mixed; boundary="===============0988731084333333382=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 18:35:08 +0200
Message-ID: <c9ee8b30-df8a-ba97-b554-23a9068651a6@tessares.net>
In-Reply-To: b90ae5e6-9858-eccd-ef45-eb59250ae8a1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6230

--===============0988731084333333382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 06/10/2020 16:03, Matthieu Baerts wrote:
> Hi Davide, Paolo,
> =

> On 06/10/2020 15:07, Paolo Abeni wrote:
>> On Tue, 2020-10-06 at 14:22 +0200, Davide Caratti wrote:
>>> using packetdrill it's possible to observe the same MPTCP DSN being =

>>> acked
>>> by different subflows with DACK4 and DACK8. This is in contrast with =

>>> what
>>> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-b=
it =

>>> wide
>>> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix =

>>> 'use_64bit_ack'
>>> variable to make it a property of MPTCP sockets, not TCP subflows.
>>>
>>> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
>>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
>>
>> LGTM, thanks Davide!
> =

> Thank you for the patch and the review!
> =

> @Davide: be careful that this patch doesn't apply as is on -net (or =

> net-next). I had a small conflict when applying it on top of net-next, =

> not at the end of the "export" branch?
> =

> - 79519fc3f520: net: mptcp: make DACK4/DACK8 usage consistent among all =

> subflows
> - be078f4e24b5: conflict in t/mptcp-refactor-shutdown-and-close
> - Results: b74dfa0c4018..9984fc6a69ca
> =

> Tests + export are in progress!

It looks unrelated but one selftest -- mptcp_join.sh, test 11 -- was =

failing with a debug kernel:


# selftests: net/mptcp: mptcp_join.sh
# Created /tmp/tmp.TXFPMQuIYt (size 1 KB) containing data sent by client
# Created /tmp/tmp.rZmBg6Ql4I (size 1 KB) containing data sent by server
# 01 no JOIN                              syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 02 single subflow, limited by client    syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 03 single subflow, limited by server    syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 04 single subflow                       syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 05 multiple subflows                    syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 06 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 07 unused signal address                syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 08 signal address                       syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 09 subflow and signal                   syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 10 multiple subflows and signal         syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 11 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[fail] got 2 ADD_ADDR[s] =

expected 4
#  - echo  [ ok ]
# Server ns stats
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtMPTCPRetrans            1                  0.0
# MPTcpExtMPJoinSynRx             1                  0.0
# MPTcpExtMPJoinAckRx             1                  0.0
# MPTcpExtDuplicateData           1                  0.0
# Client ns stats
# MPTcpExtMPTCPRetrans            1                  0.0
# MPTcpExtMPJoinSynAckRx          1                  0.0
# MPTcpExtDuplicateData           1                  0.0
# MPTcpExtAddAddr                 2                  0.0
# 12 remove single subflow                syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 13 remove multiple subflows             syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 14 remove single address                syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 15 remove subflow and signal            syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 16 remove subflows and signal           syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 17 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 18 multiple subflows with syn cookies   syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 19 subflows limited by server w cookies syn[ ok ] - synack[ ok ] - =

ack[ ok ]
# 20 signal address with syn cookies      syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 21 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 22 subflows and signal w. cookies       syn[ ok ] - synack[ ok ] - =

ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
not ok 3 selftests: net/mptcp: mptcp_join.sh # exit=3D1


I don't think it is due to your modification. I didn't have the issue =

without the debug kconfig.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0988731084333333382==--
