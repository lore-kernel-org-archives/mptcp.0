Content-Type: multipart/mixed; boundary="===============1200927067486274456=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: "tcp: Define IPPROTO_MPTCP"
Date: Fri, 13 Dec 2019 18:21:38 +0100
Message-ID: <97bc10d1-c66b-6b57-766f-e3beba40e2d2@tessares.net>
In-Reply-To: fd9848c19b14b56061bdf660e55b9f3ddb443736.1576252967.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2969

--===============1200927067486274456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo,

On 13/12/2019 17:06, Davide Caratti wrote:
> checkpatch fixes

Thank you for all the patches and the reviews!

- d1d5675e23f0: "squashed" patch 1/8 in "tcp: Define IPPROTO_MPTCP"
- 99c94db6e8c0..db6012c0c18c: result

- 97ea094740dd: "squashed" patch 2/8 in "mptcp: Write MPTCP DSS headers =

to outgoing data packets"
- db6012c0c18c..c26e1b52fb44: result

- 32793cb1ed54: "squashed" patch 3/8 in "mptcp: recvmsg() can drain data =

from multiple subflows"
- c26e1b52fb44..6a32a0cf0e5e: result

- 197fac0677b3: "squashed" patch 4/8 in "mptcp: Handle MPTCP TCP options"
- 9faccdc66fd1: conflict in t/mptcp-Add-ADD_ADDR-handling
- 6a32a0cf0e5e..52505c2de61f: result

- 73ff77bca8e9: "squashed" patch 5/8 in "mptcp: add subflow write space =

signalling and mptcp_poll"
- 52505c2de61f..029510754aff: result

- 4fd352adc42e: "squashed" patch 6/8 in "mptcp: Add key generation and =

token tree"
- 5514f4b67855: conflict in t/mptcp-move-from-sha1-v0-to-sha256-v1
- Note: no checkpatch.pl issues in this one but a funny false alarm:
WARNING: 'ba' may be misspelled - perhaps 'by'?
#193: FILE: net/mptcp/crypto.c:119:
+               .result =3D "e73b9ba9969969cefb04aa0d6df18ec2fcc075b6",
- 029510754aff..6fc1a65b4990: result

- a3c84f7f0b33: "squashed" patch 7/8 in "mptcp: Implement MPTCP receive =

path"
- 6fc1a65b4990..37578acde78f: result

- d6f69fd25d7c: "squashed" in "mptcp: add basic kselftest for mptcp"
- 37578acde78f..bc663afcd33e: result

Tests + export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1200927067486274456==--
