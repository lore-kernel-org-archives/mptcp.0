Content-Type: multipart/mixed; boundary="===============1765629135148137761=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: remove pcap captures with 'make clean'
Date: Mon, 02 Dec 2019 11:19:49 +0100
Message-ID: <063d242c-f303-5c21-f910-75d234f6ca7e@tessares.net>
In-Reply-To: f1d3c918c854ade4978b423865d253899297f372.1575155865.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2727

--===============1765629135148137761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 01/12/2019 00:21, Davide Caratti wrote:
> use EXTRA_CLEAN variable to ensure that pcap captures are removed with
> 'make clean'

Good idea! Just applied:

- bf5bea6a4d55: "squashed" in "mptcp: add basic kselftest for mptcp"
- 04af7732a5cc..55423f0702b6: result

Tests/export in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1765629135148137761==--
