Content-Type: multipart/mixed; boundary="===============8562313334701762278=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 00/13] mptcp: support for queuing data at
 mptcp-level
Date: Mon, 05 Oct 2020 08:31:24 +0200
Message-ID: <1ae96fe38254afe04d222abc665ee258b77de77b.camel@redhat.com>
In-Reply-To: 876a5ca0-9627-7fab-5006-50f48d45c2d6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6192

--===============8562313334701762278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-03 at 18:35 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 03/10/2020 12:48, Matthieu Baerts wrote:
> > - Results: d157a0e07d13..d577ff3cf895
> > =

> > tests + export are in progress!
> =

> I got two errors with the selftests:
> =

> =

> # selftests: net/mptcp: diag.sh
> # no msk on netns creation                          [  ok  ]
> # after MPC handshake                               [  ok  ]
> # ....chk remote_key                                [  ok  ]
> # ....chk no fallback                               [  ok  ]
> # check fallback                                    [  ok  ]
> # many msk socket present                           [ fail ] expected =

> 200 found 201
> not ok 4 selftests: net/mptcp: diag.sh # exit=3D6

This is still to be investigated, I guess It has to do with the newly
introduced msk socket timeout

> # selftests: net/mptcp: simult_flows.sh
> # balanced bwidth                                     4693 max 5005 [ OK ]
> # balanced bwidth - reverse direction                 4493 max 5005 [ OK ]
> # balanced bwidth with unbalanced delay               5283 max 5005  [ =

> fail ]
> # client exit code 0, server 0
> # \nnetns ns3-0-W3sXrt socket stat for 10003:
> # State     Recv-Q Send-Q Local Address:Port  Peer Address:Port Process =

> =

> # TIME-WAIT 0      0           10.0.3.3:10003     10.0.2.1:34523 =

> timer:(timewait,59sec,0)
> # 	=

> # TIME-WAIT 0      0           10.0.3.3:10003     10.0.1.1:44230 =

> timer:(timewait,59sec,0)
> # 	=

> # \nnetns ns1-0-W3sXrt socket stat for 10003:
> # State Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
> # -rw------- 1 root root 8388608 Oct  3 13:23 /tmp/tmp.IeFESgOht2
> # -rw------- 1 root root 8388608 Oct  3 13:24 /tmp/tmp.w7zJOAA5WT
> # -rw------- 1 root root 81920 Oct  3 13:24 /tmp/tmp.bITD2uHm5f
> # -rw------- 1 root root 81920 Oct  3 13:23 /tmp/tmp.fhMf6gzhah
> # balanced bwidth with unbalanced delay - reverse direction  4560 max =

> 5005 [ OK ]
> not ok 5 selftests: net/mptcp: simult_flows.sh # exit=3D1

This is still under investigation, likely not easy to fix. We still
have some out-of-[mptcp-level]window packet, expecially at connection
start. I'm *guessing* they cause this b/w fluctuation.

Cheers,

Paolo

--===============8562313334701762278==--
