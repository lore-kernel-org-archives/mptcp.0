Content-Type: multipart/mixed; boundary="===============5076981519302475567=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Status
Date: Mon, 02 Oct 2017 14:14:23 -0700
Message-ID: <20171002211423.GF31629@Chimay.local>
X-Status: 
X-Keywords:                  
X-UID: 82

--===============5076981519302475567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

just wanted to ring in here.


I started working on porting TCP_MD5 to use the TCP extra-option framework
from Mat's branch.

It allows to nicely cleanup the TCP_MD5-code out of the TCP data-path.
There are some changes/extensions I needed to do to Mat's framework. But
nothing. I will post patches in the coming days here on the list.


I keep on moving mptcp_trunk upwards to track upstream Linux. Currently I'm
stuck at v4.9 (there is a nasty bug that popped up with the merge and I
wasn't able to fix that yet).


The merge with v4.9 also forced me to bump skb->cb to 80 bytes... :/
I have been thinking back and forth on how we could handle this. The best
way I see at the moment is to create a scratch-area at the end of the skb's
data (like skb_shared_info). I think it also would quite nicely fit with a
KCM/ULP-style architecture where we could have a BPF-program that does the
scheduling.
I haven't dived very deep into the skb->cb problem yet.


Anyways, at the moment I am focusing on fixing mptcp_trunk's merge with v4.9
and the TCP_MD5 cleanup (which I think would be of interest for netdev).


Christoph


--===============5076981519302475567==--
