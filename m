Content-Type: multipart/mixed; boundary="===============0044182550923467480=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] Squash-to: "mptcp: Implement MPTCP receive
 path"
Date: Wed, 18 Dec 2019 16:22:28 +0100
Message-ID: <ae0ce521-b657-741b-a106-87a3c3fa3639@tessares.net>
In-Reply-To: 4064496cd54175b7a40684389e6437604cd7142c.1576671711.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3138

--===============0044182550923467480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 18/12/2019 13:33, Paolo Abeni wrote:
> drop C++ style comment, we have explicit checks in place
> for supported flags

Thank you for these two patches!

It looks good to me, good catch! Please check the conflict resolution =

and result to make sure I did this correctly.

- 1c8b2fdb49ea: "squashed" patch 1/2 in "mptcp: Add MPTCP socket stubs"
- 490e2f994f44: "squashed" patch 2/2 in "mptcp: Implement MPTCP receive =

path"
- b48b06bb1b2b: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- ba600451fc45..27be141bb6d9: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0044182550923467480==--
