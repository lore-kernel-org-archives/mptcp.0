Content-Type: multipart/mixed; boundary="===============3143322916399313881=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: "mptcp: move sockopt
 function into a new file"
Date: Tue, 09 Mar 2021 23:28:08 +0100
Message-ID: <415cf0b2-8576-d09b-c649-c5df6f6c6073@tessares.net>
In-Reply-To: b984e1a9dda4a47ce1b2ed949434a290a50fcf18.1615286805.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8083

--===============3143322916399313881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 09/03/2021 11:47, Paolo Abeni wrote:
> Mat noted I left over an helper function in protocol.c.
> Just drop it.

Thank you for the patches and the reviews!

Just applied the "mptcp: use whitlist for sockopt" series and this patch =

with Mat's RvB tags and a few modifications linked to checkpatch's =

output (+ an extra sentence on patch 2/3 to explain we forbid more than =

just the ones linked to mcast):

- 7c0df94ad1dc: mptcp: move sockopt function into a new file
- ce35fc3cba0b: mptcp: only admit explicitly supported sockopt
- f1726b98fee5: mptcp: revert "mptcp: provide subflow aware release =

function"
- Results: 917144c5a66a..fd254f313de3

- c42dc5a97662: "squashed" in "mptcp: move sockopt function into a new file"
- Results: fd254f313de3..433f124e57a9

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3143322916399313881==--
